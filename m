Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF2C13C9B8
	for <linux-modules@vger.kernel.org>; Thu, 31 Oct 2024 05:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730351189; cv=none; b=DOzlzVDukcc05M8Qrn7EDe6SYCh6Np/ZWATbRPLjEMclEr8I9eoNSjMKioZVS0lM2SiBFHxjB/YhIVpKJ67aUTGG7fT7U+ihg4Z/SXdUwqMqMMb4yjNLK9Z2UmHUq1nRwZgROcoXysWlBURl6mDyCUh4dt/3uX3eET1vmxFoIZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730351189; c=relaxed/simple;
	bh=CFQpG6SQWKfCkcBSL/I30J6EEER7ES3CKQCiV1mDbS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4+lpCgJgpG3JwJ2EPvCKAW1o+8uRmnIZDXCcClA8DNJgPCKWs5eXetCe5PWpsPl72ie6/7AFFcRiHS0gkC1GR3pqCX+hhN+3m+i/k/gsokqOXU/s3a6MSsMwTsV9s0/M2N+zAkEzogTSKAQArX/bSWph/3qn/pcnp9uKQVD1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3fYsPVyL; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3fYsPVyL"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so325a12.0
        for <linux-modules@vger.kernel.org>; Wed, 30 Oct 2024 22:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730351185; x=1730955985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0i2Hp+Jo553Bp7SVYgd1y/RHX4+QcCFvIVpGPREXUzM=;
        b=3fYsPVyLoT2T4oTbcm9S/y5jCqTwGNzpZJdqL7Xb+ZesNgKoMlz1QiALWKXuOd+X7r
         pTVtADZanbzDZFhbwcUIS6cvjKXM5NpYnmyp45ePviv9o3q0PFWCKgxLzGeMtcIo9DPk
         hZLWYkNFAHy0DRiug3CblKiGd7/12zZ7cmvQu3PsBVQ0ZMD/9cyiMRyXmwAamjSzUbOF
         yfUbqoaa/ZJ7HctqTzTQZKeZIwBSkDroxZiEbF0ZJnKCEAdQV3J6i4nwsRzDz031BkEo
         HOKXuPe35qUd7eEJifY8ZGHYVK/BTyPKHpk6OjKf8+9/FmhiTf3Icqknwfcb1U0Ly0Kp
         9sfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730351185; x=1730955985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0i2Hp+Jo553Bp7SVYgd1y/RHX4+QcCFvIVpGPREXUzM=;
        b=XU3kABbSoOKP1g6DOManOcZ+8R/+DKKlRyOIc4d1EHqzGOd5NIZaiOW9ydhyb9XQxT
         8v8oCmKXqdrlXnDZJTwK8xu+yiEjOtBzmkCD5q6Ot21Pny66BNPEKo/MII8YU5W4h40v
         vCxAU3Wafz4WE0ixe8LfuAzG/kkjgHzaw2m5EqXuOOKVVgOG6uawumCv4T8TL3EgijHI
         58ucX9lvIGN4FxpsurYVQA+MSDigIcGZKDv/K23qtgxFO9pfoMTnbIJMYI642yr2pDMP
         aRvpkx2aywqT+haGJ/1py7URcX4zYc0no5sg/m5llV8rSCt8ZXCTe+uyVaWGq/j/9sZl
         SBHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbn7BCzId01Jj8eBEO+o91S7P6QLx5qv/nBJSu9qqDtBQ3NOVuphLAXpE2Bwr/OU89x+N4RSZ9yQ361qmF@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn2jYCS8QYadCxHFu/BFJFrz+NDOpEGDkhGMKaJFzE4LcuiUW3
	kNHYMFaGf2b9dEWZKbadJAZql7w4Dp3rTPhMdZAYY0ontbcPK+f7Uq+8D4LF3jDryuozOCXlYV9
	RG0DBD8IqZ8YT7wtUSUFSfuBnwvoldXuKVq0b
X-Gm-Gg: ASbGncufceY+B9aaKgAYo9gHT7kkaC9RMlFbag0V2WtY2kNG9ryt4z+ZQUs6CQE/pBc
	PkcCSrCrTOiPzqZzRL4hpxEtSGU6odVwBZiNt3K7jAfd8vZJlNUHo+lttaLEGXpIO
X-Google-Smtp-Source: AGHT+IEa2MH5wcVvPPE8kavAhbMUGA/AKUSL18Rtzs97BVFow1m5e63bvnyqTFocsSVTt92eT3Zz91fTBE0w+m9p+IY=
X-Received: by 2002:aa7:d6c7:0:b0:5c4:2e9f:4cfc with SMTP id
 4fb4d7f45d1cf-5ceaa4c1727mr5520a12.6.1730351185225; Wed, 30 Oct 2024 22:06:25
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-extended-modversions-v8-0-93acdef62ce8@google.com>
 <20241030-extended-modversions-v8-1-93acdef62ce8@google.com>
 <874j4tcbhf.fsf@mpe.ellerman.id.au> <ZyMJaFcF4dTTzNgK@bombadil.infradead.org>
In-Reply-To: <ZyMJaFcF4dTTzNgK@bombadil.infradead.org>
From: Matthew Maurer <mmaurer@google.com>
Date: Wed, 30 Oct 2024 22:06:12 -0700
Message-ID: <CAGSQo02H_RwtLpdt4E_LWKjzGvryY_7s20e4QhhA5B7N0LPxVA@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] modules: Support extended MODVERSIONS info
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 9:37=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On Thu, Oct 31, 2024 at 12:22:36PM +1100, Michael Ellerman wrote:
> > Matthew Maurer <mmaurer@google.com> writes:
> > > Adds a new format for MODVERSIONS which stores each field in a separa=
te
> > > ELF section. This initially adds support for variable length names, b=
ut
> > > could later be used to add additional fields to MODVERSIONS in a
> > > backwards compatible way if needed. Any new fields will be ignored by
> > > old user tooling, unlike the current format where user tooling cannot
> > > tolerate adjustments to the format (for example making the name field
> > > longer).
> > >
> > > Since PPC munges its version records to strip leading dots, we reprod=
uce
> > > the munging for the new format. Other architectures do not appear to
> > > have architecture-specific usage of this information.
> > >
> > > Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
> > > Signed-off-by: Matthew Maurer <mmaurer@google.com>
> > > ---
> > >  arch/powerpc/kernel/module_64.c | 24 ++++++++++-
> >
> > Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
>
> Michael, Matthew, why make everyone deal with this instead of just
> making this an arch thing and ppc would be the only one doing it?
>
>   Luis
>

I'm not sure I understand - the PPC changes are in an arch-specific
directory, and triggered through the arch-implemented callback
mod_frob_arch_sections. What would you like done to make it more of an
arch-thing?
