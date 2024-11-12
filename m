Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4701FC7FC
	for <linux-modules@vger.kernel.org>; Tue, 12 Nov 2024 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422146; cv=none; b=RENRcvD5juk6YTaw6TSW9cm7ZOQrb7W/maRPS89iMmpzEyxvuH4l325THjesmKjBPbquuUOFoPeD/02XKhMPfupn1IbzCJyBrZkkNNDsBvyO0GqWTC4thRu4hJeB0oki3uDsq1UkNHyYiNFnnl8Ncq9gfpwCINRzrQn35TRq1H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422146; c=relaxed/simple;
	bh=1IlveR25fMmS5/QdrDXCjZiS8/dRkNR5bD6tax0zuHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vhrp17ZskIUYMpNhHbSQAkkRHLLiH0qnujazcKj+QWkz/lC1RdfUC7xYbydTLtCg0vXgDANIfoPtvw1xIuavJV0GwzfOtPxIfxo+sC05jCbizSJmJrkMjQdB01LPF6kF32HgA3gJ50D3Be19v3TR/vN5xMHBkrPJ/tBSMQzm3R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HikdT6Nw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HikdT6Nw"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d462c91a9so3591973f8f.2
        for <linux-modules@vger.kernel.org>; Tue, 12 Nov 2024 06:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731422143; x=1732026943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVxaA1z9fT6bwML4eXqw0/GJ56n1cvR8YdBgkVNFYhQ=;
        b=HikdT6NweKqCmBuQKTDtF/+j8J6NbVl+IB1TjX0TAyrnWgkyhN/kqtAsFl/bpHOZFQ
         ZUnc3NWhRj2HMwH2/vV44xLRAuD4vab/KJawkgxAlInsChie1rY3k7Ywrwmq5j1KdbMJ
         doUmSMS2yiZ2nYwRSmOV8QL/C5Q076mJAlcPYPlCLTa2QoH1XPiao+7iCFjuPIkbvH4V
         hC1KkiYsWsXLjsIwElG93OjGJaD1GxdOjZ/z6f40nFMi3Pf05HJRgTdrZcRueJceW2Ny
         zThVPJn2rZToUsN7nwVowhfVSeHKXUeuO/LQBKEt8TYmJ0TFApLUrd6KupkDZRNHcF2x
         H7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731422143; x=1732026943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVxaA1z9fT6bwML4eXqw0/GJ56n1cvR8YdBgkVNFYhQ=;
        b=jJs5N4kJWyC/kZTSwCXz9OA9u0GkrH7V5nggew2mxQy5+Lekb2D73HicpKLefsqHm2
         yuFuNTWTy9qq79Z4YltharoXut1lZRZid7erEM+Glfb/Hrq4qVrtcZQF/I6a1qontY7C
         +w2JXpM2yNcSZ7h0XHoY91MCNIkyy3YR/zpymHv/CZjTpga2YCdx88iDz2NMBCg9fUPg
         MPYu9aB8VGJAElFb3RU5SIaR7acROoD0iliqOruTwg4Pj2P7A13JuXIBRr3mu/Ztt1le
         XvTqmEzKPTUbVADOYxfxKmby5atB+fswYrzyBYajt4FbPvBUu8JY6dMGwY+mp9eq0z9/
         o0Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWYUctVxgytuQ13GJ+hevSirQyKeIXeO4Sq5ze1hoyGjrFqdvbb7CeL93hX4kwTbnUSadoji1Trinm13Kyt@vger.kernel.org
X-Gm-Message-State: AOJu0YzyYEBHfrXpnUGuzGFnbur4ulSYK3+pOYAQM9B4zu0Qes4h4eEs
	e2//cUxq3W9RMDoNWVEEdZewSBCZIe0NaYEmnsF1Dvc6r337jEkvxINhoc8aOewEfmF6prfFVgL
	u
X-Google-Smtp-Source: AGHT+IH3nn1DNyejg0QrIXmlhIVJG/2B1Lgrs9dlmIN9VPOR91QgXKaw3SCiFOYSgglSTBaCrt/cBA==
X-Received: by 2002:a5d:59a3:0:b0:37d:3999:7b4 with SMTP id ffacd0b85a97d-3820811097cmr2114887f8f.17.1731422142732;
        Tue, 12 Nov 2024 06:35:42 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97e46bsm15344100f8f.30.2024.11.12.06.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 06:35:42 -0800 (PST)
Message-ID: <7fdcf601-524b-4530-861d-e4b0f8c1023b@suse.com>
Date: Tue, 12 Nov 2024 15:35:41 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] module: Don't fail module loading when setting
 ro_after_init section RO failed
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
 <CGME20241109103554eucas1p1548e0da57cccb9546a88402f1f5c94be@eucas1p1.samsung.com>
 <164e5f22f8ab59d1d516e3c992efdd9f83ab4819.1731148254.git.christophe.leroy@csgroup.eu>
 <D5HZV4A6SC9A.25U3Q0WUVDJHZ@samsung.com>
 <b74f0845-4916-47eb-945b-eb91ae05fc91@csgroup.eu>
 <D5K3PNXEIKYK.11GZ8BMY02OA4@samsung.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <D5K3PNXEIKYK.11GZ8BMY02OA4@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/12/24 10:43, Daniel Gomez wrote:
> On Mon Nov 11, 2024 at 7:53 PM CET, Christophe Leroy wrote:
>>
>>
>> Le 09/11/2024 à 23:17, Daniel Gomez a écrit :
>>> On Sat Nov 9, 2024 at 11:35 AM CET, Christophe Leroy wrote:
>>>> Once module init has succeded it is too late to cancel loading.
>>>> If setting ro_after_init data section to read-only fails, all we
>>>> can do is to inform the user through a warning.
>>>>
>>>> Reported-by: Thomas Gleixner <tglx@linutronix.de>
>>>> Closes: https://protect2.fireeye.com/v1/url?k=d3deb284-b2a35ac3-d3df39cb-74fe485fff30-288375d7d91e4ad9&q=1&e=701066ca-634d-4525-a77d-1a44451f897a&u=https%3A%2F%2Feur01.safelinks.protection.outlook.com%2F%3Furl%3Dhttps%253A%252F%252Flore.kernel.org%252Fall%252F20230915082126.4187913-1-ruanjinjie%2540huawei.com%252F%26data%3D05%257C02%257Cchristophe.leroy%2540csgroup.eu%257C26b5ca7363e54210439b08dd010c4865%257C8b87af7d86474dc78df45f69a2011bb5%257C0%257C0%257C638667874457200373%257CUnknown%257CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%253D%253D%257C0%257C%257C%257C%26sdata%3DZeJ%252F3%252B2Nx%252FBf%252FWLFEkhxKlDhZk8LNkz0fs%252Fg2xMcOjY%253D%26reserved%3D0
>>>> Fixes: d1909c022173 ("module: Don't ignore errors from set_memory_XX()")
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>> ---
>>>>   kernel/module/main.c | 6 +++---
>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>>> index 2de4ad7af335..1bf4b0db291b 100644
>>>> --- a/kernel/module/main.c
>>>> +++ b/kernel/module/main.c
>>>> @@ -2583,7 +2583,9 @@ static noinline int do_init_module(struct module *mod)
>>>>   #endif
>>>>   	ret = module_enable_rodata_ro_after_init(mod);
>>>>   	if (ret)
>>>> -		goto fail_mutex_unlock;
>>>> +		pr_warn("%s: %s() returned %d, ro_after_init data might still be writable\n",
>>>> +			mod->name, __func__, ret);
>>>> +
>>>>   	mod_tree_remove_init(mod);
>>>>   	module_arch_freeing_init(mod);
>>>>   	for_class_mod_mem_type(type, init) {
>>>> @@ -2622,8 +2624,6 @@ static noinline int do_init_module(struct module *mod)
>>>>   
>>>>   	return 0;
>>>
>>> I think it would make sense to propagate the error. But that would
>>> require changing modprobe.c. What kind of error can we expect when this
>>> happens?
>>
>> AFAIK, on powerpc it fails with EINVAL when
>> - The area is a vmalloc or module area and is a hugepage area
>> - The area is not vmalloc or io register and MMU is not powerpc radix MMU
>>
>> Otherwise it propagates the error from apply_to_existing_page_range(). 
>> IIUC it will return EINVAL when it hits a leaf PTE in upper directories.
> 
> Looking at that path I see we can also fail at __apply_to_page_range()
> -> apply_to_p4d_range() and return with -ENOMEM.
> 
> My proposal was to do something like the change below in modprobe:
> 
> diff --git a/tools/modprobe.c b/tools/modprobe.c
> index ec66e6f..8876e27 100644
> --- a/tools/modprobe.c
> +++ b/tools/modprobe.c
> @@ -572,6 +572,11 @@ static int insmod_insert(struct kmod_module *mod, int flags, const char *extra_o
>                 err = 0;
>         else {
>                 switch (err) {
> +               case -EINVAL:
> +                       ERR("module '%s'inserted: ro_after_init data might"
> +                           "still be writable (see dmesg)\n",
> +                           kmod_module_get_name(mod));
> +                       break;
>                 case -EEXIST:
>                         ERR("could not insert '%s': Module already in kernel\n",
>                             kmod_module_get_name(mod));
> 
> But I think these error codes may be also be reported in other parts
> such as simplify_symbols() so may not be a good idea after all.

It isn't really possible to make a sensible use of the return code from
init_module(), besides some basic check for -EEXIST. The problem is that
any error code from a module's init function is also propagated as
a result from the syscall.

> 
> Maybe we just need to change the default/catch all error message in
> modprobe.c and to indicate/include this case:
> 
> diff --git a/tools/modprobe.c b/tools/modprobe.c
> index ec66e6f..3647d37 100644
> --- a/tools/modprobe.c
> +++ b/tools/modprobe.c
> @@ -582,7 +582,8 @@ static int insmod_insert(struct kmod_module *mod, int flags, const char *extra_o
>                             kmod_module_get_name(mod));
>                         break;
>                 default:
> -                       ERR("could not insert '%s': %s\n", kmod_module_get_name(mod),
> +                       ERR("could not insert '%s' or inserted with error %s, "
> +                           "(see dmesg)\n", kmod_module_get_name(mod),
>                             strerror(-err));
>                         break;
>                 }
> 
> 
>>
>> On other architectures it can be different, I know some architecture try 
>> to split the pages when they hit hugepages and that can fail.
> 
> Is it worth it adding an error code for this case in case we want to
> report it back?

I feel that the proposed kernel warning about this situation is
sufficient and the loader should then return 0 to indicate that the
module got loaded. It would be more confusing to return an error but
with the module actually remaining inserted.

A module loaded without having its RO-after-init section changed
properly to RO is still fully functional. In practice, if this final
set_memory_ro() call fails, the system is already in such a state where
the additional warning is the least of the issues?

-- 
Thanks,
Petr
