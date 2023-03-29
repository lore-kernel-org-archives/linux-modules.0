Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3359CC761A6
	for <linux-modules@archiver.kernel.org>; Wed, 29 Mar 2023 13:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjC2NwF (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 29 Mar 2023 09:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjC2NwE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 29 Mar 2023 09:52:04 -0400
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA33BC4
        for <linux-modules@vger.kernel.org>; Wed, 29 Mar 2023 06:51:55 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Wed, 29 Mar 2023 15:51:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1680097911; bh=nTc23p4K9zCI44KAwWGHGu2um4zhL21JFzoiQa4F/sg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Ffv8+xHgHtrmTPVXrIkXO/Dul8a/nV74jq+F1mFpg2YGc/CcVbYtN9CP9YouPPmBu
         4yvqh6lagQSc+n+i6HEHm1ghHjKfkDsqq/tedP8JvszcqVvGWFj/FxHWifhsdo5IPU
         4xLUJWlBgWTndDCiBXAEGgobuNmbXSzUPxCOkqmA=
Received: from island.ads.avm.de (unknown [172.17.88.185])
        by mail-auth.avm.de (Postfix) with ESMTPA id 78A8681FC4;
        Wed, 29 Mar 2023 15:51:51 +0200 (CEST)
Received: from island.fjasle.eu (localhost [IPv6:::1])
        by island.ads.avm.de (Postfix) with ESMTP id 68C22521A0C;
        Wed, 29 Mar 2023 15:51:51 +0200 (CEST)
From:   Nicolas Schier <n.schier@avm.de>
Date:   Wed, 29 Mar 2023 15:51:37 +0200
Subject: [PATCH v2 3/3] testsuite: modprobe: Add test for --remove-holders
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230309-remove-holders-recursively-v2-3-8a8120269cc1@avm.de>
References: <20230309-remove-holders-recursively-v2-0-8a8120269cc1@avm.de>
In-Reply-To: <20230309-remove-holders-recursively-v2-0-8a8120269cc1@avm.de>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Nicolas Schier <nicolas@fjasle.eu>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=67800; i=n.schier@avm.de;
 h=from:subject:message-id; bh=nTc23p4K9zCI44KAwWGHGu2um4zhL21JFzoiQa4F/sg=;
 b=owEBbQKS/ZANAwAIAYjGvJyImm24AcsmYgBkJEJ3QPremLJmRuPogni6byBonJ8Qivwb9Dyuz
 Fi2Ws5/feuJAjMEAAEIAB0WIQQO/4WJ63TpgecLpGmIxryciJptuAUCZCRCdwAKCRCIxryciJpt
 uCHwD/wMOyCEO6phva28kgXqPqH+w7w815eskPSv3HkVAsSMIPpoQ53wQqtNUbssw8Uz27w/3XT
 fAWIh4WzXE+rstPOFAA8qRKy3QjbsxEyFKZKmnOb9bHkcUYj34kcPGzy27MSE0Pw6b097yunYF7
 UKSMlVs1BptC30mokp4o5NvjX9PmNDqdYMeNTULQuc8D1O7MmY2ooVbfVeAHErCDG+EIGoLE3KJ
 1A6WtX4kOEQmVO1Im62trDi5sVq7YrzeEXi6faaIMvth56jUV4rubadN2Pjo5rpLfu7dyFGhBna
 /H3V+xb7vEhAP1S739hYqq9TSxe5962327tE1AgFDC55o+Zjo+ONIuomRXd0tuNLxg7c4zsT6kY
 /Aa1b5PFMGnko165Z+Xx9vt9NT5KFFMu2yls+t7fQK0jc1sq9U4ProwV0u1+pj2szkh1k7GHGrf
 x0wb6kImbz5PhZEDiVuN5fMZib8NhRluaC1b3ahDDEzeC6slrxL1PczMzCbPIL/nlqB4zeIzasJ
 z+jbxskxPX5j4MLFcS99Y9YdNpsBEfEgjyaiJlk+LyFNjzvymkGKeIIV2qcfLcrv1+8OTUuLPCa
 ua233HK7RuHng+NOfGflYMaudXwrIRwIMiLKp41C31zaZPiVx7uJfHrkJE25DH/FISlmKeBce1Y
 sn91QDN/Y16AcOg==
X-Developer-Key: i=n.schier@avm.de; a=openpgp;
 fpr=7CF67EF8868721AFE53D73FDBDE3A6CC4E333CC8
X-purgate-ID: 149429::1680097910-53FEDE5F-7904BE2E/0/0
X-purgate-type: clean
X-purgate-size: 67802
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Add a test for 'modprobe --remove --remove-holders' and a simple
dependency module chain of three modules.

Signed-off-by: Nicolas Schier <n.schier@avm.de>
---
Changes in v2:
  * new patch
---
 testsuite/module-playground/Makefile               |   6 +++
 testsuite/module-playground/mod-dep-chain-a.c      |  21 ++++++++
 testsuite/module-playground/mod-dep-chain-b.c      |  22 +++++++++
 testsuite/module-playground/mod-dep-chain-c.c      |  22 +++++++++
 testsuite/module-playground/mod-dep-chain.h        |   8 +++
 .../remove-holders/lib/modules/6.2/modules.alias   |   1 +
 .../lib/modules/6.2/modules.alias.bin              | Bin 0 -> 12 bytes
 .../lib/modules/6.2/modules.builtin.alias.bin      |   0
 .../lib/modules/6.2/modules.builtin.bin            |   0
 .../remove-holders/lib/modules/6.2/modules.dep     |   3 ++
 .../remove-holders/lib/modules/6.2/modules.dep.bin | Bin 0 -> 229 bytes
 .../remove-holders/lib/modules/6.2/modules.devname |   0
 .../remove-holders/lib/modules/6.2/modules.softdep |   1 +
 .../remove-holders/lib/modules/6.2/modules.symbols |   4 ++
 .../lib/modules/6.2/modules.symbols.bin            | Bin 0 -> 143 bytes
 .../test-modprobe/remove-holders/proc/modules      |   3 ++
 .../sys/module/mod_dep_chain_a/coresize            |   1 +
 .../module/mod_dep_chain_a/holders/mod_dep_chain_b |   1 +
 .../sys/module/mod_dep_chain_a/initsize            |   1 +
 .../sys/module/mod_dep_chain_a/initstate           |   1 +
 .../sys/module/mod_dep_chain_a/notes/.note.Linux   | Bin 0 -> 60 bytes
 .../mod_dep_chain_a/notes/.note.gnu.build-id       | Bin 0 -> 36 bytes
 .../sys/module/mod_dep_chain_a/refcnt              |   1 +
 .../sections/.gnu.linkonce.this_module             |   1 +
 .../sys/module/mod_dep_chain_a/sections/.init.data |   1 +
 .../module/mod_dep_chain_a/sections/.note.Linux    |   1 +
 .../mod_dep_chain_a/sections/.note.gnu.build-id    |   1 +
 .../module/mod_dep_chain_a/sections/.orc_unwind    |   1 +
 .../module/mod_dep_chain_a/sections/.orc_unwind_ip |   1 +
 .../module/mod_dep_chain_a/sections/.return_sites  |   1 +
 .../module/mod_dep_chain_a/sections/.rodata.str1.1 |   1 +
 .../sys/module/mod_dep_chain_a/sections/.strtab    |   1 +
 .../sys/module/mod_dep_chain_a/sections/.symtab    |   1 +
 .../module/mod_dep_chain_a/sections/.text.unlikely |   1 +
 .../sys/module/mod_dep_chain_a/sections/__kcrctab  |   1 +
 .../sys/module/mod_dep_chain_a/sections/__ksymtab  |   1 +
 .../mod_dep_chain_a/sections/__ksymtab_strings     |   1 +
 .../module/mod_dep_chain_a/sections/__mcount_loc   |   1 +
 .../sys/module/mod_dep_chain_a/taint               |   1 +
 .../sys/module/mod_dep_chain_b/coresize            |   1 +
 .../module/mod_dep_chain_b/holders/mod_dep_chain_c |   1 +
 .../sys/module/mod_dep_chain_b/initsize            |   1 +
 .../sys/module/mod_dep_chain_b/initstate           |   1 +
 .../sys/module/mod_dep_chain_b/notes/.note.Linux   | Bin 0 -> 60 bytes
 .../mod_dep_chain_b/notes/.note.gnu.build-id       | Bin 0 -> 36 bytes
 .../sys/module/mod_dep_chain_b/refcnt              |   1 +
 .../sections/.gnu.linkonce.this_module             |   1 +
 .../sys/module/mod_dep_chain_b/sections/.init.data |   1 +
 .../module/mod_dep_chain_b/sections/.note.Linux    |   1 +
 .../mod_dep_chain_b/sections/.note.gnu.build-id    |   1 +
 .../module/mod_dep_chain_b/sections/.orc_unwind    |   1 +
 .../module/mod_dep_chain_b/sections/.orc_unwind_ip |   1 +
 .../module/mod_dep_chain_b/sections/.return_sites  |   1 +
 .../module/mod_dep_chain_b/sections/.rodata.str1.8 |   1 +
 .../sys/module/mod_dep_chain_b/sections/.strtab    |   1 +
 .../sys/module/mod_dep_chain_b/sections/.symtab    |   1 +
 .../module/mod_dep_chain_b/sections/.text.unlikely |   1 +
 .../sys/module/mod_dep_chain_b/sections/__kcrctab  |   1 +
 .../sys/module/mod_dep_chain_b/sections/__ksymtab  |   1 +
 .../mod_dep_chain_b/sections/__ksymtab_strings     |   1 +
 .../module/mod_dep_chain_b/sections/__mcount_loc   |   1 +
 .../sys/module/mod_dep_chain_b/taint               |   1 +
 .../sys/module/mod_dep_chain_c/coresize            |   1 +
 .../sys/module/mod_dep_chain_c/holders/.gitignore  |   0
 .../sys/module/mod_dep_chain_c/initsize            |   1 +
 .../sys/module/mod_dep_chain_c/initstate           |   1 +
 .../sys/module/mod_dep_chain_c/notes/.note.Linux   | Bin 0 -> 60 bytes
 .../mod_dep_chain_c/notes/.note.gnu.build-id       | Bin 0 -> 36 bytes
 .../sys/module/mod_dep_chain_c/refcnt              |   1 +
 .../sys/module/mod_dep_chain_c/taint               |   1 +
 .../remove-single/lib/modules/6.2/modules.alias    |   1 +
 .../lib/modules/6.2/modules.alias.bin              | Bin 0 -> 12 bytes
 .../lib/modules/6.2/modules.builtin.alias.bin      |   0
 .../lib/modules/6.2/modules.builtin.bin            |   0
 .../remove-single/lib/modules/6.2/modules.dep      |   3 ++
 .../remove-single/lib/modules/6.2/modules.dep.bin  | Bin 0 -> 229 bytes
 .../remove-single/lib/modules/6.2/modules.devname  |   0
 .../remove-single/lib/modules/6.2/modules.softdep  |   1 +
 .../remove-single/lib/modules/6.2/modules.symbols  |   4 ++
 .../lib/modules/6.2/modules.symbols.bin            | Bin 0 -> 143 bytes
 .../test-modprobe/remove-single/proc/modules       |   3 ++
 .../sys/module/mod_dep_chain_a/coresize            |   1 +
 .../module/mod_dep_chain_a/holders/mod_dep_chain_b |   1 +
 .../sys/module/mod_dep_chain_a/initsize            |   1 +
 .../sys/module/mod_dep_chain_a/initstate           |   1 +
 .../sys/module/mod_dep_chain_a/notes/.note.Linux   | Bin 0 -> 60 bytes
 .../mod_dep_chain_a/notes/.note.gnu.build-id       | Bin 0 -> 36 bytes
 .../sys/module/mod_dep_chain_a/refcnt              |   1 +
 .../sections/.gnu.linkonce.this_module             |   1 +
 .../sys/module/mod_dep_chain_a/sections/.init.data |   1 +
 .../module/mod_dep_chain_a/sections/.note.Linux    |   1 +
 .../mod_dep_chain_a/sections/.note.gnu.build-id    |   1 +
 .../module/mod_dep_chain_a/sections/.orc_unwind    |   1 +
 .../module/mod_dep_chain_a/sections/.orc_unwind_ip |   1 +
 .../module/mod_dep_chain_a/sections/.return_sites  |   1 +
 .../module/mod_dep_chain_a/sections/.rodata.str1.1 |   1 +
 .../sys/module/mod_dep_chain_a/sections/.strtab    |   1 +
 .../sys/module/mod_dep_chain_a/sections/.symtab    |   1 +
 .../module/mod_dep_chain_a/sections/.text.unlikely |   1 +
 .../sys/module/mod_dep_chain_a/sections/__kcrctab  |   1 +
 .../sys/module/mod_dep_chain_a/sections/__ksymtab  |   1 +
 .../mod_dep_chain_a/sections/__ksymtab_strings     |   1 +
 .../module/mod_dep_chain_a/sections/__mcount_loc   |   1 +
 .../remove-single/sys/module/mod_dep_chain_a/taint |   1 +
 .../sys/module/mod_dep_chain_b/coresize            |   1 +
 .../module/mod_dep_chain_b/holders/mod_dep_chain_c |   1 +
 .../sys/module/mod_dep_chain_b/initsize            |   1 +
 .../sys/module/mod_dep_chain_b/initstate           |   1 +
 .../sys/module/mod_dep_chain_b/notes/.note.Linux   | Bin 0 -> 60 bytes
 .../mod_dep_chain_b/notes/.note.gnu.build-id       | Bin 0 -> 36 bytes
 .../sys/module/mod_dep_chain_b/refcnt              |   1 +
 .../sections/.gnu.linkonce.this_module             |   1 +
 .../sys/module/mod_dep_chain_b/sections/.init.data |   1 +
 .../module/mod_dep_chain_b/sections/.note.Linux    |   1 +
 .../mod_dep_chain_b/sections/.note.gnu.build-id    |   1 +
 .../module/mod_dep_chain_b/sections/.orc_unwind    |   1 +
 .../module/mod_dep_chain_b/sections/.orc_unwind_ip |   1 +
 .../module/mod_dep_chain_b/sections/.return_sites  |   1 +
 .../module/mod_dep_chain_b/sections/.rodata.str1.8 |   1 +
 .../sys/module/mod_dep_chain_b/sections/.strtab    |   1 +
 .../sys/module/mod_dep_chain_b/sections/.symtab    |   1 +
 .../module/mod_dep_chain_b/sections/.text.unlikely |   1 +
 .../sys/module/mod_dep_chain_b/sections/__kcrctab  |   1 +
 .../sys/module/mod_dep_chain_b/sections/__ksymtab  |   1 +
 .../mod_dep_chain_b/sections/__ksymtab_strings     |   1 +
 .../module/mod_dep_chain_b/sections/__mcount_loc   |   1 +
 .../remove-single/sys/module/mod_dep_chain_b/taint |   1 +
 .../sys/module/mod_dep_chain_c/coresize            |   1 +
 .../sys/module/mod_dep_chain_c/holders/.gitignore  |   0
 .../sys/module/mod_dep_chain_c/initsize            |   1 +
 .../sys/module/mod_dep_chain_c/initstate           |   1 +
 .../sys/module/mod_dep_chain_c/notes/.note.Linux   | Bin 0 -> 60 bytes
 .../mod_dep_chain_c/notes/.note.gnu.build-id       | Bin 0 -> 36 bytes
 .../sys/module/mod_dep_chain_c/refcnt              |   1 +
 .../remove-single/sys/module/mod_dep_chain_c/taint |   1 +
 testsuite/setup-rootfs.sh                          |   3 ++
 testsuite/test-modprobe.c                          |  55 +++++++++++++++++++++
 137 files changed, 255 insertions(+)

diff --git a/testsuite/module-playground/Makefile b/testsuite/module-playground/Makefile
index e6045b0..970822b 100644
--- a/testsuite/module-playground/Makefile
+++ b/testsuite/module-playground/Makefile
@@ -37,6 +37,12 @@ obj-m += mod-fake-hpsa.o
 obj-m += mod-fake-scsi-mod.o
 obj-m += mod-fake-cciss.o
 
+# mod-dep-chain-*: simple dependency chain:
+# mod-dep-chain-c depends on mod-dep-chain-b, which depends on mod-dep-chain-a
+obj-m += mod-dep-chain-a.o
+obj-m += mod-dep-chain-b.o
+obj-m += mod-dep-chain-c.o
+
 else
 # only build ARCH-specific module
 ifeq ($(ARCH),)
diff --git a/testsuite/module-playground/mod-dep-chain-a.c b/testsuite/module-playground/mod-dep-chain-a.c
new file mode 100644
index 0000000..a3dd896
--- /dev/null
+++ b/testsuite/module-playground/mod-dep-chain-a.c
@@ -0,0 +1,21 @@
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include "mod-dep-chain.h"
+
+void mod_dep_chain_a_info(void)
+{
+	pr_info("loaded\n");
+}
+EXPORT_SYMBOL(mod_dep_chain_a_info);
+
+static int mod_dep_chain_a_init(void)
+{
+	mod_dep_chain_a_info();
+	return 0;
+}
+
+module_init(mod_dep_chain_a_init);
+
+MODULE_AUTHOR("Nicolas Schier <n.schier@avm.de>");
+MODULE_LICENSE("LGPL");
diff --git a/testsuite/module-playground/mod-dep-chain-b.c b/testsuite/module-playground/mod-dep-chain-b.c
new file mode 100644
index 0000000..3d71d0f
--- /dev/null
+++ b/testsuite/module-playground/mod-dep-chain-b.c
@@ -0,0 +1,22 @@
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include "mod-dep-chain.h"
+
+void mod_dep_chain_b_info(void)
+{
+	pr_info("loaded and depends on mod-dep-chain-a\n");
+	mod_dep_chain_a_info();
+}
+EXPORT_SYMBOL(mod_dep_chain_b_info);
+
+static int mod_dep_chain_b_init(void)
+{
+	mod_dep_chain_b_info();
+	return 0;
+}
+
+module_init(mod_dep_chain_b_init);
+
+MODULE_AUTHOR("Nicolas Schier <n.schier@avm.de>");
+MODULE_LICENSE("LGPL");
diff --git a/testsuite/module-playground/mod-dep-chain-c.c b/testsuite/module-playground/mod-dep-chain-c.c
new file mode 100644
index 0000000..862ce84
--- /dev/null
+++ b/testsuite/module-playground/mod-dep-chain-c.c
@@ -0,0 +1,22 @@
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include "mod-dep-chain.h"
+
+void mod_dep_chain_c_info(void)
+{
+	pr_info("loaded and depends on mod-dep-chain-b\n");
+	mod_dep_chain_b_info();
+}
+EXPORT_SYMBOL(mod_dep_chain_c_info);
+
+static int mod_dep_chain_c_init(void)
+{
+	mod_dep_chain_c_info();
+	return 0;
+}
+
+module_init(mod_dep_chain_c_init);
+
+MODULE_AUTHOR("Nicolas Schier <n.schier@avm.de>");
+MODULE_LICENSE("LGPL");
diff --git a/testsuite/module-playground/mod-dep-chain.h b/testsuite/module-playground/mod-dep-chain.h
new file mode 100644
index 0000000..0bfc26f
--- /dev/null
+++ b/testsuite/module-playground/mod-dep-chain.h
@@ -0,0 +1,8 @@
+#ifndef __mod_dep_chain_h__
+#define __mod_dep_chain_h__
+
+extern void mod_dep_chain_a_info(void);
+extern void mod_dep_chain_b_info(void);
+extern void mod_dep_chain_c_info(void);
+
+#endif
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.alias b/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.alias
new file mode 100644
index 0000000..ba76e18
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.alias
@@ -0,0 +1 @@
+# Aliases extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.alias.bin b/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.alias.bin
new file mode 100644
index 0000000..7075435
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.alias.bin differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.builtin.alias.bin b/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.builtin.alias.bin
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.builtin.bin b/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.builtin.bin
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.dep b/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.dep
new file mode 100644
index 0000000..8248cf7
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.dep
@@ -0,0 +1,3 @@
+kernel/mod-dep-chain-a.ko:
+kernel/mod-dep-chain-b.ko: kernel/mod-dep-chain-a.ko
+kernel/mod-dep-chain-c.ko: kernel/mod-dep-chain-b.ko kernel/mod-dep-chain-a.ko
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.dep.bin b/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.dep.bin
new file mode 100644
index 0000000..f8b999d
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.dep.bin differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.devname b/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.devname
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.softdep b/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.softdep
new file mode 100644
index 0000000..5554ccc
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.softdep
@@ -0,0 +1 @@
+# Soft dependencies extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.symbols b/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.symbols
new file mode 100644
index 0000000..84263a6
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.symbols
@@ -0,0 +1,4 @@
+# Aliases for symbols, used by symbol_request().
+alias symbol:mod_dep_chain_a_info mod_dep_chain_a
+alias symbol:mod_dep_chain_c_info mod_dep_chain_c
+alias symbol:mod_dep_chain_b_info mod_dep_chain_b
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.symbols.bin b/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.symbols.bin
new file mode 100644
index 0000000..b246e9d
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/remove-holders/lib/modules/6.2/modules.symbols.bin differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/proc/modules b/testsuite/rootfs-pristine/test-modprobe/remove-holders/proc/modules
new file mode 100644
index 0000000..5929acb
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/proc/modules
@@ -0,0 +1,3 @@
+mod_dep_chain_c 16384 0 [permanent], Live 0x0000000000000000 (POE)
+mod_dep_chain_b 16384 1 mod_dep_chain_c,[permanent], Live 0x0000000000000000 (POE)
+mod_dep_chain_a 16384 1 mod_dep_chain_b,[permanent], Live 0x0000000000000000 (POE)
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/coresize b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/coresize
new file mode 100644
index 0000000..08558e4
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/coresize
@@ -0,0 +1 @@
+16384
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/holders/mod_dep_chain_b b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/holders/mod_dep_chain_b
new file mode 120000
index 0000000..e26fe25
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/holders/mod_dep_chain_b
@@ -0,0 +1 @@
+../../mod_dep_chain_b
\ No newline at end of file
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/initsize b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/initsize
new file mode 100644
index 0000000..573541a
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/initsize
@@ -0,0 +1 @@
+0
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/initstate b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/initstate
new file mode 100644
index 0000000..e23fe64
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/initstate
@@ -0,0 +1 @@
+live
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/notes/.note.Linux b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/notes/.note.Linux
new file mode 100644
index 0000000..183aed9
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/notes/.note.Linux differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/notes/.note.gnu.build-id b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/notes/.note.gnu.build-id
new file mode 100644
index 0000000..fcfdc7f
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/notes/.note.gnu.build-id differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/refcnt b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/refcnt
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/refcnt
@@ -0,0 +1 @@
+1
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.gnu.linkonce.this_module b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.gnu.linkonce.this_module
new file mode 100644
index 0000000..bcc5ba6
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.gnu.linkonce.this_module
@@ -0,0 +1 @@
+0xffffffffc10fa000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.init.data b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.init.data
new file mode 100644
index 0000000..de75dee
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.init.data
@@ -0,0 +1 @@
+0xffffffffc034d000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.note.Linux b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.note.Linux
new file mode 100644
index 0000000..c8513b9
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.note.Linux
@@ -0,0 +1 @@
+0xffffffffc10f9024
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.note.gnu.build-id b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.note.gnu.build-id
new file mode 100644
index 0000000..8cbe085
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.note.gnu.build-id
@@ -0,0 +1 @@
+0xffffffffc10f9000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.orc_unwind b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.orc_unwind
new file mode 100644
index 0000000..7987d4e
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.orc_unwind
@@ -0,0 +1 @@
+0xffffffffc10f90b5
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.orc_unwind_ip b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.orc_unwind_ip
new file mode 100644
index 0000000..12cda4f
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.orc_unwind_ip
@@ -0,0 +1 @@
+0xffffffffc10f90c1
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.return_sites b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.return_sites
new file mode 100644
index 0000000..cff4d30
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.return_sites
@@ -0,0 +1 @@
+0xffffffffc10f90b1
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.rodata.str1.1 b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.rodata.str1.1
new file mode 100644
index 0000000..a670b59
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.rodata.str1.1
@@ -0,0 +1 @@
+0xffffffffc10f9086
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.strtab b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.strtab
new file mode 100644
index 0000000..2905428
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.strtab
@@ -0,0 +1 @@
+0xffffffffc034e4e0
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.symtab b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.symtab
new file mode 100644
index 0000000..38b02ed
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.symtab
@@ -0,0 +1 @@
+0xffffffffc034e000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.text.unlikely b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.text.unlikely
new file mode 100644
index 0000000..0f8c361
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/.text.unlikely
@@ -0,0 +1 @@
+0xffffffffc10f8000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/__kcrctab b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/__kcrctab
new file mode 100644
index 0000000..83cf0eb
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/__kcrctab
@@ -0,0 +1 @@
+0xffffffffc10f906c
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/__ksymtab b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/__ksymtab
new file mode 100644
index 0000000..8a160a3
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/__ksymtab
@@ -0,0 +1 @@
+0xffffffffc10f9060
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/__ksymtab_strings b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/__ksymtab_strings
new file mode 100644
index 0000000..ed9d78d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/__ksymtab_strings
@@ -0,0 +1 @@
+0xffffffffc10f9070
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/__mcount_loc b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/__mcount_loc
new file mode 100644
index 0000000..b6ddb2f
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/sections/__mcount_loc
@@ -0,0 +1 @@
+0xffffffffc10f90a1
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/taint b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/taint
new file mode 100644
index 0000000..fed7ca6
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_a/taint
@@ -0,0 +1 @@
+POE
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/coresize b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/coresize
new file mode 100644
index 0000000..08558e4
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/coresize
@@ -0,0 +1 @@
+16384
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/holders/mod_dep_chain_c b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/holders/mod_dep_chain_c
new file mode 120000
index 0000000..9100cb1
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/holders/mod_dep_chain_c
@@ -0,0 +1 @@
+../../mod_dep_chain_c
\ No newline at end of file
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/initsize b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/initsize
new file mode 100644
index 0000000..573541a
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/initsize
@@ -0,0 +1 @@
+0
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/initstate b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/initstate
new file mode 100644
index 0000000..e23fe64
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/initstate
@@ -0,0 +1 @@
+live
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/notes/.note.Linux b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/notes/.note.Linux
new file mode 100644
index 0000000..183aed9
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/notes/.note.Linux differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/notes/.note.gnu.build-id b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/notes/.note.gnu.build-id
new file mode 100644
index 0000000..673a782
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/notes/.note.gnu.build-id differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/refcnt b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/refcnt
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/refcnt
@@ -0,0 +1 @@
+1
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.gnu.linkonce.this_module b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.gnu.linkonce.this_module
new file mode 100644
index 0000000..8048b8f
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.gnu.linkonce.this_module
@@ -0,0 +1 @@
+0xffffffffc10ff000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.init.data b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.init.data
new file mode 100644
index 0000000..de75dee
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.init.data
@@ -0,0 +1 @@
+0xffffffffc034d000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.note.Linux b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.note.Linux
new file mode 100644
index 0000000..b451fc5
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.note.Linux
@@ -0,0 +1 @@
+0xffffffffc10fe024
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.note.gnu.build-id b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.note.gnu.build-id
new file mode 100644
index 0000000..b10979d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.note.gnu.build-id
@@ -0,0 +1 @@
+0xffffffffc10fe000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.orc_unwind b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.orc_unwind
new file mode 100644
index 0000000..5dc94f4
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.orc_unwind
@@ -0,0 +1 @@
+0xffffffffc10fe0d6
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.orc_unwind_ip b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.orc_unwind_ip
new file mode 100644
index 0000000..4dd4220
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.orc_unwind_ip
@@ -0,0 +1 @@
+0xffffffffc10fe0e2
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.return_sites b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.return_sites
new file mode 100644
index 0000000..74defae
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.return_sites
@@ -0,0 +1 @@
+0xffffffffc10fe0d2
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.rodata.str1.8 b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.rodata.str1.8
new file mode 100644
index 0000000..18b3917
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.rodata.str1.8
@@ -0,0 +1 @@
+0xffffffffc10fe088
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.strtab b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.strtab
new file mode 100644
index 0000000..a51ce15
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.strtab
@@ -0,0 +1 @@
+0xffffffffc034e4f8
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.symtab b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.symtab
new file mode 100644
index 0000000..38b02ed
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.symtab
@@ -0,0 +1 @@
+0xffffffffc034e000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.text.unlikely b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.text.unlikely
new file mode 100644
index 0000000..88cfba0
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/.text.unlikely
@@ -0,0 +1 @@
+0xffffffffc10fd000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/__kcrctab b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/__kcrctab
new file mode 100644
index 0000000..bbe2928
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/__kcrctab
@@ -0,0 +1 @@
+0xffffffffc10fe06c
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/__ksymtab b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/__ksymtab
new file mode 100644
index 0000000..b48b59d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/__ksymtab
@@ -0,0 +1 @@
+0xffffffffc10fe060
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/__ksymtab_strings b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/__ksymtab_strings
new file mode 100644
index 0000000..585eebd
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/__ksymtab_strings
@@ -0,0 +1 @@
+0xffffffffc10fe070
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/__mcount_loc b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/__mcount_loc
new file mode 100644
index 0000000..fe363ee
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/sections/__mcount_loc
@@ -0,0 +1 @@
+0xffffffffc10fe0c2
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/taint b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/taint
new file mode 100644
index 0000000..fed7ca6
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_b/taint
@@ -0,0 +1 @@
+POE
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/coresize b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/coresize
new file mode 100644
index 0000000..08558e4
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/coresize
@@ -0,0 +1 @@
+16384
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/holders/.gitignore b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/holders/.gitignore
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/initsize b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/initsize
new file mode 100644
index 0000000..573541a
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/initsize
@@ -0,0 +1 @@
+0
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/initstate b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/initstate
new file mode 100644
index 0000000..e23fe64
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/initstate
@@ -0,0 +1 @@
+live
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/notes/.note.Linux b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/notes/.note.Linux
new file mode 100644
index 0000000..183aed9
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/notes/.note.Linux differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/notes/.note.gnu.build-id b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/notes/.note.gnu.build-id
new file mode 100644
index 0000000..50a9201
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/notes/.note.gnu.build-id differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/refcnt b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/refcnt
new file mode 100644
index 0000000..573541a
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/refcnt
@@ -0,0 +1 @@
+0
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/taint b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/taint
new file mode 100644
index 0000000..fed7ca6
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-holders/sys/module/mod_dep_chain_c/taint
@@ -0,0 +1 @@
+POE
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.alias b/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.alias
new file mode 100644
index 0000000..ba76e18
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.alias
@@ -0,0 +1 @@
+# Aliases extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.alias.bin b/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.alias.bin
new file mode 100644
index 0000000..7075435
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.alias.bin differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.builtin.alias.bin b/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.builtin.alias.bin
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.builtin.bin b/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.builtin.bin
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.dep b/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.dep
new file mode 100644
index 0000000..8248cf7
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.dep
@@ -0,0 +1,3 @@
+kernel/mod-dep-chain-a.ko:
+kernel/mod-dep-chain-b.ko: kernel/mod-dep-chain-a.ko
+kernel/mod-dep-chain-c.ko: kernel/mod-dep-chain-b.ko kernel/mod-dep-chain-a.ko
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.dep.bin b/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.dep.bin
new file mode 100644
index 0000000..f8b999d
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.dep.bin differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.devname b/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.devname
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.softdep b/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.softdep
new file mode 100644
index 0000000..5554ccc
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.softdep
@@ -0,0 +1 @@
+# Soft dependencies extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.symbols b/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.symbols
new file mode 100644
index 0000000..84263a6
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.symbols
@@ -0,0 +1,4 @@
+# Aliases for symbols, used by symbol_request().
+alias symbol:mod_dep_chain_a_info mod_dep_chain_a
+alias symbol:mod_dep_chain_c_info mod_dep_chain_c
+alias symbol:mod_dep_chain_b_info mod_dep_chain_b
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.symbols.bin b/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.symbols.bin
new file mode 100644
index 0000000..b246e9d
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/remove-single/lib/modules/6.2/modules.symbols.bin differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/proc/modules b/testsuite/rootfs-pristine/test-modprobe/remove-single/proc/modules
new file mode 100644
index 0000000..5929acb
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/proc/modules
@@ -0,0 +1,3 @@
+mod_dep_chain_c 16384 0 [permanent], Live 0x0000000000000000 (POE)
+mod_dep_chain_b 16384 1 mod_dep_chain_c,[permanent], Live 0x0000000000000000 (POE)
+mod_dep_chain_a 16384 1 mod_dep_chain_b,[permanent], Live 0x0000000000000000 (POE)
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/coresize b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/coresize
new file mode 100644
index 0000000..08558e4
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/coresize
@@ -0,0 +1 @@
+16384
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/holders/mod_dep_chain_b b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/holders/mod_dep_chain_b
new file mode 120000
index 0000000..e26fe25
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/holders/mod_dep_chain_b
@@ -0,0 +1 @@
+../../mod_dep_chain_b
\ No newline at end of file
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/initsize b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/initsize
new file mode 100644
index 0000000..573541a
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/initsize
@@ -0,0 +1 @@
+0
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/initstate b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/initstate
new file mode 100644
index 0000000..e23fe64
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/initstate
@@ -0,0 +1 @@
+live
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/notes/.note.Linux b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/notes/.note.Linux
new file mode 100644
index 0000000..183aed9
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/notes/.note.Linux differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/notes/.note.gnu.build-id b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/notes/.note.gnu.build-id
new file mode 100644
index 0000000..fcfdc7f
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/notes/.note.gnu.build-id differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/refcnt b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/refcnt
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/refcnt
@@ -0,0 +1 @@
+1
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.gnu.linkonce.this_module b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.gnu.linkonce.this_module
new file mode 100644
index 0000000..bcc5ba6
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.gnu.linkonce.this_module
@@ -0,0 +1 @@
+0xffffffffc10fa000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.init.data b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.init.data
new file mode 100644
index 0000000..de75dee
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.init.data
@@ -0,0 +1 @@
+0xffffffffc034d000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.note.Linux b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.note.Linux
new file mode 100644
index 0000000..c8513b9
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.note.Linux
@@ -0,0 +1 @@
+0xffffffffc10f9024
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.note.gnu.build-id b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.note.gnu.build-id
new file mode 100644
index 0000000..8cbe085
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.note.gnu.build-id
@@ -0,0 +1 @@
+0xffffffffc10f9000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.orc_unwind b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.orc_unwind
new file mode 100644
index 0000000..7987d4e
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.orc_unwind
@@ -0,0 +1 @@
+0xffffffffc10f90b5
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.orc_unwind_ip b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.orc_unwind_ip
new file mode 100644
index 0000000..12cda4f
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.orc_unwind_ip
@@ -0,0 +1 @@
+0xffffffffc10f90c1
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.return_sites b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.return_sites
new file mode 100644
index 0000000..cff4d30
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.return_sites
@@ -0,0 +1 @@
+0xffffffffc10f90b1
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.rodata.str1.1 b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.rodata.str1.1
new file mode 100644
index 0000000..a670b59
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.rodata.str1.1
@@ -0,0 +1 @@
+0xffffffffc10f9086
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.strtab b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.strtab
new file mode 100644
index 0000000..2905428
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.strtab
@@ -0,0 +1 @@
+0xffffffffc034e4e0
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.symtab b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.symtab
new file mode 100644
index 0000000..38b02ed
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.symtab
@@ -0,0 +1 @@
+0xffffffffc034e000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.text.unlikely b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.text.unlikely
new file mode 100644
index 0000000..0f8c361
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/.text.unlikely
@@ -0,0 +1 @@
+0xffffffffc10f8000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/__kcrctab b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/__kcrctab
new file mode 100644
index 0000000..83cf0eb
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/__kcrctab
@@ -0,0 +1 @@
+0xffffffffc10f906c
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/__ksymtab b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/__ksymtab
new file mode 100644
index 0000000..8a160a3
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/__ksymtab
@@ -0,0 +1 @@
+0xffffffffc10f9060
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/__ksymtab_strings b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/__ksymtab_strings
new file mode 100644
index 0000000..ed9d78d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/__ksymtab_strings
@@ -0,0 +1 @@
+0xffffffffc10f9070
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/__mcount_loc b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/__mcount_loc
new file mode 100644
index 0000000..b6ddb2f
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/sections/__mcount_loc
@@ -0,0 +1 @@
+0xffffffffc10f90a1
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/taint b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/taint
new file mode 100644
index 0000000..fed7ca6
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_a/taint
@@ -0,0 +1 @@
+POE
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/coresize b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/coresize
new file mode 100644
index 0000000..08558e4
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/coresize
@@ -0,0 +1 @@
+16384
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/holders/mod_dep_chain_c b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/holders/mod_dep_chain_c
new file mode 120000
index 0000000..9100cb1
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/holders/mod_dep_chain_c
@@ -0,0 +1 @@
+../../mod_dep_chain_c
\ No newline at end of file
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/initsize b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/initsize
new file mode 100644
index 0000000..573541a
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/initsize
@@ -0,0 +1 @@
+0
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/initstate b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/initstate
new file mode 100644
index 0000000..e23fe64
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/initstate
@@ -0,0 +1 @@
+live
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/notes/.note.Linux b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/notes/.note.Linux
new file mode 100644
index 0000000..183aed9
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/notes/.note.Linux differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/notes/.note.gnu.build-id b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/notes/.note.gnu.build-id
new file mode 100644
index 0000000..673a782
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/notes/.note.gnu.build-id differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/refcnt b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/refcnt
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/refcnt
@@ -0,0 +1 @@
+1
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.gnu.linkonce.this_module b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.gnu.linkonce.this_module
new file mode 100644
index 0000000..8048b8f
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.gnu.linkonce.this_module
@@ -0,0 +1 @@
+0xffffffffc10ff000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.init.data b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.init.data
new file mode 100644
index 0000000..de75dee
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.init.data
@@ -0,0 +1 @@
+0xffffffffc034d000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.note.Linux b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.note.Linux
new file mode 100644
index 0000000..b451fc5
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.note.Linux
@@ -0,0 +1 @@
+0xffffffffc10fe024
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.note.gnu.build-id b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.note.gnu.build-id
new file mode 100644
index 0000000..b10979d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.note.gnu.build-id
@@ -0,0 +1 @@
+0xffffffffc10fe000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.orc_unwind b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.orc_unwind
new file mode 100644
index 0000000..5dc94f4
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.orc_unwind
@@ -0,0 +1 @@
+0xffffffffc10fe0d6
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.orc_unwind_ip b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.orc_unwind_ip
new file mode 100644
index 0000000..4dd4220
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.orc_unwind_ip
@@ -0,0 +1 @@
+0xffffffffc10fe0e2
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.return_sites b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.return_sites
new file mode 100644
index 0000000..74defae
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.return_sites
@@ -0,0 +1 @@
+0xffffffffc10fe0d2
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.rodata.str1.8 b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.rodata.str1.8
new file mode 100644
index 0000000..18b3917
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.rodata.str1.8
@@ -0,0 +1 @@
+0xffffffffc10fe088
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.strtab b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.strtab
new file mode 100644
index 0000000..a51ce15
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.strtab
@@ -0,0 +1 @@
+0xffffffffc034e4f8
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.symtab b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.symtab
new file mode 100644
index 0000000..38b02ed
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.symtab
@@ -0,0 +1 @@
+0xffffffffc034e000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.text.unlikely b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.text.unlikely
new file mode 100644
index 0000000..88cfba0
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/.text.unlikely
@@ -0,0 +1 @@
+0xffffffffc10fd000
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/__kcrctab b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/__kcrctab
new file mode 100644
index 0000000..bbe2928
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/__kcrctab
@@ -0,0 +1 @@
+0xffffffffc10fe06c
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/__ksymtab b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/__ksymtab
new file mode 100644
index 0000000..b48b59d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/__ksymtab
@@ -0,0 +1 @@
+0xffffffffc10fe060
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/__ksymtab_strings b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/__ksymtab_strings
new file mode 100644
index 0000000..585eebd
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/__ksymtab_strings
@@ -0,0 +1 @@
+0xffffffffc10fe070
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/__mcount_loc b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/__mcount_loc
new file mode 100644
index 0000000..fe363ee
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/sections/__mcount_loc
@@ -0,0 +1 @@
+0xffffffffc10fe0c2
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/taint b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/taint
new file mode 100644
index 0000000..fed7ca6
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_b/taint
@@ -0,0 +1 @@
+POE
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/coresize b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/coresize
new file mode 100644
index 0000000..08558e4
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/coresize
@@ -0,0 +1 @@
+16384
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/holders/.gitignore b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/holders/.gitignore
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/initsize b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/initsize
new file mode 100644
index 0000000..573541a
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/initsize
@@ -0,0 +1 @@
+0
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/initstate b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/initstate
new file mode 100644
index 0000000..e23fe64
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/initstate
@@ -0,0 +1 @@
+live
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/notes/.note.Linux b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/notes/.note.Linux
new file mode 100644
index 0000000..183aed9
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/notes/.note.Linux differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/notes/.note.gnu.build-id b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/notes/.note.gnu.build-id
new file mode 100644
index 0000000..50a9201
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/notes/.note.gnu.build-id differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/refcnt b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/refcnt
new file mode 100644
index 0000000..573541a
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/refcnt
@@ -0,0 +1 @@
+0
diff --git a/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/taint b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/taint
new file mode 100644
index 0000000..fed7ca6
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/remove-single/sys/module/mod_dep_chain_c/taint
@@ -0,0 +1 @@
+POE
diff --git a/testsuite/setup-rootfs.sh b/testsuite/setup-rootfs.sh
index 4440ddc..94bfdcf 100755
--- a/testsuite/setup-rootfs.sh
+++ b/testsuite/setup-rootfs.sh
@@ -77,6 +77,9 @@ map=(
     ["test-modprobe/external/lib/modules/external/"]="mod-simple.ko"
     ["test-modprobe/module-from-abspath/home/foo/"]="mod-simple.ko"
     ["test-modprobe/module-from-relpath/home/foo/"]="mod-simple.ko"
+    ["test-modprobe/remove-holders/lib/modules/6.2/kernel/mod-dep-chain-a.ko"]="mod-dep-chain-a.ko"
+    ["test-modprobe/remove-holders/lib/modules/6.2/kernel/mod-dep-chain-b.ko"]="mod-dep-chain-b.ko"
+    ["test-modprobe/remove-holders/lib/modules/6.2/kernel/mod-dep-chain-c.ko"]="mod-dep-chain-c.ko"
     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/block/cciss.ko"]="mod-fake-cciss.ko"
     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/hpsa.ko"]="mod-fake-hpsa.ko"
     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/scsi_mod.ko"]="mod-fake-scsi-mod.ko"
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index 309f3e3..20413db 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -466,4 +466,59 @@ DEFINE_TEST(modprobe_module_from_relpath,
 	.modules_loaded = "mod-simple",
 	);
 
+static noreturn int modprobe_remove_single(const struct test *t)
+{
+	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
+	const char *const args[] = {
+		progname,
+		"--remove",
+		"--verbose",
+		"mod-dep-chain-c",
+		NULL,
+	};
+
+	test_spawn_prog(progname, args);
+
+	exit(EXIT_FAILURE);
+}
+
+DEFINE_TEST(modprobe_remove_single,
+	.description = "check if modprobe removes a single module but no holders",
+	.config = {
+		[TC_UNAME_R] = "6.2",
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/remove-single",
+		[TC_DELETE_MODULE_RETCODES] = "mod_dep_chain_c:0:0",
+	},
+	.modules_loaded = "mod-dep-chain-a,mod-dep-chain-b",
+	.need_spawn = true,
+	);
+
+static noreturn int modprobe_remove_with_holders(const struct test *t)
+{
+	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
+	const char *const args[] = {
+		progname,
+		"--remove",
+		"--remove-holders",
+		"--verbose",
+		"mod-dep-chain-a",
+		NULL,
+	};
+
+	test_spawn_prog(progname, args);
+
+	exit(EXIT_FAILURE);
+}
+
+DEFINE_TEST(modprobe_remove_with_holders,
+	.description = "check if modprobe removes also indirect holders",
+	.config = {
+		[TC_UNAME_R] = "6.2",
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/remove-holders",
+		[TC_DELETE_MODULE_RETCODES] = "mod_dep_chain_a:0:0:mod_dep_chain_b:0:0:mod_dep_chain_c:0:0",
+	},
+	.modules_loaded = "",
+	.need_spawn = true,
+	);
+
 TESTSUITE_MAIN();

-- 
2.40.0

