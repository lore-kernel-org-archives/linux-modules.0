Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6613730D3
	for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762883574; cv=none; b=WJpDU0Um9gSpeRJ/moRu+xwwKbubV9R9iQw7m0pHOWjAcDfiJGJ0QgroyIYsVgwARsNTM+PnJi6XWKHiB9sKFvXy95bluNSDI3JvlxXX/yGelMxMAqKGC91/iJq/GiPwBG3mS1TPUznfgT7xf4amc/gSeMYy26s/5nD17Q0Nij8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762883574; c=relaxed/simple;
	bh=46edM+lm/eIeFQfqmSHoHH2PCoG6egQvGXMvADmFIHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf8QKMbSL2gOAohj/Y9OfvzwK5CRJUvXY/WpLLN5zN+lq6FS9ax+pSzEqT0QSe/pMUSmuRGon4jLgfHGVowLzbWI8P2Tgpp4hhupCB3b7r2wCoI2Pes61QsI0WW9exH3kZoeZ1TqRD4d3XMatraJlPthzVKeQzEQeG3aIMPIPZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=j0uuJRWx; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j0uuJRWx"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso7628469a12.3
        for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 09:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762883571; x=1763488371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=46edM+lm/eIeFQfqmSHoHH2PCoG6egQvGXMvADmFIHY=;
        b=j0uuJRWx4TCgzGcs0iQ/SY+Rz3bHmVL8AO9iaZEmEfl2Hvk3Rq1JTDY0Avo9eNwBF9
         g4jcgzz2Zn+9VuQKLxQChIuYSGAHg2DDU10EHVRSc9HmVefDP7xf1duGH/mXH/ktm/B6
         5XK+iNWb7ZvuvPqVV1hlGaSXhp5zZjJyCm6uhxM9HLcul0bmu+qr7hUpjpt8bI3Nkx6h
         PU/5p3MDB2/pt2aS6Ud1UqOm3jJKyIPNDVeSWfH4j/id7I85JcnMm5qASHLEUkY3bhn6
         /xfn1gOFI/5IhBVMBp2HuV5VZkX/9Y4U6qcJACFw8kOrcLTqKTvhn68SVt7tB9yd4EGn
         XIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762883571; x=1763488371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46edM+lm/eIeFQfqmSHoHH2PCoG6egQvGXMvADmFIHY=;
        b=l39Snv5rcL1U/GvpWUXu5Xe31Pe5YxzJIW41odTX79KWgaL2X/nyg7QUIZlpgMRgzm
         Ca6ieUZ+PqmdoRDlFXJu9/Dk763YW980tPEflnpbwkJNZ5qx98hHr3dWRYRiitGPiwEt
         ugaNGAhDB66G+KFnDFMXkkEz9uv+MBbM9I+nhlqfMvYcJfQKHUAJA/2f95eb6k6f5Ifs
         1kaK/e5+SKXTwvJHkhz9yWpJt3jqXLC7MxxZHYmMcng3hcICBxrChvcm5jhRAxQASpkB
         XuLBJ3RKsoV4QQa77/v92oMPMM7LcSHbKcS3+EKESgQR7x9wwk4dC1YLjkSyvH2ytVox
         stbg==
X-Forwarded-Encrypted: i=1; AJvYcCWzmh7j3vGaOl1sOuvO9xyPGPevj+CJ9JApplz3BXgITOiMBnqNfL21rfNRpGGoTmRtWjqPElQvNiBx4hXD@vger.kernel.org
X-Gm-Message-State: AOJu0YwpsEnL7xTXC1V2vcfqS1YGt8h10LLwq9lM9mYUHaOiqydTa0yx
	r0zL3zWuLOXR83sWEC2Q3U7+azfN3H/SFmKzZ+geobW1o9pxLgwSdu5uhCiSY9bJ1+0=
X-Gm-Gg: ASbGncs2v5G5oIxuVQ4eUH8UcqyDaLUSe3L2z2U8TKBDhqn4rEGHk8Zbl/ghr9fW6Vf
	XGbF1+BkGzvmJ8mBuYDAar5fSYbLUqV984knZCHvdddMufUMcMgcl4hPVzq0BBfDSJszws5Qc5E
	ka4y234orHvaMchzNLZ3kUZNhKYV4C27xLmfOLQE28BynGGtm0yPbFSN2ciosUuxduySIvnFFpp
	Ho+TDckd+EWgbgQjPyZdpKiEq1poCWkLB3VXVveMHOq0TD6yXTzlbh5j0Oy9QuF1QPpA5EXyot5
	qjDhb6FNvFc8NY7CGplBLGv+c5dyan9n070HpPBJYAHXnvYX0BcS0ItdBVCyrguq01rrS3dtyA6
	MLoBB4gh3f6Nr/oxU6Wrucd53O3MwVlC2rvS8R4nMyp5hcUhTnFcCMK41q3M/2Sw8tC6heXlGaQ
	JaApkk0dlRgsfm5llP+uqKdDste9/YbrmJVwshfbM4n2G/sz5PiGlsHFOy0e764Kkl
X-Google-Smtp-Source: AGHT+IGZ24gPwNf9yPCfR7VYmGLvGJvKsnhVnsEWjyP34dYxdAWzeTApGxpBX2H8vl8E9dV82whA7w==
X-Received: by 2002:a17:907:7fab:b0:b72:d56f:3468 with SMTP id a640c23a62f3a-b7331aac316mr1013366b.50.1762883570945;
        Tue, 11 Nov 2025 09:52:50 -0800 (PST)
Received: from localhost (p200300f65f2353049e8cfcf6469e7c35.dip0.t-ipconnect.de. [2003:f6:5f23:5304:9e8c:fcf6:469e:7c35])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b732c87ccfcsm76547366b.9.2025.11.11.09.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 09:52:50 -0800 (PST)
Date: Tue, 11 Nov 2025 18:52:49 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Daniel Gomez <da.gomez@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Malcolm Priestley <tvboxspy@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/3] module: Add compile-time check for embedded NUL
 characters
Message-ID: <dvdu27leqnwvxgz6rcgsdbovw2576dtcbmxuaznevjvijdxp6s@t64lg6bckgkd>
References: <20251010030348.it.784-kees@kernel.org>
 <3dd1a00d-08f7-4801-a9f7-d6db61c0e0f3@kernel.org>
 <aRMhLEs9NpGexL7B@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mwbp63t7mxf4mfm7"
Content-Disposition: inline
In-Reply-To: <aRMhLEs9NpGexL7B@black.igk.intel.com>


--mwbp63t7mxf4mfm7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/3] module: Add compile-time check for embedded NUL
 characters
MIME-Version: 1.0

Helo Andy,

On Tue, Nov 11, 2025 at 12:42:36PM +0100, Andy Shevchenko wrote:
> Folks, are you aware that this change blown up the sparse?
> Now there is a "bad constant expression" to each MODULE_*() macro line.
>=20
> Nice that Uwe is in the Cc list, so IIRC he is Debian maintainer for spar=
se
> and perhaps has an influence to it to some extent.

To be honest, in the nearer past I'm very passive on the sparse
maintainer side and even stopped using it as it fails on guard locking.

My impression is also that upstream isn't very active any more, but that
might have been temporal and wrong as I stopped looking.

If there is an outcome and a patch to cherry-pick into the Debian
packaging, give me a ping.

Uwe

--mwbp63t7mxf4mfm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkTd+4ACgkQj4D7WH0S
/k6QXQf/WqP001zUT4Bxw/oC7trx3KqIhrnryL+Ih+OAu0LFHWKobNA3K556JcXQ
YEoGffzJU/J7ODVixICet7Uv94oeQ/1Oqr/OSPXlUst2vEIgQrkAO5guB/DCoS6C
c+aODonO57Ovlc834ylWPacex8K1XrSEC3bO3guctIxR+FLcfYyc6w8CI7pMRZ/0
Kqaype/E9cFIvlGjyxnIZ28NKGuACVyiO6a4jrfnLtCiFsirGWww65tqhUg9hJx8
sZ2RViIzMnMbl+Vqgoxm3JhpqsfgiA9k6069Ey0zw6JgBVH67N8IQs4v/AKqeBeB
05CxLfZZIK/RlfUZfQ1d/EY78KJxOg==
=qd7W
-----END PGP SIGNATURE-----

--mwbp63t7mxf4mfm7--
