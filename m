Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF001FDA9C;
	Fri, 14 Mar 2025 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741979961; cv=none; b=sk010NW2b70nTA7MkspGcls82LJTcK4Tm6wnXxOqIVGkjVloc4T4J4rCnLh2mFwwI2z7WslpzjcheWox6+h8G9wABxYHJqEPJXtOUFRjuLkSO7rSaSKGj8HTQXCpga5tWyc2mkmow9GEWrj2r2pdqH46rqs2LL7OA54fLOWnqWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741979961; c=relaxed/simple;
	bh=cdENQzTHVATYN33v4Wg9T3aBAGHVrDM6ftggIFL/JAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPtU/dumwbOOBjpdnJ80iCHOWFGPSGG42EdsH0KjSCtLOzR4HrV8XGN7XYfunp87KXePeVnqzd5g3ivqTJ81XscIvxQZ7lu8CoaVhtaTksNcpPQwAfosT0mFOeAD1HrXUzNEc4KMjiY9zqvTGhabeaUcY8EIrn++p6piMcrUOD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4hW8fqz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4hW8fqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8B1C4CEE3;
	Fri, 14 Mar 2025 19:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741979960;
	bh=cdENQzTHVATYN33v4Wg9T3aBAGHVrDM6ftggIFL/JAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f4hW8fqzwX6AKjw4Ii6ah7L31hUotS9mlxUS/lde+FAp6lsEZSBkHXVrgfQcMR/+i
	 EO+JRcaFezJjX/cw8fTRK5VGMOZyFLxXEAluPxodrNbmCsfJuR/WyLp/V1Bv/+yEhe
	 y4XiBmXbLRTpHRkvKritJ0axC79GfAv/uyYmfeTxPqYRXKmA1BvH079IFXiG1WBpQD
	 wXrW0cygxVARz/EembfLs5R1NBlko2hXvT4kcQaSTtIQ4rFlKcVy0LcVVuffTMnNIH
	 G1XEiHw6OnklERzz2XSXuvkNAdtfpJyOI3ZjYjYJZ9mpBp+0F4IWjsn0yHQnyWD3zY
	 0jo6caTOH4LNw==
Date: Fri, 14 Mar 2025 12:19:17 -0700
From: Kees Cook <kees@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Vlastimil Babka <vbabka@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
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
Message-ID: <202503141218.D638FB01@keescook>
References: <20250306103712.29549-1-petr.pavlu@suse.com>
 <Z8nT8PCPThnfb3Cq@bombadil.infradead.org>
 <c25939c5-d6e8-4450-873b-0a9c774b845b@suse.cz>
 <202503120923.199D458CB@keescook>
 <6e3ce71a-da5a-4d69-a5ea-4caca761d00f@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e3ce71a-da5a-4d69-a5ea-4caca761d00f@csgroup.eu>

On Fri, Mar 14, 2025 at 05:48:00PM +0100, Christophe Leroy wrote:
> 
> 
> Le 12/03/2025 à 17:30, Kees Cook a écrit :
> > On Wed, Mar 12, 2025 at 04:45:24PM +0100, Vlastimil Babka wrote:
> > > On 3/6/25 17:57, Luis Chamberlain wrote:
> > > > + linux-mm since we're adding TAINT_BAD_PAGE
> > > > 
> > > > On Thu, Mar 06, 2025 at 11:36:55AM +0100, Petr Pavlu wrote:
> > > > > In the unlikely case that setting ro_after_init data to read-only fails, it
> > > > > is too late to cancel loading of the module. The loader then issues only
> > > > > a warning about the situation. Given that this reduces the kernel's
> > > > > protection, it was suggested to make the failure more visible by tainting
> > > > > the kernel.
> > > > > 
> > > > > Allow TAINT_BAD_PAGE to be set per-module and use it in this case. The flag
> > > > > is set in similar situations and has the following description in
> > > > > Documentation/admin-guide/tainted-kernels.rst: "bad page referenced or some
> > > > > unexpected page flags".
> > > > > 
> > > > > Adjust the warning that reports the failure to avoid references to internal
> > > > > functions and to add information about the kernel being tainted, both to
> > > > > match the style of other messages in the file. Additionally, merge the
> > > > > message on a single line because checkpatch.pl recommends that for the
> > > > > ability to grep for the string.
> > > > > 
> > > > > Suggested-by: Kees Cook <kees@kernel.org>
> > > > > Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> > > > > ---
> > > > > I opted to use TAINT_BAD_PAGE for now because it seemed unnecessary to me
> > > > > to introduce a new flag only for this specific case. However, if we end up
> > > > > similarly checking set_memory_*() in the boot context, a separate flag
> > > > > would be probably better.
> > > > > ---
> > > > >   kernel/module/main.c | 7 ++++---
> > > > >   kernel/panic.c       | 2 +-
> > > > >   2 files changed, 5 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > > > > index 1fb9ad289a6f..8f424a107b92 100644
> > > > > --- a/kernel/module/main.c
> > > > > +++ b/kernel/module/main.c
> > > > > @@ -3030,10 +3030,11 @@ static noinline int do_init_module(struct module *mod)
> > > > >   	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
> > > > >   #endif
> > > > >   	ret = module_enable_rodata_ro_after_init(mod);
> > > > > -	if (ret)
> > > > > -		pr_warn("%s: module_enable_rodata_ro_after_init() returned %d, "
> > > > > -			"ro_after_init data might still be writable\n",
> > > > > +	if (ret) {
> > > > > +		pr_warn("%s: write-protecting ro_after_init data failed with %d, the data might still be writable - tainting kernel\n",
> > > > >   			mod->name, ret);
> > > > > +		add_taint_module(mod, TAINT_BAD_PAGE, LOCKDEP_STILL_OK);
> > > > > +	}
> > > > >   	mod_tree_remove_init(mod);
> > > > >   	module_arch_freeing_init(mod);
> > > > > diff --git a/kernel/panic.c b/kernel/panic.c
> > > > > index d8635d5cecb2..794c443bfb5c 100644
> > > > > --- a/kernel/panic.c
> > > > > +++ b/kernel/panic.c
> > > > > @@ -497,7 +497,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
> > > > >   	TAINT_FLAG(CPU_OUT_OF_SPEC,		'S', ' ', false),
> > > > >   	TAINT_FLAG(FORCED_RMMOD,		'R', ' ', false),
> > > > >   	TAINT_FLAG(MACHINE_CHECK,		'M', ' ', false),
> > > > > -	TAINT_FLAG(BAD_PAGE,			'B', ' ', false),
> > > > > +	TAINT_FLAG(BAD_PAGE,			'B', ' ', true),
> > > > >   	TAINT_FLAG(USER,			'U', ' ', false),
> > > > >   	TAINT_FLAG(DIE,				'D', ' ', false),
> > > > >   	TAINT_FLAG(OVERRIDDEN_ACPI_TABLE,	'A', ' ', false),
> > > > 
> > > > Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> > > > 
> > > > For our needs this makes sense, however I am curious if TAINT_BAD_PAGE
> > > > is too broadly generic, and also if we're going to add it, if there are
> > > > other mm uses for such a thing.
> > > 
> > > I'm not sure BAD_PAGE is a good fit. If there was a new flag that meant "a
> > > hardening measure failed", would that have other possible uses? The
> > > semantics would be that the kernel self-protection was weakened wrt
> > > expectations, even if not yet a corruption due to attack would be detected.
> > > Some admins could opt-in to panic in such case anyway, etc. Any other
> > > hardening features where such "failure to harden" is possible and could use
> > > this too? Kees?
> > 
> > Yeah, it could certainly be used. The direction the hardening stuff has
> > taken is to use WARN() (as Linus requires no direct BUG() usage), and to
> > recommend that end users tune their warn_limit sysctl as needed.
> > 
> > Being able to TAINT might be useful, but I don't have any places that
> > immediately come to mind that seem appropriate for it (besides this
> > case). Hm, well, maybe in the case of a W^X test failure? (I note that
> > this is also a "safe memory permission" failure...)
> 
> Can be anything that fails in function mark_readonly() ? :
> 
> 		jump_label_init_ro();
> 		mark_rodata_ro();
> 		debug_checkwx();
> 		rodata_test();

Yeah, works for me!

-- 
Kees Cook
