Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8584418E6
	for <linux-modules@vger.kernel.org>; Tue, 31 Mar 2026 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991688; cv=pass; b=p+YY9vdSge1szoxBMwE587Aa9kmb0vlMH0+apSlv0sAJGBSDbau9gOzFprriiZU4pKbMGhlr6mU9vlCiS3LLJcitG6iVQJXOiFu5eNHmFUdeEw1/zZG9UM/OrNPQygDdRe9TGCJCaLSuyvvlAr6mw07aICLbuQSKDJxyrMFnZpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991688; c=relaxed/simple;
	bh=+JxsCBfymivBX08sGiCuLcobIN7cdPrVFtFlzFTvswg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxS9glY21c3qfrf4U+gUiZyyuIglHiLS8C4NdBaRHSQ3GcsCRKqWY9hpUNfLuhka3rs2JdvJRPPn2WVqsJv91kWyxScpFwY3Y2TtQJTxGcQzcnbTkNjObxP8r71RBBgTZt6J0Kc1fvpYUibMfdW4zQBANXKna3NPn0kDe6UKlvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pgpZbKDP; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgpZbKDP"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38a3fafdec5so3623111fa.2
        for <linux-modules@vger.kernel.org>; Tue, 31 Mar 2026 14:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774991685; cv=none;
        d=google.com; s=arc-20240605;
        b=YMelpVGymbbYhTI0pui7rAERQ2K4tbpdLvE2vsGrOjmsboRb2u/0QC4LyiFMHSSge/
         8V7TlX3zWDN+UDX68OdopKmHzo1sxb0vi5bF0nxQTumZezzHsvxCpLt0CzSPrLR1HAt1
         ner/xnSyctaYsKgCcqD6DnYGSt8SOo2ipbsjpji7kVMIKr5cuEr04kDZselSAy7B0Dqf
         bYhEXMOyUuD9f/fl73npOfaGeCU+fn/X4eFvtVqrKwlfYw+v3R11kdmK6zw7/tUp4bCq
         wHVst7maUeUKFz4EbIwJFSEAuNTgjVpWicthJSwZM6YOw8xfPbuT1zX8EYvZtlRCl3TN
         9Vdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+JxsCBfymivBX08sGiCuLcobIN7cdPrVFtFlzFTvswg=;
        fh=WCBWUGh7YGpue4Qx/I3DKZVMODya7fST7Rdqp+kjmkI=;
        b=HLbOrMRRsWl2f4vnvNo5nX19QdyAQoSxfG6/b7pK0XPPi2tNfvxXMyQP2uDmc43xFx
         pSPmIhz3jWfNLyo8TXKTgrZcHBTckPXIAWTrIz1N6fBXEgNPLr2GrxSBeLjeVpwoyE/Y
         sBg5aj3rdvp/CK4+WzKyeqCaJsfV+BjO/VBItjRQ0vObx33Jx4XE7YbcAXaYukLNUE2J
         IpVIap+xhxDVbnAGgfEmXFDr+jkFfFod0XN/drBkL4AGfnuo/P/30w0s1Iwqf5EnCJgs
         C+C53K8wk71H51FhIWp1QqB0xXhDD/+CZHCKpB7RVLB+S9ZOoS/GlBrv0GFJSuFXZOK9
         R71A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774991685; x=1775596485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JxsCBfymivBX08sGiCuLcobIN7cdPrVFtFlzFTvswg=;
        b=pgpZbKDPX5rw9ZhtnZLPYXW9O1nqFMJtqu7lejQhRDIbHBVvV0da2co4vmSlry6L2U
         J8K/AMGbwV80DKFjqhkL/rYszDWgGcwg3KjjF1CACaPU6qjZPhr/Jy1ceiio8SugpPlq
         /0FgazDqRin9FOJh1VwutKYbFG8BpKcVJUejLGGTIs/htQNMhbpQ4iWbTjY8mCCTSpIh
         LZi/OgOhJoVaO/IzY0bprpXMwM2kfITgLN7BlSVjq6DbIWrDstq7M6/W0Qot2d0hy0uQ
         6OddvKRfxFfDDLKC9Rr2/RMOG/Nszm98C61h7IoJY65AjF6fKxJORf0/+Tjnu1O2gw2J
         6W+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991685; x=1775596485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+JxsCBfymivBX08sGiCuLcobIN7cdPrVFtFlzFTvswg=;
        b=jyuwAMUgPVwTeTMVa4spSTsmN5TYXAdqWE+Wowfh+/YNgT78cxxYccuE4vbjM/Vqyt
         VtVg0Nu48IR4GCs82X0M4bWKcoPQf7nm6cwEiL3ycIUQX/9v3NflpR7pYcIE16GaMyo6
         SHjt6c7uPUiYE0zzN9il9YzYSHN6IThtju29WF3L8BFYyNO0c+wJIHKUZ4QZHqDgFdl5
         cndDOq3BHXUDjhiJSSCI7TVwvKvkQeZ3lJYt9x6CK8trCuzRz+Hcf63talAbjC10nMd4
         bUCXTXaYsm78ougBioxe2EKa6EUk5vQuXPciQnMgaCIvokW/9sxjDIRcSfheoTHdOYeI
         IMUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlTibyNCaZ0cQR0dNBhKrOsA+VzzMTH5QseiSUvLsV65ZX6tukqSK2/k7MtVg6CPC3fL0LqFKmn13epl/9@vger.kernel.org
X-Gm-Message-State: AOJu0YzRcEBLg3veDdF8DHOPRioB0+226hXfK6CCr5yzkQ132A7lpAsD
	Yh4DMA2cN7tjq8Z94rBLy8rlOybNpFaTu3m4mTDXrJDqVVmN3w7VlAW04fwreWJrTCVO8W2wH2u
	/ukVEBba+GkZRJNxKMAmllP82mcjYoF8=
X-Gm-Gg: ATEYQzyu7f/lweKiYtY3NdEnuRfjncq2TUqOYgW7tsurwgWijXk6ug8eI5mobaivyfz
	4CEhIah3ATSypajyj/eRbLL8/pVrAaakiq6wGHM5MPbTeiBfGRo67TAocr9TSb/hLssNTx1H1Qv
	T9IHFLXFwNy5yvDi7U+x4oh9yUXJAfRAJFhxS+tcoBpmmpaajivpRC6GZAhoNNcr8MihJE6dJwk
	LSK5YG+z9rl0WZMUQ4Vgd7Oe1fjKahm/ntwF/oIoI4bhjVSnAZOX8bCMz0D6PFIheyL4IHy9BCj
	DrKMqnttCWXnI4+v2yZzcocxz53E/Se6Ffl+OyIR1v7ARqVK90wsMtezWzM4BuflurMrgXRIfiM
	QC5EF9F2q+8fNupfnEAcXr3Q=
X-Received: by 2002:a05:6512:68a:b0:5a1:3921:ab52 with SMTP id
 2adb3069b0e04-5a2c1ee0fccmr147403e87.2.1774991684307; Tue, 31 Mar 2026
 14:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331205849.498295-1-ojeda@kernel.org> <DHH9VRFULJST.383BKVSWUTZ3E@garyguo.net>
In-Reply-To: <DHH9VRFULJST.383BKVSWUTZ3E@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 31 Mar 2026 23:14:26 +0200
X-Gm-Features: AQROBzDi8zFnFshWYLfIMPc2xGZV-8btLPSlxaPEnVYkLTlH9_dpustOMhcwwhA
Message-ID: <CANiq72=wsdJf1_qwAADhmKA2i7y9U+3WOm+9utE2rv52_eqnpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: rust: allow `clippy::uninlined_format_args`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 11:07=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Does it produce a false positive, or it's a false negative? If it's the l=
atter,
> I think we don't need to disable the lint.

If you mean for custom macros, then I think it is just that it doesn't
take those into account at all. So I guess you could say false
negative if you consider that it should.

In any case, originally I just cleaned it, because it wasn't a big
deal either way, but then I thought it would be best to keep the
behavior the same. So either we disable or enable everywhere.

Cheers,
Miguel
