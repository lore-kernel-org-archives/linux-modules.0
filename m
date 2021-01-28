Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B63FC433E6
	for <linux-modules@archiver.kernel.org>; Thu, 28 Jan 2021 14:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B9A64DE7
	for <linux-modules@archiver.kernel.org>; Thu, 28 Jan 2021 14:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhA1Oub (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 28 Jan 2021 09:50:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:26930 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232419AbhA1Osb (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 28 Jan 2021 09:48:31 -0500
IronPort-SDR: s9H0jwzcJnaw5w80lmOQv9w1OeCry5Hq/RwrIBQXT1QQooI2cqCCGo5KZnm4RccB/5Ueac+dAH
 WuzRxl+LiSMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="176735464"
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="176735464"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 06:47:50 -0800
IronPort-SDR: xZN6WznY0ER+HVQR+FUedwCGAX33yEeI/6NbobhXjMZ+FiHh0xsO8QNvCgMPSLT4ZZMzE40E3/
 /DUKMUfoD/kg==
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="505330567"
Received: from tnachmax-mobl1.ger.corp.intel.com (HELO ldmartin-desk1.intel.com) ([10.213.186.171])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 06:47:47 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Petr Vorel <petr.vorel@gmail.com>
Subject: [PATCH 2/2] testsuite: move zstd-compressed module to a separate test
Date:   Thu, 28 Jan 2021 06:47:24 -0800
Message-Id: <20210128144724.102147-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210128144724.102147-1-lucas.demarchi@intel.com>
References: <20210128144724.102147-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Move it to a separate test so we can skip it if zstd is not enabled at
build time.
---
 testsuite/populate-modules.sh                 |  4 +--
 .../lib/modules/4.4.4/correct-modules.alias   | 17 +++++++++++
 .../lib/modules/4.4.4/modules.builtin         |  0
 .../lib/modules/4.4.4/modules.order           |  2 ++
 .../lib/modules/4.4.4/correct-modules.alias   | 16 ----------
 .../lib/modules/4.4.4/modules.order           |  3 --
 testsuite/test-depmod.c                       | 30 +++++++++++++++++++
 7 files changed, 51 insertions(+), 21 deletions(-)
 create mode 100644 testsuite/rootfs-pristine/test-depmod/modules-order-compressed-zstd/lib/modules/4.4.4/correct-modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-depmod/modules-order-compressed-zstd/lib/modules/4.4.4/modules.builtin
 create mode 100644 testsuite/rootfs-pristine/test-depmod/modules-order-compressed-zstd/lib/modules/4.4.4/modules.order

diff --git a/testsuite/populate-modules.sh b/testsuite/populate-modules.sh
index b0cc932..22d207c 100755
--- a/testsuite/populate-modules.sh
+++ b/testsuite/populate-modules.sh
@@ -51,8 +51,8 @@ map=(
     ["test-modprobe/module-param-kcmdline/lib/modules/4.4.4/kernel/"]="mod-simple.ko"
     ["test-modprobe/external/lib/modules/external/"]="mod-simple.ko"
     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/block/cciss.ko"]="mod-fake-cciss.ko"
-    ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/hpsa.ko"]="mod-fake-hpsa.ko"
     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/scsi_mod.ko"]="mod-fake-scsi-mod.ko"
+    ["test-depmod/modules-order-compressed-zstd/lib/modules/4.4.4/kernel/drivers/scsi/hpsa.ko"]="mod-fake-hpsa.ko"
     ["test-modinfo/mod-simple-i386.ko"]="mod-simple-i386.ko"
     ["test-modinfo/mod-simple-x86_64.ko"]="mod-simple-x86_64.ko"
     ["test-modinfo/mod-simple-sparc64.ko"]="mod-simple-sparc64.ko"
@@ -70,7 +70,7 @@ gzip_array=(
     )
 
 zstd_array=(
-    "test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/hpsa.ko"
+    "test-depmod/modules-order-compressed-zstd/lib/modules/4.4.4/kernel/drivers/scsi/hpsa.ko"
     )
 
 attach_sha256_array=(
diff --git a/testsuite/rootfs-pristine/test-depmod/modules-order-compressed-zstd/lib/modules/4.4.4/correct-modules.alias b/testsuite/rootfs-pristine/test-depmod/modules-order-compressed-zstd/lib/modules/4.4.4/correct-modules.alias
new file mode 100644
index 0000000..8542d25
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-depmod/modules-order-compressed-zstd/lib/modules/4.4.4/correct-modules.alias
@@ -0,0 +1,17 @@
+# Aliases extracted from modules themselves.
+alias pci:v0000103Cd*sv*sd*bc01sc04i* hpsa
+alias pci:v0000103Cd0000323Bsv0000103Csd00003356bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Bsv0000103Csd00003355bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Bsv0000103Csd00003354bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Bsv0000103Csd00003353bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Bsv0000103Csd00003352bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Bsv0000103Csd00003351bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Bsv0000103Csd00003350bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Asv0000103Csd00003233bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Asv0000103Csd0000324Bbc*sc*i* hpsa
+alias pci:v0000103Cd0000323Asv0000103Csd0000324Abc*sc*i* hpsa
+alias pci:v0000103Cd0000323Asv0000103Csd00003249bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Asv0000103Csd00003247bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Asv0000103Csd00003245bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Asv0000103Csd00003243bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Asv0000103Csd00003241bc*sc*i* hpsa
diff --git a/testsuite/rootfs-pristine/test-depmod/modules-order-compressed-zstd/lib/modules/4.4.4/modules.builtin b/testsuite/rootfs-pristine/test-depmod/modules-order-compressed-zstd/lib/modules/4.4.4/modules.builtin
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-depmod/modules-order-compressed-zstd/lib/modules/4.4.4/modules.order b/testsuite/rootfs-pristine/test-depmod/modules-order-compressed-zstd/lib/modules/4.4.4/modules.order
new file mode 100644
index 0000000..c8b8102
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-depmod/modules-order-compressed-zstd/lib/modules/4.4.4/modules.order
@@ -0,0 +1,2 @@
+#2137
+kernel/drivers/scsi/hpsa.ko
diff --git a/testsuite/rootfs-pristine/test-depmod/modules-order-compressed/lib/modules/4.4.4/correct-modules.alias b/testsuite/rootfs-pristine/test-depmod/modules-order-compressed/lib/modules/4.4.4/correct-modules.alias
index 5675329..0ac4ea2 100644
--- a/testsuite/rootfs-pristine/test-depmod/modules-order-compressed/lib/modules/4.4.4/correct-modules.alias
+++ b/testsuite/rootfs-pristine/test-depmod/modules-order-compressed/lib/modules/4.4.4/correct-modules.alias
@@ -19,19 +19,3 @@ alias pci:v00000E11d0000B178sv00000E11sd00004083bc*sc*i* cciss
 alias pci:v00000E11d0000B178sv00000E11sd00004082bc*sc*i* cciss
 alias pci:v00000E11d0000B178sv00000E11sd00004080bc*sc*i* cciss
 alias pci:v00000E11d0000B060sv00000E11sd00004070bc*sc*i* cciss
-alias pci:v0000103Cd*sv*sd*bc01sc04i* hpsa
-alias pci:v0000103Cd0000323Bsv0000103Csd00003356bc*sc*i* hpsa
-alias pci:v0000103Cd0000323Bsv0000103Csd00003355bc*sc*i* hpsa
-alias pci:v0000103Cd0000323Bsv0000103Csd00003354bc*sc*i* hpsa
-alias pci:v0000103Cd0000323Bsv0000103Csd00003353bc*sc*i* hpsa
-alias pci:v0000103Cd0000323Bsv0000103Csd00003352bc*sc*i* hpsa
-alias pci:v0000103Cd0000323Bsv0000103Csd00003351bc*sc*i* hpsa
-alias pci:v0000103Cd0000323Bsv0000103Csd00003350bc*sc*i* hpsa
-alias pci:v0000103Cd0000323Asv0000103Csd00003233bc*sc*i* hpsa
-alias pci:v0000103Cd0000323Asv0000103Csd0000324Bbc*sc*i* hpsa
-alias pci:v0000103Cd0000323Asv0000103Csd0000324Abc*sc*i* hpsa
-alias pci:v0000103Cd0000323Asv0000103Csd00003249bc*sc*i* hpsa
-alias pci:v0000103Cd0000323Asv0000103Csd00003247bc*sc*i* hpsa
-alias pci:v0000103Cd0000323Asv0000103Csd00003245bc*sc*i* hpsa
-alias pci:v0000103Cd0000323Asv0000103Csd00003243bc*sc*i* hpsa
-alias pci:v0000103Cd0000323Asv0000103Csd00003241bc*sc*i* hpsa
diff --git a/testsuite/rootfs-pristine/test-depmod/modules-order-compressed/lib/modules/4.4.4/modules.order b/testsuite/rootfs-pristine/test-depmod/modules-order-compressed/lib/modules/4.4.4/modules.order
index 4b64309..47a10c4 100644
--- a/testsuite/rootfs-pristine/test-depmod/modules-order-compressed/lib/modules/4.4.4/modules.order
+++ b/testsuite/rootfs-pristine/test-depmod/modules-order-compressed/lib/modules/4.4.4/modules.order
@@ -2,6 +2,3 @@
 kernel/drivers/block/cciss.ko
 #2094
 kernel/drivers/scsi/scsi_mod.ko
-#2137
-kernel/drivers/scsi/hpsa.ko
-
diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
index d52602d..299162c 100644
--- a/testsuite/test-depmod.c
+++ b/testsuite/test-depmod.c
@@ -28,6 +28,8 @@
 #define MODULES_ORDER_UNAME "4.4.4"
 #define MODULES_ORDER_ROOTFS TESTSUITE_ROOTFS "test-depmod/modules-order-compressed"
 #define MODULES_ORDER_LIB_MODULES MODULES_ORDER_ROOTFS "/lib/modules/" MODULES_ORDER_UNAME
+#define MODULES_ORDER_ROOTFS_ZSTD TESTSUITE_ROOTFS "test-depmod/modules-order-compressed-zstd"
+#define MODULES_ORDER_LIB_MODULES_ZSTD MODULES_ORDER_ROOTFS_ZSTD "/lib/modules/" MODULES_ORDER_UNAME
 static noreturn int depmod_modules_order_for_compressed(const struct test *t)
 {
 	const char *progname = ABS_TOP_BUILDDIR "/tools/depmod";
@@ -57,7 +59,35 @@ DEFINE_TEST(depmod_modules_order_for_compressed,
 			{ }
 		},
 	});
+
+static noreturn int depmod_modules_order_for_compressed_zstd(const struct test *t)
+{
+	const char *progname = ABS_TOP_BUILDDIR "/tools/depmod";
+	const char *const args[] = {
+		progname,
+		NULL,
+	};
+
+	test_spawn_prog(progname, args);
+	exit(EXIT_FAILURE);
+}
+DEFINE_TEST(depmod_modules_order_for_compressed_zstd,
+#if defined(KMOD_SYSCONFDIR_NOT_ETC) || \
+    !defined(ENABLE_ZSTD)
+        .skip = true,
 #endif
+	.description = "check if depmod let aliases in right order when using compressed modules (ZSTD)",
+	.config = {
+		[TC_UNAME_R] = MODULES_ORDER_UNAME,
+		[TC_ROOTFS] = MODULES_ORDER_ROOTFS_ZSTD,
+	},
+	.output = {
+		.files = (const struct keyval[]) {
+			{ MODULES_ORDER_LIB_MODULES_ZSTD "/correct-modules.alias",
+			  MODULES_ORDER_LIB_MODULES_ZSTD "/modules.alias" },
+			{ }
+		},
+	});
 
 #define SEARCH_ORDER_SIMPLE_ROOTFS TESTSUITE_ROOTFS "test-depmod/search-order-simple"
 static noreturn int depmod_search_order_simple(const struct test *t)
-- 
2.30.0

