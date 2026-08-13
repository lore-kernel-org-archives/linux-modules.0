Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F4443E24
	for <linux-modules@vger.kernel.org>; Thu, 13 Aug 2026 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615460; cv=pass; b=coPNLcWF01ns7CppH+SexjrAVXqO6fklldYHvcsiMbh6kNjRjHH9iiT1fGQxhwmiQpy8dQiVhyKWq/+WoEjlaTx+JU/DIfBRerEzogobw8wqL8f7AZF3+/E7qG03HqaBsLuE4OoP0TH7NAHjoVg6qF93LgwLukGFruubQlaeIUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615460; c=relaxed/simple;
	bh=izncAFina5udvh82qhiR9A/Ymo2QgJMmGzIkcJM+wME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPt/JDmOpuphN+WdZ5bULvCYWwAgrywjveQ/15n4mqr/efTmS6RoSggsZpOZtDkhxVHjOFYzzWQqx5eJD3hqN8zMW0zPicgqE1L6/l3fR6/vrA1ndW02N6wgw5ama0hzQhP7KLGugne6a7seEikluhcUaYPHjdNhKnW6unPJyPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFHTrXRV; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFHTrXRV"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ceeee8c46bso4816745ad.2
        for <linux-modules@vger.kernel.org>; Thu, 13 Aug 2026 03:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786615457; cv=none;
        d=google.com; s=arc-20260327;
        b=abBJl1ZVpRn+URWQO6IJsbt6CE3Ca3wdT9rVni0cqdcZSxUMHiZQWyBkAWjXPmaBGO
         0PNxZSS3QWJzzBL0S/sdCVOHKq/bD3YqrPN6kVFWkhkvZ5Q5E//96pwXl9nicr6vwBDa
         a1nsAYVISj4/S769TWme/RcTJeYS/DJSZIJsT+eE8qvt30RyyjCg/8xTxHR1HHbhg0Lu
         AiEd4Z6OvvIbiXTvVN+ZqBUzb+Z65iRkIGFdARf1IAyo9y/tE9jvA3yxCR/gSrEq5V/J
         TOdVh5yI0cw9goIrQwOI/L1QI19PDk6wjmrW1p2ZFYGoLagsuCOAdDudU5BXpGiNRLbw
         hTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tMciaZ/JSlG6Z7DNQJEd4FD/fd9CJYl/s1BR40smNTE=;
        fh=0z9QeLgOif2n+ecMpRlnaaHrF0gAgqZ+EWOTx9UffvU=;
        b=Zn0tvZ0gdvnZQ9VEgrkU+0Ae1H8uMGGf1jPsEUJrTEDWcx8VKzR7X99aSbZvdHjs9O
         608g5IGWBeQAvC5EQ0S2gMHrwb4yOCWf3gIKWgXGY4N9Bc3I9bbv/4Lj5MUZRGr8z7Cv
         xk+lKN4m6X9pZZ2U+A+9gHVJhVy1QtIk2bhrcPzWUljCcIEJ4Ref6btYLrFOvTB5/3wV
         yVsRZOTEppmRdpZq1NrHrJiysRtuy93HguxSa+QLqVGJbelT7j2ba0I2pKu5aVs0OBfv
         PwOe0PmZZxsR2a1UBOz5RajnXHbQ8ss/6IrnZINVMr5GawWHSkEjnwo+t99tMVSgh0GD
         QVsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786615457; x=1787220257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tMciaZ/JSlG6Z7DNQJEd4FD/fd9CJYl/s1BR40smNTE=;
        b=NFHTrXRVpZQTifaiiAeRhSGvfW/dP05MC4U1EuRQWVJr10hfFTND65+3+8jb93NkKj
         pyVgNvfrsAHjJCQSlBnv74kIuyAGwTSHOr/dBTUV0FlXohKVfuehKEUbu+Xe3QIPOuZT
         xyYOmMs01ckolTS4zDf1GolYHoz54YaFz1+Jivey5iRPUdra7EMw9Z/AYpSZUXI96EKd
         3/FfoMhZEcw+UBCPoCbiwXXB7S4RQ9x13SiLR20aVLYVohDLsUPCpyg8prA+dVsmLDAw
         h9GzD11ijNfTClaEZMVLRNH9dpACZ2webaPItG2U1BR+OiDQwMwbfXeiDxCLD+bWtAte
         hzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786615457; x=1787220257;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tMciaZ/JSlG6Z7DNQJEd4FD/fd9CJYl/s1BR40smNTE=;
        b=IsWzMURtObIrkTtA9WtLoz/SZ9QEeAhQ5o/lH8fyV/QF/p6DA/UzZUD32K4Uizrks4
         2a5SSrBP5h0V1hKp+CsZQhyLnPGAbzr1jh68WEZXn4F5lFCp1veB2mOQflEoYb7chs/A
         u0D3R1eFGIrgyONXuwHGTl8bJEF52KbjKE25nrkW5TNk9UTaTSwPOCbMugDG6xsML2Tt
         7qjEr2g/X58mmaP/b/XLI2yU5yVCmL9Ua0x0Te46Pvqmegt7lLP/RPVzWLs7+RvmktWw
         nG7Sz/8bOxeh2Fb5mhcgpr7mzJtpeD6t/8pwdFlVsUVrPcyPKyB8L+vQnPYlESiL7JH4
         yptA==
X-Forwarded-Encrypted: i=1; AHgh+RrDeYnDgMAPLQLLW9yR8wFiVX/9B6g2jdsQYqrIwHf5lIgYFBj9xcRpUFBQ7DWXIP09wxBnHwb02dI8GH8U@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf410uHdrym5EEGEEnpqsc4R33IOsRRnDZekzbpOA6BI2YgeLN
	NLmu/H0FWr2oxNb3FZXDvTD2Dws9b7pIkcJC74gc5i5aEHKi2rmJBtVL1SSMzAeifLV3JhP3bwi
	JRSNSCp2WwQQq2jfuX1VP9GwL6CK6Cuo=
X-Gm-Gg: AR+sD10fbvbqVGaXwvVwf3etxQ2ttEVGTexelofTcrXq7o1xTEuvfMr3LmcLIn27CpQ
	XAmC2ZkwglacvXPWd5Imat2cvqRTZcDz5BIPq2jH2P0UWqPuTLSo4/upnstl/6U9R/QpcokcT8V
	EihenOgDZFuL9VUoeZjGbjvaU2J1nekdQMCS9Nqz7+MOStSmfSBkEJIVf1cP4GTzY8hL0BCqlGw
	e7tzsUds/6GN94lW5UsEWEbG5BykuT7Q/KDlNivPFm7JwbVYJqIaIzgPbqLP5ZPcIwHQ8WwidGd
	3uKNIRrQ672GUk2UUy0caTDQoTHnnyE33qnmmj1j+SARProvoar6eJtrdqXjpLtkQYhbPolA8BX
	HBJWBMlyq1VJvbtXRYYma7dj8eiwFCDw42ZIUg8PqZ2/1rpfyD51ArRmhCKKO
X-Received: by 2002:a17:903:19e6:b0:2cb:2b50:d9da with SMTP id
 d9443c01a7336-2d389b61bdemr35547795ad.3.1786615457444; Thu, 13 Aug 2026
 03:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
 <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org> <DKNDF3WD27GM.5VP6RBRXZBUS@garyguo.net>
 <CANiq72=SP_nT7Z6NSH-GT51-8hJ8qLUa07Cs+SarSFTO9Z7vUw@mail.gmail.com>
In-Reply-To: <CANiq72=SP_nT7Z6NSH-GT51-8hJ8qLUa07Cs+SarSFTO9Z7vUw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 12:04:04 +0200
X-Gm-Features: AUfX_mxe0Lg9da-FioFXEgvJltaWUVJqtXi0b-R5y4sq5pbip1KqobICrYsDddk
Message-ID: <CANiq72=Whd+u0cA88++KyeOQQrsBK+NqK-586jNX7L=_Ocixrw@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>, Alvin Sun <alvin.sun@linux.dev>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 11:32=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Ok, done -- Danilo, I took your diff and converted it into a proper
> commit, please double-check you are OK with the Signed-off-by:
>
>   ec6fcf8a175a ("rust: kernel: add `LocalModule` fallback for
> `#[vtable]` `impl`s")

We also need an `allow(dead_code)` until we actually use it
unconditionally: a2595ed13816 instead.

Cheers,
Miguel
