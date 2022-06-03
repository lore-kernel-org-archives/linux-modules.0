Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6DDC433EF
	for <linux-modules@archiver.kernel.org>; Fri,  3 Jun 2022 20:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344714AbiFCUtT (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 3 Jun 2022 16:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242796AbiFCUtT (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 3 Jun 2022 16:49:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0BA326D4
        for <linux-modules@vger.kernel.org>; Fri,  3 Jun 2022 13:49:18 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so12945156pjl.4
        for <linux-modules@vger.kernel.org>; Fri, 03 Jun 2022 13:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2EjFTMqmjgFxAYvuSp3JHUUKvPc6GHZTXy2q/kwoQk=;
        b=iuWiLWD0QyRZhaBysOQOaAgS2F13IepJhQFUlVliq2RA6Bq/fAcDH8rG2M2b2c9dPQ
         iONmgayUknswrz1tlBSXjLkAWGgZ3YIypeaQ/IVbAnHAEC4Fu3JGPRZRPNQCcqHUoqlh
         L/bdWHmJKiC2X31/Jpl5NbJ2OwBtruhzUGDNHi/ir7656tOpU49AXR0TM23BuZbV1VGl
         fOTlMmrMWYi83zaR3PPwUffk1gF7yezF7qQDmwiK9MpD5ChzoCAjOO9LQzoQ7WGq8IDn
         etlSM6jyJC7nf4G/Dvx/1/MBDwN9uce7Tc4/SPH7tzi/9qy7NMIPbl0ySqM+APUfMLPa
         ArXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2EjFTMqmjgFxAYvuSp3JHUUKvPc6GHZTXy2q/kwoQk=;
        b=0aSwcX6Br/3MTgFHBNS4SjrSLIma16LJoqMv7g7jaPt0fLZ7k1fBusWFA1SzUeW+3a
         nlO7J/rsCHddeVeB8G08QUzu8blRHW5pB/JY1lEju1SXbw7DTcjlzV0R0Kd1Puk7wuA5
         VV/jSMAGIPa4u7nqGZpJelLYsem5Vr4drVf405SOdZXJKbey8vDt7PWQ1KsRJfyTNNSP
         gxwVujA3OXqM4cR2wdy660KTeVRHddgENSi/HK0L5NCl0v/cVAV3HguEHMRYovpIaPMS
         dxmJa9O/cd4bO3CuggOeYq9Rd8+g3vqxOuYRsSag0z0BDibZTckKJKi/NR84LavR3PgQ
         zqjA==
X-Gm-Message-State: AOAM531SlLrrLoo9Yi2DYLhpqSAMoqBddHjgJfp3nmLezfMy2aA1jkp8
        9nddSbb8Z1Sw12t3mpMo4+DyhVI9Pgs=
X-Google-Smtp-Source: ABdhPJyktCPVjSzBcTryWY7Ahet7fkCGo+ykCFqSLY0u/EP+kWMNHpD6TFClcTg2RjA2oK6+/invkg==
X-Received: by 2002:a17:902:e804:b0:164:164c:5a44 with SMTP id u4-20020a170902e80400b00164164c5a44mr12058946plg.85.1654289357578;
        Fri, 03 Jun 2022 13:49:17 -0700 (PDT)
Received: from ldmartin-desk2.. ([50.45.187.67])
        by smtp.gmail.com with ESMTPSA id s16-20020aa78bd0000000b0051bbd79fc9csm4703754pfd.57.2022.06.03.13.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 13:49:16 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 2/2] modprobe: re-use modname variable
Date:   Fri,  3 Jun 2022 13:49:02 -0700
Message-Id: <20220603204902.4295-2-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603204902.4295-1-lucas.de.marchi@gmail.com>
References: <20220603204902.4295-1-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 tools/modprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/modprobe.c b/tools/modprobe.c
index 830c667..a825fb5 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -324,7 +324,7 @@ static int rmmod_do_remove_module(struct kmod_module *mod)
 	const char *modname = kmod_module_get_name(mod);
 	int flags = 0, err;
 
-	SHOW("rmmod %s\n", kmod_module_get_name(mod));
+	SHOW("rmmod %s\n", modname);
 
 	if (dry_run)
 		return 0;
-- 
2.36.1

