Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CED5C433F5
	for <linux-modules@archiver.kernel.org>; Tue,  8 Mar 2022 10:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345998AbiCHKwp (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 8 Mar 2022 05:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345992AbiCHKwh (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 8 Mar 2022 05:52:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B185643493
        for <linux-modules@vger.kernel.org>; Tue,  8 Mar 2022 02:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646736699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fGHP5u/Zbzx5j7Gfciio1oHVz6AOtI5jro8ptGHtKdI=;
        b=Zg3DndeUqWJNKnhowS59Li0F/IKyKtngexcuoTu1YjAjpLJbXnKNicXj2A2qVFa7Hk8SfE
        uFOIUKshFpeW4E0CNCEvKcr73l0649Kta97B5KSrG2Pi9X9H8abJq2zgBZMy2UVWRbL4vU
        y5qUnWz877Zaakb08ETR+mCEcynyC+Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-arYwNjZKMoigYSGfLoZQqQ-1; Tue, 08 Mar 2022 05:51:38 -0500
X-MC-Unique: arYwNjZKMoigYSGfLoZQqQ-1
Received: by mail-wr1-f69.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so5335737wrg.19
        for <linux-modules@vger.kernel.org>; Tue, 08 Mar 2022 02:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fGHP5u/Zbzx5j7Gfciio1oHVz6AOtI5jro8ptGHtKdI=;
        b=m4ltRSCwttdQEWyAWKSumzEf8hr5M/wFk56P2UB+ciw9zl4THJYeaTzmkYnWWFtnji
         GeQuatv00F9nE9Fm8Y3qM0eMEPfNEUSW2JTGPnM24zKTOOUJkRapTbYVdNu8HoVP8/Eh
         fYM/heNSQfwkONYGf6Z8iKpbU/7PCVFBiiV1CYXB6JEElULZN/bXhgmri9/XC9GKsvBD
         8uPebYcJuMOFwQgcyZVCuSLSDVhag+W0A1czCi5Bqskesg5LVhmgVphHjvszlF+DRYok
         8wq6ci8pSzL6A92LJSvFlxK87HB7jzE3pSu+NCOjCjqJNigWyhrVtgxw6bMeAQb0QDEq
         V/JA==
X-Gm-Message-State: AOAM530cg9C6JrS9oTk81bWS8EKrTWaZvV+oLvGdUwVxyT7eD/GN+awK
        bcjXQfu+KjE+Kl910WcSbEQfSNb8yAlZTSvAMMCoM+vdhJoZs2lW7Pilyn8pCU7JrhY70CsGTtF
        ut9ZeIuZ2laGDSp5NGdWnCf2D
X-Received: by 2002:a5d:64c4:0:b0:202:29d7:2a4d with SMTP id f4-20020a5d64c4000000b0020229d72a4dmr3768579wri.624.1646736697577;
        Tue, 08 Mar 2022 02:51:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwRhOUg7FHvhHegjJXE7PwqmhXPJn4/LEToYlVXfLbXUBneGnbrYsN4lbqVGGq08DoadiCuw==
X-Received: by 2002:a5d:64c4:0:b0:202:29d7:2a4d with SMTP id f4-20020a5d64c4000000b0020229d72a4dmr3768548wri.624.1646736697263;
        Tue, 08 Mar 2022 02:51:37 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id v14-20020a7bcb4e000000b0034492fa24c6sm1801207wmj.34.2022.03.08.02.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:51:36 -0800 (PST)
Date:   Tue, 8 Mar 2022 10:51:35 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "pmladek@suse.com" <pmladek@suse.com>
Subject: Re: [PATCH v10 13/14] module: Move kdb module related code out of
 main kdb code
Message-ID: <20220308105135.hvs6qqfvrxkpzykx@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220307174509.2887714-1-atomlin@redhat.com>
 <20220307174741.2889588-1-atomlin@redhat.com>
 <82088b20-6129-aecc-c43c-1c78171717c4@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82088b20-6129-aecc-c43c-1c78171717c4@csgroup.eu>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue 2022-03-08 08:36 +0000, Christophe Leroy wrote:
> 
> 
> Le 07/03/2022 à 18:47, Aaron Tomlin a écrit :
> > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > index 0852a537dad4..f3a30cd5037f 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -26,7 +26,6 @@
> >   #include <linux/utsname.h>
> >   #include <linux/vmalloc.h>
> >   #include <linux/atomic.h>
> > -#include <linux/module.h>
> >   #include <linux/moduleparam.h>
> >   #include <linux/mm.h>
> >   #include <linux/init.h>
> No need of linux/module.h here anymore ?

Hi Christophe,

Correct.

> In that case, I see several other files in kernel/debug/kdb/ that 
> include linux/module.h
> 
> Should it be removed in those files as well ?

I did not review the other kernel/debug/kdb/.*c files.
Anyhow, yes it can be removed from each, since it is entirely redundant.

> > diff --git a/kernel/module/kdb.c b/kernel/module/kdb.c
> > new file mode 100644
> > index 000000000000..60baeebea3e0
> > --- /dev/null
> > +++ b/kernel/module/kdb.c
> > @@ -0,0 +1,55 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Module kdb support
> > + *
> > + * Copyright (C) 2010 Jason Wessel
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kdb.h>
> > +#include "internal.h"
> > +
> > +/*
> > + * kdb_lsmod - This function implements the 'lsmod' command.  Lists
> > + *	currently loaded kernel modules.
> > + *	Mostly taken from userland lsmod.
> > + */
> > +int kdb_lsmod(int argc, const char **argv)
> > +{
> > +	struct module *mod;
> > +
> > +	if (argc != 0)
> > +		return KDB_ARGCOUNT;
> > +
> > +	kdb_printf("Module                  Size  modstruct     Used by\n");
> > +	list_for_each_entry(mod, &modules, list) {
> > +		if (mod->state == MODULE_STATE_UNFORMED)
> > +			continue;
> > +
> > +		kdb_printf("%-20s%8u  0x%px ", mod->name,
> > +			   mod->core_layout.size, (void *)mod);
> > +#ifdef CONFIG_MODULE_UNLOAD
> > +		kdb_printf("%4d ", module_refcount(mod));
> > +#endif
> > +		if (mod->state == MODULE_STATE_GOING)
> > +			kdb_printf(" (Unloading)");
> > +		else if (mod->state == MODULE_STATE_COMING)
> > +			kdb_printf(" (Loading)");
> > +		else
> > +			kdb_printf(" (Live)");
> > +		kdb_printf(" 0x%px", mod->core_layout.base);
> > +
> > +#ifdef CONFIG_MODULE_UNLOAD
> > +		{
> > +			struct module_use *use;
> > +			kdb_printf(" [ ");
> > +			list_for_each_entry(use, &mod->source_list,
> > +					    source_list)
> > +				kdb_printf("%s ", use->target->name);
> > +			kdb_printf("]\n");
> > +		}
> > +#endif
> 
> That's a ugly construct. Could it be a function instead that you call 
> from this loop,

Fair enough and I agree; albeit, as you know, this was simply a migration
to kernel/module/kdb.c. We could indeed address this format/or style
concern later.


> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index b8a59b5c3e3a..bcc4f7a82649 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -108,10 +108,6 @@ static void mod_update_bounds(struct module *mod)
> >   		__mod_update_bounds(mod->init_layout.base, mod->init_layout.size);
> >   }
> >   
> > -#ifdef CONFIG_KGDB_KDB
> > -struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
> 
> It should be removed from kernel/debug/kdb/kdb_private.h as well.

Agreed - this was missed.


Thanks,

-- 
Aaron Tomlin

