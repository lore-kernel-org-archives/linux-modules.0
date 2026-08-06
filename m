Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC145389116
	for <linux-modules@vger.kernel.org>; Thu,  6 Aug 2026 12:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018102; cv=pass; b=axna4qkK++f9n1BSMk98lLM+bgv7CV4+ahZPZux1s2z2dNq+jy3rZ/em4iQXZphyDtdGh2GgTSt6vlPHahiTGDQTjNz9Ka8QDltsJN9N6UvPJB4Xyn6a8HFiIHIJGZWcPhmttYjOSO7RlSDIqR4YT/F5feJam+U+YXcxqKoJVFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018102; c=relaxed/simple;
	bh=mfT65NBSSPQfJvIyS8K+fknKp7dmJ4sKvXuvehWc8eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwBNHUOQiL2WPYFJDUK/vGMje4WvvI/5EsYpl45Bp7x20u/pYI9s5x1Pxav8Syo/VdpxqnyEOt5oECbFSgjSfQkYdT1p4BzrRjQG1PtR7nnF1vDefuVHY4A0J/KgwB55/O5D5XSrIytGDeqcw7e3P8AqIngGqPFjdCBTc8lXCh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qnWevrip; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnWevrip"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c8612812170so163247a12.2
        for <linux-modules@vger.kernel.org>; Thu, 06 Aug 2026 05:08:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786018100; cv=none;
        d=google.com; s=arc-20260327;
        b=LHa9M21VrDo3VQcy39UkxRnoAD0ef297uv4HnWSJ+/zPQjDhLmpnqL5DfBdEGkfI6m
         bkqfzpmhcH5KXq2Ljst8bIjhTdjgd4Pa7blddBv65awjeoZyEF0vJlLQWWah6aYq8dAr
         Cqarsuga38/qD6JspMHclhAiOna5fwKzUXwRsTSNgMhRKwTnbc3JIYP+5GR0c2JAI99S
         68+lVz1PlvJ6yq8GmowfTJegDYmaOwRU8H25HDZcANxj4bElrCx6Wa009chavRTLP4FW
         9S1/gdQIfevvMyfKVChitY69NlMGQrK85VjocXfor8ssSAwrxrRB/pgYTsX4MuPNgETf
         1FUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mfT65NBSSPQfJvIyS8K+fknKp7dmJ4sKvXuvehWc8eM=;
        fh=drSEWF+hwA1gH/aP6gfzVaMUI5CajqSyD+wD8MVoku0=;
        b=Cus+/eCBABq9TbLXRzI99mQH6rdFsE+87tOQcmLfKUk5KT4gd9drMwfSHbi581AVHD
         VU4oi7LErBVnbb6OXyY26ZqaWymvoj5AsCZG8O6+jZ129842bqV3pEebfQZ56UkbTI1Q
         SahsSnFvqme3Ay/0CgHf0+dH4pireQS2TuLBtv6AAurZ9fzNuy3K6y5hZm9MQm1Gnbpy
         m+Jo9VKJHz+3fN4Zd3Jp2Qf0CMt/igp6b8JVUp8F/g1Ws9FYXKr+3HqtCaFEf+2BzLDs
         zq7jWrRlysMRm935fT0xhDm8ZjA6qfu2qDRlZt9hyxHYVG2/A1s1VKQcdf7ZyKXY/ok/
         DXaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786018100; x=1786622900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mfT65NBSSPQfJvIyS8K+fknKp7dmJ4sKvXuvehWc8eM=;
        b=qnWevripUomW6iqrBcgRQrFWmYJCjlIHwEeYHR306eWTM6V5JaquXZnEtCdrq6mEWs
         oDE/1ymqH6GdFsSsa3B3GJymUTJRQ6A1slbEj9YV5bCYf05kAM1G0JKSCsoFk3HMmO4/
         8YpNF2j9nvyvNBGdfUN5zcZ0XSIUcjk8ubdZ7DhpPRQJwf2cf1eS5K8yZ+tZGzJpTpWd
         45Xk5zVL+blm2pD4g+UJe0BzTisZwCaMFOwCndGJ4K1KWzZmrVp2xIqPHnRZmGmSwTcN
         BwtJxqIQFjICYF5s+EVhhBQLVJrVMhn831VwEmlQRYy1HvuHYRx358eXuVD0ocP3XNYg
         Yd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786018100; x=1786622900;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mfT65NBSSPQfJvIyS8K+fknKp7dmJ4sKvXuvehWc8eM=;
        b=mo3dIe52oaoQPFnO57Bw0pEpC8kYwMp6M3AnZne3P2lVcYrMUrRkG4cHSogypaB2rN
         oteyXEseCCmtaDuoTEvJjb8VLhXI0zvOAX5hHWJbtazlsiwq5WWbNFckQ9Oq6mCnp5sI
         MeruU4jGhdYw/uTnPaqoDDMReUvU9JoZPCSIS3gn5NPj+8m19v53x04ZW5FTWkPOplLA
         VPcR9cZV1x/oMISfV4lIu77UtKeOtfnTwPi43VxMgC7ZjdcXymW1ZkzwVCr2yboa1Kgq
         wFtNOrTQW3alDwvfuraDLd16606mtykgqFDvXL8svTpKq5LJJMzLrVM8jUCl8oEcC8Na
         VfnA==
X-Forwarded-Encrypted: i=1; AHgh+RrFJd7R09zoDSGnfTNjbphHJXDGSxzRxmlHbXsdSVpcONwdXs84pXp/WxVU8o1OdxgWubaQGCdHAL66eqWd@vger.kernel.org
X-Gm-Message-State: AOJu0YzLXNG2mutlYm7slZZUdHBkpV3FDYlD41Cwg2j2mHf+YioU66fb
	KP11nYjy7YfHMqLRzfYvRWAyKvkLk9Vq4PdZ/t2RHoLKOZStCdG7eyCSJVoiBUFJE5+qG577iCs
	cZecVhU84CNshAn5PaNsblGX4K0mkdLc=
X-Gm-Gg: AR+sD103K8d7mW2OG+ET+CFw3+bKECFMXGx/QG1Dw0cLHeR5ccacBmo59ohEzEUwt+r
	FWi25btS+nM1IPx2jav5iYnu2X9FvuOmYL+odcNciu0fWIHNKMZoBZYwBfeoCAZadLQE3mQnjcU
	Ab43Eo4c7vRnhwasULGBi5Mt64TC3IvwS/rigCMzOHFOzO8S7zijK1lKhapEd25CXCvMQDigIDi
	IT+yPmfkYXGnS9LA481X7jDntMw7B3iCiH9V+jpQTZDKlLvnkz6gOeJ49glWQd6A5Hyz3oi6eux
	Jumtbvdqs48EQmvwuN1YJhSdkJQIhIHdR2eDTuYaC8XZ7cuxEYVYAc+rYLNa1G2kvbWkbGVZIqE
	KeU+48HvopJ4PPv8SFokrVddNz8bxj2rey0AhdKJA2nuWIZyuANrzlqrxUWni
X-Received: by 2002:a17:903:ac4:b0:2cf:7dfa:7f56 with SMTP id
 d9443c01a7336-2d0ca95fa2fmr116010195ad.2.1786018100132; Thu, 06 Aug 2026
 05:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-module-optional-trailing-comma-v1-1-d04811335e59@gmail.com>
 <DKHUA0DRQXYP.1WH8F0FP7N39L@garyguo.net>
In-Reply-To: <DKHUA0DRQXYP.1WH8F0FP7N39L@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Aug 2026 14:08:07 +0200
X-Gm-Features: AUfX_myd1MOtjQgfdbpPuaQwusBgM57O9hU_bVw4mzV-Q0VFOM_ZQ2Q-c2yWXL8
Message-ID: <CANiq72kXkY_CtxxedtpV1DykxGZ-SDwAYzAo6d_iDaVs7DthtA@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: Allow omitting trailing commas in module!
To: Gary Guo <gary@garyguo.net>
Cc: Ethan Plant <plant.ethan@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 1:54=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Hmm, I am not sure if we really want this.
>
> `module!` invocation usually spans multiple lines so the formatting rules=
 would
> always prefer adding trailing comma for this case.
>
> Allowing omitting sounds like encouraging bad practice.

Yeah, it also means inconsistency can be introduced for little gain.

Cheers,
Miguel
