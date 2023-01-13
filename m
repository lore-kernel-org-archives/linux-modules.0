Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214A9C3DA78
	for <linux-modules@archiver.kernel.org>; Fri, 13 Jan 2023 21:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjAMViG (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 13 Jan 2023 16:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAMViE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 13 Jan 2023 16:38:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4C088DF4
        for <linux-modules@vger.kernel.org>; Fri, 13 Jan 2023 13:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673645881; x=1705181881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lfGA5H0t2bc3Zk2g/vZDwNP6H7WkC3vw9DtyuQ/CnmM=;
  b=UhhFWBLPvdCeKnE9L6WsfcsngWFQZT/+cqaKtbHaGUFHGtctQyC4ZnzN
   uoQpL8VXXwVPwH7/27PTmNCDJKKKIb/relkCgEiq2cT/3IATTMxKBktZI
   i/R3TVG4ssU3aOfGJ7LvEUXUE9txPIhHnrSRPjefSLgeGi9cHnjV4rqgv
   Kp4pMuyQ63kFyLzmw78+QnrkmRht2Vw87Cwcs4C/iaJZg59F6LXRubtUc
   i4/unh5ypHMSH9CR2CY/Hs9v6CtSJ0UxBvVQjRpD07Deex4NH7P/RXlk1
   PDdb+6LZZmq5nAYhZlp9pTjy6upfuYPRhB2vEKq43I5G98C2J/RSTCSrw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="307661055"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="307661055"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:37:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="800725275"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="800725275"
Received: from kcknighx-mobl.amr.corp.intel.com (HELO gjsousa-mobl2.intel.com) ([10.212.91.228])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:37:57 -0800
From:   Gustavo Sousa <gustavo.sousa@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>
Subject: [PATCH v2 3/3] modprobe: Allow passing path to module
Date:   Fri, 13 Jan 2023 18:37:45 -0300
Message-Id: <20230113213745.227703-4-gustavo.sousa@intel.com>
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

v2:
  - Add test for relative path as well. (Lucas)
  - Add note warning about modules with dependencies not matching the
    installed depmod database. (Lucas)

Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
---
 man/modprobe.xml                              |   7 +++
 testsuite/populate-modules.sh                 |   2 +
 .../lib/modules/4.4.4/modules.alias           |   1 +
 .../lib/modules/4.4.4/modules.alias.bin       | Bin 0 -> 12 bytes
 .../lib/modules/4.4.4/modules.builtin.bin     |   0
 .../lib/modules/4.4.4/modules.dep             |   1 +
 .../lib/modules/4.4.4/modules.dep.bin         | Bin 0 -> 73 bytes
 .../lib/modules/4.4.4/modules.devname         |   0
 .../lib/modules/4.4.4/modules.softdep         |   1 +
 .../lib/modules/4.4.4/modules.symbols         |   1 +
 .../lib/modules/4.4.4/modules.symbols.bin     | Bin 0 -> 12 bytes
 .../module-from-abspath/proc/modules          |   0
 .../lib/modules/4.4.4/modules.alias           |   1 +
 .../lib/modules/4.4.4/modules.alias.bin       | Bin 0 -> 12 bytes
 .../lib/modules/4.4.4/modules.builtin.bin     |   0
 .../lib/modules/4.4.4/modules.dep             |   1 +
 .../lib/modules/4.4.4/modules.dep.bin         | Bin 0 -> 73 bytes
 .../lib/modules/4.4.4/modules.devname         |   0
 .../lib/modules/4.4.4/modules.softdep         |   1 +
 .../lib/modules/4.4.4/modules.symbols         |   1 +
 .../lib/modules/4.4.4/modules.symbols.bin     | Bin 0 -> 12 bytes
 .../module-from-relpath/proc/modules          |   0
 testsuite/test-modprobe.c                     |  50 ++++++++++++++++++
 tools/modprobe.c                              |  34 ++++++++----
 24 files changed, 91 insertions(+), 10 deletions(-)
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.symbols.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/proc/modules
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.symbols.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/proc/modules

diff --git a/man/modprobe.xml b/man/modprobe.xml
index db39c7a18bb7..91f9e27997cd 100644
--- a/man/modprobe.xml
+++ b/man/modprobe.xml
@@ -115,6 +115,13 @@
       kernel (in addition to any options listed in the configuration
       file).
     </para>
+    <para>
+      When loading modules, <replaceable>modulename</replaceable> can also
+      be a path to the module. If the path is relative, it must
+      explicitly start with "./". Note that this may fail when using a
+      path to a module with dependencies not matching the installed depmod
+      database.
+    </para>
   </refsect1>
 
   <refsect1><title>OPTIONS</title>
diff --git a/testsuite/populate-modules.sh b/testsuite/populate-modules.sh
index 099f02669156..aa6d5c28fb0f 100755
--- a/testsuite/populate-modules.sh
+++ b/testsuite/populate-modules.sh
@@ -56,6 +56,8 @@ map=(
     ["test-modprobe/alias-to-none/lib/modules/4.4.4/kernel/"]="mod-simple.ko"
     ["test-modprobe/module-param-kcmdline/lib/modules/4.4.4/kernel/"]="mod-simple.ko"
     ["test-modprobe/external/lib/modules/external/"]="mod-simple.ko"
+    ["test-modprobe/module-from-abspath/home/foo/"]="mod-simple.ko"
+    ["test-modprobe/module-from-relpath/home/foo/"]="mod-simple.ko"
     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/block/cciss.ko"]="mod-fake-cciss.ko"
     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/hpsa.ko"]="mod-fake-hpsa.ko"
     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/scsi_mod.ko"]="mod-fake-scsi-mod.ko"
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.alias b/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.alias
new file mode 100644
index 000000000000..ba76e1815af0
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.alias
@@ -0,0 +1 @@
+# Aliases extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.alias.bin b/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.alias.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.builtin.bin b/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.builtin.bin
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.dep b/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.dep
new file mode 100644
index 000000000000..e612900c5de7
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.dep
@@ -0,0 +1 @@
+/lib/modules/external/mod-simple.ko:
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.dep.bin b/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.dep.bin
new file mode 100644
index 0000000000000000000000000000000000000000..556e3c8142d5d85dba5b557474907f9f9dd99dcb
GIT binary patch
literal 73
zcmdnM{w17&iGfjpfx$UHCB8T_w;(5#0SFjDgnmwDl74P}N@-4Nv3_brNorAEVh%_^
S7ot!vJKu^SH}?Po0}lY-ZWUAj

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.devname b/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.devname
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.softdep b/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.softdep
new file mode 100644
index 000000000000..5554ccca7f9e
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.softdep
@@ -0,0 +1 @@
+# Soft dependencies extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.symbols b/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.symbols
new file mode 100644
index 000000000000..618c345f7e93
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.symbols
@@ -0,0 +1 @@
+# Aliases for symbols, used by symbol_request().
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.symbols.bin b/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.symbols.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/proc/modules b/testsuite/rootfs-pristine/test-modprobe/module-from-abspath/proc/modules
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.alias b/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.alias
new file mode 100644
index 000000000000..ba76e1815af0
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.alias
@@ -0,0 +1 @@
+# Aliases extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.alias.bin b/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.alias.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.builtin.bin b/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.builtin.bin
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.dep b/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.dep
new file mode 100644
index 000000000000..e612900c5de7
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.dep
@@ -0,0 +1 @@
+/lib/modules/external/mod-simple.ko:
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.dep.bin b/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.dep.bin
new file mode 100644
index 0000000000000000000000000000000000000000..556e3c8142d5d85dba5b557474907f9f9dd99dcb
GIT binary patch
literal 73
zcmdnM{w17&iGfjpfx$UHCB8T_w;(5#0SFjDgnmwDl74P}N@-4Nv3_brNorAEVh%_^
S7ot!vJKu^SH}?Po0}lY-ZWUAj

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.devname b/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.devname
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.softdep b/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.softdep
new file mode 100644
index 000000000000..5554ccca7f9e
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.softdep
@@ -0,0 +1 @@
+# Soft dependencies extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.symbols b/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.symbols
new file mode 100644
index 000000000000..618c345f7e93
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.symbols
@@ -0,0 +1 @@
+# Aliases for symbols, used by symbol_request().
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.symbols.bin b/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.symbols.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/proc/modules b/testsuite/rootfs-pristine/test-modprobe/module-from-relpath/proc/modules
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index 0255f1aaccb5..3ddb976d920a 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -422,4 +422,54 @@ DEFINE_TEST(modprobe_external,
 	.modules_loaded = "mod-simple",
 	);
 
+static noreturn int modprobe_module_from_abspath(const struct test *t)
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
+DEFINE_TEST(modprobe_module_from_abspath,
+	.description = "check modprobe able to load module given as an absolute path",
+	.config = {
+		[TC_UNAME_R] = "4.4.4",
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/module-from-abspath",
+		[TC_INIT_MODULE_RETCODES] = "",
+	},
+	.modules_loaded = "mod-simple",
+	);
+
+static noreturn int modprobe_module_from_relpath(const struct test *t)
+{
+	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
+	const char *const args[] = {
+		progname,
+		"./mod-simple.ko",
+		NULL,
+	};
+
+	if (chdir("/home/foo") != 0) {
+		perror("failed to change into /home/foo");
+		exit(EXIT_FAILURE);
+	}
+
+	test_spawn_prog(progname, args);
+	exit(EXIT_FAILURE);
+}
+DEFINE_TEST(modprobe_module_from_relpath,
+	.description = "check modprobe able to load module given as a relative path",
+	.config = {
+		[TC_UNAME_R] = "4.4.4",
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/module-from-relpath",
+		[TC_INIT_MODULE_RETCODES] = "",
+	},
+	.need_spawn = true,
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

