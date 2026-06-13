Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EB838737F
	for <linux-modules@vger.kernel.org>; Sat, 13 Jun 2026 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781347276; cv=pass; b=LQpMuUA3gz9lSQF132Fay33h18I5TSkufe4L9xgh3C0/9nRn5z1v2HUINpn24JTW0so7Ig/BQvw9MpgxGcjZZrDYWxOrgDnEjUNQcVS2ZIWxzrhM+hT+X4d2x2oZWGNvHx6MvpeUWWL07TRZbx/cjGBFAc+PAD1GGNBH0u5fpow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781347276; c=relaxed/simple;
	bh=7k6tbN+HH+WkUq4HSNO/mcXSBNU1lROqmA4mfJkiWzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwxkJupkz180XN4uue5z+0uqfODUi15WrrXFatXAlUBkMEAMkItaQDuylNrsa+0bHBFtOLMjcIYisovj2e7M449e0a+g3CBDpOZiedsNbuBSHaIjNaugHFW5l53cgafSfoGnjyMf2qTPhEoOo8AvgP8yB8c5UTuaMDbMf+c5gqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hggXMU4p; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hggXMU4p"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304da3b4508so232639eec.2
        for <linux-modules@vger.kernel.org>; Sat, 13 Jun 2026 03:41:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781347275; cv=none;
        d=google.com; s=arc-20240605;
        b=J8ntrmSKUWX9Z2+5reoDvEHWMD2VhSOneJmoP0aXjUhNcVxxWu+NjWxo0ltURo1H11
         ASXhcwL2I5E1D8QALEzsj3AO0Top0zRtJCqSjEZdIEMWswDlei6EukaaJlPhtLwB36ni
         Jt/gOFKMl4FbCiFnDjXjBWv4S6sXClkv4jNKc1/2QTrtd3JUsa8DvDZHnb+EKoFOT8eT
         2D2P5SUIZhQl1ugAMnTSArknWazy3dhSzfwru9NGS7kGrtaL6BUZI+xfMPze+Eyy04iz
         CosqjTaHaTUwNt1Bm0dMesDndSFkjdAVwX9H6lTQCzFz5b/p66kgWUpYAT/o6V9sP3QN
         AU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G548kc/xuN9FYSMWIgZO2PFN4NWhwpWrdwSftDKzZuE=;
        fh=tHDU4Paq7bvRe0RuL6utj/EJbtKkjD3Q6tt/hVfv6QI=;
        b=HKy2OYZmavu6qBIq2q1O9Skp69x24EAbrIIK1jN1wb7e6u+7DRPZOgYC4/Zlg5ilnh
         2BAiSCn4G0tYHXaZz14kfIZAugiGA0ECmYcFiMEuSw+QL29XwwcG7ZVjhz6PogKzlKma
         RH/5Ol3m/c3GKMwSCmLTQ9i6QpLawh5qGFeAAuiAQyJy2vWTEiiqaBxUWoI+9BksmUdg
         sGkFPYtMJfxOVDvshRpT1+uelNb+k5KAihmNfZLGrxNd9R4+9zpV8vPYSFMNKdSz242S
         wZxYoYYQlpegTERFJ/OpqgjF/gi/mgTxYxCbBZLe04Nfx9yQIEmYdmO+8sg+4svpiTAm
         PpWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781347275; x=1781952075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G548kc/xuN9FYSMWIgZO2PFN4NWhwpWrdwSftDKzZuE=;
        b=hggXMU4pAdKn2lZVKQNgKjiSta2uifLDJ9Iw/l48crsFzrm3pbnbxxy1To2ak1jByT
         FsTwmGAtFUqq3xR5x2gmKgtlDFR6VIyUeIVUhyC1mv0lSQ2DJYl9aUHrq0Tn2vgbhdyD
         64MYLIERBYdof+mNse5jpRn3OOFgL83vhqj8wJobew/GLHRIadj/qPqfBvx2f+gu22cB
         G68l/HyYn1KEFja7mTg3a7a+gg9VZadaOpmNwO+Rv29lokcfcSpp6O73hfztkdCDV+Iq
         SuEmMC+UyKiLEGR/ETfUagX0rgZ1wJCMFxhRnmJd3XM3po15eqBiGDd6sa4rfqHAzYSQ
         mLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781347275; x=1781952075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G548kc/xuN9FYSMWIgZO2PFN4NWhwpWrdwSftDKzZuE=;
        b=K0RGBGJqGc3kGOff3iozo6QTiz2tYI/dXYw7IIbCeSClSY97PNNMO10VP07QxKnFcF
         NBBw3kWTN3cUxaDpiOoIMmHNA5DjCsOpCLvbspQBVRBC5iIyKEEr8kF4Mg7D0phIjLun
         2kAv0K1pABSZ7ctwcPze+qmCzT+E6z8f30HoyGzW2qjiUSOwPhqdUYkQ0FGuyrkwFRi1
         9LFHlBdKZGzmpl55lkNfc+g3KZyRU2MSOjA+G0y/HH7rNX+VB+7w75UsKmYHqpk1Bde4
         Pss8sLR2f6ablsUHGWhQCfDR/a2UKW8yvZKf22PsajnC5XTujAxyJGQC7fb+XCPB3LNk
         sK5g==
X-Forwarded-Encrypted: i=1; AFNElJ/NmVmMjOo3QFS2hPWfshpKBg5qMtbC5JGLelAJzQT8MpU2uRS0c90Oirb/dWV7GqTJS+urSFKTgPHBDnU9@vger.kernel.org
X-Gm-Message-State: AOJu0YwJsj/XR8mHcqMicA9rT2ctc9aej8MYuzoCAm0w6R/zDth0pUV7
	adqAfYGIJTNL0GyvGFcuY7TURfmBoo9s98J/OOX9PsBEW91e03mpkMz1dO0aGo7i0MhU8bSVNKm
	udt/zGyjvLu/PRd/IKCFKHbQiXVXM/9E=
X-Gm-Gg: Acq92OG74TuUi4Kd1jJsmo3iQdKa35lNEceFRGOtjaWaN43l9jxXKYUYi1HEdMsPWH7
	tsnz7sXYdVmh9C15hhMB7YIqGJWPgGxNZqqWFzHvEec3SkDzaH8gQbpwvM2ZUMFwmhZ3kXjBlHO
	twj9jM//cuR5oHOEuhS7TcJ7NWzaLqBkUY51xDOni4ndKwd0T1CSGULVmFNpTps9n3eIp1BhBgV
	cVRiZcRq5de9d8RhesNJvteEEJCJ6G0rhx4VXPWJ8BynT0l/mNl0LE4Qby+kwVkxlOgDFaRP2o/
	MduxGShapl2CjyFYrfmCRzrjcr+mQuIY4wyJNBS+Bdu5Duhsuu4mQUGuW3rdSKn4semY6XroLFy
	kxd2znZ59VYEDy69KwZB8d+hOPd4JuUuBzw==
X-Received: by 2002:a05:7301:1e84:b0:2d8:7302:d3c with SMTP id
 5a478bee46e88-30820037738mr1755166eec.4.1781347274604; Sat, 13 Jun 2026
 03:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-configfs-syn-v3-1-3292fbc5cc32@gmail.com>
In-Reply-To: <20260612-configfs-syn-v3-1-3292fbc5cc32@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 13 Jun 2026 12:41:00 +0200
X-Gm-Features: AVVi8CfjPkD66q9qYEn1K64zbUlvP5cZCsx1hvccWsDn4EDiuxrat-r8eY-_Akc
Message-ID: <CANiq72=RX5V6W+1tj0GHxZusrk5OqYbZ5-xV=wvSssrx_CWXAA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: add procedural macro for declaring configfs attributes
To: Malte Wechter <maltewechter@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Malte,

Some quick notes...

On Fri, Jun 12, 2026 at 3:29=E2=80=AFPM Malte Wechter <maltewechter@gmail.c=
om> wrote:
>
> +/// ```ignore

Empty /// before examples.

> +///     // This will extract "foo: <field>" into a variable named "foo".

` instead of "

i.e. please use Markdown

> +///```

Missing space indentation

> +/// Expands the following output:
> +///    let item_type =3D {

Missing example block, both at the beginning and the end.

Please double-check by generating the docs and looking at how they
appear in the browser.

The prefix of the title should likely be `rust: configfs:`.

Thanks!

Cheers,
Miguel
