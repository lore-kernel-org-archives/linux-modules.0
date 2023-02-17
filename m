Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22255C64ED8
	for <linux-modules@archiver.kernel.org>; Fri, 17 Feb 2023 14:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBQOUy (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 17 Feb 2023 09:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBQOUx (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 17 Feb 2023 09:20:53 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639C41BCD
        for <linux-modules@vger.kernel.org>; Fri, 17 Feb 2023 06:20:52 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id eg30so4621384edb.7
        for <linux-modules@vger.kernel.org>; Fri, 17 Feb 2023 06:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DepS95Xiv6tzBVf9W0DYPpboAHnjdejp3hM9TEZ9nSc=;
        b=Yp2ODLUktl1oQf6nksGQtZHVM8M5TW/tSP4Ywbb/s9ExrHvtB5Hb52c5I4gmsNRf7Z
         e5IZaQdDxc08Gai6InENBwbflRS5VqZLnuiEXDzvTGyg0vPfSqUEHg7ObsHuJVrlaKIB
         roiJvsk3GiuBxXfK7g9c2EGSPco1aWl1bqkkSK4k3iY7PVWkP3B2LkNuA0QbtKz2BJNz
         OwSaIWQ/5Zv0JB1O2F77QiLiGAdMnS6sD7iyIMsCd7CSa9Jv+nPzE0NreulSBacCPVCL
         AzjfSWDq4xOgtNFbVfKjqVoQYUCFoRqPX6R6LoABF9tG1HnAcPIG8CxCRvgxvlQuAyi8
         mFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DepS95Xiv6tzBVf9W0DYPpboAHnjdejp3hM9TEZ9nSc=;
        b=ITpeYN7iRd280kLEsEyF1KTZP0bA+2qyycQP635Ju5pAMGN6vX7q83+q7bstv9vtFG
         89DBqY5Vdupy0KwrhAklevBU+Iyytez7+lMwkJR4riGq//mqivzxS6kufNJWCdtG4l6/
         bS2ROurON2sf4D+lyCz0zSgSTwSMQ0YsQAEZpvY/n66pAakJE4LtGm4Wg4CkEiyDAmua
         ppzyJTHXasElqEFBD0uPQB1GXDsO379jRt43TwKrUONEsphsBxJ7fN3rl2yRo+yzArVf
         Tccq7sK+3EZRA0MyDeRPLmOecCrbU5GP7GMQ9BJTydVCmT69j4YL/4yfkBZjXTGqEtM3
         tuyg==
X-Gm-Message-State: AO0yUKUeA55YdIBo6+FDhsG8wFeAinhd9/UP+Lr13bULAiQPKhgI8KYI
        EIPe+AE4JrpxFTmI02pqYPnb7w==
X-Google-Smtp-Source: AK7set9rX7c55oN2r+fSDrfkxl+GHz0jcsU7INVi4Un1Ho2Dh46EQcbo0Bir57Bi89khR4O46oJc+Q==
X-Received: by 2002:a17:907:6b8a:b0:879:43d5:3832 with SMTP id rg10-20020a1709076b8a00b0087943d53832mr5075230ejc.14.1676643650875;
        Fri, 17 Feb 2023 06:20:50 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t1-20020a17090616c100b008b13a1abadasm2162597ejd.75.2023.02.17.06.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 06:20:50 -0800 (PST)
Message-ID: <19c80f85-a1c5-3897-b592-6e9cd0579657@linaro.org>
Date:   Fri, 17 Feb 2023 15:20:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 22/24] kbuild, dmaengine: s3c24xx: remove MODULE_LICENSE
 in non-modules
To:     Nick Alcock <nick.alcock@oracle.com>, mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org
References: <20230217141059.392471-1-nick.alcock@oracle.com>
 <20230217141059.392471-23-nick.alcock@oracle.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230217141059.392471-23-nick.alcock@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 17/02/2023 15:10, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.

I think you need to base your tree-wide patches on next. The driver was
removed. Please drop the patch.


Best regards,
Krzysztof

