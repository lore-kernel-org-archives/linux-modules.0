Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06033F0AA7
	for <linux-modules@vger.kernel.org>; Thu, 13 Aug 2026 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613785; cv=pass; b=nlo5EP4nLQB/F1ol0E7PdCJleC6fi1bGfGMSoNd0cByDd4sh7Ih1Tv/GK+htfkvQyS4RtFzfZOahsvNVCGK0ovBh8UtCxFvda3JIPmPL9H3Ps9WbI3zG4eN0XS+oLCXJbenpj4OULiKI/Xe+nlq0MxSMPjHXRgAIlz5QyTp8Y1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613785; c=relaxed/simple;
	bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFDkdcO0FI+TFruvzGgt4gQ4XrCDRRJoHU2m/pL8uX9MGQJltImoW57VyObCXQVZAQNZcBaPWIjxvdrd/3ZO4KSNjp1WgLpyWy2Olo1FEutaZWKxSVHAgQRzFj25ySyFUTLDj2Qn96ay//rgVxA1/cP4+yHdxBcNlurk9SMjBkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLY20tq3; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLY20tq3"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d319b84213so4105865ad.1
        for <linux-modules@vger.kernel.org>; Thu, 13 Aug 2026 02:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786613775; cv=none;
        d=google.com; s=arc-20260327;
        b=fQuBgPreTUDjR3DXsPuS32rbFjnBlIEhpRq17EeeYfLEt/H5k0lezsB7x28xNntC9b
         jJwcS5zqYYjelXMxlIFyXRA+otSoJx49TnLDc3N+p891POK0s3YpVp7dEKV5D+UthAbF
         2QODCsrBQMP/pML86uneMUNfB/yPRQyNa/b0tlIs6K0QoHy35gsPgNvdzMl0blg7gr+A
         Vu2E7IqtPaYHa99iKCkLvEdcPXSwGCjix2KgBAbJeps7gZ3v+s0NVSfkrAZNKkJnQmpK
         08rYNU+4tFHlnBu/f0t0hLWJhT/8BIi5x/GVGAGT3XwzEcqmbZet5J9aGEowH2y118C4
         RKFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
        fh=Ig2B55toqJlxHGzqEbjL4tAGYnZlCIDMDFjftVsjUfM=;
        b=feUrHfJsUmXirgdBV4bj0C3rGM0HG7ML/ohSb7HTR3nquNr7tLbV7tDb2vcVPMy91d
         CBK2LKePLslO27g2Aeect0X2rLBeF/8RaeRbLFR/2LN2ONrs/O+AAjpIKZjocLEB0F9S
         ePS2Y7XTaZg36anlVtnumPJCaGvjqGCS84YewjxyiZIboe+Q1w/YL0IxAh7nOwUeE/Lx
         N+ro3mEyZKpMBgdOTwfSLeajUIOfqTRXmh/jbbltBdOjX3T42LMJirZIZfAnnSYBHcgP
         x8ndFYnB7XtjjiQdGHQoeSVpBrdwooJDvxMpw84FUYhIc+zRdDdVgteI1B/OHkM0y3K4
         WWUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786613775; x=1787218575; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
        b=hLY20tq3DTzgOPpU2TWFvqupEvw6BZf9j3keoSE+Gba2EpwLBOoPs3SQcPLdhbHOQd
         av4LzjQ9lYk8iOzG7fbP90+/67JTKwJKjagYjTnyBsp7LINLmDMXAMkvWpmAAwVUvpVB
         WOEJ5hPHiPAW5JflzYC087QtbgUj9OaqQKBUyQviZTqRro+AWpjLp6W2TORQUC3zlftH
         x00J3FqT8MvEhq5XipmwYmYthJ2Z4yrlDkTn3YRtrL9UiuQjU016jZXv5tQqSGMfeB1W
         CUN6JmXZU6P23klRsBB+8cEq/q+V2fmSeWpK4LPNLpfnOwggw5yl0cHmhsqlOKZT9DAk
         1v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613775; x=1787218575;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
        b=i+aP6CwdB0jDsQor42C6nBSjXXTY0XHGEe6jRSElv6/o/YsW3CJCiL5qdFShrHmKDN
         g5qkJhkHF9f7Vl+/e17WC2Mt3lC8FGZ1oFf66bHpUZw9e6/n7mVJM9z1s8qXwwRuv0ua
         Bcu7vnAzYBtkJRuIIMgMdZM9J14IgPfa36o6kbAfuaSmdgI5PICBGC4FX4Gd8DPhOEvi
         N6QyeV3Mkqo1obLXl/qNERP2PCpt1vM7igGcNH2sT+fDEWrEO8onldDIEpFRWB5pXdgZ
         auW6qxBMBcz93k40GEKMRsvwtDamHkcjkTQg8Q8oKqKQZfSebuZH1FL8RvYvcXzWvvjc
         XhQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr1wl4fUxEB6i7iX7yqRiHhjKp29SNgwkIgsbDbXVK4C9FoE+oT7/Za9Zs5J6FxzD5kG/wrOpH4cBmlbRMb@vger.kernel.org
X-Gm-Message-State: AOJu0YxgCzdZybpndkIAYuBJnhFD6VFpRf5K+FfA4UccLDVXb+iLUNpX
	uYEKSVqvbKKtxm0gOqT9xFU2RT66W5PDo4fIGwAwNtZPQiD6HU6V79BZYCS1KfCE+kynITjFyfv
	CrF/FXaQleM67q13jYuxQpmoqWxQ3Qxs=
X-Gm-Gg: AR+sD126XxPT9A4+NtM4RjCGI20AdYR6AS3TsH0kp9MhOyjWn2RySMSohHRQ8aLctDr
	8+8fnIcrJdwu1nAsYaDhxPojCR/q12zGrqXdsSjF57NV3S9nT2d9t1hzSO59hbdBHwhssVNyVuS
	7kbTsnzJoHwoDaQnmO/TWfvj9e8zKKePf7MJino9pdZYivQhBVQR5FZ36KsRAHd3sC1vFZ/rRwt
	XV1qpUgJ9KzaJqMqBsO1vIsBT1F2oS7lD/uS8Vpig2TIan4v5TT7kkMoLiOz1cgo25lgPGkG/Fc
	C0mjr4LfIeiY5JZPSrB1cHWyo148Ch/FAZgGcPlq/qVWhdFgXAhqK6yO0Qauvo0z1NJmdGAd1eN
	bsJv/UeQyDhq+/dOfG+7pFY/NzbuVJxW9efHdzkV/oD9JJ8YXHJE58xpk8gv0TRuAklr8QcA=
X-Received: by 2002:a17:902:ea0b:b0:2c9:fbde:ab68 with SMTP id
 d9443c01a7336-2d389b9107fmr28401875ad.3.1786613775343; Thu, 13 Aug 2026
 02:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com> <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org>
In-Reply-To: <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 11:36:01 +0200
X-Gm-Features: AUfX_mydrO4nx0TADc_1KF-ELy8K1d4zi4yvOYINpS4bHvyjdnsvoZ1CepMueE4
Message-ID: <CANiq72nR3K9d0Y--FyUm1yAkww2LaAuYQZ3yHXjYxxfztgMMYw@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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

On Wed, Aug 12, 2026 at 11:53=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> This series has a semantic conflict with both the driver-core and the drm=
-rust
> tree:
>
> @Mark: When you merge driver-core-next after rust-next (which I think is =
the
> case) then you need to include the diff in [1] into the merge.

Mark: in case it helps to make it clearer and so you don't have to
read much, that [1] diff still needs to be included (i.e. the rest of
the discussion and the commit I added is independent).

Thanks!

Cheers,
Miguel
