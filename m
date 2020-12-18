Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF46C2BBD5
	for <linux-modules@archiver.kernel.org>; Fri, 18 Dec 2020 16:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE1E23B6C
	for <linux-modules@archiver.kernel.org>; Fri, 18 Dec 2020 16:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgLRQDk (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:03:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:59254 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbgLRQDk (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 18 Dec 2020 11:03:40 -0500
IronPort-SDR: fSOcrBOIsVv77HARsRr7FDdAFGIiYdv6ImtGZTaqJOBF708x7vMLEyihfaSnsVME2Ojry735tM
 sEjKB3H0q1jg==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="155257960"
X-IronPort-AV: E=Sophos;i="5.78,430,1599548400"; 
   d="scan'208";a="155257960"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 08:02:16 -0800
IronPort-SDR: xkXqq/v5j94fmSWB+w56EQyXc8qHGf/36h/xlxE5BV4plMZsUHfzweIVfu79x+JIzC9XH988ZP
 V6J0soknvVyw==
X-IronPort-AV: E=Sophos;i="5.78,430,1599548400"; 
   d="scan'208";a="388582588"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 08:02:15 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Joe Buehler <aspam@cox.net>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH 3/3] testsuite: add test for empty modules.builtin.aliases.bin
Date:   Fri, 18 Dec 2020 08:02:09 -0800
Message-Id: <20201218160209.4037174-4-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218160209.4037174-1-lucas.demarchi@intel.com>
References: <20201218160209.4037174-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

---
 .../lib/modules/5.6.0/modules.alias                |   1 +
 .../lib/modules/5.6.0/modules.alias.bin            | Bin 0 -> 12 bytes
 .../lib/modules/5.6.0/modules.builtin              |   1 +
 .../lib/modules/5.6.0/modules.builtin.alias.bin    | Bin 0 -> 12 bytes
 .../lib/modules/5.6.0/modules.builtin.bin          | Bin 0 -> 39 bytes
 .../lib/modules/5.6.0/modules.dep                  |   0
 .../lib/modules/5.6.0/modules.dep.bin              | Bin 0 -> 12 bytes
 .../lib/modules/5.6.0/modules.devname              |   1 +
 .../lib/modules/5.6.0/modules.softdep              |   1 +
 .../lib/modules/5.6.0/modules.symbols              |   1 +
 .../lib/modules/5.6.0/modules.symbols.bin          | Bin 0 -> 12 bytes
 testsuite/test-init.c                              |   9 ++++++++-
 12 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.builtin
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.builtin.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.symbols.bin

diff --git a/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.alias b/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.alias
new file mode 100644
index 0000000..ba76e18
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.alias
@@ -0,0 +1 @@
+# Aliases extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.alias.bin b/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.alias.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.builtin b/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.builtin
new file mode 100644
index 0000000..1cbec61
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.builtin
@@ -0,0 +1 @@
+kernel/fake_builtin.ko
diff --git a/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.builtin.alias.bin b/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.builtin.alias.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.builtin.bin b/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.builtin.bin
new file mode 100644
index 0000000000000000000000000000000000000000..0423f039013b88f58bce7a26d4086974e5a8b96a
GIT binary patch
literal 39
qcmdnM{w17&iGfjpfk81bJ2gJ3G&83pGmilX7(oO>TG{~y1|9&t?g(c9

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.dep b/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.dep
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.dep.bin b/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.dep.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.devname b/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.devname
new file mode 100644
index 0000000..58f6d6d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.devname
@@ -0,0 +1 @@
+# Device nodes to trigger on-demand module loading.
diff --git a/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.softdep b/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.softdep
new file mode 100644
index 0000000..5554ccc
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.softdep
@@ -0,0 +1 @@
+# Soft dependencies extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.symbols b/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.symbols
new file mode 100644
index 0000000..618c345
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.symbols
@@ -0,0 +1 @@
+# Aliases for symbols, used by symbol_request().
diff --git a/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.symbols.bin b/testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.symbols.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/test-init.c b/testsuite/test-init.c
index 3a69b43..edbfc23 100644
--- a/testsuite/test-init.c
+++ b/testsuite/test-init.c
@@ -52,13 +52,20 @@ static noreturn int test_load_resources(const struct test *t)
 	exit(EXIT_SUCCESS);
 }
 DEFINE_TEST(test_load_resources,
-	    .description = "test if kmod_load_resources works",
+	    .description = "test if kmod_load_resources works (recent modprobe on kernel without modules.builtin.modinfo)",
 	    .config = {
 		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-init-load-resources/",
 		[TC_UNAME_R] = "5.6.0",
 	    },
 	    .need_spawn = true);
 
+DEFINE_TEST(test_load_resources,
+	    .description = "test if kmod_load_resources works with empty modules.builtin.aliases.bin (recent depmod on kernel without modules.builtin.modinfo)",
+	    .config = {
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-init-load-resources-empty-builtin-aliases-bin/",
+		[TC_UNAME_R] = "5.6.0",
+	    },
+	    .need_spawn = true);
 
 static noreturn int test_initlib(const struct test *t)
 {
-- 
2.29.2

