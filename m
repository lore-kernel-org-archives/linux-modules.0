Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5EDC433E0
	for <linux-modules@archiver.kernel.org>; Fri, 12 Feb 2021 09:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A16960241
	for <linux-modules@archiver.kernel.org>; Fri, 12 Feb 2021 09:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhBLJqp (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 12 Feb 2021 04:46:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:64847 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhBLJqm (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 12 Feb 2021 04:46:42 -0500
IronPort-SDR: YRvln5xa1OdsoOn5EI+rAo9T7ejPszNsQO84NSUmucxhrVBWy//rPX1H17Z8S9Yy2FMOtdswlv
 66fMt1sqibZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="182458955"
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="182458955"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 01:46:01 -0800
IronPort-SDR: abaxuMQihDo3cfTj8tzKYXXiNIUKkdLO8b/RXsbR1Gj57HmsI+9Cuevh2ULbw0ZTDnT3Yy7vrY
 9C1y0UUqyNzw==
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="381387367"
Received: from aaramire-mobl2.amr.corp.intel.com (HELO ldmartin-desk1.intel.com) ([10.212.210.126])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 01:45:59 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 2/4] libkmod-config: re-quote option from kernel cmdline
Date:   Fri, 12 Feb 2021 01:45:22 -0800
Message-Id: <20210212094524.170861-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210212094524.170861-1-lucas.demarchi@intel.com>
References: <20210212094524.170861-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

It was reported that grub mangles the kernel cmdline. It turns

	acpi_cpufreq.dyndbg="file drivers/cpufreq/acpi-cpufreq.c +mpf"

	into

	"acpi_cpufreq.dyndbg=file drivers/cpufreq/acpi-cpufreq.c +mpf"

However, even though we could blame grub for doing that, the kernel
happily accepts and re-quotes it when the module is built-in.
So, it's better if kmod also understands it this way and does the same.

Here we basically add additional code to un-mangle it, moving the quote
in way that is acceptable to pass through init_module(). Note that the
interface [f]init_module() gives us mandates the quote to be part of the
value: the module name is not passed and the options are separated by
space.

Reported-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1181111#c10
---
 libkmod/libkmod-config.c                      | 36 ++++++++++++-
 .../module-param-kcmdline7/correct.txt        |  5 ++
 .../module-param-kcmdline7/correct.txt        |  5 ++
 .../module-param-kcmdline7/proc/cmdline       |  1 +
 .../module-param-kcmdline7/proc/cmdline       |  1 +
 .../module-param-kcmdline8/correct.txt        |  5 ++
 .../module-param-kcmdline7/correct.txt        |  5 ++
 .../module-param-kcmdline7/proc/cmdline       |  1 +
 .../module-param-kcmdline8/proc/cmdline       |  1 +
 testsuite/test-modprobe.c                     | 50 +++++++++++++++++++
 10 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline7/correct.txt
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline7/module-param-kcmdline7/correct.txt
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline7/module-param-kcmdline7/proc/cmdline
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline7/proc/cmdline
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline8/correct.txt
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline8/module-param-kcmdline7/correct.txt
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline8/module-param-kcmdline7/proc/cmdline
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline8/proc/cmdline

diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index d3cd10d..2873f06 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -498,7 +498,7 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
 {
 	char buf[KCMD_LINE_SIZE];
 	int fd, err;
-	char *p, *modname,  *param = NULL, *value = NULL;
+	char *p, *p_quote_start, *modname,  *param = NULL, *value = NULL;
 	bool is_quoted = false, iter = true;
 	enum state {
 		STATE_IGNORE,
@@ -524,10 +524,23 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
 	}
 
 	state = STATE_MODNAME;
+	p_quote_start = NULL;
 	for (p = buf, modname = buf; iter; p++) {
 		switch (*p) {
 		case '"':
 			is_quoted = !is_quoted;
+
+			/*
+			 * only allow starting quote as first char when looking
+			 * for a modname: anything else is considered ill-formed
+			 */
+			if (is_quoted && state == STATE_MODNAME && p == modname) {
+				p_quote_start = p;
+				modname = p + 1;
+			} else if (state != STATE_VALUE) {
+				state = STATE_IGNORE;
+			}
+
 			break;
 		case '\0':
 		case '\n':
@@ -550,6 +563,7 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
 				 */
 				modname = p + 1;
 				state = STATE_MODNAME;
+				p_quote_start = NULL;
 			}
 			break;
 		case '.':
@@ -576,10 +590,30 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
 		}
 
 		if (state == STATE_COMPLETE) {
+			/*
+			 * We may need to re-quote to unmangle what the
+			 * bootloader passed. Example: grub passes the option as
+			 * "parport.dyndbg=file drivers/parport/ieee1284_ops.c +mpf"
+			 * instead of
+			 * parport.dyndbg="file drivers/parport/ieee1284_ops.c +mpf"
+			 */
+			if (p_quote_start && p_quote_start < modname) {
+				/*
+				 * p_quote_start
+				 * |
+				 * |modname  param  value
+				 * ||        |      |
+				 * vv        v      v
+				 * "parport\0dyndbg=file drivers/parport/ieee1284_ops.c +mpf" */
+				memmove(p_quote_start, modname, value - modname);
+				value--; modname--; param--;
+				*value = '"';
+			}
 			kcmdline_parse_result(config, modname, param, value);
 			/* start over on next iteration */
 			modname = p + 1;
 			state = STATE_MODNAME;
+			p_quote_start = NULL;
 		}
 	}
 
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline7/correct.txt b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline7/correct.txt
new file mode 100644
index 0000000..d80da6d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline7/correct.txt
@@ -0,0 +1,5 @@
+options psmouse foo
+options parport dyndbg="file drivers/parport/ieee1284_ops.c +mpf"
+
+# End of configuration files. Dumping indexes now:
+
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline7/module-param-kcmdline7/correct.txt b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline7/module-param-kcmdline7/correct.txt
new file mode 100644
index 0000000..d80da6d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline7/module-param-kcmdline7/correct.txt
@@ -0,0 +1,5 @@
+options psmouse foo
+options parport dyndbg="file drivers/parport/ieee1284_ops.c +mpf"
+
+# End of configuration files. Dumping indexes now:
+
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline7/module-param-kcmdline7/proc/cmdline b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline7/module-param-kcmdline7/proc/cmdline
new file mode 100644
index 0000000..86f9052
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline7/module-param-kcmdline7/proc/cmdline
@@ -0,0 +1 @@
+psmouse.foo parport.dyndbg="file drivers/parport/ieee1284_ops.c +mpf" quiet rw
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline7/proc/cmdline b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline7/proc/cmdline
new file mode 100644
index 0000000..86f9052
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline7/proc/cmdline
@@ -0,0 +1 @@
+psmouse.foo parport.dyndbg="file drivers/parport/ieee1284_ops.c +mpf" quiet rw
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline8/correct.txt b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline8/correct.txt
new file mode 100644
index 0000000..d80da6d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline8/correct.txt
@@ -0,0 +1,5 @@
+options psmouse foo
+options parport dyndbg="file drivers/parport/ieee1284_ops.c +mpf"
+
+# End of configuration files. Dumping indexes now:
+
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline8/module-param-kcmdline7/correct.txt b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline8/module-param-kcmdline7/correct.txt
new file mode 100644
index 0000000..d80da6d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline8/module-param-kcmdline7/correct.txt
@@ -0,0 +1,5 @@
+options psmouse foo
+options parport dyndbg="file drivers/parport/ieee1284_ops.c +mpf"
+
+# End of configuration files. Dumping indexes now:
+
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline8/module-param-kcmdline7/proc/cmdline b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline8/module-param-kcmdline7/proc/cmdline
new file mode 100644
index 0000000..86f9052
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline8/module-param-kcmdline7/proc/cmdline
@@ -0,0 +1 @@
+psmouse.foo parport.dyndbg="file drivers/parport/ieee1284_ops.c +mpf" quiet rw
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline8/proc/cmdline b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline8/proc/cmdline
new file mode 100644
index 0000000..eab04ad
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline8/proc/cmdline
@@ -0,0 +1 @@
+psmouse.foo "parport.dyndbg=file drivers/parport/ieee1284_ops.c +mpf" quiet rw
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index f6bed8b..dbc54f3 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -359,6 +359,56 @@ DEFINE_TEST(modprobe_param_kcmdline6,
 	);
 
 
+static noreturn int modprobe_param_kcmdline7(const struct test *t)
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
+DEFINE_TEST(modprobe_param_kcmdline7,
+	.description = "check if dots on other parts of kcmdline don't confuse our parser",
+	.config = {
+		[TC_UNAME_R] = "4.4.4",
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/module-param-kcmdline7",
+	},
+	.output = {
+		.out = TESTSUITE_ROOTFS "test-modprobe/module-param-kcmdline7/correct.txt",
+	},
+	.modules_loaded = "",
+	);
+
+
+static noreturn int modprobe_param_kcmdline8(const struct test *t)
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
+DEFINE_TEST(modprobe_param_kcmdline8,
+	.description = "check if dots on other parts of kcmdline don't confuse our parser",
+	.config = {
+		[TC_UNAME_R] = "4.4.4",
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/module-param-kcmdline8",
+	},
+	.output = {
+		.out = TESTSUITE_ROOTFS "test-modprobe/module-param-kcmdline8/correct.txt",
+	},
+	.modules_loaded = "",
+	);
+
+
 static noreturn int modprobe_force(const struct test *t)
 {
 	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
-- 
2.30.0

