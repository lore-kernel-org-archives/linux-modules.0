Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A228F3A7F40
	for <linux-modules@vger.kernel.org>; Tue, 26 May 2026 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779780675; cv=none; b=BvsLKPoz6ai0rf1zhcQ9FyyPeFyIGDi8sfHBfVQahrBz5UhWRkpOLp9cxEAFBmFWVZjfu4qXf7jcg05VEzG+uQ9icwTjHKs0EPtUingA4CJorbPLJQpga1M9SxoNg6hibYo9uisfeopVN/3Zs9gO9cf0aB9KzRcbU5OA8ClvGxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779780675; c=relaxed/simple;
	bh=kqpENnTE4wNumutQr2BKy4XgQPNbxnvT/AGbHPYrjQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHKzRC9KTVijOwyiGdtyv2HxsptOXQLJHwxhMdDgRaYBtfDor2dYBxqDDGY4eeJVd/hgu0jGg7MzMypdm5bH6X7CSQjd/+n8NHJiUfUFZp7DREG/TNL9O8M7wWAwkPIEoAGYCHEu9wNvmTozs2KDWT38HEzvySUbOW4m/NdRyFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BPbOYnFG; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BPbOYnFG"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-49068493267so11667485e9.1
        for <linux-modules@vger.kernel.org>; Tue, 26 May 2026 00:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779780672; x=1780385472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ekK3aVvgBJN45Ca6LV8CJRGR8knFXIQZQ0WX8FEULTQ=;
        b=BPbOYnFGlHKBIEmlk+/osM2ZBjef05wjPMfI1mkIn6EHmSMuacLiK4vy96uFYbTBTC
         UJjdUPblKrXGsWOQoIaINOioR8td4wjMpEQJgIAeVAKsT758emz7GIqZHs/ApcFpBbun
         o5tiA7yTNKoOha7fZmLlPx4Bb0e6t5l8GJQ8lEa7z8TLXY/IxzW9365HTfAt+fCp4IG1
         JQ6Ms5A6t6CNBLxl2W9+GFGggk6jScqexY8+x/xNH6tfiGdHT42j2OLXu0WjDoJHnLZH
         CiJnSarOaddId5YTjW3/wt3BAwS09dkvfn9Mdjmg4XbiyJf51+OENpK47dT2exBnWu6B
         /9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779780672; x=1780385472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ekK3aVvgBJN45Ca6LV8CJRGR8knFXIQZQ0WX8FEULTQ=;
        b=eEqQtWW1YPQjqCGhvmx7L6EGyqRLP6Oz/dJGmNtYTqNI4YMmHBFsXmd5sQPkMU/l63
         G+3QXV/n4VHCFIZEpH8Jv3u/H3HSbSx312gScFWCyEaGKLFSXR4gvl/XClR68Be1e5kb
         W2m/BWg/jzU69KQLBwgF1yqTnptvoDyQ1D78t/ZPgpY5TBIUvFlR+yIP7lzgLWaSCYXD
         jOb5Fi0KviXFy8v+0pBCqhnGjkfQATU/E+PzGUPPkturW2qnKdQl/IWy0qEytQCi4wze
         As8n+oiimITr4QTKcHrw6BoaG5BV2Gq7rXrI5vdN6gocykn21uzIrf40RyTjCIK4RAi6
         Q31g==
X-Gm-Message-State: AOJu0YwZ5/lxJPWkMiAXwJ+PiGB4+5Ilbr14ZG1jR9x5QRhaF4PNDM1j
	8dQ/l4aPmX+iyKqCSbeZ17Unh1+312DMJyOmB1GAjcG4vcBj3O+8XixlA4SpfUu6Wvg=
X-Gm-Gg: Acq92OEMq7IkR61r49Xt6Y6zWthIjZncB2XILbrLRoSTy5kNXZzx+mTmAM12tmO4tIE
	3EdozB31HyF5zN20KImjsY3Nd/OcYKYwgEF8XxES1PzzTWaI+fdSUA94iK8cxe+xREGlk21Soil
	FuyBsPWlMbBfvfnR9iLt2QoNhwF4rdo2tC0dCoDzw9dOB7/yyUlD3AAmdb9BevPEV6lR27Hei+H
	gFyvGJ74LU1R/6mIMxbwGVdPGzp1XQ1zUyCh8uZIoOwAFzVuGTvR/5AnIssIr/pvxpxEhByr3vC
	b82C7mfEPNjLxBngrg8uwbeSgycmac00BGPPSkoSEnmxuhKJi0B9oTIC/YSbNhAOE1HcOhppvmt
	bCLByEBNcookwwquuAMnHzfi5HDLlVnLZRM+ENRVvmqmCsw5l+DNwevkocSSEHJgZxRYJvyrQlR
	x1iryGc+QK+9HS1I3CvHyuzFeC/zoP03dxgXmvepf/CjtzMhc/6lxall3O4sTq8BgdQTSqwZ3ux
	YYstyWxc7xA2ZKvzkf4Fhz2c4U+yg/yTEEAahI30FbbKellxuAGnIzRFYqpDIRvEH1pjQ==
X-Received: by 2002:a05:600c:3106:b0:490:6889:1ff with SMTP id 5b1f17b1804b1-4906889025dmr88445605e9.28.1779780671966;
        Tue, 26 May 2026 00:31:11 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0cd5sm371483025e9.10.2026.05.26.00.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 00:31:11 -0700 (PDT)
Message-ID: <a4ac44fa-146b-4b13-bf42-0c8cff601ed2@suse.com>
Date: Tue, 26 May 2026 09:31:11 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: build failure for stablerc
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: linux-modules@vger.kernel.org, linux-kbuild
 <linux-kbuild@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
References: <a47f9124-15b3-4dbc-a211-6161eb98406c@gmx.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <a47f9124-15b3-4dbc-a211-6161eb98406c@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/25/26 9:39 PM, Toralf Förster wrote:
> Hi,
> 
> at a small Hetzner VPS at x86 the compilation of the stablerc v7.0.5-1656-ge79d5c5d57c0 fails under Ubuntu-26.04 with
> 
>  WRAP    arch/x86/include/generated/asm/mmiowb.h
>  WRAP    arch/x86/include/generated/asm/module.lds.h
>  WRAP    arch/x86/include/generated/asm/rwonce.h
>  UPD     include/generated/utsrelease.h
>  CC      /root/linux/tools/objtool/libsubcmd/run-command.o
>  HOSTCC  scripts/gendwarfksyms/gendwarfksyms.o
> In file included from scripts/gendwarfksyms/gendwarfksyms.c:12:
> scripts/gendwarfksyms/gendwarfksyms.h:6:10: fatal error: dwarf.h: No such file or directory
>    6 | #include <dwarf.h>
>      |          ^~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.host:131: scripts/gendwarfksyms/gendwarfksyms.o] Error 1
> make[2]: *** [scripts/Makefile.build:548: scripts/gendwarfksyms] Error 2
> make[1]: *** [/root/linux/Makefile:1325: scripts] Error 2
> make[1]: *** Waiting for unfinished jobs....
>  CC      /root/linux/tools/objtool/libsubcmd/sigchain.o
Gendwarfksyms requires libdw, see Documentation/kbuild/gendwarfksyms.rst
[1]. Is the library and its development files installed on your system?
If you write a trivial program that includes <dwarf.h>, can the compiler
find it in the default search locations?

[1] https://github.com/torvalds/linux/blob/v7.1-rc5/Documentation/kbuild/gendwarfksyms.rst

-- Petr
