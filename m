Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435AB1CB317
	for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695546; cv=none; b=PqI41acDT8YTT6WrJ3ThrthFBpj5cZazyVEPmlwJ9ZA1IUhh5JqDwwI2PzQdoQIioc3ATzoTpohx9TwmZEgLsFvi/FO+bjrr27oW8u8LDNW7WOvQ/kFmg5xBKhFSLZXMKqxmYJXMCmVDmdvN87RsiCSVdLhf7pO4EwyjlztKOHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695546; c=relaxed/simple;
	bh=qVcZMLHwHyQhq7MBDvAiHcGYCqm+ZH0H3VY5fyTsc+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFcqHB5abIthEu0kZF+UZoEnEMs9kdnkmG6rf/LckP7f1u86j0qi2PkD04LBOz3nMNQKZrOkykz8m3bTsTPLV0ci7w9X3KfnCLJAMzaAYx0OtPeaSfu788ZmmECLxZzTcdvT7r2ko0fw1tMbtDpMW74xhE1f8tNXkv7gRt9vleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IjJHcUG7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IjJHcUG7"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9abe139088so149167166b.1
        for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729695542; x=1730300342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QdfhAg7XOG6KB9fpE58iZth2jLApIcWYhDgoIBS8gtw=;
        b=IjJHcUG7cnM+rwPbkfTo+GNQQhH3RCA9s/I9xBEuu+1Ttq8VN4p8jfdaX1fYK9HipZ
         xEB+NgfdClVy1oc4btYQNynlMTUWWBlS1Wuxkn3Y868WX1lWom/g8Lq3LcNdu95BrugC
         6ZAgFLiR5VQf7aEnrZNRV1+nBNAB1Ryq/7zcPllZjCCb/VFwWGODEzVKVXvXNLPrsoQ5
         n3VZ5T0AFKcMMly/TU0iQSd6qi+9s4S27Un6PJiu8WMcH6ej1yqY66LrhzUo8jy5ZHuS
         D0Y5VNehGTcZI/p5E+TVUKgKODIT7d1MPHEehCvxwTX0NdkkP0+sr50aWAzZRWdbXQLr
         hSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729695542; x=1730300342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdfhAg7XOG6KB9fpE58iZth2jLApIcWYhDgoIBS8gtw=;
        b=aZsCT3mereJC13e7DT3prElng+Y4zGTpRy63kd8qC8yIINqOAfSnydXHO/TuhWdleh
         BLQc+yHUofzp1oL1vosah0/aPHjKvwFBm2HMurG/z13roGAXstXGBoVsYoULZs7yHDBP
         xq723rG6vUu1Jy0HGBMHobDjf7vBwTgUJQbA0S8SgISSh6+WBAM95168gRudqJT5b4hm
         X9aUc/unhmSec78kVAlekz6f92FNv8bKfzN6WpKEnZh9WX1qRNZHwP4CLp2k88PVS0sa
         98/rSRSUC91cJoOe6HyuJfeUAHcQsJxtr7CNDBzAti8LvsSINIbEe7/PzKRU9vqv8d4k
         zaow==
X-Forwarded-Encrypted: i=1; AJvYcCVATKN2HRgezcX3D7a2FZw7aDyIEPLD3sx1IeCz4LDLrlDROdxZP/OdvZQr2mTAsWkrXxpZxlVsPx6y/HRk@vger.kernel.org
X-Gm-Message-State: AOJu0YzbqSGgEbZs4WS1dfck0YkbRbztNr6sImKGjRjNV3OacDhcwLOG
	rmRRIdiczwlEI3BivCaEu1udfu1aWJPG4FZig4VDw1bNc4vy3bm41w0jJLPxn94=
X-Google-Smtp-Source: AGHT+IFC1aic+ZWmPBAnotFGoZ7s0fl8OisT/L75WyZvmDcXyVbJaWz0S1S/NSTReRarLlppasFQew==
X-Received: by 2002:a17:906:794c:b0:a9a:4a:284a with SMTP id a640c23a62f3a-a9abf8792bbmr287818566b.26.1729695542525;
        Wed, 23 Oct 2024 07:59:02 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6234sm486571666b.24.2024.10.23.07.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:59:02 -0700 (PDT)
Message-ID: <8017c328-f039-46c3-b472-f203cd6e2cfe@suse.com>
Date: Wed, 23 Oct 2024 16:59:00 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/19] kbuild: Add gendwarfksyms as an alternative to
 genksyms
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
 Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>,
 Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20241008183823.36676-21-samitolvanen@google.com>
 <20241008183823.36676-39-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241008183823.36676-39-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 20:38, Sami Tolvanen wrote:
> When MODVERSIONS is enabled, allow selecting gendwarfksyms as the
> implementation, but default to genksyms.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Acked-by: Neal Gompa <neal@gompa.dev>
> ---
>  kernel/module/Kconfig  | 25 ++++++++++++++++++++++++-
>  scripts/Makefile       |  2 +-
>  scripts/Makefile.build | 39 +++++++++++++++++++++++++++++++--------
>  3 files changed, 56 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index f9e5f82fa88b..e6b2427e5c19 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -169,13 +169,36 @@ config MODVERSIONS
>  	  make them incompatible with the kernel you are running.  If
>  	  unsure, say N.
>  
> +choice
> +	prompt "Module versioning implementation"
> +	depends on MODVERSIONS
> +	default GENKSYMS
> +	help
> +	  Select the tool used to calculate symbol versions for modules.
> +
> +	  If unsure, select GENKSYMS.
> +
> +config GENKSYMS
> +	bool "genksyms (from source code)"
> +	help
> +	  Calculate symbol versions from pre-processed source code using
> +	  genksyms.
> +
> +	  If unsure, say Y.
> +
>  config GENDWARFKSYMS
> -	bool
> +	bool "gendwarfksyms (from debugging information)"
>  	depends on DEBUG_INFO
>  	# Requires full debugging information, split DWARF not supported.
>  	depends on !DEBUG_INFO_REDUCED && !DEBUG_INFO_SPLIT
>  	# Requires ELF object files.
>  	depends on !LTO
> +	help
> +	  Calculate symbol versions from DWARF debugging information using
> +	  gendwarfksyms. Requires DEBUG_INFO to be enabled.
> +
> +	  If unsure, say N.
> +endchoice
>  
>  config ASM_MODVERSIONS
>  	bool
> diff --git a/scripts/Makefile b/scripts/Makefile
> index d7fec46d38c0..8533f4498885 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -53,7 +53,7 @@ hostprogs += unifdef
>  targets += module.lds
>  
>  subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
> -subdir-$(CONFIG_MODVERSIONS) += genksyms
> +subdir-$(CONFIG_GENKSYMS) += genksyms
>  subdir-$(CONFIG_GENDWARFKSYMS) += gendwarfksyms
>  subdir-$(CONFIG_SECURITY_SELINUX) += selinux
>  subdir-$(CONFIG_SECURITY_IPE) += ipe
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 8f423a1faf50..ae13afb71123 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -107,18 +107,28 @@ cmd_cpp_i_c       = $(CPP) $(c_flags) -o $@ $<
>  $(obj)/%.i: $(obj)/%.c FORCE
>  	$(call if_changed_dep,cpp_i_c)
>  
> +gendwarfksyms := scripts/gendwarfksyms/gendwarfksyms
> +getexportsymbols = $(NM) $(1) | sed -n 's/.* __export_symbol_\(.*\)/$(2)/p'
> +
>  genksyms = scripts/genksyms/genksyms		\
>  	$(if $(1), -T $(2))			\
>  	$(if $(KBUILD_PRESERVE), -p)		\
>  	-r $(or $(wildcard $(2:.symtypes=.symref)), /dev/null)
>  
>  # These mirror gensymtypes_S and co below, keep them in synch.
> +ifdef CONFIG_GENDWARFKSYMS
> +symtypes_dep_c = $(obj)/%.o
> +cmd_gensymtypes_c = $(if $(skip_gendwarfksyms),,			\
> +	$(call getexportsymbols,$(2:.symtypes=.o),\1) |			\
> +	$(gendwarfksyms) $(2:.symtypes=.o) $(if $(1), --symtypes $(2)))

Is it possible to pass options to gendwarfksyms that apply to the entire
build, specifically, how can one say to use the --stable option? If not
then I think it would be good to add something as
KBUILD_GENDWARFKSYMS_STABLE (similar to KBUILD_PRESERVE), or maybe
a generic GENDWARFKSYMSFLAGS?

-- 
Thanks,
Petr
