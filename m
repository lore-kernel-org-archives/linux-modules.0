Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EB5C636CC
	for <linux-modules@archiver.kernel.org>; Wed,  8 Feb 2023 17:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjBHRQK (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 8 Feb 2023 12:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjBHRQJ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 8 Feb 2023 12:16:09 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EB128D03
        for <linux-modules@vger.kernel.org>; Wed,  8 Feb 2023 09:16:06 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id u22so8228535ejj.10
        for <linux-modules@vger.kernel.org>; Wed, 08 Feb 2023 09:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z8p3hFtepK2wzolx/E7JmHRshbs4JfB8maq8B1ADqo=;
        b=knpuUZt3ZAXjn1MxuT0whBLwZ8Lh5l2ZXF2C1HBnR8oUVyUhFe4zDi/qwAjGYJJnv3
         cngVRxwbVEAKsyyA4jrwcwJWFbrBU+nrHRKD2gAUTeJkbz88HMRwzY10J0RPoalsYimi
         Q0w/xHvwNU+ljZ1aoxrbH4Yuq4A2o8sBfj94YYylb+im/pTDWBZzuuLWEr7i8wvoUczE
         05onYW56XJvVjy/gT5INBpRHdBFDevyVpmZ2zWj6C2QKyw/mQeTIrsBdAjVWol4IYitA
         MfzJmGxwRqDeAU+0GJgGYymgaIlJXWYq25xP1liiUhsoOzY3K9ITNg+eA1POyD2ScpTb
         111Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z8p3hFtepK2wzolx/E7JmHRshbs4JfB8maq8B1ADqo=;
        b=I+BvVaaAQIGgcQFHgcKsLLc3A5PFSevPJagZDY2cs5ckCfQvzO4EEgCSuRJAgO7A1F
         tZYX/21L3orZlIBC2cUTU16IhkI6RK9JhjXkmmSC2WxL4OjXmRtCCNfuV/IJwm2mKref
         yEONdUBWmmnLCxGA5Gg8ALwZRHMj1BAi/qvWVBK/QJlreSW76TUsqfZXM35aukOrLCdC
         CsfE6Q9vVEXzaOXytaxvJ3o0iEtcfZf0hEBj85XWCaxsNfVbhmFriHIK8k1xIeuqS1Zl
         UFDuzX919oxtoOrVdadi9z1kUIuF2RAwH9IAmBKIDuGj7vdqaSg36su3Ikgm2Ia0ReC+
         dSVg==
X-Gm-Message-State: AO0yUKXBMBKKHoNYg7GfhB8BoZxEk4SBntLEgWyiP4bwhLy3ij79Afmi
        t5ccuTuPDafpWbLk/rhjTr2AJWaGtBs=
X-Google-Smtp-Source: AK7set+neyY5O1oDhZlaiGKmma7VsMqXoJp2P97pQWBvl7ei2eqag8woSC8Pk8j2ugB3a0cpJjiC0Q==
X-Received: by 2002:a17:906:29cb:b0:87f:5d0a:c610 with SMTP id y11-20020a17090629cb00b0087f5d0ac610mr8675523eje.32.1675876563805;
        Wed, 08 Feb 2023 09:16:03 -0800 (PST)
Received: from ldmartin-desk2.lan ([134.134.139.71])
        by smtp.gmail.com with ESMTPSA id kx13-20020a170907774d00b0087bcda2b07bsm8404190ejc.202.2023.02.08.09.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 09:16:02 -0800 (PST)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org,
        Yauheni Kaliuta <ykaliuta@redhat.com>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH] man/rmmod: explain why modprobe -r is more useful
Date:   Wed,  8 Feb 2023 09:15:56 -0800
Message-Id: <167587649253.40388.9645887581385634542.b4-ty@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202134736.405778-1-ykaliuta@redhat.com>
References: <20230202134736.405778-1-ykaliuta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


On Thu, 02 Feb 2023 15:47:36 +0200, Yauheni Kaliuta wrote:
> Improve user experience by explaining the option so the user may
> not search explanations in other manpages (modprobe).
> 
> 

Applied, thanks!

[1/1] man/rmmod: explain why modprobe -r is more useful
      commit: 06fadcc6b17c3b9a534540dd6d74b0c5fb1d948d

Best regards,
-- 
Lucas De Marchi <lucas.de.marchi@gmail.com>
