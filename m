Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AD8C677F1
	for <linux-modules@archiver.kernel.org>; Wed, 11 Jan 2023 15:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbjAKPaE (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbjAKP37 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 11 Jan 2023 10:29:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29CB2DE7
        for <linux-modules@vger.kernel.org>; Wed, 11 Jan 2023 07:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673450997; x=1704986997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0o+EvkGnZkxpr6GOKzTE2xp4CJ58hfzth6YBv4qSEYU=;
  b=fgZsz7dcyImrwGm57rU81FrVWnRwxLsxtQH4vmf2PQoo73uTf0qUiKxe
   0agad9pKsDW7cVCtFnbHckgBhnQjxfNR2kdUj/1FSEOcCHLAEaThR823t
   LDRZuaSAhfjojsKalUgBLsggBxNlfy8WHXOMzctxtD2k9rmKSYxwjKEM/
   Icj6AwAgGiLBi9juDFuUt3yhMa+sN82UAEQabuJFTd1rX7K0YsZvcrGja
   bWjxXMfH8zJWJGHL63pFw5A8SjTdtu9DVcEuRC+61JpTuh4Wxdxazf/Gu
   nMSRULfRlzM7enjpMXYi1Yvr0RuEsFBKi5JYk1YnTHoKlxfx6qJwhWvov
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="409685025"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="409685025"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 07:29:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="720758753"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="720758753"
Received: from dhuo-mobl2.amr.corp.intel.com (HELO gjsousa-mobl2.intel.com) ([10.212.66.3])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 07:29:53 -0800
From:   Gustavo Sousa <gustavo.sousa@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Gustavo Sverzut Barbieri <barbieri@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>
Subject: [PATCH 2/2] modprobe: Allow passing path to module
Date:   Wed, 11 Jan 2023 12:29:36 -0300
Message-Id: <20230111152936.101040-3-gustavo.sousa@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111152936.101040-1-gustavo.sousa@intel.com>
References: <20230111152936.101040-1-gustavo.sousa@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This is useful to kernel module developers for testing a just compiled
module: instead of using insmod, they can load the module from the path
while getting all the benefits of modprobe (e.g. module dependency
resolution).

Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
---
 man/modprobe.xml                              |   5 +++
 testsuite/populate-modules.sh                 |   1 +
 .../lib/modules/4.4.4/modules.alias           |   1 +
 .../lib/modules/4.4.4/modules.alias.bin       | Bin 0 -> 12 bytes
 .../lib/modules/4.4.4/modules.builtin.bin     |   0
 .../lib/modules/4.4.4/modules.dep             |   1 +
 .../lib/modules/4.4.4/modules.dep.bin         | Bin 0 -> 73 bytes
 .../lib/modules/4.4.4/modules.devname         |   0
 .../lib/modules/4.4.4/modules.softdep         |   1 +
 .../lib/modules/4.4.4/modules.symbols         |   1 +
 .../lib/modules/4.4.4/modules.symbols.bin     | Bin 0 -> 12 bytes
 .../module-from-path/proc/modules             |   0
 testsuite/test-modprobe.c                     |  22 ++++++++++++
 tools/modprobe.c                              |  34 ++++++++++++------
 14 files changed, 56 insertions(+), 10 deletions(-)
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.symbols.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/proc/modules

diff --git a/man/modprobe.xml b/man/modprobe.xml
index db39c7a18bb7..615466977f6a 100644
--- a/man/modprobe.xml
+++ b/man/modprobe.xml
@@ -115,6 +115,11 @@
       kernel (in addition to any options listed in the configuration
       file).
     </para>
+    <para>
+      When loading modules, <replaceable>modulename</replaceable> can also
+      be a path to the module. If the path is relative, it must
+      explicitly start with "./".
+    </para>
   </refsect1>
 
   <refsect1><title>OPTIONS</title>
diff --git a/testsuite/populate-modules.sh b/testsuite/populate-modules.sh
index 099f02669156..652279eda728 100755
--- a/testsuite/populate-modules.sh
+++ b/testsuite/populate-modules.sh
@@ -56,6 +56,7 @@ map=(
     ["test-modprobe/alias-to-none/lib/modules/4.4.4/kernel/"]="mod-simple.ko"
     ["test-modprobe/module-param-kcmdline/lib/modules/4.4.4/kernel/"]="mod-simple.ko"
     ["test-modprobe/external/lib/modules/external/"]="mod-simple.ko"
+    ["test-modprobe/module-from-path/home/foo/"]="mod-simple.ko"
     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/block/cciss.ko"]="mod-fake-cciss.ko"
     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/hpsa.ko"]="mod-fake-hpsa.ko"
     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/scsi_mod.ko"]="mod-fake-scsi-mod.ko"
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.alias b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.alias
new file mode 100644
index 000000000000..ba76e1815af0
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.alias
@@ -0,0 +1 @@
+# Aliases extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.alias.bin b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.alias.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.builtin.bin b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.builtin.bin
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.dep b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.dep
new file mode 100644
index 000000000000..e612900c5de7
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.dep
@@ -0,0 +1 @@
+/lib/modules/external/mod-simple.ko:
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.dep.bin b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.dep.bin
new file mode 100644
index 0000000000000000000000000000000000000000..556e3c8142d5d85dba5b557474907f9f9dd99dcb
GIT binary patch
literal 73
zcmdnM{w17&iGfjpfx$UHCB8T_w;(5#0SFjDgnmwDl74P}N@-4Nv3_brNorAEVh%_^
S7ot!vJKu^SH}?Po0}lY-ZWUAj

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.devname b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.devname
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.softdep b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.softdep
new file mode 100644
index 000000000000..5554ccca7f9e
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.softdep
@@ -0,0 +1 @@
+# Soft dependencies extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.symbols b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.symbols
new file mode 100644
index 000000000000..618c345f7e93
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.symbols
@@ -0,0 +1 @@
+# Aliases for symbols, used by symbol_request().
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.symbols.bin b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.symbols.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/proc/modules b/testsuite/rootfs-pristine/test-modprobe/module-from-path/proc/modules
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index 0255f1aaccb5..3f8a430c09e4 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -422,4 +422,26 @@ DEFINE_TEST(modprobe_external,
 	.modules_loaded = "mod-simple",
 	);
 
+static noreturn int modprobe_module_from_path(const struct test *t)
+{
+	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
+	const char *const args[] = {
+		progname,
+		"/home/foo/mod-simple.ko",
+		NULL,
+	};
+
+	test_spawn_prog(progname, args);
+	exit(EXIT_FAILURE);
+}
+DEFINE_TEST(modprobe_module_from_path,
+	.description = "check modprobe able to load module given as a direct path",
+	.config = {
+		[TC_UNAME_R] = "4.4.4",
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/module-from-path",
+		[TC_INIT_MODULE_RETCODES] = "",
+	},
+	.modules_loaded = "mod-simple",
+	);
+
 TESTSUITE_MAIN();
diff --git a/tools/modprobe.c b/tools/modprobe.c
index d4012fab39f8..3b7897c1b8e4 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -614,14 +614,23 @@ static int insmod(struct kmod_ctx *ctx, const char *alias,
 						const char *extra_options)
 {
 	struct kmod_list *l, *list = NULL;
+	struct kmod_module *mod = NULL;
 	int err, flags = 0;
 
-	err = kmod_module_new_from_lookup(ctx, alias, &list);
-
-	if (list == NULL || err < 0) {
-		LOG("Module %s not found in directory %s\n", alias,
-			ctx ? kmod_get_dirname(ctx) : "(missing)");
-		return -ENOENT;
+	if (strncmp(alias, "/", 1) == 0 || strncmp(alias, "./", 2) == 0) {
+		err = kmod_module_new_from_path(ctx, alias, &mod);
+		if (err < 0) {
+			LOG("Failed to get module from path %s: %s\n", alias,
+				strerror(-err));
+			return -ENOENT;
+		}
+	} else {
+		err = kmod_module_new_from_lookup(ctx, alias, &list);
+		if (list == NULL || err < 0) {
+			LOG("Module %s not found in directory %s\n", alias,
+				ctx ? kmod_get_dirname(ctx) : "(missing)");
+			return -ENOENT;
+		}
 	}
 
 	if (strip_modversion || force)
@@ -642,13 +651,18 @@ static int insmod(struct kmod_ctx *ctx, const char *alias,
 	if (first_time)
 		flags |= KMOD_PROBE_FAIL_ON_LOADED;
 
-	kmod_list_foreach(l, list) {
-		struct kmod_module *mod = kmod_module_get_module(l);
+	/* If module is loaded from path */
+	if (mod != NULL) {
 		err = insmod_insert(mod, flags, extra_options);
 		kmod_module_unref(mod);
+	} else {
+		kmod_list_foreach(l, list) {
+			mod = kmod_module_get_module(l);
+			err = insmod_insert(mod, flags, extra_options);
+			kmod_module_unref(mod);
+		}
+		kmod_module_unref_list(list);
 	}
-
-	kmod_module_unref_list(list);
 	return err;
 }
 
-- 
2.39.0

