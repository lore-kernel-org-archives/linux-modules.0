Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AA0C433F5
	for <linux-modules@archiver.kernel.org>; Wed,  2 Mar 2022 16:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiCBQ1M (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 2 Mar 2022 11:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiCBQ1K (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 2 Mar 2022 11:27:10 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9882A9E28
        for <linux-modules@vger.kernel.org>; Wed,  2 Mar 2022 08:26:26 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d3so3662757wrf.1
        for <linux-modules@vger.kernel.org>; Wed, 02 Mar 2022 08:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4lZEInqzBQdxmom04rLGOTBOINe87ZHTNK8A1MHNUYM=;
        b=zNY/A3DvXSSHSOLKYTxwjW4mjiSxKTe2DFTa9drWsknJ9Gobo/rAHMhdkBLLnUF8it
         qObkZaPUtzMcW0vv80UyqbGn/5SqEJm5CWtnqtNf416LbLOH03IHCDcalJaCaNnQqmxa
         n7JOmOog5D44bHsXOE9UR4UELZJ0fyDRKRw2sg464T2pSOZ/8YSImYpJ3+7w/18AZrm/
         QVjeS2JlyxOhcZTWDhqbC0p+x8FcyzIDVLtpp9OSPqij50FzVjYaVMJ8SxAgdZHfT7RG
         faSL3/PPKB61LMyU9PIhxtaqQqPnmwi8mqwaM9f4L8E7gFTt3Hft0K5TWhEtuzuGZbds
         unrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4lZEInqzBQdxmom04rLGOTBOINe87ZHTNK8A1MHNUYM=;
        b=tPExOy+y4NVjIs300rJy1BmXDz0mYfQZHsotSTWVrqOHfiU+8KAIQjHpelrUwz0arP
         jLhszmTjkJEF0QPuN5tz7g1/1moEb/YyaHAfAWPsmbUtjRgGoBhnYLet67A/MP7RG95t
         DjTvAavkEqHbGSQp9ChoHm5thNFvt0dXiWu4m0vfkcJEQbsRIP3xTVitqTdMozWlkOwu
         1IIp1kxwrwxnmIZarz/j/4ZpimH6cO1QvwE2iYObNQy3jr9WRBH9UrDPTaUb29WLkU4Q
         l4wSbHniAvxLyVHOA0QwmSgSWHSlOcUYpydQslEkkNZJSO95/RTFNNRdW5zblgW82yd0
         ef2g==
X-Gm-Message-State: AOAM530nLjdvGxGjv+hEG+2kc0UhZ89ol6KlQZ30Pp6u+8xISMkMkh6e
        ebu5svMWZj9RCTpsDb9Fl7qfdA==
X-Google-Smtp-Source: ABdhPJxbCsWQrJHmYbdS8sJGQSK+IN5/SW7XDx1ANefT8UUiw7YoiSlpX6p5XW4Wc6Ducn8hIA0qbA==
X-Received: by 2002:a5d:52d2:0:b0:1ef:e22d:18ba with SMTP id r18-20020a5d52d2000000b001efe22d18bamr10036216wrv.30.1646238385454;
        Wed, 02 Mar 2022 08:26:25 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id g22-20020a1c4e16000000b003817614d4adsm6068399wmh.12.2022.03.02.08.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 08:26:24 -0800 (PST)
Date:   Wed, 2 Mar 2022 16:26:22 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, pmladek@suse.com,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Message-ID: <20220302162622.z5wxbdmxh2pqh6cb@maple.lan>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302161917.gx5icfszakoye4uh@maple.lan>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Mar 02, 2022 at 04:19:17PM +0000, Daniel Thompson wrote:
> On Mon, Feb 28, 2022 at 11:43:21PM +0000, Aaron Tomlin wrote:
> > No functional change.
> > 
> > This patch migrates kdb_modules list to core kdb code
> > since the list of added/or loaded modules is no longer
> > private.
> > 
> > Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> > ---
> >  kernel/debug/kdb/kdb_main.c    | 5 +++++
> >  kernel/debug/kdb/kdb_private.h | 4 ----
> >  kernel/module/main.c           | 4 ----
> >  3 files changed, 5 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > index 0852a537dad4..5369bf45c5d4 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -59,6 +59,11 @@ EXPORT_SYMBOL(kdb_grepping_flag);
> >  int kdb_grep_leading;
> >  int kdb_grep_trailing;
> >  
> > +#ifdef CONFIG_MODULES
> > +extern struct list_head modules;

Actually thinking a bit harder and trying
`git grep '#include .*[.][.]' kernel/` (which finds some prior art) I
wonder if we even want the extern or whether
`#include "../../module/internal.h"` would be more robust.


Daniel.


> > +static struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
> 
> If modules is no longer static then why do we kdb_modules at all?
> kdb_modules is used exactly once and it can now simply be replaced
> with &modules.
> 
> 
> Daniel.
