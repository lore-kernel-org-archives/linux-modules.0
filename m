Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1280B
	for <linux-modules@vger.kernel.org>; Sat, 16 Nov 2024 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731777624; cv=none; b=jVc9keHK5YKlyaD/zWNmJ2tBCAb5tZYYhRF4PY5O5+xgC4CvCl7yeRiGZOm1ShrD6E5Ix2TdSYhvR2wIY30KlCrIS2Blb/+uGxn9/NwmAttJzQU/3Gnq6Hrwt4iIzX5/XeFdwdV1zndDgkxgq4rKgifXqwwTdjo6k+0xIVXM87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731777624; c=relaxed/simple;
	bh=5w+T7fDiwjH4Q91Rzn299zU03tEpvFIoldlRVMcVLGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vk4diY91aw9XK3DctsUxMEID7DkzfUeA6wX7AHE4SCouJjQAMd3sOVc06gJbBKqYuC41fNRV1peLALgcU7VyUAAH7I/3QcbCrFOS/Nttq0JtQQslfukNJVBsod7pTVP/KG5LWBoetzZpcUUsoxP8Oy46wnYvVk+UYAvZ0PuYT38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TmkP9kmL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TmkP9kmL"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so14795785e9.2
        for <linux-modules@vger.kernel.org>; Sat, 16 Nov 2024 09:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731777619; x=1732382419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/dgzgvFQRnihgmL6uOs2B7Yp3DRZimnSwwaTVovC9Q=;
        b=TmkP9kmLkBSp3Tz7xxzG7Dvg4C9l8nxsfcLmDzk+VSkacU9MLqtgBLHHImxMuAjtj4
         HKn1lvj9cHKfx7aTNQOynzJ5N1tsgf7nRdbvOAwIs0eDkz2HvAX/L64Ion5H2oUATlC/
         mlc5upbbjXZfI9WS5ySIDFXcIc7QxrfMq+i9hHtOHCKX+dRPzlcipCQ/NVKz5YYS0qZX
         XQi3nwy3OcxF7SajhjnlzAjvFLj1rdlRgvhb3LgYWp6CBoey57SM7ND2wQ4fe+j5INj5
         4QmQdv35lkZ+MmLSKl5uyM8OCPeBzx98mGv/VlRQkinnt1P5aYYPcVitVzb9WIUb9pZc
         rMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731777619; x=1732382419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/dgzgvFQRnihgmL6uOs2B7Yp3DRZimnSwwaTVovC9Q=;
        b=kDFp7QdgKE9NjM8o+NgZr13iA4J90oh+W0KbH6Ct5ZzzaXt2v6sa63EntmLqV1y1JB
         o5qkdKOLgOvZziASPsB3Cx3L4lOZBE9iZCg7UJAL3e60/NRkzfju36sF5x3iPtje1nno
         9YKHAychUUEl/m8AYh9o/H0SwbYvzshX22Hls+EqZ5jSQ9vTVL6iewRUAfv/Ent4S1/L
         /pcDz8JB7vYVeCysC9XbeogoYeU+rDk+DSANKVYslLVTQfDZPyZM6rlEyNk/rayZlWGV
         +NAyrlqAK7pBuJuxOgY22h/pADxH4dOGTMLKRXvnrcL7oUroDTUrfzn8rkcyLjNVNNjt
         PXRw==
X-Forwarded-Encrypted: i=1; AJvYcCXqQ+wRyvp5YaNd2pN25h4r1dXFBsKoAbxNNQwuMoxWJWBsL8GTqRBp4H/cdfsVWd4bIOykJt4b6nATIvbj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqev1W7IzNchdDQ/4gHv3JZE/3axFImqPliroKk5Y6BqIsWd8Z
	Q+tuWizsqeRVlFdVtwj6h9frTjo0sKvqNyif0NLp3ySW7rDT6BSkPZl7Zy2SwiI=
X-Google-Smtp-Source: AGHT+IGPrpiwwvYCz+WWZ7w684+SywIWzla7gQ5qa/QXLMORFBVUuxFDT5sUvlxxHeTi9VQig72ryQ==
X-Received: by 2002:a05:600c:3b0a:b0:431:52b7:a499 with SMTP id 5b1f17b1804b1-432df78b065mr53563615e9.20.1731777619087;
        Sat, 16 Nov 2024 09:20:19 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:941:29cc:578f:b591])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2946a3sm96583395e9.35.2024.11.16.09.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 09:20:18 -0800 (PST)
Date: Sat, 16 Nov 2024 18:20:15 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Daniel Gomez <d+samsung@kruces.com>
Cc: Werner Sembach <wse@tuxedocomputers.com>, mcgrof@kernel.org, 
	petr.pavlu@suse.com, samitolvanen@google.com, da.gomez@samsung.com, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, linux@leemhuis.info, 
	vv@tuxedocomputers.com, cs@tuxedo.de
Subject: Re: [PATCH v5 2/2] module: Block a module by TUXEDO from accessing
 GPL symbols
Message-ID: <wnfqe7q2aby76zokkh77jhlwc2dbr243kycmejc4wj5wflywgi@6sox742ip22g>
References: <20241115185253.1299264-1-wse@tuxedocomputers.com>
 <20241115185253.1299264-3-wse@tuxedocomputers.com>
 <D5NGCPSP7EO8.28YI337NY203X@kruces.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mtg7bk2c5czsktwc"
Content-Disposition: inline
In-Reply-To: <D5NGCPSP7EO8.28YI337NY203X@kruces.com>


--mtg7bk2c5czsktwc
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/2] module: Block a module by TUXEDO from accessing
 GPL symbols
MIME-Version: 1.0

On Sat, Nov 16, 2024 at 09:15:55AM +0100, Daniel Gomez wrote:
> On Fri Nov 15, 2024 at 7:50 PM CET, Werner Sembach wrote:
> > From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> >
> > TUXEDO has not yet relicensed a module for GPLv2+ as a reply from former
> > contributers the committed code under GPLv3+ is awaited.
>=20
> FYI, the SPDX identifier GPL-2.0+ is deprecated as of 2.0rc2 [1]. I think=
 you'd
> need to use GPL-2.0-or-later [2] instead. And when using the SPDX identif=
ier,
> you don't need to include the full text boilerplate in the source of ever=
y file
> as long as you include a LICENSE file or COPYRIGHT file with a copy of the
> license. One example upstream here [3] commit 1a59d1b8e05ea ("treewide: R=
eplace
> GPLv2 boilerplate/reference with SPDX - rule 156").
>=20
> [1] https://spdx.org/licenses/GPL-2.0+.html
> [2] https://spdx.org/licenses/GPL-2.0-or-later.html
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?h=3Dv6.12-rc7&id=3D1a59d1b8e05ea

If you're convinced that "GPL-2.0-or-later" is the right string to use
(and the following somewhat agrees with you:

	linux$ git rev-parse next/master
	744cf71b8bdfcdd77aaf58395e068b7457634b2c

	linux$ git grep -l -F 'SPDX-License-Identifier: GPL-2.0+' next/master | wc=
 -l
	3640

	linux$ git grep -l -F 'SPDX-License-Identifier: GPL-2.0-or-later' next/mas=
ter | wc -l
	9005
)

you can consider patching Documentation/process/license-rules.rst which
currently reads:

   License identifiers for licenses like [L]GPL with the 'or later' option
   are constructed by using a "+" for indicating the 'or later' option.::

      // SPDX-License-Identifier: GPL-2.0+
      // SPDX-License-Identifier: LGPL-2.1+

Best regards
Uwe

--mtg7bk2c5czsktwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmc41E0ACgkQj4D7WH0S
/k5+SwgAubHUymAvKTccESpnV+7u3Yc/hqVAPKF4P2jEMd5yAHKSi2ekL0Sae1Jz
mNT7gnv+ytCDflbgLThPeSkjdfAgFyjPQjsZlC29RZ54MsTHIcEiMVvHMueV9UUD
KqVWhvH/8zQMM5U7FCZpU8scDHxKQuKHnBAhwr1cUHPO4ecNpv1uk5dkDVjzFi1c
VcZTIzLJz4pf69xaChiHjZRszpkbjhci3lTGPF15WL25E7zs41ix401Z4ReYvJhP
EYnSgH15fQjy/Wxzcg3rI5a/hwZQYVyk6SMZ4Ddwcof4TzpLdHfdmB4nxSjVdE2G
nrnK/IbIb+wHs7pTTe/FalQWLn4chA==
=Dtig
-----END PGP SIGNATURE-----

--mtg7bk2c5czsktwc--
