Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207271FAA
	for <linux-modules@vger.kernel.org>; Tue, 19 Nov 2024 00:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731974989; cv=none; b=ozjhJuBcVjnYWPzSH8IdEOmzK1bjHbBOCwICfvQjj9lZKWWRDTMI0Sz6zoAfbDpvNx+TekdUukoxTb+F1vqhixwi1SjAjpK49cSSm9FkBmyAlZ107FGNtfqwfmymzOHIrHdXgnOSWdk4D84pUSq4yFDOv9/6QTMZ6GVslXoi1EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731974989; c=relaxed/simple;
	bh=2joQyxA/A/Ix50bwDrphRLZe1ZN4vLdUciNkknx5Y1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msRkV+W4PD/I5JzrN89cq9blAPQdaphyTNY46BcVlbPZSGLN69qjS/ClFT6xoZS6jmHdmAzvUH3kfpjeKvf1PoQo8dcmoTvX8qSPeDF44zTiNaCJ4cRH5jxr67nbLKTdKnQluSdj1e2b97RIMZ312W3lqnL6WBF22on65fb+U4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hWPkwO9I; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hWPkwO9I"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cfc18d5259so1786a12.1
        for <linux-modules@vger.kernel.org>; Mon, 18 Nov 2024 16:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731974985; x=1732579785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2joQyxA/A/Ix50bwDrphRLZe1ZN4vLdUciNkknx5Y1w=;
        b=hWPkwO9IKE0mcDw1guYidN9euwszrsIhtf2WghLE+tEDyvcK7DKzBMO3S1NVvjn9/E
         drM88icJqpN39XLRsTkOuncXv+icSxP5fc3IDTd3TUNYlfdJwnJ69FDBXAn2UdUnXIPA
         j5e4ta4N9s4fv+uVwngsQwG3xAVVsqPsbfD1ndYbxMtbO3+kHvj5tfBZ0r/X9WU6SBZP
         MjRmep7ay09tA3lq/qME7f7CLU+c5RV/aVinc7lCAatlXoUp93m6Ze3NXTaLFIKRZ4gs
         gQiH8inZ1YRGWt6bqj8kWgyahUNyJ0knUkOzUrkk1AplHgQ7ReW1YLvULF163tP6tvUo
         gDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731974985; x=1732579785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2joQyxA/A/Ix50bwDrphRLZe1ZN4vLdUciNkknx5Y1w=;
        b=KvBMzfFsDF91/E0CQoWPvMFVUL1RAbFSt2FO+kOO/t9nXyTX/Ks704xJIZUSsyea95
         wn30KGu3OkWyZcLmaMmimeXC+YgJG4xZNeNQmd6Svves0uU4hrZYdMk/w8JE7d0GNVAz
         5VAjS4n1MbDr4VbeBx8beIkahVxoWqrnTyQqiE3PSOFI07W9bYQQ+ZSCktkYhOaxIGvc
         OXCcTdTfMfF8HEiYGnImLWhnZ1wXgVM/hzqMUrT618KrMEwnF5LphQWKtMvOHKECjicV
         WQncXq8qjFvul2ejgZd1QNmtzfWMTefaZ0pD2+sstXBQ4PME5QgD/NgxBJSXCvGnK3AZ
         ZTiA==
X-Forwarded-Encrypted: i=1; AJvYcCX8NgosejpqAGMR7CI9KkesoH6WKUebE1Yg4k34B/WdQ+GH7qU86vJuhiSzcd/8npOP5q7Jk4PeCBnWkgfA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6srJUlghutk6o2zoXXVJuPCl9uCtVv8H4avQ4AAGFsNPtIc1a
	p3h0+JW47iyiigMzSQ8MxjC3sjtOrzI63nytP92BoRXzatiDZWm69aW7DWQF0+BJz7aRRobEhcM
	TwoIGm88uKVzmdXgTjHqfrfTPbDaUlVrREg+R
X-Gm-Gg: ASbGncuF0aoF48JpRgH/Url1rhf8G8udsxSDoWuytu+/zWrfIhX+kYALPNKZ1k/mhp8
	AUJ/b746CD04tC/FLp3ThNFRiY+yAjJhUr2QqGn47lUL0UPddNS0hgY+Y+1UOkg==
X-Google-Smtp-Source: AGHT+IGFkoWOhwex/vXz0phxng/cuRxB+IRiCctA7Y89o5ijfhkRJftBIN3eR6qiPieo/jVpc0lu+QpSWPIlthCtl3k=
X-Received: by 2002:a05:6402:1351:b0:5cf:bd9a:41ec with SMTP id
 4fb4d7f45d1cf-5cfdec244d3mr31183a12.2.1731974985273; Mon, 18 Nov 2024
 16:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-extended-modversions-v8-0-93acdef62ce8@google.com>
 <20241030-extended-modversions-v8-2-93acdef62ce8@google.com>
 <ZyNr--iMz_6Fj4yq@bombadil.infradead.org> <CAGSQo00F07viDHQkwBS8_1-THxJHYwx9VkS=TXC5rz3i8zSZSw@mail.gmail.com>
 <ZyVDv0mTm3Bgh1BR@bombadil.infradead.org> <CAGSQo02uDZ5QoRMPOn=3Fa9g5d+VPfKW-vmSsS2H+pOdPYCBFw@mail.gmail.com>
 <ZyrRYUD0K1f7SwWg@bombadil.infradead.org> <CAGSQo03+1WjUVj-iQ6zdOST6z=p+=OqS2Xk_c4ZUdHOsxa7g2w@mail.gmail.com>
 <Zy1BVXgnT72Jt_HE@bombadil.infradead.org> <Zzu-wfGqbuAm24yg@bombadil.infradead.org>
In-Reply-To: <Zzu-wfGqbuAm24yg@bombadil.infradead.org>
From: Matthew Maurer <mmaurer@google.com>
Date: Mon, 18 Nov 2024 16:09:34 -0800
Message-ID: <CAGSQo033fha6tj7sU8se4kbNfYD_rm5sx6-hpF9s8SfcgWH3Tg@mail.gmail.com>
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

> Thinking about this some more, if we're going down enabling a new
> option, it seems to beg the question if the old *two* ksymtab sections
> could just be folded into the a new one where the "gpl only" thing
> becomes just one "column" as you call it. Reasons I ask, it seems like
> we're duplicating symbol names on ksymtab and for modeversions. Could
> you review this a bit?

 Short answer: We could do this, but I don't necessarily think it's a good idea.

ksymtab and modversions aren't duplicating names even with this patch
series - We have two different formats, one for importing symbols, and
one for exporting them. `__ksymtab`, `__ksymtab_gpl`, and
`__ksymtab_strings` are used to export symbols. `__versions` or the
new `__version_ext_names` and `__version_ext_crcs` are used to import
them. For this reason, in any given compilation unit, a string should
only appear either in the ksymtab (providing it), or in versions
(consuming it).

There also isn't as much immediate technical need for that kind of
rework of the ksymtab format - ksymtab uses a string table for their
names, so the "long name support" that extended modversions provides
to modversions is already present in ksymtab.

Combined, this means that there would be few technical benefits to
this - the primary potential benefit I could see to something like
this would be code complexity reduction, which is a bit of a matter of
personal taste, and mine might not match others'.

However, we could do some things similar to what's going on here:
A. We could try to unify versions and ksymtab (this seems most viable,
but the change in meaning of this data structure has me wary)
B. We could make ksymtab use columnar storage for more things - it
already does so for CRCs, we could theoretically make any or all of
licensing, namespaces, or symbol values columnar.

With the caveat that I am not convinced this restructuring is worth
the churn, the way I would do A would be:

1. Add a field to the `kernel_symbol` that indicates whether the
symbol is import/export (or possibly re-use `value` with a 0 value
after linker resolution to mean "import" instead of export).
2. Generate `kernel_symbol` entries for imported symbols, not just
exported ones.
3. Read `kcrctab` for import symbols to figure out what the expected
crc value is when importing, rather than using versions.
4. Stop generating/reading any of `__versions`, `__version_ext_names`,
`__versions_ext_crcs`, etc.

There are two downsides I can see to this:
1. You cannot make this backwards compatible with existing `kmod`.
(This was the argument given against just enlarging MODVERSIONS symbol
names.)
2. It's hard to be certain that we know about all users of `ksymtab`
in order to ensure they all know the new convention around imported vs
exported symbols.

I think that B would actually make things worse because symbols always
today always have a value, a namespace, a name, and a license. The
only thing that's optional is the CRC, and that's already columnar.
Making the other ones columnar would hurt locality. We'd still need
the strtab sections, or we'd end up with many copies of each
namespace, where today that should get deduped down by the linker.
Columns are good for things that are extensions, optional, or variable
length.

If there are other reasons *for* doing this that I'm not aware of,
what I'd do would be:
1. Use the name as the primary index, same as modversions.
2. Split each other piece into its own column, with a joint iterator.
3. Convert license into a column, with an enum value (currently only
fully exported or GPL).
4. Replace places in the coe where a `struct kernel_symbol *` is used
today with an iterator over the joint columns.

Again, to reiterate, I *do not* think that B is a good idea. A might
be, but the improvement seems sufficiently marginal to me that I don't
know if it's worth the churn.
