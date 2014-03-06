Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21955 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282AbaCFOFy (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 6 Mar 2014 09:05:54 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <linux-modules@vger.kernel.org>
CC: Michal Marek <mmarek@suse.cz>
Subject: [PATCH 3/8] testsuite: add test to ignore unrelated strings in kcmdline
Date: Thu, 6 Mar 2014 11:06:44 -0300
Message-ID: <1394114809-2737-3-git-send-email-lucas.demarchi@intel.com>
In-Reply-To: <1394114809-2737-1-git-send-email-lucas.demarchi@intel.com>
References: <1394114809-2737-1-git-send-email-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Strings unrelated to modules and modprobe should be ignored and not
appear in the output of "modprobe -c".

This adds a test for the fix provided in aa87854 ("libkmod-config: Only
match dot before '=' in /proc/cmdline").
---
 .../module-param-kcmdline3/correct.txt             |  5 +++++
 .../module-param-kcmdline3/proc/cmdline            |  1 +
 testsuite/test-modprobe.c                          | 25 ++++++++++++++++++++++
 3 files changed, 31 insertions(+)
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline3/correct.txt
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline3/proc/cmdline

diff --git a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline3/correct.txt b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline3/correct.txt
new file mode 100644
index 0000000..b73a680
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline3/correct.txt
@@ -0,0 +1,5 @@
+options psmouse foo
+options psmouse bar=1
+
+# End of configuration files. Dumping indexes now:
+
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline3/proc/cmdline b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline3/proc/cmdline
new file mode 100644
index 0000000..3575bb1
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline3/proc/cmdline
@@ -0,0 +1 @@
+BOOT_IMAGE=/boot/vmlinuz-3.12.12-57.g5f654cf-default initrd=\initramfs-linux.img psmouse.foo psmouse.bar=1 root=/dev/sda2 rootfstype=ext4 add_efi_memmap quiet rw
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index b5eaba3..e5bd925 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -211,6 +211,30 @@ static DEFINE_TEST(modprobe_param_kcmdline2,
 	.modules_loaded = "",
 	);
 
+static noreturn int modprobe_param_kcmdline3(const struct test *t)
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
+static DEFINE_TEST(modprobe_param_kcmdline3,
+	.description = "check if unrelated strings in kcmdline are correctly ignored",
+	.config = {
+		[TC_UNAME_R] = "4.4.4",
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/module-param-kcmdline3",
+	},
+	.output = {
+		.out = TESTSUITE_ROOTFS "test-modprobe/module-param-kcmdline3/correct.txt",
+	},
+	.modules_loaded = "",
+	);
+
 static noreturn int modprobe_force(const struct test *t)
 {
 	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
@@ -287,6 +311,7 @@ static const struct test *tests[] = {
 	&smodprobe_install_cmd_loop,
 	&smodprobe_param_kcmdline,
 	&smodprobe_param_kcmdline2,
+	&smodprobe_param_kcmdline3,
 	&smodprobe_force,
 	&smodprobe_oldkernel,
 	&smodprobe_oldkernel_force,
-- 
1.9.0

