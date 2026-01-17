Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C66135A53;
	Sat, 17 Jan 2026 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768680751; cv=none; b=pfSiCOgAgTXIx3d8uO078vB6weD1lGbBQr1tKopQjr5qJUsyDoEYfPwZimh9dUDD21PbzATlbXTysbJcPAnaz8P6NAZtUUd/bOa+kT2qJ0+O2cAQZZ0RpdCPVldbnNBC+TDwAEjYvHTxOyIEsMgvlNFuGYopW/j+dzw7Aw5Dh9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768680751; c=relaxed/simple;
	bh=n9bdXP3SYJS7k3E8+6xh+/pWXS7ei4TZPvyW3jatxNQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=LDiRg9AgRRiZWptnfr/vNf8DFAx21gMZxTqUwLAACl5LZ6Fqewy4fkP5MAoK7cGY7kP1Gkf2sLi3kcAAHuHrKZ4D6g7ki2tzA62y6UKOQpw6LbVHw3DcaotmrpRlLyO5mtCZWBLN2SNSzRJArxxNFChc1aoYREtfkybftu+ADJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USVL9aXI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USVL9aXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE83C4CEF7;
	Sat, 17 Jan 2026 20:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768680751;
	bh=n9bdXP3SYJS7k3E8+6xh+/pWXS7ei4TZPvyW3jatxNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USVL9aXIsDi7YQe24VBzuQexo5E7BaOsSmL2xWISC3r0vKIkP7iDCg/PODu4L2FJ5
	 DiQkfuDCC8FT5VOKjYJrPkU7CX2D3W/DOBytOK+G8csSKo7hcMWPeEaFGzWdKMojHE
	 rmQ1pqQY1TcmYRuHPBp6QEQl5zAAEvZvJ+z8dGxUSH/QnPQft8F/EP4JV8lRO1kH2F
	 LbOAPM6H8rSDFBl51XLuQXxAN9siqAFgCb+KG8fUomnu2VmySrK26dkcSAgSHu0wtK
	 zGiYXAv6PUo8HWrwyzDJQU0cSo+UmiPtqC+ZstkIR0iaJwTSl6imXJnhrvV41+JH2r
	 zlm6uDHmgTBqA==
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Jan 2026 21:12:25 +0100
Message-Id: <DFR4ZXJSZ1QO.20K98LW2161E@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez"
 <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Tamir Duberstein" <tamird@gmail.com>, "Igor
 Korotin" <igor.korotin.linux@gmail.com>,
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v3 04/12] rust: macros: use `syn` to parse `module!`
 macro
X-Mailer: aerc 0.21.0
References: <20260112170919.1888584-1-gary@kernel.org>
 <20260112170919.1888584-5-gary@kernel.org>
In-Reply-To: <20260112170919.1888584-5-gary@kernel.org>

On Mon Jan 12, 2026 at 6:07 PM CET, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> With `syn` being available in the kernel, use it to parse the complex
> custom `module!` macro to replace existing helpers. Only parsing is
> changed in this commit, the code generation is untouched.
>
> This has the benefit of better error message when the macro is used
> incorrectly, as it can point to a concrete span on what's going wrong.
>
> For example, if a field is specified twice, previously it reads:
>
>     error: proc macro panicked
>       --> samples/rust/rust_minimal.rs:7:1
>        |
>     7  | / module! {
>     8  | |     type: RustMinimal,
>     9  | |     name: "rust_minimal",
>     10 | |     author: "Rust for Linux Contributors",
>     11 | |     description: "Rust minimal sample",
>     12 | |     license: "GPL",
>     13 | |     license: "GPL",
>     14 | | }
>        | |_^
>        |
>        =3D help: message: Duplicated key "license". Keys can only be spec=
ified once.
>
> now it reads:
>
>     error: duplicated key "license". Keys can only be specified once.
>       --> samples/rust/rust_minimal.rs:13:5
>        |
>     13 |     license: "GPL",
>        |     ^^^^^^^
>
> Reviewed-by: Tamir Duberstein <tamird@gmail.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Benno Lossin <lossin@kernel.org>

Cheers,
Benno

> ---
>  rust/macros/helpers.rs | 109 ++++-------
>  rust/macros/lib.rs     |   6 +-
>  rust/macros/module.rs  | 399 +++++++++++++++++++++++++----------------
>  3 files changed, 280 insertions(+), 234 deletions(-)
