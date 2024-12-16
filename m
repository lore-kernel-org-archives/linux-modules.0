Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFC9205E17;
	Mon, 16 Dec 2024 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369920; cv=none; b=VdIqxUo/zGuE84XkSmhW3cxuJJ8k1UY8pBawSgdU69A22QWEPJi/t1TtJlPObMABp/qQdmPBQ5htL8g4ILX7FSWnG2v9h2KHo/xRZ8tF6ngUs7M0cGpS8Jsd+lX9tpwdZR2k5w09yq0NMj62EsBJDXoyIQoo88416AvJnCb4XFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369920; c=relaxed/simple;
	bh=DuxXlk3W/T8wuzPthEBObYLuRqqRuQXmKbcONxISvNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VUO4iYiHtgDHL733evsi38sNbZ7NBnbN1AZfbYQkFX+dbIeQJpvqzvnu8r1LCSABN9fQGT3uR091k9VHlMmB042qr8eyZedEaeRrZn1vNFeZtW3J37u+jZCGX92ZeQpVjcSMovSjrVNZ/fDNVpCgzLqhAIraH5oeXH29FF6fMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=E1krEBuT; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="E1krEBuT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734369915;
	bh=DuxXlk3W/T8wuzPthEBObYLuRqqRuQXmKbcONxISvNo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E1krEBuTbDRp8zNUQFNmkaBWylEss+jQifuRhIFZcXHT0jcGWaWIjsTPRoZEqnrS5
	 Q/vQJ8IY6OEih0jDFZrz1OVN2z/ULD9wp4OuxM7Do5A1IPAm0XBHClqQvjKrqr7ClY
	 ybJ/mn7vGd7RDz95OckZkpnzVmP+UbFZb4EdtJ4s=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 18:25:10 +0100
Subject: [PATCH 3/3] module: Constify 'struct module_attribute'
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-attr-module-v1-3-3790b53e0abf@weissschuh.net>
References: <20241216-sysfs-const-attr-module-v1-0-3790b53e0abf@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-attr-module-v1-0-3790b53e0abf@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734369915; l=11663;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=DuxXlk3W/T8wuzPthEBObYLuRqqRuQXmKbcONxISvNo=;
 b=zXHeliF/ZE+yFg6djABfJaIXPBfIA7+SFRp0AlOiyQQytJuJkue2Y/+sY61Xw7dgltqCa4WyS
 jJPKi4EO0sPBSLZc90yNhAM0wDgthrIpnsJbv3oHjAP8cz/g6N6rSND
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

These structs are never modified, move them to read-only memory.
This makes the API clearer and also prepares for the constification of
'struct attribute' itself.

While at it, also constify 'modinfo_attrs_count'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/module.h   |  8 ++++----
 kernel/module/internal.h |  4 ++--
 kernel/module/main.c     | 40 ++++++++++++++++++++--------------------
 kernel/module/sysfs.c    |  4 ++--
 kernel/params.c          | 12 ++++++------
 5 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index de2f2293204a4681072fba9ea3439e5582c81fbf..81a0dd46a5d2c29c30ea2cb8d82147ba2fa2a0a8 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -52,9 +52,9 @@ struct module_kobject {
 
 struct module_attribute {
 	struct attribute attr;
-	ssize_t (*show)(struct module_attribute *, struct module_kobject *,
+	ssize_t (*show)(const struct module_attribute *, struct module_kobject *,
 			char *);
-	ssize_t (*store)(struct module_attribute *, struct module_kobject *,
+	ssize_t (*store)(const struct module_attribute *, struct module_kobject *,
 			 const char *, size_t count);
 	void (*setup)(struct module *, const char *);
 	int (*test)(struct module *);
@@ -67,10 +67,10 @@ struct module_version_attribute {
 	const char *version;
 };
 
-extern ssize_t __modver_version_show(struct module_attribute *,
+extern ssize_t __modver_version_show(const struct module_attribute *,
 				     struct module_kobject *, char *);
 
-extern struct module_attribute module_uevent;
+extern const struct module_attribute module_uevent;
 
 /* These are either module local, or the kernel's dummy ones. */
 extern int init_module(void);
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index daef2be8390222c22220e2f168baa8d35ad531b9..ac73da5f15bccfa6e280669c6ce048868120822b 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -47,8 +47,8 @@ struct kernel_symbol {
 extern struct mutex module_mutex;
 extern struct list_head modules;
 
-extern struct module_attribute *modinfo_attrs[];
-extern size_t modinfo_attrs_count;
+extern const struct module_attribute *const modinfo_attrs[];
+extern const size_t modinfo_attrs_count;
 
 /* Provided by the linker */
 extern const struct kernel_symbol __start___ksymtab[];
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5399c182b3cbed2dbeea0291f717f30358d8e7fc..69be1dad032abe53d55b437411f152aa95e4adf6 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -538,7 +538,7 @@ static void setup_modinfo_##field(struct module *mod, const char *s)  \
 {                                                                     \
 	mod->field = kstrdup(s, GFP_KERNEL);                          \
 }                                                                     \
-static ssize_t show_modinfo_##field(struct module_attribute *mattr,   \
+static ssize_t show_modinfo_##field(const struct module_attribute *mattr, \
 			struct module_kobject *mk, char *buffer)      \
 {                                                                     \
 	return scnprintf(buffer, PAGE_SIZE, "%s\n", mk->mod->field);  \
@@ -552,7 +552,7 @@ static void free_modinfo_##field(struct module *mod)                  \
 	kfree(mod->field);                                            \
 	mod->field = NULL;                                            \
 }                                                                     \
-static struct module_attribute modinfo_##field = {                    \
+static const struct module_attribute modinfo_##field = {              \
 	.attr = { .name = __stringify(field), .mode = 0444 },         \
 	.show = show_modinfo_##field,                                 \
 	.setup = setup_modinfo_##field,                               \
@@ -842,13 +842,13 @@ void symbol_put_addr(void *addr)
 }
 EXPORT_SYMBOL_GPL(symbol_put_addr);
 
-static ssize_t show_refcnt(struct module_attribute *mattr,
+static ssize_t show_refcnt(const struct module_attribute *mattr,
 			   struct module_kobject *mk, char *buffer)
 {
 	return sprintf(buffer, "%i\n", module_refcount(mk->mod));
 }
 
-static struct module_attribute modinfo_refcnt =
+static const struct module_attribute modinfo_refcnt =
 	__ATTR(refcnt, 0444, show_refcnt, NULL);
 
 void __module_get(struct module *module)
@@ -917,7 +917,7 @@ size_t module_flags_taint(unsigned long taints, char *buf)
 	return l;
 }
 
-static ssize_t show_initstate(struct module_attribute *mattr,
+static ssize_t show_initstate(const struct module_attribute *mattr,
 			      struct module_kobject *mk, char *buffer)
 {
 	const char *state = "unknown";
@@ -938,10 +938,10 @@ static ssize_t show_initstate(struct module_attribute *mattr,
 	return sprintf(buffer, "%s\n", state);
 }
 
-static struct module_attribute modinfo_initstate =
+static const struct module_attribute modinfo_initstate =
 	__ATTR(initstate, 0444, show_initstate, NULL);
 
-static ssize_t store_uevent(struct module_attribute *mattr,
+static ssize_t store_uevent(const struct module_attribute *mattr,
 			    struct module_kobject *mk,
 			    const char *buffer, size_t count)
 {
@@ -951,10 +951,10 @@ static ssize_t store_uevent(struct module_attribute *mattr,
 	return rc ? rc : count;
 }
 
-struct module_attribute module_uevent =
+const struct module_attribute module_uevent =
 	__ATTR(uevent, 0200, NULL, store_uevent);
 
-static ssize_t show_coresize(struct module_attribute *mattr,
+static ssize_t show_coresize(const struct module_attribute *mattr,
 			     struct module_kobject *mk, char *buffer)
 {
 	unsigned int size = mk->mod->mem[MOD_TEXT].size;
@@ -966,11 +966,11 @@ static ssize_t show_coresize(struct module_attribute *mattr,
 	return sprintf(buffer, "%u\n", size);
 }
 
-static struct module_attribute modinfo_coresize =
+static const struct module_attribute modinfo_coresize =
 	__ATTR(coresize, 0444, show_coresize, NULL);
 
 #ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
-static ssize_t show_datasize(struct module_attribute *mattr,
+static ssize_t show_datasize(const struct module_attribute *mattr,
 			     struct module_kobject *mk, char *buffer)
 {
 	unsigned int size = 0;
@@ -980,11 +980,11 @@ static ssize_t show_datasize(struct module_attribute *mattr,
 	return sprintf(buffer, "%u\n", size);
 }
 
-static struct module_attribute modinfo_datasize =
+static const struct module_attribute modinfo_datasize =
 	__ATTR(datasize, 0444, show_datasize, NULL);
 #endif
 
-static ssize_t show_initsize(struct module_attribute *mattr,
+static ssize_t show_initsize(const struct module_attribute *mattr,
 			     struct module_kobject *mk, char *buffer)
 {
 	unsigned int size = 0;
@@ -994,10 +994,10 @@ static ssize_t show_initsize(struct module_attribute *mattr,
 	return sprintf(buffer, "%u\n", size);
 }
 
-static struct module_attribute modinfo_initsize =
+static const struct module_attribute modinfo_initsize =
 	__ATTR(initsize, 0444, show_initsize, NULL);
 
-static ssize_t show_taint(struct module_attribute *mattr,
+static ssize_t show_taint(const struct module_attribute *mattr,
 			  struct module_kobject *mk, char *buffer)
 {
 	size_t l;
@@ -1007,10 +1007,10 @@ static ssize_t show_taint(struct module_attribute *mattr,
 	return l;
 }
 
-static struct module_attribute modinfo_taint =
+static const struct module_attribute modinfo_taint =
 	__ATTR(taint, 0444, show_taint, NULL);
 
-struct module_attribute *modinfo_attrs[] = {
+const struct module_attribute *const modinfo_attrs[] = {
 	&module_uevent,
 	&modinfo_version,
 	&modinfo_srcversion,
@@ -1027,7 +1027,7 @@ struct module_attribute *modinfo_attrs[] = {
 	NULL,
 };
 
-size_t modinfo_attrs_count = ARRAY_SIZE(modinfo_attrs);
+const size_t modinfo_attrs_count = ARRAY_SIZE(modinfo_attrs);
 
 static const char vermagic[] = VERMAGIC_STRING;
 
@@ -1681,7 +1681,7 @@ static void module_license_taint_check(struct module *mod, const char *license)
 
 static void setup_modinfo(struct module *mod, struct load_info *info)
 {
-	struct module_attribute *attr;
+	const struct module_attribute *attr;
 	int i;
 
 	for (i = 0; (attr = modinfo_attrs[i]); i++) {
@@ -1692,7 +1692,7 @@ static void setup_modinfo(struct module *mod, struct load_info *info)
 
 static void free_modinfo(struct module *mod)
 {
-	struct module_attribute *attr;
+	const struct module_attribute *attr;
 	int i;
 
 	for (i = 0; (attr = modinfo_attrs[i]); i++) {
diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index 456358e1fdc43e6b5b24f383bbefa37812971174..31e7f305540708582d95a83bdc865aaa28e27005 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -275,7 +275,7 @@ static int add_usage_links(struct module *mod)
 
 static void module_remove_modinfo_attrs(struct module *mod, int end)
 {
-	struct module_attribute *attr;
+	const struct module_attribute *attr;
 	int i;
 
 	for (i = 0; (attr = &mod->modinfo_attrs[i]); i++) {
@@ -293,7 +293,7 @@ static void module_remove_modinfo_attrs(struct module *mod, int end)
 
 static int module_add_modinfo_attrs(struct module *mod)
 {
-	struct module_attribute *attr;
+	const struct module_attribute *attr;
 	struct module_attribute *temp_attr;
 	int error = 0;
 	int i;
diff --git a/kernel/params.c b/kernel/params.c
index 763261a7fef94d02503fa0d365d155c223fc382b..0074d29c9b80ced537bba29c33972c998de60864 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -538,7 +538,7 @@ const struct kernel_param_ops param_ops_string = {
 EXPORT_SYMBOL(param_ops_string);
 
 /* sysfs output in /sys/modules/XYZ/parameters/ */
-#define to_module_attr(n) container_of(n, struct module_attribute, attr)
+#define to_module_attr(n) container_of_const(n, struct module_attribute, attr)
 #define to_module_kobject(n) container_of(n, struct module_kobject, kobj)
 
 struct param_attribute
@@ -557,7 +557,7 @@ struct module_param_attrs
 #ifdef CONFIG_SYSFS
 #define to_param_attr(n) container_of_const(n, struct param_attribute, mattr)
 
-static ssize_t param_attr_show(struct module_attribute *mattr,
+static ssize_t param_attr_show(const struct module_attribute *mattr,
 			       struct module_kobject *mk, char *buf)
 {
 	int count;
@@ -573,7 +573,7 @@ static ssize_t param_attr_show(struct module_attribute *mattr,
 }
 
 /* sysfs always hands a nul-terminated string in buf.  We rely on that. */
-static ssize_t param_attr_store(struct module_attribute *mattr,
+static ssize_t param_attr_store(const struct module_attribute *mattr,
 				struct module_kobject *mk,
 				const char *buf, size_t len)
 {
@@ -857,7 +857,7 @@ static void __init param_sysfs_builtin(void)
 	}
 }
 
-ssize_t __modver_version_show(struct module_attribute *mattr,
+ssize_t __modver_version_show(const struct module_attribute *mattr,
 			      struct module_kobject *mk, char *buf)
 {
 	const struct module_version_attribute *vattr =
@@ -892,7 +892,7 @@ static ssize_t module_attr_show(struct kobject *kobj,
 				struct attribute *attr,
 				char *buf)
 {
-	struct module_attribute *attribute;
+	const struct module_attribute *attribute;
 	struct module_kobject *mk;
 	int ret;
 
@@ -911,7 +911,7 @@ static ssize_t module_attr_store(struct kobject *kobj,
 				struct attribute *attr,
 				const char *buf, size_t len)
 {
-	struct module_attribute *attribute;
+	const struct module_attribute *attribute;
 	struct module_kobject *mk;
 	int ret;
 

-- 
2.47.1

