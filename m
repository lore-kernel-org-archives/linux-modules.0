Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA122931F1
	for <linux-modules@vger.kernel.org>; Sat, 15 Aug 2026 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786790758; cv=none; b=sMtHYdVGB1GNo49FiZeXDA+uzDleDx+BXYBrOzJdz2WZNKCMPuzwrBXidHBYbFGQl/RRo77/5dirpVHCYlm94ppZf4Jv4vRGrIxqwAzCoaHaZuBg2rSikGBAuvPGqyOX1ZBvslQBykVUe0uzq1stnPpMtlY9RyOh8a7RK9VasxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786790758; c=relaxed/simple;
	bh=QpUm6CVCQQwGrppEIrtM90WDN1gNlvT8gtcLxZ+Uq/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XcCy0N/dmpk4Jph8YLIoNm0ZcE3gq8wU35fzyZ1GUxcTcjRpuC+Bdx7UsNKpc17WMp5q4PLXUhaGlnsHO3BH28j0eywlrLzFwVEbNx+kim/ed1+8KcJL4ZQmfMkxqbY+I0cQNvPPBw/cSHBRpCZ8QevD7jpna2jlnoaSOaSHzHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gN22j3LJ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gN22j3LJ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f7027ca11so1145769f8f.3
        for <linux-modules@vger.kernel.org>; Sat, 15 Aug 2026 03:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786790754; x=1787395554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+i8sSuNGd6mmLHE2UfzLIflavVjmbyhwZK+DDdZURwg=;
        b=gN22j3LJBUgUW4n0mofX+AT+LJQELbhXEDS1l0/wXGMNsbKdVciVghTfKGnJkf3naD
         K7pvf1x2iX1Vjutw/kIRYQBvyOt56GsgvdY1DVrkEVQKzLydmNyo7+yWBEBQGisgxzmo
         NDgU38st9945n/IQlFvDKO5o6eRYD/+f2RxmOURQtlOmilXba18NEcgvEu1YIB1UZJW6
         Nq/wuUfswDbacpzegELdA3WOCJJvFjb++3SWXLgdnEFB4w2H9ddrM0tJ8vC9K8IAT9xx
         wFtc8G4WRM3CTvhi3hm70jnbByQsNOmksuH9oLmbXbHLPvATOtnsAi7P+c9C1J3u74K2
         qhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786790754; x=1787395554;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+i8sSuNGd6mmLHE2UfzLIflavVjmbyhwZK+DDdZURwg=;
        b=CjRe4+v0F3hA9pDZy1e/tOGi/4OPEU0HzHLpzxTgtcksOYIndSLP2rOrK6HrD9lw1X
         FwkdEmmjM3hKBdY+uBmTDGWWtqZr8UVIzZ4p5flK5iKqLF1l1wHa3ST5/KOCsJR5Yr/e
         rro885zy1aqgXCC8uapFoN6cW6mfaCc1BrdtW8bUGfhEnCL4ztpmAlcCzAOEkdj+DPWS
         lVHK0MzdGk2Vv9CEuMY73HMjazB0EYARYTVrCFYuiJ6nkq7CX6cCzAvOBA0XRQkXyew3
         YJqK8bylaUphqSvMokCVpePuomIeFrAgeoZQ3ZQj39Od9y/q/nitRKsIxq7zRU/p7L9x
         RCNQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYwja/E04+hsL/7j+SORWex04XqkViIebakHNhyG25Pmo0damRgUQmvD/zJIiV46pQd+M92oqH1cEY2lZk@vger.kernel.org
X-Gm-Message-State: AOJu0YwZds3wFA2iFu639rx1hptKx731XQ6YxDleCRKCWHj/Ta41Qzrf
	OpG4zhItt8Nm7esFVxTfUmU2aQRc/EOBdh9J1zxqg1UODiR7voJ42G041U0QUec68wc=
X-Gm-Gg: AR+sD134O6Rvkwez2DKvhdjCvbbuUOy4TxLRxhLwMaZSrpF1PpCPGWI9l9DoZ5KonP/
	oWA9ozb9cXTur7hfx0lltBq29Jjan+hFzstPfCTEAntYeHQ6HZL5Yqu0veyoylxIO+J/yfD2aNt
	6giIVzMXcRv9YshaWWeaOLbKS5DiJZo8t/ssjCrZuZTsqZGPEFViUegOIURbXPwQ5fg6Fnn+gAP
	x6mgz96cr1Zx9FTDMTDiD3LY2YBIliKpqdW+Hlj/mw8xWNDKczWxgLst//P3TdIruMGv9jLt316
	ApD9dt6rzgCCiohS9kDMH5TzGem1+/EvSXvSV0zelDGF5uYmzfaFN5ySnkmekeP0T7YD2tZW1Kj
	EKSkNKCBqd/rLW1bKBd6kF0qkxgVmH/VOUB/HmB6fuRisEfdpBui8jXo0dQ1vPZJWmVNspHFsfd
	6ese2kzyIdkfBwLaWvEzCN94/O/P5QqyvubG8tfBxT8zH1a4k/t1hBi0nmIEBeK3Wr+YU14sJhi
	mF3MdCAvQ5JINPAv6slU0wI
X-Received: by 2002:a05:6000:29c2:b0:481:44e5:160c with SMTP id ffacd0b85a97d-48160723ca6mr13951544f8f.2.1786790754104;
        Sat, 15 Aug 2026 03:45:54 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2ccc00sm15346737f8f.35.2026.08.15.03.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2026 03:45:53 -0700 (PDT)
Message-ID: <143a37b5-93a2-4038-8be9-29e13263e743@suse.com>
Date: Sat, 15 Aug 2026 12:45:53 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] alloc_tag: fix undetected compressed tag overflow
 when profiling is disabled
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
References: <20260812054105.102637-1-hao.ge@linux.dev>
 <20260812054105.102637-3-hao.ge@linux.dev>
 <CAJuCfpFvdNFdsKdK2CdF2fNp8gbNgFpoeAiaqp70mpbNGCvk3g@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CAJuCfpFvdNFdsKdK2CdF2fNp8gbNgFpoeAiaqp70mpbNGCvk3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 7:41 AM, Hao Ge wrote:
> In reserve_module_tags(), the tag overflow check is gated on
> mem_alloc_profiling_enabled():
> 
>     if (mem_alloc_profiling_enabled() && !tags_addressable())
> 
> If profiling is toggled off at runtime and a module is loaded whose
> tags exceed the compressed-mode limit, shutdown_mem_profiling() is
> skipped. vm_module_tags_populate() still maps memory for the tags and
> the module loads successfully, but the total tag count now exceeds what
> NR_UNUSED_PAGEFLAG_BITS can address.
> 
> Once profiling is re-enabled, ref_to_idx() computes each tag's index
> as its position in the alloc_tag array. update_page_tag_ref() masks
> it to alloc_tag_ref_mask before storing in page->flags. Indices
> beyond the mask are truncated and idx_to_ref() resolves them to wrong
> tags.
> 
> This silently corrupts /proc/allocinfo: allocated pages get attributed
> to the wrong call sites, so the statistics it reports are wrong.
> 
> mem_alloc_profiling_enabled() and mem_profiling_compressed are
> independent. Once compressed mode is established at boot, it stays
> active regardless of runtime toggles of mem_profiling.
> 
> Remove the mem_alloc_profiling_enabled() guard. On overflow, shut down
> profiling, release the reservation, and return -EAGAIN so that
> layout_and_allocate() retries with profiling disabled: codetag sections
> are then placed as regular module data and the module loads without
> profiling rather than being rejected entirely.

When the described overflow occurs, why should codetag sections be
placed as regular module data? Will the codetag support use them in any
way, or do they simply waste space? Is the issue that alloc_hooks()
creates relocations pointing into .codetag.alloc_tags?

> 
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
> Cc: stable@vger.kernel.org
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  kernel/module/main.c | 25 +++++++++++++++++++++++--
>  mm/alloc_tag.c       |  8 +++++---
>  2 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a605..ed26f167be84 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2944,6 +2944,7 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>  {
>  	struct module *mod;
>  	int err;
> +	unsigned long frob_size[MOD_MEM_NUM_TYPES];

frob_size is used to store values of module_memory::size, which has type
`unsigned int`. The types should match.

>  
>  	/* Allow arches to frob section contents and sizes.  */
>  	err = module_frob_arch_sections(info->hdr, info->sechdrs,
> @@ -2966,18 +2967,38 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>  	 */
>  	module_mark_ro_after_init(info->hdr, info->sechdrs, info->secstrings);
>  
> +	/*
> +	 * Save the sizes reserved by module_frob_arch_sections() so they can
> +	 * be restored if we retry below.
> +	 */
> +	for_each_mod_mem_type(type)
> +		frob_size[type] = info->mod->mem[type].size;
> +
>  	/*
>  	 * Determine total sizes, and put offsets in sh_entsize.  For now
>  	 * this is done generically; there doesn't appear to be any
>  	 * special cases for the architectures.
>  	 */
> +retry:
>  	layout_sections(info->mod, info);
>  	layout_symtab(info->mod, info);
>  
>  	/* Allocate and move to the final place */
>  	err = move_module(info->mod, info);
> -	if (err)
> -		return ERR_PTR(err);
> +	if (err) {
> +		if (err != -EAGAIN)
> +			return ERR_PTR(err);

The move_module() logic is non-trivial. -EAGAIN could be returned by
other code, now or in the future.

> +		/*
> +		 * -EAGAIN means profiling was disabled but the module
> +		 * can still load without it. Reset state and retry.
> +		 */
> +		rewrite_section_headers(info, flags);
> +		for_each_mod_mem_type(type)
> +			info->mod->mem[type].size = frob_size[type];
> +		info->sechdrs[info->index.sym].sh_flags &= ~(unsigned long)SHF_ALLOC;
> +		info->sechdrs[info->index.str].sh_flags &= ~(unsigned long)SHF_ALLOC;

Why is it necessary to reset SHF_ALLOC for .symtab and .strtab here?

> +		goto retry;
> +	}
>  
>  	/* Module has been copied to its final place now: return it. */
>  	mod = (void *)info->sechdrs[info->index.mod].sh_addr;

I'm not sure this is the best approach. It's complex logic for what
appears to be an edge case related to a debugging facility. It will have
the usual problem of error paths not getting enough testing and breaking
subtly over time.

An alternative could be to reset SHF_ALLOC on the codetag section to
remove it from further processing and have relocations that point to
this section resolve to something else. It seems that alloc_hooks_tag()
could tolerate this, since it only needs to reference the associated
alloc_tag when mem_alloc_profiling_enabled() is true and that gets
disabled by reserve_module_tags() on the overflow.

It is also not an ideal approach, but I feel it could be less intrusive
to the module loader. I can put together a prototype if needed.

-- 
Thanks,
Petr
