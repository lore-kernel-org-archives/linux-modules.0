Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5CCC43334
	for <linux-modules@archiver.kernel.org>; Fri, 22 Jul 2022 02:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiGVCZZ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 21 Jul 2022 22:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbiGVCZB (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 21 Jul 2022 22:25:01 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B809823D
        for <linux-modules@vger.kernel.org>; Thu, 21 Jul 2022 19:24:45 -0700 (PDT)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 39CD13F133
        for <linux-modules@vger.kernel.org>; Fri, 22 Jul 2022 02:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658456683;
        bh=21lfF1OMKLeXFtULRWjRtXARMWFjMfI3d/p5JlAEia8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Vf7233D7ytA6ZTtX9mLYYWxhKK9hYQtdMFnxeN1tmh3hKfX4TVbolh602Sm5j6+XE
         IHVJ+gq6i1/7lKF40qeHk4xg7mR9o2HDPkbY1/z1+PJCoUNysK+cuRGeLocuNUmVAV
         js76IMhzVMHe3yDm4WmsUNLBI94R5idTJFnYvZ0z3L+3h6gAL4BfqOuyJ3hh/Kt4iu
         XrqtwGSh14MJUYIZtKcDCqdXK7Ns8oYqqmGObQz1fh4Gk6Xzlyirr4zezFytq9r+2m
         ZMS2R5wGaAKG9vmvZ/EatNqeJ3pzGLR35uyvfbN1Vv6ktiWS0kPh9EEJTGiWKKUoLa
         Yv5sUkIV0yaEQ==
Received: by mail-oi1-f197.google.com with SMTP id u127-20020aca6085000000b00335812e0b1eso1699289oib.22
        for <linux-modules@vger.kernel.org>; Thu, 21 Jul 2022 19:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21lfF1OMKLeXFtULRWjRtXARMWFjMfI3d/p5JlAEia8=;
        b=QtldXLbN6mBbaHAVeUGqFagLAmg/67ttGGhbMY9N2eDXzhqzYMAdQRqbJhXC0SmIbX
         /Rtad0TXs1vXqpBOz9LRgz+Gn8gd6eoHR1UhmbrlUtqra1Pq1jEph3NU7TlcXgp5TGDU
         7yGaLFXRiBCoXivZkAnTUAFu7yCqMhKmQC6kP9Vci0LzRfvW9X73K+hZE5cynvVjKDST
         8vJ6qM+c28ppyq8lYUf1t9vxVhr4Kb8UI5KcD5AgLWTdXtv4CjffZ1XuyBol1bLLLAjz
         8hWQkTLx8mg2v2MsUtqrXBelIj5NQ11squ4zMmOF7sHihv5GhHQoEuWECmXON2dK2kC3
         vnqg==
X-Gm-Message-State: AJIora8pT9tNQwiy3Ldh2KRysr6Ywhnz7JKo5iumqF1iScMt1xcpDBrS
        8GZrlGF279IxS+szxWmo1jwH58t6RfbMkmugRxaQkntxgc0XdLdd0V2jYOcu0YG+GcL94G/4qHA
        utFHFZfa5R3BD0PxHBdjKJk1cRx1/FfZeTXn3376ly0k=
X-Received: by 2002:a05:6870:9691:b0:10d:4e09:6d0d with SMTP id o17-20020a056870969100b0010d4e096d0dmr620836oaq.54.1658456682544;
        Thu, 21 Jul 2022 19:24:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uvU9qJw3xZdY8qLtAMfrO1WVNCSVRdNA2PSo7g3N3dxoTLVc+Yd1R+zm9uxw3Fm3r+ZL9hVg==
X-Received: by 2002:a05:6870:9691:b0:10d:4e09:6d0d with SMTP id o17-20020a056870969100b0010d4e096d0dmr620824oaq.54.1658456682346;
        Thu, 21 Jul 2022 19:24:42 -0700 (PDT)
Received: from mfo-t470.. ([2804:14c:4e1:8732:c479:1206:16fb:ce1f])
        by smtp.gmail.com with ESMTPSA id k23-20020a056870959700b000f5f4ad194bsm1814528oao.25.2022.07.21.19.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 19:24:41 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: [RFC PATCH 6/6] sysctl: introduce /proc/sys/kernel/modprobe_sysctl_alias
Date:   Thu, 21 Jul 2022 23:24:16 -0300
Message-Id: <20220722022416.137548-7-mfo@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220722022416.137548-1-mfo@canonical.com>
References: <20220722022416.137548-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The goal of the earlier patches is to let sysctl userspace tools
load the kernel module with a sysctl entry that is not available
yet in /proc/sys/ when the tool runs (so it can become available).

Let's expose this file for userspace for two reasons:

1) Allow such tools to identify that the running kernel has the
   code which produces sysctl module aliases, so they could run
   'modprobe sysctl:<entry>' only when it may actually help.

2) Allow an administrator to hint such tools not to do that, if
   that is desired for some reason (e.g., rather have the tools
   fail if something is misconfigured in a critical deployment).

Also add a module parameter for that (proc.modprobe_sysctl_alias),
for another method that doesn't depend on sysctl tools to be set
(that wouldn't fail them to try and set it if it's not there yet).

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 fs/proc/proc_sysctl.c  | 8 ++++++++
 include/linux/module.h | 1 +
 kernel/sysctl.c        | 9 +++++++++
 3 files changed, 18 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index ebbf8702387e..1e63819fcda8 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -33,6 +33,14 @@ static void check_struct_sysctl_device_id(void)
 	BUILD_BUG_ON(offsetof(struct sysctl_device_id, procname)
 			!= offsetof(struct ctl_table, procname));
 }
+
+/*
+ * Hint sysctl userspace tools whether or not to run modprobe with sysctl alias
+ * ('modprobe sysctl:entry') if they cannot find the file '/proc/sys/.../entry'
+ */
+int modprobe_sysctl_alias = 1;
+module_param(modprobe_sysctl_alias, int, 0644);
+
 #else
 static void check_struct_sysctl_device_id(void) {}
 #endif
diff --git a/include/linux/module.h b/include/linux/module.h
index 3010f687df19..5f565491c596 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -304,6 +304,7 @@ struct notifier_block;
 #ifdef CONFIG_MODULES
 
 extern int modules_disabled; /* for sysctl */
+extern int modprobe_sysctl_alias; /* for proc sysctl */
 /* Get/put a kernel symbol (calls must be symmetric) */
 void *__symbol_get(const char *symbol);
 void *__symbol_get_gpl(const char *symbol);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 15073621cfa8..b396cfcb55fc 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1763,6 +1763,15 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dostring,
 	},
+#ifdef CONFIG_PROC_SYSCTL
+	{
+		.procname	= "modprobe_sysctl_alias",
+		.data		= &modprobe_sysctl_alias,
+		.maxlen		= sizeof(modprobe_sysctl_alias),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+#endif
 	{
 		.procname	= "modules_disabled",
 		.data		= &modules_disabled,
-- 
2.25.1

