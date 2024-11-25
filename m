Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9B518FDBE
	for <linux-modules@vger.kernel.org>; Mon, 25 Nov 2024 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526527; cv=none; b=B2v4OE8DOi39yjmckuAkk3L9i72AP5/LHHdd6EnbdpjdLIiLd60PRdWAJY/qorMw014/2EMkVP3yXTPnXApc1SkjseloqXNYla+NyAJBBiNlx0AhQhOjPg6r8xjFooOy0FbFqwuS4WqAkl5AfE/3w6Qsj/52Kqc/0jCqOcAQ/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526527; c=relaxed/simple;
	bh=FCYlpekwLX29y1babPtkl5hhwfzqAWLF9A3oe2+5id0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlZlykeWxF14QFBIRpqoePFimmE0i6gNBEhuANHwuMGF10v7Bxb2VAUVktxfg0+GA50YmxSzWJQNtuzLk0tDwffNJXVEYP9M4atr8GWAsCu9IDrRXKdWvNR5S9woIEipYi+rH4HUyONY6lnSGEsJ4kGNHX/Sh42Xc/kkLR0n9Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/QApVvC; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/QApVvC"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cfc264b8b6so8223a12.0
        for <linux-modules@vger.kernel.org>; Mon, 25 Nov 2024 01:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732526524; x=1733131324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCYlpekwLX29y1babPtkl5hhwfzqAWLF9A3oe2+5id0=;
        b=L/QApVvCl2TEfZGYYEfTC3A1hQNfZH2vjBTq86eD/zjHUJ54iRzh51xj3aYuIKBuUv
         YHUejdIuGeK4KTPZ4p4MVGpV9KX1wfCemqd0ciGNreYL8at1hJVYiDvamxYmz96qz0GL
         sDXHtdhWoEK/iGnani5i3vzGP+qpSQVXE6HxYedijsvrLlstYYhLxPxNPvUlaFkPfqmt
         zEhRnIwbUXq43jiXU2o+hdZBEAueRG1pjOSQoLf3R5bNjJVU4MGLhUzse2juThQKgsiC
         mkXMThFP1UqRsiIJmzr8IvZFvEYXtfvSqLgPWNGY/dclfQbUKAf/SBjZlglyKAYLSE4c
         wdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732526524; x=1733131324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCYlpekwLX29y1babPtkl5hhwfzqAWLF9A3oe2+5id0=;
        b=UmECN+iqaBW5dTAqYqD44CU9PEnAq47/0lr2cVrUyx5m0tIH2llflG9uosr/GLoh/4
         vfyKpnjPa6q4/PCmOWxERx0tUooTDmz+d6VSVvgTzLPwUI1fYTLXGIM+bbFC6xK185SC
         VelllZK9oSPj1iWHyw7x6YSUS/fM/fTaTM++b/qtoaArHZaizgYuUP3WuSONp5v6ngX3
         JTThVXol+crEgQL4R8+nHg6mX6ewWYNHolEuAVYcBPKP0KhNJDCuhBBA3J+Eyw/mKnOW
         htWWqt2T6OODnrGuH2ru/Va9zc/ZPXRVxvx+taqc4rizAOPMmiULjfcA6IxSuBIRI7zC
         zn2A==
X-Forwarded-Encrypted: i=1; AJvYcCXsiNyW+0vAB+sDotFG0nXy/Z94tcXqs/nlsKwMKM6lOFTMgmqs6caqpkSKAWEULFMyY30KClfpNvvApEjt@vger.kernel.org
X-Gm-Message-State: AOJu0YxU0Vq7rfreFmG9hcaXH2rvJABSeTmeV0yqLa715y8r8DM37l6q
	/fe3d5VVX06Fi80d14ujwIKdqsao7wO7GusPRbwF1YLJ5B6pws2/qNqGKV4wQtFmzUSiY7X0U1Z
	ZkYZAWzdQVOWuZA1sjiALYRpm/P1Y/zLUMDt6
X-Gm-Gg: ASbGncshq5NWPAWa+Wz8IrF5+zGpNNzl4VZmD8S0VIR8X0YCZqj4jQSgGkMZhUY+JI1
	WkjZlqqopzt0jbfrzcDHErfVhIG/jCt4d
X-Google-Smtp-Source: AGHT+IEyjVc+w4xYMWK45ReBVdh5zSSYk8/svaq/gH5CeUai6F225gz3gVyn1zbIlnkBPYmtw02u4vkN3IF6RImReBs=
X-Received: by 2002:a05:6402:1ca2:b0:5d0:3807:bcbd with SMTP id
 4fb4d7f45d1cf-5d03807bf0amr89021a12.6.1732526523672; Mon, 25 Nov 2024
 01:22:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121204220.2378181-20-samitolvanen@google.com> <CA+icZUX-gf8624z8u+h-W8KeddCruYDng-4vTggNGwC61NzfNA@mail.gmail.com>
In-Reply-To: <CA+icZUX-gf8624z8u+h-W8KeddCruYDng-4vTggNGwC61NzfNA@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 25 Nov 2024 11:21:26 +0200
Message-ID: <CABCJKufb7SLY3j7EqRwFkNbrp22moJ51rDJm8madpUQdOhV9kQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] Implement DWARF modversions
To: sedat.dilek@gmail.com
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sedat,

On Fri, Nov 22, 2024 at 3:51=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
>
> Thanks for the update, Sami.
>
> What are your plans to get this upstream?

Once everything has been reviewed, I'm suspect it would be up to
Masahiro to decide if he wants to pick this up.

> Is Linux 6.13 the new development base?
>
> Personally, I would like to see a Linux v6.12 LTS version offered.

This version is based on linux-kbuild/for-next, which at the time was
based on 6.12-rc6, I think. It should apply cleanly to 6.12.

> LTO is not supported - might be worth mentioning this in the
> documentation patch with some explanations?

Sure, it's probably worthwhile to add a note.

Sami
