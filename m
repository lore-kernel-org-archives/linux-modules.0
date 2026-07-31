Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DF842DA50;
	Fri, 31 Jul 2026 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502988; cv=none; b=ZTFDjeGXns26bVraZAXNCuyjHM6iraekiOGVyzTxBNQCwS7+G7d3yA9AbSnufitUzOSh0qrC/RTNKnHC0IXe1JQVRthOoiuA1qBZe/aPuV/QbRBR7GzqcUp3wfgEP1At4EA/J76sz5VFy0CIpifmhsokq7rINDJ9jWqWQtdIR4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502988; c=relaxed/simple;
	bh=V2wxZhoHVWffRIKfCoiokWovc+AjWq81unlflacOnC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qrUhrf9CgNLZOAk2QO2g7I3t567tsNChHbV564qUymW1+zFPcaDsGm2iAI+wimje9hPOozmMXyw6edhvNzGXzZ9cU/qf2Fgg5Vp855/bMjo00OaFUjZrtqYGS3MARP0WyFZqiYzo1MovzUEXk+uNFjiTIrlbnrhj2UznBGOeRzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t3J/jFNy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t3J/jFNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFDD1F000E9;
	Fri, 31 Jul 2026 13:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785502986;
	bh=lKfeHMMS/JD2JJc1HXDMovraIG2bbsZFo6mnqo0AZoc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=t3J/jFNytldqjR/03kuxJMX4mPim2tDXWvLGuwRGjJyf/WSpbVsfGeEfJkPput73Z
	 coxB1ALbZgmO42TLY6TBKBGlpJ0bCyjNZKVj9rOcO5HeStV1yv2gl/YFx9gJd/Mwdo
	 0IsWoQZ27dJUbDULl9lqGgGJmoSffwC/m4F6Odq0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 31 Jul 2026 15:02:24 +0200
Subject: [PATCH v2 2/2] module: remove srcversion module attribute
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-module_ver_remove-v2-2-c9163858f382@linuxfoundation.org>
References: <20260731-module_ver_remove-v2-0-c9163858f382@linuxfoundation.org>
In-Reply-To: <20260731-module_ver_remove-v2-0-c9163858f382@linuxfoundation.org>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Shyam Saini <shyamsaini@linux.microsoft.com>, Kees Cook <kees@kernel.org>, 
 Thorsten Blum <thorsten.blum@linux.dev>, 
 Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openpgp-sha256; l=8802;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=V2wxZhoHVWffRIKfCoiokWovc+AjWq81unlflacOnC8=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFk5c76JXmZYeqjS/9WugPpFcleENjpNSLbUXXP2x5t47
 r28Nsu+dMSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEFvgyLOg5p6p2p8bedO1h
 iaK2bmXhqntFOgwLdrDMnHqTvXLDNaGTjJLJC74Iir2WAwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

Now that module versions are gone, there is no need for srcversion
either.  So drop the logic for this from both the kernel and the helper
module tools.

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Daniel Gomez <da.gomez@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/stable/sysfs-module |  6 ------
 drivers/block/drbd/drbd_buildtag.c    |  7 +------
 include/linux/module.h                |  1 -
 kernel/module/Kconfig                 | 11 -----------
 kernel/module/main.c                  | 30 ------------------------------
 scripts/Makefile.modpost              |  1 -
 scripts/mod/modpost.c                 | 24 ------------------------
 scripts/mod/modpost.h                 |  1 -
 8 files changed, 1 insertion(+), 80 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-module b/Documentation/ABI/stable/sysfs-module
index 7a3cdd8a8d9f..5c028af9921a 100644
--- a/Documentation/ABI/stable/sysfs-module
+++ b/Documentation/ABI/stable/sysfs-module
@@ -33,9 +33,3 @@ Description:
 		Note: If the module is built into the kernel, or if the
 		CONFIG_MODULE_UNLOAD kernel configuration value is not enabled,
 		this file will not be present.
-
-What:		/sys/module/<MODULENAME>/srcversion
-Date:		Jun 2005
-Description:
-		If the module source has MODULE_VERSION, this file will contain
-		the checksum of the source code.
diff --git a/drivers/block/drbd/drbd_buildtag.c b/drivers/block/drbd/drbd_buildtag.c
index cd0389488f63..22f1e842f9ce 100644
--- a/drivers/block/drbd/drbd_buildtag.c
+++ b/drivers/block/drbd/drbd_buildtag.c
@@ -10,13 +10,8 @@ const char *drbd_buildtag(void)
 
 	static char buildtag[38] = "\0uilt-in";
 
-	if (buildtag[0] == 0) {
-#ifdef MODULE
-		sprintf(buildtag, "srcversion: %-24s", THIS_MODULE->srcversion);
-#else
+	if (buildtag[0] == 0)
 		buildtag[0] = 'b';
-#endif
-	}
 
 	return buildtag;
 }
diff --git a/include/linux/module.h b/include/linux/module.h
index 209b6a388be7..cafb99479966 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -377,7 +377,6 @@ struct module {
 	/* Sysfs stuff. */
 	struct module_kobject mkobj;
 	struct module_attribute *modinfo_attrs;
-	const char *srcversion;
 	const char *imported_namespaces;
 	struct kobject *holders_dir;
 
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 43b1bb01fd27..e27f12778e24 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -238,17 +238,6 @@ config BASIC_MODVERSIONS
 
 endif # MODVERSIONS
 
-config MODULE_SRCVERSION_ALL
-	bool "Source checksum for all modules"
-	help
-	  Modules which contain a MODULE_VERSION get an extra "srcversion"
-	  field inserted into their modinfo section, which contains a
-	  sum of the source files which made it.  This helps maintainers
-	  see exactly which source was used to build a module (since
-	  others sometimes change the module source without updating
-	  the version).  With this option, such a "srcversion" field
-	  will be created for all modules.  If unsure, say N.
-
 config MODULE_SIG
 	bool "Module signature verification"
 	select MODULE_SIG_FORMAT
diff --git a/kernel/module/main.c b/kernel/module/main.c
index da8be9788d13..5f590ce90f2d 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -575,35 +575,6 @@ bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
 
 #endif /* CONFIG_SMP */
 
-#define MODINFO_ATTR(field)	\
-static void setup_modinfo_##field(struct module *mod, const char *s)  \
-{                                                                     \
-	mod->field = kstrdup(s, GFP_KERNEL);                          \
-}                                                                     \
-static ssize_t show_modinfo_##field(const struct module_attribute *mattr, \
-			struct module_kobject *mk, char *buffer)      \
-{                                                                     \
-	return scnprintf(buffer, PAGE_SIZE, "%s\n", mk->mod->field);  \
-}                                                                     \
-static int modinfo_##field##_exists(struct module *mod)               \
-{                                                                     \
-	return mod->field != NULL;                                    \
-}                                                                     \
-static void free_modinfo_##field(struct module *mod)                  \
-{                                                                     \
-	kfree(mod->field);                                            \
-	mod->field = NULL;                                            \
-}                                                                     \
-static const struct module_attribute modinfo_##field = {              \
-	.attr = { .name = __stringify(field), .mode = 0444 },         \
-	.show = show_modinfo_##field,                                 \
-	.setup = setup_modinfo_##field,                               \
-	.test = modinfo_##field##_exists,                             \
-	.free = free_modinfo_##field,                                 \
-};
-
-MODINFO_ATTR(srcversion);
-
 static void setup_modinfo_import_ns(struct module *mod, const char *s)
 {
 	mod->imported_namespaces = NULL;
@@ -1083,7 +1054,6 @@ static const struct module_attribute modinfo_taint =
 
 const struct module_attribute *const modinfo_attrs[] = {
 	&module_uevent,
-	&modinfo_srcversion,
 	&modinfo_import_ns,
 	&modinfo_initstate,
 	&modinfo_coresize,
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index d7d45067d08b..b6c1467cf527 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -45,7 +45,6 @@ modpost-args =										\
 	$(if $(CONFIG_MODVERSIONS),-m)							\
 	$(if $(CONFIG_BASIC_MODVERSIONS),-b)						\
 	$(if $(CONFIG_EXTENDED_MODVERSIONS),-x)						\
-	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)					\
 	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)					\
 	$(if $(KBUILD_MODPOST_WARN),-w)							\
 	$(if $(KBUILD_NSDEPS),-d modules.nsdeps)					\
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index a7b72a81d248..2e969be7f414 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -33,8 +33,6 @@
 static bool module_enabled;
 /* Are we using CONFIG_MODVERSIONS? */
 static bool modversions;
-/* Is CONFIG_MODULE_SRCVERSION_ALL set? */
-static bool all_versions;
 /* Is CONFIG_BASIC_MODVERSIONS set? */
 static bool basic_modversions;
 /* Is CONFIG_EXTENDED_MODVERSIONS set? */
@@ -1584,7 +1582,6 @@ static void mod_set_crcs(struct module *mod)
 static void read_symbols(const char *modname)
 {
 	const char *symname;
-	char *version;
 	char *license;
 	char *namespace;
 	struct module *mod;
@@ -1645,13 +1642,6 @@ static void read_symbols(const char *modname)
 
 	check_sec_ref(mod, &info);
 
-	if (!mod->is_vmlinux) {
-		version = get_modinfo(&info, "version");
-		if (version || all_versions)
-			get_src_version(mod->name, mod->srcversion,
-					sizeof(mod->srcversion) - 1);
-	}
-
 	parse_elf_finish(&info);
 
 	if (modversions) {
@@ -2035,15 +2025,6 @@ static void add_depends(struct buffer *b, struct module *mod)
 	buf_printf(b, "\");\n");
 }
 
-static void add_srcversion(struct buffer *b, struct module *mod)
-{
-	if (mod->srcversion[0]) {
-		buf_printf(b, "\n");
-		buf_printf(b, "MODULE_INFO(srcversion, \"%s\");\n",
-			   mod->srcversion);
-	}
-}
-
 static void write_buf(struct buffer *b, const char *fname)
 {
 	FILE *file;
@@ -2149,8 +2130,6 @@ static void write_mod_c_file(struct module *mod)
 		free(alias);
 	}
 
-	add_srcversion(&buf, mod);
-
 	ret = snprintf(fname, sizeof(fname), "%s.mod.c", mod->name);
 	if (ret >= sizeof(fname)) {
 		error("%s: too long path was truncated\n", fname);
@@ -2327,9 +2306,6 @@ int main(int argc, char **argv)
 		case 'o':
 			dump_write = optarg;
 			break;
-		case 'a':
-			all_versions = true;
-			break;
 		case 'T':
 			files_source = optarg;
 			break;
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 2aecb8f25c87..2c2f1d2b4021 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -126,7 +126,6 @@ struct module {
 	bool seen;
 	bool has_init;
 	bool has_cleanup;
-	char	     srcversion[25];
 	// Missing namespace dependencies
 	struct list_head missing_namespaces;
 	// Actual imported namespaces

-- 
2.55.0

