Return-Path: <SRS0=uawh=4P=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32FFC4BA24
	for <linux-modules@archiver.kernel.org>; Thu, 27 Feb 2020 11:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9CF2468E
	for <linux-modules@archiver.kernel.org>; Thu, 27 Feb 2020 11:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgB0LJT (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:09:19 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:55692 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgB0LJT (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 27 Feb 2020 06:09:19 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 5F40172CCF1;
        Thu, 27 Feb 2020 14:09:17 +0300 (MSK)
Received: from boyarsh.office.basealt.ru (unknown [83.220.44.62])
        by imap.altlinux.org (Postfix) with ESMTPSA id 233964A4A16;
        Thu, 27 Feb 2020 14:09:17 +0300 (MSK)
Date:   Thu, 27 Feb 2020 14:09:15 +0300
From:   "Anton V. Boyarshinov" <boyarsh@altlinux.org>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>, legion@altlinux.org
Subject: Re: [PATCH v2] Add kernel-version dependent configuration directory
Message-ID: <20200227140915.7fa32b2e@boyarsh.office.basealt.ru>
In-Reply-To: <CAKi4VA+8o=3HASrtuFNwts35q09xR_bUAY8Bd8_tc0ebj4DZ=g@mail.gmail.com>
References: <20200226133221.44342a57@table.localdomain>
        <CAKi4VA+8o=3HASrtuFNwts35q09xR_bUAY8Bd8_tc0ebj4DZ=g@mail.gmail.com>
Organization: BaseALT
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-alt-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


> Thanks for the patch, I really like the idea of supporting this. I
> have some suggestions below.

Thank you for review. 
> >
> > -       if (config_paths == NULL)
> > -               config_paths = default_config_paths;
> > -       err = kmod_config_new(ctx, &ctx->config, config_paths);
> > +       if (config_paths == NULL) {
> > +               char **tmp_config_paths = malloc(sizeof(default_config_paths) +
> > +                               sizeof(char *) * 2);  
> 
> See documentation above this function. This breaks the case in which
> the supplied array is empty,
> i.e. a single NULL element.

Yes, i haven't read it carefully enouth, but it can be easyly fixed by checking
first element.
 
> I wonder if for implementing this it wouldn't be better to leave this
> function alone and implement it
> in kmod_config_new():

But how to distinguish in mod_config_new(): are provided config pointer
default config and needs version-dep paths adding or it is a custom config?
I've considered this options but haven't found a straight way to do this.
 
> 1) we create ctx->kver that points to the end of ctx->dirname. If
> dirname is NULL in kmod_new(), then
> it's assumed we are actually not running for the current kernel, so we
> might leave this logic alone.

AFAIK in reverse, if dirname is NOT NULL, we a not running for the current kernel.
And you are right, my patch will cause evil effects when not current kernel is 
specified. Not a problem for modprobe, but it is common code.
 
> 2) conf_files_list(): after "opendir(path)" we try a opendirat(d,
> ctx->kver...) and just ignore if it doesn't exist.

But should we try to open versions-dependent dirs in user-specified dirs?
It looks unexpected, considering user-specified dirs semantics.
 
> then we run the rest of the logic as usual.
> 
> This should ensure that a) we don't break the API, b) we honor dirname
> == NULL meaning "don't treat this ctx as
> one for the currently running kernel" and also c) we allow
> kernel-version subdirs for a user-provided list.
> What do you think?
> 
> 
> Lucas De Marchi
> 
> > +               if(tmp_config_paths == NULL) {
> > +                       ERR(ctx, "could not create versioned
> > config.\n");
> > +                       goto fail;
> > +               }
> > +
> > +               memcpy(tmp_config_paths, default_config_paths,
> > sizeof(default_config_paths)); +
> > +               configs_count = ARRAY_SIZE(default_config_paths);
> > +               tmp_config_paths[configs_count-1] =
> > get_ver_config_path("/lib");
> > +               tmp_config_paths[configs_count] =
> > get_ver_config_path(SYSCONFDIR);
> > +               tmp_config_paths[configs_count+1] = NULL;
> > +
> > +               err = kmod_config_new(ctx, &ctx->config, (const
> > char * const*) tmp_config_paths); +
> > +               free(tmp_config_paths[configs_count-1]);
> > +               free(tmp_config_paths[configs_count]);
> > +               free(tmp_config_paths);
> > +       }
> > +       else
> > +               err = kmod_config_new(ctx, &ctx->config,
> > config_paths); +
> >         if (err < 0) {
> >                 ERR(ctx, "could not create config\n");
> >                 goto fail;
> > diff --git a/man/modprobe.d.xml b/man/modprobe.d.xml
> > index 211af84..d1e254a 100644
> > --- a/man/modprobe.d.xml
> > +++ b/man/modprobe.d.xml
> > @@ -41,7 +41,9 @@
> >
> >    <refsynopsisdiv>
> >      <para><filename>/lib/modprobe.d/*.conf</filename></para>
> > +    <para><filename>/lib/modprobe.d/`uname
> > -r`/*.conf</filename></para>
> > <para><filename>/etc/modprobe.d/*.conf</filename></para>
> > +    <para><filename>/etc/modprobe.d/`uname
> > -r`/*.conf</filename></para>
> > <para><filename>/run/modprobe.d/*.conf</filename></para>
> > </refsynopsisdiv>
> >
> > --
> > 2.21.0
> >
> >  
> 
> 
> -- 
> Lucas De Marchi
