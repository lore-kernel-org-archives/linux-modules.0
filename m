Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7A13BCD12
	for <linux-modules@vger.kernel.org>; Fri, 12 Jun 2026 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271663; cv=none; b=EqsaXlKLTTkJ5dtCvPGsNAPwTnjKl8Ng3roVUmchsaefGp91UJoglsXHhA9ZdwHMfob2F9HVqCfTw2IiSk9ScRronpeDiSG+XpHja3qLqbcoLRWATN4mde9kXt6qFSPLZ8NqRBJBbxHkDgGLukJrxKyIaxyK9/7BvwS+VV8o0Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271663; c=relaxed/simple;
	bh=PRAb21pxPv5UAIwHYDCgJ5b1gRHFAKx+Hf1rl8wNGFU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ww54nQlm+Z3LoNc7Rt/jcaEdPN2XmV5TCENpq35jhWscSE8R1eEtIquFODxv5E0Bv8KIm3gWPAvyTxsIfz0+Kpy7l6c9P6Y4QTbHmAce2oOlcYtYecuwQ2cMy/PYwJxkkr0bXmKIyKiIbL2yOuVDe+fzinsIP/85dkYlgN0zszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9sfm7B7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9sfm7B7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118B21F000E9;
	Fri, 12 Jun 2026 13:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781271661;
	bh=pyCBlsVoBL+nrBTW/JiPJGfwOxjFtpAk3M4MXpubRcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E9sfm7B7UNnXSmhdmAS7qs+dqMb8pzpL/qePHEDONh+Sw/oYdFpIy414g4aPjKeSY
	 3dDMHcocB9uprkVzUtPWaDwK/P2jdTwX0z6UOyrHpVn4exrVfAbv2vkj8L86DJYhq2
	 31z+fdv0RsLUtWQanHHbb1kcQgVSpVjGYJ9Ikrnn4+Mi5+W1C92xbM6upHcznsuqTy
	 sjapdoj/ox5xdyFsXi9RuuSh17f6u2X2nc3AN5j/PnkKIwNEosp8RQWeN6Q1NgO2h6
	 J9rL3fsa+pTIYKZ36KUwNQ54LE4tYIBvcuypdsr/Jhvj0yiH/uTEg7hf536ma/GoV7
	 ZmAmek4cNFP2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] rust: add procedural macro for declaring configfs
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Malte Wechter" <maltewechter@gmail.com>
Cc: ojeda@kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260612-configfs-syn-v3-1-3292fbc5cc32@gmail.com>
References: <20260612-configfs-syn-v3-1-3292fbc5cc32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 13:41:00 +0000
Message-Id: <20260612134101.118B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of the generated `configfs_attrs!` block caus=
es a data race on a shared `static` array.
--

commit d9a7547ab4c8957df6d5328eba0e3a712923192f
Author: Malte Wechter <maltewechter@gmail.com>

rust: add procedural macro for declaring configfs attributes

This commit replaces the old declarative configfs_attrs macro with a new
procedural macro to improve readability and maintainability.

> diff --git a/rust/macros/configfs_attrs.rs b/rust/macros/configfs_attrs.rs
> new file mode 100644
> index 0000000000000..81037bc38188b
> --- /dev/null
> +++ b/rust/macros/configfs_attrs.rs
[ ... ]
> +    let mut attrs =3D Vec::new();
> +    for (attr_idx, (name, id)) in cfs_attrs.attributes.iter().enumerate(=
) {
> +        let name_with_attr =3D format_ident!("{}_ATTR_{}", name.to_strin=
g().to_uppercase(), attr_idx);
[ ... ]
> +        attrs.push(quote! {
> +        static #name_with_attr: kernel::configfs::Attribute<#id, #data_t=
y, #data_ty> =3D
> +            // SAFETY: We are expanding `configfs_attrs`.
> +            unsafe {
> +              kernel::configfs::Attribute::new(kernel::c_str!(::core::st=
ringify!(#name)))
> +            };
> +
> +          // SAFETY: By design of this macro, the name of the variable we
> +          // invoke the `add` method on below, is not visible outside of
> +          // the macro expansion. The macro does not operate concurrently
> +          // on this variable, and thus we have exclusive access to the
> +          // variable.
> +          unsafe { #data_attr_ident.add::<#attr_idx, #id, _>(&#name_with=
_attr) }

[Severity: High]
This is a pre-existing issue, but does this generated code cause a data rac=
e=20
on the static attribute list array?

Because the generated attribute list is a static variable, its state is sha=
red
across all invocations of the block. If the macro is used inside a callback
like make_group, every time a new directory is created via mkdir, the add
method is executed at runtime, mutating the globally shared UnsafeCell-back=
ed
array via a raw pointer.

While make_group itself is serialized per-subsystem by su_mutex, concurrent
VFS reads on attributes of previously created directories do not hold this
mutex. Could make_group mutate the static array at the exact same time a
concurrent attribute read accesses it?

Could this array be fully initialized statically at compile time instead?

> +        });
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-configfs-s=
yn-v3-1-3292fbc5cc32@gmail.com?part=3D1
