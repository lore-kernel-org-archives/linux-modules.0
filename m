Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB364AEEA;
	Thu, 15 Aug 2024 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750390; cv=none; b=PF0wiIAyLeqJYbFQykvMMnMxiher4Y9Zn9jsKK2C5nerJtv9LwvwXjMNR1HppceQWGhhgYTRNy8n0wCV19tO8mqh3A1XxDu+tQ1UntMhbBhDUHfFwyMB/0ACO43skw8KARqVdx7afRz8fZUVahdVDIwr55PDbAimucHImUXrRYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750390; c=relaxed/simple;
	bh=pG9Aus7iAHYTITJbi1PiXulBDTMcPpokdZ6SGw9ONaA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJJZhxQLQsgoclItj4fccth5Bz3bvUQ3yldT+EQkDXpwYrhar5YFPgKlUXcG+Uk6s+0uDUWa31s/DrQH2+ar/y0mHemmMHI967owhtkAJhKhNDiwX1Ov6AlN0AiYoUTolYS8RgYq/JI9SjGhjeXKJsVOMHmYnVkiUoHBlBzIoBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ScJ/yCNg; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ScJ/yCNg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723750386; x=1724009586;
	bh=KFdR3DG5cPCd+PTqtDNl+zJ8d82n94YIveCGBfC+ylg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ScJ/yCNgl5qXrNnCNiSpp85buhWOjiy4GJSxIFelb6yfFq5Na0DtUskAI/Ifo4BVq
	 aU8U8tgfuFUtKOyc47ueKT152LsX+/odkXcXqzk995dhZFrHh4fFg6G1tPM7VUP4RB
	 sl6Yx9abfmw6wFeg7C/5IEspoqECo4o8Swr+rDjzSSofw0XTKjMFCKC0QSy+4eczEo
	 LMz2Ht+r40a5hN3VDR3TqJID7o0Mx9lUVivO/moniQjDOUBfsUfrnW3U3/SxMqL4Zr
	 xRrX+qYROR1jg+34VaXKGsW9JzOPt2cRFw2mU8x7PjbAiQeHdSKbS0ooi7DMxqj2x6
	 YVy6xgTPf8UmA==
Date: Thu, 15 Aug 2024 19:33:01 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <9853812d-d885-4eef-9ae0-070c5b04e1cd@proton.me>
In-Reply-To: <87ikw2rlbi.fsf@metaspace.dk>
References: <20240705111455.142790-1-nmi@metaspace.dk> <ed2f7416-2631-411d-bb49-5a580dbf51b8@proton.me> <874j84nurn.fsf@metaspace.dk> <f84e9189-b64a-4761-86f5-ccd50fb62f36@proton.me> <87zfpvmd8y.fsf@metaspace.dk> <a98ddf54-3e27-4587-8e49-f19dd1ac65a6@proton.me> <87v80fme7g.fsf@metaspace.dk> <b95cc90a-46ae-44af-90af-0fc374cd381a@proton.me> <87ikw2rlbi.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 4df29f5222843aa59bf26abafcf1b4f518d868f0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.08.24 15:11, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>> On 05.08.24 12:55, Andreas Hindborg wrote:
>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>> On 02.08.24 12:27, Andreas Hindborg wrote:
>>>>> At a higher level where the bindings supply the parsing functions, we
>>>>> can decide that passing an argument without a value yields a default
>>>>> parameter value. C does this for the predefined `bool` type. The
>>>>> predefined integer types does not support omitting the value.
>>>>>
>>>>> This patch only supports the higher level predefined parameter types,
>>>>> and does not allow modules to supply their own parameter parsing
>>>>> functions. None of the types we implement in this patch support passi=
ng
>>>>> the argument without a value. This is intentional to mirror the C
>>>>> implementation.
>>>>>
>>>>> To that end, I removed `NOARG_ALLOWED`, and changed the parsing funct=
ion
>>>>> trait to:
>>>>>
>>>>>     fn try_from_param_arg(arg: &'static [u8]) -> Result<Self>;
>>>>>
>>>>> If/when we start supporting types like `bool` or custom parsing
>>>>> functions provided by the module, we will have to update the signatur=
e
>>>>> to take an `Option` to represent the case where the user passed an
>>>>> argument without a value. However, to mimic C, the function must alwa=
ys
>>>>> return a value if successful, even if the user did not supply a value=
 to
>>>>> the argument.
>>>>>
>>>>> Two different default values are in flight here. 1) the value that th=
e
>>>>> parameter will have before the kernel calls `try_from_param_arg` via
>>>>> `set_param` and 2) the value to return from `try_from_param_arg` if t=
he
>>>>> user did not pass a value with the argument.
>>>>>
>>>>> For a `bool` 1) would usually be `false` and 2) would always be `true=
`.
>>>>>
>>>>> For predefined types the module would not customize 2), but 1) is use=
ful
>>>>> to customize. For custom types where the module supplies the parsing
>>>>> function, 2) would be implicitly given by the module in the parsing
>>>>> function.
>>>>>
>>>>> In this patch set, we only have 1 default value, namely 1). We do not
>>>>> need 2) because we do not support parameters without values.
>>>>
>>>> I am not sure that putting the default value of `my_module.param` into
>>>> the `ModuleParam` trait is a good idea. It feels more correct to me to
>>>> add an optional field to the part in `module!` that can be set to deno=
te
>>>> this default value -- we might also want to change the name of
>>>> `default`, what do you think of `default_inactive` and `default_active=
`?
>>>
>>> For all the predefined parameter types, the module code would never set
>>> the `default_active` value. It should be part of the data parsing
>>> specification for the predefined argument types.
>>
>> So if your module has an i32 parameter, you can't set a default value to
>> eg 1000?
>=20
> You _would_ be able to set the `default_inactive` value, which is the
> value assigned to the static at initialization time. It would make sense
> to default this to 0 for integer types and make it overridable in the
> `module!` macro.

Hmm, I would say it makes more sense to have the user always specify a
default in `module!`, since integers can mean a lot of different things.

> You would not be to set the `default_active` value, which is the value
> assigned to the parameter static variable, when the parameter is passed
> without value. The reason being that we want to mirror C, so we prohibit
> this for predefined integer parameter types.

Gotcha, I wasn't 100% sure in our previous emails if we wanted to
exactly mirror C or not. Should've asked that.
Thanks for taking the time to write this clarification (and the other
ones as well!), I think I now finally understand why you do it this way.
I agree with your approach.

---
Cheers,
Benno

