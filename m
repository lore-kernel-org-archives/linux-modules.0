Return-Path: <SRS0=A0aH=NY=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53939C43441
	for <linux-modules@archiver.kernel.org>; Tue, 13 Nov 2018 18:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189E821780
	for <linux-modules@archiver.kernel.org>; Tue, 13 Nov 2018 18:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189E821780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeKNEqL (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:46:11 -0500
Received: from mga07.intel.com ([134.134.136.100]:33605 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbeKNEqL (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 13 Nov 2018 23:46:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 10:46:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,229,1539673200"; 
   d="scan'208";a="89013170"
Received: from ldmartin-desk.jf.intel.com ([10.24.10.170])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2018 10:46:48 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     ykaliuta@redhat.com
Subject: [PATCH] testsuite: add simple test for --show-exports
Date:   Tue, 13 Nov 2018 10:46:40 -0800
Message-Id: <20181113184640.3671-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.19.1.1.g56c4683e68
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

---
 testsuite/populate-modules.sh                 |  1 +
 .../test-modprobe/show-exports/correct.txt    |  1 +
 testsuite/test-modprobe.c                     | 22 +++++++++++++++++++
 3 files changed, 24 insertions(+)
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/show-exports/correct.txt

diff --git a/testsuite/populate-modules.sh b/testsuite/populate-modules.sh
index b77e71e..ba68a69 100755
--- a/testsuite/populate-modules.sh
+++ b/testsuite/populate-modules.sh
@@ -39,6 +39,7 @@ map=(
     ["test-modprobe/show-depends/lib/modules/4.4.4/kernel/mod-loop-a.ko"]="mod-loop-a.ko"
     ["test-modprobe/show-depends/lib/modules/4.4.4/kernel/mod-loop-b.ko"]="mod-loop-b.ko"
     ["test-modprobe/show-depends/lib/modules/4.4.4/kernel/mod-simple.ko"]="mod-simple.ko"
+    ["test-modprobe/show-exports/mod-loop-a.ko"]="mod-loop-a.ko"
     ["test-modprobe/softdep-loop/lib/modules/4.4.4/kernel/mod-loop-a.ko"]="mod-loop-a.ko"
     ["test-modprobe/softdep-loop/lib/modules/4.4.4/kernel/mod-loop-b.ko"]="mod-loop-b.ko"
     ["test-modprobe/install-cmd-loop/lib/modules/4.4.4/kernel/mod-loop-a.ko"]="mod-loop-a.ko"
diff --git a/testsuite/rootfs-pristine/test-modprobe/show-exports/correct.txt b/testsuite/rootfs-pristine/test-modprobe/show-exports/correct.txt
new file mode 100644
index 0000000..bc2d045
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/show-exports/correct.txt
@@ -0,0 +1 @@
+0x00000000	printA
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index ee9d82d..52a6621 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -95,6 +95,28 @@ DEFINE_TEST(modprobe_show_alias_to_none,
 	);
 
 
+static noreturn int modprobe_show_exports(const struct test *t)
+{
+	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
+	const char *const args[] = {
+		progname,
+		"--show-exports", "--quiet", "/mod-loop-a.ko",
+		NULL,
+	};
+
+	test_spawn_prog(progname, args);
+	exit(EXIT_FAILURE);
+}
+DEFINE_TEST(modprobe_show_exports,
+	.description = "check if modprobe --show-depends doesn't explode with an alias to nothing",
+	.config = {
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/show-exports",
+	},
+	.output = {
+		.out = TESTSUITE_ROOTFS "test-modprobe/show-exports/correct.txt",
+	});
+
+
 static noreturn int modprobe_builtin(const struct test *t)
 {
 	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
-- 
2.19.1.1.g56c4683e68

