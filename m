Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF42C2566F3;
	Thu,  6 Mar 2025 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280243; cv=none; b=L7qcZcgcDDHkC7IWSQl45pBij42jjOgvj9XZKBdkAjkqMqdXyhxbvneFGoCI4XOX+mMs0gxvqe3Ux9MolVx2LbH6caVgZX6GKm4CnHB/69iX7k7DXwabGkEGwuRR0ZfK3FsXgSAnrIq16+ON66Iv6+mOP3pl4CN/A/ndbYm41/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280243; c=relaxed/simple;
	bh=aJZfEajPBD2iDdwcbtY5Avx4D4TADjWaPWTqb27CuZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzsodWmEQV3vRasXcj+vFYsBpbMdswUeNECFWfhGXjnNRMrdxBeF1Mu3oIfCyJwIN5/6+ajb4jT/B8x0wGMcntlaWtBpz/5uW8lrAjxkhx9hYdTUu2D5aMeL4wEg2wKi1JrSD8SswvOt7SEbwZdiGTmoHcRG5mkh8AXfZdIcD40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/zKuPZt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/zKuPZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E35C4CEE0;
	Thu,  6 Mar 2025 16:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741280242;
	bh=aJZfEajPBD2iDdwcbtY5Avx4D4TADjWaPWTqb27CuZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/zKuPZtB/q7WJWachcbscNMt2RpxJbhxrweb9D3AFQ/J7a9xhz/lAS2i/IK2RuEO
	 dM+XbQKheP5Epwae9QZ0ElwT6NH3EOYRqBZZlj4alZ1wGwH2jEuAFBU0x9/3ujuII3
	 SSI6bB8f5xLQ3JfurvV3sk2ftg7vZqY7wWl66KlPIQRPg0Dl06P99XbDBwgA41Nw87
	 nk2q6mEcSIEXKKD7mqrg66FA7z8tFQM7oNXx5dymWmzxYHw2iasdIUluCpEPuGPoim
	 bbFLeodMSiPJSJPCUCpg8mule2+aswhuVJubxyqf+kPMNI5q2+rN8cPv6/X179U0pn
	 fgj067cXZm8nw==
Date: Thu, 6 Mar 2025 08:57:20 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
	Petr Mladek <pmladek@suse.com>, Jani Nikula <jani.nikula@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-mm <linux-mm@kvack.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Taint the kernel when write-protecting
 ro_after_init fails
Message-ID: <Z8nT8PCPThnfb3Cq@bombadil.infradead.org>
References: <20250306103712.29549-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306103712.29549-1-petr.pavlu@suse.com>

+ linux-mm since we're adding TAINT_BAD_PAGE

On Thu, Mar 06, 2025 at 11:36:55AM +0100, Petr Pavlu wrote:
> In the unlikely case that setting ro_after_init data to read-only fails, it
> is too late to cancel loading of the module. The loader then issues only
> a warning about the situation. Given that this reduces the kernel's
> protection, it was suggested to make the failure more visible by tainting
> the kernel.
> 
> Allow TAINT_BAD_PAGE to be set per-module and use it in this case. The flag
> is set in similar situations and has the following description in
> Documentation/admin-guide/tainted-kernels.rst: "bad page referenced or some
> unexpected page flags".
> 
> Adjust the warning that reports the failure to avoid references to internal
> functions and to add information about the kernel being tainted, both to
> match the style of other messages in the file. Additionally, merge the
> message on a single line because checkpatch.pl recommends that for the
> ability to grep for the string.
> 
> Suggested-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
> I opted to use TAINT_BAD_PAGE for now because it seemed unnecessary to me
> to introduce a new flag only for this specific case. However, if we end up
> similarly checking set_memory_*() in the boot context, a separate flag
> would be probably better.
> ---
>  kernel/module/main.c | 7 ++++---
>  kernel/panic.c       | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 1fb9ad289a6f..8f424a107b92 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3030,10 +3030,11 @@ static noinline int do_init_module(struct module *mod)
>  	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
>  #endif
>  	ret = module_enable_rodata_ro_after_init(mod);
> -	if (ret)
> -		pr_warn("%s: module_enable_rodata_ro_after_init() returned %d, "
> -			"ro_after_init data might still be writable\n",
> +	if (ret) {
> +		pr_warn("%s: write-protecting ro_after_init data failed with %d, the data might still be writable - tainting kernel\n",
>  			mod->name, ret);
> +		add_taint_module(mod, TAINT_BAD_PAGE, LOCKDEP_STILL_OK);
> +	}
>  
>  	mod_tree_remove_init(mod);
>  	module_arch_freeing_init(mod);
> diff --git a/kernel/panic.c b/kernel/panic.c
> index d8635d5cecb2..794c443bfb5c 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -497,7 +497,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
>  	TAINT_FLAG(CPU_OUT_OF_SPEC,		'S', ' ', false),
>  	TAINT_FLAG(FORCED_RMMOD,		'R', ' ', false),
>  	TAINT_FLAG(MACHINE_CHECK,		'M', ' ', false),
> -	TAINT_FLAG(BAD_PAGE,			'B', ' ', false),
> +	TAINT_FLAG(BAD_PAGE,			'B', ' ', true),
>  	TAINT_FLAG(USER,			'U', ' ', false),
>  	TAINT_FLAG(DIE,				'D', ' ', false),
>  	TAINT_FLAG(OVERRIDDEN_ACPI_TABLE,	'A', ' ', false),

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

For our needs this makes sense, however I am curious if TAINT_BAD_PAGE
is too broadly generic, and also if we're going to add it, if there are
other mm uses for such a thing.

  Luis
