Return-Path: <lucas.de.marchi@gmail.com>
Date: Fri, 2 May 2014 14:13:59 +0000
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Gustavo Sverzut Barbieri <barbieri@gmail.com>,
	linux-modules <linux-modules@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Fix recursion loop in mod_count_all_dependencies()
Message-ID: <20140502141357.GA24741@politreco>
References: <53484327.5Nr2aWdyWz5+36kD%matwey.kornilov@gmail.com>
 <CAKi4VALtbKS=wj1KncN+kt+5hRPLDYxzkuDDg-3Cm+wr2mK5JQ@mail.gmail.com>
 <CANkykrBdJ-u-OWWgBZj_Jsghd8oqhC6AtRK7dvs=EGFt7EozMQ@mail.gmail.com>
 <CAJs94EZbVaS=N0xpAQbAySBzX_e6JR1o8FJkrJ0f4buCWvsZSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAJs94EZbVaS=N0xpAQbAySBzX_e6JR1o8FJkrJ0f4buCWvsZSA@mail.gmail.com>
List-ID: <linux-modules.vger.kernel.org>

[ CC'ing Rusty ]

Rusty, when facing module loops, shouldn't we let depmod fail? kmod and
module-init-tools since always just warned about them, but it's really a
bug in the module if they exist. See below.

On Sun, Apr 27, 2014 at 11:44:54PM +0400, Matwey V. Kornilov wrote:
> Can't answer the question. Looking the code, mod_count_all_dependencies has
> to be fixed in that way. The code, running before and after, is
> loop-tolerant.
> 
> However, I am not sure whether loops make sense. Can we load whole the loop
> at once?

nops, this is not possible.


The difference from the code before is that with your approach it would
output the partial dependencies of a module that depends on a loop. So
if we have a module A with these dependencies:

A -> B -> C -> B

modules.dep would contain:

A: B C

Which is wrong and shouldn't be there.

We could fix your patch so we don't output anything until the
dependencies are counted, however we would need to do the same thing
while outputting modules.dep.bin. IMO fixing it in these functions is
already too late... they should only be executed if we are in fact
writing out the index.

So if there are loops, I think we should either (1) fail depmod entirely
or (2) add proper support to depmod_calculate_dependencies() to mark the
loop's dependents.

(1) would be very straightforward
(2) would be like below.

---------8<--------------------
From: Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH] depmod: Fix not marking dependencies of a loop

Currently we are marking as modules with dep_loop only the modules that
are part of a loop. However we also need to skip the modules that depend
on any module that is part of a loop.

So, before this patch this loop we got right:

	A -> B -> C -
	^           |
	'------------

A, B and C will be ignored due to dependency loops. But this loop we got
wrong:

	A -> B -> C -
	     ^      |
	     '-------

B and C will be ignored due to dependency loops, since they are part of
it, but we will try to output the A's dependencies, leading to an
infinite recursion loop in mod_count_all_dependencies() as pointed out
by Matwey V. Kornilov <matwey.kornilov@gmail.com> in the mailing list.
This is based on his patch, but instead of fixing it by detecting the
loop dependency while outputing A's dependency, this adds the proper
support to depmod_calculate_dependencies() to do the right thing.
---
 tools/depmod.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 85 insertions(+), 20 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 1aedaaf..5eea498 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -927,6 +927,7 @@ struct mod {
 	int dep_sort_idx; /* topological sort index */
 	uint16_t idx; /* index in depmod->modules.array */
 	uint16_t users; /* how many modules depend on this one */
+	bool visited; /* helper field to search for loops */
 	uint8_t dep_loop : 1;
 	char modname[];
 };
@@ -1587,6 +1588,86 @@ static void depmod_sort_dependencies(struct depmod *depmod)
 	}
 }
 
+static inline const char *mod_get_compressed_path(const struct mod *mod)
+{
+	if (mod->relpath != NULL)
+		return mod->relpath;
+	return mod->path;
+}
+
+/*
+ * Traverse the tree marking with dep_loop = 1 any module which depends
+ * directly or indirectly in a module with dep_loop = 1. The loops must have
+ * alread been marked.
+ *
+ * We use a depth-first search using @stack to backtrack and @edges to
+ * mark the current visiting modules
+ */
+static void depmod_mark_loop_dependencies(struct depmod *depmod,
+					  uint16_t *stack, uint16_t *edges)
+{
+	const struct mod **itrm;
+	unsigned int i, n_mods = depmod->modules.count;
+	int j, k;
+
+	itrm = (const struct mod **)depmod->modules.array;
+	for (i = 0; i < n_mods; i++, itrm++) {
+		const struct mod *root = *itrm;
+		if (root->visited || root->dep_loop == 1)
+			continue;
+
+		DBG("root = %s\n", mod_get_compressed_path(root));
+
+		/* new DFS with i as root */
+		stack[0] = i;
+		j = 0;
+		k = -1;
+		while (j >= 0) {
+			uint16_t idx = stack[j--];
+			struct mod *m = depmod->modules.array[idx];
+			struct mod **itr_child, **itr_child_end;
+			bool leaf = true;
+
+			DBG("node = %s loop=%d visited=%d\n",
+			    mod_get_compressed_path(m), m->dep_loop,
+			    m->visited);
+
+			if (m->dep_loop == 1) {
+				m->visited = true;
+				while (k >= 0) {
+					struct mod *parent =
+						depmod->modules.array[edges[k--]];
+					parent->dep_loop = 1;
+					parent->dep_sort_idx = INT32_MAX;
+				}
+				break;
+			}
+
+			if (m->visited)
+				continue;
+
+			m->visited = true;
+			edges[++k] = idx;
+
+			itr_child = (struct mod **) m->deps.array;
+			itr_child_end = itr_child + m->deps.count;
+			for (; itr_child < itr_child_end; itr_child++) {
+				struct mod *child = *itr_child;
+
+				if (child->dep_loop == 0 && child->visited)
+					continue;
+
+				stack[++j] = child->idx;
+				leaf = false;
+			}
+
+			if (leaf)
+				k--;
+		}
+	}
+
+}
+
 static int depmod_calculate_dependencies(struct depmod *depmod)
 {
 	const struct mod **itrm;
@@ -1652,6 +1733,9 @@ static int depmod_calculate_dependencies(struct depmod *depmod)
 			m->dep_sort_idx = INT32_MAX;
 			depmod->dep_loops++;
 		}
+
+		/* Re-purpose our buffers for tree traversal */
+		depmod_mark_loop_dependencies(depmod, users, roots);
 	}
 
 	depmod_sort_dependencies(depmod);
@@ -1745,13 +1829,6 @@ static const struct mod **mod_get_all_sorted_dependencies(const struct mod *mod,
 	return deps;
 }
 
-static inline const char *mod_get_compressed_path(const struct mod *mod)
-{
-	if (mod->relpath != NULL)
-		return mod->relpath;
-	return mod->path;
-}
-
 static int output_deps(struct depmod *depmod, FILE *out)
 {
 	size_t i;
@@ -1762,7 +1839,7 @@ static int output_deps(struct depmod *depmod, FILE *out)
 		size_t j, n_deps;
 
 		if (mod->dep_loop) {
-			DBG("Ignored %s due dependency loops\n", p);
+			WRN("Ignored %s due dependency loops\n", p);
 			continue;
 		}
 
@@ -1779,12 +1856,6 @@ static int output_deps(struct depmod *depmod, FILE *out)
 
 		for (j = 0; j < n_deps; j++) {
 			const struct mod *d = deps[j];
-			if (d->dep_loop) {
-				DBG("Ignored %s (dependency of %s) "
-				    "due dependency loops\n",
-				    mod_get_compressed_path(d), p);
-				continue;
-			}
 			fprintf(out, " %s", mod_get_compressed_path(d));
 		}
 		free(deps);
@@ -1828,12 +1899,6 @@ static int output_deps_bin(struct depmod *depmod, FILE *out)
 		linelen = strlen(p) + 1;
 		for (j = 0; j < n_deps; j++) {
 			const struct mod *d = deps[j];
-			if (d->dep_loop) {
-				DBG("Ignored %s (dependency of %s) "
-				    "due dependency loops\n",
-				    mod_get_compressed_path(d), p);
-				continue;
-			}
 			linelen += 1 + strlen(mod_get_compressed_path(d));
 		}
 
-- 
1.9.2
------------------->8---------------------------

I'm letting the rest of the thread below since it never reached the mailing
list.


Lucas De Marchi


> 27.04.2014 19:30 пользователь "Gustavo Sverzut Barbieri" <barbieri@gmail.com>
> написал:
> 
> > patch itself is okay, (one minor syntax issue with lack of space
> > between "if" and "(").
> >
> > But I wonder why just fail if we find loops, are those valid? If not,
> > couldn't we fail earlier and ask people to fix it?
> >
> > On Fri, Apr 25, 2014 at 12:46 AM, Lucas De Marchi
> > <lucas.de.marchi@gmail.com> wrote:
> > > Hi
> > >
> > > On Fri, Apr 11, 2014 at 4:31 PM,  <matwey.kornilov@gmail.com> wrote:
> > >> From 48d4d7ba1acbb5c0955f75c6bdda9cf0935240fd Mon Sep 17 00:00:00 2001
> > >> From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
> > >> Date: Fri, 11 Apr 2014 19:43:18 +0400
> > >> Subject: [PATCH] Fix recursion loop in mod_count_all_dependencies() when
> > >>  subgraph has a cycle.
> > >>
> > >> When cycle is detected in mod_count_all_dependencies, use total count of
> > >> modules as an upper bound of needed memory. Correct number of nodes is
> > determined by
> > >> subsequent call of mod_fill_all_unique_dependencies().
> > >
> > > We should deal with this already in depmod_calculate_dependencies(),
> > > otherwise I'd say it would be a bug there. How did you reproduce it?
> > >
> > >
> > > Gustavo, could you take a look on the patch below?
> > >
> > > --
> > > Lucas De Marchi
> > >
> > >> ---
> > >>  tools/depmod.c | 20 ++++++++++++++------
> > >>  1 file changed, 14 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/tools/depmod.c b/tools/depmod.c
> > >> index 1aedaaf..c83dee1 100644
> > >> --- a/tools/depmod.c
> > >> +++ b/tools/depmod.c
> > >> @@ -1682,12 +1682,20 @@ static int depmod_load(struct depmod *depmod)
> > >>         return 0;
> > >>  }
> > >>
> > >> -static size_t mod_count_all_dependencies(const struct mod *mod)
> > >> +static size_t mod_count_all_dependencies(const struct mod *mod, size_t
> > upper_bound)
> > >>  {
> > >>         size_t i, count = 0;
> > >> +       /* cycle is detected */
> > >> +       if (mod->dep_loop)
> > >> +               return upper_bound;
> > >> +
> > >>         for (i = 0; i < mod->deps.count; i++) {
> > >>                 const struct mod *d = mod->deps.array[i];
> > >> -               count += 1 + mod_count_all_dependencies(d);
> > >> +               const size_t child = mod_count_all_dependencies(d,
> > upper_bound);
> > >> +               if(child == upper_bound)
> > >> +                       return child;
> > >> +
> > >> +               count += 1 + child;
> > >>         }
> > >>         return count;
> > >>  }
> > >> @@ -1722,12 +1730,12 @@ static int
> > mod_fill_all_unique_dependencies(const struct mod *mod, const struct
> > >>         return err;
> > >>  }
> > >>
> > >> -static const struct mod **mod_get_all_sorted_dependencies(const struct
> > mod *mod, size_t *n_deps)
> > >> +static const struct mod **mod_get_all_sorted_dependencies(const struct
> > mod *mod, size_t *n_deps, size_t count)
> > >>  {
> > >>         const struct mod **deps;
> > >>         size_t last = 0;
> > >>
> > >> -       *n_deps = mod_count_all_dependencies(mod);
> > >> +       *n_deps = mod_count_all_dependencies(mod, count);
> > >>         if (*n_deps == 0)
> > >>                 return NULL;
> > >>
> > >> @@ -1771,7 +1779,7 @@ static int output_deps(struct depmod *depmod,
> > FILE *out)
> > >>                 if (mod->deps.count == 0)
> > >>                         goto end;
> > >>
> > >> -               deps = mod_get_all_sorted_dependencies(mod, &n_deps);
> > >> +               deps = mod_get_all_sorted_dependencies(mod, &n_deps,
> > depmod->modules.count);
> > >>                 if (deps == NULL) {
> > >>                         ERR("could not get all sorted dependencies of
> > %s\n", p);
> > >>                         goto end;
> > >> @@ -1819,7 +1827,7 @@ static int output_deps_bin(struct depmod *depmod,
> > FILE *out)
> > >>                         continue;
> > >>                 }
> > >>
> > >> -               deps = mod_get_all_sorted_dependencies(mod, &n_deps);
> > >> +               deps = mod_get_all_sorted_dependencies(mod, &n_deps,
> > depmod->modules.count);
> > >>                 if (deps == NULL && n_deps > 0) {
> > >>                         ERR("could not get all sorted dependencies of
> > %s\n", p);
> > >>                         continue;
> > >> --
> > >> 1.8.1.4
> > >>
> > >> --
> > >> To unsubscribe from this list: send the line "unsubscribe
> > linux-modules" in
> > >> the body of a message to majordomo@vger.kernel.org
> > >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> >
> > --
> > Gustavo Sverzut Barbieri
> > --------------------------------------
> > Mobile: +55 (19) 99225-2202
> > Contact: http://www.gustavobarbieri.com.br/contact
> >
