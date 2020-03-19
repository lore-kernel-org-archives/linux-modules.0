Return-Path: <SRS0=Riih=5E=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0496EC4332D
	for <linux-modules@archiver.kernel.org>; Thu, 19 Mar 2020 14:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5B220663
	for <linux-modules@archiver.kernel.org>; Thu, 19 Mar 2020 14:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgCSOkR (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:40:17 -0400
Received: from mx1.emlix.com ([188.40.240.192]:45178 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgCSOkR (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 19 Mar 2020 10:40:17 -0400
X-Greylist: delayed 525 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2020 10:40:16 EDT
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 221C05FB76
        for <linux-modules@vger.kernel.org>; Thu, 19 Mar 2020 15:31:30 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     linux-modules@vger.kernel.org
Subject: Static build of kmod
Date:   Thu, 19 Mar 2020 15:31:29 +0100
Message-ID: <17444062.evWP73jU2D@devpool35>
Organization: emlix GmbH
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2036423.THErbCYBbU"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

--nextPart2036423.THErbCYBbU
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Greetings,

since commit b7016153ec87dba2b0f0d182cc8f1e3b12f4dfaf building static kmod =
is=20
disabled. I would like to question that decision.

My use case is as follows: I build a custom BSP and would like to provide=20
statically linked host tools. That makes it easy to deploy them at any=20
location, and that these tools do not pick up random shared libraries of th=
e=20
underlying Linux system when executed. Currently kmod is one of the few=20
packages that are not able to build in that way.

I understand that you may want to prevent other tools (e.g. sytemd was=20
mentioned in that commit) to link against a static libkmod, and that is fin=
e=20
with me. What I would like to get is static kmod tools. For the BSP host to=
ols=20
case I don't mind if a libkmod does not exist at all, only the tools are of=
=20
interest.

What do you think?

Regards,

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source

--nextPart2036423.THErbCYBbU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCXnOCQQAKCRCr5FH7Xu2t
/B7PBACduEJO5BbMJKTKbz0xmHYtpvaU9Sfrw31GTTqwH1tpHX5JGVe+qmEroh5B
zud35feyT+Yr1t1UWVNd9DTFlHhKZoz1RG1slQREUyFl0TMrs4jeqEXMREWfsdpi
FMoLFwy+Yqb5Y8H/mzEtVUEDpdlEdmH3ynxqez6NMw4So3+yXA==
=x65S
-----END PGP SIGNATURE-----

--nextPart2036423.THErbCYBbU--



