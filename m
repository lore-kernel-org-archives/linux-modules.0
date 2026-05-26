Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F013E0758
	for <linux-modules@vger.kernel.org>; Tue, 26 May 2026 23:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779840006; cv=pass; b=CEYtrniZck7LBlYHzzAUXSqj2S7kYBaaiPc58syBVj4XF8inpjI6D7qZZG6ryi7q0EqYMstnTCq0bTCk3QiHmkidWg5pJbm3Md47bv+k/lS+B1m/K+dH48RJjXn9k/YhpNU4GI96tNlJ6RcZkCbAj2LYJS7VMe127AQvI32lg5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779840006; c=relaxed/simple;
	bh=IOnBLCPvO3NhNULOKmAsnK/+AVxD94h4t9BDNjzs42s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpPgng7lmdPo5NmQOT42aJ6/Q3F01fW9haVHP42nNQwTCWWHgd3Z5U5lxb0uddx+mcUrYhpm6mmZEu3wPG51hpBmV1R1ouIlwfGgdH4o0/j6GQzabiWd9ORYrQ9oVWUYGZv6CsaCffgmSy71EOaXDMwQjpsQwPH9jO2/gCYk8sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ThJ/ePrN; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ThJ/ePrN"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso70a12.1
        for <linux-modules@vger.kernel.org>; Tue, 26 May 2026 16:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779839979; cv=none;
        d=google.com; s=arc-20240605;
        b=e+AFMKe8Rz4b+wbPP6deY7Whx6u2JQfECJHNMJ9AmBDybS175uG1PajgBXL6r3Fyap
         5yn2FGCTS/5X+pKJD94y3mudp4krxLSdzIxBR0oDELncUslEzDp1fx3iJAydh7UsNbwP
         RJ+DUkT8JbLlEZx+7QqtQv6Oq5Bp3UGrpgIfUzYIs5niGwGrwJA96VvAT7T16OVEo9Jf
         uvJRESw8jKXdfzFe2a6ieM0ilUM1BjTF+7Ztp6kifgmGNfSdGkikCXV5s0VOIyPw/tGO
         KN2HxWfdP5lKLQi8b1pNpMZ+aZGjCIV9PNAsLTV2VVI4Yfom2txVRwDJA9DwKTFEAyXM
         dFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ddLKUcZEKjh/VeC6wO7L8rHmcyDC7Ag+vZxzVVz7ubg=;
        fh=BTlzidUZVDVd6kabz+zJV3UXzlStg9jlGlv2kmOqKm0=;
        b=KpbvaNxW1RnZyFlqxilgL/tQ3myF3cdH6r5N+po1mDzuvsUyLvOkwxGilV2txc37+X
         Le8Ky5I33HYTQPQKl3/LSnGP9X/3We/N81Q8OG767gBHN9QCKZwivoFcC9xJrF5TwmRZ
         p/vUXuZI79kfXRXFx76Jhfz4fPMoCM6CUQ1W79KRxzg4f/Qfu5/+HXKEfc7HqFQDL/N1
         uKVtpauWlRxMekXt6lbP5Q7Y0rIh75E1qLaBgabNky6ZfbPortEqPdNGJjqfbmpRBwn5
         fHjKIaERAXtYiarnfpzHLbWgpfNUPP6VMZ2MapxIkPn8piY22mYWdIhG/4XT4jtr18dT
         jBng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779839979; x=1780444779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddLKUcZEKjh/VeC6wO7L8rHmcyDC7Ag+vZxzVVz7ubg=;
        b=ThJ/ePrNrivOEc9b4c4be9NtiEIjAYTHeBsnK4L9Rb95dB1sZm9e/kUhDFRw4z42nU
         qnzDTrCVrIg9k+Gy4kyL6YGKkDLpQWlfblL26sH4Kulx7+hN0mEsrbvHTXBqNMYCUlXp
         P01kmewE5I0+KYcmjhe2PedaIs9PABWRQmp9LdeO2D4GWkj+0LjKKMVjPsOvgo80eOU0
         IJdnped7ODdrbhV0twjnJjJ0gubXJUD6AlRcV2I2x7rueemWGnafLvO3QdQXv899aV4E
         1/DOpYVywX9S1nPm6V/aYXGbDFuyyQIRzhlQCLbbPffKQFT+nfJhFdNRxfIB8hakqrVt
         T/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779839979; x=1780444779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ddLKUcZEKjh/VeC6wO7L8rHmcyDC7Ag+vZxzVVz7ubg=;
        b=ilSZWtN/hwguhSZubc3Uj80fYlVqgF2BBGphO6C7FWlV4uOt5Vj4TmozQYUBj5J1rn
         hxtj/jDObk+41feW6ysa9ESSyDYR8qVvQX6r4D0mWhw35pDfCRYZmwx2Ewi41i8RV67c
         xT7zaRnCFuzqU110w6UmHHyKDzlYGEGbCUUFGwTaozsN5xV7oXSR+tPWZjwa9p+N+hjH
         A8eNQc6stNHlyiDAqyvDkOCA5Gva9/x3UP1xmFPXmKparIiPOysJmcrpDv+ygyrlTpuU
         Rp+Wet9V0XoPLE1ab1uABGKolpx4/Bk0QJSQSRXDQ9JPvv1FJyAEFOSAaC+hCwoJ0OTW
         3yjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8h6Iipn4c3ZbfTDP6BDgSeDE2ix8QMOhUQBfGxI4r269Zb1YisxgVVfWxZqW68Ufa7Y7AZ2RWhv/0Rme7h@vger.kernel.org
X-Gm-Message-State: AOJu0YyH2SexzOyj7h6ylEwhqtx5iA4A4sf7RYVgvD2Ho2vSfilEfaYN
	0/squNz5fyov/vOb5+qVDJBIA0cZ9viZ0Iqaw6axnOudU/ELeJW7gMHLdeDGcsEA2H90HzxuFg8
	PT989Y2Ey1j+Y43eRF+COioyUvEbeD2+GyorglCqi
X-Gm-Gg: Acq92OHzbvTESM7XoohdaCVZnk+XDkWh9Y7JRatEs18vSEDz6GiNgee8BuftHaoFomX
	PtrWYZfKulqqtK6547UrYUA4LIe5bov/jxKcSArFzHPQx9l6U6p7d5jN4GHwBQfueTWPaM9N+lo
	X8gpxyJpo3PhjLdLUpyZpHXqAsCQE7+FuI5jXMp5FilDop+LXBngtO6q5KpPdnY3PALeFoG4+7s
	7VU4ddcmXqaZ3YHBMYxmP+unqRGn6kJyohvR7a5D/7X88K95mRaIU3OdHp2WQ1RKjpXcP945PoU
	VFudqLO4NWSsG48=
X-Received: by 2002:aa7:c48b:0:b0:679:4b60:c7d2 with SMTP id
 4fb4d7f45d1cf-6890a047644mr138223a12.1.1779839978918; Tue, 26 May 2026
 16:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-params-pr-once-v1-1-3a8c64704cc4@kernel.org>
 <177983883957.35274.15506019019254966722.b4-ty@google.com> <CANiq72nq45d+kvyR8jp-hdJhFHv-zw2i51mPCduBeUdgSwMKsA@mail.gmail.com>
In-Reply-To: <CANiq72nq45d+kvyR8jp-hdJhFHv-zw2i51mPCduBeUdgSwMKsA@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 26 May 2026 16:59:02 -0700
X-Gm-Features: AVHnY4LR2XMEjvxMyvYWYkdUO4K5AC6_qj_1wz6o7NrReKgVUHEA9jcUWqjE_5I
Message-ID: <CABCJKuen4ZHaTzJccjjhhJ_ACKFMHCX6pT20O4V9xCyV=9eVOg@mail.gmail.com>
Subject: Re: [PATCH] rust: module_param: use `pr_warn_once!` for null pointer warning
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 4:46=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, May 27, 2026 at 1:40=E2=80=AFAM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> >
> > Applied to modules-next, thanks!
> >
> > [1/1] rust: module_param: use `pr_warn_once!` for null pointer warning
> >       commit: 8d2a562b7efe98fdea57d10caaced911fca46a3f
>
> Even if we pick this one, should we credit Adarsh Das?
>
>   https://lore.kernel.org/rust-for-linux/20260226120848.82891-3-adarshdas=
950@gmail.com/
>
> Or did Andreas send it earlier than that?

Ah, that series was never sent to linux-modules, so it wasn't on my
list. I agree that Adarsh seems to have sent the same patch first
though. Happy to credit him unless someone objects.

Sami
