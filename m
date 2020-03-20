Return-Path: <SRS0=IjVX=5F=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B587CC4332B
	for <linux-modules@archiver.kernel.org>; Fri, 20 Mar 2020 16:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D0E20709
	for <linux-modules@archiver.kernel.org>; Fri, 20 Mar 2020 16:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHiHppOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCTQli (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:41:38 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:38501 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgCTQli (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 20 Mar 2020 12:41:38 -0400
Received: by mail-wr1-f46.google.com with SMTP id s1so8313517wrv.5
        for <linux-modules@vger.kernel.org>; Fri, 20 Mar 2020 09:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aFwA9XUDndmzsgO0N2H6FgIvl23wmxeeBrn26mtmpLE=;
        b=bHiHppOcK1oEk4Envqdl6wlBpBrFaGX4tAIb+bRSYKs24pPFxUTOClKN0UeIz+QFVd
         h8wN/4fwCBkEoqelzcIMACu2M/g5NzwMYz0150vIrfevgyX4z4i4yiKwOw5GLNdXcY1U
         roTgMt7TiMA8DFKFRcvNm91b1ASAkuM9zH/NbuKQBIRurBT/+0yiGlchkP94V9SssTnZ
         MKCOXxbz51xO/TgsVd4JGiaBtTDY2w8sRKHTUV7WnFJBaztPs9sGTQcUx0lmUT0eMwIR
         1yEIyoqZumQj0iNKf/qo90NWbnx43MiUGCcJnoKiLBNca1EezkPvnYTsL57AT+8vKUfN
         /XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aFwA9XUDndmzsgO0N2H6FgIvl23wmxeeBrn26mtmpLE=;
        b=Yj4JnTWaNNkoK1OM/HKWfePNuPNiJLcyyY+pyc/YGYW0DcfNeAt+bXiGOwnnxrANzq
         fj3EEtTMvWsFlbzlMELAMfXZYNfJkzgmYg2ZSn/tJEu8WqxqfeoP2WVJKp3F+WBmC/Tv
         ApXRyXdjjqwIYfkOFQtPbNrofMl7EYuUlB3wtnqvOpzcSA2RWagjDUNKWsW2Dodo5OEt
         xtAC48FEyRHIfHSMmNftW0dqF3BaxxZ86UecbEkPl2+8gNJp+hYoJQJkFCaqeTbD3N9N
         fn6mAZAZjcg7r0podNpCRlVN/ppgBw2aUvZa2BvmRZaIR1cQ8ohEGJYj8JkqfDI+jQRA
         O4DA==
X-Gm-Message-State: ANhLgQ1gYo2J+AZlPdNtoNcNOrDI9bPYuef/t/8RjIerOEBpEpy3s1um
        rm/S43LK/CgZ4guVS1HVCtSmRiP0PZxuQY+/iM8KSbv0
X-Google-Smtp-Source: ADFU+vtevN+CTIikBq1ie8sHuDFMJ2FGFNaxYblEzp7YVhNz1rO9Lf7BfHb7nB4epNwnJVIHQdrS2M404Vl5ozhFfZM=
X-Received: by 2002:adf:9796:: with SMTP id s22mr11868736wrb.31.1584722495411;
 Fri, 20 Mar 2020 09:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <17444062.evWP73jU2D@devpool35>
In-Reply-To: <17444062.evWP73jU2D@devpool35>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Fri, 20 Mar 2020 09:41:18 -0700
Message-ID: <CAKi4VALBCxct17L9FazuHHfYN_ikim4Pj=Ko3-OY=Odn5pNu+A@mail.gmail.com>
Subject: Re: Static build of kmod
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Mar 19, 2020 at 7:40 AM Rolf Eike Beer <eb@emlix.com> wrote:
>
> Greetings,
>
> since commit b7016153ec87dba2b0f0d182cc8f1e3b12f4dfaf building static kmo=
d is
> disabled. I would like to question that decision.
>
> My use case is as follows: I build a custom BSP and would like to provide
> statically linked host tools. That makes it easy to deploy them at any
> location, and that these tools do not pick up random shared libraries of =
the
> underlying Linux system when executed. Currently kmod is one of the few
> packages that are not able to build in that way.
>
> I understand that you may want to prevent other tools (e.g. sytemd was
> mentioned in that commit) to link against a static libkmod, and that is f=
ine
> with me. What I would like to get is static kmod tools. For the BSP host =
tools
> case I don't mind if a libkmod does not exist at all, only the tools are =
of
> interest.
>
> What do you think?

It's a build system limitation:

./configure -h| grep static
  --enable-static[=3DPKGS]  build static libraries [default=3Dno]

The --enable-static switch is about building static libraries, and as
a consequence linking the binaries statically.
We don't want libkmod to be built statically because its symbols will
conflict with other libraries
as you mentioned.

If we had a --enable-static-tools switch that made only the tools
static (default false), I think it would be acceptable.

And since you are going to mess with the build system, if you want to
convert kmod to meson it would be very
appreciated :)

thanks
Lucas De Marchi

>
> Regards,
>
> Eike
> --
> Rolf Eike Beer, emlix GmbH, http://www.emlix.com
> Fon +49 551 30664-0, Fax +49 551 30664-11
> Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
> Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 31=
60
> Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-Id=
Nr.: DE 205 198 055
>
> emlix - smart embedded open source



--=20
Lucas De Marchi
