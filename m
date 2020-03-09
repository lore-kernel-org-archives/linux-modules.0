Return-Path: <SRS0=HmkN=42=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF65C18E5A
	for <linux-modules@archiver.kernel.org>; Mon,  9 Mar 2020 21:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7679524649
	for <linux-modules@archiver.kernel.org>; Mon,  9 Mar 2020 21:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8eBMvI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgCIVqm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:46:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45000 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgCIVqm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 9 Mar 2020 17:46:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id l18so3079436wru.11
        for <linux-modules@vger.kernel.org>; Mon, 09 Mar 2020 14:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AOhhB2Fc39lg16ZknPdUgiRi4tEWjBxo94H3EZGlQdg=;
        b=K8eBMvI1Tex3kd22mHdMQV4Imv/awKs3zOqYTb7B7LWeCUkeBHikH5Jdh4dXvdbW0E
         s/nye7yfT+kkZzfzT7a2Rxe5MufKLQq3QGhG+7eqEmfQaanaevfDKE2l/y6/LhmLX1Fz
         VV4OvMj+iCdHI8G8Nw5PvfuresSv6nEtM3jQA0RljCoMF58iLuKPs8XYE+Ca7qqA3ytB
         lnXO+IUm3Hj6TT8knMmhU4qbDyqH5jdt80wrylXa5mjlM+DYX9LpjYsBazG6TgN9Cb25
         OBkVpejUZ0vv23rgjxXClZggAz/RzVDJsxAMssOCFJidn7wqUzMuHQlmipjvWmCxjGsE
         8J4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AOhhB2Fc39lg16ZknPdUgiRi4tEWjBxo94H3EZGlQdg=;
        b=Aw3e/KFH+0wlF9i3LBbKiJbXQNpRYT4A+tpdZnIXwbU7pnt+7sgFyEKTwpTanL/r/g
         U3qVZ0Ksd3KQiSaxsPpfhy0OoWIcLxCrAvqLEHHFW19Bv4xtdu8esXfgq19/iE1OzYGP
         6eUOr8AICjSpWJNEhkjiuuw5mMnMk0I+8esVX+PjhQ1FhCLn9PQw+y4aefioHO6Upcsi
         p6lBDQUYz0es4TDgESqsHRgjm7kKBhg8zWmoPEW73dq+VihTkM6o9F0nf7LCQhkGhCZj
         t0qKiFxEnEWCilJtQEFYMFQGNo0rBPW9nA1DzOR0Y564Q388D8YBu2MLTzliUVOeylK8
         tpFg==
X-Gm-Message-State: ANhLgQ3ptRtyo9YrRuOmtS7rVV/jE7QAm+xD1rQfQaAWuuH+QpddB96B
        npm+maOm4E7EjfUXrZ0zZNiI4swAPGrdbzdwjIM=
X-Google-Smtp-Source: ADFU+vvnmu2A+c4PiPOzgax+bxk9GQ9bWhTv1aFJXVqMcKAfJ4R7iX48nNhAvAfvoVvJ3lpCeJbevmp/4K+WsjPA9aM=
X-Received: by 2002:adf:aa0e:: with SMTP id p14mr23405344wrd.399.1583790398410;
 Mon, 09 Mar 2020 14:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200306075934.3104-1-lucas.demarchi@intel.com>
 <20200306075934.3104-2-lucas.demarchi@intel.com> <20200306095825.qmnothvjjemjwh7u@comp-core-i7-2640m-0182e6>
In-Reply-To: <20200306095825.qmnothvjjemjwh7u@comp-core-i7-2640m-0182e6>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Mon, 9 Mar 2020 14:46:25 -0700
Message-ID: <CAKi4VA+QDwsoyqPKA4UJTCJ-K600WEAb8tg9FuwWvnQNe7cPUA@mail.gmail.com>
Subject: Re: [PATCH 2/2] depmod: just add .bin suffix to builtin.modinfo
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-modules <linux-modules@vger.kernel.org>,
        Yanko Kaneti <yaneti@declera.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Mar 6, 2020 at 1:58 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> On Thu, Mar 05, 2020 at 11:59:34PM -0800, Lucas De Marchi wrote:
> > For all the other indexes what we do is to add a .bin to the original
> > filename to denote it's the indexed version of that file. It was
> > kernel's decision to name it modules.builtin.modinfo, so respect that.
> >
> > Fix: b866b2165ae6 ("Lookup aliases in the modules.builtin.modinfo")
> > ---
> >  tools/depmod.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/depmod.c b/tools/depmod.c
> > index 875e314..fe1c54d 100644
> > --- a/tools/depmod.c
> > +++ b/tools/depmod.c
> > @@ -2402,7 +2402,7 @@ static int output_devname(struct depmod *depmod, FILE *out)
> >       return 0;
> >  }
> >
> > -static int output_builtin_alias_bin(struct depmod *depmod, FILE *out)
> > +static int output_builtin_modinfo_bin(struct depmod *depmod, FILE *out)
> >  {
> >       int ret = 0, count = 0;
> >       struct index_node *idx;
> > @@ -2482,7 +2482,7 @@ static int depmod_output(struct depmod *depmod, FILE *out)
> >               { "modules.symbols", output_symbols },
> >               { "modules.symbols.bin", output_symbols_bin },
> >               { "modules.builtin.bin", output_builtin_bin },
> > -             { "modules.builtin.alias.bin", output_builtin_alias_bin },
> > +             { "modules.builtin.modinfo.bin", output_builtin_modinfo_bin },
>
> This file does not contain all whole modinfo. Now the function name and
> index name will be confusing. But it's up to you.

Indeed. I'd also have to fix the libkmod counterpart, otherwise it
would look for the wrong file.
This index contains only the alias -> module, like our modules.alias file.

I think it would be better to leave it with this name.  It would
probably be good to output
modules.builtin.alias though to make it similar to the
modules.alias/modules.alias.bin case.
Another option is to just add those aliases to modules.alias and
lookup modules.builtin to decide
if that's builtin, but I  think I prefer to keep them separate.

thanks
Lucas De Marchi


>
> >               { "modules.devname", output_devname },
> >               { }
> >       };
> > --
> > 2.25.1
> >
>
> --
> Rgrds, legion
>


-- 
Lucas De Marchi
