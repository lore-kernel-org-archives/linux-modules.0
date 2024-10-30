Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640961CF5FD
	for <linux-modules@vger.kernel.org>; Wed, 30 Oct 2024 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322889; cv=none; b=TjHparEbQuhXdjzDRr52IKBkjOJVMFYvQ0NuvGied8og7DOSnZhMfHcNS2asfsS1K+gS1g2Tm5hoX9NsrPLNoazDkJmTtxJsBlswxvF3AYkNWGFbL35CuorIFNPzlDul/ht6IqaOD/iy7VRWjGE5je3aa+43MNBw0xI4wFRyF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322889; c=relaxed/simple;
	bh=o534AfqHtN7RldxfitzK66PsnDX4NhPFj12yRB4Rmbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkQSAHJ731HBkuDtYvauYfUzou/nDZRyNQBX6p8iyaPLABUCGD6uiYrW4wc3YmK5HgSM02NEevdEVeWZ+ILfnpmx8SiHB7gIuzH23oKzhxrKMP2OsDWss2vIdYEWcp/pj+ZGapu/FGntcQvMLYB0/6XErwL+T+VsPQvSIXi5Yog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ry2af5WU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ry2af5WU"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so37305e9.0
        for <linux-modules@vger.kernel.org>; Wed, 30 Oct 2024 14:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730322886; x=1730927686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o534AfqHtN7RldxfitzK66PsnDX4NhPFj12yRB4Rmbs=;
        b=Ry2af5WUv/skSRNxT+7siplCwQWDhKtQfIsMjY9CKz4eMhiDaZX1feC5lYAe1PYbNz
         KNoCsxFUr1uBOAwYpDz8pWMPcz/SQtxG339IHGWDwqYztGZqfo22sfw5XoOMvVZJsl+f
         +twacZr2LJZsSmJBtLqUo4nwKOY8IxT/enb/U243vHrgZuhK6ZdUTMg9FPxNHD8lWP+K
         riMozXWSdTIv1OQR3UtxZU/nF3JvE8oOoKSnTlNpAMZEYs87ED4gijbier9TavT5e2pP
         XCwBYmqUx8tfgOtIIX/fLhhgI2Jfk1fqWyDYH2f32yzgDByNWx9UEjFSvRQbKWTsKg8E
         aABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730322886; x=1730927686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o534AfqHtN7RldxfitzK66PsnDX4NhPFj12yRB4Rmbs=;
        b=Ohe1JfsdLmEZ0zg6zHE7EhGJOzn0L4PerdMxJ6DcWYKyk6rD+bvTAQ94gIICNXdEMA
         sYkt3L+pa2ZXeA6eNr4fne6Gea1LoJ+E9wqD/6M+SJC+AtQgSr/nCFu+Vd2sPhm20pGp
         2bDX0gwB4QFrjMc3/7H2D8ry2owJ1VXharkdKH1H8rmuoqETU4w7Chaudx/z25p306sr
         dEB8nR4uffGoeqzCppBwQzDZ2n8sghrUgL+RHFOcO1NIpexntwS/nc4TMpthrlYQdezH
         8hdwmf16HHGmLVDlwqb8D4/9vnHz0zDdvtQyDhnUlcSlKxwWbASfn5PtnPX677atJ3Z5
         AzZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoPRkS8IdqPVcpb/dcujagVPpR5WbnxDfYLBc3FxUfgntsAaL26V4dm1XQbi+DcklYPhWMxtScOA/OIsUI@vger.kernel.org
X-Gm-Message-State: AOJu0YwU1BCPEWQxxqzzlT+MLR/wr5fT/bvTmurHqN1/nDL+aj/bPWIz
	jfDrqmO+3mbaipy8ZMouIEGE78HeDgpYQHimggJ2fEt3XO1iiBFgHg+gRf9QUuUHXx5UDcOgmeM
	yteDtfZxHznijObxtAKlzYBoEDeClFBtsw36A
X-Gm-Gg: ASbGncut4BLTRU9/DU3FQmfSMGunf3PWTj1x7kq8kkCnTAs2iokX8gkqw4Ur21xY1T9
	oEHuDQb0L3snzzYm4WE7Zr7S8dBVdV0tCTGpTk5IcaQZ1cVAnfNDpxfQV1IyBnA==
X-Google-Smtp-Source: AGHT+IGpbeaz+5KppTzbcYqEE1yAqTgZJWcDUhQHhbTL7VnBBuh5AYIfWrbwLxtiZ4nkFcdHa3790grpJGu5v7MdZew=
X-Received: by 2002:a05:600c:c8c:b0:42c:b0b0:513a with SMTP id
 5b1f17b1804b1-4327bdca213mr1401735e9.2.1730322885602; Wed, 30 Oct 2024
 14:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030170106.1501763-21-samitolvanen@google.com> <CA+icZUWTdgM7HQrnR_NzgZZQE3aXXk+tAqD3srNd1Eyjr5d7EA@mail.gmail.com>
In-Reply-To: <CA+icZUWTdgM7HQrnR_NzgZZQE3aXXk+tAqD3srNd1Eyjr5d7EA@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 30 Oct 2024 14:14:07 -0700
Message-ID: <CABCJKuepGSFcQa0F5iO4aa4V2UbhuKO+tyfhB3_ODaTGs3sM5Q@mail.gmail.com>
Subject: Re: [PATCH v5 00/19] Implement DWARF modversions
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

On Wed, Oct 30, 2024 at 2:00=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
>
> Hi Sami,
>
> perfect timing: Nathan uploaded SLIM LLVM toolchain v19.1.3
>
> KBUILD_GENDWARFKSYMS_STABLE is to be set manually?
> What value is recommended?

The usage is similar to KBUILD_SYMTYPES, you can just set
KBUILD_GENDWARFKSYMS_STABLE=3D1 to use --stable when calculating
versions. However, it's not normally necessary to set this flag at all
when building your own kernel, it's mostly for distributions.

Sami
