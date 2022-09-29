Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742A4C433F5
	for <linux-modules@archiver.kernel.org>; Thu, 29 Sep 2022 12:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiI2MKs (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 29 Sep 2022 08:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiI2MKr (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 29 Sep 2022 08:10:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F59E79A51
        for <linux-modules@vger.kernel.org>; Thu, 29 Sep 2022 05:10:45 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id o2so1902135lfc.10
        for <linux-modules@vger.kernel.org>; Thu, 29 Sep 2022 05:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=NsrrWIjf2uyMMXyxY7icXqYe+9FJkb9IHxNntDwreP4=;
        b=XWdx3nnbholxUaQlNpAYPNQWHmifAfs11gtmtx33+5wKkyrm5AFhGQPzcVhYtrfLkk
         EtoWaTJPd+B6YtUixt/Q78iUkiDl5oJHYnFSh11hOBjVgjOv4sD3ufr/KzHpetgSMD51
         MZpuEgMTMS9T+WuemoX3uw39+wcbsZjt+Ed1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=NsrrWIjf2uyMMXyxY7icXqYe+9FJkb9IHxNntDwreP4=;
        b=0QiCvh8WaGIeczuZDA52FiVeb3dD+bdlYzFJp/bkBPN9wCzV8/2MpF2l0ESYS77mYM
         g0/5G68qXG/W//Ju9WnNQxD0+ZA0M6VgkREQPHiUTli3QRBAgNpxpLoG7DKXniZhBYpA
         KAlpnLZoWyAkvqtsxbjRu5mgdUXvifxOnVgMfzMIgtmTPIQ3DLNqjFOqNLPtsWqvZQQU
         nH1aUVlFldqXaDJJC00/iB4xUj+iwKa99Ns/b+P7vDtERspkNWgeOBwuirP2yoekqh1x
         hwKiM0JrvJ6LxE3cxJFAtyvfM/jNniRbdED7IX+Gniu3ZhgDgYUkc/Wtvjl8+WiH/Ri6
         r3Cw==
X-Gm-Message-State: ACrzQf1TcFqtgloiYV0hL+JsBWxqXx2hnURiYFXN142EzTOsaAqHlrCA
        L0nUiOFiew7kZ8GiNphgl6H3b9BC8rE/T/ng
X-Google-Smtp-Source: AMsMyM5utwA6mqx1GWSzGWmcGTdL8ObnQwkFKgX/HF/+wvlKA00E1HQEYJw3V/fRLHpwjk9qxiEq9A==
X-Received: by 2002:ac2:4f03:0:b0:495:ec98:bcac with SMTP id k3-20020ac24f03000000b00495ec98bcacmr1220332lfr.339.1664453443617;
        Thu, 29 Sep 2022 05:10:43 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512078400b00497a61453a9sm767713lfr.243.2022.09.29.05.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 05:10:42 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] module: remove redundant module_sysfs_initialized variable
Date:   Thu, 29 Sep 2022 14:10:39 +0200
Message-Id: <20220929121039.702873-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The variable module_sysfs_initialized is used for checking whether
module_kset has been initialized. Checking module_kset itself works
just fine for that.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/module.h | 1 -
 kernel/module/sysfs.c  | 2 +-
 kernel/params.c        | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 518296ea7f73..727176de2890 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -827,7 +827,6 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
 #ifdef CONFIG_SYSFS
 extern struct kset *module_kset;
 extern struct kobj_type module_ktype;
-extern int module_sysfs_initialized;
 #endif /* CONFIG_SYSFS */
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index ce68f821dcd1..c921bf044050 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -340,7 +340,7 @@ static int mod_sysfs_init(struct module *mod)
 	int err;
 	struct kobject *kobj;
 
-	if (!module_sysfs_initialized) {
+	if (!module_kset) {
 		pr_err("%s: module sysfs not initialized\n", mod->name);
 		err = -EINVAL;
 		goto out;
diff --git a/kernel/params.c b/kernel/params.c
index 5b92310425c5..8d4e9a3f0df2 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -940,7 +940,6 @@ static const struct kset_uevent_ops module_uevent_ops = {
 };
 
 struct kset *module_kset;
-int module_sysfs_initialized;
 
 static void module_kobj_release(struct kobject *kobj)
 {
@@ -964,7 +963,6 @@ static int __init param_sysfs_init(void)
 			__FILE__, __LINE__);
 		return -ENOMEM;
 	}
-	module_sysfs_initialized = 1;
 
 	version_sysfs_builtin();
 	param_sysfs_builtin();
-- 
2.37.2

