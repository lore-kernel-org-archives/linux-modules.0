Return-Path: <SRS0=Ow/D=43=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89DFC18E7A
	for <linux-modules@archiver.kernel.org>; Tue, 10 Mar 2020 05:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93EF2467D
	for <linux-modules@archiver.kernel.org>; Tue, 10 Mar 2020 05:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgCJFBm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 10 Mar 2020 01:01:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:60672 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgCJFBm (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 10 Mar 2020 01:01:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 22:01:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="353525592"
Received: from ldmartin1-desk.jf.intel.com ([10.165.21.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2020 22:01:40 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Yanko Kaneti <yaneti@declera.com>, gladkov.alexey@gmail.com,
        auke-jan.h.kok@intel.com,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6/6] testsuite: add check for kmod_load_resources
Date:   Mon,  9 Mar 2020 22:00:29 -0700
Message-Id: <20200310050029.27678-7-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310050029.27678-1-lucas.demarchi@intel.com>
References: <20200310050029.27678-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Make sure we can call kmod_load_resources when we do have all the
mandatory indexes in place.
---
 .../lib/modules/5.6.0/modules.alias           |   1 +
 .../lib/modules/5.6.0/modules.alias.bin       | Bin 0 -> 12 bytes
 .../lib/modules/5.6.0/modules.builtin         |   1 +
 .../lib/modules/5.6.0/modules.builtin.bin     | Bin 0 -> 39 bytes
 .../lib/modules/5.6.0/modules.dep             |   0
 .../lib/modules/5.6.0/modules.dep.bin         | Bin 0 -> 12 bytes
 .../lib/modules/5.6.0/modules.devname         |   1 +
 .../lib/modules/5.6.0/modules.softdep         |   1 +
 .../lib/modules/5.6.0/modules.symbols         |   1 +
 .../lib/modules/5.6.0/modules.symbols.bin     | Bin 0 -> 12 bytes
 testsuite/test-init.c                         |  31 ++++++++++++++++++
 11 files changed, 36 insertions(+)
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.builtin
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.symbols.bin

diff --git a/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.alias b/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.alias
new file mode 100644
index 0000000..ba76e18
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.alias
@@ -0,0 +1 @@
+# Aliases extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.alias.bin b/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.alias.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.builtin b/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.builtin
new file mode 100644
index 0000000..1cbec61
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.builtin
@@ -0,0 +1 @@
+kernel/fake_builtin.ko
diff --git a/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.builtin.bin b/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.builtin.bin
new file mode 100644
index 0000000000000000000000000000000000000000..0423f039013b88f58bce7a26d4086974e5a8b96a
GIT binary patch
literal 39
qcmdnM{w17&iGfjpfk81bJ2gJ3G&83pGmilX7(oO>TG{~y1|9&t?g(c9

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.dep b/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.dep
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.dep.bin b/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.dep.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.devname b/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.devname
new file mode 100644
index 0000000..58f6d6d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.devname
@@ -0,0 +1 @@
+# Device nodes to trigger on-demand module loading.
diff --git a/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.softdep b/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.softdep
new file mode 100644
index 0000000..5554ccc
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.softdep
@@ -0,0 +1 @@
+# Soft dependencies extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.symbols b/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.symbols
new file mode 100644
index 0000000..618c345
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.symbols
@@ -0,0 +1 @@
+# Aliases for symbols, used by symbol_request().
diff --git a/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.symbols.bin b/testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.symbols.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/test-init.c b/testsuite/test-init.c
index 9651280..3a69b43 100644
--- a/testsuite/test-init.c
+++ b/testsuite/test-init.c
@@ -29,6 +29,37 @@
 
 #include "testsuite.h"
 
+static noreturn int test_load_resources(const struct test *t)
+{
+	struct kmod_ctx *ctx;
+	const char *null_config = NULL;
+	int err;
+
+	ctx = kmod_new(NULL, &null_config);
+	if (ctx == NULL)
+		exit(EXIT_FAILURE);
+
+	kmod_set_log_priority(ctx, 7);
+
+	err = kmod_load_resources(ctx);
+	if (err != 0) {
+		ERR("could not load libkmod resources: %s\n", strerror(-err));
+		exit(EXIT_FAILURE);
+	}
+
+	kmod_unref(ctx);
+
+	exit(EXIT_SUCCESS);
+}
+DEFINE_TEST(test_load_resources,
+	    .description = "test if kmod_load_resources works",
+	    .config = {
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-init-load-resources/",
+		[TC_UNAME_R] = "5.6.0",
+	    },
+	    .need_spawn = true);
+
+
 static noreturn int test_initlib(const struct test *t)
 {
 	struct kmod_ctx *ctx;
-- 
2.25.1

