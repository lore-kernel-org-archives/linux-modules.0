Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A523DCDBE
	for <linux-modules@vger.kernel.org>; Tue,  5 May 2026 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965990; cv=none; b=U0n5NVCSD4QrWzR4VWx5tU5iLowyPV6tct9EY8TwtuLbTMQ9892VGgM/v0ONS+uyqlAKjUKxIHZ/OK8yiVQNZtt2NaSqc3LKfAzwJDshLmjQJDeFL81tnzGaoovrh/FlWuLG5nF/BY/xpt0o7kgPVSuz/AJF5l9Id/zOJUI3bI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965990; c=relaxed/simple;
	bh=T+wbeQamq/tj3Vv47HHDIJvt1tkICVJb0cnzZ3qBaKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qE8uEjIvckDNxaCgzVTrw3b5bq+4mk2Sy2aEeoQhU1MP2bmgwGO9IjCTSNGcB5MOIB/3nYgdbf6Lj/F+od7SqedUNsM2fKoa653LnGbQ0ur0uWYM9Bje+y8My3BFf9y9/+DGZbfw5M11FILcz1VgdlAPXH4P9TJPOyaQvRdo6Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LEtUayOw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LEtUayOw"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so32468735e9.1
        for <linux-modules@vger.kernel.org>; Tue, 05 May 2026 00:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777965987; x=1778570787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BYyU/gDiNCK3Xl0s772Lu/DkeUvU8mOX4Y8Y+qgk5Zc=;
        b=LEtUayOwIGtxkPnnJYFaxO0GmSQWxek7PD6h+L7rd8gr+ks4FRd7Nm3oqsA44oFKJT
         25rbF798u+uUU9GcAW5/zoKHnU3OD7AR1YIDg9LqFUbh3T4TUj4vhufjcIpZDAiyyDE9
         FoOujVIzYwxEcXoOTuSPYqq4tbmfq4MPLOajkUoFI5ca8Hb61Ymj3v21gnaNKlRGUgJ+
         u68PEWTXhsVsZOX2MF4qEGLSexjqg/1ESDin0MItL+vh3myQVTZ98WiQYH9bg1pqC5mw
         CfJn3zZ8RzNWIWoOiCJ8no5GTtrnt3Wr3gorTOsWkAOcYivOwLh5BRmXAjp6ehTogvh2
         yC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965987; x=1778570787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BYyU/gDiNCK3Xl0s772Lu/DkeUvU8mOX4Y8Y+qgk5Zc=;
        b=L8iZKL/4IXgedRs9Y+FJfIuXe/tRBS1z5jWnmhRKht6wGEhbbh8lP5KZPk6yp4kuiu
         Gq4loNn34gfq1fLkzOSCwJytxlCceFH+pT4fwXDC3IJvCQy6tDFZm1ANLOU2gpmING+w
         33lS/bd5VhRCrlYujQcN7mx7czyEN3DgQB+1WykzMnY3k29MGMmPf/2hCSx7OJ8OPhZG
         7rm++z8wkRYpsAj/Kw8Kv3SkeeZzYcL+pFsOHFzQs43YPC5DR+94MY8qwQ5YvhT7aEgG
         gt6vN5+NAcAYcTyByTKitJpmLPOsnK65nbrz62jQiSh7EZXm89HfrP7j1pKJvsdrKGSZ
         UAsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+1LOCMvtpjG65+4mFTeNxUM0fWKFy3O2LTk2VgKZnVgSWpPH7o4fiQmzGUKk43u498GJ4zYpopuQKOcrf@vger.kernel.org
X-Gm-Message-State: AOJu0YyJzxbEq1TIuSBMgdew26e1a089lPw6Sv4+/a0rOF7ZWVqhip+5
	iCIVFyhnCs5GQSavMa95G6rmlaZpy4cAKfapx2bgfWaK10Vccb2d3sr0gh/tap90M8Y=
X-Gm-Gg: AeBDieulf2molBL+viS1CdSRZQ59phOeMP1SqRzOUbuKTTwlIX5YWNQMh+3XJk5BBMR
	77HXGeKmS6rbnaaMg4Dq2uHFcH6Vog2nHxq8rLohDCT9g4oNiDgM88aOs8PtmkyZRkS/QvcSeXC
	9FSSYpjoA4JrK/ZKTJx4YD3R3h0SrivDfHJyxHYr0UUIS0JNMZjseDdexEqjEPmCMXhoUb22jeK
	mu/4VuNNFpfpybOeLQR25CubViSQcdVUJpOaQa3NrGXUxWhEpn0cRtwafM4BDtFkqYDOqTf8VuY
	Amql7vtM7YziM4sRWuQVWxXkB0GG0DpgV9GrOpqoX4Gkm6YSfGzqsidzSq59fyU3weMEipgu3Pw
	n9uy2M1ggv37EUEZ7WLOgGARvQ6q98HwDSBlTmi3f+Ub8yNieQsgmlSsJmp23LgPRe28EjGiPlE
	wihFdlTVvnSawaJnYNcA4+K7EJbNquyaEFViEUjC7JGAdXULXfJQgUm0s=
X-Received: by 2002:a05:600c:19d4:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-48d1422baefmr38657615e9.2.1777965986739;
        Tue, 05 May 2026 00:26:26 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c8556sm372787885e9.4.2026.05.05.00.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 00:26:26 -0700 (PDT)
Message-ID: <0487a38a-ddb0-4abd-a1f1-fd98551ccb09@suse.com>
Date: Tue, 5 May 2026 09:26:25 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] dyndbg.lds.S: fix lost dyndbg sections in modules
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
References: <20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com>
 <20260502-asm-generic-1-v1-5-1103ee0152df@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260502-asm-generic-1-v1-5-1103ee0152df@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/26 2:05 AM, Jim Cromie wrote:
> Several build configs had problems with __dyndbg* sections getting
> lost in drm drivers.  Fix this by following the model demonstrated in
> codetag.lds.h.
> 
> Introduce include/asm-generic/dyndbg.lds.h, to bundle dynamic-debug's
> multiple sections together, into 2 macros:
> 
> vmlinux.lds.h DATA_DATA: move the 2 BOUNDED_SECTION_BY(__dyndbg*)
> calls into dyndbg.lds.h DYNDBG_SECTIONS(). vmlinux.lds.h now includes
> the new file and calls the new macro.
> 
> MOD_DYNDBG_SECTIONS declares the 2 BOUNDED_SECTION_BY calls, but wraps
> them with output section syntax to keep them as known and separate ELF
> sections in the module.ko.  The KEEP fixes the lost section.
> 
> dyndbg.lds.h includes (reuses) bounded-section.lds.h
> 
> scripts/module.lds.S: now calls MOD_DYNDBG_SECTIONS right before the
> CODETAG macro (consistent with their placements in vmlinux.lds.h), and
> also includes dyndbg.lds.h
> 
> This isolates vmlinux.lds.h from further __dyndbg section additions.
> 
> CC: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
[...]
> diff --git a/include/asm-generic/dyndbg.lds.h b/include/asm-generic/dyndbg.lds.h
> new file mode 100644
> index 000000000000..f95683aa16b6
> --- /dev/null
> +++ b/include/asm-generic/dyndbg.lds.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __ASM_GENERIC_DYNDBG_LDS_H
> +#define __ASM_GENERIC_DYNDBG_LDS_H
> +
> +#include <asm-generic/bounded_sections.lds.h>
> +#define DYNDBG_SECTIONS()					\
> +	. = ALIGN(8);						\
> +	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)			\
> +	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)
> +
> +#define MOD_DYNDBG_SECTIONS()                                           \
> +	__dyndbg : {							\
> +		BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)			\
> +	}								\
> +	__dyndbg_classes : {						\
> +		BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)	\
> +	}

The BOUNDED_SECTION_BY() macro always defines the __start and __end
symbols for the section. This is not ideal for modules because these
symbols are created even when no __dyndbg or __dyndbg_classes input
sections are present. Additionally, they cause MOD_DYNDBG_SECTIONS() to
produce dummy output sections with the same names in all modules, even
when dynamic debug is disabled in the config. This unnecessarily
pollutes the modules. Since modules are relocatable files, the usual
method for locating consolidated data in a module is to read its section
table.

The second problem is that MOD_DYNDBG_SECTIONS() should force the
address of all its output sections to 0. Otherwise, when linking modules
with 'ld.bfd -r', sections defined without an address inherit the
location counter, resulting in non-zero sh_addr values in the resulting
.ko files. Non-zero addresses are confusing in this context, typically
worse compressible, and may cause external tools to misbehave.

-- 
Thanks,
Petr
