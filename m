Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F8AC433EF
	for <linux-modules@archiver.kernel.org>; Sun, 20 Feb 2022 06:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiBTGBO (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 20 Feb 2022 01:01:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbiBTGBJ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 20 Feb 2022 01:01:09 -0500
Received: from smtpbg516.qq.com (smtpbg516.qq.com [203.205.250.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D83D4E38D
        for <linux-modules@vger.kernel.org>; Sat, 19 Feb 2022 22:00:45 -0800 (PST)
X-QQ-mid: bizesmtp65t1645336839trr4rl57
Received: from localhost.localdomain (unknown [180.102.102.45])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 20 Feb 2022 14:00:32 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000B00A0000000
X-QQ-FEAT: g3JGK9LspAkdPLuIKUMkLU2nZN/IgIz7rigkD/y4wwHIiZcWPMTYYVxSLLGxT
        m2KkDvONxPdWZaRrkdzg8vD18jKhE9xShvpP+19sfwC7zrjVXg9o+NYfqei3hpDHKmAq1X2
        juzQFknEnVgHMIb34gDebgeuR6TKaygU04SwpM7wv9C1ChyJVuouxnvOwNCIIQWmPojOPGy
        uhbgMAGz0ceHlux5K39rjlXEMeOpJ+oCUMzIS8UpXGM2qggLnH4M0VPX1RXaTH6vxwlHt9O
        FEGctFFE0YYB9TRjemd9zwYMNIPO+u7vrje3TZxF4agTTy0DwaVJxlLnMTlEFGBXpOlgfUq
        ShZbQufJH4gavj5Hc2XHYF2Za1mcg==
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, nixiaoming@huawei.com,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 03/11] kernel/kmod: move modprobe sysctl to its own file
Date:   Sun, 20 Feb 2022 14:00:29 +0800
Message-Id: <20220220060029.13434-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to places
where they actually belong.  The proc sysctl maintainers do not want to
know what sysctl knobs you wish to add for your own piece of code, we
just care about the core logic.

All filesystem syctls now get reviewed by fs folks. This commit
follows the commit of fs, move the modprobe sysctl to its own file,
kernel/kmod.c.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 include/linux/kmod.h |  3 ---
 kernel/kmod.c        | 23 ++++++++++++++++++++++-
 kernel/sysctl.c      |  7 -------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/kmod.h b/include/linux/kmod.h
index 68f69362d427..9a07c3215389 100644
--- a/include/linux/kmod.h
+++ b/include/linux/kmod.h
@@ -14,10 +14,7 @@
 #include <linux/workqueue.h>
 #include <linux/sysctl.h>
 
-#define KMOD_PATH_LEN 256
-
 #ifdef CONFIG_MODULES
-extern char modprobe_path[]; /* for sysctl */
 /* modprobe exit status on success, -ve on error.  Return value
  * usually useless though. */
 extern __printf(2, 3)
diff --git a/kernel/kmod.c b/kernel/kmod.c
index b717134ebe17..54df92abb8dd 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -55,10 +55,31 @@ static DECLARE_WAIT_QUEUE_HEAD(kmod_wq);
  */
 #define MAX_KMOD_ALL_BUSY_TIMEOUT 5
 
+#define KMOD_PATH_LEN 256
 /*
 	modprobe_path is set via /proc/sys.
 */
-char modprobe_path[KMOD_PATH_LEN] = CONFIG_MODPROBE_PATH;
+static char modprobe_path[KMOD_PATH_LEN] = CONFIG_MODPROBE_PATH;
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table kern_modprobe_table[] = {
+	{
+		.procname       = "modprobe",
+		.data           = &modprobe_path,
+		.maxlen         = KMOD_PATH_LEN,
+		.mode           = 0644,
+		.proc_handler   = proc_dostring,
+	},
+	{ }
+};
+
+static __init int kernel_modprobe_sysctls_init(void)
+{
+	register_sysctl_init("kernel", kern_modprobe_table);
+	return 0;
+}
+late_initcall(kernel_modprobe_sysctls_init);
+#endif /* CONFIG_SYSCTL */
 
 static void free_modprobe_argv(struct subprocess_info *info)
 {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b41138d64e5e..126d47e8224d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1791,13 +1791,6 @@ static struct ctl_table kern_table[] = {
 	},
 #endif
 #ifdef CONFIG_MODULES
-	{
-		.procname	= "modprobe",
-		.data		= &modprobe_path,
-		.maxlen		= KMOD_PATH_LEN,
-		.mode		= 0644,
-		.proc_handler	= proc_dostring,
-	},
 	{
 		.procname	= "modules_disabled",
 		.data		= &modules_disabled,
-- 
2.20.1



