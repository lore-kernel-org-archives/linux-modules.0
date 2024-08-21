Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2F31494AD
	for <linux-modules@vger.kernel.org>; Wed, 21 Aug 2024 23:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724281307; cv=none; b=Rcik2Cib2Jt7/7p2/t4u/fHWHLqaLfbrKP2GLBK1y5cxusQ9MZYnYT3cFaOqGnQ0jCLi9fC8MPNOzYiyBJKcqVWOKa7OZ6XlL+DL/cu1TGEWDXJcD0u88Wc9NeHijJVM9ImeVrsHGp611bHfa/zj8MY8uVMCgD2OfJ4frjsVXxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724281307; c=relaxed/simple;
	bh=aWbQKsoO/3O0Lnp0a6MfXVSMRVMVZaRxC4kpSF7nsAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElBnFA+Mv1403bvdKi+J+4SzSCvVC0RWTCqimI14boAyA5y3BWiHcMMnNaArSTIN+vEYTcD40u5cyDOjt+t6+IAAckh3+ffIRm/DVj8zA4/KA8yPzSzLZ61NCxgFhPLr1teIuRSZ0wzk2gw0s54+IZcxhhJQ5uUP3XsXzCFVysg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=llX0/Ebs; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llX0/Ebs"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-454b1e08393so136031cf.0
        for <linux-modules@vger.kernel.org>; Wed, 21 Aug 2024 16:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724281305; x=1724886105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYqlc+O3M1PAGsmUtdwrYwO0p9/AGmcfM5YGYrhFe/U=;
        b=llX0/EbsQWgvdxkuMG03M4wna6v5q5zCeCqz7SqNw5lp/bqWGLMeWiFQS5I+AOppAz
         yRD1BXQvCMXbl1fexId6GidUm3kwklzprBlBeOMxUMhUUvqIXyK8gqZpafLYPEQzFgo5
         8pHYYgSB0MHgHKyTgKzZAZ94AHAceSyIrrnRVNBuPhWr5wiiwqP1AwBTM/9dnHufGi/D
         5oCqwQvSSzDpp0jyYBiPoZyDSJM2RhN6RoOzm8Oe65yz7leKjEdvwSxP38R4U8+bGzZq
         PtdkEFAW5GDSbWEJLcSX2gLaKPxFw0i+grH1YWORFdvw2Ma3lXOqUVckvan5dJzDiSSf
         c8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724281305; x=1724886105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYqlc+O3M1PAGsmUtdwrYwO0p9/AGmcfM5YGYrhFe/U=;
        b=Afp6TdFceubIWaZE3Zky4JyJr+Nec7FUlSOjmK3biEll16ottmbgo3EF1YqpFatOom
         LBbKVo+GuR/+FpKOoT69gZ8TrS6bp5cGFLbFITSNDxXGvKCWbr/a1/7TCQYNWyrYHDab
         RREd8BdeEqq0JzBp0QvwCSY4n6D7OhdoKJ92T0c558h5ArrxE7/9qEWUt6yHquBHqNFU
         JTaLt/0kku3dFYLQQ69vYj/GsGv/k4pjF6zNuzjyRhTZgJPIw+EZcdcmBARUb2x2mVBN
         ooBUOj+1Da5/ytmw40eYoG8ePhP20J2Ndm3cYTyV6Yt/EeFn2Gq+9Qkofa+D1KH70GHy
         PwqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+EDNtivEkVJC1xZ3fE/goBgv93LRW3x90+afVzLEg8HzFOX6hGo31gtSvD9v/Ld0WWZaynqvOiHO9psQn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7juEt2f6l/GAq2iisbjvy5IL8vlF5c+/wGs4CB+KiDx55J1fz
	YZvjwPq6mtD7P81+HDerqzZyN+uI8mDHyLvxLm3yfkZDhqOwy9N8qJp86LVdcg1yxWOTM/SJofo
	oB7KD3N4tSWuh7o+5h0ITJ1bJ2xTZQc+WJdOI
X-Google-Smtp-Source: AGHT+IHr6GY8qz9jDAmwr42+hMsnH5B+DA3xc3h3v+2emTPxckOukoEGDbPDha957SRPhSwjOBNcOQFJ2vjqfFpTJfg=
X-Received: by 2002:ac8:5708:0:b0:450:47a5:2203 with SMTP id
 d75a77b69052e-454fd778a28mr587521cf.11.1724281304543; Wed, 21 Aug 2024
 16:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-37-samitolvanen@google.com> <2024081600-grub-deskwork-4bae@gregkh>
 <CABCJKuedc3aCO2Or+_YBSzK_zp9zB8nFwjr-tK95EBM3La1AmA@mail.gmail.com>
 <2024081705-overarch-deceptive-6689@gregkh> <ef6f7294-0afe-46af-8714-ed4a4aaee558@proton.me>
 <20240819193851.GA4809@google.com> <a76f9422-4001-416a-a31b-37ab7dcb17f4@proton.me>
 <CABCJKudAF0=29js8SDcYY5r6kM7RBveTrZH9RyECNGqkcqy=nw@mail.gmail.com>
 <CAGSQo01kCUd64nB7C7Ssy1N=UBpOP3bORsRDcHJ1k2CqkbKsfQ@mail.gmail.com> <c6c1e84a-40f3-41a5-a732-f1cf06521691@proton.me>
In-Reply-To: <c6c1e84a-40f3-41a5-a732-f1cf06521691@proton.me>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 21 Aug 2024 16:01:08 -0700
Message-ID: <CABCJKudN7vGB1gfGDuEArdkH9DL4iPFw3DXMPrX1ZLzPRp8+3w@mail.gmail.com>
Subject: Re: [PATCH v2 16/19] gendwarfksyms: Add support for reserved
 structure fields
To: Benno Lossin <benno.lossin@proton.me>
Cc: Matthew Maurer <mmaurer@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 4:31=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 20.08.24 22:03, Matthew Maurer wrote:
> >>> The way `KAbiReserved` is implemented is via a `union` (maybe a bit
> >>> ironic, considering what I said in my other replies, but in this case=
,
> >>> we would provide a safe abstraction over this `union`, thus avoiding
> >>> exposing users of this type to `unsafe`):
> >>>
> >>>     #[repr(C)]
> >>>     pub union KAbiReserved<T, R> {
> >>>         value: T,
> >>>         _reserved: R,
> >>>     }
> >>
> >> I like this approach even better, assuming any remaining issues with
> >> ownership etc. can be sorted out. This would also look identical to
> >> the C version in DWARF if you rename _reserved in the union to
> >> __kabi_reserved. Of course, we can always change gendwarfksyms to
> >> support a different scheme for Rust code if a better solution comes
> >> along later.
>
> Yeah sure, that should also then work directly with this patch, right?

Yes, this would work without changes.

Sami
