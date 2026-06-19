Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19542E6CB8
	for <linux-modules@vger.kernel.org>; Fri, 19 Jun 2026 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861030; cv=none; b=TOi8F5gHKKrQ+V/H9UMlbDsY1UAET3ptQWJz6oDU/QEDvtTlfOzQFJPkuJn4gRfmU2UQvj2FvDzbV4Wc/AQ3WJJ2LMDz7p8zo+h1IK02DgyTx1W+6UVLNQKRcSMtpzQ8dDHcDs8x16CcbB6E0QD47YjUXrlOMyd6MOPdp8qOhYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861030; c=relaxed/simple;
	bh=TeVr2m2aAWWjiKaTvlwv/EfoTkwJ6NRfnM38YUoqyh0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tk3AWYBKqKbJld8mnI3b63IEEUOXqnYQAWvCwrvqh5lb9xndCqLXVhkr7poXxs3w0zzdAOwlqiIR1i5SkpMVPAUZFmsUeq8AM1MJE/R2rEYcF84HsU7AYI0wDK0YSUunwC2jBdcBlP7Mh1Yz/J+GLfgXlYzLf+jr4vZ6ZSCdFSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBr68Xoa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBr68Xoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396051F000E9;
	Fri, 19 Jun 2026 09:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781861029;
	bh=Bcvrz61G5v4CMruhqOW6gEewE9YcAuvfn75LYqS5Q38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gBr68Xoa1awyXg4AZh8HvOFedWW8cYmPESG8o4075juFxfDE6Cab4s3lSOYlxmQ9+
	 DeRM0ilH8hQ/bPjJSwqpC3x76q4q069/omKzX6DPopMsT9LdnEbDKOrEmqeqfCXB1m
	 hRX1IXL4JEw/UgWZ9rVdhKYVikPQyP7TRzkMX4zYLZOjyi/LRbzA3As6AWhuWX63O2
	 IkdIIK0ruSTgUJM6atw7zbJ4KDrC4IOi4EUxHgl69cf0fxDuI7hysVg8ALY7n9ULrD
	 67ir4fwmNsQsUc7Oo9qupCFVne87mlZNJMFtUbYVNK8thjVuZYhGxk52GQ2xebierl
	 67f1OGkODznnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] rust: configfs: add procedural macro for declaring
 configfs attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Malte Wechter" <maltewechter@gmail.com>
Cc: linux-modules@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260619-configfs-syn-v4-1-207c39504c1e@gmail.com>
References: <20260619-configfs-syn-v4-1-207c39504c1e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:23:48 +0000
Message-Id: <20260619092349.396051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The new macro no longer prevents duplicate attribute names at co=
mpile time.
- [Low] The macro will panic at compile time if a raw identifier (e.g., `r#=
type`) is used as an attribute name.

Pre-existing issues:
- [High] The `configfs_attrs!` macro dynamically mutates a `static` array v=
ia `AttributeList::add`, causing a data race and undefined behavior when in=
voked concurrently at runtime.
--

commit eb5933487fd2a34ea26fb0f106c056e03f633059
Author: Malte Wechter <maltewechter@gmail.com>

rust: configfs: add procedural macro for declaring configfs attributes

Implement configfs_attrs! as a procedural macro using syn, this improves
readability and maintainability. Remove the old macro and replace all uses
with the new macro. Add the new macro implementation file to MAINTAINERS.

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

[Severity: Medium]
Does this change remove compile-time duplicate name checking?

In the old macro, the generated static variables were named based only on
the data type and attribute name (e.g., CONFIGURATION_MESSAGE_ATTR). If a
user accidentally provided duplicate attribute names, the compiler would
catch the duplicate static variable definition.

By appending attr_idx to the identifier here, duplicate attributes will
compile successfully since the variable names are unique, but they will
fail at runtime when the C configfs layer attempts to register them.

[Severity: Low]
Will this format_ident! call panic during compilation if a raw identifier
(like r#type) is used as an attribute name?

When name is a raw identifier, name.to_string() yields "r#type", which
becomes "R#TYPE" after to_uppercase(). Attempting to construct an
identifier containing "R#" is invalid. Using name.unraw() might be needed
to strip the prefix before processing.

> +
> +        let id: u64 =3D match id.base10_parse::<u64>() {
> +            Ok(v) =3D> v,
> +            Err(_) =3D> {
> +                return syn::Error::new(id.span(), "Could not parse attri=
bute ID as a u64")
> +                    .to_compile_error();
> +            }
> +        };
> +
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
This is a pre-existing issue, but does this unsafe block introduce a data
race?

The macro expands to a block containing a static DATA_ATTR_LIST and unsafe
runtime statements (DATA_ATTR_LIST.add(...)) to populate it. Because this
macro is typically evaluated at runtime inside the make_group callback
(which handles mkdir syscalls), concurrent executions by multiple threads
will perform unsynchronized writes to the shared static variable.

Concurrently modifying the same memory via interior mutability is undefined
behavior in Rust.

> +        });
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619-configfs-s=
yn-v4-1-207c39504c1e@gmail.com?part=3D1
