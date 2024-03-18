Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B72153391
	for <linux-modules@vger.kernel.org>; Mon, 18 Mar 2024 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778532; cv=none; b=mhTo1vDr0bOHvWT6WeNiTpSLYK3RXFrjqpcchz/wVje0x9VMeiwr20G4J55ax1DFRUpe9uEHxaWUZlrTklN50bWBqzgMv0IFXWtZSee3BbF3WcsOTC/9kCCU4q3Izlw42d5g9AHQU0WEkia3zWdnMDqMjEy295DQlB5dG5dXllU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778532; c=relaxed/simple;
	bh=9VADwp4+hzA7HCZcn5bxSUTFgIGpIAmjdDIESDdq7B8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DrkG2LkCjhd3jSDGF7IcA+f02ws5Z9Sob/s/QFr8boDLN3rCuUI5vwDDwdv8g9jdbq6MCZ8TSPC8UwS107K6Ut5ugqzbTVYXxGM31qxnJ4fphLFbUroz1KvcJDWApZewC2wFJPanhGuVY+qu8ICFKUEJJMfnaKqqLAqY6Ukl3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSGMKbCK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSGMKbCK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710778528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vYkts5cBs9M/m6jp0h/RfFAVaZnW+2LqcBFPyCKyEiY=;
	b=JSGMKbCKVK0mfmW79dEcIY0mEzZJLuTrKVLdTlRMR4rD8aOKpWNMCdveHmVyU2hk4ZrE/y
	8OJ5SdTKZ/DJ84yVQ673rEd++rzfurUaid9WT8s8N+b7ngOqyfyR/NNLxxtUgsE7omqRGm
	ap063k4FtusJmAhfZKsWlselu0C8zb8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-dH2qt6wlPXqO24ZwEKJv-w-1; Mon, 18 Mar 2024 12:15:27 -0400
X-MC-Unique: dH2qt6wlPXqO24ZwEKJv-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 532038007A1
	for <linux-modules@vger.kernel.org>; Mon, 18 Mar 2024 16:15:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.73])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3FECD1C060A4;
	Mon, 18 Mar 2024 16:15:26 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: linux-modules@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH kmod] libkmod: add user soft dependecies
Date: Mon, 18 Mar 2024 17:15:14 +0100
Message-ID: <20240318161517.58550-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

It has been seen that for some network mac drivers (i.e. lan78xx) the
related module for the phy is loaded dynamically depending on the current
hardware. In this case, the associated phy is read using mdio bus and then
the associated phy module is loaded during runtime (kernel function
phy_request_driver_module). However, no software dependency is defined, so
the user tools will no be able to get this dependency. For example, if
dracut is used and the hardware is present, lan78xx will be included but no
phy module will be added, and in the next restart the device will not work
from boot because no related phy will be found during initramfs stage.

In order to solve this, we could define a normal 'pre' software dependency
in lan78xx module with all the possible phy modules (there may be some),
but proceeding in that way, all the possible phy modules would be loaded
while only one is necessary.

The idea is to add a new attribute when the software dependency is defined,
apart from the normal ones 'pre' and 'post', I have called it 'user', to be
used only by the user tools that need to detect this situation. In that
way, for example, dracut could check the 'user' attribute of the modules in
order to install these software dependencies in initramfs too. That is, for
the  commented lan78xx module, defining the 'user' attribute to the
software dependency with the possible phy modules list, only the necessary
phy would be loaded on demand keeping the same behavior but all the
possible phy modules would be available from initramfs.

A new function 'kmod_module_get_user_softdeps' in libkmod will be added for
this to avoid breaking the API and maintain backward compatibility. This
general procedure could be useful for other similar cases (not only for
dynamic phy loading).

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 libkmod/docs/libkmod-sections.txt |  1 +
 libkmod/libkmod-config.c          | 66 +++++++++++++++++++++++++++----
 libkmod/libkmod-internal.h        |  1 +
 libkmod/libkmod-module.c          | 50 +++++++++++++++++++++++
 libkmod/libkmod.h                 |  2 +
 libkmod/libkmod.sym               |  1 +
 6 files changed, 114 insertions(+), 7 deletions(-)

diff --git a/libkmod/docs/libkmod-sections.txt b/libkmod/docs/libkmod-sections.txt
index 33d9eec..04743e4 100644
--- a/libkmod/docs/libkmod-sections.txt
+++ b/libkmod/docs/libkmod-sections.txt
@@ -62,6 +62,7 @@ kmod_module_remove_module
 kmod_module_get_module
 kmod_module_get_dependencies
 kmod_module_get_softdeps
+kmod_module_get_user_softdeps
 kmod_module_apply_filter
 kmod_module_get_filtered_blacklist
 kmod_module_get_install_commands
diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index e83621b..c0e15be 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -54,8 +54,10 @@ struct kmod_softdep {
 	char *name;
 	const char **pre;
 	const char **post;
+	const char **user;
 	unsigned int n_pre;
 	unsigned int n_post;
+	unsigned int n_user;
 };
 
 const char *kmod_blacklist_get_modname(const struct kmod_list *l)
@@ -110,6 +112,12 @@ const char * const *kmod_softdep_get_post(const struct kmod_list *l, unsigned in
 	return dep->post;
 }
 
+const char * const *kmod_softdep_get_user(const struct kmod_list *l, unsigned int *count) {
+	const struct kmod_softdep *dep = l->data;
+	*count = dep->n_user;
+	return dep->user;
+}
+
 static int kmod_config_add_command(struct kmod_config *config,
 						const char *modname,
 						const char *command,
@@ -263,11 +271,11 @@ static int kmod_config_add_softdep(struct kmod_config *config,
 	struct kmod_softdep *dep;
 	const char *s, *p;
 	char *itr;
-	unsigned int n_pre = 0, n_post = 0;
+	unsigned int n_pre = 0, n_post = 0, n_user = 0;
 	size_t modnamelen = strlen(modname) + 1;
 	size_t buflen = 0;
 	bool was_space = false;
-	enum { S_NONE, S_PRE, S_POST } mode = S_NONE;
+	enum { S_NONE, S_PRE, S_POST, S_USER } mode = S_NONE;
 
 	DBG(config->ctx, "modname=%s\n", modname);
 
@@ -298,6 +306,9 @@ static int kmod_config_add_softdep(struct kmod_config *config,
 		else if (plen == sizeof("post:") - 1 &&
 				memcmp(p, "post:", sizeof("post:") - 1) == 0)
 			mode = S_POST;
+		else if (plen == sizeof("user:") - 1 &&
+				memcmp(p, "user:", sizeof("user:") - 1) == 0)
+			mode = S_USER;
 		else if (*s != '\0' || (*s == '\0' && !was_space)) {
 			if (mode == S_PRE) {
 				buflen += plen + 1;
@@ -305,6 +316,9 @@ static int kmod_config_add_softdep(struct kmod_config *config,
 			} else if (mode == S_POST) {
 				buflen += plen + 1;
 				n_post++;
+			} else if (mode == S_USER) {
+				buflen += plen + 1;
+				n_user++;
 			}
 		}
 		p = s + 1;
@@ -312,11 +326,12 @@ static int kmod_config_add_softdep(struct kmod_config *config,
 			break;
 	}
 
-	DBG(config->ctx, "%u pre, %u post\n", n_pre, n_post);
+	DBG(config->ctx, "%u pre, %u post, %u user\n", n_pre, n_post, n_user);
 
 	dep = malloc(sizeof(struct kmod_softdep) + modnamelen +
 		     n_pre * sizeof(const char *) +
 		     n_post * sizeof(const char *) +
+		     n_user * sizeof(const char *) +
 		     buflen);
 	if (dep == NULL) {
 		ERR(config->ctx, "out-of-memory modname=%s\n", modname);
@@ -324,9 +339,11 @@ static int kmod_config_add_softdep(struct kmod_config *config,
 	}
 	dep->n_pre = n_pre;
 	dep->n_post = n_post;
+	dep->n_user = n_user;
 	dep->pre = (const char **)((char *)dep + sizeof(struct kmod_softdep));
 	dep->post = dep->pre + n_pre;
-	dep->name = (char *)(dep->post + n_post);
+	dep->user = dep->post + n_post;
+	dep->name = (char *)(dep->user + n_user);
 
 	memcpy(dep->name, modname, modnamelen);
 
@@ -334,6 +351,7 @@ static int kmod_config_add_softdep(struct kmod_config *config,
 	itr = dep->name + modnamelen;
 	n_pre = 0;
 	n_post = 0;
+	n_user = 0;
 	mode = S_NONE;
 	was_space = false;
 	for (p = s = line; ; s++) {
@@ -362,6 +380,9 @@ static int kmod_config_add_softdep(struct kmod_config *config,
 		else if (plen == sizeof("post:") - 1 &&
 				memcmp(p, "post:", sizeof("post:") - 1) == 0)
 			mode = S_POST;
+		else if (plen == sizeof("user:") - 1 &&
+				memcmp(p, "user:", sizeof("user:") - 1) == 0)
+			mode = S_USER;
 		else if (*s != '\0' || (*s == '\0' && !was_space)) {
 			if (mode == S_PRE) {
 				dep->pre[n_pre] = itr;
@@ -375,6 +396,12 @@ static int kmod_config_add_softdep(struct kmod_config *config,
 				itr[plen] = '\0';
 				itr += plen + 1;
 				n_post++;
+			} else if (mode == S_USER) {
+				dep->user[n_user] = itr;
+				memcpy(itr, p, plen);
+				itr[plen] = '\0';
+				itr += plen + 1;
+				n_user++;
 			}
 		}
 		p = s + 1;
@@ -395,14 +422,15 @@ static int kmod_config_add_softdep(struct kmod_config *config,
 static char *softdep_to_char(struct kmod_softdep *dep) {
 	const size_t sz_preprefix = sizeof("pre: ") - 1;
 	const size_t sz_postprefix = sizeof("post: ") - 1;
+	const size_t sz_userprefix = sizeof("user: ") - 1;
 	size_t sz = 1; /* at least '\0' */
-	size_t sz_pre, sz_post;
+	size_t sz_pre, sz_post, sz_user;
 	const char *start, *end;
 	char *s, *itr;
 
 	/*
-	 * Rely on the fact that dep->pre[] and dep->post[] are strv's that
-	 * point to a contiguous buffer
+	 * Rely on the fact that dep->pre[] dep->post[] and dep->user[]
+	 * are strv's that point to a contiguous buffer
 	 */
 	if (dep->n_pre > 0) {
 		start = dep->pre[0];
@@ -422,6 +450,15 @@ static char *softdep_to_char(struct kmod_softdep *dep) {
 	} else
 		sz_post = 0;
 
+	if (dep->n_user > 0) {
+		start = dep->user[0];
+		end = dep->user[dep->n_user - 1]
+					+ strlen(dep->user[dep->n_user - 1]);
+		sz_user = end - start;
+		sz += sz_user + sz_userprefix;
+	} else
+		sz_user = 0;
+
 	itr = s = malloc(sz);
 	if (s == NULL)
 		return NULL;
@@ -456,6 +493,21 @@ static char *softdep_to_char(struct kmod_softdep *dep) {
 		itr = p;
 	}
 
+	if (sz_user) {
+		char *p;
+
+		memcpy(itr, "user: ", sz_userprefix);
+		itr += sz_userprefix;
+
+		/* include last '\0' */
+		memcpy(itr, dep->user[0], sz_user + 1);
+		for (p = itr; p < itr + sz_user; p++) {
+			if (*p == '\0')
+				*p = ' ';
+		}
+		itr = p;
+	}
+
 	*itr = '\0';
 
 	return s;
diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 26a7e28..8e4f112 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -145,6 +145,7 @@ const char *kmod_command_get_modname(const struct kmod_list *l) __attribute__((n
 const char *kmod_softdep_get_name(const struct kmod_list *l) __attribute__((nonnull(1)));
 const char * const *kmod_softdep_get_pre(const struct kmod_list *l, unsigned int *count) __attribute__((nonnull(1, 2)));
 const char * const *kmod_softdep_get_post(const struct kmod_list *l, unsigned int *count);
+const char * const *kmod_softdep_get_user(const struct kmod_list *l, unsigned int *count);
 
 
 /* libkmod-module.c */
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 585da41..dbe676c 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -1664,6 +1664,56 @@ KMOD_EXPORT int kmod_module_get_softdeps(const struct kmod_module *mod,
 	return 0;
 }
 
+/**
+ * kmod_module_get_user_softdeps:
+ * @mod: kmod module
+ * @user: where to save the list of user soft dependencies.
+ *
+ * Get user dependencies for this kmod module. Soft dependencies come
+ * from configuration file and are not cached in @mod because it may include
+ * dependency cycles that would make we leak kmod_module. Any call
+ * to this function will search for this module in configuration, allocate a
+ * list and return the result.
+ *
+ * @user is newly created list of kmod_module and
+ * should be unreferenced with kmod_module_unref_list().
+ *
+ * Returns: 0 on success or < 0 otherwise.
+ */
+KMOD_EXPORT int kmod_module_get_user_softdeps(const struct kmod_module *mod,
+						struct kmod_list **user)
+{
+	const struct kmod_list *l;
+	const struct kmod_config *config;
+
+	if (mod == NULL || user == NULL)
+		return -ENOENT;
+
+	assert(*user == NULL);
+
+	config = kmod_get_config(mod->ctx);
+
+	kmod_list_foreach(l, config->softdeps) {
+		const char *modname = kmod_softdep_get_name(l);
+		const char * const *array;
+		unsigned count;
+
+		if (fnmatch(modname, mod->name, 0) != 0)
+			continue;
+
+		array = kmod_softdep_get_user(l, &count);
+		*user = lookup_softdep(mod->ctx, array, count);
+
+		/*
+		 * find only the first command, as modprobe from
+		 * module-init-tools does
+		 */
+		break;
+	}
+
+	return 0;
+}
+
 /**
  * kmod_module_get_remove_commands:
  * @mod: kmod module
diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
index 7251aa7..ec6d270 100644
--- a/libkmod/libkmod.h
+++ b/libkmod/libkmod.h
@@ -196,6 +196,8 @@ const char *kmod_module_get_remove_commands(const struct kmod_module *mod);
 struct kmod_list *kmod_module_get_dependencies(const struct kmod_module *mod);
 int kmod_module_get_softdeps(const struct kmod_module *mod,
 				struct kmod_list **pre, struct kmod_list **post);
+int kmod_module_get_user_softdeps(const struct kmod_module *mod,
+					struct kmod_list **user);
 int kmod_module_get_filtered_blacklist(const struct kmod_ctx *ctx,
 					const struct kmod_list *input,
 					struct kmod_list **output) __attribute__ ((deprecated));
diff --git a/libkmod/libkmod.sym b/libkmod/libkmod.sym
index 0c04fda..26c3eef 100644
--- a/libkmod/libkmod.sym
+++ b/libkmod/libkmod.sym
@@ -42,6 +42,7 @@ global:
 
 	kmod_module_get_dependencies;
 	kmod_module_get_softdeps;
+	kmod_module_get_user_softdeps;
 	kmod_module_get_filtered_blacklist;
 
 	kmod_module_get_name;
-- 
2.44.0

