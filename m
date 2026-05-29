Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADCC313E34
	for <linux-modules@vger.kernel.org>; Fri, 29 May 2026 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044913; cv=none; b=rxoBFl4h5OYXnnmjk7zu8HjReCgggOja6dMcTtobfmX6A/VcoTKKSK62MRBuLaJsAS5gcwZFXeVuzkZZZxISwAq2tNNwjYQsVoD55ruFvY/wdIOw9ceCTEUDyvO/In1MnB3qyVcnvp2HaaWP58jHvHht4DhBXNNLHZwdvBObKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044913; c=relaxed/simple;
	bh=xy2fucimnTLheB2x8zM39euIYcd0fS3rvhhGNwrSA5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GhBJNKTJEP38MZXJyHZqKlQhXXIV81HP0MaeRqxFpMoJy8JAuf9J/iDPvAl+ubJdXjD0/l2rnLcVZC8cbFOTbnbibT/XdLFgrsqU0l0f9fBbyzLoSvQAGZ7Zhg1tytLbj2YUbHImMNK+lSLQP/l3y7mJAlZuYKydZshq5qV/1lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJvej+QD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJvej+QD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BF01F00893;
	Fri, 29 May 2026 08:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780044912;
	bh=2JscMcgeXosxdVMYI+Yl7mj7qnKsR0Rj76sZJtgTVgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GJvej+QDN1RjEZ+dLNpWmOJgto3Hryh87H2UqfErbc3Ln2hACY2qKQUfcN8njJxVi
	 VTqM6yO9V7PPam2XDr384fGcTqG1KhAxid4oSICoF2ZnkkFylC3xcv85X78E15bH7t
	 A0z4GoDUgF0l9Bp0q4aF3m3zB74grHMyZ8vWDaZuSYLFK3oC9cvH3bx95Y2ckwcWRC
	 qNgKVmyUuaBr4qJLmgY83XonxQvveK8W1PiMCjlOF+KkpYJzr5NksFMEfSfaV63aC5
	 hY3bdsFyW4cr4Dq3POOJteV9lctxRJ4NpUgspelGE+lIGcVQH1jG3bpQUj4Beun71G
	 /CwO1Dg8hDbqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust: module_param: return value by copy from `value`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-modules@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260529-modules-value-ref-v1-1-a0df7e9e6f2d@kernel.org>
References: <20260529-modules-value-ref-v1-1-a0df7e9e6f2d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 08:55:11 +0000
Message-Id: <20260529085512.32BF01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing `#[inline]` annotations on small abstraction methods `value=
` and `value_ref` in `ModuleParamAccess`.
--

commit 6103e7f86e2528da9d35cfda1b1a7d24ab1f6516
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: module_param: return value by copy from value
   =20
For Copy parameter types, this patch changes ModuleParamAccess::value
to return by copy instead of by reference, improving ergonomics. It also
renames the reference-returning accessor to value_ref and updates the
caller in rust_minimal.

> diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
> index 6a8a7a875643a..701210206bba5 100644
> --- a/rust/kernel/module_param.rs
> +++ b/rust/kernel/module_param.rs
> @@ -132,9 +132,12 @@ pub const fn new(default: T) -> Self {
>      }
> =20
>      /// Get a shared reference to the parameter value.
> +    ///
> +    /// Returns a reference to the value supplied at module load time, o=
r a
> +    /// reference to the default value if the parameter has not been set.
>      // Note: When sysfs access to parameters are enabled, we have to pas=
s in a
>      // held lock guard here.
> -    pub fn value(&self) -> &T {
> +    pub fn value_ref(&self) -> &T {

[Severity: Low]
This isn't a bug, but according to the Rust subsystem coding guidelines,
functions in abstractions that are small or forward to binding calls should
be annotated with #[inline]. Should value_ref() have an #[inline] annotation
added here?

>          self.value.as_ref().unwrap_or(&self.default)
>      }

[ ... ]

> @@ -146,6 +149,16 @@ pub const fn as_void_ptr(&self) -> *mut c_void {
>      }
>  }
> =20
> +impl<T: Copy> ModuleParamAccess<T> {
> +    /// Get a copy of the parameter value.
> +    ///
> +    /// Returns the value supplied at module load time, or the default v=
alue
> +    /// if the parameter has not been set.
> +    pub fn value(&self) -> T {

[Severity: Low]
This isn't a bug, but similar to the above, should this small abstraction
method also be marked with #[inline] to allow compiler optimizations
across crate boundaries?

> +        self.value.copy().unwrap_or(self.default)
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529-modules-va=
lue-ref-v1-1-a0df7e9e6f2d@kernel.org?part=3D1
