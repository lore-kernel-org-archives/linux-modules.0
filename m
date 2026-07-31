Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C483342CB07;
	Fri, 31 Jul 2026 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502985; cv=none; b=QhZ4U66447jS6D72C/lEKFKaLTTIuwk0Knu/+lOw9sSz8TCabcffEyiM7cNA0O4NomEErlYSX/wXz0Q1E8FBpULex+V4KxefADf2tsPLeP+cN/kpsMACdEPYVjjYrHRQkrEl6e1mQz2/96MZI+S+3ais41E9yvXA6csqQXIyx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502985; c=relaxed/simple;
	bh=YvhAS+jqIEopvMBRFPP4PuvgS21KN+zPGPaVhgmWBjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kpRqlor69EzErP+1vxMo1/GWeyaXwfSzZ4ZJYkJBwdOZ7SJ7T4EU7dIFnp6M0ulJZtJlM0xpobDOvJTRb0KkWG+2cKc9erwfTXBvieLpUyX2N8STryatawdMHkkgP7q3+bvHJH+dreVUm6yk6NKAVRHiOeGkxZ4/ZWymKysLKXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fgo80dGi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fgo80dGi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043FF1F000E9;
	Fri, 31 Jul 2026 13:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785502983;
	bh=Z9eknygJ64zVXB4Xgdrr0GdVp/4tpYnJSHY3Y16u6BE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Fgo80dGikgWpRNlM8F87BPlHBOQwUYYe+jvS6hO9GSky5B4XpWONafXcNvAKnNBzk
	 RsHFuhmpKbMuWjQ1OYeN4PJyGJ86YywYuNuQ9C0vMKKSePIVh8CYKQ7G9XROMLPvbq
	 XUcnAqQQyuPG63VRQt8a5DQdRj5qWMBoAM8BSF/M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 31 Jul 2026 15:02:23 +0200
Subject: [PATCH v2 1/2] module: remove MODULE_VERSION()
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-module_ver_remove-v2-1-c9163858f382@linuxfoundation.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9004;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=YvhAS+jqIEopvMBRFPP4PuvgS21KN+zPGPaVhgmWBjs=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFk5c77e6ZtU/vrHoXSOnB0y/RJnnxh8OhO8uTRDjWtSi
 /DKKo7CjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIYXeG+RFLw5vkLy16sptl
 XmONJvuFU0em6jMsuFAhuf+hYAPX5mQJ7jOqRbFzFD5sBQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

Module "versions" do not make sense as the kernel is built all at once,
the "version" is the overall kernel version number, so modules can not
really be described as having a unique version given that they rely on
the infrastructure of the whole kernel.

For now, just make this an "empty" define, to keep existing code
building properly as the tree is slowly purged of the use of this over
time.

This macro will be removed entirely in the future when there are no
in-tree users.

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Daniel Gomez <da.gomez@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/stable/sysfs-module    |  6 ----
 arch/x86/tools/relocs.c                  |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  7 +---
 include/asm-generic/vmlinux.lds.h        |  5 ---
 include/linux/module.h                   | 57 ++++++--------------------------
 kernel/module/main.c                     |  2 --
 kernel/params.c                          | 30 -----------------
 7 files changed, 12 insertions(+), 96 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-module b/Documentation/ABI/stable/sysfs-module
index 41b1f16e8795..7a3cdd8a8d9f 100644
--- a/Documentation/ABI/stable/sysfs-module
+++ b/Documentation/ABI/stable/sysfs-module
@@ -39,9 +39,3 @@ Date:		Jun 2005
 Description:
 		If the module source has MODULE_VERSION, this file will contain
 		the checksum of the source code.
-
-What:		/sys/module/<MODULENAME>/version
-Date:		Jun 2005
-Description:
-		If the module source has MODULE_VERSION, this file will contain
-		the version of the source code.
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index e5a2b9a912d1..1426ddcb3a89 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -81,7 +81,6 @@ static const char * const	sym_regex_kernel[S_NSYMTYPES] = {
 	"__(start|stop)___ksymtab(_gpl)?|"
 	"__(start|stop)___kcrctab(_gpl)?|"
 	"__(start|stop)___param|"
-	"__(start|stop)___modver|"
 	"__(start|stop)___bug_table|"
 	"__tracedata_(start|end)|"
 	"__(start|stop)_notes|"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 9e8f7d2b898c..a1ca1bc27f93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -677,12 +677,7 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 	vf2pf_info->header.size = sizeof(struct amd_sriov_msg_vf2pf_info);
 	vf2pf_info->header.version = AMD_SRIOV_MSG_FW_VRAM_VF2PF_VER;
 
-#ifdef MODULE
-	if (THIS_MODULE->version != NULL)
-		strscpy(vf2pf_info->driver_version, THIS_MODULE->version);
-	else
-#endif
-		strscpy(vf2pf_info->driver_version, "N/A");
+	strscpy(vf2pf_info->driver_version, "N/A");
 
 	vf2pf_info->pf2vf_version_required = 0; // no requirement, guest understands all
 	vf2pf_info->driver_cert = 0;
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5659f4b5a125..80bc90ec9ee1 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -544,11 +544,6 @@
 		BOUNDED_SECTION_BY(__param, ___param)			\
 	}								\
 									\
-	/* Built-in module versions. */					\
-	__modver : AT(ADDR(__modver) - LOAD_OFFSET) {			\
-		BOUNDED_SECTION_BY(__modver, ___modver)			\
-	}								\
-									\
 	KCFI_TRAPS							\
 									\
 	RO_EXCEPTION_TABLE						\
diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..209b6a388be7 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -62,15 +62,6 @@ struct module_attribute {
 	void (*free)(struct module *);
 };
 
-struct module_version_attribute {
-	struct module_attribute mattr;
-	const char *module_name;
-	const char *version;
-};
-
-extern ssize_t __modver_version_show(const struct module_attribute *,
-				     struct module_kobject *, char *);
-
 extern const struct module_attribute module_uevent;
 
 /* These are either module local, or the kernel's dummy ones. */
@@ -256,43 +247,18 @@ struct module_kobject *lookup_or_create_module_kobject(const char *name);
 static typeof(name) __mod_device_table(type, name)			\
   __attribute__ ((used, alias(__stringify(name))))
 
-/* Version of form [<epoch>:]<version>[-<extra-version>].
- * Or for CVS/RCS ID version, everything but the number is stripped.
- * <epoch>: A (small) unsigned integer which allows you to start versions
- * anew. If not mentioned, it's zero.  eg. "2:1.0" is after
- * "1:2.0".
-
- * <version>: The <version> may contain only alphanumerics and the
- * character `.'.  Ordered by numeric sort for numeric parts,
- * ascii sort for ascii parts (as per RPM or DEB algorithm).
-
- * <extraversion>: Like <version>, but inserted for local
- * customizations, eg "rh3" or "rusty1".
-
- * Using this automatically adds a checksum of the .c files and the
- * local headers in "srcversion".
+/*
+ * Module "versions" do not make sense as the kernel is built all at once, the
+ * "version" is the overall kernel version number, so modules can not really be
+ * described as having a unique version given that they rely on the
+ * infrastructure of the whole kernel.
+ *
+ * For now, just make this an "empty" define, to keep existing code building
+ * properly as the tree is slowly purged of the use of this over time.
+ *
+ * It will be removed in the future when there are no in-tree users.
  */
-
-#if defined(MODULE) || !defined(CONFIG_SYSFS)
-#define MODULE_VERSION(_version) MODULE_INFO(version, _version)
-#else
-#define MODULE_VERSION(_version)					\
-	MODULE_INFO(version, _version);					\
-	static const struct module_version_attribute __modver_attr	\
-		__used __section("__modver")				\
-		__aligned(__alignof__(struct module_version_attribute)) \
-		= {							\
-			.mattr	= {					\
-				.attr	= {				\
-					.name	= "version",		\
-					.mode	= S_IRUGO,		\
-				},					\
-				.show	= __modver_version_show,	\
-			},						\
-			.module_name	= KBUILD_MODNAME,		\
-			.version	= _version,			\
-		}
-#endif
+#define MODULE_VERSION(_version)
 
 /* Optional firmware file (or files) needed by the module
  * format is simply firmware file name.  Multiple firmware
@@ -411,7 +377,6 @@ struct module {
 	/* Sysfs stuff. */
 	struct module_kobject mkobj;
 	struct module_attribute *modinfo_attrs;
-	const char *version;
 	const char *srcversion;
 	const char *imported_namespaces;
 	struct kobject *holders_dir;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..da8be9788d13 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -602,7 +602,6 @@ static const struct module_attribute modinfo_##field = {              \
 	.free = free_modinfo_##field,                                 \
 };
 
-MODINFO_ATTR(version);
 MODINFO_ATTR(srcversion);
 
 static void setup_modinfo_import_ns(struct module *mod, const char *s)
@@ -1084,7 +1083,6 @@ static const struct module_attribute modinfo_taint =
 
 const struct module_attribute *const modinfo_attrs[] = {
 	&module_uevent,
-	&modinfo_version,
 	&modinfo_srcversion,
 	&modinfo_import_ns,
 	&modinfo_initstate,
diff --git a/kernel/params.c b/kernel/params.c
index a668863a4bb6..6c5a1eb22b25 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -837,35 +837,6 @@ static void __init param_sysfs_builtin(void)
 	}
 }
 
-ssize_t __modver_version_show(const struct module_attribute *mattr,
-			      struct module_kobject *mk, char *buf)
-{
-	const struct module_version_attribute *vattr =
-		container_of_const(mattr, struct module_version_attribute, mattr);
-
-	return scnprintf(buf, PAGE_SIZE, "%s\n", vattr->version);
-}
-
-extern const struct module_version_attribute __start___modver[];
-extern const struct module_version_attribute __stop___modver[];
-
-static void __init version_sysfs_builtin(void)
-{
-	const struct module_version_attribute *vattr;
-	struct module_kobject *mk;
-	int err;
-
-	for (vattr = __start___modver; vattr < __stop___modver; vattr++) {
-		mk = lookup_or_create_module_kobject(vattr->module_name);
-		if (mk) {
-			err = sysfs_create_file(&mk->kobj, &vattr->mattr.attr);
-			WARN_ON_ONCE(err);
-			kobject_uevent(&mk->kobj, KOBJ_ADD);
-			kobject_put(&mk->kobj);
-		}
-	}
-}
-
 /* module-related sysfs stuff */
 
 static ssize_t module_attr_show(struct kobject *kobj,
@@ -968,7 +939,6 @@ static int __init param_sysfs_builtin_init(void)
 	if (!module_kset)
 		return -ENOMEM;
 
-	version_sysfs_builtin();
 	param_sysfs_builtin();
 
 	return 0;

-- 
2.55.0

