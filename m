Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280DDC3F6B0
	for <linux-modules@archiver.kernel.org>; Wed, 27 Jul 2022 18:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243302AbiG0SIF (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 27 Jul 2022 14:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243281AbiG0SHs (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 27 Jul 2022 14:07:48 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADB2C7ACA
        for <linux-modules@vger.kernel.org>; Wed, 27 Jul 2022 10:11:22 -0700 (PDT)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 059553F139
        for <linux-modules@vger.kernel.org>; Wed, 27 Jul 2022 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658941881;
        bh=H/YoNoMBJ5KLzizvRdlp2kaTQKAcETzt8x9wjboShNc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Vqy05hNpFCzYlr1ssgPhlMHFJOpGyVHDLtskRE5gMz/iWUTD1PlJPgYAzNgVcWRBv
         8P7GMT/z+xqovntmaVVR3pb/hAV+l0UY7azSZ1h0EeZXJUAI5JcWNG8NImkPyYB4QI
         Pu0AhH2QqBDaqnyJb0kbzAlYLkQw1rmIUDCCfcjfI1Kx4tfBbPr7ygxvxfD0bOADl8
         +kh82y5nEcdvgPQsLfMMFUXIpShqu6zzdnp09Gw52sQUy6kuUYKewUTbX4gXSTRIG2
         64YoHuLVFJ3z5ofLHZbgG15DCBSq4zdwlAQDwG6yDilvUXeB7tm+On9B5jDLRgBbiH
         L3O3klykmnXgA==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-10d7a610a64so9340940fac.7
        for <linux-modules@vger.kernel.org>; Wed, 27 Jul 2022 10:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/YoNoMBJ5KLzizvRdlp2kaTQKAcETzt8x9wjboShNc=;
        b=oXXypISq9In2nHPRQ313kP8xPP6LkKgNZB2u5D4ChndlGmlRkDjSxvsNQSoSbjbN7F
         d+Ho2nK68kt0Dqtiw4iYtdHNWyHGxB/5K6w2WS4GqNEq5TM0+nYjVnCqoSofphdpXaZe
         2czQHTg8J9xAxwycxVikcXSlS8fmPbWg3fV6rdo7BS55shbWsdGgCOt2nHjNfT/XA1/H
         gKWytnSuR7KVHeDpIUnlRf9Fz+xeexSPamzCNpF9BLLQxSHNELSq3ENv7hCRetpQ6Dwp
         xOpN+V66/BBjuFlKUQNO75Ap12ZaaLMGYYw3ovHk3E6dZHPeLYG847he8F/tkLN/0X/9
         j/QA==
X-Gm-Message-State: AJIora/4xvSGh3sPmkTJvq5/Uw98HwGp6IqnnC0FY2PwqAjqsbOUw3X8
        eHcch5DLBnEY+DZnd4UasGGxrb79Y6sd3/2GUVj2i44VsZjGYhL/pA9WnbgyYszBB5rXXJ0q3dM
        m3qWgQ/RF0rI9lTmpzTmFa47oL5tKQL1g1ZU4+qlk9P93EmfRPVA/5+F5pA8=
X-Received: by 2002:a9d:2602:0:b0:61c:30c1:fa03 with SMTP id a2-20020a9d2602000000b0061c30c1fa03mr9316717otb.86.1658941879713;
        Wed, 27 Jul 2022 10:11:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sUAq7yzvxs08MQ/1pmGOGHFSPETa6NtLulFJUJqWOK5wr+vL658B/OM4yj6drYQZjU8O1hrMUjyEk+FKH3IyE=
X-Received: by 2002:a9d:2602:0:b0:61c:30c1:fa03 with SMTP id
 a2-20020a9d2602000000b0061c30c1fa03mr9316702otb.86.1658941879435; Wed, 27 Jul
 2022 10:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220722022416.137548-1-mfo@canonical.com> <20220722022416.137548-7-mfo@canonical.com>
 <CAK7LNARbSjmZgp1vg5m2j4oRYHgCUv7Wsj+4-OYdo9Cpe0Xs3A@mail.gmail.com>
In-Reply-To: <CAK7LNARbSjmZgp1vg5m2j4oRYHgCUv7Wsj+4-OYdo9Cpe0Xs3A@mail.gmail.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Wed, 27 Jul 2022 14:11:08 -0300
Message-ID: <CAO9xwp33Q9ksED_MxPFJYT=DSsEX5=g_C-b5mcF4irU9dy6Vaw@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] sysctl: introduce /proc/sys/kernel/modprobe_sysctl_alias
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jul 26, 2022 at 6:24 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Jul 22, 2022 at 11:24 AM Mauricio Faria de Oliveira
> <mfo@canonical.com> wrote:
> >
> > The goal of the earlier patches is to let sysctl userspace tools
> > load the kernel module with a sysctl entry that is not available
> > yet in /proc/sys/ when the tool runs (so it can become available).
> >
> > Let's expose this file for userspace for two reasons:
> >
> > 1) Allow such tools to identify that the running kernel has the
> >    code which produces sysctl module aliases, so they could run
> >    'modprobe sysctl:<entry>' only when it may actually help.
> >
> > 2) Allow an administrator to hint such tools not to do that, if
> >    that is desired for some reason (e.g., rather have the tools
> >    fail if something is misconfigured in a critical deployment).
>
> This flag is just a hint.
> User-space tools are still able to ignore it.
>
> Perhaps, such administrator's choice might be specified in
> tools' configuration file.
>
> For example,
>
> /etc/modprobe.d/forbid-sysctl-alias.conf
>
> may specify
>
>     blacklist:  sysctl:*
>
> if they want to forbid sysctl aliasing.
> (but I do not know if this works or not).

Yes, it's just a hint. I considered this isn't strong enough, but
didn't think more into it.

Now, your idea with modprobe.d is strong enough. We have to change it a bit, as
only 'alias' supports wildcards per modprobe.d(5), then add 'install'
to make sure.

# cat /etc/modprobe.d/disable-sysctl-alias.conf
alias sysctl:* sysctl_alias_off
install sysctl_alias_off /bin/false
# or /bin/true, per the sysadmin.

# modprobe sysctl:nf_conntrack_max
modprobe: ERROR: ../libkmod/libkmod-module.c:990 command_do() Error
running install command '/bin/false' for module sysctl_alias_off:
retcode 1
modprobe: ERROR: could not insert 'sysctl_alias_off': Invalid argument

I'll document this in the commit message for now.

P.S.: Since the flag is a hint to userspace tools in sense 1) as well
(so they know not to run modprobe if sysctl aliases aren't expected),
the idea or the file itself seems worth keeping -- but maybe differently.

Thanks,


>
>
>
>
>
>
>
>
>
>
>
>
>
>
> > Also add a module parameter for that (proc.modprobe_sysctl_alias),
> > for another method that doesn't depend on sysctl tools to be set
> > (that wouldn't fail them to try and set it if it's not there yet).
> >
> > Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> > ---
> >  fs/proc/proc_sysctl.c  | 8 ++++++++
> >  include/linux/module.h | 1 +
> >  kernel/sysctl.c        | 9 +++++++++
> >  3 files changed, 18 insertions(+)
> >
> > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > index ebbf8702387e..1e63819fcda8 100644
> > --- a/fs/proc/proc_sysctl.c
> > +++ b/fs/proc/proc_sysctl.c
> > @@ -33,6 +33,14 @@ static void check_struct_sysctl_device_id(void)
> >         BUILD_BUG_ON(offsetof(struct sysctl_device_id, procname)
> >                         != offsetof(struct ctl_table, procname));
> >  }
> > +
> > +/*
> > + * Hint sysctl userspace tools whether or not to run modprobe with sysctl alias
> > + * ('modprobe sysctl:entry') if they cannot find the file '/proc/sys/.../entry'
> > + */
> > +int modprobe_sysctl_alias = 1;
> > +module_param(modprobe_sysctl_alias, int, 0644);
> > +
> >  #else
> >  static void check_struct_sysctl_device_id(void) {}
> >  #endif
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 3010f687df19..5f565491c596 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -304,6 +304,7 @@ struct notifier_block;
> >  #ifdef CONFIG_MODULES
> >
> >  extern int modules_disabled; /* for sysctl */
> > +extern int modprobe_sysctl_alias; /* for proc sysctl */
> >  /* Get/put a kernel symbol (calls must be symmetric) */
> >  void *__symbol_get(const char *symbol);
> >  void *__symbol_get_gpl(const char *symbol);
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 15073621cfa8..b396cfcb55fc 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -1763,6 +1763,15 @@ static struct ctl_table kern_table[] = {
> >                 .mode           = 0644,
> >                 .proc_handler   = proc_dostring,
> >         },
> > +#ifdef CONFIG_PROC_SYSCTL
> > +       {
> > +               .procname       = "modprobe_sysctl_alias",
> > +               .data           = &modprobe_sysctl_alias,
> > +               .maxlen         = sizeof(modprobe_sysctl_alias),
> > +               .mode           = 0644,
> > +               .proc_handler   = proc_dointvec,
> > +       },
> > +#endif
> >         {
> >                 .procname       = "modules_disabled",
> >                 .data           = &modules_disabled,
> > --
> > 2.25.1
> >
>
>
> --
> Best Regards
> Masahiro Yamada



--
Mauricio Faria de Oliveira
