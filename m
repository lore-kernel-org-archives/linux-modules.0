Return-Path: <SRS0=Ow/D=43=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E832BC18E5A
	for <linux-modules@archiver.kernel.org>; Tue, 10 Mar 2020 08:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96EA24677
	for <linux-modules@archiver.kernel.org>; Tue, 10 Mar 2020 08:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgCJIZQ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 10 Mar 2020 04:25:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:27664 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgCJIZQ (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 10 Mar 2020 04:25:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 01:25:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="231245736"
Received: from ldmartin1-desk.jf.intel.com ([10.165.21.151])
  by orsmga007.jf.intel.com with ESMTP; 10 Mar 2020 01:25:15 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     joao.moreira@intel.com, leandro.maciel.dorileo@intel.com,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 2/2] testsuite: check for ill-formed kcmdline
Date:   Tue, 10 Mar 2020 01:23:08 -0700
Message-Id: <20200310082308.14318-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310082308.14318-1-lucas.demarchi@intel.com>
References: <20200310082308.14318-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Commit ca3bf5d47cec ("iommu/amd: Introduces ivrs_acpihid kernel parameter")
in the kernel introduced an ill-formed kernel parameter, ivrs_acpihid.
The problem is that it may have a dot on the key side:
"ivrs_acpihid[00:14.5]=AMD0020:0". This could potentially trip our
parser of module options, but right now it's working as intended: the
only thing that happens is that after deciding "ivrs_acpihid[00:14" is a
module name, it will fail the underscores() routine and the option will
be ignored from the kmod pov (not kernel's pov since that driver parsers
the kernel command line by itself).
---
 .../module-param-kcmdline6/correct.txt        |  6 +++++
 .../module-param-kcmdline6/proc/cmdline       |  1 +
 testsuite/test-modprobe.c                     | 25 +++++++++++++++++++
 3 files changed, 32 insertions(+)
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline6/correct.txt
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline6/proc/cmdline

diff --git a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline6/correct.txt b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline6/correct.txt
new file mode 100644
index 0000000..7a087ef
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline6/correct.txt
@@ -0,0 +1,6 @@
+options psmouse foo=2
+options psmouse bar=1
+options psmouse zinga=test
+
+# End of configuration files. Dumping indexes now:
+
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline6/proc/cmdline b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline6/proc/cmdline
new file mode 100644
index 0000000..14bbd2e
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline6/proc/cmdline
@@ -0,0 +1 @@
+psmouse.foo=2 ivrs_acpihid[14:00.5]=AMD0020:00 psmouse.bar=1 psmouse.zinga=test
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index 1cace82..f908d56 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -328,6 +328,31 @@ DEFINE_TEST(modprobe_param_kcmdline5,
 	);
 
 
+static noreturn int modprobe_param_kcmdline6(const struct test *t)
+{
+	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
+	const char *const args[] = {
+		progname,
+		"-c",
+		NULL,
+	};
+
+	test_spawn_prog(progname, args);
+	exit(EXIT_FAILURE);
+}
+DEFINE_TEST(modprobe_param_kcmdline6,
+	.description = "check if dots on other parts of kcmdline don't confuse our parser",
+	.config = {
+		[TC_UNAME_R] = "4.4.4",
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/module-param-kcmdline6",
+	},
+	.output = {
+		.out = TESTSUITE_ROOTFS "test-modprobe/module-param-kcmdline6/correct.txt",
+	},
+	.modules_loaded = "",
+	);
+
+
 static noreturn int modprobe_force(const struct test *t)
 {
 	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
-- 
2.25.1

