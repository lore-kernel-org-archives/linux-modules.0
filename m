Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199050;
	b=o4wbcCiSGvhoEd5apb6VwlGjBc+T8TJ1N1RDULs41mUU2oBPMkOChxx/FOOaQDb5sFar
	 WWlekR04vvN5q7xw7AxwOU8/Xc2LudYx7+ZqRej7P6ckPrVe851VNaj5pRXgTfzteNuXn
	 7BoV37S8SJ+3zy6SvpzKO3rwbhjK8T1yxnE3APPR8sBZkQ0ZxXNpyeKaQTrNOLig8l/2u
	 lP+fBZKhGQzE8ytaQlZoynnWVx4hFm7Zq0N0RuJaLew7/GIp7IVprmWlWAKfzSljufsvu
	 NawevPNpyb0fd5LJqUK6u5nGOATX6aKhiDNn85VZsQ7LTomhaMPOjzfMkXBcpMft+hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8g9t7ALU7n+7VW9gQDZGowaF3x6SIEajb/2Mc6wiGZg=;
	b=2hpgicAQprD2tZfhaEiCPR5bxFLyr2mQCQwkWl2FwPjkgcsS0mfEG03PBPIv2U5VkFgm
	 nI0ug0Z7KHrD0hV+vo8JzmCEP4X0iH8aoyOREV/9JR5HmahB29UoX7RVivEpolNZyA2N5
	 Jw0GfdLpNUNRP8Y0CHFoOVFNDfI0KDq1E9SoEJeKVgpT22OKfkwetxh5lHMie0RUgwhue
	 V/0S0BVcVQMfi3YAgRLy37BmzaZlOqtzkgzMaF/PwXoKjTFdPV3iBzT7CWS2benPuWGJb
	 Yn3B0xzAb/eKc4QyHixld9M8Vd4ainyrqXnWyQqTMPQiqykCyTV2giiQxhyIA99j9FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ZHI+PnMY;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F745606A325
	for <linux-modules@vger.kernel.org>; Wed, 28 Oct 2026 14:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F745606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ZHI+PnMY
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso11108255e9.3
        for <linux-modules@vger.kernel.org>; Wed, 28 Oct 2026 07:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793199047; x=1793803847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8g9t7ALU7n+7VW9gQDZGowaF3x6SIEajb/2Mc6wiGZg=;
        b=ZHI+PnMYUO4N11z48C45pvIZIJWpMQLYtqa/tXxi4VJPtckafE2C8vZsmMqf8WSay0
         WkP8vzXw7KUTk+v36CyGXajDZqG5by6+RXck/9D3EACNfx4yeyKYYQCGbZWVuUnG8rUY
         5qLQe1LGWxfOMYFobc3VGIHrV+AV15yetvd7tYKfqNhVaNLNUnVgOeygrUQUPRbwHDiW
         lcID/IWXFCzR53WbNv/a/lMfGMt8NtxMv4qhxOQ+gXhSRnRitG8FLFKqq0+vRsgTDT10
         G8Oqf0Udam7YRK2gHQ+5l/UpMXkarOzmpwiZriOVr29JvpcbNa84+vP5mTUlSdzwCT8R
         2qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793199047; x=1793803847;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8g9t7ALU7n+7VW9gQDZGowaF3x6SIEajb/2Mc6wiGZg=;
        b=SY+hmehTuDSbnYlAmVtvzx9GsBW61uvjoAVwKXYQrbpP2Y8A16XMLnCxGwAjy9e2Hh
         JO6Iumq99SKsHldLahRj4/khEsqoYdb9sSGWedxFOp8tQdT99SQPxD+Kbjr5JGLN5exy
         p6CVQWaRrjaWjy4SMXYnSDTNh2DXDDgV2UPD79jltCYarooXh6h7u4iXoQJd1IJHkxcH
         a47p78ZqFMwmmtsFNO5QUA4II+Wx1XZP1/yWRNlgvZEeTYUprKDe7PBHfsMhwDJ93r4Z
         84l9AtE2F1mzqCUK8w8y0+5u1lU48ZGbm/arTYhpJ9BsElvZqFFp7tBTffy1sEQB+PkT
         QZpQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLNLo4pbdUkVrmE1KTbwS2p1vPMsbxD7Hr3dFjci0HpGgRkDW3N+vLbzd8hCObGD76mKyEN32oFQhxR9Mq@vger.kernel.org
X-Gm-Message-State: AFq9FYLPVoXr4sAk5Rg8Qycp+g0d8U3Uw2KD80TFVqkrIUwllPKbpk+X
	jmMQO9t6tA2A8Kzc0mZ8+O4g3AtcIWfQuDVDmxye6a1ebdEFE93mYRoy8GEMeyU1ddXizlREeDz
	lHKoxWug=
X-Gm-Gg: AYBFou1le1udK4fbw9kCz1YySS3gA3/MZMGVukmha6cDPZtGRT5/2haLSibcwwwoAye
	L1/s2UpaiqxCDTp6Uexpt79EJ7TWkfWt6mOs1Nti02MJPkMQsE0qLDDlIx8+KLs4jnbTNInBIdJ
	0BpEPO+BlIHQLiCb3JNnBfi2Z7Ild3GOMJD4oUo9ivcMYZmUCn/19cwqclyKRQmomuI0WlGNdAH
	S2WauLG3U/S8nqTc0LcCN+w4N8SV2LcNGYmYvibif4HHVr2OaCW9lBE105RMdSZpi8llLHvbSlD
	X02OuIVBqIk/3QcnZbN2eVuJ3r8PrS2TtmPWGss5OaDhy3qmR10gZiWWInhUqMNAo0F+VUQqs/5
	EITlJr5GsoMuFiB0sNJtf5bHVcmkDDMKshpVKItB8sULWNOlIPebPHscO9uVwNVFUyz/i+0iu87
	Drap0A2g4XVJYCYU1Mcqeh55cjKi8PENhADO4w+9BIA/hk/09EjIj/dj05gt2xVwlDNcWTgv0QN
	UbMJFPcHYNgN7qEuFcI5UNJ3HUPQ7TG6g9hK6u0jRCamaTlySoaoIJIKwtABcLCtjV8uOn9WKAF
	RtLg2na4JjM/vfQCwJwrjQDTvjoiuRrVug8=
X-Received: by 2002:a05:600c:3510:b0:4a4:7a8d:c436 with SMTP id 5b1f17b1804b1-4a96667dd75mr52332595e9.11.1793199047357;
        Wed, 28 Oct 2026 07:50:47 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a97cebf858sm57250745e9.12.2026.10.28.07.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:50:46 -0700 (PDT)
Date: Wed, 28 Oct 2026 15:50:44 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>, 
	Armin Wolf <W_Armin@gmx.de>, David Lechner <dlechner@baylibre.com>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Bradley Morgan <brads@mainlining.org>, 
	Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Thierry Reding <thierry.reding@kernel.org>
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <auILBqh9Ccv7ztid@monoceros>
References: <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <2026102437-vista-unsoiled-b089@gregkh>
 <at34UOuYv3NtX36R@monoceros>
 <20261026225950.GD1685504@ziepe.ca>
 <2026102849-turkey-series-ac07@gregkh>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dvdgfsb6jpiy7bdt"
Content-Disposition: inline
In-Reply-To: <2026102849-turkey-series-ac07@gregkh>


--dvdgfsb6jpiy7bdt
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
MIME-Version: 1.0

On Wed, Oct 28, 2026 at 02:45:18PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Oct 26, 2026 at 07:59:50PM -0300, Jason Gunthorpe wrote:
> > On Sun, Oct 25, 2026 at 01:48:04PM +0100, Uwe Kleine-K=F6nig wrote:
> >=20
> > > The more I think about this taint, the more I believe the commit shou=
ld
> > > be reverted and replaced by a some stop gaps for driver_override. (Be=
 it
> > > a taint or better yet
> > > https://lore.kernel.org/all/0f7446324f6a0c8f0153d6532d92a6eeecd6a308.=
1790612298.git.u.kleine-koenig@baylibre.com/
> > > .)
> >=20
> > I also think this patch is way too broad and should be reverted until
> > something better is designed.
>=20
> Fair enough, I've sent a revert for now, will get it merged before -rc1
> is out.

\o/, thanks

> I'll rework this for a later release, thanks.

Please look at the series behind the link above before investing time
here. I think most of the ideas are already implemented there. If you
voice your preferences there, I can rework accordingly and rebase on top
of your revert.

Best regards
Uwe

--dvdgfsb6jpiy7bdt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmriC7gACgkQj4D7WH0S
/k7RWwf/cwXDsUHX0jhgjipjJFi1+cjW14UhDdlEnrd0BnzhDhCcWYdtX4Jokju7
CvB5Oiyfrbzutn6NGqwDb2r6lwabIE+FUkSwqOYBh0v9DeYZc09PyetAJUrJc1P+
ykWQcL5z1tPk5gkQDnk/OMUtvZXVwgH9T+CJaYjJ1zX5KQEqpM1iA0orv6blUtcV
QoHhDAdbFR9S/jZ/4rdCfk08awpvM3VqeV4VW0n2VR/QwFLZ7NS45TRo8EZdRHiI
enU/kyx10Vep14yRZmuVr3Xw5rdSN+ylwbNFFKzSLcL/Vz00iyhlIOgvlsS2wy69
vU6dhHVeUJVTb8Y8hxbTBePHR0MSsQ==
=kVFg
-----END PGP SIGNATURE-----

--dvdgfsb6jpiy7bdt--
