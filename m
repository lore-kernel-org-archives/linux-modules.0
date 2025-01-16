Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3041925A0
	for <linux-modules@vger.kernel.org>; Thu, 16 Jan 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014362; cv=none; b=Gj+J16Im/8HYjDUAkb67nfbcuMGUh9CVC6khoG5r9psw7vWRyuORB38OyMZnjseoJklU6D4ZmdL/1NQRY+yZM7WR/+oco6IHHimxjKFc5c2Wblr0A5vlkuRPLSOifWdpYbVCWFnBY4YLR8vY90jLbO8090tRy3dSSFIPBBqIJws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014362; c=relaxed/simple;
	bh=J2XwIiL4XYVVvcC11VwQC6Q4KQywqA2c2F2DiApgnVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqWO7FYq73MwS/Sh08y4q2Osxvb82kJDwaShCrHBXGC9FSe99yDEk/v1HrADJX8hVSS5XKBfEHVDK5yXH7x/uYEvyVU2HfFpzkCt3gMzulIhsIyRlxj9eZ4/cJbT7MWBCXTLHRnj0UybCOmQNI2yREkQyTLFK6IP5zFFPJa1GUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A971schL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A971schL"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436202dd730so3128635e9.2
        for <linux-modules@vger.kernel.org>; Wed, 15 Jan 2025 23:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737014359; x=1737619159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qs2ifX3pk+mgn6ciIknx54bjB1UYrVSbW++3djKTznw=;
        b=A971schLsBEor8CANwHuUiQY8ynozgJhm+xtchqARzYtfNgxgBgh2l6zGgOIsF8NzZ
         vwr0foLNPJABQ9VBpGptSULOJEc4ESVjnl0BPTB9U2XVqlakYn61lDzurzPPa0UGvDpD
         X/nd0zRduxFSz9zlD3WMH2Zw3nuy/ZWa3phpVQSb/p2mTM4zSd7cCYwkF2QpbwcV/Ib5
         gNuCA55wZVyLgXccNrgSMGo11LwfpwXAQ5fHfwCwhI3Y+vkhAk3+XW01y0kIUFtr8XAb
         5vpc+M/oz2c51J/uBifIQORoHmYOTBCalCpbFj8KsHcYM1dfzCnWhPA8RPI703EyuWiJ
         VQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737014359; x=1737619159;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qs2ifX3pk+mgn6ciIknx54bjB1UYrVSbW++3djKTznw=;
        b=cvzXQWCQKuDPYWQRWWW3fqFux2v3zjt/ekGr3AtP2PiwGp8HIHh6gsTH4uI41XfoVX
         Y7LXVAG9JECqd5Pfay9q7zKro0LUdA9bFjHTGGLHpM1nTj9Fmay3wPq+Duk+zDEwjp1e
         3T76q15uM4iSu5OGQ4aB0Ct2/eQ6kI8AxRH5UUhiDFX9c0q1510eK+KInmIgZ7rCdFiy
         lWzQUrRZizmI4v3l6u9I8wGG6hBcXpAhFYXSQVd/IjNCIF2Zae1O9BLvc2redAgLs1W8
         4Tic2A34PAfA8SJn6ixJ79Bap3z4WQawrbesJUmltABH+7O9u6NV7ftvBrc6IFcN8JJm
         TdoA==
X-Forwarded-Encrypted: i=1; AJvYcCVH2U+cx1/UxsI+1e0WzsZUJ5fhiuZwKZpZi+mfzggjzpfMhRmyLXYkCy+y1d8wd8QAiaL1qpk7u7qd2uKo@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ptKTp8l5Fl8wW3OynbaTsBKjKhVM84psYdrxJCl7ZL8EZO9K
	v+S/tjCp0T3Y2ahuI20RN8plpO1hiQXmU6wEOKizUAoneeozn/ng4ccNpy51Eg==
X-Gm-Gg: ASbGncuJy0kg51H5n2WL5bVJiKuVb37wVxLxMojLw+oydF+Q3bkNuq9/ep9qGvGYVOC
	fZ9tq7e4ZxP7UvrQL0jkX3lK5WBgiUx1DemUl3IqRnQGllutCIN4JWk4TGTvy0sLcyc65Z+Kd3W
	ZTExlunsOCurWSMfgTWX5Qfdq+2+9z64ukfAZwBLNbHe/koHhMZ+n4hGXzYoCQ8iNeExJMkjfhl
	JtzZPcQ9hvxEuvtmLNe4mYWk1IGdqcYK0oTGfY0tmR1AsWFZNYnWIjOrN98N6aDFxyWTeOhe0NY
	xUTSbOEOXb11E/39InvCzvxTWc263a4AiTTEbAR/xA==
X-Google-Smtp-Source: AGHT+IHVozHkMCzrbtLkNrMg5jL+FAcSYQfVVR5k9FWOoQx76/wgrdvd+dlFhJ0P9AyZVS0xdveE0g==
X-Received: by 2002:a05:600c:138d:b0:433:c76d:d57e with SMTP id 5b1f17b1804b1-436e26849f2mr67155315e9.5.1737014358851;
        Wed, 15 Jan 2025 23:59:18 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8124sm19455879f8f.81.2025.01.15.23.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 23:59:18 -0800 (PST)
Message-ID: <16bf04b0-64ad-4614-957e-2971f053949d@suse.com>
Date: Thu, 16 Jan 2025 08:59:17 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unaligned accesses when loading modules
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@samsung.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 Sami Tolvanen <samitolvanen@google.com>
References: <1665d54c-178f-ff72-e627-776e7c76798b@redhat.com>
 <CABCJKud9RCJzVZ2VuTRoaBavOC9bnyTv_W_-AC3mGOy9AY7dWA@mail.gmail.com>
 <aedcb0fd-040b-0dcc-8c28-34a0b07d5a7e@redhat.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <aedcb0fd-040b-0dcc-8c28-34a0b07d5a7e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15.01.2025 19:02, Mikulas Patocka wrote:
> On Tue, 14 Jan 2025, Sami Tolvanen wrote:
>> On Tue, Jan 14, 2025 at 6:07 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>>> On PA-RISC, with the kernel 6.12.9, I get unaligned pointer warnings when
>>> a module is loaded. The warnings are caused by the fact that the
>>> .gnu.linkonce.this_module section is not aligned to the appropriate
>>> boundary. If I dump the module content with "objdump -h configs.ko", I get
>>> this. Note that the .gnu.linkonce.this_module has "File off 000042d2" and
>>> "Algn 2**4".
>>>
>>> On x86-64, the same misalignment can be seen, but it doesn't cause
>>> warnings because unaligned pointers are handled in hardware.
>>>
>>> This seems to be a bug in the linker, because when I compile an old kernel
>>> with a new linker, I also get the misalignment. Do you have an idea how to
>>> work around this bug?
>>
>> Does explicitly specifying section alignment in the module linker
>> script fix this by any chance?
>>
>>> kernel-6.12.9, binutils from Debian ports:
>>> [...]
>>> kernel 6.10, older binutils:
>>
>> Which exact versions of binutils were used here? I don't see the
>> alignment issue with binutils 2.42 on either x86_64 or parisc64, so I
>> assume you're testing with something newer?
>>
>> $ hppa64-linux-gnu-ld.bfd --version
>> GNU ld (GNU Binutils for Debian) 2.42.50.20240625
>>
>> $ hppa64-linux-gnu-objdump -h configs.ko | grep -E '(format|this_module)'
>> configs.ko:     file format elf64-hppa-linux
>>  17 .gnu.linkonce.this_module 00000300  0000000000000000
>> 0000000000000000  00005c50  2**4
>>
>> Sami
> 
> Hi
> 
> I use version "GNU ld (GNU Binutils for Debian) 2.43.50.20250108".
> 
> It was broken in the commit 1f1b5e506bf0d9bffef8525eb9bee19646713eb6 in 
> the binutils-gdb git and partially fixed in the commit 
> d41df13ab36b224a622c0bdf28a96a0dee79db77 - the section is still not 
> aligned at their specified boundary (16), but at least it is aligned on 8 
> bytes, which avoids the warnings.

When you say "broken", can you please explain what it is that is _broken_?
Things have changed, yes, but the produced ELF is - afaict - still within
spec. The "partial fix" as you call it wasn't really a fix, but a band-aid
for some broken consumers of ELF. Plus modpost, being one such example,
was supposedly corrected already (Linux commit 8fe1a63d3d99). Said "partial
fix" was also confirmed to help modpost [1] - are you saying that wasn't
quite true?

Jan

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=32435

> With binutils from git, I no longer see warnings when loading modules, but 
> there are warnings in modpost when compiling the kernel:
> 
> 2025-01-15T17:09:29.408347+01:00 phoebe kernel: handle_unaligned: 2165 callbacks suppressed
> 2025-01-15T17:09:29.408433+01:00 phoebe kernel: modpost(9283): unaligned access to 0xf9096bd5 at ip 0x015d03 (iir 0xf381086)
> 2025-01-15T17:09:29.602490+01:00 phoebe kernel: modpost(9283): unaligned access to 0xf9096bd1 at ip 0x015d07 (iir 0xf301088)
> 2025-01-15T17:09:29.700610+01:00 phoebe kernel: modpost(9283): unaligned access to 0xf9096be9 at ip 0x015d0b (iir 0x4b3c0040)
> 2025-01-15T17:09:29.700653+01:00 phoebe kernel: modpost(9283): unaligned access to 0xf9096bdd at ip 0x015d0f (iir 0x4b240028)
> 2025-01-15T17:09:29.897081+01:00 phoebe kernel: modpost(9283): unaligned access to 0xf9096bd9 at ip 0x015d13 (iir 0x4b270020)
> 
> The affected instructions are in the function do_pci_entry:
>    15d00:       0f 38 10 86     ldw c(r25),r6
>    15d04:       0f 30 10 88     ldw 8(r25),r8
>    15d08:       4b 3c 00 40     ldw 20(r25),ret0
>    15d0c:       4b 24 00 28     ldw 14(r25),r4
>    15d10:       4b 27 00 20     ldw 10(r25),r7
>    15d14:       0f 28 10 89     ldw 4(r25),r9
>    15d18:       82 93 20 e0     cmpb,= r19,r20,15d90 <do_pci_entry+0xcc>
>    15d1c:       0f 20 10 8a     ldw 0(r25),r10
> they happen in the expansion of the macro DEF_FIELD.
> 
> Mikulas

