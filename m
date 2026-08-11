Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD60740097E
	for <linux-modules@vger.kernel.org>; Tue, 11 Aug 2026 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450809; cv=none; b=cBj1DmLZc69Ob9CG6TkVwV6QOYeN2/6GVpMXew7bmqp2AyYGoRqaqiqIDeljIlRegcVPQ5I+nsYS+KWD+V+DxKo4jmB9jyNPZgsgzB+blo/Gduvw1pWCC3aA6a/fYQVl5IR3OndNPxs1WktcpHJOJOZ7QcjyTAGeRdw5mpqqyIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450809; c=relaxed/simple;
	bh=4llsLWaEDSFkKqLTqmOe2KriepWDHwfSb/u+d2WeKqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4JatI6eXu0hNX96p1ILi/oHuVyhamfHdf8dFm1VoOPRdazpNE0e+f67aPAVZZzPV7KLWYTXa/N+IDdruhD6lsp5dvEhbQOsZVZRNTEkb8Bc9jfy0WXDV5GALuan4HrcTvqfSRsEqRBD479unu4G4SlgDTga2PjhYblDZp28pgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bE8wXf7D; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bE8wXf7D"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4956242332dso29444445e9.2
        for <linux-modules@vger.kernel.org>; Tue, 11 Aug 2026 05:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786450806; x=1787055606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gAOSYqRVcuEeGEvjxb4g0YtG8ZJHqRE+rYQE448XlH8=;
        b=bE8wXf7DLb21bMCjqhiLrN8gxIrXDpmlclZDs4swd+fuGAcFsmypuzmfZtWtLXghWL
         S6lxaeJPOqqouc+VDS7mV8Bl618C2xOfWZ8P9jmWOgfqYezzT1VfKI0grTW/Np2l7Guc
         dlemvXCAFUaQtoK091euNtBuGAZM/qhmp/a9l3jj0V82lEsxCZ5sLLtET+9n3LoWatb2
         lJmsK3r5/mQp4/XpUCjTUM0CaCL+YqOn7Uj4dNWaouQky1lwreErNdzooZ0POb/gu6vw
         y1Ccds3h2T3Am8mBhu0EWr10L5/mML4fsNb88TPGYA/WUrYKos4xY6N8FVv42wH2qNU7
         7gYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450806; x=1787055606;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gAOSYqRVcuEeGEvjxb4g0YtG8ZJHqRE+rYQE448XlH8=;
        b=DowUnvYjnlm3rA7KYkaZj3zQNyROoxLJGw9Wy+kXSG09EDY3v5ysk+lsa3HeGzjU06
         xjoV/454QEdZht2gw9h5pv/Eb/AnddOHnPX99sMFmB2M/53P9snnkCPpSC8Io4RVJJ/W
         kNdShSYgUUXmmBtze2c7QFSRZMiFPPheHNsNI0IwU7nApC/NV1Zb9/XsDtk9Am4g2UBS
         KUHkoTd+4K7cJpuIBOW/+XULD7QuQrk3J0xZ5ys1wqCW0unvK5bvJLpPOzY0WfxS9HVq
         UgnEsQ1FwsfFs31Hg97CHIgYshp7iI5Lr6wXeaea6KQJUxmwXMM90mtQ38N5tOt8AJRG
         5k8g==
X-Forwarded-Encrypted: i=1; AHgh+RrGLOnrB1kNXAigfkW1ck/5V11KAFa+ZTl413cX8OrCBbSlndqnjxLRbXsVhJroMMFxEji1WUELGddM7ru0@vger.kernel.org
X-Gm-Message-State: AOJu0YwDvL1z43raQ8XNCk8JYd6efl2sR1jQB87zF58KZe1H6jb7J13S
	Fm2WyRxxFBWkU+iggv10l/eJWyF0lMlerbJANXFg1Ars+P7Kl8ElG7847EpJ70SvGas=
X-Gm-Gg: AR+sD10zicxLlSxDbrueaevnNGHwUXYs9o1I4JtYOqNu1+q/7bQRYBg5/nZBIJsPJ3Q
	WQB7mjOOzBVdStRgRvT/ePjANHuGSZCwUQmtTi48sSuvwwy46sQa8O4xAj0MZ3f1JyOpJYvw5oL
	Ik5PJA22Uryh3XFKp2+iHAhE3F+WTxVKqB+G+B8xKil4xxvbDhpNCKn8QoD833Ka6Z8JpJ2vz4p
	hNN+k+ePjuGOOemWGELLjk8HTzG4zYcMEie0a0pvVCDPPnk4GM320V1fJOa4OUjVssxFSfbOIU7
	ZqzgtOUL2QOsbXPw1fe/dan2U4LNtebE+PBMF3NHNQnd2G5SfvTByAshIBvhHlPbHnhqwYdisMu
	s+IVYtTXAUhFssgfcvG7+8G322xusddftADDLYlsAq/oXqE4sCSnWzlQcxTBUntXHulgC9baR5R
	97TSeY8PKsDhtOmYzstahwfcYjt/EM2ktXU805FMJOFh7bfXCvvDy7Hr3i7XOUzhbdpObhFQDnE
	YnKCRVLYG2q7Yvex9qhR9z/jc8RLIzHm7AM3dSk1zAaULmQf7dahC+tCJxSqodRV2v3nsLublH9
	/h6cn7kqhEAezMbDo5+kqf8TylEfRhM=
X-Received: by 2002:a05:600c:1d2a:b0:499:52ab:a50c with SMTP id 5b1f17b1804b1-4997840c622mr44289915e9.1.1786450806038;
        Tue, 11 Aug 2026 05:20:06 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499788f17ccsm38388315e9.11.2026.08.11.05.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 05:20:05 -0700 (PDT)
Message-ID: <39a48465-22b6-4b18-9f7e-ce258513181b@suse.com>
Date: Tue, 11 Aug 2026 14:20:04 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module/kallsyms: Filter out local mapping symbols
 during module load
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260811071507.24043-1-yangtiezhu@loongson.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260811071507.24043-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/26 9:15 AM, Tiezhu Yang wrote:
> The compiler toolchains generate internal local labels on certain
> architectures (such as LoongArch) for optimizations and relocations.
> 
> While these local labels are filtered out during runtime lookups in
> find_kallsyms_symbol(), they still leak into the permanent symbol
> tables of loaded modules, because layout_symtab() and add_kallsyms()
> do not check for the mapping symbols during layout generation.
> 
> Consequently, tracing tools like bpftrace resolve identical addresses
> into confusing local labels instead of actual clear C function names.
> 
> Fix this by adding is_mapping_symbol() checks directly into the symbol
> tracking loops of layout_symtab() and add_kallsyms(). This prevents the
> mapping symbols from entering the module's memory symbol arrays at load
> time.

This optimization looks sensible to me. Kallsyms in vmlinux also
normally doesn't include information about local labels (.L<xyz>) and
mapping symbols ($a, $d, ...), so it should be ok not to track them in
modules either.

Note that the patch description mixes up these two symbol categories,
presumably because the existing is_mapping_symbol() function conflates
them as well.

> 
> For livepatch modules, core_kallsyms.symtab must remain a complete copy
> of the original ELF symbol table to prevent delayed relocation failures.
> Therefore, enforce is_livepatch_module() checking to skip the filtering
> for livepatch modules.
> 
> Reproduce steps:
> 
> 1. Set up a LoongArch VM with "-accel kvm":
> 
>    $ sudo qemu-system-loongarch64 -serial stdio \
>      -machine virt -cpu la464 -smp 4 -m 4G \
>      -bios /usr/share/edk2/loongarch64/QEMU_EFI.fd \
>      -nodefaults -no-reboot -nographic -accel kvm
> 
> 2. Use bpftrace to capture kstack when vCPU is scheduled out:
> 
>    $ cat trace_sched.bt
>    kprobe:kvm:kvm_sched_out
>    {
>            if (pid == $1) {
>                    print(kstack());
>            }
>    }
> 
>    $ sudo bpftrace trace_sched.bt `pgrep -o qemu-system`
> 
> Test results:
> 
> 1. Before this patch (Confusing stack with local labels):
> 
>         kvm_sched_out+0
>         __schedule+1584
>         schedule+48
>         .LVL3767+36
>         .LVL3801+8
>         .LVL285+12
>         .LVL425+44
>         .LVL1419+20
>         kvm_exc_entry+260

The description should mention that this change affects what appears in
/proc/kallsyms, as that is the important part. bpftrace is only one user
of this data and apparently gets confused because it does not apply any
filtering of its own, unlike perf which has is_ignored_kernel_symbol().

> 
> 2. After this patch (Accurate stack with function names):
> 
>         kvm_sched_out+0
>         __schedule+1584
>         schedule+48
>         kvm_vcpu_block+112
>         kvm_vcpu_halt+104
>         kvm_emu_idle+284
>         kvm_handle_gspr+1316
>         kvm_handle_exit+456
>         kvm_exc_entry+260
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> v2: Fix livepatch support as pointed out by Sashiko bot.
> 
>  kernel/module/kallsyms.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index f23126d804b2..aece7aa49dd4 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -130,6 +130,10 @@ void layout_symtab(struct module *mod, struct load_info *info)
>  
>  	/* Compute total space required for the core symbols' strtab. */
>  	for (ndst = i = 0; i < nsrc; i++) {
> +		if (!is_livepatch_module(mod) &&
> +		    is_mapping_symbol(&info->strtab[src[i].st_name]))
> +			continue;
> +
>  		if (i == 0 || is_livepatch_module(mod) ||
>  		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
>  				   info->index.pcpu)) {
> @@ -198,6 +202,11 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
>  	src = kallsyms->symtab;
>  	for (ndst = i = 0; i < kallsyms->num_symtab; i++) {
>  		kallsyms->typetab[i] = elf_type(src + i, info);
> +
> +		if (!is_livepatch_module(mod) &&
> +		    is_mapping_symbol(&kallsyms->strtab[src[i].st_name]))
> +			continue;
> +
>  		if (i == 0 || is_livepatch_module(mod) ||
>  		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
>  				   info->index.pcpu)) {

It is better to avoid duplicating the same logic in layout_symtab() and
add_kallsyms(). The function is_core_symbol() can be renamed to
something like is_kept_symbol() and can be solely responsible for
deciding what to keep.

The following prototype shows my suggestion:

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 0fc11e45df9b..c86879cc5b66 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -75,23 +75,29 @@ static char elf_type(const Elf_Sym *sym, const struct load_info *info)
 	return '?';
 }
 
-static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr *sechdrs,
-			   unsigned int shnum, unsigned int pcpundx)
+static bool is_kept_symbol(struct module *mod, const struct load_info *info,
+			   unsigned int symnum, const Elf_Sym *src)
 {
 	const Elf_Shdr *sec;
 	enum mod_mem_type type;
 
+	if (symnum == 0 || is_livepatch_module(mod))
+		return true;
+
 	if (src->st_shndx == SHN_UNDEF ||
-	    src->st_shndx >= shnum ||
+	    src->st_shndx >= info->hdr->e_shnum ||
 	    !src->st_name)
 		return false;
 
+	if (is_mapping_symbol(&info->strtab[src->st_name]))
+		return false;
+
 #ifdef CONFIG_KALLSYMS_ALL
-	if (src->st_shndx == pcpundx)
+	if (src->st_shndx == info->index.pcpu)
 		return true;
 #endif
 
-	sec = sechdrs + src->st_shndx;
+	sec = info->sechdrs + src->st_shndx;
 	type = sec->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
 	if (!(sec->sh_flags & SHF_ALLOC)
 #ifndef CONFIG_KALLSYMS_ALL
@@ -130,12 +136,11 @@ void layout_symtab(struct module *mod, struct load_info *info)
 
 	/* Compute total space required for the core symbols' strtab. */
 	for (ndst = i = 0; i < nsrc; i++) {
-		if (i == 0 || is_livepatch_module(mod) ||
-		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
-				   info->index.pcpu)) {
-			strtab_size += strlen(&info->strtab[src[i].st_name]) + 1;
-			ndst++;
-		}
+		if (!is_kept_symbol(mod, info, i, src + i))
+			continue;
+
+		strtab_size += strlen(&info->strtab[src[i].st_name]) + 1;
+		ndst++;
 	}
 
 	/* Append room for core symbols at end of core part. */
@@ -197,23 +202,22 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	strtab_size = info->core_typeoffs - info->stroffs;
 	src = kallsyms->symtab;
 	for (ndst = i = 0; i < kallsyms->num_symtab; i++) {
+		ssize_t ret;
+
 		kallsyms->typetab[i] = elf_type(src + i, info);
-		if (i == 0 || is_livepatch_module(mod) ||
-		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
-				   info->index.pcpu)) {
-			ssize_t ret;
-
-			mod->core_kallsyms.typetab[ndst] =
-				kallsyms->typetab[i];
-			dst[ndst] = src[i];
-			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
-			ret = strscpy(s, &kallsyms->strtab[src[i].st_name],
-				      strtab_size);
-			if (ret < 0)
-				break;
-			s += ret + 1;
-			strtab_size -= ret + 1;
-		}
+
+		if (!is_kept_symbol(mod, info, i, src + i))
+			continue;
+
+		mod->core_kallsyms.typetab[ndst] = kallsyms->typetab[i];
+		dst[ndst] = src[i];
+		dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
+		ret = strscpy(s, &kallsyms->strtab[src[i].st_name],
+			      strtab_size);
+		if (ret < 0)
+			break;
+		s += ret + 1;
+		strtab_size -= ret + 1;
 	}
 
 	/* Set up to point into init section. */

-- 
Thanks,
Petr
