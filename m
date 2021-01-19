Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF5CC433DB
	for <linux-modules@archiver.kernel.org>; Tue, 19 Jan 2021 20:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EAE02310B
	for <linux-modules@archiver.kernel.org>; Tue, 19 Jan 2021 20:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389723AbhASUjD (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 19 Jan 2021 15:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbhASUhw (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 19 Jan 2021 15:37:52 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B9CC061574
        for <linux-modules@vger.kernel.org>; Tue, 19 Jan 2021 12:37:12 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id p13so23524663ljg.2
        for <linux-modules@vger.kernel.org>; Tue, 19 Jan 2021 12:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6WnKN0/tn3kpJLMiXRss/Q3cFt4bj7ZDAh7ftb7ov8I=;
        b=k8trYf33oXL6QPG2JPaUeEr3Ynf7NPt8R6OkOmKTLDsBfTDoFVG3G50apeeYTJT0IY
         6ZwQHktu1o1SU0WtvSEUYqEFoeoeHtvCO4fNiRu7LHlORGeh/7bhKeNCQ4oKP1HdCjTt
         YZL7ZKiC1WOmy8xdtijczesgvFrtZjU9+xAdTOtmXiyvT/oEUbf8rYfmiAJoeqTZXH0D
         4oKJnbsiD8inEFNDbfIDbSCciKRjCutApJlA/pPFiqGtsaYfsYppS5tHThaSwN/a4sJN
         ve50htXX8p2sIWD8Y+QVe8U7ie+4aMzRZ3lKNXto7WZTzLMUAMKqr9QwdQ5+nu659mOg
         v9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6WnKN0/tn3kpJLMiXRss/Q3cFt4bj7ZDAh7ftb7ov8I=;
        b=S1AXT24mXBtBFb6KPCZd7h5DygMVgZr7VRiiVRPjYUKgCLZHWvOvjgMeZHHmVz8JYj
         +8kaFSukJe829rcQBlbs0mo0f2qM5TdagPGyImjkkJ/eHk0KrygcetcQ+LZC24/kwr8/
         wA6dj42Ldu7KWIOkYLpbPK3S38crUkU2GwC8wyFeyAK2gQao9Nj3dKWdOxSkiqFcU7Ra
         ficrIcCQf2NFyYZjmgK13EdCKiK/CdaKZNqOR76VXuL0DXyYIfriS3V5r3Fj8EOSdzp0
         s65sPzgt2fANPv4Yi1f2qCTDHGADHfKl4pei34e5NXG+B6lHcPzdzvkohiXdzjttWXDq
         K3MQ==
X-Gm-Message-State: AOAM531yutn7JrkSXVlgitHILstd9W8Wkpb1To6bDNPzx49EcDt6svW9
        uT9RUfUWQNlZqpjchvTjp9L2FLPehVQBCHwMTcs=
X-Google-Smtp-Source: ABdhPJzZvqUD6kfZXrpe26eJ6OlR9GXUfl4Q9IlX4n2H6M4Wdh/0VQAFY1TofkadRuRhg0oYirmLze6sOxcJj0zpCCQ=
X-Received: by 2002:a05:651c:1397:: with SMTP id k23mr923043ljb.332.1611088630911;
 Tue, 19 Jan 2021 12:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20210119145238.12774-1-lucas.demarchi@intel.com>
 <20210119145238.12774-2-lucas.demarchi@intel.com> <20210119183130.GA10896@altlinux.org>
In-Reply-To: <20210119183130.GA10896@altlinux.org>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Tue, 19 Jan 2021 12:36:57 -0800
Message-ID: <CAKi4VAL5GUSf__XzY6EeDRkno1qq62p3FAV7rRkESVakjzocHA@mail.gmail.com>
Subject: Re: [PATCH 2/3] depmod: fix precedence order
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-modules <linux-modules@vger.kernel.org>,
        Jan Tojnar <jtojnar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jan 19, 2021 at 10:35 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> On Tue, Jan 19, 2021 at 06:52:37AM -0800, Lucas De Marchi wrote:
> > Configuration in /etc should have higher prio than /run.
>
> Should it?  Isn't the common practice nowadays to have /run override /etc?

Doesn't make much sense as /run can be derived from /usr/lib. /etc is
what the system
administrator touches and should have the final say.

Man pages from systemd agree with this logic:

    <title>Configuration Directories and Precedence</title>

    <para>Configuration files are read from directories in
<filename>/etc/</filename>,
    <filename>/run/</filename>, <filename>/usr/local/lib/</filename>,
and <filename>/usr/lib/</filename>, in
    order of precedence, as listed in the SYNOPSIS section above.
Files must have the the
    <literal>.conf</literal> extension. Files in
<filename>/etc/</filename> override files with the same name
    in <filename>/run/</filename>, <filename>/usr/local/lib/</filename>, and
    <filename>/usr/lib/</filename>. Files in
<filename>/run/</filename> override files with the same name
    under <filename>/usr/</filename>.</para>

Lucas De Marchi

>
> > Given how rarely configuration in /run is used with depmod, this is
> > likely not to cause any problems, even if it's a change in behavior.
> > ---
> >  tools/depmod.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/depmod.c b/tools/depmod.c
> > index 3f31cdf..8e1d9ec 100644
> > --- a/tools/depmod.c
> > +++ b/tools/depmod.c
> > @@ -51,8 +51,8 @@ static int verbose = DEFAULT_VERBOSE;
> >  static const char CFG_BUILTIN_KEY[] = "built-in";
> >  static const char CFG_EXTERNAL_KEY[] = "external";
> >  static const char *default_cfg_paths[] = {
> > -     "/run/depmod.d",
> >       SYSCONFDIR "/depmod.d",
> > +     "/run/depmod.d",
> >       "/lib/depmod.d",
> >       NULL
> >  };
>
> --
> ldv
