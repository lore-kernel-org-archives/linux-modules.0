Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F971C6FD1D
	for <linux-modules@archiver.kernel.org>; Mon,  6 Mar 2023 14:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCFOah (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 6 Mar 2023 09:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjCFOaF (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 6 Mar 2023 09:30:05 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3FA271C
        for <linux-modules@vger.kernel.org>; Mon,  6 Mar 2023 06:29:24 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cy23so39180214edb.12
        for <linux-modules@vger.kernel.org>; Mon, 06 Mar 2023 06:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678112893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qmumDQ5xHhb1nsDe4w90chyWCa+4iJ1hJ1sUP+qMbw=;
        b=gTvZQb9mo5cX8gSspGONw8s3VEmOF1S3140k9YzNAV0sx7M5hPlm5A+JKc6MWGV701
         JzfBppNbayJ5q9umwlNX0XOMSYYvzeu3eSg9YhpY4MePimrD6ptZOV7drt6p2CXd1609
         Ho99UrjrSw4gceoEVVHcGAw57bxP47el0BtBnOpJQLon6W02HRiuzE1rbhouRAOYkkgA
         uWDal0D+L2BX3GOJ4bSamLkzPQh9qgqQWzHw9xjp1H3vhorPpYbIjePquNamrpZfLW7x
         WXSPVv2CHjWOm6Q3c/kTavhT0YQZhsoP1nwawC1EFYHXD1QMH9Dc1gLugb6PIMZ/RCst
         j2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678112893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qmumDQ5xHhb1nsDe4w90chyWCa+4iJ1hJ1sUP+qMbw=;
        b=ahydqsEIO1aNZT4tO2UPbkxGSV7MVf23EME8bimNR06tsvKI1izl/PApkzhCnLIMZV
         BixDM1v94Dygcw7w7kRmg5zbskmvlST7cb7QptaDJOAeJCVjKKT7FRvfkVqGH309mUxZ
         3vTPSGFRUfYxxvku4B+PmyCfylbxlgMFpSxZhTLyOUwrhSJL8nzfm5jtkaXHovd9/IZS
         ycsxPYhh/ghY/WNZf1BqKxEOea2eqdMUrnskK2+v2RZ7SY2Ydy5DH67jWQjHva+ruD5B
         a8ckGKsx1VgKRAYGEi/ZPJ71FSwPKobX+mm0CdSBQWaypTCX/DZ2zPTczY+dZ3MRVuGf
         rlEQ==
X-Gm-Message-State: AO0yUKUPYhWvnNyIPHCTWrB9yX1m4PuJfYfKQbNGSa76ef+5+W4omaLl
        GmhU2pK2G49Tue0CyL2btRaQjQ==
X-Google-Smtp-Source: AK7set9Fpbk62D73iRfBEKdGRoPrH+hCtWPYEz16g73QV03ih9+05TnqoP4q5vPLshJDuqKD4lOXNg==
X-Received: by 2002:a05:6402:1503:b0:4ab:553:75d8 with SMTP id f3-20020a056402150300b004ab055375d8mr9945972edw.10.1678112892860;
        Mon, 06 Mar 2023 06:28:12 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c1e7:5006:98ac:f57])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906a38e00b008b8ae79a72bsm4636763ejz.135.2023.03.06.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 06:28:12 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     mcgrof@kernel.org, Nick Alcock <nick.alcock@oracle.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 17/27] memory: remove MODULE_LICENSE in non-modules
Date:   Mon,  6 Mar 2023 15:28:09 +0100
Message-Id: <167811288496.11610.11937459322909682733.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230224150811.80316-18-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com> <20230224150811.80316-18-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, 24 Feb 2023 15:08:01 +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> [...]

Applied, thanks!

[17/27] memory: remove MODULE_LICENSE in non-modules
        https://git.kernel.org/krzk/linux-mem-ctrl/c/38ffd3eca02502d1d41b8f1430e5a8e302522bd4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
