Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7C4255231
	for <linux-modules@vger.kernel.org>; Fri,  2 May 2025 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193462; cv=none; b=IULYl+sAiYr4KjvoxAHIqC2/tMAOnSKx5FwHxWqXNJb5BcxHxb1H4iC69v3TvWmfpo/kdVN4R2EP1+vvpS63WnaLbMoAAZpDsBFyQfPZAUZtwlmUSJNO5uhaq00Q7TRkYVl67MI7EFwkXGkvP0Gel5zVMDrapFSYIgUs8WGstjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193462; c=relaxed/simple;
	bh=g1ZgZils+uIGmjH+sJCijkWj58eoAO+5+vhmz54zqng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FOFoXklkmJUA+T6hTDEsf+wxs8vwu5RtGbq0rdcDaV71lXWR5Ad+fHXHVTkgbPahwcDwObsX8WQDjXrCg0YZMgei6D2ZSd3/sacFiYQ13oQBa47/9GQsqXeFZsxWaTZQC9mLoiJVUUnqqXAH4QDxFH2KkBLj1KYZd/awt1VLBmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AtW3CDbY; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AtW3CDbY"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d01024089so12703735e9.1
        for <linux-modules@vger.kernel.org>; Fri, 02 May 2025 06:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746193458; x=1746798258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8vTlnazaQVMThLmfIbwpqp3Xc7k0uu2U7TuS5r4iVAU=;
        b=AtW3CDbYrEwsiz3JvGie3okg4UA6QXDOP91W3KSPhN/+ENd1ZwHeCwXfn+3euhw896
         ICxtn1CH5uPrOTgmKuit2mEWQF027yMJEUxI6Gz8t4fGdWsOTv16vQ9jDvdSMBiP6DXP
         EqTVzk1tnboNkuWF6xbBpzS6sXaC2FbYN4mzHvk55g47GooFHP+ejFvs8RijH6vEfUUn
         yvKSZuSoVVBnUJEPQTv17FcO6SAsceXRPAbTjXkcPTU8U2xn7YMruRTilKxe59itUY8b
         iWgE/MiK4BRpWFQ/xofKUHWWBWmp6gmkwSYoD267WMgnF5LyMdq2oaZoBDSQkPPAMlfW
         QrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746193458; x=1746798258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vTlnazaQVMThLmfIbwpqp3Xc7k0uu2U7TuS5r4iVAU=;
        b=bVLmtEL26oYqt7c2mMdg00as7KfLCXVQL3ymcMFwkKD8zPmdWdo+uXzGqWawZGqEgw
         JLBALgnvoWjndUd9ExVY34bZxYerx7Vc5//HSO6bjJouVIFgo0mayWDoTwwG86WMkEYy
         VxVMXx+6Ct984AOE3P6OrQrOnamJv3HR1NOP+rEuCvKUE+CsLEteBg1IsLH+BHjK0HNI
         VbZuMVZWUbS840zR6J7Wd+j6UqFGkZLUJsKuLdzEe15+44zSumJbKyE8kS+xyz9geXKX
         N1tm0fuHVN/9wFEb+1EN7jVnUQ/4182V+97SfAoAXBApOTg0MjUlGkiMNpJrMOn3Qpou
         8LWw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9Glq2h3Eo9t4lcIFYdBC053nKU9b/dNc1Re2DRVH8DXNcOYvVxN37Rfpla7w32W/dSarv/61AieJevGZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk8TAYfUEsPj62ybd+EXzEi+8RhihFRVQBLceZNOnN6twThFnz
	TnSrpMIC3Jrq8d8AbXCfAHGy6lPBUWdMJiKtM9FR0M9H3vsD5+0S0pxBxo2pMN+/NTkPIqJP4+m
	wCweVVfdduhGDOQ==
X-Google-Smtp-Source: AGHT+IEEgU9nO8+UD2Pb7fL6yoFx+ADY8fhoKwXwvYxRbDyw/NOtlc4poFHnBmyLm0nVuIh4YARc+RWwPkJd+/E=
X-Received: from wmbbe6.prod.google.com ([2002:a05:600c:1e86:b0:440:5d4e:87])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1da6:b0:43d:fa59:be39 with SMTP id 5b1f17b1804b1-441bbf38afemr24834895e9.33.1746193458263;
 Fri, 02 May 2025 06:44:18 -0700 (PDT)
Date: Fri, 2 May 2025 13:44:16 +0000
In-Reply-To: <20250502-module-params-v3-v11-2-6096875a2b78@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250502-module-params-v3-v11-0-6096875a2b78@kernel.org> <20250502-module-params-v3-v11-2-6096875a2b78@kernel.org>
Message-ID: <aBTMMHWNXS7wK7zS@google.com>
Subject: Re: [PATCH v11 2/3] rust: add parameter support to the `module!` macro
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Trevor Gross <tmgross@umich.edu>, 
	Adam Bratschi-Kaye <ark.email@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Greg KH <gregkh@linuxfoundation.org>, Fiona Behrens <me@kloenk.dev>, 
	Daniel Almeida <daniel.almeida@collabora.com>, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, May 02, 2025 at 02:16:35PM +0200, Andreas Hindborg wrote:
> Add support for module parameters to the `module!` macro. Implement read
> only support for integer types without `sysfs` support.
> 
> Acked-by: Petr Pavlu <petr.pavlu@suse.com> # from modules perspective
> Tested-by: Daniel Gomez <da.gomez@samsung.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

> +unsafe extern "C" fn set_param<T>(
> +    val: *const kernel::ffi::c_char,
> +    param: *const crate::bindings::kernel_param,
> +) -> core::ffi::c_int
> +where
> +    T: ModuleParam,
> +{
> +    // NOTE: If we start supporting arguments without values, val _is_ allowed
> +    // to be null here.
> +    if val.is_null() {
> +        // TODO: Use pr_warn_once available.
> +        crate::pr_warn!("Null pointer passed to `module_param::set_param`");
> +        return EINVAL.to_errno();
> +    }
> +
> +    // SAFETY: By function safety requirement, val is non-null and
> +    // null-terminated. By C API contract, `val` is live and valid for reads
> +    // for the duration of this function.
> +    let arg = unsafe { CStr::from_char_ptr(val) };
> +
> +    crate::error::from_result(|| {
> +        let new_value = T::try_from_param_arg(arg)?;
> +
> +        // SAFETY: `param` is guaranteed to be valid by C API contract
> +        // and `arg` is guaranteed to point to an instance of `T`.
> +        let old_value = unsafe { (*param).__bindgen_anon_1.arg as *mut T };
> +
> +        // SAFETY: `old_value` is valid for writes, as we have exclusive
> +        // access. `old_value` is pointing to an initialized static, and
> +        // so it is properly initialized.
> +        unsafe { core::ptr::replace(old_value, new_value) };

You don't use the return value of this, so this is equivalent to
unsafe { *old_value = new_value };

> +macro_rules! make_param_ops {
> +    ($ops:ident, $ty:ty) => {
> +        ///
> +        /// Static [`kernel_param_ops`](srctree/include/linux/moduleparam.h)
> +        /// struct generated by `make_param_ops`
> +        #[doc = concat!("for [`", stringify!($ty), "`].")]
> +        pub static $ops: $crate::bindings::kernel_param_ops = $crate::bindings::kernel_param_ops {
> +            flags: 0,
> +            set: Some(set_param::<$ty>),
> +            get: None,
> +            free: Some(free::<$ty>),

You could potentially only include `free` if
`core::mem::needs_drop::<T>()` as an optimization.

> +    fn emit_params(&mut self, info: &ModuleInfo) {
> +        let Some(params) = &info.params else {
> +            return;
> +        };
> +
> +        for param in params {
> +            let ops = param_ops_path(&param.ptype);
> +
> +            // Note: The spelling of these fields is dictated by the user space
> +            // tool `modinfo`.
> +            self.emit_param("parmtype", &param.name, &param.ptype);
> +            self.emit_param("parm", &param.name, &param.description);
> +
> +            write!(
> +                self.param_buffer,
> +                "
> +                    pub(crate) static {param_name}:
> +                        ::kernel::module_param::ModuleParamAccess<{param_type}> =
> +                            ::kernel::module_param::ModuleParamAccess::new({param_default});

Is this global accessible to the user? It would be a use-after-free to
access it during module teardown. For example, what if I access this
static during its own destructor? Or during the destructor of another
module parameter?

Alice
