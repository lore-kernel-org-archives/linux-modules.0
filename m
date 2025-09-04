Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B27027F75F
	for <linux-modules@vger.kernel.org>; Thu,  4 Sep 2025 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017376; cv=none; b=LSDCsA7SXJytSOvaTRtU1pdbpNrY14s6rwUwQUEfZZQ8z97oOYc60bmU8cduJ4rlyD/B8mrciPQnFHUykzxWf1vfhqkEkobNzM8FRxIn+ytxD48ZuPZCkWHPBAUcoahwBsBcIPXPtwNEH6muvJdR3DKVF6h/LOY87O9P0SgGze8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017376; c=relaxed/simple;
	bh=pOSe9LCUGXl4HpI1pu1/gQtGF+5rfV27KrUR5t1T8RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3R9ZJm6q8CCVDIB18Ymd4jTZF9jD73qXeCyyZzD/xObNeahXqiCRiHQsrL1ExJZKAkiWYMriv0ZIfoTf2XspZwOLx6Sqcq6azitS9TrwEcssKipWPxqbjN4DrNLdkrIqkB68oNrGPiWcE2S+YUfmWi/gCkbPKIeewn6d5x2YvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D1sIot58; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D1sIot58"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7322da8so294286366b.0
        for <linux-modules@vger.kernel.org>; Thu, 04 Sep 2025 13:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757017372; x=1757622172; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EFjbiB4m/eIhgkbRs/v135oy1P6+1az87mWyaXYnAmg=;
        b=D1sIot58XQ031mTgRCPm+Ic98putP0IabQZcY+oQW0XsiKTMYl3cq+TeRKnPD9TsQP
         y8DCUSFqpByFRmXJQfxH5+tBGhwfcnAvm286zIrran6O0VUGHa1l1PIluvvA2r+Ca2uZ
         sN/oei58AIGjwpO5nbccmAjs4RzoUIR8euyts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757017372; x=1757622172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFjbiB4m/eIhgkbRs/v135oy1P6+1az87mWyaXYnAmg=;
        b=OgJXfAArx6OAcrnYaggXJTFoGZtoXyk4xLlnQztrYY/+nAsq9TD/k2vTAYqAB9OWyR
         KLP1COaRVvsOf2j0fdY68hjgqEp8JACTiBHET93tfTXQBelBgDhmlb6X/LvQnLs3xRQd
         voKSgNt3egxeS5BEhaRWubrkbnEB4+sijV7AERgZ2HpncL+4/i8zU9BAz8TomsSzsvqX
         /JzSPJLwzCdW8j8dYOgMO9coEs66QKfu2BO52Vr4jf8PheGPlgnKatVjZAESfzEo1/y5
         cFszROH9qz8b8d5jyOaIGrWo9z1PfdlzQ7AWnkCjtmsDfyzRq4Zl4M4YkAJmSTgx/uIg
         /V4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUj0jag/9rOxLginBFygUDhNswIMyQJS1KkjmxJKrjeogOoGcNMqrgGmISa0mOLYIDMALQEV2IiDVp8Yu4h@vger.kernel.org
X-Gm-Message-State: AOJu0YzreLNfDPQ3ahnzB5nvK6hdzq77HWibkJk4C9tErDocHpMObuPR
	zbVWtqjC+BMAA2jGcnKpCqNxHe/jMrqMoCu3/Nb11PZOhfIodS7+Vz72pF/bd8ZcycrJZYpO7ta
	NzqhpDRs=
X-Gm-Gg: ASbGnctbybbZdk88+v8kyksTsuxTKO8QA3Ti1VpR2q+BQSesaPvHz2c59O4z2dlOdIF
	XrJlKffC18/ZvnaET1PBWd7iTXIiCcwbKlY12PH2ILCIHbrjz54w5KAR8tGfq+IxVRZkh6y8C0e
	/E3Hmc/k9frC/9s7v3FbaAWZjm1h7zESi3PcVa4XLFjXPtZGsgVh5RMR4YbjvzWXkOIxKUpY/oJ
	IfWqwi6LjjiGAxuF2B7oea5SouuRg5NfhunkIJMFboPo9ecuyLuXA7CGEKHnPjEzXE6oWfKx+Wv
	7hjBvLtKJSsoI5Yhz214DMM3yg0n7WFumT/16nmWV1tIwCXGOmCzIT64/BgVePhDHxUFWZOBDwi
	9VUWmUseMMpvTkJ+VJ0c570fp9Zmgt3qpOkdhG8Du6hJ2/afdCJ6D9HYILObf5M+PlbnlO+ejvO
	MM1B3SwqM=
X-Google-Smtp-Source: AGHT+IFSaDgXhwWNpPNO1M2KWP2ETBBH6B9GGkCuh1r05T28+loSwrVqkG3hWyD5Hb0nYZiOmaGoHQ==
X-Received: by 2002:a17:906:cec2:b0:b04:33a1:7f1b with SMTP id a640c23a62f3a-b0433a18629mr1394526766b.19.1757017371603;
        Thu, 04 Sep 2025 13:22:51 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046d0b0135sm444788366b.73.2025.09.04.13.22.49
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 13:22:49 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0473327e70so252157266b.3
        for <linux-modules@vger.kernel.org>; Thu, 04 Sep 2025 13:22:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDd7vWCdek4y1yCTr4tc8Sb+xh/aHdlrLw/5Hvs9/JwV++YX/ASBHT7ZCtdZDshoW0jPNHiRFTF+qpMItR@vger.kernel.org
X-Received: by 2002:a17:907:2da8:b0:b04:23e0:5c0a with SMTP id
 a640c23a62f3a-b0423e07281mr1768814666b.20.1757017369118; Thu, 04 Sep 2025
 13:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904155216.460962-1-vegard.nossum@oracle.com> <20250904155216.460962-7-vegard.nossum@oracle.com>
In-Reply-To: <20250904155216.460962-7-vegard.nossum@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Sep 2025 13:22:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizcBV_yos1SZW9Zty7960TCeEE1t2qE_Wmm8CMoim60Q@mail.gmail.com>
X-Gm-Features: Ac12FXxMTxemNqEb5J5AwGTntJrW-uSyt3_5duZoquFOFuM4JPaOvQtYu2LKoHk
Message-ID: <CAHk-=wizcBV_yos1SZW9Zty7960TCeEE1t2qE_Wmm8CMoim60Q@mail.gmail.com>
Subject: Re: [PATCH RFC 006/104] KEYS: trusted: eat -ENOENT from the crypto API
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	linux-crypto@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Wang, Jay" <wanjay@amazon.com>, Nicolai Stange <nstange@suse.com>, Vladis Dronov <vdronov@redhat.com>, 
	Stephan Mueller <smueller@chronox.de>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-modules@vger.kernel.org, Vijaykumar Hegde <vijaykumar.hegde@oracle.com>, 
	Sriharsha Yadagudde <sriharsha.devdas@oracle.com>, Sumit Garg <sumit.garg@linaro.org>, 
	Jarkko Sakkinen <jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sept 2025 at 13:05, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> However, since commit 9d50a25eeb05c ("crypto: testmgr - desupport SHA-1
> for FIPS 140") when booting with fips=1, the SHA-1 algorithm (or anything
> that uses it, like HMAC-SHA-1) will be unavailable.
>
> security/keys/trusted-keys/trusted_tpm1.c is hard-coded to use SHA-1 and
> will fail with -ENOENT when attempting to initialize the hash instance
> using the crypto API _if_ the hardware is available. This in turn causes
> the entire trusted.ko to fail to load.

Oh Christ.

Can we please just make that trusted_tpm1.c code use the sha1 library
code directly instead of going through the crypto layer to get it?
That would presumably neatly avoid the whole issue.

Eric - I haven't looked at how painful it is to just do conversions
like that - I assume it's a boilerplate thing and trivial to do if
you've one one. Please?

             Linus
