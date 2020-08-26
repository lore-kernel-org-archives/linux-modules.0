Return-Path: <SRS0=Sldx=CE=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0144BC433E1
	for <linux-modules@archiver.kernel.org>; Wed, 26 Aug 2020 09:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3C420897
	for <linux-modules@archiver.kernel.org>; Wed, 26 Aug 2020 09:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="esuGwPNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgHZJgb (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:36:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:49369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbgHZJga (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 26 Aug 2020 05:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598434587;
        bh=2SqX2oADNvp2+XbIN5gWqGmAQvR/fh7OjGlyEB6jGxo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=esuGwPNUXlhlw2EZqdzQabyDw8/VHAp/keqAHCWEYvSFKQTvTR+wxbsFkcoiTQFdP
         TxYPWiFFo3jjcAS/iGOEG6ZbWnWaNT1mwqkZX6dONG7JL10rwXcWOLeQCTkexK8enU
         cOpN6eq5TKTbwKnu1azSnDlopAjwO5tSPawhGBd0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from blumerang ([95.118.16.46]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MI5UD-1kMfhE2Ivn-00F8G4; Wed, 26
 Aug 2020 11:36:27 +0200
Date:   Wed, 26 Aug 2020 11:36:27 +0200
From:   Xaver =?utf-8?B?SMO2cmw=?= <hoe.dom@gmx.de>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH] modinfo: dont print module name when --field is given
Message-ID: <20200826093627.ukw4hwff2wxb6ykh@blumerang>
References: <20200823215433.j5gc5rnsmahpf43v@blumerang>
 <CAKi4VALERCR92nf+D00knka4NOrUM+P2TY7Rs+zoLOvi_8iQtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKi4VALERCR92nf+D00knka4NOrUM+P2TY7Rs+zoLOvi_8iQtQ@mail.gmail.com>
X-Provags-ID: V03:K1:kJmRIWBrSS0RypapiipynWp99NaDVuS8gjTxCxp7F/WWeFEEmoP
 KNCOvRhzG4od0pGMchbIqY/zM0liYieNXJq6jiTpd6pr9ork9jQkaIPAj2m2nWdgGlrdGxX
 tvpR+YFIaylupRh4bQtotYAyaI4QJ9Iu6Gq4ls0qMuLXvl+FtFQoVAdNGbayGnbS8TDPAzO
 PRlIqnezvNoCU/IYZbP6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dJBDG1voZEI=:LN2TiqUMx4pf5/0bbjlm6u
 CuJ1xeZvbKo3ApjWWVMahXSZIvRLNy5qx7NObykf2EkSqI499bD37ggdKMe1wHrd642hWtF/x
 0jd3VEBCSsnNKzHd8dvgiUpQMXIZ3Ynllf1L125zba0s3xIyZ64bk3sYUGhuB8bPth2ye7zVh
 bF9JX/DrGiR8pQJj4kQ5aXzcLIyfWGwJfpv4JIzURyaoakP9t/FGZ4HM+nMQBOjwApbTVgWBo
 jWa4Qjtnije4v+eRMaLABYtbMvoE1Luri5jWXQ8GHN+MX5cemjvlJX5LJuipyh3TuKNaeDu2H
 tWXdz6Zliipj2dv4gIiiBDs+8KLBXynux8+iOwViIwjkxJzCKqtzSq04vekPd4RuCVSd34X4J
 tnrf7I1/Kpcn45VtRXQGP7tg4lCtqPQpgy+naw23A7oelSO0Ww3SFV5JuJPgYlEmDp1zFb0Sj
 VsqhlAWABGF0uM13Jp1wEjZog7JsQLCQw8+ovDNpqsF32W8lDnLN1kFpJTj4Z4nOoUWGUjvFp
 XnJ+fxIIzKdyHSi/Pl3lSPo680nC/Mi8LRTWgAkvAAc9etBgBqYKDoi1r4A4LGIBdCkvx5V0u
 V/IW1Rd8IgHTVpJMPkr65CuECH9lmTDj6w9fuJaFst94/Gd2gpLwTCQSZ1jDShDpq2ZJOhMub
 mWXAZDqWPrHuR4BuxpNn4UM8xE3sIwfvaelhDqTr+TqOT6gpEWgKlCotW9OfILbyutTkO+cZN
 GBQjvMKQkaX0VjzF16uzG59Y2kQCgPCSCz8Rhesh2oQriV6kaAj5RAP5PAM84PKut1/GJoNwr
 FjkkvBVirXdog01Zb4lls4sMmoZc9ov2nQ+bDxOpe3x9iyBdo3UjO8cyAyzqnIuKmqnp7LBBK
 sFOvSX+5aT/NuDsp6qUWhMgrejEI0uE/9AL3GXp3pMB0t7IYZqTF42zFmwqXJpSqQdFVWuLXN
 Ayq3eD65XBact+sy4lBfhLp8FyjQLaSDxGgS9CRM5YqyqnhaD+zCUcF8ScR6jgqqHy0msfdRg
 L/E4QCkY1OcKcx1J3Ll93HKIaxCLtVtTChDVwxGYP//JaVJ8N0CrSC6aNKSWHe7CNzpi3dCzM
 RyCt9jBwS5SZ+d/5VaRMEamd44nx+bYqn/AWdU89JC4+iqATcfBaaX17ewJDpvfQFfTQ6BZ9f
 7Q1OiMF8C6CgEBiwOoGZcVGEwmihPrcLDVFe+noCH65tlp1lQDN1gwagigSnmYSh4vUmx3JFG
 apNUcMxKJMQH3B+Tt
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Aug 25, 2020 at 10:27:46AM -0700, Lucas De Marchi wrote:
> the name would be handled by the next if/else branch. Unconditionally pr=
inting
> the name at the beginning for built-in modules doesn't seem something im=
portant
> to retain. I'd rather handle it in the `if (is_builtin && err =3D=3D
> -ENOENT) {` below just
> not to exit without printing anything. In that case, printing both
> name and filename
> would be preferred, so the user knows why there isn't additional informa=
tion

Dropping the "name:" part with --field seems the right thing (updated
patch below implements this). But I don't know what exactly to do about
the error case, not sure if I get your intention right there.

If --field is not given, the name and filename (i.e. "(builtin)" in
this case) will be there anyway, on the other hand if --field
_is_ given it seems a bit inconsistent to give additional output.
Unless you consider this case an error condition of sorts, but the
return value being 0 suggests otherwise.


Thanks for having a look at this!
Xaver H=C3=B6rl

=2D--
 tools/modinfo.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/modinfo.c b/tools/modinfo.c
index 0231bb0..b49f622 100644
=2D-- a/tools/modinfo.c
+++ b/tools/modinfo.c
@@ -178,14 +178,21 @@ static int modinfo_do(struct kmod_module *mod)
 	is_builtin =3D (filename =3D=3D NULL);

 	if (is_builtin) {
-		printf("%-16s%s%c", "name:", kmod_module_get_name(mod), separator);
 		filename =3D "(builtin)";
 	}

-	if (field !=3D NULL && streq(field, "filename")) {
+	if (field !=3D NULL && streq(field, "name")) {
+		printf("%s%c", kmod_module_get_name(mod),
+			       separator);
+		return 0;
+	} else if (field !=3D NULL && streq(field, "filename")) {
 		printf("%s%c", filename, separator);
 		return 0;
 	} else if (field =3D=3D NULL) {
+		if (is_builtin) {
+			printf("%-16s%s%c", "name:",
+			       kmod_module_get_name(mod), separator);
+		}
 		printf("%-16s%s%c", "filename:",
 		       filename, separator);
 	}
=2D-
2.28.0

