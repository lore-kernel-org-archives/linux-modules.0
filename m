Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063EC188015
	for <linux-modules@vger.kernel.org>; Fri, 15 Nov 2024 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667880; cv=none; b=BJnxfnmlaKA1Aso8RZmXF48Q2aU42oQIh8tltd+L+5RGHqp/67QJC+N5mwKuAF/g1UFKABGPjZRriYhX6wjjGJWjZDosdB+2kMP4/IrSRpyu/XCZtYJIvieQfs1Sdv9ieXDVxpRkPlIOH4pTAGGdDeMWzIsKLl/GdV7Xhtzzd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667880; c=relaxed/simple;
	bh=Qx4F0F461BzRVt5DGASUXEaOPXglVHaubs+hPumYIhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cB51cJrIIQJTOQmKDrZErcXpzNxDR9ulh1zLCVICKmjzMDLhW9/jPPP2cGjN/8ylqQm3+i3fuzJtETqAjD4P4WBCOFPXtUwjUIaA1HNz7guMSpsAZqI9XRWnmyZve0caSmb46J7bl66CcDih1fVJ7SbYgq8OaXr8/XE8dlRrhdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ghHj80am; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ghHj80am"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431616c23b5so9521185e9.0
        for <linux-modules@vger.kernel.org>; Fri, 15 Nov 2024 02:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731667876; x=1732272676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qx4F0F461BzRVt5DGASUXEaOPXglVHaubs+hPumYIhQ=;
        b=ghHj80amLuodM885jnFDpzZZId6U4zEf6JkFlhA9mrzvt8tVKjKVfQlTjslNv2xQid
         a8ZB01IdS/yqGFrPif0/bmIdYnsSbxnORyh28jgiyF/QGudhAwdgLpzu7OUHXro89Ur5
         TC6eiMQvxu8lbyScFHAJUSTMvYIk2ThCVs6U2yubFvp7QKBNT6URWKLdDBSEfPUHkTQM
         ROn60oJ06X6mivXbRs4nhZE6COyiGxs//snCH352VtbSAfCG984AyD4oaPeFec8Q/uoa
         qwk2T9g6vlVdhAy08koNLRutsUJG7F1j7e8f/bu6d3yILm+RVrCr9XZ6OoT19iDX2+xZ
         /Z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731667876; x=1732272676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qx4F0F461BzRVt5DGASUXEaOPXglVHaubs+hPumYIhQ=;
        b=Rl9WuIdQo8ZZlvBlx0XotOymmYRcjfN8Bl6d3KaqzUgNe6BcP2YsLUcngFRqjdDKmK
         tlj7AFiIHXTFL9z5vKkVuBYyyiAiBwYVb3ZH/fDk6SqSmVEVUzGQliZq/LFPngT7myO6
         RFEH6mCY8W5Q2s+m7JR9nJUQDydJVWgCB4VVTiCLUyG5Lhzun3CJEnsE2j/Zgryis2Ju
         lQpkKqi9WTNSpLS039qvpF606V/QeJj/hPIKtG+W1mX2oPd82f0VC0Um/txqrKO7G0c1
         beoEGDOBIzyJcvBBc89lemYain+gTd4QBA80IkQbosnAHpXstPuudYExnEuxGofhIVlL
         EJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUAjsIkTjjInGpN9JWtwmlf/nDtdpwHHDRqgsMgsF0RPmtBBRZo3w/YhMSNxDEWZAbUbhEUETTxLnhqUYF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5mwcyJdTZ9fSskPjpQ9AbwrUNsc5hKq06EgefALf9G/ZnFA/t
	SvGkqr6RMqgkwW6kiKuOeb0xXLbcdyqKXrwg+r5jY20j+mTuiHIQ4ulcOMvtWK0=
X-Google-Smtp-Source: AGHT+IEELQH215cT5HxQoVpbKazD1oIwR5e78Y6MuL4jy6qtS+rOi2RiLQuJVhCpA5LXSAg3YC4WLA==
X-Received: by 2002:a05:600c:1c29:b0:431:4e33:98b6 with SMTP id 5b1f17b1804b1-432defd2398mr20383955e9.5.1731667876341;
        Fri, 15 Nov 2024 02:51:16 -0800 (PST)
Received: from localhost (p200300f65f28bb0063ffae39110fa2df.dip0.t-ipconnect.de. [2003:f6:5f28:bb00:63ff:ae39:110f:a2df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac223e6sm50118295e9.43.2024.11.15.02.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 02:51:15 -0800 (PST)
Date: Fri, 15 Nov 2024 11:51:13 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, tux@tuxedocomputers.com, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thorsten Leemhuis <linux@leemhuis.info>, Vinzenz Vietzke <vv@tuxedocomputers.com>, 
	Christoffer Sandberg <cs@tuxedo.de>
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
Message-ID: <y3lspnzleavkgvujrf66rly65yw3sskjomcvbginijgexaybys@bg53hyadhcbw>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <e32e9f5c-3841-41f7-9728-f998f123cc8a@tuxedocomputers.com>
 <2024111557-unlighted-giggle-0d86@gregkh>
 <6c1952bc-f58d-4c55-887e-6aa247daec5c@tuxedocomputers.com>
 <h5q36ajuzgwf5yrjmqv46x62evifcgoi5imxhcvsv7oxauvxak@sj54oisawqnf>
 <58b85a78-55aa-422c-a21d-254eb16cc8c6@tuxedocomputers.com>
 <2024111522-brush-excusably-cae5@gregkh>
 <3ea99d52-cafb-4c79-a78b-fdd1f9a9fcd5@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="urniyztjj4xzapin"
Content-Disposition: inline
In-Reply-To: <3ea99d52-cafb-4c79-a78b-fdd1f9a9fcd5@tuxedocomputers.com>


--urniyztjj4xzapin
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
MIME-Version: 1.0

Hello Werner,

On Fri, Nov 15, 2024 at 10:40:56AM +0100, Werner Sembach wrote:
> Then why does the proprietary NVIDIA driver exist?

Please don't use NVIDIA's behaviour as a blueprint for your actions.
INAL, but I would not recommend to deduce from "NVIDIA does it and
wasn't tried to stop" (for any value of "it") that "it" is legal, honest
and in line with the open source spirit.

Best regards
Uwe

--urniyztjj4xzapin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmc3J58ACgkQj4D7WH0S
/k7y+wgAoeHmj2+Ieb2/+7ZLcMqzAgTHIowWVwOoVKDhzeR/QR/KcGI/NpJy6+9d
N8T7+pSTEZfckqr9kK37pjzX5bRFYnqAOdzKbi9z4qHL+8aTLRVn2nsi7kombrEZ
0L+lRVzkXEB1bPndRdSGisMhKqLQu8FTf8hNXnPNv1oVoTR5CqJaYRUGVdLt0XJo
8xQF88D47JhOCm37oMhLqfkAewQqJ0giSKSQKzsC7Z7OFcMUuj3m0alMALIiqJcH
34J2igse0euzjP9oQ2eH4v+I9wk4nSB2rAWukYcDEUuDqYCg0xQRL2PpS8YrpQQX
FwoHsvdf4LmLdh7SQrma+KylB9rNCw==
=Kv05
-----END PGP SIGNATURE-----

--urniyztjj4xzapin--
