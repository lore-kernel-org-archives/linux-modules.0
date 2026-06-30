Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230912609FD
	for <linux-modules@vger.kernel.org>; Tue, 30 Jun 2026 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827490; cv=none; b=JT5eQ8N1Gp9O0o+kTlRcVKTYubWxuMpbjtfDdvMg9+9vmVUJoq2hYKxvj2SgtvnakzuqR7d3el84DvlTqGbn7YuNGZ/oAHXvT+AHA8Fn7Gvrq++cGlrCidt8DMDra10IOSL9+ngu7I3e1GyJI7FOQFEHDvN9qgnkPkNgnjL5Ijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827490; c=relaxed/simple;
	bh=I7zJN8M+96uJIvnnbpVkxeEzQU1GzI7A7TqU81j9vVo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IU/mIRE3EEFJ0aLcWuDan9EbqEtcZezacMwj15QY09etDAMdT9cGKVeUjibF/WtY2zovbujmIemFkPzcF8iKHcAJmetJpSKHkuki7Ua9NSIB9c7DCo9oXYxPHfNxsSENvSLlzLLET4en+8hxXqc/zh2CgZ/2zDrkmnry5njPVKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFAfORqN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFAfORqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE4A1F00A3A;
	Tue, 30 Jun 2026 13:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782827488;
	bh=z1eQTE5uxvCd4OXl0u1x+xXEbrumx7/y3U4+ncxXS5E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dFAfORqNxfctFhHG3oQ+JstoxA5mHTpLqKudetKs5GxuiOcwKgLkymAgDFnPrXQKg
	 RqGeLDNrI1MsnprRDnAbFsIHfyXz+brs40x1BPqSn3wCX2K+atuTlpptAw7ux5X2Ch
	 afRhtfLS5CtDyQt1cs4OLeMCJQZyruZpFAlaKSdwH/BtlAZ5AwIgfQoIvL40qivC5t
	 Wjz3RlFE0UjjhYxsLxj8KjTLtZ/vNuLqPvJwZbnrMME8NXpR8cC5yKhqwjXbRMR+1q
	 vrf5WQ9P+ni3KyJY+1ZWDWC9Q7FEp5FwUZ0POL51Odj8btvn1JGCXdnrFRk/ijKZdP
	 EEF3Rdn/DYr4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] rust: configfs: add procedural macro for declaring
 configfs attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Malte Wechter" <maltewechter@gmail.com>
Cc: linux-modules@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260630-configfs-syn-v5-1-da712975ec1a@gmail.com>
References: <20260630-configfs-syn-v5-1-da712975ec1a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:51:28 +0000
Message-Id: <20260630135128.8BE4A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Raw identifiers generate incorrect configfs attribute names with=
 an 'r#' prefix.
- [Low] The new macro strictly requires a trailing comma after the last fie=
ld, reverting a usability fix and breaking compatibility with existing macr=
o invocations.

Pre-existing issues:
- [High] Concurrent configfs directory creations of the same type will caus=
e a data race on the `static` `DATA_ATTR_LIST` array.
--

commit 884f1e9ac3af92759b06d060216464edd49fb53f
Author: Malte Wechter <maltewechter@gmail.com>

rust: configfs: add procedural macro for declaring configfs attributes

Implement `configfs_attrs!` as a procedural macro using `syn`, this
improves readability and maintainability. Remove the old macro and
replace all uses with the new macro. Add the new macro implementation
file to MAINTAINERS.

> diff --git a/rust/macros/configfs_attrs.rs b/rust/macros/configfs_attrs.rs
> new file mode 100644
> index 0000000000000..f829a42cece88
> --- /dev/null
> +++ b/rust/macros/configfs_attrs.rs
[ ... ]
> +        attrs.push(quote! {
> +        static #name_with_attr: kernel::configfs::Attribute<#id, #data_t=
y, #data_ty> =3D
> +            // SAFETY: We are expanding `configfs_attrs`.
> +            unsafe {
> +              kernel::configfs::Attribute::new(kernel::c_str!(::core::st=
ringify!(#name)))
             ^^^^

[Severity: Medium]
Will this generate incorrect configfs attribute names with an "r#" prefix if
a raw identifier is used? The macro uses unraw() for the Rust static names
earlier, but seems to pass the raw string into stringify!() here.

> +            };
> +
> +          // SAFETY: By design of this macro, the name of the variable we
> +          // invoke the `add` method on below, is not visible outside of
[ ... ]
> +          // by per subsystem mutex.
> +          unsafe { #data_attr_ident.add::<#attr_idx, #id, _>(&#name_with=
_attr) }
             ^^^^

[Severity: High]
This is a pre-existing issue, but does this code cause a data race? If
multiple threads call make_group concurrently (for example, creating
directories in different subsystems that share the same configuration struc=
t),
they would execute this add() concurrently and mutate the static
DATA_ATTR_LIST array without synchronization, leading to undefined behavior.

> +        });
> +    }

> diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
> index d18fbf4daa0a5..305dcbddf7974 100644
> --- a/rust/macros/helpers.rs
> +++ b/rust/macros/helpers.rs
[ ... ]
> +            match &*key.to_string() {
> +                $(
> +                    stringify!($key) =3D> $name =3D Some($parser),
> +                )*
> +                _ =3D> {
> +                    Err(Error::new_spanned(
> +                        &key,
> +                        format!(r#"unknown key "{key}". Valid keys are: =
{EXPECTED_KEYS:?}."#),
> +                    ))?
> +                }
> +            }
> +
> +            $input.parse::<Token![,]>()?;
             ^^^^

[Severity: Low]
Does this strictly require a trailing comma after the last field? The
previous declarative macro allowed an optional trailing comma, so
this strict requirement might break compatibility with existing macro
invocations.

> +            seen_keys.push(key);
> +        }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-configfs-s=
yn-v5-1-da712975ec1a@gmail.com?part=3D1
