Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE47C7EE29
	for <linux-modules@archiver.kernel.org>; Fri, 26 May 2023 01:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjEZBkh (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 25 May 2023 21:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjEZBkf (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 25 May 2023 21:40:35 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10CB194
        for <linux-modules@vger.kernel.org>; Thu, 25 May 2023 18:40:33 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f3baf04f0cso148815e87.1
        for <linux-modules@vger.kernel.org>; Thu, 25 May 2023 18:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685065232; x=1687657232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mm58cdLmSJ5zDiAtA58RWN5FnFQJSGcvSIirliOWuIM=;
        b=AN6ZZ1Qjb6GJB6OOue81HlYulO12nT8LuSYRzZ0y4HV/gQHoBctoL5TISEiLDs3uvy
         AkVTh5fjLDoCDdazn1geNALlcrztjRAvJmnUeZgiC6MiYi4XhgeUoKnkkPvWAfYvA4Up
         mb4jExcl2SpfLJzjScukXuv9pkCF/OdxNsySA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685065232; x=1687657232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mm58cdLmSJ5zDiAtA58RWN5FnFQJSGcvSIirliOWuIM=;
        b=lwOljM46jOtXrXfD3jsU5NP4+HQqIk9eot+kUvM00A/PUNztOQdzfPPMUVAivnJHQb
         KuX8+IBzjO+NnJGDbLJBrc3yfgIWwefHbBKaulXcpHiyGnat80WAfXwMSuyeFuQFfV6j
         XfTCjwhB6nfLG2b2EcrbufXngs39xwPa4GAxCuoRBKqOogDxGdkgNXNsC1QXJm+DUu/1
         wXCZOsWPLq25DAO9ouan30g0QxpCitY03TT5eHLc97w7NpuFd1qUKXeOV33pPg+ivYC/
         8NZo0yxC0HjL4fFu3erUeJzkBYAMsqef2SYdN6zVMGiPL4D2kGJyrEZAynIlk8Rt2bvP
         E1Og==
X-Gm-Message-State: AC+VfDxjYXU59dmdyHU5e5AnSXHoOsR3ECjsl4JLRK4XFvyoX21/cMTW
        k+FOB2I0K9JEoiZk/iOBHRMVXQqvuxu/XNS8Ilt/Z/lV
X-Google-Smtp-Source: ACHHUZ6FywRug6GoJMg9jz4/ykLxtrKjwCwzzbpdZcF3s/9JCAF7zPCMxTWg7I+V2kt5/0n5qsZflA==
X-Received: by 2002:a19:7619:0:b0:4f3:aa74:2faf with SMTP id c25-20020a197619000000b004f3aa742fafmr29645lff.6.1685065231916;
        Thu, 25 May 2023 18:40:31 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id m7-20020a056512014700b004eaeb0a984csm407482lfo.88.2023.05.25.18.40.30
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 18:40:31 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f3edc05aa5so140030e87.3
        for <linux-modules@vger.kernel.org>; Thu, 25 May 2023 18:40:30 -0700 (PDT)
X-Received: by 2002:a17:907:31c3:b0:96f:912d:7922 with SMTP id
 xf3-20020a17090731c300b0096f912d7922mr478321ejb.53.1685065209995; Thu, 25 May
 2023 18:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-3-mcgrof@kernel.org>
 <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com> <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
 <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
 <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com> <ZG/a+nrt4/AAUi5z@bombadil.infradead.org>
In-Reply-To: <ZG/a+nrt4/AAUi5z@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 18:39:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
Message-ID: <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, May 25, 2023 at 3:02=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> So yeah definitely a pretty good improvement. Sometimes the system boots
> without any duplicates at all, for some reason Vs the previous attempt.
>
> Tested-by: Luis Chamberlain <mcgrof@kernel.org>

Ok, I decided to just move it from my experimental tree to my main tree.

I think I used about three times the time and effort (and lines of
text) on writing the commit message compared to what I did on the
patch itself.

I tried to lay out the background and the implications of the change -
it may be pretty darn simple, but it does have some subtle issues.

Anyway: I've committed it to my tree. This is not necessarily the best
time to do that, but let's get this behind us, and in particular,
let's get it out and into wider testing asap.

If it causes any problems what-so-ever, I'll just revert it very
aggressively (unless the problem is trivially and obviously fixable).
It is, after all, not a fix for a _kernel_ bug per se, and whil eI
think the patch is very benign, it does change user-visible behavior.
Very intentionally so, but still..

                         Linus
