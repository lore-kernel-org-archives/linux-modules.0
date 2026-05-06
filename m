Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10913E317D
	for <linux-modules@vger.kernel.org>; Wed,  6 May 2026 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057906; cv=none; b=ONarFztX004sTN+ygmrfcFT6J4QkjGuLFkgIIAJBymBT0mES0FiM4cPyfSlupBIA433hRwSMJLdV4py+EH1nZYSxCkXuJ1yV1mc4V95RVIaWtVlXBUMiPgU5hELEJNe5ExDOmRLxOwYHLGVVgtYeBWjoph7WehP7CLt4yUtbg1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057906; c=relaxed/simple;
	bh=2ql1LwdlEFefyEoDGprmept9lrBe1j+xp7imDDXxwOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTJ7svH5+wu6jFHpi13jK21BvKmh8paMtWfgSUSxtpOgslnfuu/EvsoFzGpwqOjaRR20l3XgGGZJ3OhsiOzDgutzZrpciXN/w1SK/Ls69SO5NnJ5bYRUk6UpbF/e2tnkALD4HkpZ1/ur/JWVvbfE3pvPw8CfX14Ve8CZCODLmhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KL2L13gw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KL2L13gw"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so59916945e9.2
        for <linux-modules@vger.kernel.org>; Wed, 06 May 2026 01:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778057898; x=1778662698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yq1rhhp+Y2W2kfISuuZ/kFZ98isQ+AScoJuJplL5IG4=;
        b=KL2L13gwWqZLTtRoOPyd4Jroet2qjFDquj6vD3ieDegRK5tjXarPh+NSH36QLQfq9a
         Uqf34+tRGQmozY93bJ8esfvRYYFmUYFAu6+DhPUkIjOnM+zGdpCJEAG6vFtsK8PeB3Bs
         KBqH9SoJDYY0lciPlgqIbG8ziWDv4aZQuRng4VdI6i12ttn6LdpQAFlywM0mMvv/JWa5
         /0rGiWoCsdLS6g9m6JqE/JLCGLPUytq8rvfgt95/My2tk0w32Sm+ku6ufkxsvGz0vyqB
         adL5rHernpe6ba1cZFuNPYpeXk5ceFQXuQARSkPlUrkekBz1BTY5Jy2UA4bK+DeHOcbg
         SNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778057898; x=1778662698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yq1rhhp+Y2W2kfISuuZ/kFZ98isQ+AScoJuJplL5IG4=;
        b=abl12L2swk8k55byL3WRw3jbbP7emMeLItWFET5gLGd6zrUSXyhvu451bFjUMHEOqH
         RVA+4AqOifkPeSi6iMtjkOUOX0e34JPfMOX4gbC0owWPUQtzI4UuLhBjYjbEAarcnnNy
         v9q2Bv8O7s7cJh8rSVcECXapE25XTLbt5fiWO6gZ8or5llx1mzeAPjMrD9lPn4Nux0V2
         CesYb6JlkbnHPGAr+AjYWKMmjdJ/oQ7foJT4AaGOUztqMiqKUWV3OUle0MHfiS/Kf314
         5OQtkwrp3pN6HWk3dC1VCyvvHJ5MPW9IrxmcbaiQH0CzG6oPAyKRJrqZqKT+/60V+XtD
         pQ2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/gEsDn+z4owH0ijcu/SfjqY64uDMxiD7+gSO+D2FKnRsro0rBG7GIA7WN0lODT9Ie3hZLWTmjKVob9kSUI@vger.kernel.org
X-Gm-Message-State: AOJu0YwSNO7+gkFUQGwm7Uy7OVz6qVOUYQM5GdZVXHL4oMQbUxoopX28
	W84+o6UF/XSdD6WI11lzFIhrXueECjBjDAYoet7oailBvIU2xIvI+Dv+s8ke0fnipzA=
X-Gm-Gg: AeBDieuoSykLET7NXczBGw2G2JBnSRWy9PgsELDhA/oedP1Mhm8Pj1fTnM/YnTjmsBt
	putDJNwMaB775m1xr5F0YJII6R+buILZBitg4emNBQhZjIG1F8ZbTBefePrBxSev6Y8uWUVJeie
	stgDrUb00dbDQnvHFswuMNmvMcPgt19GGe5AvServv+0WMdNVM3sZLoTRgtZLZkflO9CucXf5KR
	9oTmDl5OulFZxSaXfmVSUsF8WBN2ezpqvcCLuqiRgF4BFG3NzADfe8pA4WKFWWMburiOF59boST
	Kppx9h6pwmDV2FuVhpuyDhLnrP91+JiErK/NLDDkSE4WSRAMHx5zzGVDnjlUcAau4Ldk0F/Uby4
	1pWR3q4t/dYUpW1z6ta2/Yz9Rjn2izwjn45kgud5X3Ii4bNarwhzNfR2ecRfxdUVXgJ179WDSNP
	Ul7iQsVJE0eSABr+UxDozhNZQEkyuDiEHa5uTB
X-Received: by 2002:a05:600c:4449:b0:48a:89d9:a419 with SMTP id 5b1f17b1804b1-48e51f2e67fmr42687525e9.11.1778057897613;
        Wed, 06 May 2026 01:58:17 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e52f5d299sm17831355e9.0.2026.05.06.01.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 01:58:17 -0700 (PDT)
Date: Wed, 6 May 2026 10:58:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-modules@vger.kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jordan Rome <linux@jordanrome.com>,
	Viktor Malik <vmalik@redhat.com>, Miroslav Benes <mbenes@suse.cz>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v2 2/2] module/kallsyms: sort function symbols and use
 binary search
Message-ID: <afsCpoGPasi-kBLb@pathway.suse.cz>
References: <20260327110005.16499-1-stf_xl@wp.pl>
 <20260327110005.16499-2-stf_xl@wp.pl>
 <afnhidn7K7dZ_cPh@pathway.suse.cz>
 <28bb0f74-8721-4e53-ad89-87b2a78623b2@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28bb0f74-8721-4e53-ad89-87b2a78623b2@suse.com>

On Tue 2026-05-05 16:37:56, Petr Pavlu wrote:
> On 5/5/26 2:24 PM, Petr Mladek wrote:
> > On Fri 2026-03-27 12:00:05, Stanislaw Gruszka wrote:
> >> Module symbol lookup via find_kallsyms_symbol() performs a linear scan
> >> over the entire symtab when resolving an address. The number of symbols
> >> in module symtabs has grown over the years, largely due to additional
> >> metadata in non-standard sections, making this lookup very slow.
> >>
> >> Improve this by separating function symbols during module load, placing
> >> them at the beginning of the symtab, sorting them by address, and using
> >> binary search when resolving addresses in module text.
> >>
> >> This also should improve times for linear symbol name lookups, as valid
> >> function symbols are now located at the beginning of the symtab.
> >>
> >> The cost of sorting is small relative to module load time. In repeated
> >> module load tests [1], depending on .config options, this change
> >> increases load time between 2% and 4%. With cold caches, the difference
> >> is not measurable, as memory access latency dominates.
> >>
> >> The sorting theoretically could be done in compile time, but much more
> >> complicated as we would have to simulate kernel addresses resolution
> >> for symbols, and then correct relocation entries. That would be risky
> >> if get out of sync.
> >>
> >> The improvement can be observed when listing ftrace filter functions.
> >>
> >> Before:
> >>
> >> root@nano:~# time cat /sys/kernel/tracing/available_filter_functions | wc -l
> >> 74908
> >>
> >> real	0m1.315s
> >> user	0m0.000s
> >> sys	0m1.312s
> >>
> >> After:
> >>
> >> root@nano:~# time cat /sys/kernel/tracing/available_filter_functions | wc -l
> >> 74911
> >>
> >> real	0m0.167s
> >> user	0m0.004s
> >> sys	0m0.175s
> >>
> >> (there are three more symbols introduced by the patch)
> >>
> >> For livepatch modules, the symtab layout is preserved and the existing
> >> linear search is used. For this case, it should be possible to keep
> >> the original ELF symtab instead of copying it 1:1, but that is outside
> >> the scope of this patch.
> > 
> > What is the exact motivation for the special handling of livepatch modules,
> > please?
> > 
> > Honestly, I am always a bit lost in the various symbol tables. It is
> > possile that I have got something wrong.
> > 
> > Anyway, my understanding is that there are two aspects which are important
> > for livepatches:
> > 
> > 1. Livepatches need to preserve special symbols which are used to
> >    relocate symbols which were local in the original code, see
> >    Documentation/livepatch/module-elf-format.rst
> > 
> >    IMHO, this is why layout_symtab() computes space for all core
> >    symbols in livepatch modules and copies them in add_kallsyms().
> > 
> >    The symtab is normally released when the module is loaded.
> >    But livepatch modules make its own copy of the important
> >    parts, see copy_module_elf().
> > 
> >    IMHO, the sorting of function symbols vs other symbols does
> >    not matter here. I believe that the special relocation
> >    symbols are not affected by this.
> 
> I'm not sure if I fully follow the conclusion in this point. My
> understanding is that .klp.rela sections still refer to their special
> symbols in the symbol table via Elf_Rela::r_info. If the symbol table is
> filtered or reordered, these references will end up pointing to
> incorrect symbols.

My understanding is that the relocations point to symbols which
are found via the name of the entry. Let's take an example
from Documentation/livepatch/module-elf-format.rst:

     73: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT OS [0xff20] .klp.sym.vmlinux.snprintf,0

This symbol points to snprintf() function in vmlinux object.
The address of this function is found via kallsyms, see
klp_find_object_symbol().

IMHO, it does not matter if we shuffle this entry in the livepatch
module because the real address is found via kallsyms().

Even the ordering of the entries in vmlinux is not important in
_this particular case_ because the "sympos" is zero "0" in this case.
It means that "snprintf" symbol name is unique in vmlinux.

The ordering of the symbols in "vmlinux" becomes important
if the livepatch needs to access a symbol and there are more
symbols of the same name. This is what I tried to describe
below.

I hope that it makes some sense. As I said, I am not familiar
with the elf format...

> This is also described in Documentation/livepatch/module-elf-format.rst,
> section "4.1 A livepatch module's symbol table".
> 
> > 
> > 
> > 2. Livepatches _rely on the sorting_ of symbols in the module.
> >    The special relocation symbols might define a symbol position,
> >    see
> > 
> > 	.klp.sym.objname.symbol_name,sympos
> > 
> >    in the documentation. It defines the position of the symbol
> >    when there are more symbols of the same name, see
> >    klp_match_callback() in kernel/livepatch/core.c.
> > 
> >    I am afraid that _this patch might break_ this when it moves
> >    function symbols before non-funciton ones. I guess that
> >    the symbols of the same name will not longer be groupped.
> 
> I see. So if the module loader sorts the symbol table in a regular
> module and a livepatch module exists for that module, the livepatch may
> no longer function correctly. This means that the loader cannot even
> reorder the symbol table in regular modules.

Yeah, reordering symbols in regular module might break livepatching.
Namely it might break finding the right symbol when there are
more symbols of the same name.

Best Regards,
Petr
