Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C90C433E0
	for <linux-modules@archiver.kernel.org>; Fri,  8 Jan 2021 04:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3028A23601
	for <linux-modules@archiver.kernel.org>; Fri,  8 Jan 2021 04:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbhAHEOo (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 7 Jan 2021 23:14:44 -0500
Received: from attila.bofh.it ([85.94.204.146]:49206 "EHLO attila.bofh.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbhAHEOo (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 7 Jan 2021 23:14:44 -0500
X-Greylist: delayed 8972 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jan 2021 23:14:43 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.it;
 i=@linux.it; q=dns/txt; s=attila; t=1610079242; h=date : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to : from : from;
 bh=j3flEEC12aT3HqCtmeEFkXlP6J3K+6Pb9vSAVpALz7Y=;
 b=oEaVggu2NO30qGDLE3MiPG0rmSWvBHdTKcyoD2AiAnt4qb11eY5/yWu6Onq3IOqto77yg
 emHEq9opmVG0js+uois04TQpfKXrGIHWBzNQT8+l3i6q3jPXoGwgAATfPrvjfcE7pRJVCCr
 LX15sLPMtaNEWQ5W0LyaE2lbkyWPMgA=
Received: by attila.bofh.it (Postfix, from userid 10)
        id 5701312BB82; Fri,  8 Jan 2021 05:14:02 +0100 (CET)
Received: by bongo.bofh.it (Postfix, from userid 1000)
        id 994D7840A4F; Fri,  8 Jan 2021 05:13:57 +0100 (CET)
Date:   Fri, 8 Jan 2021 05:13:57 +0100
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Subject: Re: Bug#970871: "modinfo -F" always shows name for built-ins
Message-ID: <X/fcBfwqlw1XkE/H@bongo.bofh.it>
Mail-Followup-To: Lucas De Marchi <lucas.de.marchi@gmail.com>,
        linux-modules <linux-modules@vger.kernel.org>
References: <X/e48mOg7WfVxRc0@bongo.bofh.it>
 <CAKi4VA+RA8Sr85dHrRf9-XL5cJ8_rf=0WG68zQQQO6JA4qRPjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wG2R/9wu1SVW/kdv"
Content-Disposition: inline
In-Reply-To: <CAKi4VA+RA8Sr85dHrRf9-XL5cJ8_rf=0WG68zQQQO6JA4qRPjw@mail.gmail.com>
From:   Marco d'Itri <md@Linux.IT>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


--wG2R/9wu1SVW/kdv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 08, Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:

> On Thu, Jan 7, 2021 at 5:55 PM Marco d'Itri <md@linux.it> wrote:
> >
> > The attached patch fixes this.
>=20
> who is the author?
I am.

--=20
ciao,
Marco

--wG2R/9wu1SVW/kdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQnKUXNg20437dCfobLPsM64d7XgQUCX/fcBQAKCRDLPsM64d7X
gVo+AP4722nQJp5XUectP1sTBRuD+lhXbo5kETmRGBG8DJQfCQEAiaPvrRO/haCx
fdocpDi6qK5AUYueYCsjWFNbeIjgeQU=
=vGn5
-----END PGP SIGNATURE-----

--wG2R/9wu1SVW/kdv--
