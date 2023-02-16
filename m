Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E90AC636CC
	for <linux-modules@archiver.kernel.org>; Thu, 16 Feb 2023 18:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjBPSML (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 16 Feb 2023 13:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjBPSMK (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 16 Feb 2023 13:12:10 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72B850AD2
        for <linux-modules@vger.kernel.org>; Thu, 16 Feb 2023 10:12:06 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id pg6-20020a17090b1e0600b002349579949aso2536425pjb.5
        for <linux-modules@vger.kernel.org>; Thu, 16 Feb 2023 10:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hcDgeVfUhfmz8IwQ6VSNlxJydteCF1nqY6zwjGhL1XE=;
        b=audfm7HxgI5GehILPrPovaO73LbLVQeitaSr0EcBMbNptFL+flMw/VkZfxJX5+Y2om
         cM4Ckrg8rOza6E2tD9jcMRz0/zWChTkA+Q0TYnkffDIoPPj+sk2QcftoxuqGNjAtJuTk
         BRbwHFB0YxFXEyvj2W62yj7DHn/RjT3GNzHnOR0xikQqN9ZLRSczxi+Wzh6eVcaL3PtQ
         GO1qF2cirTBriwFxbR0Lk3lLJPVSswKShfEwYkGnNu+LVZNH5yvlvcfXYvMND/50gvZG
         j4bTNk+FWoqejZ3YRHmyf6FiE+mrZUwSV/WLmY79oeL4JPoDF+JJKwSL24CmGaA73roH
         Fqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcDgeVfUhfmz8IwQ6VSNlxJydteCF1nqY6zwjGhL1XE=;
        b=R26hEXqUT9XHkjsd0FrknIE13MEOGIQ2g4kbcOYJsj7bhJ9gOUvJ6FZ75nKr0EXgV7
         foC94RH423wyXIcjWUzBmYlyFeChknJyyzNtM2Mq9gxfWWwCKaTwz89Q4GifrmuEL/7n
         +grnjopK6cP+BwqFeuKRxchJF1ER/5aYRRmGADPjfEpr0qM3sDe+nLmxdh6oniOo5yxh
         aRIFtwlhWVX/e9GX5GALaG5Ux2TXDzDTZRQbEdzq3/9oXUglwiD6VhOCAyBEajRzovrW
         0D5tjw8F9aXpC43GJEOvrRzkPU2xwo5dK8SMy971tT5oveqtEPfAr9CPvuQzq4xWtw6V
         osUA==
X-Gm-Message-State: AO0yUKWo1r3/EbozX89yeoAvRa+OavzJhU5dkX8LNSgH5mxKb9olmq62
        Zbi3T0QSBg2fOMKAKI1MVMr0
X-Google-Smtp-Source: AK7set8bOpBs5drLbVaZkaWgHSg1clF1gqoDV9iRWkFEwHuqTROHoJxBIpjAoXHAVe3Qy605P2jlqA==
X-Received: by 2002:a17:902:c944:b0:196:88b8:8616 with SMTP id i4-20020a170902c94400b0019688b88616mr8204787pla.5.1676571126058;
        Thu, 16 Feb 2023 10:12:06 -0800 (PST)
Received: from thinkpad ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902d38d00b0019b4ee071ddsm24352pld.209.2023.02.16.10.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:12:05 -0800 (PST)
Date:   Thu, 16 Feb 2023 23:41:57 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/7] kbuild, PCI: endpoint: remove MODULE_LICENSE in
 non-modules
Message-ID: <20230216181157.GB7015@thinkpad>
References: <20230216152410.4312-1-nick.alcock@oracle.com>
 <20230216152410.4312-5-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230216152410.4312-5-nick.alcock@oracle.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Feb 16, 2023 at 03:24:07PM +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c   | 1 -
>  drivers/pci/endpoint/pci-epc-core.c | 1 -
>  drivers/pci/endpoint/pci-epc-mem.c  | 1 -
>  drivers/pci/endpoint/pci-epf-core.c | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index d4850bdd837f..4b8ac0ac84d5 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -728,4 +728,3 @@ module_exit(pci_ep_cfs_exit);
>  
>  MODULE_DESCRIPTION("PCI EP CONFIGFS");
>  MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 2542196e8c3d..dd750ad29485 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -861,4 +861,3 @@ module_exit(pci_epc_exit);
>  
>  MODULE_DESCRIPTION("PCI EPC Library");
>  MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> index a97b56a6d2db..7dcf6f480b82 100644
> --- a/drivers/pci/endpoint/pci-epc-mem.c
> +++ b/drivers/pci/endpoint/pci-epc-mem.c
> @@ -260,4 +260,3 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_free_addr);
>  
>  MODULE_DESCRIPTION("PCI EPC Address Space Management");
>  MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 9ed556936f48..2036e38be093 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -568,4 +568,3 @@ module_exit(pci_epf_exit);
>  
>  MODULE_DESCRIPTION("PCI EPF Library");
>  MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
> -MODULE_LICENSE("GPL v2");
> -- 
> 2.39.1.268.g9de2f9a303
> 

-- 
மணிவண்ணன் சதாசிவம்
