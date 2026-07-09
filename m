Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642903FF1D5
	for <linux-modules@vger.kernel.org>; Thu,  9 Jul 2026 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589022; cv=none; b=Lg1MIi3I4BXZzSZEsgqnzOGyEQ9z1UlbFCVBYXMT6ahCFqj82ZwpVw5ds5Fmz07PsmwiQbsUwkC1JUoV5r600EZ/BUs/HKmO1YIGwrVbsCm+Fwapw9rI6i27BuxYceYOsWgPjwqapUh2q+3GlyWxuJE7ZLYycORlkOCjBJth20I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589022; c=relaxed/simple;
	bh=ugjTvsW7OPBUbId7o5OdCJlPpCtJimKjzsZpUdRwtbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lA34yYzVQ0AMoo8aUo8lJ0IkzqGPJB0I4rCRfcVlBSBM/fG3bckAzIwk0DNeaFxaODuxSsxXJI5gNk8/KU9XJ+BoOoCcvD8emTL71ghHzD0ehe8TeABWNTDqrhtRKDJRTjNy5oIVlWsFrpQpvOGsKmatKg91QhoXsdD8gwWMLUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PkysJBkT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PkysJBkT"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-476d8e647e9so519402f8f.0
        for <linux-modules@vger.kernel.org>; Thu, 09 Jul 2026 02:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783589020; x=1784193820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VTVYBQvEkKaNaBd+wNBZ0176hbApIof794YXIpaDqoc=;
        b=PkysJBkT/2ubq7Rs/W9EvuXitlJ1Wj/zurEHVRefIQpRw76rym0XbCKa56QUN42nfT
         KsximHxCU0sWa4rul/a5MhrADKlEt56rXwyWogJLNLgBzHS4dUt+OLXuz0Q+5MnClX+F
         kAytoKaIGE+UgwPg/zf7ZGzS2BvXxvNBZL6ZJYrWrXHBpESOUgzDgJKPFmAzvMgX7oYM
         X+TH0K1ZgtRG2ARjrWOTHD+MeCjsgiV6ZW3jcsacMynLUXRGkR2xtJq3OQOxe/wwmoJW
         kJrhDHGugkzJ6ZpwLErSu+JutNOklN08uio/N7v0Mb8/h4W/MJ3zdI+gSPZn/FK0CK1J
         Zigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783589020; x=1784193820;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VTVYBQvEkKaNaBd+wNBZ0176hbApIof794YXIpaDqoc=;
        b=m7iAkk+g4L2kAwg94r3EcZKtzBBDtI9+fvRuqTGgFS4APRtvOAPh6uRETtgEPACxHb
         /CLOS5LcdKUVElApY3BxIvjLBuf5M8HQtvScvFrnQ7eKAizNWeJhurYVDVEJG/A9lNVw
         H1j6kC4PCHm8Sp4wiE4a4ru4wRPncfg643E9OqSE0qW00RSW6y3AXkyBEh7bL8BNKRnf
         mr5fTln15sQ2+xODDaDwZO1efLMbWAhy9AQmGzqS6quQb1d5MZgxrrI2dmeDYCf2tf3L
         UR48zHPSSoflP+aVm4+yy3Stap3q4BEonOMl053xBS2Oz9T3abqFqy0xZmJ7eE10NwMr
         xs7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq9ueqV7I5tWDQktEeHo7o70tZAnFN5Aux0uQAMl7u7DhgSYpigIuznkMLFrYPZNfVIVB5DL2H8Xi1cXTab@vger.kernel.org
X-Gm-Message-State: AOJu0YyQtOdwO0CZdYtY0G09RocCc9MdzE+PdCk0I1ZlbV/UuxK4Yh7r
	NtuSntZBJkecjWblyEN6omfVNif7gCFvhPpmiy9+V1Hmt+dk5RvnOig5mf+UoV2CifM=
X-Gm-Gg: AfdE7ck6INOlve+eICVQcECxT4OpLYTFakQ7hRbeWexMZWx5gMt8vHDDEShOwFfMu8r
	J2Im5Oj9ZLksrFPLNClHdxftXnCr8RrfJYS3a9KuPoaS30qiIG7YwDOa3QKVVvUPDg9PcGnK/CS
	xzS6s+y+xVHfhHcWhmtK1VBmjGFTzHGEuppnj0KORO2/Dj/s+w9ufpK0NVt+3dzCAh7nneqrO7w
	08PYnKF1kccC8gfnmZgOV0N2PK1Md2bRO871AlfYvOGta26/CApql6BJ8Jy0XJNfolndQf0AWip
	IslnjS+sH4xrCV4Zw2FYznadCCbTpTfdm1NSGoDAkjWcXhvOdnblKxezSFFYKqdJUKBzzIJ4pjP
	7rcChmKEhc5BhmtWqdhGPhGBdkXeUu3C/OWTOLmfFiQBaOtYsz25MuPz66iB6nu501/s9vEvOjO
	Qlve9F9Yz9gwNvpv8oRcjIQFqxrXCQeBggNw==
X-Received: by 2002:a05:6000:4709:b0:475:f0d1:eb69 with SMTP id ffacd0b85a97d-47df07c5accmr6852609f8f.54.1783589019599;
        Thu, 09 Jul 2026 02:23:39 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d6e4csm47272862f8f.10.2026.07.09.02.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 02:23:39 -0700 (PDT)
Message-ID: <945d18e3-13b8-453b-89fd-05229ab37e96@suse.com>
Date: Thu, 9 Jul 2026 11:23:38 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: validate string table section types
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Siddharth Nayyar <sidnayyar@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260708012107.1621513-1-tweek@google.com>
 <33fba1b5-d107-46cd-896f-bd2539a4a0b6@suse.com>
 <CA+zpnLfpNPoVt8ZrN8AcjNhyYHfB3G-VbykVUNZLjQhsqiP=8g@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CA+zpnLfpNPoVt8ZrN8AcjNhyYHfB3G-VbykVUNZLjQhsqiP=8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/9/26 3:56 AM, Thiébaud Weksteen wrote:
> On Thu, Jul 9, 2026 at 1:40 AM Petr Pavlu <petr.pavlu@suse.com> wrote:
>>
>> On 7/8/26 3:21 AM, Thiébaud Weksteen wrote:
>>> In elf_validity_cache_sechdrs, section sizes and offsets are validated,
>>> unless the section type is SHT_NULL or SHT_NOBITS.
>>>
>>> Later, elf_validity_cache_secstrings and elf_validity_cache_index_str
>>> access the section name table (.shstrtab) and symbol string table
>>> (.strtab) headers without first ensuring that their types are
>>> SHT_STRTAB. If a section type is SHT_NULL or SHT_NOBITS, sh_offset has
>>> not been validated and may reference out-of-bounds memory when
>>> dereferenced in elf_validity_cache_secstrings or
>>> elf_validity_cache_strtab.
>>>
>>> Validate that both string section headers are of type SHT_STRTAB before
>>> caching them.
>>
>> The module loader should normally at least get through the signature and
>> blacklist checks without crashing due to a corrupted module ELF file.
>> Failing to validate the offset+size of .shstrtab means the module loader
>> could crash before the blacklist check, so I believe it is useful to add
>> this validation.
>>
>> How did you run into this issue? Was it observed in practice with the
>> GNU or LLVM toolchain, or with some manually crafted module?
> 
> Thanks for the review Petr. I found the issue while reading the code.
> I am working on a separate commit that reuses some of the ELF parsing
> logic (in a different subsystem, with simpler assertions). I was able
> to confirm with a basic PoC (reusing a valid .ko and replacing the
> type and offset of .shstrtab).

Thanks for the explanation. The change looks ok to me.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr
