Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B61BC61DA3
	for <linux-modules@archiver.kernel.org>; Wed, 22 Feb 2023 00:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBVAlC (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 21 Feb 2023 19:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBVAlB (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 21 Feb 2023 19:41:01 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEDC27482
        for <linux-modules@vger.kernel.org>; Tue, 21 Feb 2023 16:41:00 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b12so24074839edd.4
        for <linux-modules@vger.kernel.org>; Tue, 21 Feb 2023 16:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljywgRsdyFJLwbHtH82ElW21yztA0okPcafuTsTqGBg=;
        b=SIkb+HtAAtj+l5xcfUbt6XxxUoQ886xdmaTcTOWLTaG3F1lj45VuLRgkAnL9qqonMM
         1DhLPC7SQa1pSDZZ7b813Vx3mJPdBhg72Rg3nS3Fus7J0vEmCalJ5dUwmGl14xYgBmXs
         Bi6hoRh1Z1BKDEr4G2TBAsbAVcwF0nzK0kud7wwWs4Jc9GGMoEgn/Kuuag/9FqATNvXm
         QGPKffg0VN4U4EFZwVrKdK1fK6efXiZPz8GaXMLEFcPGpigFnvI7+nCCf6+hgNfH3tmf
         YtTuE91nMLlsV1AS+0blCZ/MmejobmeXh9EGxOHC5p6jRvuKugit2vS3h/Wnvtw3vSKn
         JeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljywgRsdyFJLwbHtH82ElW21yztA0okPcafuTsTqGBg=;
        b=EGZxrBr/ZUMk8Zkn8pZAwgQbROTRjiY1IYC3noDoKvA9eApGWZxjrQROamqwt3BMZQ
         7v3sHlXC213txa+MHjnxndoOuTmuHtzuYg0vJxTvhneeUsX0lugH8aN9YImVfcu3E1Gg
         gEWPjPndBJeE+EwEj4pfIMj72XeLNZ9D2Ynj+8OzybKGfntquzV3jA/MBjj9T4WaKBzs
         iyAAOtGOBcFy7xyF5pIu/G5yJDVrASHoTHkEXxMlNbpIr5sTH69sX90jcU8voqW4c4Ud
         CUN09R5j0/aXLzeaNqhZeGfjHmDt61qA/BbPXDbi0Yzneb8tGWK2f9BUFWQXvVz8gZ6N
         M9LA==
X-Gm-Message-State: AO0yUKXQIfsITLdRC0N8gxlthQIRFGHeksg2nBrK48XYU02+Y6trfck6
        AuUOGnuFXP2oXtWiNy4pBMYpHrcKfl0=
X-Google-Smtp-Source: AK7set8eEv1ISjqzRYkE2Yg1LYeQVPUrrwA95sRmi3seHinfCI6GS5+3BPeatB9v+VWafLO4xr0F3w==
X-Received: by 2002:a05:6402:b04:b0:4ae:f496:10ac with SMTP id bm4-20020a0564020b0400b004aef49610acmr5803081edb.0.1677026458031;
        Tue, 21 Feb 2023 16:40:58 -0800 (PST)
Received: from ldmartin-desk2.intel.com ([134.134.137.86])
        by smtp.gmail.com with ESMTPSA id ca5-20020a170906a3c500b008c1952b63d8sm4932009ejb.137.2023.02.21.16.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 16:40:56 -0800 (PST)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org,
        Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH 0/4] kmod: Paper cuts - dead code removal, don't SED manually
Date:   Tue, 21 Feb 2023 16:40:48 -0800
Message-Id: <167702625292.356650.2246926470690447394.b4-ty@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230221131929.106951-1-emil.l.velikov@gmail.com>
References: <20230221131929.106951-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


On Tue, 21 Feb 2023 13:19:25 +0000, Emil Velikov wrote:
> Here's another, final, round of paper cuts while browsing through the project.
> 
> Note that despite the enabled linker garbage collector, the first few cleanup
> patches result in detectable improvement in the final binaries.
> 
> The last patch, removes the open-coded replacement and by doing so fixes a
> genuine bug - albeit one that is uncommon to hit.
> 
> [...]

Applied all the patches, thanks!

[1/4] libkmod: remove unused kmod_module_get_builtin
      commit: 0237665beff4fa5e45b1d1ac5857627f949721b5
[2/4] libkmod: annotate kmod_builtin_iter API as static
      commit: df9d07a1492d7185413985add42ab38650ec2378
[3/4] shared: annotate local API as static
      commit: 06e6f167c211106212290aa7980880f972d71ba2
[4/4] configure: manage libkmod.pc.in and version.py.in via AC_CONFIG_FILES
      commit: e4c1a5b2998bc2c9dbcff8d62f121d1f8f5f4fe5

My intention is to release kmod 31 soon. Let me know if you have
anything pending that you'd like in the next release.  If nothing is pending I may just
do a release in the next days/week.


Best regards,
-- 
Lucas De Marchi <lucas.de.marchi@gmail.com>
