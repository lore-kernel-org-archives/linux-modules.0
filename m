Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21470 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262AbaCFOFz (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 6 Mar 2014 09:05:55 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <linux-modules@vger.kernel.org>
CC: Michal Marek <mmarek@suse.cz>
Subject: [PATCH 4/8] testsuite: add test for '.' correctly parsed in param's value
Date: Thu, 6 Mar 2014 11:06:45 -0300
Message-ID: <1394114809-2737-4-git-send-email-lucas.demarchi@intel.com>
In-Reply-To: <1394114809-2737-1-git-send-email-lucas.demarchi@intel.com>
References: <1394114809-2737-1-git-send-email-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

In kcmdline it's possible to have a dot in the param's value. The
support for this was added in 66f3228 ("libkmod: Add support for '.' in
module parameter on kcmdline") and is needed to correctly support some
modules that depend on it.

This test was added in order to make sure the commit  aa87854
("libkmod-config: Only match dot before '=' in /proc/cmdline") didn't
break it. Although that commit  message says it's allowing to match a
dot before '=' it's actually enforcing the first part of the string to
be always in the format "<module-name>.param". Dots after '=' are still
correctly allowed.
---
 .../module-param-kcmdline4/correct.txt             |  4 ++++
 .../module-param-kcmdline4/proc/cmdline            |  1 +
 testsuite/test-modprobe.c                          | 25 ++++++++++++++++++++++
 3 files changed, 30 insertions(+)
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline4/correct.txt
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline4/proc/cmdline

diff --git a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline4/correct.txt b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline4/correct.txt
new file mode 100644
index 0000000..60fa483
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline4/correct.txt
@@ -0,0 +1,4 @@
+options testmodule testparam=1.5G
+
+# End of configuration files. Dumping indexes now:
+
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline4/proc/cmdline b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline4/proc/cmdline
new file mode 100644
index 0000000..c460c5e
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline4/proc/cmdline
@@ -0,0 +1 @@
+testmodule.testparam=1.5G
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index e5bd925..d7663e6 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -235,6 +235,30 @@ static DEFINE_TEST(modprobe_param_kcmdline3,
 	.modules_loaded = "",
 	);
 
+static noreturn int modprobe_param_kcmdline4(const struct test *t)
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
+static DEFINE_TEST(modprobe_param_kcmdline4,
+	.description = "check if unrelated strings in kcmdline are correctly ignored",
+	.config = {
+		[TC_UNAME_R] = "4.4.4",
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/module-param-kcmdline4",
+	},
+	.output = {
+		.out = TESTSUITE_ROOTFS "test-modprobe/module-param-kcmdline4/correct.txt",
+	},
+	.modules_loaded = "",
+	);
+
 static noreturn int modprobe_force(const struct test *t)
 {
 	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
@@ -312,6 +336,7 @@ static const struct test *tests[] = {
 	&smodprobe_param_kcmdline,
 	&smodprobe_param_kcmdline2,
 	&smodprobe_param_kcmdline3,
+	&smodprobe_param_kcmdline4,
 	&smodprobe_force,
 	&smodprobe_oldkernel,
 	&smodprobe_oldkernel_force,
-- 
1.9.0

