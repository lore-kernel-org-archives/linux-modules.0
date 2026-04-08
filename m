Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3B833ADB9
	for <linux-modules@vger.kernel.org>; Wed,  8 Apr 2026 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655808; cv=none; b=tm6w1eEcrAcSYkX6NQLYsB1dto1km0gZJrrYVqPWJRKOE+gxY2HE/Zk6lvhKpGk0km+XUedTy2eQWLA1QBB20xrChAXsRy10jfZe+Fgi3fa5TIKjBLCavk2sl1C9ES9thnk0H5Gigu6JhxbKAfnWInq1qQnUZgA/Tb1DVA8LnpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655808; c=relaxed/simple;
	bh=aGBBqF82BfQwkwgHxlkI1N/8GUQz8/+5w8flepFuzok=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ahr/0vKXgCpC/78fiDRyz9GAtzInCmlC+5gcoW+I0MlWjk5dQ1EHb2dqAiaBYI7qkCaP38KNgRnF6J8eWuuPkvERH+BnOYdVvEDnSX73w4zKfpCZWo8NguGVTZR29oSfMeIXAaKFj8Ko6mhcnMwXq2AoRTggFN8hhKty+GPNNnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PDGxzH+O; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PDGxzH+O"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b0046078so34352605e9.1
        for <linux-modules@vger.kernel.org>; Wed, 08 Apr 2026 06:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775655805; x=1776260605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7oNmpe4d3hv2RrDET86MTy+CkexOZOZ7u5ulEsKdlgw=;
        b=PDGxzH+O+Rmd9SO+r3SuZTpt5hD7GCO6IVZQCDmw8NCkr61pFnu7hgQrGG4i/4zc5m
         ZdYfRDHcoymcWNdVx0kfhUlzspdm1as5UA76jorvvwrR6TNEJ+luZAlSDsU7CA+DpX24
         Zps0ouQ6vfjDYMf9GytYaUIwO6clNWYQa6lyEts63sCt53hwfx5j5sy20jdfEoKhnXw1
         sV1+xx+2qDOiHBJ1v9MMjjAufu+tmDDWy9uhG4/iHjuL42imyzQsQC7YUeqsuiV4f+Wr
         GFaaJbrDymY7WkXxc0SWeHIqFZgfJCZWw4PFwNbczyeSj8/opCfpUG/ETo8JbPRQOx5Q
         EwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775655805; x=1776260605;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7oNmpe4d3hv2RrDET86MTy+CkexOZOZ7u5ulEsKdlgw=;
        b=qjcT+z8ED9tH6Lq079OuRiDK+cYbAKjbGJXv15d2fzL+hihQh0wMUoZDj8pc1yycxj
         X4PYm4eoHqG7zCSoPX2wYYBdnmrDGioquJZl09Q4ajK3n4N2af0adLDw7M3yputwthDb
         5AWzmBcdu/MR2PSnGVTTqQaDoFPVCMJbXLvBc+xTyzJRALzs5Es2RY31ulo+3hvyzZBD
         GljDUn8Vzj+OcKAIEQkUNUNQm6NBHwaQO9lcrJAyTqRjohqBca9/kRKihsKoVvhWlata
         7h3ZsVDH/DXMMjQIGyKQfogS+vfq7N67AvG0Az4HgnWry0n6CDsj82uhtmMshRvRtnPD
         u5qw==
X-Forwarded-Encrypted: i=1; AJvYcCWdRnPtpBCbzIh4rq9Y88zBthUmUFMxG06XxXI4uerm+9JySruqIv3mmh62CrsiUgjLMvDk1tA4wNYjEuIp@vger.kernel.org
X-Gm-Message-State: AOJu0YxMasyLHkVPox2NrOrfteL8satW2eYEElUpiPfJYzxw1m2ejEFG
	vafDYiPQXhZy/uHJAtENVK2hsSsEY18iQtei8/Dh9uqivHkun2EMOBgzGz9bKgWmqtY=
X-Gm-Gg: AeBDieuB3dQKug99/G03aRcgwbkMLBa2l09Lj6dWDmkCIVXLLuekZDy2/De5ThmDNXQ
	GN2UJZfdEg1A08ODYOuDHyA7IfPIkpbMdToyF9cIw0Ea/ddbiRBlWHefjgSgD31Co4m5VWM3SCV
	mPods0/M0Xj77sM8QPhT9V+iXsbcud+OfxiydzYn2EnByTUy6op9FZf4vPblx1jzooXVZsdfTA0
	szjpzMwjtqFpuC1GnYxPk7XO1ZpBIeqNWIXkhySiY+2vQVgh9/GFk5QNywxoI6BsLt3VXcH0IRz
	3kD4O3svGemm2NrM5eXpPjvtSLNEJjt6ybDjCa+iE1kQxgvlrVHJh4FjQgwUJ60ycFKaUdR9fH5
	9sogKQehCSDR1mOscVloiyMUK0W1DzQurL0OrwfQ5hpUScZTuuRgyLcSy4Vp/t9t+fRo1qN83pS
	miyoLuY2+kNA0oqgIbKh9m9QEIFEsSLtUfaD5ljccNKGym+Q8aEIcCImY=
X-Received: by 2002:a05:600c:3b1a:b0:486:fc5f:1ab9 with SMTP id 5b1f17b1804b1-48899775d8emr271551155e9.14.1775655805038;
        Wed, 08 Apr 2026 06:43:25 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e9630ddsm645561325e9.13.2026.04.08.06.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 06:43:24 -0700 (PDT)
Message-ID: <81bee452-f3b9-4a65-a4ee-8a71e8bd265b@suse.com>
Date: Wed, 8 Apr 2026 15:43:23 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild/btf: Avoid relinking modules when only vmlinux
 changes
From: Petr Pavlu <petr.pavlu@suse.com>
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
 <dc3db54f-f95d-46aa-ad84-6258abd13fab@suse.com>
Content-Language: en-US
In-Reply-To: <dc3db54f-f95d-46aa-ad84-6258abd13fab@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/26 1:30 PM, Petr Pavlu wrote:
> On 4/2/26 4:17 PM, Petr Pavlu wrote:
>> Commit 5f9ae91f7c0d ("kbuild: Build kernel module BTFs if BTF is enabled
>> and pahole supports it") in 2020 introduced CONFIG_DEBUG_INFO_BTF_MODULES
>> to enable generation of split BTF for kernel modules. This change required
>> the %.ko Makefile rule to additionally depend on vmlinux, which is used as
>> a base for deduplication. The regular ld_ko_o command executed by the rule
>> was then modified to be skipped if only vmlinux changes. This was done by
>> introducing a new if_changed_except command and updating the original call
>> to '+$(call if_changed_except,ld_ko_o,vmlinux)'.
>>
>> Later, commit 214c0eea43b2 ("kbuild: add $(objtree)/ prefix to some
>> in-kernel build artifacts") in 2024 updated the rule's reference to vmlinux
>> from 'vmlinux' to '$(objtree)/vmlinux'. This accidentally broke the
>> previous logic to skip relinking modules if only vmlinux changes. The issue
>> is that '$(objtree)' is typically '.' and GNU Make normalizes the resulting
>> prerequisite './vmlinux' to just 'vmlinux', while the exclusion logic
>> retains the raw './vmlinux'. As a result, if_changed_except doesn't
>> correctly filter out vmlinux. Consequently, with
>> CONFIG_DEBUG_INFO_BTF_MODULES=y, modules are relinked even if only vmlinux
>> changes.
>>
>> Additionally, commit 522397d05e7d ("resolve_btfids: Change in-place update
>> with raw binary output") in 2025 reworked the method for patching BTF data
>> into the resulting modules by using 'objcopy --add-section'. This command
>> fails if a section already exists.
>>
>> Fix the unnecessary relinking issue by also excluding the normalized form
>> 'vmlinux' when invoking ld_ko_o. Adjust embed_btf_data() to first use the
>> --remove-section option to remove the patched BTF section if it is already
>> present.
> 
> I noticed that sorting id+flags in BTF_SET8 by resolve_btfids doesn't
> seem to be idempotent, so this requires additional work.

It is possible to make sorting id+flags in BTF_SET8 by resolve_btfids
idempotent. One approach would be to also update the offsets (st_value)
of the __BTF_ID__* symbols so that they reflect the result after
sorting.

However, I don't think this is worth doing. Since this logic would be
relevant in specific cases when vmlinux changes and only the BTF data
needs to be regenerated, it would have limited usage and testing.
Importantly, always relinking the modules adds only about 6% to the
rebuild time of the modules target on my system when vmlinux is touched.
The work required for BTF and Makefile processing dominates this target.
When developing the kernel locally, it's common to use a custom config
with a limited amount of modules. In such a case, avoiding the relinking
of modules saves very little.

I plan to instead send a patch to replace the current condition that
invokes ld_ko_o from if_changed_except to if_changed, and remove the
if_changed_except logic.

-- Petr
