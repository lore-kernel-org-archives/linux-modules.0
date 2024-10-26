Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAF62CA8
	for <linux-modules@vger.kernel.org>; Sat, 26 Oct 2024 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729929244; cv=none; b=YVLItZwus6xukyibaOea3tK1zCPpEh5aymBkJd0GfSVn6zu3Uam/80S10DIgalNJzjQsX3PFYp/J6w89y5IiimP8wwIZFRPHkLmvsNRqNyAenAWAo124BR9Lo0AajALuBK/h0GkP4Hap0dWIBO4xfUNr2RpndKvEi3TTbnt5wkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729929244; c=relaxed/simple;
	bh=upakk7f+/lmzOtCAYk+1yntDQmPfscU4AkoKNdipNp4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BwL7HS9oVKpddaYUhZkmS2i8giwxzLuhchLeIAnAp8rIVsvs6phvb7OylIF1Tm92wuyQmi2SEHwzJggMtHFQQJT+k++BuC3hcIK7PzxzwVPTiit/HYZ87ka60xtamXIOj0W888OheaCiAIVF5C4zxvlUOLm4Odb3Z/0onVGapOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q1tBhhmv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1tBhhmv"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso27664695e9.0
        for <linux-modules@vger.kernel.org>; Sat, 26 Oct 2024 00:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729929241; x=1730534041; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u2Nb9qNA9UVRm4r/YDsF7whL7+kaI8x9ldnNaLj4KB0=;
        b=Q1tBhhmvwLuvLhIn5NxCRV53OqMj8KHE4HND72LZc6RC03Ien4/QKRb2YT1ZsZAMiq
         qNQN1lLokAuINU9Aqz3r5WuesytITl7LtEpCdQibZcYkhh+3h5iOpplWQvwU9EL+XPUG
         s1WShWTleOQqDtG4HmHNcjENeqH1MAJc9y6uHBtoVjBupi+MStjEIAY+V3kTDsCxhJvh
         qoJsv3Wk2iDTEV89o82vUsJIh6aezoNXBq4mfSb3qEB3qXrHKjo7cweMa8K9EKpzF1JT
         +pWdKoeurviIkr90g7+/kMkUfkWhsA9ZsJKyzT5ujOer5A/qZsMJ7lR1SdPfBbx3MNsR
         5isQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729929241; x=1730534041;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2Nb9qNA9UVRm4r/YDsF7whL7+kaI8x9ldnNaLj4KB0=;
        b=q/kLDp7a6UwUMU7rwxPy3w+/ZIVd50mNnRqPGMXaYz2QE0SoA/SLVm00KvSOhN9+Oj
         srf1PdyjndLBnxZL4GD4WioQayP6cz7HShywgaeoOw9oSuMCIGRUzlZrwwJBXQ58EBnn
         ME7rmumzTL2cqj3wT8oIuDKPld8d9EThFFo6NNEx0o6WTKHOV8lzsrM6iwgAogwEMSaA
         CmnYRohkpdp6nZpIBBxjbJxE7AMc3d/jz/dxbDSLGUm6ExhtH6hFXKsyWjBSvqfFFMc3
         DYEzsm5C4/jrweRUYDbq9Vk0ee9vzANOapO8luFWdfzvua+OcdvHojhE1j3FnZKvlP11
         bE3Q==
X-Gm-Message-State: AOJu0YzJV1hqjWX252cUaAeWrFWMm7d1o6mUBPxQGO8Zuad2wQuoT7Zi
	qm9nUOrIwKFFzV7BkYl4d0kimLOBgUC25ewaLzhQjdGn4kWstezR/CodAuDLFNY=
X-Google-Smtp-Source: AGHT+IHxluWBCuIPi+oMX60lmxOc1cQ3JztqqsmvbPqhJXic3/wyZ8tpE4DOXnksR1UHkP1NDjRJvQ==
X-Received: by 2002:a5d:5cce:0:b0:37d:446a:9e60 with SMTP id ffacd0b85a97d-38060ffe8cbmr1367896f8f.0.1729929240796;
        Sat, 26 Oct 2024 00:54:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935a4ad8sm39723405e9.23.2024.10.26.00.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 00:54:00 -0700 (PDT)
Date: Sat, 26 Oct 2024 10:53:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-modules@vger.kernel.org
Subject: [bug report] alloc_tag: load module tags into separate contiguous
 memory
Message-ID: <50f12fa1-17c1-4940-a6bf-beaf61f6b17a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Suren Baghdasaryan,

Commit e88dfe467aa7 ("alloc_tag: load module tags into separate
contiguous memory") from Oct 23, 2024 (linux-next), leads to the
following Smatch static checker warning:

	kernel/module/main.c:2594 move_module()
	warn: 'dest' isn't an ERR_PTR

kernel/module/main.c
    2554 static int move_module(struct module *mod, struct load_info *info)
    2555 {
    2556         int i;
    2557         enum mod_mem_type t = 0;
    2558         int ret = -ENOMEM;
    2559         bool codetag_section_found = false;
    2560 
    2561         for_each_mod_mem_type(type) {
    2562                 if (!mod->mem[type].size) {
    2563                         mod->mem[type].base = NULL;
    2564                         mod->mem[type].rw_copy = NULL;
    2565                         continue;
    2566                 }
    2567 
    2568                 ret = module_memory_alloc(mod, type);
    2569                 if (ret) {
    2570                         t = type;
    2571                         goto out_err;
    2572                 }
    2573         }
    2574 
    2575         /* Transfer each section which specifies SHF_ALLOC */
    2576         pr_debug("Final section addresses for %s:\n", mod->name);
    2577         for (i = 0; i < info->hdr->e_shnum; i++) {
    2578                 void *dest;
    2579                 Elf_Shdr *shdr = &info->sechdrs[i];
    2580                 const char *sname;
    2581                 unsigned long addr;
    2582 
    2583                 if (!(shdr->sh_flags & SHF_ALLOC))
    2584                         continue;
    2585 
    2586                 sname = info->secstrings + shdr->sh_name;
    2587                 /*
    2588                  * Load codetag sections separately as they might still be used
    2589                  * after module unload.
    2590                  */
    2591                 if (codetag_needs_module_section(mod, sname, shdr->sh_size)) {
    2592                         dest = codetag_alloc_module_section(mod, sname, shdr->sh_size,
    2593                                         arch_mod_section_prepend(mod, i), shdr->sh_addralign);
--> 2594                         if (IS_ERR(dest)) {
    2595                                 ret = PTR_ERR(dest);
    2596                                 goto out_err;
    2597                         }

This is a false positive caused my specific kernel config. The
codetag_alloc_module_section() function returns both error pointers and NULL.
It can return NULL because of the .config, because the section isn't found,
because the size is too small or because the desc.alloc_section_mem() function
isn't implemented (which is a bug).

    2598                         addr = (unsigned long)dest;
    2599                         codetag_section_found = true;
    2600                 } else {
    2601                         enum mod_mem_type type = shdr->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
    2602                         unsigned long offset = shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK;
    2603 
    2604                         addr = (unsigned long)mod->mem[type].base + offset;
    2605                         dest = mod->mem[type].rw_copy + offset;
    2606                 }
    2607 
    2608                 if (shdr->sh_type != SHT_NOBITS) {
    2609                         /*
    2610                          * Our ELF checker already validated this, but let's
    2611                          * be pedantic and make the goal clearer. We actually
    2612                          * end up copying over all modifications made to the
    2613                          * userspace copy of the entire struct module.
    2614                          */
    2615                         if (i == info->index.mod &&
    2616                            (WARN_ON_ONCE(shdr->sh_size != sizeof(struct module)))) {

This handles the case where the size is too small.  Why not return an error
pointer if the section is not found or if there is a bug.  We could also add a
NULL check here.

    2617                                 ret = -ENOEXEC;
    2618                                 goto out_err;
    2619                         }
    2620                         memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
                                        ^^^^^
Dereferenced without testing.

    2621                 }
    2622                 /*
    2623                  * Update the userspace copy's ELF section address to point to
    2624                  * our newly allocated memory as a pure convenience so that
    2625                  * users of info can keep taking advantage and using the newly
    2626                  * minted official memory area.
    2627                  */
    2628                 shdr->sh_addr = addr;
    2629                 pr_debug("\t0x%lx 0x%.8lx %s\n", (long)shdr->sh_addr,
    2630                          (long)shdr->sh_size, info->secstrings + shdr->sh_name);
    2631         }
    2632 
    2633         return 0;
    2634 out_err:
    2635         for (t--; t >= 0; t--)
    2636                 module_memory_free(mod, t);
    2637         if (codetag_section_found)
    2638                 codetag_free_module_sections(mod);
    2639 
    2640         return ret;
    2641 }

regards,
dan carpenter
