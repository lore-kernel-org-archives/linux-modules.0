Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247B8C678D4
	for <linux-modules@archiver.kernel.org>; Mon,  6 Mar 2023 09:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjCFJ7n (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 6 Mar 2023 04:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCFJ7l (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 6 Mar 2023 04:59:41 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F276311169
        for <linux-modules@vger.kernel.org>; Mon,  6 Mar 2023 01:59:33 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id n4so5986595ual.13
        for <linux-modules@vger.kernel.org>; Mon, 06 Mar 2023 01:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678096773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYIx7+Ak5uvLBEiqCaz2EjTEv5YVga1eqk3WlIV6f4M=;
        b=zK2NCcCpt9UU5XWW7P556fwgVJnEZEkgL1VUMcs6Mj43IYOEvoEhfp8gfGUsPfLC9y
         rr++bTyCnBcdN2dngclReRJLaxoST8UztHhb1fDmgWvgza6vB+TGcRfhIZnGtRSmxWAH
         1CVAD5hZIQVINYG5pgNlKMDawgjanCiHOlNjBOd0Fuk+W/0c+b4uiCC8Xb8KXBnI095x
         8QLYEPPLxrfg3p8bJIMPf18V36pTcBfCfQstjYus6E0Iq0L5ShKu8Tzt04xYxOeI4YvW
         nDIag/4yGtMlZV2g1dzKtMLxiEvkUPlPuFxOlgkxt4MZrtxvdOozHO6rLF0cmXE46pon
         ntHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678096773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYIx7+Ak5uvLBEiqCaz2EjTEv5YVga1eqk3WlIV6f4M=;
        b=V7I8oDtfLNM2tatR5zcEqhiHMjB+6zA33xYOv29Tt04xQOzMw7ZsHhheUXjBm5vMjO
         E8h8iFVCLyDoVj5mDQ/RRRtNTkpdVsbsuEvC8AbcHVp1pPry3sA4ffNAtxQiuqon6h8A
         4Q02NHibfrGgC0mqbd2GmwkMdZ9IWAvjWGbOaH+3x01t1xtg0e0UUd14Tw3LPyf+pJPI
         jQNVjyC3QbChmjr4qFXqL8kE2Vm7CmdCWUpKGo4e5km/eSFunV/sgEJ4hAJHzeQKN9xE
         iaXH6V2VwYw2M0AdgSC/o/rJvPgRXJIl+LOwhT6P61D6CoEJT1VGVAqgvAe94ZouQuDk
         BWJg==
X-Gm-Message-State: AO0yUKUs6mycCqkJAf9eO0lLsuQU5T8LehNTsIZsVA35xLTKERpW4qva
        anTXG5Px2xoiPT2sBA26GtUkb8Ii4gNI0aPdxWLkLQ==
X-Google-Smtp-Source: AK7set86O3qpveh/FrKfkd3g2XuLPEZoo2Pf5KYA5+piHq15fqYnN6m4NMoJVYTy0MLAeYsy8UJPiyEY5BxmJfkfHGE=
X-Received: by 2002:a1f:2dcb:0:b0:401:42e5:6d2e with SMTP id
 t194-20020a1f2dcb000000b0040142e56d2emr6188621vkt.1.1678096773108; Mon, 06
 Mar 2023 01:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20230222121453.91915-1-nick.alcock@oracle.com> <20230222121453.91915-28-nick.alcock@oracle.com>
In-Reply-To: <20230222121453.91915-28-nick.alcock@oracle.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Mar 2023 10:59:22 +0100
Message-ID: <CAMRc=Mc76TT+y_OZokRBptgDzA=Tnf6_0BuiBNqB2FRjCEGuHg@mail.gmail.com>
Subject: Re: [PATCH 27/27] kbuild, gpio: gpio-aspeed-sgpio: remove
 MODULE_LICENSE in non-modules
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 22, 2023 at 1:17=E2=80=AFPM Nick Alcock <nick.alcock@oracle.com=
> wrote:
>
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>
> So remove it in the files in this commit, none of which can be built as
> modules.
>

Applied, thanks!

Bart
