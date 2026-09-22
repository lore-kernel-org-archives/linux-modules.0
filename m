Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E5C318BB5;
	Tue, 22 Sep 2026 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080736; cv=none; b=FX5P9fNlwUijhtev9jfUu9r8GpQAsecgBbXOhZnzI0PPv4NP8SHTNqUwDDcjzzk4zXPejyo74xyOqT+Wd4dOd6HUVxcTdtTZfZyaFauOPyHKolAajqOEcH/yejFUsKQUJ2D0hMU+bRQvSf0nvlWWUOAmZw/qptQDH7ZPq/zcd2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080736; c=relaxed/simple;
	bh=cScClSEFXuaUS8XKb6a1KH7r1p4cEPwQACRbELUv12o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G8uxOJtm8MLYVW3hvJTILT2Fyjse9S9uNAAWOuTOqsFK5I50b6Ev1ub7ep1ZV7lQT4rko7w7J29wYruYS1mOiGdYGUirET9uw+q166tV1oxe8cDdkM7xoUZyxb1yLQR8l9cRVoaksXBJFY0MTjCG5i1cNPWvcH68rgXXrAxBoiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0G2RlRw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0G2RlRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E910B1F00893;
	Tue, 22 Sep 2026 12:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080734;
	bh=2ORII6Ge34B1BzAh+lcRHMUXsQkyOQDuClowMpGXjk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=T0G2RlRwzGqFfKWSYchIgdzk6bssCAtVvqvwQYEnh83z4zKyPyWQFyKlpdsZq8kPm
	 T1vPM7qljXvr8yRnzC5KSkGxzIAbZp7sGqhryW/b04vq8JNA7PaFLLAOo+MX+Wbiyr
	 jtSoa7N3CLJjv5YbJvrOLgYt4NJy5iF/tr1+SbPBic+I/Zqu0q4OZRNZbr1EoB34ng
	 EFu903R11wO/XGBfq36fgaTaMkl1dctQBelFwGFv2qJ+CBOdsPmvmUPrv7Ggt1symW
	 0dEOeo1TXIweeq/KxWubBj/LlO+Uy169TNVVvkeLXHu/tINd2wH0D763rohMsfwZiz
	 Zn7HHHnKGOt1g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Priya Bala Govindasamy <pgovind2@uci.edu>, mcgrof@kernel.org,
 petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
 ojeda@kernel.org
Cc: atomlin@atomlin.com, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com,
 tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev,
 linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org,
 ardalan@uci.edu, zhiyunq@cs.ucr.edu, dzueck@uci.edu, pgovind2@uci.edu
Subject: Re: [PATCH 1/1] rust: module_param: Fix potentially incorrect
 access of `SetOnce<T>`
In-Reply-To: <e65203759411aeca4805e3f619f3dd20839dba35.1789426258.git.pgovind2@uci.edu>
References: <cover.1789426258.git.pgovind2@uci.edu>
 <FdiPIlB8b46OSfjlwz76TUlT6wZZlBnrojdIpqdfcvdhwJDwKrBZama8zVUX8dFHpUYYXw02R732rD5GuNCeKw==@protonmail.internalid>
 <e65203759411aeca4805e3f619f3dd20839dba35.1789426258.git.pgovind2@uci.edu>
Date: Tue, 22 Sep 2026 14:38:41 +0200
Message-ID: <8733v14g1a.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Priya Bala Govindasamy" <pgovind2@uci.edu> writes:

> The `set_param` function casts `kernel_param.arg` to `*const SetOnce<T>`
> But the Rust module macro in rust/macros/module.rs initializes `arg` with
> `#param_name.as_void_ptr()`, and `#param_name` is a `ModuleParamAccess<T>`,
> not a `SetOnce<T>`.
>
> ModuleParamAccess<T> has default Rust layout but `set_param` accesses its
> first field SetOnce<T> assuming it to be at offset 0. This is not
> guaranteed by Rust and could cause type confusion leading to data
> corruption.
>
> Fix this by casting `kernel_param.arg` to `ModuleParamAccess<T>` and
> then accessing the `value: SetOnce<T>` field.
>
> Fixes: 0b08fc292842 ("rust: introduce module_param module")
> Reported-by: Dylan Zueck <dzueck@uci.edu>
> Assisted-by: LLM
> Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
> ---
>  rust/kernel/module_param.rs | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
> index f9a14765a926..7ae87ffe1d6b 100644
> --- a/rust/kernel/module_param.rs
> +++ b/rust/kernel/module_param.rs
> @@ -75,7 +75,9 @@ pub trait ModuleParam: Sized + Copy {
>          let new_value = T::try_from_param_arg(arg)?;
>
>          // SAFETY: By function safety requirements, this access is safe.
> -        let container = unsafe { &*((*param).__bindgen_anon_1.arg.cast::<SetOnce<T>>()) };
> +        let param_access = unsafe { &*((*param)
> +            .__bindgen_anon_1.arg.cast::<ModuleParamAccess<T>>()) };
> +        let container = &param_access.value;
>
>          container
>              .populate(new_value)
> --
> 2.34.1

This is indeed a bug. Nice catch.

I think the primary reason for this error is that the safety comment is
lacking. It is also covering two distinct unsafe operations. I think we
should rephrase as so:

diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
index 7ae87ffe1d6b..1a2fcbf4a5b3 100644
--- a/rust/kernel/module_param.rs
+++ b/rust/kernel/module_param.rs
@@ -74,9 +74,12 @@ pub trait ModuleParam: Sized + Copy {
     crate::error::from_result(|| {
         let new_value = T::try_from_param_arg(arg)?;
 
-        // SAFETY: By function safety requirements, this access is safe.
-        let param_access = unsafe { &*((*param)
-            .__bindgen_anon_1.arg.cast::<ModuleParamAccess<T>>()) };
+        // SAFETY: By function safety requirements, `param` is valid for read.
+        let arg = unsafe { (*param).__bindgen_anon_1.arg };
+        let param_access_ptr = arg.cast::<ModuleParamAccess<T>>();
+        // SAFETY: The `arg` field is initialized with a pointer to a `static ModuleAccessParam` by
+        // the rust module macro. Thus, the pointer is valid for use as a reference.
+        let param_access = unsafe { &*(param_access_ptr) };
         let container = &param_access.value;
 
         container
---

Please also remember to run `make rustfmt` to format the code properly.


Best regards,
Andreas Hindborg


