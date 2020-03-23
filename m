Return-Path: <SRS0=Fs8F=5I=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DD8C4332B
	for <linux-modules@archiver.kernel.org>; Mon, 23 Mar 2020 08:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFBF2072D
	for <linux-modules@archiver.kernel.org>; Mon, 23 Mar 2020 08:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCWIfn (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 23 Mar 2020 04:35:43 -0400
Received: from mx1.emlix.com ([188.40.240.192]:60048 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbgCWIfn (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 23 Mar 2020 04:35:43 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 121DA5F77C
        for <linux-modules@vger.kernel.org>; Mon, 23 Mar 2020 09:35:42 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     linux-modules <linux-modules@vger.kernel.org>
Subject: Re: Static build of kmod
Date:   Mon, 23 Mar 2020 09:35:33 +0100
Message-ID: <9035977.IJiM3cOGZI@devpool35>
Organization: emlix GmbH
In-Reply-To: <CAKi4VALBCxct17L9FazuHHfYN_ikim4Pj=Ko3-OY=Odn5pNu+A@mail.gmail.com>
References: <17444062.evWP73jU2D@devpool35> <CAKi4VALBCxct17L9FazuHHfYN_ikim4Pj=Ko3-OY=Odn5pNu+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4291190.D9zf89q2FB"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

--nextPart4291190.D9zf89q2FB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Freitag, 20. M=C3=A4rz 2020, 17:41:18 CET schrieb Lucas De Marchi:
> On Thu, Mar 19, 2020 at 7:40 AM Rolf Eike Beer <eb@emlix.com> wrote:
> > Greetings,
> >=20
> > since commit b7016153ec87dba2b0f0d182cc8f1e3b12f4dfaf building static k=
mod
> > is disabled. I would like to question that decision.
> >=20
> > My use case is as follows: I build a custom BSP and would like to provi=
de
> > statically linked host tools. That makes it easy to deploy them at any
> > location, and that these tools do not pick up random shared libraries of
> > the underlying Linux system when executed. Currently kmod is one of the
> > few packages that are not able to build in that way.
> >=20
> > I understand that you may want to prevent other tools (e.g. sytemd was
> > mentioned in that commit) to link against a static libkmod, and that is
> > fine with me. What I would like to get is static kmod tools. For the BSP
> > host tools case I don't mind if a libkmod does not exist at all, only t=
he
> > tools are of interest.
> >=20
> > What do you think?
>=20
> It's a build system limitation:
>=20
> ./configure -h| grep static
>   --enable-static[=3DPKGS]  build static libraries [default=3Dno]
>=20
> The --enable-static switch is about building static libraries, and as
> a consequence linking the binaries statically.
> We don't want libkmod to be built statically because its symbols will
> conflict with other libraries
> as you mentioned.

Yes, for now I simply patch that check out there.

> If we had a --enable-static-tools switch that made only the tools
> static (default false), I think it would be acceptable.
>=20
> And since you are going to mess with the build system, if you want to
> convert kmod to meson it would be very
> appreciated :)

If I change any build system the target is CMake.

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source

--nextPart4291190.D9zf89q2FB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCXnh01QAKCRCr5FH7Xu2t
/ICzBACQzQl8bEyONfOZ08pjdYEqwOOshNrGwzE66e0pa8Ysfl3UDL1Bu26Jbz0b
k3aztKt6hiGeTCfV8B9b7WoZuU94MTz2EWu60TN2xDFHkPb4oiv3muMqNjc0Wojv
fCZEE5PXfHjAt1bx3NOV3CpGXQfwjKg4Yl2xf38xC+aYXXQlww==
=gEJB
-----END PGP SIGNATURE-----

--nextPart4291190.D9zf89q2FB--



