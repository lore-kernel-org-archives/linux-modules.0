Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CDDC433F5
	for <linux-modules@archiver.kernel.org>; Sat, 19 Feb 2022 12:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242051AbiBSMlI (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 19 Feb 2022 07:41:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbiBSMlI (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 19 Feb 2022 07:41:08 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC7A197000
        for <linux-modules@vger.kernel.org>; Sat, 19 Feb 2022 04:40:49 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o34so6831304wms.1
        for <linux-modules@vger.kernel.org>; Sat, 19 Feb 2022 04:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2A5zJ2JQLZT7/ldVfROQO2rt7n2xXVeWkf8h2fP2Fe4=;
        b=Y0hLKCpWLXaQlwMqy9cSA40+6BdpoUDimzl8y+qUV1nasOi1zpjtsDjpVS51EDus6a
         oWpleNq4IVgkH7zUooXDzgWGE9KEMirVZ82njtaT63BDyS6ZsFk38GvShBRQd7Dh/Es+
         MsdFZRbBN49qeBtN4RtGQcra4G0wHIA6cCFDUwFExxnjIQRbByHl1MyUS+GrbETY3N+Z
         hCAG7PlzuswY6tkmY4r0fMmOOEyHiWhO4dXMyfE6EIxv8u4HR3c9c0CSVlBf4c+ZcOtu
         0tagiKDkZos229xG6tjzN0/pCAcWBLlTTqJ+ZadvQSFSnW+RD06IY89TRJN9KlRnbtoS
         UVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2A5zJ2JQLZT7/ldVfROQO2rt7n2xXVeWkf8h2fP2Fe4=;
        b=XHD/g8q7Anm4phOdLCdgVxzhutaMJJ97hgYaC+Vhq+tUCBnH8n4oxd+yoEuntYHE1+
         vS0/Of15ipp1wjq+SSZFCtDexESZ8ErYuU1LNGHrRAeHgpt/ibBZOBOCqvw2gAYpXjID
         42L+pHH1Jy8KJCUTqEatrY78KfdrK2WqcPW76WISAOzEIjLWhCTeqIFuvuHxi/XS7zm6
         H0+LE4mhyykmNpUgD1O5vaTA719saULGgAjSp6hMOf0Tf0w6DyobEsv7K210Ge78aPvd
         qEGU0GJ0+z3QwNubXNvWV9a9lSouoYYX7M+ri43ETW1tgVaP4pHf6lVQxMRKK68zZY2o
         D26g==
X-Gm-Message-State: AOAM5332AXebbq7AN3CAvc9EDot17Yp9/CUcBiAyMq+fBV0OkcA3/9mE
        WyKidKfDZFpk0tQbwjnrBRjDuOVtQIg=
X-Google-Smtp-Source: ABdhPJzXFziivtxxwxQBnAAGxPotSSKW/8sFFi1hVUIJ1yHOcp2jFDtxaYz480+bB9g24SovYsLuQw==
X-Received: by 2002:a1c:6a16:0:b0:37b:f4b0:65d8 with SMTP id f22-20020a1c6a16000000b0037bf4b065d8mr10942371wmc.80.1645274447801;
        Sat, 19 Feb 2022 04:40:47 -0800 (PST)
Received: from example.org (ip-78-45-37-102.net.upcbroadband.cz. [78.45.37.102])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c300700b0037bf8c6ee5bsm2488174wmh.45.2022.02.19.04.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 04:40:46 -0800 (PST)
Date:   Sat, 19 Feb 2022 13:40:42 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH v2] libkmod: Prefer builtin index over builtin.alias
Message-ID: <20220219124042.th572glnwdivf2vw@example.org>
References: <CAKi4VAJs8mC23vpvkryrdJiX2fJgkPPzb763Og4Y0vZv_JH8Gw@mail.gmail.com>
 <20220213074335.15774-1-lucas.demarchi@intel.com>
 <20220213131339.yxi3rq3q6xexqbbx@example.org>
 <20220215074310.is2umkvdnsx5lk25@ldmartin-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215074310.is2umkvdnsx5lk25@ldmartin-desk2>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Feb 14, 2022 at 11:43:10PM -0800, Lucas De Marchi wrote:
> On Sun, Feb 13, 2022 at 02:13:39PM +0100, Alexey Gladkov wrote:
> > On Sat, Feb 12, 2022 at 09:43:35PM -1000, Lucas De Marchi wrote:
> > > The modules.builtin.alias.bin is way larger than the
> > > modules.builtin.bin.  On a normal "distro kernel":
> > > 
> > > 	21k modules.builtin.alias.bin
> > > 	11k modules.builtin.bin
> > > 
> > > >From the kernel we get both modules.builtin and modules.builtin.modinfo.
> > > depmod generates modules.builtin.bin and modules.builtin.alias.bin
> > > from them respectively. modules.bultin is not going away: it's not
> > > deprecated by the new index added. So, let's just stop duplicating the
> > > information inside modules.builtin.alias.bin and just use the other
> > > index.
> > 
> > The modules.builtin contains only module names. The modules.builtin.modinfo
> > contains full info about builtin modules including names.
> > 
> > I thought that if there is complete information about the modules, then
> > reading the index with only the names does not make sense. And only in the
> > absence of modules.builtin.modinfo, you need to fallback to the index
> > with the names.
> 
> yeah, but most of the time we really need only the module name, so we
> can optimize for that. And since we are not getting rid of the other
> index, we can simply use it first the same way that for modules we first
> do lookup on lookup modules.dep and only later on modules.aliases.

Yes and no. We can be sure that we don't need aliases. The argument passed
to utilities can be very similar to the name of a module:

$ modinfo fs-ext4
name:           ext4
filename:       (builtin)
softdep:        pre: crc32c
license:        GPL
file:           fs/ext4/ext4
description:    Fourth Extended Filesystem
author:         Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others
alias:          fs-ext4
alias:          ext3
alias:          fs-ext3

By the way, crc32c is also an alias:

$ modinfo crc32c
filename:       /lib/modules/5.14.0.61-centos-alt1.el9/kernel/arch/x86/crypto/crc32c-intel.ko
alias:          crypto-crc32c-intel
alias:          crc32c-intel
alias:          crypto-crc32c
alias:          crc32c
license:        GPL
description:    CRC32c (Castagnoli) optimization using Intel Hardware.
author:         Austin Zhang <austin.zhang@intel.com>, Kent Liu <kent.liu@intel.com>
rhelversion:    9.0
srcversion:     1F2B6A533C8243A4017180A
alias:          cpu:type:x86,ven*fam*mod*:feature:*0094*
depends:
retpoline:      Y
intree:         Y
name:           crc32c_intel
vermagic:       5.14.0.61-centos-alt1.el9 SMP preempt mod_unload modversions

This is because there are multiple implementations of crc32c. So, information
about alias of builtin modules is almost always needed.

> > 
> > > ---
> > >  libkmod/libkmod-module.c | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> > > index 6f7747c..6423339 100644
> > > --- a/libkmod/libkmod-module.c
> > > +++ b/libkmod/libkmod-module.c
> > > @@ -576,13 +576,15 @@ KMOD_EXPORT int kmod_module_new_from_lookup(struct kmod_ctx *ctx,
> > >  	err = kmod_lookup_alias_from_aliases_file(ctx, alias, list);
> > >  	CHECK_ERR_AND_FINISH(err, fail, list, finish);
> > > 
> > > +	DBG(ctx, "lookup modules.builtin %s\n", alias);
> > > +	err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
> > > +	CHECK_ERR_AND_FINISH(err, fail, list, finish);
> > > +
> > >  	DBG(ctx, "lookup modules.builtin.modinfo %s\n", alias);
> > >  	err = kmod_lookup_alias_from_kernel_builtin_file(ctx, alias, list);
> > > -	if (err == -ENOSYS) {
> > > -		/* Optional index missing, try the old one */
> > > -		DBG(ctx, "lookup modules.builtin %s\n", alias);
> > > -		err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
> > > -	}
> > > +	/* Optional index missing, ignore */
> > > +	if (err == -ENOSYS)
> > > +		err = 0;
> > >  	CHECK_ERR_AND_FINISH(err, fail, list, finish);
> > 
> > Yep. Looks good for me.
> 
> thanks
> Lucas De Marchi
> 
> > 
> > -- 
> > Rgrds, legion
> > 
> 

-- 
Rgrds, legion

