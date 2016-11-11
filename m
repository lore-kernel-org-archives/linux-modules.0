Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756201AbcKKLmp (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 11 Nov 2016 06:42:45 -0500
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: linux-modules@vger.kernel.org
Cc: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
        bjorn.andersson@linaro.org, Jessica Yu <jeyu@redhat.com>
Subject: [PATCH RFC 3/3] depmod: handle nested loops
Date: Fri, 11 Nov 2016 13:43:21 +0200
Message-Id: <1478864601-3259-4-git-send-email-yauheni.kaliuta@redhat.com>
In-Reply-To: <1478864601-3259-1-git-send-email-yauheni.kaliuta@redhat.com>
References: <1478683053.4155.8.camel@suse.com>
 <1478864601-3259-1-git-send-email-yauheni.kaliuta@redhat.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

This is a rework of depmod report cycles logic to make it
tolerant to more complex loops.

The patch tries to remember own path for vertexes which makes it
possible to handle configurations with common edges and
non-cyclic modules.

It assumes that the previous dependency calculations can not give
as input something like

mod_a -> mod_b -> <loop>, but

<loop> -> mod_a -> mod_b should be fine.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/depmod.c | 287 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 204 insertions(+), 83 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index f2b370f146bb..c110635ff517 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -785,6 +785,7 @@ static void cfg_free(struct cfg *cfg)
 
 
 /* depmod calculations ***********************************************/
+struct vertex;
 struct mod {
 	struct kmod_module *kmod;
 	char *path;
@@ -800,6 +801,7 @@ struct mod {
 	uint16_t idx; /* index in depmod->modules.array */
 	uint16_t users; /* how many modules depend on this one */
 	bool visited; /* helper field to report cycles */
+	struct vertex *vertex; /* helper field to report cycles */
 	char modname[];
 };
 
@@ -1450,105 +1452,225 @@ static void depmod_sort_dependencies(struct depmod *depmod)
 	}
 }
 
-static void depmod_report_cycles(struct depmod *depmod, uint16_t n_mods,
-				 uint16_t n_roots, uint16_t *users,
-				 uint16_t *stack, uint16_t *edges)
+struct vertex {
+	struct vertex *parent;
+	struct mod *mod;
+};
+
+static struct vertex *vertex_new(struct mod *mod, struct vertex *parent)
+{
+	struct vertex *v;
+
+	v = malloc(sizeof(*v));
+	if (v == NULL)
+		return NULL;
+
+	v->parent = parent;
+	v->mod = mod;
+	return v;
+}
+
+static void depmod_list_remove_data(struct kmod_list **list, void *data)
+{
+	struct kmod_list *l;
+
+	l = kmod_list_remove_data(*list, data);
+	*list = l;
+}
+
+static void depmod_report_one_cycle(struct depmod *depmod,
+				    struct vertex *vertex,
+				    struct kmod_list **roots,
+				    struct hash *loop_set)
 {
 	const char sep[] = " -> ";
-	int ir = 0;
-	int num_cyclic = 0;
+	size_t sz;
+	char *buf;
+	struct array reverse;
+	int i;
+	int n;
+	struct vertex *v;
 
-	while (n_roots > 0) {
-		int is, ie;
+	array_init(&reverse, 2);
 
-		for (; ir < n_mods; ir++) {
-			if (users[ir] > 0) {
-				break;
-			}
+	sz = 0;
+	for (v = vertex->parent, n = 0;
+	     v != NULL;
+	     v = v->parent, n++) {
+
+		sz += v->mod->modnamesz - 1;
+		array_append(&reverse, v);
+		hash_add(loop_set, v->mod->modname, NULL);
+	}
+	sz += vertex->mod->modnamesz - 1;
+
+	buf = malloc(sz + n * strlen(sep) + 1);
+
+	sz = 0;
+	for (i = reverse.count - 1; i >= 0; i--) {
+		v = reverse.array[i];
+
+		strcpy(buf + sz, v->mod->modname);
+		sz += v->mod->modnamesz - 1;
+		strcpy(buf + sz, sep);
+		sz += strlen(sep);
+
+		depmod_list_remove_data(roots, v->mod);
+	}
+	strcpy(buf + sz, vertex->mod->modname);
+	ERR("Cycle detected: %s\n", buf);
+
+	free(buf);
+	array_free_array(&reverse);
+}
+
+static int depmod_report_cycles_from_root(struct depmod *depmod,
+					  struct mod *root_mod,
+					  struct kmod_list **roots,
+					  void **stack,
+					  size_t stack_size,
+					  struct hash *loop_set)
+{
+	struct kmod_list *free_list = NULL; /* struct vertex */
+	struct kmod_list *l;
+	struct vertex *root;
+	struct vertex *vertex;
+	struct vertex *v;
+	struct mod *m;
+	struct mod **itr, **itr_end;
+	size_t is;
+
+	root = vertex_new(root_mod, NULL);
+	if (root == NULL) {
+		ERR("No memory to report cycles\n");
+		return -ENOMEM;
+	}
+
+	l = kmod_list_append(free_list, root);
+	if (l == NULL) {
+		ERR("No memory to report cycles\n");
+		return -ENOMEM;
+	}
+	free_list = l;
+
+	is = 0;
+	stack[is++] = (void *)root;
+
+	while (is > 0) {
+		vertex = stack[--is];
+		m = vertex->mod;
+		/*
+		 * because of the topological sort we can start only
+		 * from part of a loop or from a branch after a loop
+		 */
+		if (m->visited && m == root->mod) {
+			depmod_report_one_cycle(depmod, vertex,
+						roots, loop_set);
+			continue;
 		}
 
-		if (ir >= n_mods)
-			break;
+		m->visited = true;
+		if (m->deps.count == 0) {
+			/*
+			 * boundary condition: if there is more than one
+			 * single node branch (not a loop), it is
+			 * recognized as a loop by the code above:
+			 * m->visited because more then one,
+			 * m == root->mod because it is a single node.
+			 * So, prevent deeping into the branch second
+			 * time.
+			 */
+			depmod_list_remove_data(roots, m);
 
-		/* New DFS with ir as root, no edges */
-		stack[0] = ir;
-		ie = 0;
-
-		/* at least one root less */
-		n_roots--;
-
-		/* skip this root on next iteration */
-		ir++;
-
-		for (is = 1; is > 0;) {
-			uint16_t idx = stack[--is];
-			struct mod *m = depmod->modules.array[idx];
-			const struct mod **itr, **itr_end;
-
-			DBG("Cycle report: Trying %s visited=%d users=%d\n",
-			    m->modname, m->visited, users[idx]);
-
-			if (m->visited) {
-				int i, n = 0, sz = 0;
-				char *buf;
-				bool is_cyclic = false;
-
-				for (i = ie - 1; i >= 0; i--) {
-					struct mod *loop = depmod->modules.array[edges[i]];
-					sz += loop->modnamesz - 1;
-					n++;
-					if (loop == m) {
-						sz += loop->modnamesz - 1;
-						is_cyclic = true;
-						break;
-					}
-				}
-				/* Current module not found in dependency list.
-				 * Must be a related module. Ignore it.
-				 */
-				if (!is_cyclic)
-					continue;
-
-				num_cyclic += n;
-
-				buf = malloc(sz + n * strlen(sep) + 1);
-				sz = 0;
-				for (i = ie - n; i < ie; i++) {
-					struct mod *loop =
-						depmod->modules.array[edges[i]];
-					memcpy(buf + sz, loop->modname,
-					       loop->modnamesz - 1);
-					sz += loop->modnamesz - 1;
-					memcpy(buf + sz, sep, strlen(sep));
-					sz += strlen(sep);
-				}
-				memcpy(buf + sz, m->modname, m->modnamesz);
+			continue;
+		}
 
-				ERR("Cycle detected: %s\n", buf);
+		itr = (struct mod **) m->deps.array;
+		itr_end = itr + m->deps.count;
+		for (; itr < itr_end; itr++) {
+			struct mod *dep = *itr;
+			v = vertex_new(dep, vertex);
+			if (v == NULL) {
+				ERR("No memory to report cycles\n");
+				return -ENOMEM;
+			}
+			assert(is < stack_size);
+			stack[is++] = v;
 
-				free(buf);
-				continue;
+			l = kmod_list_append(free_list, v);
+			if (l == NULL) {
+				ERR("No memory to report cycles\n");
+				return -ENOMEM;
 			}
+			free_list = l;
 
-			m->visited = true;
+		}
+	}
+	while (free_list) {
+		v = kmod_list_data(free_list);
+		l = kmod_list_remove(free_list);
+		free_list = l;
+		free(v);
+	}
 
-			if (m->deps.count == 0) {
-				continue;
-			}
+	return 0;
+}
 
-			edges[ie++] = idx;
+static void depmod_report_cycles(struct depmod *depmod, uint16_t n_mods,
+				 uint16_t *users)
+{
+	int num_cyclic = 0;
+	struct kmod_list *roots = NULL; /* struct mod */
+	struct kmod_list *l;
+	size_t n_r; /* local n_roots */
+	int i;
+	int err;
+	void **stack;
+	struct mod *m;
+	struct mod *root;
+	struct hash *loop_set;
 
-			itr = (const struct mod **) m->deps.array;
-			itr_end = itr + m->deps.count;
-			for (; itr < itr_end; itr++) {
-				const struct mod *dep = *itr;
-				stack[is++] = dep->idx;
-				users[dep->idx]--;
-			}
+	for (i = 0, n_r = 0; i < n_mods; i++) {
+		if (users[i] <= 0)
+			continue;
+		m = depmod->modules.array[i];
+		l = kmod_list_append(roots, m);
+		if (l == NULL) {
+			ERR("No memory to report cycles\n");
+			return;
 		}
+		roots = l;
+		n_r++;
+	}
+
+	stack = malloc(n_r * sizeof(void *));
+	if (stack == NULL) {
+		ERR("No memory to report cycles\n");
+		return;
+	}
+
+	loop_set = hash_new(16, NULL);
+	if (loop_set == NULL) {
+		ERR("No memory to report cycles\n");
+		return;
+	}
+
+	while (roots != NULL) {
+		root = kmod_list_data(roots);
+		l = kmod_list_remove(roots);
+		roots = l;
+		err = depmod_report_cycles_from_root(depmod,
+						     root,
+						     &roots,
+						     stack, n_r, loop_set);
+		if (err < 0)
+			goto err;
 	}
 
+	num_cyclic = hash_get_count(loop_set);
 	ERR("Found %d modules in dependency cycles!\n", num_cyclic);
+err:
+	hash_free(loop_set);
 }
 
 static int depmod_calculate_dependencies(struct depmod *depmod)
@@ -1605,8 +1727,7 @@ static int depmod_calculate_dependencies(struct depmod *depmod)
 	}
 
 	if (n_sorted < n_mods) {
-		depmod_report_cycles(depmod, n_mods, n_mods - n_sorted,
-				     users, roots, sorted);
+		depmod_report_cycles(depmod, n_mods, users);
 		ret = -EINVAL;
 		goto exit;
 	}
-- 
2.7.4

