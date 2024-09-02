Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAA21C32F2
	for <linux-modules@vger.kernel.org>; Mon,  2 Sep 2024 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270734; cv=none; b=btbVZ3acoyBxSJ9HrntqfD6e2Ul1bqkmB9aXDeM+L5VEIXCaidln3EjkpjtBhsS9srFamglxBMoBYdlJmIHOlom56p15DoUHafmQFO5qiqSTLJV/VrjSGdAFKMH7HW3sh8Bfr9tda6R5s27bC7cYiXQOqPqD8N/rdfGlvsvomIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270734; c=relaxed/simple;
	bh=Y3286RFIN/qanbnIGpLD1sy9reDUKmRfsP0fszQnG2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAPMpmhAGegLW4aFNCFLG0eXpQq+J8cq5I09RNMWMqb3Hn7MImg2TBenG6vYSgRNuEz5QOZuOJiaiKWfef1uT7NJLX/wTmoil+KGQv8byiMuXr8eTawTKwVMRJ8UEvvCmoYGuk7Z9JHWU1139SoHv8YnUugMmBvsLyPEj0DVyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HACGL+ST; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HACGL+ST"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5343eeb4973so6107073e87.2
        for <linux-modules@vger.kernel.org>; Mon, 02 Sep 2024 02:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725270730; x=1725875530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yx8BEfb/mnbcgYtxco8Iy/KiPiqDzvW3Qbyqerwej2A=;
        b=HACGL+STIeP144wMpOhb48Z6YNQigumPtmMYXzA2vs7mIqbLKjZMDSxucgaZ6BEIht
         oREQMtSTR1K04lndTwRN5oiF+/c3nI6Yc28H6sV6uLlyQHrQcVId8lvLDIKwA3MvQCl8
         YIRLSAwTDsaUBs41rB/VxAEZBDZWNqGdV8EYUHF1nxEoufHgfdflEesEU2MxhY4HWzDN
         D5MMz9LILoHP9fIsIZve237SOigbmLoWmcGJU9j54TRT1D433FfgNR1D18Dm/A8/4Xzh
         k/3sMykomZ/At4HWniqfBYJjn71IrOymgAz1y8thK+IZs8cloTW0b2dC5Z30AAerec/Z
         KVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725270730; x=1725875530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yx8BEfb/mnbcgYtxco8Iy/KiPiqDzvW3Qbyqerwej2A=;
        b=Vzg3Ol9xsuFQP57TeZ9T7TLdjWClWQb0KTdhp8iWcd6PpYOSmI7LC2FqFqE69bNJ4P
         zhpcMCjfIvNJCXwF6mBRF3BpRKfiF7piizDOvEh5HSH1F4wJ1OSLW+xY7YzPrgyg5O1x
         TDUSOFTtE3EL18wgsGQ+pBeHPGkZyI+BT7Gl1oyG0U/ovgsXzjtqsr+4hSsNdY7MHnAR
         POAfroUNOBvmze98Whe5etHMYP7ANx4ybWYhrRPssa6LUbHZuzliO+xXWpuasioSHisa
         ezC/eTm0JWADv9i333d1uD3nZ2oc0SWNzkTeeCslm58GR+U4QZkARxw7zJsW84IB384M
         I3IA==
X-Forwarded-Encrypted: i=1; AJvYcCWAe9pFrMq28/dctMOEuKuLncgS5vBWsk7YlTRODMP/h6G7vEygn27mhBdMQt/pGlAkjSkx6M4EHA71bzF9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Wm9BdZZjUBiFxXdC8oyirmdVPudXMnNetHKlyzaFOi9OvL/y
	GBMqtttbWhF5lPkGGtt+G5v78oPbBHAGX6FM79ZPVLUQYntsYoUUNCbFSjOazZY=
X-Google-Smtp-Source: AGHT+IFsKjRAuLVJClwA0Nrt/yFrgmXM54r0gk3+x482UZ6mR7qGdsUfVkQo6Wdbf5SvREoe7xnxYQ==
X-Received: by 2002:a05:6512:3c9e:b0:52c:deb9:904b with SMTP id 2adb3069b0e04-53546bde550mr7411628e87.38.1725270730406;
        Mon, 02 Sep 2024 02:52:10 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892333a0sm530996466b.220.2024.09.02.02.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 02:52:10 -0700 (PDT)
Message-ID: <1c7d9094-c893-4423-822c-4ec33ae06d1b@suse.com>
Date: Mon, 2 Sep 2024 11:52:08 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/19] gendwarfksyms: Add symbol list handling
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>,
 Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
 Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-23-samitolvanen@google.com>
 <95db3178-a2ce-421e-8024-afd7fa3359a3@suse.com>
 <20240828230919.GI2130480@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20240828230919.GI2130480@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/24 01:09, Sami Tolvanen wrote:
> On Wed, Aug 28, 2024 at 02:35:29PM +0200, Petr Pavlu wrote:
>> On 8/15/24 19:39, Sami Tolvanen wrote:
>>> diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
>>> index 65a29d0bd8f4..71cfab0553da 100644
>>> --- a/scripts/gendwarfksyms/dwarf.c
>>> +++ b/scripts/gendwarfksyms/dwarf.c
>>> @@ -5,6 +5,48 @@
>>> [...]
>>> +
>>> +static bool is_export_symbol(struct state *state, Dwarf_Die *die)
>>> +{
>>> +	Dwarf_Die *source = die;
>>> +	Dwarf_Die origin;
>>> +
>>> +	state->sym = NULL;
>>> +
>>> +	/* If the DIE has an abstract origin, use it for type information. */
>>> +	if (get_ref_die_attr(die, DW_AT_abstract_origin, &origin))
>>> +		source = &origin;
>>> +
>>> +	state->sym = symbol_get(get_name(die));
>>> +
>>> +	/* Look up using the origin name if there are no matches. */
>>> +	if (!state->sym && source != die)
>>> +		state->sym = symbol_get(get_name(source));
>>> +
>>> +	state->die = *source;
>>> +	return !!state->sym;
>>> +}
>>
>> Sorry, I don't want to comment much on function names.. but I realized
>> the name of is_export_symbol() isn't really great. The "is_" prefix
>> strongly indicates that it is only a query function, yet it changes the
>> state. It makes its caller process_exported_symbols() hard to understand
>> on the first read.
> 
> I see your point. How would you make this more obvious? get_ doesn't
> seem entirely accurate either. match_ perhaps?

Looks reasonable to me.

-- 
Thanks,
Petr
