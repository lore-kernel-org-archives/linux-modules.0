Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609298;
	b=AHVZJC13PAuMrrbEXqfQ1Py3H6MNY9uGGAz4aM9c+rZHSJnDAbfjdHdjv4G2ya1+9nsZ
	 gV5bAj8ovRQIrvLTJ4DDmGOUc6DbblcJMeQCM6T9EsqQuV2q0zfbdfpCuyshOlD/hr7+K
	 +draYo27xOiCMccQmW2TDp/uMXeLL7BUXLl+2Xh873lA9X3lD+3OdgTTYa/pur4iwJ9oF
	 9BhgKQdCum+7OQAfwZThvsYo5epyxEd5Yk5vYjjZ5TQa5j7j+ZUWWk/8ojSoguOjt4so6
	 1OF+CyGyEj3WDk80spF1iOBXFodgx+IlaR+zxk5XmMSjf1tYaPAlGCjTKqdfVJlA3Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609298;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pfwUE4VpK782tDAwe0awin0qkTtNZnQd6N+nXJt4Zdk=;
	b=nC4vJuGVK7l75Uf39V+UmEp80O2Gecm/FwVD7TJS+JtkWVxFfng3M3zQx0eNbAPNVc1/
	 okCjl+vH1FMhr85FNCany3vj1YZJKGZiydfOS59AUZDwu4Vla08sffU4+48NwehWaSnzn
	 6Efb0KEZKlRShAsPKjbk/NEq9M3+8w2gshw6hFVBFobWEkVmqpihLwU99UipQMCiiaE72
	 k6jKCEn3Eh/DYReXwQ6KXhmj+GYxc++BsIMjDl8t/1/kcDYHZPHCgAChwWyaWZ5tTfwp1
	 FfwNoCz4CjvrFF0kJNCHL9H2U+hXo4Mamb8nJlzCUWBP2oh1LSiPwkw/kGyEz8tbH4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ewgrBCyg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA05E606A321;
	Wed, 25 Nov 2026 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ewgrBCyg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1839B1F000CF;
	Wed, 25 Nov 2026 12:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795609298;
	bh=pfwUE4VpK782tDAwe0awin0qkTtNZnQd6N+nXJt4Zdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ewgrBCygZQRx6JNqinpGU/bKkkoLox69v47v/rI+nroSFBYvcJKp54BVd6fECvkOe
	 Ro9lP8ebhZ3Ns+HdOeTRxrTPFhEC9Yro71jJRhmO9Eb1o7KDgHLTG6hACPFj5n6dvS
	 emWvzy0+/ip35GukLvMLnyy23wBv0jGwXF2GBMVxaOgx2FXPOGTq/VUgT4LYL2AHfz
	 hN++S7piuqbSl1+aLIPlgBoj/cGIfsPgAL04vkiADTrarfbpcJ4cj7VQY1oYgG6BKC
	 29I14eD3zNuw1yYL0bt9atILEqaJdzA6cSzMglwhp21zjD0qyr2pz7vCxXKDm1XoiI
	 qeBdzs7co5fVQ==
Message-ID: <sashiko-outbox-233361@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/7] modpost: cache section relocation mismatch state
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Nick Desaulniers" <ndesaulniers@google.com>, "Bill
 Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>, "Geert
 Uytterhoeven" <geert@linux-m68k.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>, "Sami
 Tolvanen" <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>, "Josh
 Poimboeuf" <jpoimboe@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?b?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir
 Duberstein" <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?b?T251ciDDlnprYW4=?= <work@onurozkan.dev>, "Nicolas Schier" <n.schier@fritz.com>, "Kees
 Cook" <kees@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org
In-Reply-To: <20261124-build-speedup-v6-3-141a4f861c67@kernel.org>
References: <20261124-build-speedup-v6-0-141a4f861c67@kernel.org>
 <20261124-build-speedup-v6-3-141a4f861c67@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 12:21:36 +0000
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] modpost: O(num_sections^2) cache reset in check_sec_ref()
--

commit 5f25a8268ae38882b32798d9f25f701a7e196767
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

modpost: cache section relocation mismatch state

This commit caches section_mismatch() results per destination section index
while scanning each relocation section in check_sec_ref().

> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 75374c64b8cc7..83caf29b4bf2b 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1155,12 +1155,62 @@ static void check_export_symbol(struct module *mo=
d, struct elf_info *elf,
>  			 name);
>  }
> =20
> +static void init_mismatch_cache(struct elf_info *elf)
> +{
> +	elf->mismatch_cache =3D xcalloc(elf->num_sections,
> +				      sizeof(*elf->mismatch_cache));
> +}
> +
> +static void reset_mismatch_cache(struct elf_info *elf)
> +{
> +	memset(elf->mismatch_cache, 0,
> +	       elf->num_sections * sizeof(*elf->mismatch_cache));
> +}

[ ... ]

> @@ -1445,6 +1495,8 @@ static void check_sec_ref(struct module *mod, struc=
t elf_info *elf)
>  {
>  	int i;
> =20
> +	init_mismatch_cache(elf);
> +
>  	/* Walk through all sections */
>  	for (i =3D 0; i < elf->num_sections; i++) {
>  		Elf_Shdr *sechdr =3D &elf->sechdrs[i];
> @@ -1461,6 +1513,9 @@ static void check_sec_ref(struct module *mod, struc=
t elf_info *elf)
>  			if (match(secname, section_white_list))
>  				continue;
> =20
> +			/* Reset cache per-section. */
> +			reset_mismatch_cache(elf);

[Severity: Medium]
Does calling reset_mismatch_cache() on every non-whitelisted relocation
section make check_sec_ref() O(elf->num_sections^2)?

When per-function or per-data sections are enabled (for example with
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION or CONFIG_LTO_CLANG), each function
or variable with relocations gets its own .rela.text.<func> or
.rela.data.<var> section in vmlinux.o.  With hundreds of thousands of
sections, zeroing the entire elf->num_sections array per relocation section
performs tens to hundreds of gigabytes of memset() work while flushing
cached entries between .text.* sections that share the same sectioncheck[]
source classification.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-build-spee=
dup-v6-0-141a4f861c67@kernel.org?part=3D3
