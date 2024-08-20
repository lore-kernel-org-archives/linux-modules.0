Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9111C463F
	for <linux-modules@vger.kernel.org>; Tue, 20 Aug 2024 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724179693; cv=none; b=aTreAETJ5/Gmx3ecSYb9MWQxC77497YxeuHL4dLfl0S+iRetBtamDiu+2uDdFRuYXT2B+ENTML/22kg0nEfZ4HLkFQh2k+LmkGSh9svQZi1Nks2OvCV3clADrT5sEFUsKmxOog73lHfvdeSq+Au7uiyHsBji+9Ch7oLT2H1mCEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724179693; c=relaxed/simple;
	bh=9IntjtaXg9k+kUVEV9axZKmA4rC298YdyXwRG+HAIh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLoacnLKvKM52VQkNn+YBtq0pgmQPNrlrKAl927+ZRDzprauD9uPOHw9fhqJx/LuJB2NJpQQGyDS5g7LE3+0mXIhiBOlHt19Sq59In0CNLCnRK6IFhO0/X5TcoEUJXWYg4wGocPanP6auKyOAq8F2qmhG5yy6u12Cu7oGsvLqNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HA08n9ZI; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HA08n9ZI"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-454b1e08393so63771cf.0
        for <linux-modules@vger.kernel.org>; Tue, 20 Aug 2024 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724179690; x=1724784490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kqyu9H3Z/7xJHVyMUShvAD4YuvpcJRXIyTBe+BDA0AQ=;
        b=HA08n9ZIQJLmCrRV8+Ce1gYw50AGfpOYxhfwP9BbcEhjGr8MXkoEHvQekbQb39cN1l
         CpNpq1aufeU/9WDCyZn8VJtQ6YLSB3ny5c2b/Us/q50dO877oJSjH3Ub4dHcnq7PCMtZ
         vPX3vGcPYzrsgbDNPqcTrtFYhNiNK1xIjV9P7b6WfYGqiuDgmbT0Bwcs25Xh3s2KvMIU
         ppsee8V2rjFSrT6FUWEFvfx1glD/WMJesNP+YDHRBWNlakvr5TEpMLhtjIYbBu2m2gmf
         BP0UQuYe67hxjenYfi2AusZuE0SLIKgBI3c5WyPsk3fzNyfJYksvAl8mETg9x1gtFRls
         RZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724179690; x=1724784490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kqyu9H3Z/7xJHVyMUShvAD4YuvpcJRXIyTBe+BDA0AQ=;
        b=MJmmpOsZ9cFgVjTQXzntMbmaPW5JZm5CAA7U5Z7zPDVVmQ0ihaE41o+APMVWd2RUuP
         35iAMf3ojBSBiPsd0C7KR+4eLaI5dL/hRs0/9JA7e44PYxa5VsiH0ANwSFT4R3CggYSg
         Quz4UJk5PCJsSCy1j+qI+2jBxKHHkSw5gdG/Ba5KRjKLp+nZjL+3BWQTQiHO1nNWvsh3
         aVkc0QCAT1clm3VBllagCV9y5LR4vn4x6/4NiIR6MFgGhpMjbgCBE8LD9WT4DiB9iJ8I
         +NVnrIPyFiaH+U2WeGK9WOxKY1iMw7T0Xj8i1r1uqbqA6gxYjtF5jNBTeSL0SLNoHkad
         6JUw==
X-Forwarded-Encrypted: i=1; AJvYcCVw0v84hi3ZWcXP0czn0yEZq7APSEBXkNKfoFHYFD0IZcg62g63BpXvjLt+9y4mqwEEFBhjdTFXmmGo0vFt@vger.kernel.org
X-Gm-Message-State: AOJu0YzSAfwMObMnzx2Q+8QABhqbUIVscLb5WINVSS4QJBkDhnJ30xIb
	v2aQN4VMFGPnCLKqwKDXJ2MHYY1n/EBwY+8xh6I3ZnLNZ+gG6K45fcECEzRHxzOJsmpnN/J1s0C
	1lLtx0+SPOL9BSVvNzc3laMb5hOnGLXwa72H0
X-Google-Smtp-Source: AGHT+IEaaaVbWTiloHDIiXOmckXCXgvScfO2Sv9V70rY2jP8blHGtm/LE4cy6bWAnQvIHakKwQ31ZmSJ833RTPp+SXA=
X-Received: by 2002:ac8:7dc5:0:b0:447:d97f:9765 with SMTP id
 d75a77b69052e-454e642e2ccmr3218081cf.16.1724179690110; Tue, 20 Aug 2024
 11:48:10 -0700 (PDT)
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
In-Reply-To: <a76f9422-4001-416a-a31b-37ab7dcb17f4@proton.me>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 20 Aug 2024 18:47:31 +0000
Message-ID: <CABCJKudAF0=29js8SDcYY5r6kM7RBveTrZH9RyECNGqkcqy=nw@mail.gmail.com>
Subject: Re: [PATCH v2 16/19] gendwarfksyms: Add support for reserved
 structure fields
To: Benno Lossin <benno.lossin@proton.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 10:17=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On 19.08.24 21:38, Sami Tolvanen wrote:
> >
> > This definitely looks cleaner than unions in Rust, but how would this
> > scheme be visible in DWARF? You might also need to expand the annotatio=
n
> > to allow replacing one reserved field with multiple smaller ones withou=
t
> > using structs.
>
> Hmm that's a good question, I have no idea how DWARF works. The way you
> do it in this patch is just by the name of the field, right?

Correct, it just looks at the name of the union fields.

> If Rust's DWARF output contains exact types names (I just checked this,
> I *think* that this is the case, but I have never used/seen DWARF
> before), we might be able to just create a `KAbiReserved<T, R>` type
> that you search for instead of the attribute. The usage would then be
> like this:
>
>     #[repr(C)]
>     pub struct Struct1 {
>         a: u64,
>         _reserved: KAbiReserved<(), u64>,
>     }
>
> And then when adding a new field, you would do this:
>
>     #[repr(C)]
>     pub struct Struct1 {
>         a: u64,
>         b: KAbiReserved<Struct2, u64>,
>     }
>
>     /* Struct2 as above */
>
> The way `KAbiReserved` is implemented is via a `union` (maybe a bit
> ironic, considering what I said in my other replies, but in this case,
> we would provide a safe abstraction over this `union`, thus avoiding
> exposing users of this type to `unsafe`):
>
>     #[repr(C)]
>     pub union KAbiReserved<T, R> {
>         value: T,
>         _reserved: R,
>     }

I like this approach even better, assuming any remaining issues with
ownership etc. can be sorted out. This would also look identical to
the C version in DWARF if you rename _reserved in the union to
__kabi_reserved. Of course, we can always change gendwarfksyms to
support a different scheme for Rust code if a better solution comes
along later.

Sami
