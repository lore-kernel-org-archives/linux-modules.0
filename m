Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51432 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283Ab3EDJHN (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Sat, 4 May 2013 05:07:13 -0400
From: Chengwei Yang <chengwei.yang@intel.com>
To: linux-modules@vger.kernel.org
Cc: Chengwei Yang <chengwei.yang@intel.com>
Subject: [V2, 1/2] Several minor fixes for documentation
Date: Sat,  4 May 2013 17:07:02 +0800
Message-Id: <1367658423-25937-1-git-send-email-chengwei.yang@intel.com>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

---
 libkmod/libkmod-module.c |   12 +++++-------
 libkmod/libkmod.c        |    6 ++++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 47d12ad..b6fcc3b 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -570,8 +570,7 @@ fail:
  * Drop a reference of each kmod module in @list and releases the resources
  * taken by the list itself.
  *
- * Returns: NULL if @mod is NULL or if the module was released. Otherwise it
- * returns the passed @mod with its refcount decremented.
+ * Returns: 0
  */
 KMOD_EXPORT int kmod_module_unref_list(struct kmod_list *list)
 {
@@ -629,9 +628,8 @@ static const struct kmod_list *module_get_dependencies_noref(const struct kmod_m
  * The result is cached in @mod, so subsequent calls to this function will
  * return the already searched list of modules.
  *
- * Returns: NULL on failure or if there are any dependencies. Otherwise it
- * returns a list of kmod modules that can be released by calling
- * kmod_module_unref_list().
+ * Returns: NULL on failure. Otherwise it returns a list of kmod modules
+ * that can be released by calling kmod_module_unref_list().
  */
 KMOD_EXPORT struct kmod_list *kmod_module_get_dependencies(const struct kmod_module *mod)
 {
@@ -1564,7 +1562,7 @@ void kmod_module_set_remove_commands(struct kmod_module *mod, const char *cmd)
  * Create a new list of kmod modules with all modules currently loaded in
  * kernel. It uses /proc/modules to get the names of loaded modules and to
  * create kmod modules by calling kmod_module_new_from_name() in each of them.
- * They are put are put in @list in no particular order.
+ * They are put in @list in no particular order.
  *
  * The initial refcount is 1, and needs to be decremented to release the
  * resources of the kmod_module. The returned @list must be released by
@@ -2380,7 +2378,7 @@ list_error:
 }
 
 /**
- * kmod_module_versions_get_symbol:
+ * kmod_module_version_get_symbol:
  * @entry: a list entry representing a kmod module versions
  *
  * Get the symbol of a kmod module versions.
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 66d4859..e8e3ea0 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -219,8 +219,8 @@ static char *get_kernel_release(const char *dirname)
  * kmod_new:
  * @dirname: what to consider as linux module's directory, if NULL
  *           defaults to /lib/modules/`uname -r`. If it's relative,
- *           it's treated as relative to current the current working
- *           directory. Otherwise, give an absolute dirname.
+ *           it's treated as relative to the current working directory.
+ *           Otherwise, give an absolute dirname.
  * @config_paths: ordered array of paths (directories or files) where
  *                to load from user-defined configuration parameters such as
  *                alias, blacklists, commands (install, remove). If
@@ -307,6 +307,8 @@ KMOD_EXPORT struct kmod_ctx *kmod_ref(struct kmod_ctx *ctx)
  *
  * Drop a reference of the kmod library context. If the refcount
  * reaches zero, the resources of the context will be released.
+ *
+ * Returns: the passed kmod library context or NULL if it's freed
  */
 KMOD_EXPORT struct kmod_ctx *kmod_unref(struct kmod_ctx *ctx)
 {
-- 
1.7.9.5

