Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8537FF54
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525224; cv=none; b=BLVQKXxaNMvI0Vsc+8kwc1eFlLh5ZP92+FRIhg4+MSbjH18lk3JEwmgNYlCJ7Chg1W4kgfn65ZcVGqb6VuBLUhtPzAQh54yPoX0iDIpbkx/6R9u9Z40sXT9BCScQ5S2z0JpVvdURlmhl/eT4AreuSiWtRJemTLlj5mVimEAwXy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525224; c=relaxed/simple;
	bh=/Whx/p+MYkyAuhWrvcq+g0ZZSANbDSWKvfNk40lVm5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzKMQkChQpY70PWlL+/nSR/b7ogPMTKAKsqr6pHV7TYc/6jMploAOzPFH7dpqhRx+mwXpkjClniCgQcvc4YuOfbnZyUomUjJ140vreI63LEDKDRF8ZgyXD5Lxrg/4vEx8alFPEIp9GJmpCLG2pc7U7asFEoONYDcrzIxRoUAbrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q1ZYNlIE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q1ZYNlIE"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-697de23bd7dso1142704a12.1
        for <linux-modules@vger.kernel.org>; Wed, 08 Jul 2026 08:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783525221; x=1784130021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J58VsVzKHLmdYM058MzR59i+EdjdXbLhh5p4a428zoc=;
        b=Q1ZYNlIErlypi6Gk+EnB+S3EogNZyn2Qx6dlrJNtmGxzhs0yq+U+PEPQvRtJCFn3M3
         RTmrSH3fDIsE+kzKbwoc6hmqt7tpYCMErhR48z/fDYgesxTgjcJ24AFRHNVvMTBybRaB
         QlAXpUhSjdLUOhzIooHgcSXxY/z/fk/51g4LOOTwxzgT1QeqGOwHYR0Jwid1k253P51i
         zl9GFbRFYpKSYZmR3Nz90hlgJd3dPus6kPZV8yyTc/ZCoSDNlxMufTlTeSQo24H8qfT8
         AT2ZCyfX014HD8moNikgpzVZ8dppr83MOW+gkI7zjFPRD15RO4rc1YhFWGxwLvOIyE46
         tQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525221; x=1784130021;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J58VsVzKHLmdYM058MzR59i+EdjdXbLhh5p4a428zoc=;
        b=Sk3vSe+rt69QoGUOYTlTl16VHcvZ1rZG9+AF075gM8seTSkB163d+BoXGti3L9TaI/
         YaIKlsG1GH2uZ4XJXEtHfxHdKAImgaBfGQG3iPvUznvyZMigFPcRr/PDtDM7i8fULxMT
         MlC1vFTV3NAsnnt+j7/D2R2u4RY/69+ymeAsS7fxVcbIpape5vmJpUq4rG6EaQ6JNxWi
         sUCBvyYUKw+USarzHTcpbPfSRXxT8yCfTxIM/OIHNf3RWc4cqDoZ7bthRVNrrOLYunC3
         XU64vHMYBKgLwOtMOTLH9dD/bPVRiuK45s5Y9KUmq7OYuAJVQRsxHu4KK7bYC4+yJTlv
         TW/w==
X-Forwarded-Encrypted: i=1; AHgh+RqSTr+KqccsI9XkMGtIijaZjySLIPyMKIxKqT6uTgI9QqnWoNCZjhLBQnSsV4oGkpCNf5qThqUkdDXy2vxa@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxjjn/8w2sb3NYYyk/Xcak9/62kIM1l4jHEKFaDwgyj1SM8+lL
	RWbabpOseEMmfW+oHOLCC7ZvDWkS+ngqEVg+UFPMj12J39xqBAUy/BgwGS1OHhzzMQo=
X-Gm-Gg: AfdE7cnj/tpKB1/iYtH7QcXhL3thUe+otTHnmoKb77I2vWjnHuS7tGd+CRobVd/sp0B
	gYu6Cx78owjWRyUllSSCZh3xLejQ+gply8SFEJhrHFRL4rQDYCubIxjKcwrzV+Z37d6YTrrhesu
	d1ELaw5w8LVqX+gTUFsn3mEMPj5kcZNIwjzTfOr1v3l+wSe/DJgxbRtoYT8oeqHHdGQNldP3/qR
	YMG6nTu2M135r4cAe3+K0MJwJ5kWMl2zegmvTnYZd1u2NXUEQPii+LJX+OuUcE4fOo8c5cih8w4
	9zveQhERoXoOx55iNNhlinWRocoXqlx12DmwsKu2JZHczqYxlivphMrerOKc4oP0hro7QdsDk2x
	pvFXutVysUKivfbCliDjWTugTMY4rc2ILKdgNjLjSOxheU2SE9fCvvDrxxWt4bnUqwjxCFNHi4w
	rQRWgMZBxhDIhmTM83weTD2qVczH1tJ4pSMg==
X-Received: by 2002:a05:6402:3606:b0:698:3b7b:e48e with SMTP id 4fb4d7f45d1cf-69ab44bf73cmr1349570a12.36.1783525221226;
        Wed, 08 Jul 2026 08:40:21 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19d799dfsm9124402a12.17.2026.07.08.08.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 08:40:20 -0700 (PDT)
Message-ID: <33fba1b5-d107-46cd-896f-bd2539a4a0b6@suse.com>
Date: Wed, 8 Jul 2026 17:40:19 +0200
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
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260708012107.1621513-1-tweek@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/8/26 3:21 AM, Thiébaud Weksteen wrote:
> In elf_validity_cache_sechdrs, section sizes and offsets are validated,
> unless the section type is SHT_NULL or SHT_NOBITS.
> 
> Later, elf_validity_cache_secstrings and elf_validity_cache_index_str
> access the section name table (.shstrtab) and symbol string table
> (.strtab) headers without first ensuring that their types are
> SHT_STRTAB. If a section type is SHT_NULL or SHT_NOBITS, sh_offset has
> not been validated and may reference out-of-bounds memory when
> dereferenced in elf_validity_cache_secstrings or
> elf_validity_cache_strtab.
> 
> Validate that both string section headers are of type SHT_STRTAB before
> caching them.

The module loader should normally at least get through the signature and
blacklist checks without crashing due to a corrupted module ELF file.
Failing to validate the offset+size of .shstrtab means the module loader
could crash before the blacklist check, so I believe it is useful to add
this validation.

How did you run into this issue? Was it observed in practice with the
GNU or LLVM toolchain, or with some manually crafted module?

-- 
Thanks,
Petr
