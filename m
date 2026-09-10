Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0504485940
	for <linux-modules@vger.kernel.org>; Thu, 10 Sep 2026 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789043413; cv=none; b=aRVNTkrb/0zLrz0P0Rir2TqSzDh88AkHlNEWFVpSuzvGPFe8Ou9G3SSCYTICMtlSym3aB7NM60WfvhvzU9fACsTL3m9rQkSWSA1G5hTnToq2pmudn3a4+nSL3+MB1euBsizNJPQKSLhiUtxo+ZhvZug4Bd9xDtSd/XrPFc4JVQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789043413; c=relaxed/simple;
	bh=8Q0ze4ZDX2GHsiZDFfKXC9i9aMSp57Cl9GGwUJvpLkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGZfsDUJkclHE0xTSnI0X40roTkM6WT/OudyXDYcUg2o2HzhEgtRfnxLoPcslcS6mgBGYSS7+j0LtXIZ7l+0h2J/qj0tp6CUZhysdLU4RwW3M9bQATefoSDz0CHvJ6/p06bMl9gDg8IEC2ayFteHArl0OR/wU/rV/fb1QiizAVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VMD79ML5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VMD79ML5"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4843e397f74so590550f8f.1
        for <linux-modules@vger.kernel.org>; Thu, 10 Sep 2026 05:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789043406; x=1789648206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ARPEqhavuvd4sEo+R5C4AUtofUWM0B/7wgknn65mA9s=;
        b=VMD79ML5yXjolU2L6ZiyyKpEEPErjJGdlOnuiDnq7l2rahcJQfgc6vP9LP2EGfTJWa
         aT2JprphxBNTCh88V74+4xPdrNMM2ndYwqenC4TJrUvGnPE6vyfNiNO9Cv/9RskMPA9+
         jFHNX5w/zemxo19genVp4VuGChmeXGGa19kjbG8Oux3wpPnIG/s8xgHl9NBwGcYNj/gD
         lkRLWFPeQtecihKk9mKRfvMJtNsauW4m5vdpMxuzbJYewV7PAXyaeTjQWx3J8JMyU5XU
         4K12SLdIv59wkClf0Bl8LyY7y1OF/kox6Aug7rLPkBFmQtOHec45+SPKFRBsvbA5S2Jj
         qF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789043406; x=1789648206;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ARPEqhavuvd4sEo+R5C4AUtofUWM0B/7wgknn65mA9s=;
        b=CmtyszZEpVXZBI4tSRHwojrTUe9YrWaxX63yFr4qfudaQTWYW0p/exkRGLOP79cbqT
         QcsIUKkNI5r1R3E3LOrBSPvCt26BceRTf/CZv1kA4v5hpipjOAKWO9W8cJoJRO16wysI
         HX/Yvh0rEHSbCW0sjBD2Sow0+XMNEnd2KkhNGfjn1YZ6uCOqBDXyZg8PFnHoxAPcnGVp
         hjWwH0aBSiiUSL/8QGnX3trHMPczE82W+ersQspuYtLIYUFLic3Qd1Mz/J9kFdIUJmJE
         iDNIdHE46aEkp2YGDxV2HxAoz0eFzFfvQaCgjY7PnyLw34aLfB/M8kd5IqI3R0yL7UXg
         BVQA==
X-Forwarded-Encrypted: i=1; AKwUvBw19inpejfCiJQMAVhdpAnOCXnMnlzsXd2sPxruVX8UFbUIyTltQSR/t+yv+45eOtTDb4/jyburiUk6gdcJ@vger.kernel.org
X-Gm-Message-State: AFuF++kYyDVHz/eTFBksCGsD35gtsVQ0qrw4t9hGSYFNF5Nku4H4ljaj
	vVE3xlyPUe+orLRJyGcH1QdHhLcQoUhzOUWGqsQpr1SwppTL+EOXU9yN+dzoc2znwRY=
X-Gm-Gg: AYBFou0TkXa5lQJqyJXj6QI21fS/Pa61BedVl+fpjnzxwYCk6Wi5sxGj0UH0vdg8IsD
	YVS93o7g7VA5fiGguUhMKo6wBhuP4PyliLZHf++BF4SKxdLg9vT+bypPTy/1S+AVAV6wkocwLc5
	sxR640H5m7pvmvmTD00jqAhriqhYSMu9E0oRVhWzHpSO+Y+C/ncWpD1WK+8LQIlBsgMe+Nx3TPg
	3woNroIVJbU1QuR7YOTsAkOX/zAXrYOVsideNnnLIq+5p/VQzuBEHW89dCldI/9PblUPSP2QLVM
	tzwZD3sJGqkJWDiA7kDFwlqbXQZmMDmwWujCMZjRxq6336S547jYPDwL1gIvns0TpDGvwLqlPHN
	d8ieNWkx1xxNwcSxa5jt+4cSIOJ0fjtwzkUlXL9xkp/g5FpXxfto9kVsToRjEt4TyC8B2SnfBdv
	37wzyVb/nFHFFKn59H9mnNTJrR1KPiTQNOJSvliSTQk9l+hXjTms3EoYYsDsRF4wUncN/S29Kw2
	mVkg5w0FP5H25hzv2VEXDsx3zNqEka25io=
X-Received: by 2002:a05:6000:29cb:b0:485:8df2:6460 with SMTP id ffacd0b85a97d-486e0f776c3mr3738554f8f.20.1789043406106;
        Thu, 10 Sep 2026 05:30:06 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm55987457f8f.25.2026.09.10.05.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 05:30:05 -0700 (PDT)
Message-ID: <65b2a754-c180-42a3-b6fd-f8714804c043@suse.com>
Date: Thu, 10 Sep 2026 14:30:04 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: reject out-of-range relocation target indices
To: Helge Deller <deller@gmx.de>, Karl Mehltretter <kmehltretter@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Ard Biesheuvel <ardb@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-modules@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260908230815.78409-1-kmehltretter@gmail.com>
 <a8f29668-be71-4679-a95d-55dfbd9b5c61@gmx.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <a8f29668-be71-4679-a95d-55dfbd9b5c61@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/26 12:59 PM, Helge Deller wrote:
> On 9/9/26 01:08, Karl Mehltretter wrote:
>> apply_relocations() skips relocation sections whose sh_info target index
>> is outside the section table. ARM, ARM64, LoongArch, PA-RISC and RISC-V
>> use sh_info earlier in module_frob_arch_sections(), before this check.
>>
>> ARM, ARM64, LoongArch and RISC-V use the unchecked index to read
>> sh_flags outside the section header table. PA-RISC uses it to index an
>> e_shnum-sized heap array for a read and an update. QEMU reproduced
>> page-fault Oopses on ARM, ARM64, LoongArch and RISC-V, and a Data TLB
>> miss on the PA-RISC array read.
>>
>> Validate sh_info for SHT_REL and SHT_RELA sections in
>> elf_validity_cache_sechdrs(). Reject the module with ENOEXEC before
>> architecture code can use the index.
>>
>> Fixes: c298be74492b ("parisc: fix module loading failure of large kernel modules")
>> Fixes: 7d485f647c1f ("ARM: 8220/1: allow modules outside of bl range")
>> Fixes: fd045f6cd98e ("arm64: add support for module PLTs")
>> Fixes: ab1ef68e5401 ("RISC-V: Add sections of PLT and GOT for kernel module")
>> Fixes: fcdfe9d22bed ("LoongArch: Add ELF and module support")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
>> ---
>>
>> A custom harness for upstream Frama-C 33.0 (Arsenic) Eva found the
>> ARM32 instance in a source-identical ARM module_frob_arch_sections()
>> slice. Eva reported the out-of-range section-table pointer and sh_flags
>> access.
>>
>> The analysis and ARM32 A/B test ran at Linux b9b3e33b70b7 ("Merge tag
>> 'trace-v7.2-rc6' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace"). The
>> PA-RISC, ARM64, RISC-V, LoongArch and x86_64 A/B tests ran at the
>> declared base commit, 28924df2a08f. arch/arm/kernel/module-plts.c and
>> the touched loop in kernel/module/main.c are identical between the two
>> commits.
>>
>> Each A/B test changed only a relocation section's sh_info to
>> 0x10000000. The same configurations and modules were used before and
>> after the change. All controls loaded before and after the change. The
>> fixed kernels rejected the malformed modules with ENOEXEC.
>>
>> Original-kernel results with QEMU 10.2.1 TCG:
>>
>> - ARM32, virt/Cortex-A15, GCC 15.2.0, multi_v7_defconfig plus
>>    VMSPLIT_2G: page fault at module_frob_arch_sections()+0x160.
>> - ARM64, virt/Cortex-A57, GCC 15.2.0, defconfig: page fault at
>>    module_frob_arch_sections()+0x110.
>> - PA-RISC, B160L, hppa-linux-gcc 8.1.0, binutils 2.30,
>>    generic-32bit_defconfig: Data TLB miss at
>>    module_frob_arch_sections()+0x11c on the stub_entries read for a
>>    counted R_PARISC_PCREL17F relocation.
>> - RISC-V, virt, GCC 15.2.0, defconfig plus RELOCATABLE with
>>    MODULE_SECTIONS enabled: page fault at
>>    module_frob_arch_sections()+0xe4.
>> - LoongArch, virt/LA464, LLVM 21.1.8, loongson64_defconfig: page fault
>>    at module_frob_arch_sections()+0x1b8.
>>
>> On x86_64, which has no vulnerable early sh_info access, the original
>> kernel loaded both modules. The fixed kernel loaded the control and
>> rejected the malformed module with ENOEXEC. The test used pc/qemu64,
>> x86_64_defconfig and GCC 15.2.0.
> 
> Interesting.
> So, this patch helps to prevent loading modules with buggy entries,
> even if the module was e.g. loaded on x86-64 before.
> 
> For me the patch is OK, but it only adds one random sanitizing check,
> and where would we stop to check?

Loading a module should normally at least get through the signature and
blacklist checks without crashing due to a corrupted module ELF file.
After that point, I believe the ELF data should be trusted, similar to
how the actual module code is expected to be correct.

module_frob_arch_sections() is called later in the module-loading
process, after the signature and blacklist checks, so I think this patch
is not strictly necessary.

-- 
Thanks,
Petr
