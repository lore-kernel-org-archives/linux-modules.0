Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4D043933E
	for <linux-modules@vger.kernel.org>; Thu,  9 Jul 2026 01:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783562189; cv=pass; b=uiRdYQFjg/jgTkxh1P4OI88EcVrjoQzbu3IJLdX5A312jGULeO6J/iCmLkxbizg5IKrjKcdzoLWHvt3ewqK+QyrlzihtElm9u86t/fMm+Cv5lL4SBK+OXui2PzWU56IyIzXXICPwvHzYLXdtHtSXX1bGeJy7TI1FwaICvoUZMPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783562189; c=relaxed/simple;
	bh=YdrxfBRVMx2S7wqSMtA3Ne7fpQWQzgbolKRPlOvBYiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTBIplsUam+12XoTbEPQIMVBsr6LVS4cSIe8hBF0Y9MfH9EIflyDmmgWFtpZ2A3yXGYUjJGnZaQHywf3su8ytiD7+jCP+oRH5sxRvCdvB4mceahHat8Yd8kX/M0i6mInCycXAtAmsxtiQXd1mrpqQnND+TX89ZQ0T6relErT/3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AxTtUD/n; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AxTtUD/n"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c10e86e52so80431cf.1
        for <linux-modules@vger.kernel.org>; Wed, 08 Jul 2026 18:56:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783562186; cv=none;
        d=google.com; s=arc-20260327;
        b=TWaOtuhWvHfzZP9LMBOLONtcnjBz+rvx8z2F8CcB7POChWJUp1YZrDPhs7STUXzI7m
         qeZ1bhsuWVx+6MazRzBCTpfWyMV5Wob+JidsXGxD9SajGUAhH+cyUiMN3DUPHKtr3iif
         Qxzgc4xB9+N7MIEMX8tfsVTHTyhXI0vjmBdRg1Rp1iOIazNaAEc5ye7fZqp+CbfHJKmB
         u2Rzl8DFaZNvMXAmeF2ohPdxKhLBMcmBBto8sfrtsJSTv216FrEbmOY5r6lU+983QT4E
         N2SgPxnFYG8xo8STl2J4Bv3cew8AH5pTZhQ+i7iHOkaqGYf1pViJdKq1Mm+f/m+kJFJm
         ngSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YdrxfBRVMx2S7wqSMtA3Ne7fpQWQzgbolKRPlOvBYiU=;
        fh=sB7tPIi9CzT/lzACbyg3acMX2iWfaLythQWVP4/hOY8=;
        b=GbweSoc4MnR1VHoJ0U5Sgcxvg1BVHSPAIGbkkuBh/OYi2TxwJrMURthsp3s/pthHyG
         YQ7DIGR7Bt8c6Lrn28XskNpGDMnPsvfY1ZDmwZSGxeQz+XN/Kd80Tu1D/Fe0JI3x2NUh
         Z8Wu5eTrJvxXFl3xKCIU12CePGeQae1BHaCMyaFeC7O24CnkfJqcS2nXnrkwsDTr0JiL
         2t7/gRWlHK5xQ4qcn0vJwjCGlTzlew6+mfR8GIZyuBxsLAsx5kR30LH0Q8oD39Jth9yn
         A4D0iZNgBRfk7r+/y4q5jv9f3GPUG0Ky0xBsRbdReMIDKAYchLBuZEnHQVB2tq1n+kZb
         XIyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783562186; x=1784166986; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YdrxfBRVMx2S7wqSMtA3Ne7fpQWQzgbolKRPlOvBYiU=;
        b=AxTtUD/noe0HxJLoW4psllJkyQ8g6N60TrtbzKt0PdoQu3iZCv0NTe3suekhpM9AXW
         gzX+RrEfJ74VDXxmVIRbowRLRd2B2gSmMr5flfmzV0sbXFLZ7Tz4OiJrhzdDvpRYtt3P
         lKuEhpJUaXDsdfqUu+k2r6zWkUM/QDQdQkUqV9Hk3WlL4lQJi2ztPCyuoMGBL0mPmJey
         WsCxsuzfdP6dMMxQ3csJmAVrhmdhFCXM8dVcYq2hC+jQiQ1ubaZIBjHW/Pq2emTQ8/bI
         rWzvzwkm6nrlIIO+04RGvFiTlPqmHjV0mn6nK9XlbUr7TeSPdcMCM8fQ9B02t/pzkVDo
         M2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783562186; x=1784166986;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YdrxfBRVMx2S7wqSMtA3Ne7fpQWQzgbolKRPlOvBYiU=;
        b=ZEuYSlKzfs2zWXPepvheQkUYuvD2X3V7d7AP1C/0okIZ6c8+8+/slXMuKMr4X3Jl9M
         vLdA1XGyB5a4NbRnXWM5HcWTcslmV6wQFpbXO/g1fxsjWdsSHpw+FSq+FYRllz2SwXeL
         sJd3XRCtcMjkZ5CraRwvaXSGFU8GReP35y4uzfUnF9AcnX8SJmOzjaeQzqHZ9C79Wspc
         a0D51r9px8cWdHUW+4UKVq6cHiVgXt7dpcaC9+zTv5A8Xr1vWMpOGP4KAXAETS40fx6/
         4nUuDRA4lK4gRxOB2YoFFkjR1gwGGXmGgG/RuTi2ZGtJT51BzmGFfwd2cMfCiuewfu/W
         AQdw==
X-Forwarded-Encrypted: i=1; AHgh+Rox1HIOjy2JqeXCRQRCi8XKj1o+9jGROuBid7NBppKPb3m2M+hh8NUjaNnwLYfNiHB3IQWv6FRYJl4R5cja@vger.kernel.org
X-Gm-Message-State: AOJu0YzfL2EVVwz7ciSftXvSoxfzT+bCuGc7/kBVUjh4fK4GGlA64FaN
	uxfz7tJ2UyFhJfTEXkYzLZtWU7+Ai8g0K050MdbNmkEzPgeO0NWIQZaErWs3cOhKyOQIecflTg3
	DyBz91WbSvtAnorgWrsDy1YH7Hqex77PWtVHzoWtH
X-Gm-Gg: AfdE7clZcv6Nb7zXraP+czkIHvbiG+qHDlfc+R/aj1xa297I7jhQ1aqFyRCjDmv7fZi
	pHPPSel7NBbdSWy4GGKIkC5zo6eH7p3GfuP2kICAZNNxYIHI3Dj+GCTGTioa/Ay9bxA91WTFkbe
	aNA3vhTFOy6uoWJBB4Nr2XrR7ba7Q50W4eNBpZAyp/xB8vCjwC7pCzMrNFZXe1O6tzPKaKaB2SL
	45FqfQizxo9UigX7LAM1ly14WB5ytYgv5yTyrzXQ4s94+uPwe0yZFYOMPuImFwxoGdOOOXPCfSP
	n5hftdkOe/R24+wMyIC+8Wi46oQ0/3oM6kbPPFc2hXLZrb+zR8xdv9Ox
X-Received: by 2002:a05:622a:c13:b0:51c:97f:83a6 with SMTP id
 d75a77b69052e-51c9c622acdmr1638411cf.17.1783562186165; Wed, 08 Jul 2026
 18:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708012107.1621513-1-tweek@google.com> <33fba1b5-d107-46cd-896f-bd2539a4a0b6@suse.com>
In-Reply-To: <33fba1b5-d107-46cd-896f-bd2539a4a0b6@suse.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Thu, 9 Jul 2026 11:56:08 +1000
X-Gm-Features: AVVi8Cfj32BRp1NgEd23wzicSKCQBg78yZ1hlfisRbrL5qNY5kannCSsPI0Dhps
Message-ID: <CA+zpnLfpNPoVt8ZrN8AcjNhyYHfB3G-VbykVUNZLjQhsqiP=8g@mail.gmail.com>
Subject: Re: [PATCH] module: validate string table section types
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Siddharth Nayyar <sidnayyar@google.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 1:40=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wro=
te:
>
> On 7/8/26 3:21 AM, Thi=C3=A9baud Weksteen wrote:
> > In elf_validity_cache_sechdrs, section sizes and offsets are validated,
> > unless the section type is SHT_NULL or SHT_NOBITS.
> >
> > Later, elf_validity_cache_secstrings and elf_validity_cache_index_str
> > access the section name table (.shstrtab) and symbol string table
> > (.strtab) headers without first ensuring that their types are
> > SHT_STRTAB. If a section type is SHT_NULL or SHT_NOBITS, sh_offset has
> > not been validated and may reference out-of-bounds memory when
> > dereferenced in elf_validity_cache_secstrings or
> > elf_validity_cache_strtab.
> >
> > Validate that both string section headers are of type SHT_STRTAB before
> > caching them.
>
> The module loader should normally at least get through the signature and
> blacklist checks without crashing due to a corrupted module ELF file.
> Failing to validate the offset+size of .shstrtab means the module loader
> could crash before the blacklist check, so I believe it is useful to add
> this validation.
>
> How did you run into this issue? Was it observed in practice with the
> GNU or LLVM toolchain, or with some manually crafted module?

Thanks for the review Petr. I found the issue while reading the code.
I am working on a separate commit that reuses some of the ELF parsing
logic (in a different subsystem, with simpler assertions). I was able
to confirm with a basic PoC (reusing a valid .ko and replacing the
type and offset of .shstrtab).
