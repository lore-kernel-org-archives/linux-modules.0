Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E170F329C60
	for <linux-modules@vger.kernel.org>; Fri, 31 Jul 2026 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785479405; cv=pass; b=H2A7Ri2Fu/3ZZpQYiEfY43rWJK91FfqRUdaG98T2iHGXPzPJzJ5MDkO4YlWlX9IYxzRen/8g2IkqC+DHBZU6fTLM/w0favTpVMcstUnP6zKie0FC7I1CZ4QnsosgwxjI+ohO16qretjQnEYfsuW2KyGDIPYtTmvslswPx6zewek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785479405; c=relaxed/simple;
	bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uL8kNlFe/7kANx7N4BNJfUU+si4YsR6d+spJGz+nTaAW6NL6Dl7GJDZi8+vtPjm+OXN5ZM3Z0oDNU9U3u/dBtiOQVzfogSmEAm5K9HYfTsrLy4J3ncyAlnmR1oM0Bt3hRSz3HESk1y1RUTUJhJoMHcAOZ0JRkWMbQsfH2q5WF6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWCaNt6d; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWCaNt6d"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d027b7c8easo1114075ad.3
        for <linux-modules@vger.kernel.org>; Thu, 30 Jul 2026 23:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785479403; cv=none;
        d=google.com; s=arc-20260327;
        b=Cn9ZQT7eYG0VFrGA99dLPBSUHzONJ+bMp1xHlVsfWg/bz+Djncg9usqRuB8CIoDoSO
         /nGiUAcWCWC0mDcLEu4TpME9Gz16k7alqm65oR2+piBC44MEovDKR2E4hpVEMq3jD93l
         EoOtL+UsI0YJccUptWjHcSYbpPjbyF7JOKWG93NkKvxsINpwvzbvNcnVUqF9MEJbnXlu
         CIbqG3dv/1DTVUedZWYVboqYxItXwVWn8QX7aQ4EHCkFOTTrIwZkpDEyCi11bX3EFVI7
         8M/7ua5IYSzRsqoMdp++p/bVQ0/MsK6qKQBQ+HjFveF6AauLpvlLAjwtYqGFZ11/CMmy
         gU1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
        fh=vqjm+GzYH5VH+acrIuRI/r/rwnZNRbzPo2xXxjCgmPg=;
        b=bvVM5pdXne0e9y983Q2aZgytqu0Tm/GRX4gSg2dakxsQ9pnrFXpeu5PQl4MrT4fZkV
         udH/R8oJbpvMgGtB5zmKe/euAvc4aZ+uMjxl8E2FWx5uXbCd6x/W1UmI5+46YK0wVkTc
         jajYDLNS6HnSzj1DB4kak/dlmPBySqXO19938NOwdO20YAWLuoK9cr0e0YcrqPLaHDMm
         eNtoPSjXHPyRsqEsJ3HRpm63BQSLcnQC75UnUrw2QKeFeyHkohcTdnNY6GRjfzj9WEpc
         oey5HBJTMBFy7RS3u88q7/j/Ksm8gqkZ4MWzK43MCRA4ot2/qKuOSeTr3WW4qvbWvZKK
         DasQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785479403; x=1786084203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
        b=NWCaNt6dNgAGARtRG0i87Zg/4MX5m8mmYfHmRZodmPVVojtjaNus2ym6gJYtL1Pd/L
         AOv8wQRegNwG+GTWDMU06KuMRMWo9BXgtNKT0WdD02cXI6YUfx3v6sR0VOs9hagIJ4w4
         vnKyIIdeB+5YOvum8D393ArHcLC4LBT79fBcIgbLi5vihAt4TNMsu4hXeFugfhN4ySHC
         W5nQEtPsoLJ884H3F4mK4Qtrrd1jUgKr9KCr4ehF1xIV8/txfgWipTUtPYDapxLJ/34I
         F6/4LcrSYzE7iSczVrekyvtA/Ww6xZ6wYo3NFEDB9G7amXtbcR2IB4gYc02nSfWbY2eZ
         DKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785479403; x=1786084203;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
        b=HVQcFUBoNZrXaq/kDmmb6ceEih7Ziu9QwohmcMF/0qizk9oMUZLlqHNNoZQMVYaoxM
         fBuzhqEw595Uax37TfLH7c3cRo2NEhFy5VbBcbbuvQmuBdEqwkwQu4WQxZz+6aLyi/nl
         FsCS4FSJlNFI5slWVSlBAXiB2dydh+4psfjYRMJUWZ9iDPAfp2ra0dgdlNWulCIti2FH
         4Opx7Qd/6/XkzKBWFIIg2y0MYQV6rPml5l+xA1NGdu4xvo0RKzNGHe68otPNyXVoXECs
         +pfttMHJtHePlVpfIHd3dbYgfJ/oUyPb+pS1Vcs16fi/ZoDmrPlSMTvzUVDnh5uGZfLM
         GcgA==
X-Forwarded-Encrypted: i=1; AHgh+RqQGr6chNWtnhHGdhq8jiSv32KizpUmVH/MvXtdt7WvFd0C0ELZoLwjEIMRJyNJEfOFO2XFUa6aXi7Teo6m@vger.kernel.org
X-Gm-Message-State: AOJu0YwXeDONtG4KRh80onkqDoLAvDOruowMeqWtdRmRjqNKRoGhKO82
	oU8mbOELY9mt82d77dkL12hj9N+3du5WOx6wXRvnU64QjEKzQQiAZc1b+WJtCiP7Yr7SHcbAqVN
	5cZ8OHI5lfmbGo14SleAWLRfgOLMMhrs=
X-Gm-Gg: AR+sD11ow1Ac0m6FaIFD9mBv+PIehqoESYqxtgDTZPoFxysMhtQj/8mSe/55M2ii72k
	2BqgchVXWSNY+wFWVGguhX9wNLdr7J1941RrHVgWyUsJ0NZdPdTlN4Jszw7Q6/QD3J072QWQsAJ
	qwc3wEMNBhDDBkJcaobYLTx3caXjN6TdCXlQt0DoYUzWJMGUXorH3maFbHyxzYQSUsR8bGKGQdg
	787TNabHwUH/rP/bUDA+lZq70sKp9ASEwftUjbidg/NqusszcfCO/qtsmH01xCyFSzdO+tkVpUG
	Bn6dH/Hmn9FsVArFh14LmOGPu3zGZyz/rBgJtp0Mv3zCK5J/sg60HDqHC8pLUt+SpU1NJAUOiBl
	IpVX+8DhNKZ+RQxvoniIxmEjNcIAKlw+6vd/+/KIKQnu+cCclIjLVxJqxRsDp
X-Received: by 2002:a17:902:ceca:b0:2c4:397:dd7a with SMTP id
 d9443c01a7336-2d046ef0048mr13066585ad.4.1785479403240; Thu, 30 Jul 2026
 23:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev> <a9dde63a-5f2d-494b-95dd-7567879de38d@linux.dev>
In-Reply-To: <a9dde63a-5f2d-494b-95dd-7567879de38d@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 31 Jul 2026 08:29:50 +0200
X-Gm-Features: AUfX_mxTwoRg7YuTGPUdUHKCs3gSMN4l-jXSn1vTLDoexparxESqmVPaSYuvKs8
Message-ID: <CANiq72kkuKsRAF-r+2OyZbjjgvC+jvqMSXR=LgmqTNRaWQZ-nw@mail.gmail.com>
Subject: Re: [PATCH v9 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
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
	Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 10:39=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wr=
ote:
>
> Back in v3, Gary suggested this series go via the rust tree.
> Would you be happy with that, or would you prefer a different
> path? If so, is there anything else needed from my side?

That is fine with me, but let's see what the modules maintainers think...

Luis, Petr, Daniel, Sami: what would you like to do? This touches your
entry, so it would be nice to know what your thoughts are /
Acked-by's.

Thanks!

Cheers,
Miguel
