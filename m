Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3612A34320C
	for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890320; cv=none; b=pTnSYT6pRtuSePg1Ntt8B6TlLnmSuIrnysNz7jfugJ0KMhHp4T7YFPSuxQgxip6QmbvoMV3+U2pYArHGXiL2eDEs4t3XKtpeDegUTmDYNmGCx94LDqa69PeEjqNyNaK5zxjpV9YTt4LTQg587jeZZTxQ5nosvVkybZzkEZfPL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890320; c=relaxed/simple;
	bh=Sg7FhLFPHYhYHz0dhqTZ1MP6Nbu0jdxwfOGdyNc5gt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFWQhuU1NoYUZH4NgWCxI2PVm17rtaqVgjF/u7zTIGodHMTLOet9jvcaMcsRYuyRn8gtQa4i0dDBovo2T0EUCJJbkLy8wcmX30RJzyYKni9HkpxW6eS3K+CiEq98X9vpxz7aKp7jMTjlalCdzcj4uWLdsDbOV91oOw/dnwDGpb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOWsf+Wy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOWsf+Wy"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2952d120da1so113675ad.3
        for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 11:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890318; x=1763495118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sg7FhLFPHYhYHz0dhqTZ1MP6Nbu0jdxwfOGdyNc5gt0=;
        b=eOWsf+WyXEw/eSF9CmjV7HIDweZC0asEzb85mqYKzz9wg9h3Fdpm+mS73vV/5Ri0q4
         t8upNUavqVuqv1KuNaDwbNcMTtBmEav4/wRRVAiTOGmNkbKa7JYB8Sr3/GutmNH1zy2b
         sifoMj72Cs8fBjjrfh0B1yIsNwfW1QhayBnLG5uGcBynT17eVAjrj9w8qJgEMGmXwmvS
         KNqDLm1LQdTW45V+nMxQyCR6IuZZ5AEvh72qA2Km/jLtdUtLXA8HsON+YTh7klrydLoW
         gbXlNtwgbm0lWwyAwSzuYEffId7REO1vPMVZZsuaHTmVcPh642HqHwn1o3As6AL1BJIl
         cDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890318; x=1763495118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sg7FhLFPHYhYHz0dhqTZ1MP6Nbu0jdxwfOGdyNc5gt0=;
        b=VEWOhi1/UieZ/+VUd0QsYhrIedJhufp6aTvZPV+Wx9eJqhNbSbvQt4iMNYIvX2CjD2
         UgBQbddqNK8tm30mTIseG8lgHlvfweLNjmdRko0Li/1Rzn6PajKVAM2VRTZUoluck9gc
         gg7wxkRMWsquxS1JdfxqqY/YlTp2/9A28ImJJP0oEKZF9nq0Y7tALIOI1T5ZwaAAJQ//
         gxYjk3W8a3GDCIpfbJuc8PXqScKhjPk7jUwrUm/bui6PMu8oHZolj43H2ZNKMX9s5bs2
         E0DsR4AmhT0Qy8OLqKXtW4jcD9GyKT3lyhIJ2HXZ21rbfXp+WaPydlpyOMB0zHLTCwT8
         TQdA==
X-Forwarded-Encrypted: i=1; AJvYcCXpPZY5NDdPn3hp2XohLyxrOecY3ZKSZV9Zid4lCNtXZFJsw0It5Rc4Vx6fOGmyf2S4bPcnvxNoktKWOkON@vger.kernel.org
X-Gm-Message-State: AOJu0YzJfp7VZtVbR1VhJj3dB1AqjSUmdYZaMRuj/Z5wj8MRcHg9QxQ4
	04GDAi1Q7vYZUOpqe7MAK5c25PuZwpWs7z/J7RgcVDt0hKVcYbuvSQNVQ1dUlP0K2NZ84niJVBW
	K6Fs7PuTcMzNzl8ll4I51nnzt4jI8wkE=
X-Gm-Gg: ASbGncvWIT2OQlXZedfMzJt5w5QaHuQd+cLsZiEgjFB5RjsmF3ZMyfOpnls7l2LJSwI
	tCIkCR1tqcPltuMJbCuX1JvaaUJV+GNV5O9WfNMrnUeqmpaTR6v7F4l5JiPmk+Db65dzZXsCqyo
	N9gldP4LVPLEVlu7jS8hkKQFBPLdoAXUH3C/8QgU2Slgyz5pYTeF0cBBWvDAZXIfF2+NhAPDBzi
	xkIiWJRoL5a80mZ7FO9TI7xgbfxjXJaNZu7VaIMzaoWoNwPBn5LUidOQRKh5tjMcgaDiacbj1IS
	/i7bIbVu0VOeLwgJir5DLxBHlPct7ZLbib1iJNbN717vD+ifEm3XANvko1eCra4c3BfzIXr3EzF
	oxIY=
X-Google-Smtp-Source: AGHT+IE5zjw8D+my40d60Ix41uKXNSt7HOnLAKKhJi0H3LCnV5CTo+qFPBfkXgqbqQK8w6cViFfsGq4E6L6246te+k0=
X-Received: by 2002:a17:902:db0a:b0:295:70b1:edd6 with SMTP id
 d9443c01a7336-2984ed884e3mr3098505ad.3.1762890318029; Tue, 11 Nov 2025
 11:45:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org> <CANiq72mjFobjfQEtNvk9aA+757RkLpcfmCCEJAH69ZYsr67GdA@mail.gmail.com>
 <CA+icZUVcHfLru9SRfhNGToiRmyOY+fLw-ASEvQakZYfU1Kxq4g@mail.gmail.com>
In-Reply-To: <CA+icZUVcHfLru9SRfhNGToiRmyOY+fLw-ASEvQakZYfU1Kxq4g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Nov 2025 20:45:06 +0100
X-Gm-Features: AWmQ_bkZOKXuOXoFqnluk99fIIrWIqE98EcoUgehQR7XEFroNIarOWjMBHltciY
Message-ID: <CANiq72mS2SFfMsMgVvmR7dgBpYq6O23Gx9fQmDWuaqrz5sVNYw@mail.gmail.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
To: sedat.dilek@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 4:25=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
>
> I switched over to gendwarfksyms in the very early testing days.
> Faster builds. DWARFv5 fan.
>
> And was using v5 of Sami's patchset against Linux v6.12 as it cleanly app=
lied.
>
> Last week, I jumped over to Linux v6.17.6 and the next testing will be
> Linux v6.18-rc5+ (upcoming next LTS kernel-version).
>
> I will try this patch - might be you will get a Tested-by.

Sound good -- I have applied it to start getting testing, but if you
have a tag in the next day or so, I can add it.

Thanks!

Cheers,
Miguel
