Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D8CC6FD20
	for <linux-modules@archiver.kernel.org>; Wed,  8 Mar 2023 13:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjCHNLO (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 8 Mar 2023 08:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjCHNKw (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 8 Mar 2023 08:10:52 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F58C2200
        for <linux-modules@vger.kernel.org>; Wed,  8 Mar 2023 05:08:58 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so1238703wmb.5
        for <linux-modules@vger.kernel.org>; Wed, 08 Mar 2023 05:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678280937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqEy80eHCsICtttV1M++C2UtoxkEBMHbEfeG1GrV7h4=;
        b=mYqizw2M2pU0Ss16oVAZkmHhAWlHxvu4rm9pr4Mq8BiERCs1QLFHF3s/cQJHlo/nsO
         9zQn2uVtaA+YFWJCk4thGSX3BnGdon/Rk8z3hyh3joAmt6J0q+WW2OYBlWQp+b/3VX/1
         0uqCo8fvkbGCF7qEbNANLPhIw7t1Nye99PLTaIiNLvZts807XrCNhjcvAsdkX0z/elro
         jb1uQKi4dbzWBiVeORyaaSBXSf2ybD7DgoA2z35Cw307M2qOiu5VZvKeryYND8yM3w/y
         GTcmSRaKIBp0bFEzjemxKzIH2dRuMUewWDlDW/fqIcIKhms6gMFZkOsB92PNrCgDOklK
         jHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678280937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FqEy80eHCsICtttV1M++C2UtoxkEBMHbEfeG1GrV7h4=;
        b=U6VRIlKJVrg/UVxNV5bPgg2tXPTAQmD2sN7N49qzzKqGO9A04FI0Xn4B497Vd3H2kY
         c6kwjo8t5f2Vbw90ZXkTA1ghTVf7AIiveRhWa/kU3KsbMg+GdorQs/XnVcUDSrK2FshA
         Txp7zRYGKb06AigVgUpymz6V70SVBpDIaNcoUN3TY7DS/PWkIUZBgPPTvYB5RsSVZRNQ
         7qJ1wr24EA/ZYu8VAvfuB3mL4SJu9AqyDLSPVcUvy2Z5Ji7L68vcshVgzqlrskpnKc/z
         Rb9rEGSZwhMfNviwz4QMtRTDbpotPFVakWjEZTAkB172SA7cPQo2zdSu5epsUOVDUblE
         u5Mg==
X-Gm-Message-State: AO0yUKXwz89CsKGv5CtWC0iIuibLsPDSDXRWkNLKVbxieayaJza+B0Fs
        YxdAz/vpJEryoRo6Fw+sL4wQ9A==
X-Google-Smtp-Source: AK7set/CwqCBmnt4TFuxPFRUmhtB1xU5+OWCKfFGMZ9SWcixK2D3Nn1cpdVVjGE5ye5bsy/JfnUAuw==
X-Received: by 2002:a05:600c:190b:b0:3ea:e7f6:f8f9 with SMTP id j11-20020a05600c190b00b003eae7f6f8f9mr16120976wmq.19.1678280936709;
        Wed, 08 Mar 2023 05:08:56 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j21-20020a05600c075500b003e0238d9101sm15537669wmn.31.2023.03.08.05.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 05:08:56 -0800 (PST)
Message-ID: <1c9e15e5-b88b-2fbc-7671-1f93d3ef50c6@linaro.org>
Date:   Wed, 8 Mar 2023 13:08:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] firmware: xilinx: nvmem: zynqmp: make modular
Content-Language: en-US
To:     Nick Alcock <nick.alcock@oracle.com>, michal.simek@xilinx.com
Cc:     Michal Simek <michal.simek@amd.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        linux-arm-kernel@lists.infradead.org
References: <20230308122703.114549-1-nick.alcock@oracle.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230308122703.114549-1-nick.alcock@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>



On 08/03/2023 12:27, Nick Alcock wrote:
> This driver has a MODULE_LICENSE but is not tristate so cannot be
> built as a module, unlike all its peers: make it modular to match.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Michal Simek <michal.simek@amd.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---

Thanks for fixing this,

Applied thanks,

--srini
>   drivers/nvmem/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> How's this?  (This supplants the previous patch, obviously.)
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 6dec38805041b..3b3832f4dfad1 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -368,7 +368,7 @@ config NVMEM_VF610_OCOTP
>   	  be called nvmem-vf610-ocotp.
>   
>   config NVMEM_ZYNQMP
> -	bool "Xilinx ZYNQMP SoC nvmem firmware support"
> +	tristate "Xilinx ZYNQMP SoC nvmem firmware support"
>   	depends on ARCH_ZYNQMP
>   	help
>   	  This is a driver to access hardware related data like
