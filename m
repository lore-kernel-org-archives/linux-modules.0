Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A3FC433F5
	for <linux-modules@archiver.kernel.org>; Fri,  7 Oct 2022 13:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJGNiX (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 7 Oct 2022 09:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJGNiU (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 7 Oct 2022 09:38:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244B79DD8B
        for <linux-modules@vger.kernel.org>; Fri,  7 Oct 2022 06:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665149898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KLExc21YikxYfkGzogVL5HvRLyAIOk3MYbkInTDglKs=;
        b=F8U0yXCt9f9LRmj1P0O3CZ6fGU2uCrng4ayZaNpETXARyN8sm6HFjbk4MP458r6bAL4835
        +ihW7V16qC4xbxA4R1qffbrTx2XJ0GvehFQFl+x3+eH3BXg4MZu0GJNYYoUb6NP/J0h4JF
        iwVG+6l3itLboI1Ts6JxXZpSnu++CWo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-453-8sq8Lcn0OwymXl8IF5o0XA-1; Fri, 07 Oct 2022 09:38:16 -0400
X-MC-Unique: 8sq8Lcn0OwymXl8IF5o0XA-1
Received: by mail-wr1-f71.google.com with SMTP id e14-20020adf9bce000000b0022d18139c79so1437908wrc.5
        for <linux-modules@vger.kernel.org>; Fri, 07 Oct 2022 06:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLExc21YikxYfkGzogVL5HvRLyAIOk3MYbkInTDglKs=;
        b=NvMSnVf0EB4qfpMmQRNOeFPhCinhq1gQ8N3myCxdqr4bd2gGinETEdBwKYRS/TI0Yv
         IrmR6frHc9VdW40EHGS84E6Ge5LzRRqYYowtwFmee7RELeYzXlBVT/2BihATQmNsCPdO
         oz7fWQ2WHjqGWT4o+Rn3PMu2MdkJSLp70pUlzt8dKd+LqIcC/stAYY9pbKyjnzc3Pxd6
         6JgKWEZqR6wHJ42XZhr8dX2NbN88ZmIxumcUFYcUTZKAU6NQ/i4eAwGZiL2p3uh/pCyo
         KtpjXmqe8d3q5QL2oaXUrTeFdvLCFihlDJ05RzYqNT+SmFtNtYfp/uP1SrvWwDD/yeYO
         Mycw==
X-Gm-Message-State: ACrzQf1kHkUzw6yOOFYOn8a96a4qtO/OrJv6h2WvYG2CHPP4ut7XJB/w
        MbL23sX8bwkfN1ijJlwXpT2TroU8QwPF41y5DqN1NnEZFAuztAWq+RSdgvoNBfyiVQZpCfO/5xt
        DWOdy+cHO2sxJ/hTzs7upCnWF
X-Received: by 2002:a5d:6442:0:b0:22e:2c71:fdac with SMTP id d2-20020a5d6442000000b0022e2c71fdacmr3087505wrw.243.1665149895153;
        Fri, 07 Oct 2022 06:38:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM70RDA0DD69O0XjxoiDBxjeGXQHA+jCC60Vq1qMN7flnCd8L1EiVTzKLW6Zic2kg6PV2dI03A==
X-Received: by 2002:a5d:6442:0:b0:22e:2c71:fdac with SMTP id d2-20020a5d6442000000b0022e2c71fdacmr3087487wrw.243.1665149894757;
        Fri, 07 Oct 2022 06:38:14 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id m8-20020adffe48000000b0022e3cba367fsm2092740wrs.100.2022.10.07.06.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 06:38:13 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, atomlin@atomlin.com
Subject: [PATCH modules-next] module: tracking: Keep a record of tainted unloaded modules only
Date:   Fri,  7 Oct 2022 14:38:12 +0100
Message-Id: <20221007133812.804837-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This patch ensures that no module record/or entry is added to the
unloaded_tainted_modules list if it does not carry a taint.

Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Fixes: 99bd9956551b ("module: Introduce module unload taint tracking")

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/tracking.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index a139e63b6f20..26d812e07615 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -22,6 +22,9 @@ int try_add_tainted_module(struct module *mod)
 
 	module_assert_mutex_or_preempt();
 
+	if (!mod->taints)
+		goto out;
+
 	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules, list,
 				lockdep_is_held(&module_mutex)) {
 		if (!strcmp(mod_taint->name, mod->name) &&
-- 
2.37.3

