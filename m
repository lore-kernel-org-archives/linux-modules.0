Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322A5C6FA8F
	for <linux-modules@archiver.kernel.org>; Tue, 29 Aug 2023 15:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbjH2Pn5 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 29 Aug 2023 11:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbjH2Pnt (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 29 Aug 2023 11:43:49 -0400
X-Greylist: delayed 541 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Aug 2023 08:43:20 PDT
Received: from attila.bofh.it (attila.bofh.it [85.94.204.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805DFE56
        for <linux-modules@vger.kernel.org>; Tue, 29 Aug 2023 08:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.it;
 i=@linux.it; q=dns/txt; s=attila; t=1693323253; h=date : to : subject
 : message-id : mime-version : content-type : from : from;
 bh=WUE8t5wFL9spv1tY99mmHW0uXDTP9DICl6eQKAiynzk=;
 b=hrUYhY/mlkqdwHEAMu5kRqR1IM/Bz9Be8Fo9PzjpM5xfHxCzpnMveLBzLI1jMqAW6uMGT
 CZLZF8+EZlONWSflktsa8PZeKIkHMoJ/cVQ+fNtiPSvFnEDfA9N7dMK0nnssNiEHDyoqiLe
 ObFmafBnsJC0y9vgTKG5WYbdFrKmr8E=
Received: by attila.bofh.it (Postfix, from userid 10)
        id AC6A617C08C9; Tue, 29 Aug 2023 17:34:13 +0200 (CEST)
Received: by bongo.bofh.it (Postfix, from userid 1000)
        id A775852EAB0; Tue, 29 Aug 2023 17:34:09 +0200 (CEST)
Date:   Tue, 29 Aug 2023 17:34:09 +0200
To:     linux-modules@vger.kernel.org
Subject: XZ in-kernel module decompression
Message-ID: <ZO4P8QVDdhwEADdT@bongo.bofh.it>
Mail-Followup-To: linux-modules@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5RI9CC/XvQ3M3w8y"
Content-Disposition: inline
From:   Marco d'Itri <md@Linux.IT>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


--5RI9CC/XvQ3M3w8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have packaged for Debian a current snapshot of kmod, and a couple of=20
users that use XZ-compressed modules with custom kernels reported that=20
now modules loading fail with "decompression failed with status 6".
Status 6 is XZ_OPTIONS_ERROR, which I understand means "Input was=20
encoded with settings that are not supported by this XZ decoder".

One of the users reported that everything works fine after switching=20
=66rom xz to zstd.

Debian kernels do not enable CONFIG_MODULE_DECOMPRESS (should they?), so=20
this new feature has very limited exposure to our users.

Does anybody understand what is wrong here?

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1050582
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1050586

--=20
ciao,
Marco

--5RI9CC/XvQ3M3w8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQnKUXNg20437dCfobLPsM64d7XgQUCZO4P8QAKCRDLPsM64d7X
gQVFAP9jEerDIA7imaG0l5sz+7TQBq0KrsLj/ViN+YiEK9p/kwD+Kl7egsYIGls8
uUf1VwpFRnEI7fo8EysWxxe+LdVuLwc=
=+BH5
-----END PGP SIGNATURE-----

--5RI9CC/XvQ3M3w8y--
