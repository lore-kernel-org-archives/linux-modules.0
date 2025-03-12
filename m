Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D299E14F117
	for <linux-modules@vger.kernel.org>; Wed, 12 Mar 2025 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781127; cv=none; b=lH7JQ10ueQq9GvuJcxm/mld/f+B8X7bvRReZ2bZPH/peCgCdjI+c9MC5bbM26uRhDgy4Pk4e9Vt8xEYt2gQH/CxQbV00JWnG/SX1woclViYNhJZOsx4NNC4yI8AvkDkHlP/kFqkOXXY4P12Sqh6we+Va1GhW2Q+YVCUbUyJpH6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781127; c=relaxed/simple;
	bh=I3eeBWE/LMZynG2czAXHMWKMLPqllq8LervyeDvhne8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMu7JpkJ+gNU93tPhaNchd0Ce0iLEPGFV4noBPIa6u/fXpYr63KB2pl4BZun9DXeamdNTJjm+WjiT1DvB8GFjEAPoyT5MCb0xu5Gxm6KJ2Zj2+mKHmWHeH/gWS+5ndgFl037KZL5TfCEwI5tbeGsjMQSdENBmvgUpA8doUOiTa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c54+rNTD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c54+rNTD"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso39836925e9.0
        for <linux-modules@vger.kernel.org>; Wed, 12 Mar 2025 05:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741781124; x=1742385924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eiqsf0HzzlGLhSgy/0lgckThk5pKGLIU6m9bddwieEo=;
        b=c54+rNTD2YZ/126Mzkmv4B6/hlF8/fHXU4gNKCUKZDDukmMBY6TIkszM0s7QD/EuTp
         ITMvodCW8bffyL8/IHPSPdklQb46wRuAJe5PzYEUsqNN76G3p+q7yxzweSaVr/m52ks2
         bBmDsdmADMSO7w22PguIOq8kXByCeVDwe1MxGEY3oXm+huwfQNdzpzz8mWq1NY8wMuNz
         ML9hXj0x8yAjSRYfrEDdp8Cn7vZK6WmAlFq5DqZvs7UVznBa//M5L0YeW0Q+Oym34geN
         4i6iD8uvAPY4xEfAF1WftGTvpB4NSXd53UOpCCUfvkkST81ekGqrrxhCFMJ6bcXLZ61n
         48gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781124; x=1742385924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiqsf0HzzlGLhSgy/0lgckThk5pKGLIU6m9bddwieEo=;
        b=BDx2Zn9QgNlt2964zwA+Pv8XEiMglAsBMuNk44Eh/iM8Av/rZ7r70C6+e+SlDEwf62
         3vJioJEeN9EKlbCtmnyUq5O3KHOzmg64CyFMDCrvktrxXVoSULtBqu/nG5j/N15oU21s
         o/eVq/dbDDY07REdfzwrpA8W8sy7i6mDAwJkbeQQJEY1bgG7F7c64nLLaDDFdFTvWU2o
         TGCLp4il7v83byE5Fhf0INDFEXDC/zwR3InaNms42d2fxf4nwLyxUEd3PxWRipA+CfEI
         gyaCidt5AqE6JuuiamdzcdD98CF9XTT0LdX6/n0/+LAmOCduiHSnceueoRhQvjN8JuwU
         tgPg==
X-Forwarded-Encrypted: i=1; AJvYcCUE4daZ+ssBsshOzw9gVTMz0l5RmKtsrPXFZ5339etNco9M0KrV6SWKEoaLi6IL0kgy7+/2vKnKXlm6tgWa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw52sOU/eKaWHVGwFxZ53MyxIdNFCctPiu3A2exki/QdClwDeXQ
	UUgJRCouxOj8MfzXPENVnBEZgFFDI+D1lIn6CvpekxsiJZqirqmJIfD7i4IsOcU=
X-Gm-Gg: ASbGnctMHr8fZVF1Q5Bp4kfDRwrrUNCuHKm2QxDwC72hFdVw8Nu5ogV7IBGiswlYPaX
	2ZSKoh9LP8emrbyc+VkT7scYlWFkOlWzn0T0VGSjJUliXd8e82O8at0SbRjWwqg+kkk/0fsWl2T
	NRlLg9e+YVOY8G/558lpz1ThDof0U25AMpqxLqqyPTwYtj+FXftj1BEn3Cvv7LyXHJRYzOI2Irg
	F0RvTf5ja+469JqkrA0+De7kMtOA6DhzBykg25nTV9zMNBpChFg5ToWdIan3xk5liYEdrgS3NQO
	iEt96GioKjycU/pEVxkBF542zAWgTtwyDM7MPoCoIs3qsHZQ
X-Google-Smtp-Source: AGHT+IFf2RijMv0k8lptg1AGDY2v+JyK5+tf/2Ywarp4agmGIrZlKJfK/ANZT3Qn+8OJjIC2rilIDQ==
X-Received: by 2002:a7b:c4d4:0:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-43cf5139abdmr130987575e9.14.1741781124038;
        Wed, 12 Mar 2025 05:05:24 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a74cf8bsm19369895e9.12.2025.03.12.05.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 05:05:23 -0700 (PDT)
Message-ID: <3ad23825-d249-4108-b5c3-693e359fd12e@suse.com>
Date: Wed, 12 Mar 2025 13:05:22 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] module: Make .static_call_sites read-only after
 init
To: Sami Tolvanen <samitolvanen@google.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jason Baron <jbaron@akamai.com>, Daniel Gomez <da.gomez@samsung.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250306131430.7016-1-petr.pavlu@suse.com>
 <20250306131430.7016-4-petr.pavlu@suse.com>
 <481a3ef9-6d4e-4e29-9d50-a6338604c873@csgroup.eu>
 <20250307001256.GA2276503@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250307001256.GA2276503@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/7/25 01:12, Sami Tolvanen wrote:
> On Thu, Mar 06, 2025 at 06:28:58PM +0100, Christophe Leroy wrote:
>> Le 06/03/2025 à 14:13, Petr Pavlu a écrit :
>>> Section .static_call_sites holds data structures that need to be sorted and
>>> processed only at module load time. This initial processing happens in
>>> static_call_add_module(), which is invoked as a callback to the
>>> MODULE_STATE_COMING notification from prepare_coming_module().
>>>
>>> The section is never modified afterwards. Make it therefore read-only after
>>> module initialization to avoid any (non-)accidental modifications.
>>
>> Maybe this suggestion is stupid, I didn't investigate the feasability but:
>> why don't we group everything that is ro_after_init in a single section just
>> like we do in vmlinux ? That would avoid having to add every new possible
>> section in the C code.
>>
>> Like we have in asm-generic/vmlinux.lds.h:
>>
>> #define RO_AFTER_INIT_DATA						\
>> 	. = ALIGN(8);							\
>> 	__start_ro_after_init = .;					\
>> 	*(.data..ro_after_init)						\
>> 	JUMP_TABLE_DATA							\
>> 	STATIC_CALL_DATA						\
>> 	__end_ro_after_init = .;
> 
> I like this idea. Grouping the sections in the module linker script
> feels cleaner than having an array of section names in the code. To be
> fair, I think this code predates v5.10, where scripts/module.lds.S was
> first added.

I agree in principle. I like that the information about ro_after_init
sections for vmlinux and modules would be in the same source form, in
linker scripts. This could eventually allow us to share the definition
of ro_after_init sections between vmlinux and modules.

The problem is however how to find the location of the __jump_table and
static_call_sites data. In vmlinux, as a final binary, they are
annotated with start and end symbols. In modules, as relocatable files,
the approach is to rely on them being separate sections, see function
find_module_sections().

I could add start+end symbols for __jump_table and static_call_sites
data in scripts/module.lds.S and use them by the module loader, but this
would create an inconsistency in how various data is looked up. Another
problem is that I can't find a way to tell the linker to add these
symbols only if the specific data is actually present.

-- 
Cheers,
Petr
