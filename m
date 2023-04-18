Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9350FC77B75
	for <linux-modules@archiver.kernel.org>; Tue, 18 Apr 2023 08:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjDRIwt (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 18 Apr 2023 04:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDRIwt (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 18 Apr 2023 04:52:49 -0400
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C928A1726
        for <linux-modules@vger.kernel.org>; Tue, 18 Apr 2023 01:52:47 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Tue, 18 Apr 2023 10:52:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1681807962; bh=IOcTw37QP+4ZqqLXfIdALFpI4DaRwAb76ftj+8kXkxo=;
        h=From:To:Cc:Subject:Date:From;
        b=EAF6VLVWVVyv++br68gZ54vPgEWn7+rSkIsWc38DJO3x0uFmj9MjWJCt49lbtxrNf
         mYt1I8U5fVs+mmowsG38XvwADKD9VEY8Vem5JXGHTzGP32/Z5WlyPNdwjKwy4aJ0QX
         SYRTkT+VB9DriV1WYMSrysforl4XNauKvef7SqPg=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id B59CD8234D;
        Tue, 18 Apr 2023 10:52:42 +0200 (CEST)
Received: from d-nsc-z2.avm.de. (unknown [IPv6:fde4:4c1b:acd5:7792::1])
        by buildd.core.avm.de (Postfix) with ESMTP id AAAD0180F16;
        Tue, 18 Apr 2023 10:52:42 +0200 (CEST)
From:   Nicolas Schier <n.schier@avm.de>
To:     linux-modules@vger.kernel.org,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        Nicolas Schier <n.schier@avm.de>
Subject: [PATCH] modprobe: rmmod_do_module: Free kmod list of holders
Date:   Tue, 18 Apr 2023 10:52:38 +0200
Message-Id: <20230418-add-missing-kmod_module_unref_list-v1-1-ab5b554f15ee@avm.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1681807961-BA76ED8F-8390DAC4/0/0
X-purgate-type: clean
X-purgate-size: 938
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Add a missing kmod_module_unref_list() to fix a memory leak.

Fixes: 42b32d30c38e ("modprobe: Fix holders removal")
Signed-off-by: Nicolas Schier <n.schier@avm.de>
---
Resend as a separate patch as suggested in https://lore.kernel.org/linux-modules/20230412192151.jbbcltmcwwamhlm6@ldmartin-desk2.lan/
---
 tools/modprobe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/modprobe.c b/tools/modprobe.c
index 3b7897c..e891028 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -455,6 +455,7 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
 		struct kmod_list *holders = kmod_module_get_holders(mod);
 
 		err = rmmod_do_modlist(holders, true);
+		kmod_module_unref_list(holders);
 		if (err < 0)
 			goto error;
 	}

---
base-commit: 3d1bd339ab942ea47e60f053f4b11b0c47ff082b
change-id: 20230418-add-missing-kmod_module_unref_list-e7c4dd5b6625

Best regards,
-- 
Nicolas Schier
