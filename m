Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7DCCA5B
	for <linux-modules@vger.kernel.org>; Wed,  6 Nov 2024 00:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730852826; cv=none; b=jeuOPcR3XzP+ZP7pAR6xcSgnrWfnPtiZY0vUcgnPs8R0s5omkXYnxdTfkhOfT16xgBqTek8rpvp+BUBqpS8c1cVtgufE8cl6d3Suuoxz105XerAsxj0znl231sj+lUm3Il2iOGq6Cfqede/FEQwcsREbMuNJO+S1kwTtl2dAqdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730852826; c=relaxed/simple;
	bh=3ieE5cYb6tECi6D+DBtovi5eoxeskei2U1od2A9ExwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ps/aAvVyJnYO7wq8PiKKbZd0L2SuhM3VvnvPp4reYJKUDj/+sI6UQyb8YB/4MLk5+bj+kqoa8miQa7jHA7MN3Wv9WcAsoGcy+e+xDXmjJxweqUGSlj+Z7iYbp1kgP9Bc0idaY5DFCioswEJZAldoTbdCQKAXswPsJB1ZnyoXuTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EPW9tcix; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EPW9tcix"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e66ba398so8668e87.0
        for <linux-modules@vger.kernel.org>; Tue, 05 Nov 2024 16:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730852823; x=1731457623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRO9xQlklRvT0E69gUtfh5sNxBrWxd3DuFYUq1k3Ijw=;
        b=EPW9tcixhStYhPz8q/MuwQissDMAgHHiPWaevx7QSiFLiBKNhtxJTuzASgv1/VVZSC
         54WdBOx9NBsNX91O2MI84/Kxgsi5mz3UbwlVbhRGJLLddGcc6sEP6JwfRA+Ssi7w5BAv
         gnfw8SEmgeyVJrR7Kov/KwEC5Kn+A/0mzJCFLnImBge06qSauXyCQe2OJ0JlqFtg7ycT
         qr1i+3qAViYqaJ5lDAdC60QZl/H+pYOqK8MNT+0UpZ4m+AmYv7ruRIDOSbNQUroqMkbi
         VVtq1zGB+iQ3esraBkEFyR+LvFlvw1NmQ5vlrx4t1HKdp+gDQRMSO5gH/+MmXyhj781+
         /jfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730852823; x=1731457623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRO9xQlklRvT0E69gUtfh5sNxBrWxd3DuFYUq1k3Ijw=;
        b=DnTiLJk/E9hjcA+2BHmmF4N/og0FnzUWLMmQ1FTUyUkoN3rYGdQtat8b+s2MtwYB9m
         /VAVmjzgiBEkwugPjtCLpYQGaestMmhKwQwcMrWVBReNMjXPGVFId4CaVU7ABvIIwA1X
         L3KBOBb9t+JU3RDyqh2PQ+4w3PlcOWWEWiyFwIXjH54TC35uQfmwcy/VqyITfYzM+9Mg
         s75TTR4+KkSz3H/1mANRSykNn9cn5ErH/FL7UucK6DocWwnljz/E0LqqRzf3QNfSuu+6
         7NOdtdRbhnZowasf1FUgVocheuCzXPIpqU//ejxzxROEC6NX3zVopP6zs97u3qoFNtXu
         mSSg==
X-Forwarded-Encrypted: i=1; AJvYcCXqye0qWD946xvCGpvv5Ow6TE2BFxSZDNX1/2AQJwTkHD2pLmIRCMP5ItET566F3C5PtSC9KcfwjetavJmh@vger.kernel.org
X-Gm-Message-State: AOJu0Yza82tS76puTwlqD5M9CGP4yFpFd6hd1OxAfNzLo7ASeZzqHxGg
	txbUCZa3sXzw2AfcTr2uorAFerMKEWGMXiIfNqSdhNRA9q80FvcHzWEmoIY5L7OayDrpXAg0z4C
	t/DnlhNvs9o65xHuetnZeSqyJJUjFSHHulzmx
X-Gm-Gg: ASbGnctfwJ+/hBwpdRgSByFmIPrBmznxLLz2XMR9HDe0L4G3YxM1yHa5yE0l+lG2ZEg
	F+bSsdBSwG7fZ2lC+IAdPDKFL4nz43yiI9t7JvjLOiqM0IF8JjG0LfW+UwzihQg==
X-Google-Smtp-Source: AGHT+IE+Ve5zkLIG/2ctO+hgokTHSdkzeAFtePIoGq4t8jD3ad7SdLQ0XlUXXaSH2Lu/eahr3Xg9xbPc7h0Nl+t5HbI=
X-Received: by 2002:a05:6512:4ca:b0:533:49ab:780e with SMTP id
 2adb3069b0e04-53d7cc42facmr199195e87.2.1730852823031; Tue, 05 Nov 2024
 16:27:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-extended-modversions-v8-0-93acdef62ce8@google.com>
 <20241030-extended-modversions-v8-2-93acdef62ce8@google.com>
 <ZyNr--iMz_6Fj4yq@bombadil.infradead.org> <CAGSQo00F07viDHQkwBS8_1-THxJHYwx9VkS=TXC5rz3i8zSZSw@mail.gmail.com>
 <ZyVDv0mTm3Bgh1BR@bombadil.infradead.org>
In-Reply-To: <ZyVDv0mTm3Bgh1BR@bombadil.infradead.org>
From: Matthew Maurer <mmaurer@google.com>
Date: Tue, 5 Nov 2024 16:26:51 -0800
Message-ID: <CAGSQo02uDZ5QoRMPOn=3Fa9g5d+VPfKW-vmSsS2H+pOdPYCBFw@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] modpost: Produce extended MODVERSIONS information
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, Lucas De Marchi <lucas.de.marchi@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
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

On Fri, Nov 1, 2024 at 2:10=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> On Thu, Oct 31, 2024 at 01:00:28PM -0700, Matthew Maurer wrote:
> > > The question is, if only extended moversions are used, what new tooli=
ng
> > > requirements are there? Can you test using only extended modversions?
> > >
> > >   Luis
> >
> > I'm not sure precisely what you're asking for. Do you want:
> > 1. A kconfig that suppresses the emission of today's MODVERSIONS
> > format?
>
> Yes that's right, a brave new world, and with the warning of that.

OK, I can send another revision with a suppression config, perhaps
CONFIG_NO_BASIC_MODVERSIONS

>
>
> > This would be fairly easy to do, but I was leaving it enabled
> > for compatibility's sake, at least until extended modversions become
> > more common. This way existing `kmod` tools and kernels would continue
> > to be able to load new-style modules.
>
> Sure, understood why we'd have both.
>
> > 2. libkmod support for parsing the new format? I can do that fairly
> > easily too, but wanted the format actually decided on and accepted
> > before I started modifying things that read modversions.
>
> This is implied, what I'd like is for an A vs B comparison to be able to
> be done on even without rust modules, so that we can see if really
> libkmod changes are all that's needed. Does boot fail without a new
> libkmod for this? If so the Kconfig should specificy that for this new
> brave new world.

libkmod changes are not needed for boot - the userspace tools do not
examine this data for anything inline with boot at the moment, libkmod
only looks at it for kmod_module_get_versions, and modprobe only looks
at that with --show-modversions or --dump-modversions, which are not
normally part of boot.

With the code as is, the only change will be that if a module with
EXTENDED_MODVERSIONS set contains an over-length symbol (which
wouldn't have been possible before), the overlong symbol's modversion
data will not appear in --show-modversions. After patching `libkmod`
in a follow-up patch, long symbols would appear as well. If booted
against an old kernel, long symbols will not have their CRCs in the
list to be checked. However, the old kernel could not export these
symbols, so it will fail to resolve the symbol and fail the load
regardless.

If we add and enable NO_BASIC_MODVERSIONS like you suggested above,
today's --show-modversions will claim there is no modversions data.
Applying a libkmod patch will result in modversions info being
displayed by that command again. If booted against a new kernel,
everything will be fine. If booted against an old kernel, it will
behave as though there is no modversions information.

>
>
> If a distribution can leverage just one format, why would they not
> consider it if they can ensure the proper tooling is in place. We
> haven't itemized the differences in practice and this could help
> with this. One clear difference so far is the kabi stuff, but that's

The kabi stuff is at least partially decoupled - you can (and it
sounds like from the responses to Sami's change, occasionally might
want to) enable debug symbol based modversions even without extended
modversions. You can also enable extended modversions without the
debug symbol based modversions, though there are less clear use-cases
for that.

> just evaluating one way of doing things so far, I suspect we'll get
> more review on that from Petr soon.
>
>   Luis
