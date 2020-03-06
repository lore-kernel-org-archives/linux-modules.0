Return-Path: <SRS0=p+Rv=4X=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D158BC10F00
	for <linux-modules@archiver.kernel.org>; Fri,  6 Mar 2020 09:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40232072D
	for <linux-modules@archiver.kernel.org>; Fri,  6 Mar 2020 09:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgCFJ63 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:58:29 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:35846 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgCFJ63 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 6 Mar 2020 04:58:29 -0500
Received: from comp-core-i7-2640m-0182e6 (nat-pool-brq-t.redhat.com [213.175.37.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id 80730C61AB0;
        Fri,  6 Mar 2020 09:58:27 +0000 (UTC)
Date:   Fri, 6 Mar 2020 10:58:25 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org, Yanko Kaneti <yaneti@declera.com>
Subject: Re: [PATCH 2/2] depmod: just add .bin suffix to builtin.modinfo
Message-ID: <20200306095825.qmnothvjjemjwh7u@comp-core-i7-2640m-0182e6>
References: <20200306075934.3104-1-lucas.demarchi@intel.com>
 <20200306075934.3104-2-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306075934.3104-2-lucas.demarchi@intel.com>
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Mar 05, 2020 at 11:59:34PM -0800, Lucas De Marchi wrote:
> For all the other indexes what we do is to add a .bin to the original
> filename to denote it's the indexed version of that file. It was
> kernel's decision to name it modules.builtin.modinfo, so respect that.
> 
> Fix: b866b2165ae6 ("Lookup aliases in the modules.builtin.modinfo")
> ---
>  tools/depmod.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/depmod.c b/tools/depmod.c
> index 875e314..fe1c54d 100644
> --- a/tools/depmod.c
> +++ b/tools/depmod.c
> @@ -2402,7 +2402,7 @@ static int output_devname(struct depmod *depmod, FILE *out)
>  	return 0;
>  }
>  
> -static int output_builtin_alias_bin(struct depmod *depmod, FILE *out)
> +static int output_builtin_modinfo_bin(struct depmod *depmod, FILE *out)
>  {
>  	int ret = 0, count = 0;
>  	struct index_node *idx;
> @@ -2482,7 +2482,7 @@ static int depmod_output(struct depmod *depmod, FILE *out)
>  		{ "modules.symbols", output_symbols },
>  		{ "modules.symbols.bin", output_symbols_bin },
>  		{ "modules.builtin.bin", output_builtin_bin },
> -		{ "modules.builtin.alias.bin", output_builtin_alias_bin },
> +		{ "modules.builtin.modinfo.bin", output_builtin_modinfo_bin },

This file does not contain all whole modinfo. Now the function name and
index name will be confusing. But it's up to you.

>  		{ "modules.devname", output_devname },
>  		{ }
>  	};
> -- 
> 2.25.1
> 

-- 
Rgrds, legion

