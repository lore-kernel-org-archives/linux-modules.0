Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2360AC433ED
	for <linux-modules@archiver.kernel.org>; Sat, 15 May 2021 22:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3AF561108
	for <linux-modules@archiver.kernel.org>; Sat, 15 May 2021 22:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbhEOWdO (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 15 May 2021 18:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhEOWdM (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 15 May 2021 18:33:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C29DC061573
        for <linux-modules@vger.kernel.org>; Sat, 15 May 2021 15:31:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i22so3372455lfl.10
        for <linux-modules@vger.kernel.org>; Sat, 15 May 2021 15:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0p8YiEIAs4RZAI5PIRWQJw7kZcCs1gXXVVCIA7ZNKY=;
        b=izdM++wyKoCoSB4QKsc3S1Hlv7lfWh1xV7Hhy8eUuqVO949mZBgn3X9Zm2hNifnIAr
         LzBSMZTYx8NrgcCYuHv6yb05EgTnsJhFVj9iq1sRHqLujefwz7+rPmtrEMzWdkZl3gj2
         xGAHjX75oDBtUwogxy5s+29yhRQzI41TX78kagoagANdLPu5+Zuzl2MkQoJfTGmdWB4T
         F1jjrWJna/BqCotoSMjEuVp4KEsuCOf15JnVyiZhgQ0wL4yaJMjv8vm7U3tCalKHmGB4
         xhiLXqa0/tzb39q7bwmgeSfU1iQ/Yed9Javuxw9PJvc6HXD8vr8eIwNMVSpM1IEdSqjr
         HoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0p8YiEIAs4RZAI5PIRWQJw7kZcCs1gXXVVCIA7ZNKY=;
        b=ZiRe81quFsNbCPds4lf3XA/c4DK934AlyCQMAJD4ewGpr7wHO014/UJARgRz+9vajC
         UBxs6lWCyrt2AUZfbQ21+dmzN/esgvdfad4MpDkTeAS0Zdan0VQsiqYrRz1+IaS9pHGs
         o7UjM1p0QAIyT2iNmhVKzztjiIpIPlQiPnvdfTh6/kYhxRUNGWlLysG6MPHm1kmyarQY
         ChPZyHCyqFunWb73GkqrybIs967PMs3CTD2vzf8vGfGfmhysdRAqlPXy/w/EZG0TwQEj
         z2WzR99qlf7SGUm4QG0n3aI13ZJ9aHwTTr+WP94kfUg1VvLnzieilIHXVjHUC3WowXA6
         lW7Q==
X-Gm-Message-State: AOAM530C5/Egp44m3EJ2J23AF8BDWNZ31zwkI6TBPPfjLYWVxowKmoRH
        t9u5Ng9c3wefZo+CWK/lfKe+fujrIxZPGdzcmOI=
X-Google-Smtp-Source: ABdhPJxRy1ExaEVoNK+DsQwKufASjHRP+c5etcKEzvXbbqWccxKfs5yWBpnB0gBxmGeHbLm6gOsIy2CjZw3WK/Dc1zA=
X-Received: by 2002:ac2:5602:: with SMTP id v2mr36216054lfd.23.1621117916370;
 Sat, 15 May 2021 15:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210503105347.979635-1-rvarghes@redhat.com>
In-Reply-To: <20210503105347.979635-1-rvarghes@redhat.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Sat, 15 May 2021 15:31:44 -0700
Message-ID: <CAKi4VA+QqSkZMk+8=-9j7qH+_e7CRjW1mc+tVZ2V9Y+f=khe0w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Introduce inclusive language in kmod
To:     Reuben Varghese <rvarghes@redhat.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, May 3, 2021 at 3:54 AM Reuben Varghese <rvarghes@redhat.com> wrote:
>
> In July 2020, linux moved to adopt inclusive and neutral language.
> This includes replacing words slave/master with alternative terms
> like primary/secondary or the words blacklist/whitelist with
> blocklist/passlist.
>
> This patchset aims at editing the existing kmod code to make it inclusive.
> This is mainly achieved by refactoring the blacklist command to blocklist.
>
> The first patch refactors the term and updates the relevant documentation.
>
> Since changing blacklist to blocklist and completely removing support for the
> term blacklist will most likely break many systems, temporary support for the
> term blacklist with a warning is introduced as part of the fallback patch.

no warning should be added. The conf file with the blacklist command
spans through
OS packages and system administrators' files.

> That being said, two possible approaches of phasing out the term
> blacklist are listed below:
> Approach 1: The moment the word blacklist is seen when reading the config file,
> overwrite it to blocklist in the user's config file. The benefit of this approach
> would be that we could stop support for the term blacklist immediately while at
> the same time not breaking any systems.

that is out of question. You can't write to the system's config file.
The fs may even be readonly,
or you may actually be writing to initrd instead of rootfs

>
> Approach 2: Add a warning each time the term blacklist is encountered.
> This is the approach that is currently implemented. It is less aggresive
> than approach 1 and serves the purpose of removing the term blacklist from
> most places in the code.

As I said, no warning should be added... That would be, I guess, option 3.

thanks
Lucas De Marchi

>
> Reuben Varghese (2):
>   Refactor all instances of blacklist to blocklist and update
>     documentation
>   Continue temporary support for Blacklist command with warnings
>
>  Makefile.am                                   |  6 +--
>  NEWS                                          | 12 ++---
>  libkmod/docs/libkmod-sections.txt             |  4 +-
>  libkmod/libkmod-config.c                      | 50 ++++++++++--------
>  libkmod/libkmod-internal.h                    |  4 +-
>  libkmod/libkmod-module.c                      | 52 +++++++++----------
>  libkmod/libkmod.h                             | 12 ++---
>  libkmod/libkmod.sym                           |  4 +-
>  libkmod/python/kmod/_libkmod_h.pxd            |  2 +-
>  libkmod/python/kmod/kmod.pyx                  |  2 +-
>  man/modprobe.d.xml                            |  8 ++-
>  man/modprobe.xml                              |  4 +-
>  testsuite/.gitignore                          |  6 +--
>  .../etc/modprobe.d/modprobe.conf              |  2 -
>  .../etc/modprobe.d/modprobe.conf              |  2 +
>  .../{test-blacklist.c => test-blocklist.c}    | 12 ++---
>  tools/insert.c                                |  6 +--
>  tools/modprobe.c                              | 18 +++----
>  18 files changed, 109 insertions(+), 97 deletions(-)
>  delete mode 100644 testsuite/rootfs-pristine/test-blacklist/etc/modprobe.d/modprobe.conf
>  create mode 100644 testsuite/rootfs-pristine/test-blocklist/etc/modprobe.d/modprobe.conf
>  rename testsuite/{test-blacklist.c => test-blocklist.c} (90%)
>
> --
> 2.27.0
>
