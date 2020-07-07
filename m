Return-Path: <SRS0=e/mN=AS=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F7AC433DF
	for <linux-modules@archiver.kernel.org>; Tue,  7 Jul 2020 06:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33639206CD
	for <linux-modules@archiver.kernel.org>; Tue,  7 Jul 2020 06:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5RQ+CfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgGGGee (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgGGGee (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 7 Jul 2020 02:34:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D371C061755
        for <linux-modules@vger.kernel.org>; Mon,  6 Jul 2020 23:34:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so43897625wrn.3
        for <linux-modules@vger.kernel.org>; Mon, 06 Jul 2020 23:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wWeWw2Ma4ea+LhtH/rY0LV34HVqdO1KbjOSRtOWkyxs=;
        b=B5RQ+CfAlcaWketPDiaSjUmE5yflsXZilqxAjO5eGSuGJPyJlt/S2Hzb7QfktALXRT
         KwSGAW2mka2NHJN1XxAiZyjb2UP/jgZZ2LAwtJOke9+QPmarMgVVwRlZctAppyAu6LHS
         TM2BXw4tTRoHtaNlgBJ04gkc7I9uq+rTYaxEOQ5V/vB62jfu0Zu0lKMv+IXEMcqWcSOk
         If+t89n52fqX62dnvB9OrIMApCb9Au8X/mD+dFjwk4tEdDu/tc+Gyu097RjLCt+VcH8d
         nEPNFeSKFZjOTV2nU0sVYcyjxg50glMuCuRxPBWkBl2PWrPlFH/Pnm0nfaa3vfX3Bes7
         BWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWeWw2Ma4ea+LhtH/rY0LV34HVqdO1KbjOSRtOWkyxs=;
        b=hsQkcm6dlpfR/QICOeIyZ46gqsMk8qn/Mp8E6U/Qnnmnq75/hQrFENnf73Iqb8hSYk
         ckFWfmU5wdWrEhoDeNeJaWS8v68ikaqQWYReyEqmGFUT/dyyjLObyhrAV5RQYSTvSJEF
         zpkdMRGbB43cOmkXClpQubT/VOoNoIqZ7i51DN/PvSknhq6ivgF6I64S/K49l9umJF9E
         iJMmKhHuM51ZnHHRGOJlrwWcOaiEJYx7kZatg+baqhtexTm0UAN06w1aerqAd6kTrwYK
         E1YOw+izp9Rn8Po5OEwSL9zTiKtFiYCesYrtoBTXN0wqCE5djuSGnhy68+OHN7ukZf7D
         yrxw==
X-Gm-Message-State: AOAM531+HZ0uxH0NqgHMDyjja5BGj9r5F5fntmYFxcvG6yjS1wwyzRnB
        scj2SnWKNDLW68V9/qmmoPA1XkWnrMRF/nrHeI1ffoj+
X-Google-Smtp-Source: ABdhPJz1tWaE+l9cB+fouQ2eY5ecSZsfIbuCVcKnbAjRma1Ln4Hye4LT7WShXnYVNn6q7KR7yJVTokTs1fOoujr0IXU=
X-Received: by 2002:adf:f751:: with SMTP id z17mr54657234wrp.114.1594103673022;
 Mon, 06 Jul 2020 23:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <b0894a8dd06ccee4326bcd7ff14e1f871bd45080.camel@gmail.com>
In-Reply-To: <b0894a8dd06ccee4326bcd7ff14e1f871bd45080.camel@gmail.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Mon, 6 Jul 2020 23:34:20 -0700
Message-ID: <CAKi4VAJjjpziyNYNAs5rDivAxt-b=L3ucCUN+P=0Aou7GwsJnA@mail.gmail.com>
Subject: Re: Support for /usr/local/lib/modprobe.d
To:     Jan Tojnar <jtojnar@gmail.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jul 1, 2020 at 6:21 PM Jan Tojnar <jtojnar@gmail.com> wrote:
>
> Hello.
>
> We are working with a project that ships a blacklist file [1] that is
> supposed to be installed to modprobe.d directory but it is not clear
> what the default installation path should be.
>
> Distros will typically install modprobe config files to
> /lib/modprobe.d but it is common to use /usr/local as the default
> prefix [2] for manual `make` invocations. The manual page [3] does not
> list /usr/local/lib/modprobe.d as a supported location though.
>
> In the past module-init-tools added [4] support for that path but that
> repo appears to be abandoned and it does not look like kmod supports
> it [5].
>
> 1. Am I missing something, or was this an omission when porting
> modprobe to kmod?
> 2. Could the support be added?

That is probably because we don't default prefix to /usr/local so people never
actually needed it. Yes, I think we could add. Could you prepare a
patch for that?

> 3. Should we default to /lib or /etc for manual `make` invocations for
> now?

/lib is where packages should install and /etc is up to the system
admin to set up.
if we add /usr/local, then override order would be /etc, /usr/local/lib, /lib.

Lucas De Marchi

>
> [1]:
> https://github.com/medusalix/xow/blob/4aa49f27cb6fcb3da995da9e8d51167bed40f520/Makefile#L22
> [2]:
> https://www.gnu.org/prep/standards/html_node/Directory-Variables.html#index-prefix
> [3]: https://man7.org/linux/man-pages/man5/modprobe.d.5.html
> [4]:
> https://git.kernel.org/pub/scm/utils/kernel/module-init-tools/module-init-tools.git/commit/?id=9454d710137be3799f343cc9d0f833f0802e2111
> [5]:
> https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/tree/libkmod/libkmod.c?id=f5434cf5fc5b567359e1b9207bbab24c6782cfbd#n65
>
> Cheers,
>
> Jan
>


-- 
Lucas De Marchi
