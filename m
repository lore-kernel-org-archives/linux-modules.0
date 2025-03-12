Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9564E1482F2;
	Wed, 12 Mar 2025 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741797034; cv=none; b=SToVgcr15GIEcFYkuaf+YtwSLozKrp2wN3kWnWStpPIk5wPwAivvK+flOWfP3/vEOimzYrak1qTQjw0j8hRSK75Rt5O9hGjhD/bRbj7VN66icd2DNSJSUadZ2TZY5KV0PF27b6GrP5T+Dgvyp4DnpetIBlplmDv3rsBIW6YdJGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741797034; c=relaxed/simple;
	bh=T4USTpbiJBU+Mo+Fc8Gyg6DEW4C5PZ2fzKc4tIFb8DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXA0ilqe928ATToGfiZOMV68n4Nis8i9Nuo7qcMev0kwo212I4oOklEUBoMazt61UhWaFNiTQBxYLaIbnaYPtiOrjqUU3vbARybAjs1inAYD7dX30OFyoFjAIyecUdm9+6+DyeE2pHXYfj/oAp96TTshVTiqgED/rN1uG9kO7kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KArYPLzY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KArYPLzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000A1C4CEDD;
	Wed, 12 Mar 2025 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741797034;
	bh=T4USTpbiJBU+Mo+Fc8Gyg6DEW4C5PZ2fzKc4tIFb8DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KArYPLzYeStq7Oz7/PRzKy3002H7u7RQTP11qkabSqoZzH9slWvs7PVg1sr37MTVO
	 zwo+jrKI1gR/6grBKGbSPcA4QhNPMCaqlq8CxLOvf3cDC8W5Tokd305ycEJqqz6pxF
	 l+1OGFAsb0B8mgYStsBpm3hNOWtnIAWT482zOIAs0mNBRAA1ObZL7KXKUG1i5wG6Fd
	 2uWIReEV5UBFcLcZ+TWxrMUH2Yi58XVfZ5Ua9EM59YsQwLugLvs1QkILxTUgQAJ+qx
	 MXTDhEPo0t8tpZlVUfHQ441pgSMM+b9rIEkvYcJ060a3ycScZhKxoTFLuVorzxU6RU
	 rlOCS+nE/Ui6A==
Date: Wed, 12 Mar 2025 09:30:28 -0700
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, Petr Mladek <pmladek@suse.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-mm <linux-mm@kvack.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Taint the kernel when write-protecting
 ro_after_init fails
Message-ID: <202503120923.199D458CB@keescook>
References: <20250306103712.29549-1-petr.pavlu@suse.com>
 <Z8nT8PCPThnfb3Cq@bombadil.infradead.org>
 <c25939c5-d6e8-4450-873b-0a9c774b845b@suse.cz>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c25939c5-d6e8-4450-873b-0a9c774b845b@suse.cz>

On Wed, Mar 12, 2025 at 04:45:24PM +0100, Vlastimil Babka wrote:
> On 3/6/25 17:57, Luis Chamberlain wrote:
> > + linux-mm since we're adding TAINT_BAD_PAGE
> > 
> > On Thu, Mar 06, 2025 at 11:36:55AM +0100, Petr Pavlu wrote:
> >> In the unlikely case that setting ro_after_init data to read-only fails, it
> >> is too late to cancel loading of the module. The loader then issues only
> >> a warning about the situation. Given that this reduces the kernel's
> >> protection, it was suggested to make the failure more visible by tainting
> >> the kernel.
> >> 
> >> Allow TAINT_BAD_PAGE to be set per-module and use it in this case. The flag
> >> is set in similar situations and has the following description in
> >> Documentation/admin-guide/tainted-kernels.rst: "bad page referenced or some
> >> unexpected page flags".
> >> 
> >> Adjust the warning that reports the failure to avoid references to internal
> >> functions and to add information about the kernel being tainted, both to
> >> match the style of other messages in the file. Additionally, merge the
> >> message on a single line because checkpatch.pl recommends that for the
> >> ability to grep for the string.
> >> 
> >> Suggested-by: Kees Cook <kees@kernel.org>
> >> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> >> ---
> >> I opted to use TAINT_BAD_PAGE for now because it seemed unnecessary to me
> >> to introduce a new flag only for this specific case. However, if we end up
> >> similarly checking set_memory_*() in the boot context, a separate flag
> >> would be probably better.
> >> ---
> >>  kernel/module/main.c | 7 ++++---
> >>  kernel/panic.c       | 2 +-
> >>  2 files changed, 5 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/kernel/module/main.c b/kernel/module/main.c
> >> index 1fb9ad289a6f..8f424a107b92 100644
> >> --- a/kernel/module/main.c
> >> +++ b/kernel/module/main.c
> >> @@ -3030,10 +3030,11 @@ static noinline int do_init_module(struct module *mod)
> >>  	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
> >>  #endif
> >>  	ret = module_enable_rodata_ro_after_init(mod);
> >> -	if (ret)
> >> -		pr_warn("%s: module_enable_rodata_ro_after_init() returned %d, "
> >> -			"ro_after_init data might still be writable\n",
> >> +	if (ret) {
> >> +		pr_warn("%s: write-protecting ro_after_init data failed with %d, the data might still be writable - tainting kernel\n",
> >>  			mod->name, ret);
> >> +		add_taint_module(mod, TAINT_BAD_PAGE, LOCKDEP_STILL_OK);
> >> +	}
> >>  
> >>  	mod_tree_remove_init(mod);
> >>  	module_arch_freeing_init(mod);
> >> diff --git a/kernel/panic.c b/kernel/panic.c
> >> index d8635d5cecb2..794c443bfb5c 100644
> >> --- a/kernel/panic.c
> >> +++ b/kernel/panic.c
> >> @@ -497,7 +497,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
> >>  	TAINT_FLAG(CPU_OUT_OF_SPEC,		'S', ' ', false),
> >>  	TAINT_FLAG(FORCED_RMMOD,		'R', ' ', false),
> >>  	TAINT_FLAG(MACHINE_CHECK,		'M', ' ', false),
> >> -	TAINT_FLAG(BAD_PAGE,			'B', ' ', false),
> >> +	TAINT_FLAG(BAD_PAGE,			'B', ' ', true),
> >>  	TAINT_FLAG(USER,			'U', ' ', false),
> >>  	TAINT_FLAG(DIE,				'D', ' ', false),
> >>  	TAINT_FLAG(OVERRIDDEN_ACPI_TABLE,	'A', ' ', false),
> > 
> > Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > For our needs this makes sense, however I am curious if TAINT_BAD_PAGE
> > is too broadly generic, and also if we're going to add it, if there are
> > other mm uses for such a thing.
> 
> I'm not sure BAD_PAGE is a good fit. If there was a new flag that meant "a
> hardening measure failed", would that have other possible uses? The
> semantics would be that the kernel self-protection was weakened wrt
> expectations, even if not yet a corruption due to attack would be detected.
> Some admins could opt-in to panic in such case anyway, etc. Any other
> hardening features where such "failure to harden" is possible and could use
> this too? Kees?

Yeah, it could certainly be used. The direction the hardening stuff has
taken is to use WARN() (as Linus requires no direct BUG() usage), and to
recommend that end users tune their warn_limit sysctl as needed.

Being able to TAINT might be useful, but I don't have any places that
immediately come to mind that seem appropriate for it (besides this
case). Hm, well, maybe in the case of a W^X test failure? (I note that
this is also a "safe memory permission" failure...)

How about TAINT_WEAKENED_PROTECTION ? Or something that carries that
idea?

-Kees

-- 
Kees Cook
