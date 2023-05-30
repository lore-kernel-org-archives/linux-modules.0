Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFC4C77B73
	for <linux-modules@archiver.kernel.org>; Tue, 30 May 2023 19:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjE3T65 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 30 May 2023 15:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjE3T64 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 30 May 2023 15:58:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C81CE8
        for <linux-modules@vger.kernel.org>; Tue, 30 May 2023 12:58:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96f818c48fbso892390566b.0
        for <linux-modules@vger.kernel.org>; Tue, 30 May 2023 12:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685476733; x=1688068733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/GZIYOVPadGBuAha4Oa1euhmTZ5VxFO4RrpEB9lXVk=;
        b=bByszG5yaD9kj6JgswRPKfZnd7TwdPkFQQV9hZ5zmbwQoRkHQmeOrdOICOTYV7Q7so
         q9LF4M7xx3wMD+1G5BcaGbvVEuz+mmqpuueKfnQ90cKM3AJTlne/Fz993e+SxEd5JJ6K
         U/vRPtept5oB3dibVxhb4hFHb5yGheqEdSAKZXUohtWYNFkT8qgC8J5jdH8RN3fXxdUp
         AetpSoJzOblQ6dkigapSz7Fhe9bh4yEuHBPUmaTtAAkGIJbDVUN1cvk6AynSMQ92dKcC
         VJKNw3s7H8/h8RC/MpXDye9CnlmQfMyCyOyi2eupLOq/1j9jjmkz7z05uAZq+Ct32rcn
         fjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685476733; x=1688068733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/GZIYOVPadGBuAha4Oa1euhmTZ5VxFO4RrpEB9lXVk=;
        b=WCIlXdAgL9aVqYBAsJ0iUdBKrKKlGNjxN1JXUlYu5gBwoamZmLBRXdI7BTfugc6HCt
         Eog9kUGAf/Oqo0/pvV6Aol7IJJHRqhwm/xRhoPlfo20dBfv122rjYKCwCCDqM63Ve5xx
         g5c2EenG0UGrEDfy1OO8cYzlsggLP0PEi11SX0mkCW0hKF570/NSTXJzLMp2zHBy8Fcw
         sOkiu71zkrEk3psgCAHBmgsu6/OIesURTE8YsO970WAa6uoKwTxcnnx+K3gk8vEjuEtT
         qlorqvW4TbeTdgYXNpJYnBtu7C6Iy0k+Ypw3dKGJ8cRVTJCsTsmIrh/2IbaREJpwTZpN
         uQow==
X-Gm-Message-State: AC+VfDwLl1li6Mgte3vnkaZixaYK8+8WX2jAYZy7U3U9Z6TFvEizQ7du
        4R3pFOUQ6lo4947oWV2ff+oFQabxjbo=
X-Google-Smtp-Source: ACHHUZ7TWNbL0P/SLxa8gbfEA4DkrK210vhKf2vkCacjhbKKNcBpOhaxCp1jQKGmsWDjcynLCCn7DA==
X-Received: by 2002:a17:907:62a1:b0:974:1c98:d38e with SMTP id nd33-20020a17090762a100b009741c98d38emr3264057ejc.2.1685476733013;
        Tue, 30 May 2023 12:58:53 -0700 (PDT)
Received: from ldmartin-desk2.jf.intel.com ([134.134.139.85])
        by smtp.gmail.com with ESMTPSA id z4-20020aa7d404000000b0050bc9ffed66sm4708437edq.53.2023.05.30.12.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 12:58:52 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] libkmod: fix possible out-of-bounds memory access
Date:   Tue, 30 May 2023 12:58:25 -0700
Message-Id: <168547666141.429581.8060561968440690116.b4-ty@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519074638.402045-1-dmantipov@yandex.ru>
References: <f95eccca-3eac-5213-6a33-c9ebf1121a7d@csgroup.eu> <20230519074638.402045-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


On Fri, 19 May 2023 10:46:38 +0300, Dmitry Antipov wrote:
> An attempt to pass too long module name to, say, rmmod, may
> cause an out-of-bounds memory access (as repoted by UBSan):
> 
> $ rmmod $(for i in $(seq 0 4200); do echo -ne x; done)
> libkmod/libkmod-module.c:1828:8: runtime error: index 4107 out of bounds for type 'char [4096]'
> 
> This is because 'snprintf(path, sizeof(path), ...)' may return the
> value which exceeds 'sizeof(path)' (which happens when an output
> gets truncated). To play it safe, such a suspicious output is
> better to be rejected explicitly.
> 
> [...]

Applied, thanks!

[1/1] libkmod: fix possible out-of-bounds memory access
      commit: badacf76e46b3602bc0e99ffc677ccbe53691f62

Best regards,
-- 
Lucas De Marchi <lucas.de.marchi@gmail.com>
