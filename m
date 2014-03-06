Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43797 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224AbaCFOFj (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 6 Mar 2014 09:05:39 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <linux-modules@vger.kernel.org>
CC: Michal Marek <mmarek@suse.cz>
Subject: [PATCH 1/8] testsuite: add test for kcmdline params with no value
Date: Thu, 6 Mar 2014 11:06:42 -0300
Message-ID: <1394114809-2737-1-git-send-email-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Use "modprobe -c" to dump the configuration. Since we configure our
rootfs to have only a /proc/cmdline file, this should dump the knowledge
we have from its parsed content.

Test if <module>.option, without any value is correctly parsed, as fixed
in commit 493dc65 ("libkmod: Fix getting param with no value from kcmdline")
---
 .../module-param-kcmdline2/correct.txt             |  5 +++++
 .../module-param-kcmdline2/proc/cmdline            |  1 +
 testsuite/test-modprobe.c                          | 25 ++++++++++++++++++++++
 3 files changed, 31 insertions(+)
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline2/correct.txt
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline2/proc/cmdline

diff --git a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline2/correct.txt b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline2/correct.txt
new file mode 100644
index 0000000..b73a680
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline2/correct.txt
@@ -0,0 +1,5 @@
+options psmouse foo
+options psmouse bar=1
+
+# End of configuration files. Dumping indexes now:
+
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline2/proc/cmdline b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline2/proc/cmdline
new file mode 100644
index 0000000..f048fdd
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline2/proc/cmdline
@@ -0,0 +1 @@
+psmouse.foo psmouse.bar=1 quiet rw
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index b675f48..492b4d8 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -187,6 +187,30 @@ static DEFINE_TEST(modprobe_param_kcmdline,
 	.modules_loaded = "",
 	);
 
+static noreturn int modprobe_param_kcmdline2(const struct test *t)
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
+static DEFINE_TEST(modprobe_param_kcmdline2,
+	.description = "check if params with no value are parsed correctly from kcmdline",
+	.config = {
+		[TC_UNAME_R] = "4.4.4",
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/module-param-kcmdline2",
+	},
+	.output = {
+		.out = TESTSUITE_ROOTFS "test-modprobe/module-param-kcmdline2/correct.txt",
+	},
+	.modules_loaded = "",
+	);
+
 static noreturn int modprobe_force(const struct test *t)
 {
 	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
@@ -262,6 +286,7 @@ static const struct test *tests[] = {
 	&smodprobe_softdep_loop,
 	&smodprobe_install_cmd_loop,
 	&smodprobe_param_kcmdline,
+	&smodprobe_param_kcmdline2,
 	&smodprobe_force,
 	&smodprobe_oldkernel,
 	&smodprobe_oldkernel_force,
-- 
1.9.0

