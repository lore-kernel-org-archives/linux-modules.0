Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BA93AD51D
	for <linux-modules@vger.kernel.org>; Tue,  7 Apr 2026 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561413; cv=none; b=q4D03smPM4gS7fP8+4WBY11IHUi6+sY+xu61D0OYoa83nGr7+NyUsXkwKu7YTV0BJ0P4xTGAIXRsCeN5Qebh7mtIo0aRf5vps3bJ0WbE9EwfNh1keopAdeLV6xhBZ/QGTEz4nPSnqENwOMqLCKoEEIjwiCCLqepLPwb4k1oeJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561413; c=relaxed/simple;
	bh=gJmeGJ4YN8tSj2UwwdnqaAqNbb191sdvW00bw/KMDMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHSm1r83vwZpxiP5gC0yeqvskv04NoR2ZpLTHJ+v4UF/MEn8Trl16gL09Xe8xX5GbSWGKShBgkRfpjr9J5k/O6kc6o86zlcKVXuJURModK3ogQuSLrD0pqM+mSvloclH+5uNTq6viih9NZpZcdBVP2W46N7sEiqWAu7VnO4ZqjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LlgejsTs; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LlgejsTs"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cfac48bc7so2680987f8f.0
        for <linux-modules@vger.kernel.org>; Tue, 07 Apr 2026 04:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775561410; x=1776166210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X0AK+dItOezHrfutn/S86jIfwBt1tYlgVzWPhG3Rkg4=;
        b=LlgejsTsH9VJsNm/3X0MBF7h9YHfSL4diYMLtPfjqUh+JpV3M/Y0wPgN7Y1ctIcwv2
         im0KDa4nk/17sDatAoJzu6p6lyobo6xkj48+5xoDwElSUvwwMoKONYjukr2NLxduW5Wb
         +iltYLAfBzgwtTrOGZKBSMJHqcRVW6TDVpQShQTV27EfvapSBIluxWltwNuz9cqcpQ3i
         SsOi/aySKC0/5Xv+pPdLYyf0yh7JNmJdDTJVWMZ2EZoYF4pMyV5IbO02ahzOPrPKqezQ
         2hS3oEhzVOs69yrWQvLr8Ah6apAMl7QV/heiiKU1KlTUYP1v5y6KfAlpDab3lqldAZxd
         ompA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561410; x=1776166210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0AK+dItOezHrfutn/S86jIfwBt1tYlgVzWPhG3Rkg4=;
        b=eK1+vyLVSVEzd8oJg/2fqsD6pMji1Mp4AcvMkAFaLdiGJgF69bYBU+zuf1cwexRMw8
         z1kgObJzxjmpKi41jHIWSuyw+g3x8F/811sTIx9hOY8NsN9LQBSmRluURmfiN5+ULx5L
         TmWd+s3PaJ60KIH2sdoP7F4FXkyN5WPSfTLMavC/eVGLYA5Sa//bDzLmQvF9zDSTimoH
         Yoylxhu3+875H+U0hCEe4VjU/nOJqXp6yxWy1mqpmPnKKCVw0IFkfnLKC012u/QbWvRA
         /5gghJjC3zsBAxjw+m4EvOlfVtSff/uMjjwZYAw4iKvegGKnbqoFklEhMjOixuW+f8sr
         ZzQg==
X-Forwarded-Encrypted: i=1; AJvYcCWiLE54ZCdl02oKn1IOnAXFdmtMY0hiXxevBrupzO3fKqejl9zPTMmIjcSwmcqpxRq1yBgF5f/gaEP8LLho@vger.kernel.org
X-Gm-Message-State: AOJu0YxVbyFXxoX9uBTNxzpAnDxS2iJwN7MId1LR2+rZtHgtAdNIWxka
	tMUHMqWkciVFLyh23qdUfWdNxNVME5LHz3OskxKFLLyoJB0dMLlmPIjfXtJMYI4RtNg=
X-Gm-Gg: AeBDietMqEcixPTR+x7gnpfV27ES1FCSK3N5sSjH8BXQigxPLd1Mzxh2G3Wo2WX8Hl9
	U5ty8yhfMlPjzftNBvXCJ9fUrVCYCL4oiA2kMm4YKaIed+55/NbjhHc9rUofL1VVT8B1OFFHs2H
	fWAVFAoUpjrdyEQfnH/j+u1OUx5aqGNm8oC1lILqXbUQH2Vg5rbtIhy3VTm/BnNnMwCALJPORB6
	fcxmZW88ROH7IWKFA0AZlWExyC/zk7Cq76xUNAbYfQ51+LuLOpn73fiVSTVQxX5snU+OMkafZGz
	wQgl0Z5S4Cmdkuni8O6dwZHODU7aZh1nDUNkhe5LtJtspBZuQvV4qDqZI/Xgjq1ZIvnaX1xl+qM
	GLFJACqH+s5s5fdF1vgJ2BovWHNbrLCwv8MhiFZx53Qdzuf07gEIu4ofPJyQC5XPv/Xe8lmhdkP
	74dJaPHL4ZfY9d+/iCFn/sraEGvioQbuCfhLYd563doyD8
X-Received: by 2002:a5d:5d0f:0:b0:43d:184:8a9b with SMTP id ffacd0b85a97d-43d2929d8fcmr23481469f8f.16.1775561409975;
        Tue, 07 Apr 2026 04:30:09 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a720dsm49743604f8f.4.2026.04.07.04.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 04:30:09 -0700 (PDT)
Message-ID: <dc3db54f-f95d-46aa-ad84-6258abd13fab@suse.com>
Date: Tue, 7 Apr 2026 13:30:08 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild/btf: Avoid relinking modules when only vmlinux
 changes
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org,
 bpf@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260402141911.1577711-1-petr.pavlu@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260402141911.1577711-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/26 4:17 PM, Petr Pavlu wrote:
> Commit 5f9ae91f7c0d ("kbuild: Build kernel module BTFs if BTF is enabled
> and pahole supports it") in 2020 introduced CONFIG_DEBUG_INFO_BTF_MODULES
> to enable generation of split BTF for kernel modules. This change required
> the %.ko Makefile rule to additionally depend on vmlinux, which is used as
> a base for deduplication. The regular ld_ko_o command executed by the rule
> was then modified to be skipped if only vmlinux changes. This was done by
> introducing a new if_changed_except command and updating the original call
> to '+$(call if_changed_except,ld_ko_o,vmlinux)'.
> 
> Later, commit 214c0eea43b2 ("kbuild: add $(objtree)/ prefix to some
> in-kernel build artifacts") in 2024 updated the rule's reference to vmlinux
> from 'vmlinux' to '$(objtree)/vmlinux'. This accidentally broke the
> previous logic to skip relinking modules if only vmlinux changes. The issue
> is that '$(objtree)' is typically '.' and GNU Make normalizes the resulting
> prerequisite './vmlinux' to just 'vmlinux', while the exclusion logic
> retains the raw './vmlinux'. As a result, if_changed_except doesn't
> correctly filter out vmlinux. Consequently, with
> CONFIG_DEBUG_INFO_BTF_MODULES=y, modules are relinked even if only vmlinux
> changes.
> 
> Additionally, commit 522397d05e7d ("resolve_btfids: Change in-place update
> with raw binary output") in 2025 reworked the method for patching BTF data
> into the resulting modules by using 'objcopy --add-section'. This command
> fails if a section already exists.
> 
> Fix the unnecessary relinking issue by also excluding the normalized form
> 'vmlinux' when invoking ld_ko_o. Adjust embed_btf_data() to first use the
> --remove-section option to remove the patched BTF section if it is already
> present.

I noticed that sorting id+flags in BTF_SET8 by resolve_btfids doesn't
seem to be idempotent, so this requires additional work.

-- Petr
