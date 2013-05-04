Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51432 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752643Ab3EDJHS (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Sat, 4 May 2013 05:07:18 -0400
From: Chengwei Yang <chengwei.yang@intel.com>
To: linux-modules@vger.kernel.org
Cc: Chengwei Yang <chengwei.yang@intel.com>
Subject: [V2, 2/2] Add document for exported enums
Date: Sat,  4 May 2013 17:07:03 +0800
Message-Id: <1367658423-25937-2-git-send-email-chengwei.yang@intel.com>
In-Reply-To: <1367658423-25937-1-git-send-email-chengwei.yang@intel.com>
References: <1367658423-25937-1-git-send-email-chengwei.yang@intel.com>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

There are several exported enums by libkmod without document, this patch
mainly added documentation for below enums like the way kmod_resources
be documented in.
* kmod_index
* kmod_remove
* kmod_insert
* kmod_probe
* kmod_filter
* kmod_module_initstate

This is not the best way to document these exported enums, however, it's
the simple way due to gtkdoc limits. It doesn't support export plain
enum like below: see https://bugzilla.gnome.org/show_bug.cgi?id=657444
---------8<-------head.h--------------8<-----------
...
enum foo {
    ...
};
...
---------8<-------end of head.h-------8<-----------
---------8<-------source.c------------8<-----------
...
/**
 * document for foo here
 */
...
typedef enum foo foo;
...
---------8<-------end of source.c-----8<----------
---
 libkmod/libkmod-module.c |   43 ++++++++++++++++++++++++++++++++++++++-----
 libkmod/libkmod.c        |    6 +++++-
 2 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index b6fcc3b..b24ea8f 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -738,7 +738,15 @@ extern long delete_module(const char *name, unsigned int flags);
 /**
  * kmod_module_remove_module:
  * @mod: kmod module
- * @flags: flags to pass to Linux kernel when removing the module
+ * @flags: flags to pass to Linux kernel when removing the module, valid flags are
+ * KMOD_REMOVE_FORCE: force remove module regardless if it's still in
+ * use by a kernel subsystem or other process;
+ * KMOD_REMOVE_NOWAIT: return immediately. It will fail if the module
+ * is in using and KMOD_REMOVE_FORCE is not specified.
+ * If this module is in use by any kernel subsystem or process, not using
+ * this flag will cause the call to block indefinitely, until the module
+ * is not in use anymore. Always use this flag, it's deprecated not using
+ * it and the default behavior might change in future to always set it.
  *
  * Remove a module from Linux kernel.
  *
@@ -770,7 +778,9 @@ extern long init_module(const void *mem, unsigned long len, const char *args);
  * kmod_module_insert_module:
  * @mod: kmod module
  * @flags: flags are not passed to Linux Kernel, but instead they dictate the
- * behavior of this function.
+ * behavior of this function, valid flags are
+ * KMOD_INSERT_FORCE_VERMAGIC: ignore kernel version magic;
+ * KMOD_INSERT_FORCE_MODVERSION: ignore symbol version hashes.
  * @options: module's options to pass to Linux Kernel.
  *
  * Insert a module in Linux kernel. It opens the file pointed by @mod,
@@ -879,7 +889,9 @@ static bool module_is_blacklisted(struct kmod_module *mod)
 /**
  * kmod_module_apply_filter
  * @ctx: kmod library context
- * @filter_type: bitmask to filter modules on
+ * @filter_type: bitmask to filter modules out, valid types are
+ * KMOD_FILTER_BLACKLIST: filter modules in blacklist out;
+ * KMOD_FILTER_BUILTIN: filter builtin modules out.
  * @input: list of kmod_module to be filtered
  * @output: where to save the new list
  *
@@ -1150,7 +1162,24 @@ static int kmod_module_get_probe_list(struct kmod_module *mod,
  * kmod_module_probe_insert_module:
  * @mod: kmod module
  * @flags: flags are not passed to Linux Kernel, but instead they dictate the
- * behavior of this function.
+ * behavior of this function, valid flags are
+ * KMOD_PROBE_FORCE_VERMAGIC: ignore kernel version magic;
+ * KMOD_PROBE_FORCE_MODVERSION: ignore symbol version hashes;
+ * KMOD_PROBE_IGNORE_COMMAND: whether the probe should ignore install
+ * commands and softdeps configured in the system;
+ * KMOD_PROBE_IGNORE_LOADED: do not check whether the module is already
+ * live in kernel or not;
+ * KMOD_PROBE_DRY_RUN: dry run, do not insert module, just call the
+ * associated callback function;
+ * KMOD_PROBE_FAIL_ON_LOADED: if KMOD_PROBE_IGNORE_LOADED is not specified
+ * and the module is already live in kernel, the function will fail if this
+ * flag is specified;
+ * KMOD_PROBE_APPLY_BLACKLIST_ALL: probe will apply KMOD_FILTER_BLACKLIST
+ * filter to this module and its dependencies. This will most likely fail
+ * the probe, unless a blacklisted module is already loaded;
+ * KMOD_PROBE_APPLY_BLACKLIST: probe will fail if the module is in blacklist;
+ * KMOD_PROBE_APPLY_BLACKLIST_ALIAS_ONLY: probe will fail if the module is an
+ * alias and is blacklisted.
  * @extra_options: module's options to pass to Linux Kernel. It applies only
  * to @mod, not to its dependencies.
  * @run_install: function to run when @mod is backed by an install command.
@@ -1650,7 +1679,11 @@ KMOD_EXPORT const char *kmod_module_initstate_str(enum kmod_module_initstate sta
  * Get the initstate of this @mod, as returned by Linux Kernel, by reading
  * /sys filesystem.
  *
- * Returns: < 0 on error or enum kmod_initstate if module is found in kernel.
+ * Returns: < 0 on error or module state if module is found in kernel, valid states are
+ * KMOD_MODULE_BUILTIN: module is builtin;
+ * KMOD_MODULE_LIVE: module is live in kernel;
+ * KMOD_MODULE_COMING: module is being loaded;
+ * KMOD_MODULE_GOING: module is being unloaded.
  */
 KMOD_EXPORT int kmod_module_get_initstate(const struct kmod_module *mod)
 {
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index e8e3ea0..788676c 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -856,7 +856,11 @@ KMOD_EXPORT void kmod_unload_resources(struct kmod_ctx *ctx)
 /**
  * kmod_dump_index:
  * @ctx: kmod library context
- * @type: index to dump
+ * @type: index to dump, valid indexes are
+ * KMOD_INDEX_MODULES_DEP: index of module dependencies;
+ * KMOD_INDEX_MODULES_ALIAS: index of module aliases;
+ * KMOD_INDEX_MODULES_SYMBOL: index of symbol aliases;
+ * KMOD_INDEX_MODULES_BUILTIN: index of builtin module.
  * @fd: file descriptor to dump index to
  *
  * Dump index to file descriptor. Note that this function doesn't use stdio.h
-- 
1.7.9.5

