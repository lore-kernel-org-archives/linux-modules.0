Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66029C2BBCF
	for <linux-modules@archiver.kernel.org>; Fri, 18 Dec 2020 15:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A77F23B08
	for <linux-modules@archiver.kernel.org>; Fri, 18 Dec 2020 15:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbgLRPCm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 18 Dec 2020 10:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbgLRPCl (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 18 Dec 2020 10:02:41 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7154CC0617A7
        for <linux-modules@vger.kernel.org>; Fri, 18 Dec 2020 07:02:01 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id s26so6142595lfc.8
        for <linux-modules@vger.kernel.org>; Fri, 18 Dec 2020 07:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kycfb3aGsFwFjrMKUq3nfJf2uPOaPiVPYna8srRZHQw=;
        b=qYJzJu/lnQ5FYQILyGU4Cp29Lz1hJBYH5WLeKA/fwScuQy3A9m/Hcx2SNYZllp1/Zj
         MHto3Vr0lQRscngmN8jBELt51FjATQWmGaxe317zl7PdXY1pQSTmlMh5IaJYXxpagocZ
         dtBPBgYEzO4xHOP9BK/lfgkbhV5KNG1o1D9+XnHCJC9bQtsQa3hkaCX0hcWG1NQfRrlC
         6jCLiCZlD5ubkdHCrOJzp6WBdvx/QcInXo3hv1uBOLpEvqsQyXsUnhK81bhbKN8O4hI4
         xA6D3THmX0QfHi2C/pD2RKz4kNnseVdF5KRSC+ix9EWQBRSMD81n7irAg4lRcnNtCAY7
         JeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kycfb3aGsFwFjrMKUq3nfJf2uPOaPiVPYna8srRZHQw=;
        b=fRSk6z+Gcae2wWEdqEPp6Jl/k6kCp8DS8WD6OAvnlyx/VZcVQxn5CHmpsguNBJVZf9
         XKFJvwiKbNY1utnlQWSNqMeL4qcYpVx/SQ4cWQgLEf3e7f2AyWq7WY7B/wNauUyAq4Mu
         CnHP7aeU/MRdRb6gryFb1/iPnvHjvkR7ZjWH3yJA0KkaOx32RFErlct0Whh86ZswU8TK
         tqxZS+hnHseFjoNtXAs46HviaXSb1e0iOkitCXudkDuEuseY1jxdO9O5YH3YfaRh6Vnh
         Y92U0vNpWJVOpR99q4G9GlHOqc+BhXGqAsvUdqVJhJ1ll2fP1O65tE1dVBn9uQer7wB/
         Rdkw==
X-Gm-Message-State: AOAM532P6W6Y/z+uD0FhIvTpcw7psDORrByrSNQSgmJFs0w98lUmsgP7
        kbVQyoGNNHfpDbXJp6CJZINj2gJDil6tEfNI3Gqsf1JQJ4V5SA==
X-Google-Smtp-Source: ABdhPJwZiJOj+lodSWvC+Lx4x416TIjMAmbRcz7/dC/yLfpoCGiChMzb6TmrRiggcrtXxPskQgYWoBbO17maTMPQzXg=
X-Received: by 2002:a2e:2417:: with SMTP id k23mr1978492ljk.373.1608303718462;
 Fri, 18 Dec 2020 07:01:58 -0800 (PST)
MIME-Version: 1.0
References: <5FD2AA34.3000409@cox.net> <CAKi4VAK4LFWZH7LD4nON=AOeO+iZBa8WfvCvhr8uhs9KR8pYqw@mail.gmail.com>
In-Reply-To: <CAKi4VAK4LFWZH7LD4nON=AOeO+iZBa8WfvCvhr8uhs9KR8pYqw@mail.gmail.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Fri, 18 Dec 2020 07:01:46 -0800
Message-ID: <CAKi4VALscaU9WL40sceR+xsqgGDZYFTZ1UPRs44Zcff4FiZyOA@mail.gmail.com>
Subject: Re: lspci: Unable to load libkmod resources: error -12
To:     Joe Buehler <aspam@cox.net>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Dec 18, 2020 at 6:56 AM Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
>
> On Fri, Dec 11, 2020 at 2:19 AM Joe Buehler <aspam@cox.net> wrote:
> >
> > When running lspci -v on Ubuntu 20.40, I get the error message:
> >
> > lspci: Unable to load libkmod resources: error -12
> >
> > I tracked this down to a possible libkmod issue.  The kernel I am using
> > has an empty modules.builtin.aliases.bin file (modules.builtin.aliases
> > does not exist).
>
> It is indeed a little bit confusing, but modules.builtin.alias.bin is
> created from
> modules.builtin.modinfo that should come with the kernel.  Is this a
> custom kernel or
> one from the distro? modules.builtin.alias.bin should either not exist
> (in case the kernel
> doesn't have modules.builtin.modinfo) or should be a valid index.
>
> Indeed depmod doesn't create the file unless it has something to
> write. I wonder if the error wasn't
> because the call to depmod failed for some reason (out of space?).
>
> Looking at a ubuntu 20.04 system I do have both
> modules.builtin.modinfo and modules.builtin.alias.bin. If I remove
> modules.builtin.modinfo and call
> depmod -a, then the latter is not created.

oops, it turned out I was looking in the wrong directory. That should
be the behavior, but
it's not and and empty modules.builtin.alias.bin is being created.

Let me take a closer look what's going on.

thanks
Lucas De Marchi

>
> Lucas De Marchi
>
> >
> > kmod_load_resources() doesn't like this.  It calls index_mm_open() which
> > checks the file size, sees that it is less than sizeof(hdr), error
> > terminates, causing kmod_load_resources() to return -ENOMEM.
> >
> > kmod version 27 as shipped with ubuntu 20.04
> >
> > Please copy me on any responses, I am not on this list.
> >
> > Joe Buehler
> >
