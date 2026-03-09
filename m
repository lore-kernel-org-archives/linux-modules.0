Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1FD264612
	for <linux-modules@vger.kernel.org>; Mon,  9 Mar 2026 02:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773023265; cv=pass; b=rP2HoeeRVKAvqJHBE5rJrDZd08PIrNj0jK3XWuMDQnYu36crEmFFHVH71/QwtwoLjkSRcYpzpPnvODKrDRckI16aYrd/5Y/yxFQHH/jvKPT009gQ8HKB/YeZpZJ6MVkH+KPXHm3Q7rH4zIcj593oBOgFNJANgQoBeU54WVitSbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773023265; c=relaxed/simple;
	bh=lRhCryaHatFHPppU1xNTY1b3biOzFgcRi3XOIImuU7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h57uVhAhG4cvT9fO//yhORd15zIkIDELuSheWTs0a0QVd93i2Do/iwAECfcml2POA3hExKy2w7cFXqs0ousKszH26w8+X2ezBq/0cBrReuBPCzQBVv7ZwVRm81wE83jg0PUelpE7yt8BlOTFX3Bb7tlrzgxFfBRrgn/Xihhpkk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kA/IM+TA; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kA/IM+TA"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89a09ef1e3aso86772066d6.0
        for <linux-modules@vger.kernel.org>; Sun, 08 Mar 2026 19:27:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773023262; cv=none;
        d=google.com; s=arc-20240605;
        b=Vm0TWFeApiGRDsyBQBzDinChy3mob0nmk50OtcyMW30eIQYYpxzLHu5KphP82dsn9I
         Ihwo4sEG5lgB6Uxn2KAZDTC/g8RFPCJ8u+jR7z74avUJ8ToZUNVZmcxbEE5rLzzyOod/
         apcdLyHE8m8YlYczVSaGgwca/Xz4IXaKvw7ddOrxC4HF4lTnaW+wgAKDwFoSzeEg+FRS
         H0DsUtZf6DTu+FrvKen558T/1XIPmEF+yU8qC3SBlIRYHva9rzjYhhwy17fOhiPpaUf0
         396q/F67pHK98bEMi+EP1cAuKMMbbWdkN4lEtBsW/5W40g4zmmXIsbktrBFbZpv5EFbZ
         nbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s5RU6BCjytPyyzUpkOxs/fzBSSRBzHFkspiRq/z9n8w=;
        fh=KyeIDrHxVXWbB/Rj94r6kADYCJmlskIQlmaTpSBivek=;
        b=Jbhl+dKyjlrBWXqvNyGh7gdH+FRuc/GW+rv/piRFZsgD1VwwjQEtpEDGQvBqeYuMKf
         MY6sZ/MXuymR/B+UoP/UHoOhyXlIEEj6YQl9vIvcQTIsd/gyq9eCFq41eBAVXZSsKXMJ
         SPGvgQ7zvMc2EgnHMSttpuSKdm5j676aJb6GCQHO7ClkxjIwnKH5ru95xP7xS4KeW2Od
         LLHi92o6VQPNnuU99jCMpDBKkGkZooGM9ywv5nlCxl/yRt3y3j8aBuD6gQcrivi64+/J
         lmxvquEtorXCIU0z0nJT9XGmf5EFQOVCXHZ0CbI0tQfoZlMj9YV9UiLBXZfWsT/+6hQ6
         Z1OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773023262; x=1773628062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5RU6BCjytPyyzUpkOxs/fzBSSRBzHFkspiRq/z9n8w=;
        b=kA/IM+TA0Zw61MJCYZbHa6xQkNj5s8fUBBzm/wHAkV+kbJlmPIU6VBLz0c3j5PFrfO
         UyS99Ij8oRlvrNyH62BCYImpMEq/5jfX7Fi6m17pCeHEWzICvmPHokppmshD1lEMZkgt
         cti6CTpfPbt7DndcnMX+bKIgvheOSjp3OtRTHoUKJzLyb2b72hMPA+yKZQiH5IhFRSCI
         lfpyL0sXbdEoaEG4TZvA/tvm/6zTh6viaqDvNNHlvM2NSWa8iUnLHgV3QtUCKwsdK9ZQ
         Ra5voDhGbMT0CCpowlxf2/s7mqOdQnR8F+m5CBNf5409cwd57skdM5z80yQg2+PYVtFA
         Btug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773023262; x=1773628062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s5RU6BCjytPyyzUpkOxs/fzBSSRBzHFkspiRq/z9n8w=;
        b=l76pLdA3jKfYLy27V0zcaT3P8yfR3PgfasdUzzVm1WgesE2ypgE/ilGLeQu4kZoRRY
         Ywu/VI5TFglyeN2ymdACVRPkhtWDr6yIeFkLYoW2pfmitMD0oBNtnknMaRmHRxSLdQV2
         dJF9CnmHcWGV5nAQc307jhZ/wUZSFLwk+JVfL8q5R2ab6wyq6XTusq0TPsxiGZoREsMY
         +D7to6/+RyPBP6/nIo1Y+fBn5GGBVACxOD1PyZD6UlofghdzEnjanBM1cmvMo5yOXZ0L
         IsHH8zB8y+v5XblZOyQFbLsgobZ/f1+7Tv5O1uAk+SFzi3559s3W2Dg8AiM5o7a2CIQ0
         tESA==
X-Forwarded-Encrypted: i=1; AJvYcCV4k8naWtgdQrkvPMUNrRpw+/Y7O/GxsT/yhusqRR8xBTlwFcGyVKMxGtxPRxMeWDu1NV+5IDQky0wcVcOz@vger.kernel.org
X-Gm-Message-State: AOJu0YwvbLuo1nitoZgpWLTMwqGxP2rYAvDqU6DvstH2vQ4WDAD+n9zi
	IZrXVp3A9mj94S/xdqVh3zFe9KDcLRaBfddHkTL6rBfwAfzyuPHVgY8QeNmVtNBjK7AD+moErpp
	/LNKmBFr+MHOLucTt9YPgR/MtUa9xs4c=
X-Gm-Gg: ATEYQzyuPAlW1QGz8DZf/mu+Wpx08AOAPEI0Go0+4LxSaPYyiGb4cNWHrfH7P/oYeL+
	xhIYwO5FLxwO613lneOoyia7OGSwn3wsfAJbiIo1UDDUH+yQx7+9R4EZa8F+Xv1lisIKM5ncYaI
	2SVP0rgvarU4w2e6JSs9v4+m9Vc6IKBckf2/t9uC+Q+ZKHrU3H4Udx3cQw+X2GtBmheaHZW0Cd5
	6aANrEkAlZi7mvAaMSDlVEr0qZ6WgIWhIFcfwC85fruRlOjY4fHcbEQ6SiOSuSVC/sldsSQq4vc
	iV0qLQ==
X-Received: by 2002:a05:6214:d0a:b0:89a:14c5:f4e with SMTP id
 6a1803df08f44-89a30ae1147mr147853306d6.52.1773023262350; Sun, 08 Mar 2026
 19:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226234736.428341-1-thepacketgeek@gmail.com>
 <20260226234736.428341-3-thepacketgeek@gmail.com> <20260306192759.GA1369418@google.com>
In-Reply-To: <20260306192759.GA1369418@google.com>
From: Matthew Wood <thepacketgeek@gmail.com>
Date: Sun, 8 Mar 2026 19:27:31 -0700
X-Gm-Features: AaiRm50InwIKSW37fYXL15ce4Rn0pYRvi00dG_w0G3xAUoq1wgM4o2jZUal9T38
Message-ID: <CADvopva0gqbPPW+DHOEumfCW4e0qn3ZS0=FGNAdpvjQR5iwzZQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] rust: module_param: wire StringParam into the module! macro
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>, David Gow <davidgow@google.com>, 
	=?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 11:28=E2=80=AFAM Sami Tolvanen <samitolvanen@google.=
com> wrote:
>
> On Thu, Feb 26, 2026 at 03:47:28PM -0800, Matthew Wood wrote:
> > +/// Set a string module parameter from a string.
> > +///
> > +/// Similar to [`set_param`] but for [`StringParam`].
> > +///
> > +/// # Safety
> > +///
> > +/// Same requirements as [`set_param`].
> > +unsafe extern "C" fn set_string_param(
> > +    val: *const c_char,
> > +    param: *const bindings::kernel_param,
> > +) -> c_int {
> > +    if val.is_null() {
> > +        crate::pr_warn!("Null pointer passed to `module_param::set_str=
ing_param`");
> > +        return EINVAL.to_errno();
> > +    }
> > +
> > +    crate::error::from_result(|| {
> > +        // SAFETY: val points to a valid C string from the kernel.
> > +        let cstr_param =3D unsafe { StringParam::from_ptr(val) };
> > +
> > +        // SAFETY: By function safety requirements, param.arg points t=
o our SetOnce<StringParam>.
> > +        let container =3D unsafe { &*((*param).__bindgen_anon_1.arg.ca=
st::<SetOnce<StringParam>>()) };
>
> I do realize this matches set_param, and there's a good chance I
> missed something when reading the macros, but doesn't arg actually
> point to ModuleParamAccess<T> here? Since the struct is not repr(C),
> isn't the compiler technically speaking allowed to reorder the
> fields, which means SetOnce<T> might not actually be at offset 0?
>

Hi Sami,

I appreciate the review! This does seem to be an oversight, I'll try
to figure out the
correct implementation. I agree, `repr(C)` is likely needed here.

> > +
> > +        container
> > +            .populate(cstr_param)
> > +            .then_some(0)
> > +            .ok_or(kernel::error::code::EEXIST)
>
> Does this mean the behavior for Rust modules differs from C modules if
> the user specifies multiple instances of the same parameter? I believe
> we just use the last value of the parameter instead of failing in C.
>
> Sami

Yes, I'll fix that, the implementations should match.

Regards,
Mat
