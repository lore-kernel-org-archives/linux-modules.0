Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A8717BEC6
	for <linux-modules@vger.kernel.org>; Wed, 28 Aug 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724848533; cv=none; b=tUgIZveuOuDLuYznGVgrQpbn7BftaaJyUk+RbenWQuFVUqSTTnIrxDk2x6u3zvbRL1eg0U9A7xJdj65XLGs2+A0mHsWDRYOZvlTYgfanCqo2hfm+BE8ryG7KlKpycqaoUcsFKgA6gWzfbPF4YErF8IrygI4IIgWMQ4m6KE4Ot/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724848533; c=relaxed/simple;
	bh=aEKzrBbYi9Ry+ohyfsBeblxLDxy0FJBfs72+PMvk3CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqTH/UebJNm5V6IYSIvAa65yNg4OcxHtsmyhukWZU5AmUdvNj29Eb2+rxpiBft2a2451JklnaMYFSp6y9V/nD02po7hMCRfqcRjkqABv7AdU8oV3mQ3L8ivdtQz7BSbFEmCxpNoB7sFsLXgCA5Ir6v7OyLU1+vS0zUo6cwc3UbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VyER4sID; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VyER4sID"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3718eaf4046so4879332f8f.3
        for <linux-modules@vger.kernel.org>; Wed, 28 Aug 2024 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724848530; x=1725453330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pUt4fS45inpztmNIGJYo+GUFk/1UM7umsW/0Hcne0yc=;
        b=VyER4sID8XPVvDMTajQC6Q8MjpdhvmAnngg57GeINNiTY8jixM2Z1ENhwCdMRLhy8E
         2VPyOFxzF9ouqkYQAO0IjgLgulIx7jd93vVdUOEzm9YuqTrjoHVoNgaxVkRKjLPGFUnF
         1pPV0cyOU8RVXiSFexmocPQiT1AZd82dt+M88yUY1eGseyeQaTVDfiUSVi38BpJoGqx9
         48H4AWbs3w5IreBuIa6IvlQE+NXrPG3a3EInA6yKEvtxW4Eq9G7BWoEjdKCvS77sPwZ1
         9ivY0c6d7I6R/js7DMAYp/QLD64yMfXymA4BopiH3rBKGv0GDdOXkqY13sHFI5GLIQe2
         HFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724848530; x=1725453330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUt4fS45inpztmNIGJYo+GUFk/1UM7umsW/0Hcne0yc=;
        b=Wr87LCzOe8/5MLV9Ns65lcytSEXIDbJe6tAdcDustSSQkmiOSbTA9S827diob0Nr0Y
         nluE1QN438r2/JbfamREPQt9tna27c7NMvj0ekGgiYO93N3yMwyR5cae8ExmrRYl0W5n
         d2gK2LRhKdM5Z0MWJ1LiZMjAHLtNNZHNMK8Wj/U1bzoYbpeYKvEFc9U/25g5RUh329Hc
         bnJ9n7HvBVnr8wd6zpMZHOWUQNw25/5v3BV8k7GjmAtfNNCkwrGMtGRej3WVHy9hGg+V
         QsZyLdpcc94h7kLcVpH1L+2LspUqmojAaaQmmL61R+zaUwJNjk6q5dkgqp5vZkmosn/o
         Cghw==
X-Forwarded-Encrypted: i=1; AJvYcCU92g15rfidfem26RtSGUQ9Ktq/BJfBxWBzlRdAmSdtsVSUDXKgaURUQBaM0lNquV/Ew+68R1Z4T8kkvVcS@vger.kernel.org
X-Gm-Message-State: AOJu0YxdjwTc10BzkBPc7LpjOBjl/H6ePhX8GTn4B3kLsOIXlAJBwqhx
	MwcNcTsSVkleg/boWoueczCoLraBC+otNroOhMAN2Y4fzqhQqGCV9mGieR2Jmo4=
X-Google-Smtp-Source: AGHT+IHtoo2WUu3BieUUp3gLp4qf08YKUh5yOQZnaKr6LG3FzOM6CjSzhHpc5du36ZYPkM90Gk3FgQ==
X-Received: by 2002:a5d:46cf:0:b0:371:8e85:c58e with SMTP id ffacd0b85a97d-37311863a3cmr13842070f8f.33.1724848530075;
        Wed, 28 Aug 2024 05:35:30 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549cc55sm241658566b.64.2024.08.28.05.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 05:35:29 -0700 (PDT)
Message-ID: <95db3178-a2ce-421e-8024-afd7fa3359a3@suse.com>
Date: Wed, 28 Aug 2024 14:35:29 +0200
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
 Petr Pavlu <petr.pavlu@suse.com>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
 Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-23-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20240815173903.4172139-23-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/24 19:39, Sami Tolvanen wrote:
> diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
> index 65a29d0bd8f4..71cfab0553da 100644
> --- a/scripts/gendwarfksyms/dwarf.c
> +++ b/scripts/gendwarfksyms/dwarf.c
> @@ -5,6 +5,48 @@
> [...]
> +
> +static bool is_export_symbol(struct state *state, Dwarf_Die *die)
> +{
> +	Dwarf_Die *source = die;
> +	Dwarf_Die origin;
> +
> +	state->sym = NULL;
> +
> +	/* If the DIE has an abstract origin, use it for type information. */
> +	if (get_ref_die_attr(die, DW_AT_abstract_origin, &origin))
> +		source = &origin;
> +
> +	state->sym = symbol_get(get_name(die));
> +
> +	/* Look up using the origin name if there are no matches. */
> +	if (!state->sym && source != die)
> +		state->sym = symbol_get(get_name(source));
> +
> +	state->die = *source;
> +	return !!state->sym;
> +}

Sorry, I don't want to comment much on function names.. but I realized
the name of is_export_symbol() isn't really great. The "is_" prefix
strongly indicates that it is only a query function, yet it changes the
state. It makes its caller process_exported_symbols() hard to understand
on the first read.

-- 
Thanks
Petr
