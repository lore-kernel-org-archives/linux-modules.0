Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953203B3BEC;
	Fri,  2 Oct 2026 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790964327; cv=none; b=n2WFBEdsAevhAgymhHnkrlVz+8pSzwGsQjvunf5MRnNZl6h8W2pFaIyZlH7nT9ACKBsCCCIfDNO008xcaInoC1ubzb73+hBTyRRhjqM9AF4JC4vRQvDRQbjlAx1RBimeVvlSPZm/6NmquT3w8G8wfjzg6Vn+TKvuSOWthyKoWcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790964327; c=relaxed/simple;
	bh=PKGPe/578IZsFB4iyAfk/lE1kzNHWCmLIX0DWsqMN5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXpU21Xcbf1s3edZ4SKmf+40lbS8hA146732EDB7Pga+nQ2xfimmcmQ2ukc0rgfUZpw0+eucNBXsv4QaFhjXnbdUcgyC6liFmNlYLRZHbOi7JYsFTswTg+6YHQzvRPBm+Jjb17fA3WKAU1YIjsWmouTx9lusuQpCbPIp8jrRhg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxLKh+K5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxLKh+K5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76A21F000FF;
	Fri,  2 Oct 2026 18:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790964323;
	bh=lYBNuQhS8rhzLTl1ODtEug9R54vVRIeXQ9TrTmjSeTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DxLKh+K5mM82/keRYJ+UV2MqHJ7MMgVQtFMNBI3QlcyC4dFL7URjI3cEVNAko2hj1
	 fOLHjbVDPiyDOOHYs9HDeNzDWemWNGUTCUTMeeD6u++iCVZ0y4/0WZ6nLIBL+YuYRF
	 YEHgHDpj+h+uiRog7tdw1hSiU/3VA5lUNR0t/hauFQh1voDoi0WIqyW0dDr4w4b9lC
	 GwvzW227VvWx1+lwsivTQb0hZb60iRn3bY3V907OjbsygBA48k75YcTXtRQCounECT
	 EjfB03Z163S8DudJi5BiOnTYrVRUmYRB2SEPcCM6z3pcgasmtPgDb3NM3K7I2nZKQh
	 +lXwxNhRbvPVw==
Date: Fri, 2 Oct 2026 20:05:17 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
	Borislav Petkov <bp@alien8.de>, Daniel Gomez <da.gomez@kernel.org>,
	Frederic MARIE-JOSEPH <fredericmariejoseph@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org
Subject: Re: [RFC][PATCH] x86/mm: Disconnect RWX module checking from execmem
Message-ID: <ar_yXZ4yLmlsIIHQ@kernel.org>
References: <20261001201952.ACC7B6D6@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261001201952.ACC7B6D6@davehans-spike.ostc.intel.com>

Hi Dave,

On Thu, Oct 01, 2026 at 01:19:52PM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Frédéric reported:
> 
> 	x86/mm: Checked W+X mappings: FAILED, 7 W+X pages found.
> 
> errors on a build with modules disabled. There are some build
> dependencies in play:
> 
>  * ARCH_HAS_EXECMEM_ROX depends on STRICT_MODULE_RWX
>  * STRICT_MODULE_RWX depends on MODULES
>  * execmem_restore_rox() is a stub without ARCH_HAS_EXECMEM_ROX=y
> 
> execmem_restore_rox() is what the x86 "ITS" code uses to zap its
> W+X mappings during early boot. The error message comes from
> CONFIG_DEBUG_WX which is independent from any of the other options.
> 
> But the nutty part is that there is any connection at all between
> ARCH_HAS_EXECMEM_ROX and STRICT_MODULE_RWX.
> 
> Restore a functional execmem_restore_rox() to all 64-bit builds by
> eliminating the STRICT_MODULE_RWX dependency.
> 
> Then, turn our attention to execmem. 47410d839fcd "x86/Kconfig: only
> enable ROX cache...") was trying to make module memory access more
> permissive unless STRICT_MODULE_RWX is in play. For execmem, never
> consider module memory to be ROX except under STRICT_MODULE_RWX.
> 
> This seems to fix Frédéric's issue, but I'm a bit worried that it
> has other implications in the execmem code. For instance, the
> module_enable_text_rox() loop is now rather weird mem->is_rox is
> now directly dependent on STRICT_MODULE_RWX.
> 
> Mike, do you see anything bad happening on the execmem side if we
> do this?

This could work, but it takes us back to 4k mappings for executable code.

But since x86 always sets STRICT_MODULE_RWX=y when MODULES=y, I think we
can just revert 47410d839fcd.

I also replied on the thread Frederic started.

> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Tested-by: Frederic MARIE-JOSEPH <fredericmariejoseph@gmail.com>
> Reported-by: Frederic MARIE-JOSEPH <fredericmariejoseph@gmail.com>
> Link: https://lore.kernel.org/all/20261001-x86-fault-spurious-rw-v1-1-7fe1189b5efd@imperva.com/
> Fixes: a82b26451de1 ("x86/its: explicitly manage permissions for ITS pages")
> Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Daniel Gomez <da.gomez@kernel.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Aaron Tomlin <atomlin@atomlin.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-modules@vger.kernel.org
> ---
> 
>  b/arch/x86/Kconfig     |    2 +-
>  b/kernel/module/main.c |    3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff -puN arch/x86/Kconfig~x86-STRICT_MODULE_RWX arch/x86/Kconfig
> --- a/arch/x86/Kconfig~x86-STRICT_MODULE_RWX	2026-10-01 07:11:50.443595828 -0700
> +++ b/arch/x86/Kconfig	2026-10-01 07:11:50.454595751 -0700
> @@ -85,7 +85,7 @@ config X86
>  	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
>  	select ARCH_HAS_EARLY_DEBUG		if KGDB
>  	select ARCH_HAS_ELF_RANDOMIZE
> -	select ARCH_HAS_EXECMEM_ROX		if X86_64 && STRICT_MODULE_RWX
> +	select ARCH_HAS_EXECMEM_ROX		if X86_64
>  	select ARCH_HAS_FAST_MULTIPLIER
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> diff -puN kernel/module/main.c~x86-STRICT_MODULE_RWX kernel/module/main.c
> --- a/kernel/module/main.c~x86-STRICT_MODULE_RWX	2026-10-01 07:11:50.449595786 -0700
> +++ b/kernel/module/main.c	2026-10-01 09:47:20.842360625 -0700
> @@ -1355,7 +1355,8 @@ static int module_memory_alloc(struct mo
>  	if (!ptr)
>  		return -ENOMEM;
>  
> -	mod->mem[type].is_rox = execmem_is_rox(execmem_type);
> +	if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
> +		mod->mem[type].is_rox = execmem_is_rox(execmem_type);
>  
>  	/*
>  	 * The pointer to these blocks of memory are stored on the module
> _

-- 
Sincerely yours,
Mike.
