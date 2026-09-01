Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD9479863
	for <linux-modules@vger.kernel.org>; Tue,  1 Sep 2026 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275065; cv=none; b=K9nQoiWv0/CJrt0jFHe9ZSkZCtKH2RVIRNNFc4Pc6UVGZcz77tFfpt61qDa5RVwXz6GV45wCgJKp6ZDAeNF3bbhGj0QBE/mytkZWe4KzlCL6/Zv6EYlEQaGT0wsZuh5WPSq5RNn6c0SU1xFq8IkRsvpOIU1dcHt7SvXnZSFnWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275065; c=relaxed/simple;
	bh=H/vm3I3DKXFxiC6zoTUJ5T/YttOvqb9FY91jw5Ps2Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGXoxUQr4Nz5TdCUhznMglJIl0pL7RS3UMcvbOQl5xpvv1A9jZUFuqlHhhvc9n1BD2p+aU3UG470CwD0isPJm8cOEEl+5rnqX2iq2lBp3OHnywTeA4oYk8VsRvuZzAvyLW7tkWZkdPh3oxhB+0FoNImMc4pg0lQNttiqWJPNDyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LN2cuoLg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LN2cuoLg"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-484392e3d33so1572901f8f.2
        for <linux-modules@vger.kernel.org>; Tue, 01 Sep 2026 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788275060; x=1788879860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lkEp7cyC+lYty+dlUIhPSdP3TVX1ELsGFG8hQ9Ko+gA=;
        b=LN2cuoLgoy5R7JjQTe3yoL0CB/gZu8OQBMVy/VFp/B6frbdbByFUG3kd/vv81pLuGR
         fcTrFTakWfKaG/hF9z43X8QWDw1HGrBDHdl+8MyrW2PuJlCptUyGJOmZTlTWeBbK05Yc
         LgbO4SCzQ+zc2w5FVhACbG0BXffu1fOASZ+Ufv3WhxC6NXYWWmNGi8pMfzEGQuaXkMEC
         nS8IOpcwtMjKguabL7t0LGytmDcovqw/mhHRdorNkjovJIDbmUtyLHRLpSMLEqtq9H8f
         Y/9EN8maZVo1lEDcDugw+br7cstAmgzhKnvfMVCT2FiwJcT3+NQsBWBteRTHdyxg2slg
         DQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788275060; x=1788879860;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lkEp7cyC+lYty+dlUIhPSdP3TVX1ELsGFG8hQ9Ko+gA=;
        b=iCU30n486u3KO/QwZadZZa0b3sksuuCulzp95oxTYL/yE7WsUydj0U8zx3BTOkOfCf
         Rb3f3eaml7RXyyxlE1grSsVXOHjjVW/2XQEKwWsExBTJw7Bwi1r1q6Nax2jml7kLSznL
         GJ33O8vsqeIw6LfuVTiaRubsmoLbaEd/5sypwam/Y+mNc5iGkvBunD8OpoW/dlq4Vsi6
         R8MSHaaEa92qujVJ0YlLCtQUY5I8U9Ykgo+5Sh6d4c+BsB/VrNPMxulwhegXbym/SpHr
         SHp5JP6PBwG1PahYHbSjCuIypQnOXSZMY9qnhjd2byTIoydY0qExrgR7Ml6iEJwty00g
         dn8g==
X-Forwarded-Encrypted: i=1; AKwUvBxKWFIotb9hS0ov88yBWsBqt7/rNhSE9rT6jIH4Q1iGGjRxfwGxSHOWh/YKkXnlOlKb2DEckyiIgBYhNjvk@vger.kernel.org
X-Gm-Message-State: AFuF++m0KkkqcUAa6mRgEcnnkqvfaQy4D7ngNGEWsTzF8JvPE2uI5Iye
	yxZpXkOYkKIPvh5ckWAQKnrZaXEeDuGPyiMZqXEe8gDDGHb6My211VCudrtERAC6o9U=
X-Gm-Gg: AYBFou1bsVMWYT0F51nu3JUw4iZ763jXMGNS+Si4IGwfjPTNjmgpXah4wChZmngiBGr
	yTL3lOoWgu/yvJcGZ4OU10fA0cZL10Erwapi2/7OAfoDg4rbRG6wqIDFg0agTtbph23WJdj9bxy
	RSlor6SmxmSIWRxcjJY0OWzmzLgJYUszzYZLawYOrehDZvyx5dlw/yDQ3PX9ruu9cWicsXYcKj+
	dpHMZVYoyW94E+SiO9t8Wlr3JeP28ApIjRhdL6bHaUBYvzhS4pRGmXxwXmIk6FYZZrQ/Xg6e3Rw
	xsXLe75+NlPbVvf0nGQgSBmOLUDC6o+9z8a1zUs+Po3Bn0xxzzXNXuJa8jLru5I+iCgiVsg213G
	jWiMODdp47AervOfNRmNyT9uPH3poLHj8igkk17EQjcoWo1mTnRUKfnAVdE+jfu08JFuY3HoAqC
	IRGy25PiOFafI3q/vL0pseTE1aSov4Uk0ZQhqXHOUUuu0Q4jSQv3iLieCdgVpFXC5pQR5QSvkid
	6xStltv6rT0LsLmknFephaZ
X-Received: by 2002:a05:6000:2688:b0:481:5167:abda with SMTP id ffacd0b85a97d-4843fab8ce5mr19406456f8f.9.1788275060332;
        Tue, 01 Sep 2026 08:04:20 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d7e34csm5307482f8f.33.2026.09.01.08.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 08:04:19 -0700 (PDT)
Message-ID: <37eb07db-332c-4da1-a671-6ef1cb753cb3@suse.com>
Date: Tue, 1 Sep 2026 17:04:18 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 2/2] module: allocate codetag sections before the
 regular module layout
To: Hao Ge <hao.ge@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20260831072104.120197-1-hao.ge@linux.dev>
 <20260831072104.120197-3-hao.ge@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260831072104.120197-3-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/26 9:21 AM, Hao Ge wrote:
> Whether a codetag section goes to the codetag region is decided by
> layout_sections() and asked again in move_module(). A concurrent
> load can shut profiling down in between, and move_module() then
> copies the section to offset 0 of its regular destination,
> overwriting whatever is there.
> 
> Decide and allocate in one pass, before the layout. Allocation
> errors fail the load. On a tag area overflow profiling is already
> disabled, so -EAGAIN makes the section fall back to regular module
> data and the module still loads.
> 
> The overflow and populate failure paths of reserve_module_tags() now
> release their reservation instead of leaking the maple tree entry.
> When profiling was toggled off, the overflow check did not run, a
> module could load with more tags than the page flags can address,
> and re-enabling profiling then silently corrupted /proc/allocinfo.
> The check no longer depends on mem_alloc_profiling_enabled().
> 
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Based-on-a-patch-by: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
> Changes against Petr's prototype:
> - allocate_codetag_sections() returns an error instead of void, and
>   only -EAGAIN falls back to a regular section. Any other error now
>   fails the load. The prototype fell back on everything, which can
>   leave live tags in module memory.
> - reserve_module_tags() releases its reservation when populate fails
>   too, that path used to leak the maple tree entry.
> - codetag_free_module_sections() on the move_module() error path uses
>   info->mod, the local mod is assigned only after a successful move.
> - The percpu section is marked only when index.pcpu != 0, otherwise
>   sechdrs[0] gets marked.
> - Dropped the SHF_ALLOC check, .codetag.* sections always have it.
> ---
>  include/linux/module.h   |   2 +
>  kernel/module/internal.h |   4 ++
>  kernel/module/main.c     | 120 ++++++++++++++++++++-------------------
>  mm/alloc_tag.c           |   9 ++-
>  4 files changed, 75 insertions(+), 60 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 7566815fabbe..33548daa31a3 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -325,6 +325,8 @@ enum mod_mem_type {
>  	MOD_INIT_RODATA,
>  
>  	MOD_MEM_NUM_TYPES,
> +
> +	MOD_STANDALONE = -2,
>  	MOD_INVALID = -1,
>  };
>  

It might be better to split this patch into two: the first to introduce
MOD_STANDALONE and use it only for the percpu section, and the second
with all the codetag-related changes.

The introduction of SH_ENTSIZE_STANDALONE should also allow us to clean
up the current resetting of SHF_ALLOC for the percpu section, and now
also for codetag sections. The problem is that find_sec(".data..percpu")
can currently return different results depending on whether it is called
before layout_and_allocate() or later. In addition, apply_relocations()
needs a special case for SH_ENTSIZE_STANDALONE, where it could otherwise
just test SHF_ALLOC.

Instead of resetting SHF_ALLOC for percpu/codetag sections, both
__layout_sections() and move_module() can check for
SH_ENTSIZE_STANDALONE to determine whether a section is handled
specially and should be skipped.

I think it would be useful to include this change in the first patch
introducing MOD_STANDALONE, but I'm also ok with the current version.
I can send a separate patch later to make more use of
SH_ENTSIZE_STANDALONE in this way.

> @@ -2966,18 +2967,23 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>  	 */
>  	module_mark_ro_after_init(info->hdr, info->sechdrs, info->secstrings);
>  
> -	/*
> -	 * Determine total sizes, and put offsets in sh_entsize.  For now
> -	 * this is done generically; there doesn't appear to be any
> -	 * special cases for the architectures.
> -	 */
> +	/* Allow codetag sections to be allocated separately first. */
> +	err = allocate_codetag_sections(info);
> +	if (err) {
> +		codetag_free_module_sections(info->mod);

The usual convention is that functions clean up after themselves on
error. That means this codetag_free_module_sections() call should be
done ideally by allocate_codetag_sections().

-- 
Thanks,
Petr
