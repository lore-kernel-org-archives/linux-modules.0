Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCFD84D13;
	Wed, 12 Mar 2025 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741801125; cv=none; b=d6bnjgsSlSw1a7b47+Zd985ChLBtv2hUdUGJthBtqzKwlF1u/aXzupNE/2oAPbF6C4ZdDNKB/0pq50F9X0jX5VrWSX/nwvT2VopIZwWzIpGHs0UvMggLveqb5mKQQmxoc5TogDfOv6PRNH5oG9sMmRk+Up4yQ6lZRwUQAS73ReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741801125; c=relaxed/simple;
	bh=3IQCekR2kO8T0WEg1CoEHBcqTm/HWqSnX3xaIwcLORo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tp+CBtIdo7ukvUp1q+uwZS7gbE1O2lLSRxbzreHlmgTeputLtXpgYJyMXqYk2mQflumJt3O9GIUxj0nK+UAQPuz5to69pf7pDVpJUlUul5GsACJjgWzE5oxYsbJHrwuhsop+j8RX9Eorgu07w3/qmq1LZyLZVAdzkvneWQOdCng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYT/nnLm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYT/nnLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC032C4CEDD;
	Wed, 12 Mar 2025 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741801125;
	bh=3IQCekR2kO8T0WEg1CoEHBcqTm/HWqSnX3xaIwcLORo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYT/nnLm8ww6q2w69OobpziCjXlERE6IOERYBSScUWRxMSFVASe0mELVJ4JcytYGb
	 S6fg2Byp1oA5+rgyZV49iB0a1DUtPvO2RMPMT5+eRml3IhEJzfzgky850WtS+j3GLU
	 zLFKEMTVlkuJCDUm/T+fM/spAETiMyhqdovZ1VOw92jklTu0uOQMjhLebcFb1fWFZ7
	 pZpjGTjkuCxdlemUI67CwDME31GpLkxFbXzcp7RE2dUc7CG665aMGlZkpA/lE9AiF3
	 rjxcbTpyUz8UCIOwMJFUP+6Oo6rcG/WyAvQGBpIYETHdS2jKBhUM7tXElKHEwCGEW0
	 NWH6iBwWv7sWw==
Date: Wed, 12 Mar 2025 10:38:43 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Petr Pavlu <petr.pavlu@suse.com>,
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
Message-ID: <Z9HGoxwTpOfzbBP9@bombadil.infradead.org>
References: <20250306103712.29549-1-petr.pavlu@suse.com>
 <Z8nT8PCPThnfb3Cq@bombadil.infradead.org>
 <c25939c5-d6e8-4450-873b-0a9c774b845b@suse.cz>
 <202503120923.199D458CB@keescook>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503120923.199D458CB@keescook>

On Wed, Mar 12, 2025 at 09:30:28AM -0700, Kees Cook wrote:
> On Wed, Mar 12, 2025 at 04:45:24PM +0100, Vlastimil Babka wrote:
> > On 3/6/25 17:57, Luis Chamberlain wrote:
> > > + linux-mm since we're adding TAINT_BAD_PAGE
> > > 
> > > On Thu, Mar 06, 2025 at 11:36:55AM +0100, Petr Pavlu wrote:
> > >> In the unlikely case that setting ro_after_init data to read-only fails, it
> > >> is too late to cancel loading of the module. The loader then issues only
> > >> a warning about the situation. Given that this reduces the kernel's
> > >> protection, it was suggested to make the failure more visible by tainting
> > >> the kernel.
> > >> 
> > >> Allow TAINT_BAD_PAGE to be set per-module and use it in this case. The flag
> > >> is set in similar situations and has the following description in
> > >> Documentation/admin-guide/tainted-kernels.rst: "bad page referenced or some
> > >> unexpected page flags".
> > >> 
> > >> Adjust the warning that reports the failure to avoid references to internal
> > >> functions and to add information about the kernel being tainted, both to
> > >> match the style of other messages in the file. Additionally, merge the
> > >> message on a single line because checkpatch.pl recommends that for the
> > >> ability to grep for the string.
> > >> 
> > >> Suggested-by: Kees Cook <kees@kernel.org>
> > >> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> > >> ---
> > >> I opted to use TAINT_BAD_PAGE for now because it seemed unnecessary to me
> > >> to introduce a new flag only for this specific case. However, if we end up
> > >> similarly checking set_memory_*() in the boot context, a separate flag
> > >> would be probably better.
> > >> ---
> > >>  kernel/module/main.c | 7 ++++---
> > >>  kernel/panic.c       | 2 +-
> > >>  2 files changed, 5 insertions(+), 4 deletions(-)
> > >> 
> > >> diff --git a/kernel/module/main.c b/kernel/module/main.c
> > >> index 1fb9ad289a6f..8f424a107b92 100644
> > >> --- a/kernel/module/main.c
> > >> +++ b/kernel/module/main.c
> > >> @@ -3030,10 +3030,11 @@ static noinline int do_init_module(struct module *mod)
> > >>  	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
> > >>  #endif
> > >>  	ret = module_enable_rodata_ro_after_init(mod);
> > >> -	if (ret)
> > >> -		pr_warn("%s: module_enable_rodata_ro_after_init() returned %d, "
> > >> -			"ro_after_init data might still be writable\n",
> > >> +	if (ret) {
> > >> +		pr_warn("%s: write-protecting ro_after_init data failed with %d, the data might still be writable - tainting kernel\n",
> > >>  			mod->name, ret);
> > >> +		add_taint_module(mod, TAINT_BAD_PAGE, LOCKDEP_STILL_OK);
> > >> +	}
> > >>  
> > >>  	mod_tree_remove_init(mod);
> > >>  	module_arch_freeing_init(mod);
> > >> diff --git a/kernel/panic.c b/kernel/panic.c
> > >> index d8635d5cecb2..794c443bfb5c 100644
> > >> --- a/kernel/panic.c
> > >> +++ b/kernel/panic.c
> > >> @@ -497,7 +497,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
> > >>  	TAINT_FLAG(CPU_OUT_OF_SPEC,		'S', ' ', false),
> > >>  	TAINT_FLAG(FORCED_RMMOD,		'R', ' ', false),
> > >>  	TAINT_FLAG(MACHINE_CHECK,		'M', ' ', false),
> > >> -	TAINT_FLAG(BAD_PAGE,			'B', ' ', false),
> > >> +	TAINT_FLAG(BAD_PAGE,			'B', ' ', true),
> > >>  	TAINT_FLAG(USER,			'U', ' ', false),
> > >>  	TAINT_FLAG(DIE,				'D', ' ', false),
> > >>  	TAINT_FLAG(OVERRIDDEN_ACPI_TABLE,	'A', ' ', false),
> > > 
> > > Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> > > 
> > > For our needs this makes sense, however I am curious if TAINT_BAD_PAGE
> > > is too broadly generic, and also if we're going to add it, if there are
> > > other mm uses for such a thing.
> > 
> > I'm not sure BAD_PAGE is a good fit. If there was a new flag that meant "a
> > hardening measure failed", would that have other possible uses? The
> > semantics would be that the kernel self-protection was weakened wrt
> > expectations, even if not yet a corruption due to attack would be detected.
> > Some admins could opt-in to panic in such case anyway, etc. Any other
> > hardening features where such "failure to harden" is possible and could use
> > this too? Kees?
> 
> Yeah, it could certainly be used. The direction the hardening stuff has
> taken is to use WARN() (as Linus requires no direct BUG() usage), and to
> recommend that end users tune their warn_limit sysctl as needed.
> 
> Being able to TAINT might be useful, but I don't have any places that
> immediately come to mind that seem appropriate for it (besides this
> case). Hm, well, maybe in the case of a W^X test failure? (I note that
> this is also a "safe memory permission" failure...)
> 
> How about TAINT_WEAKENED_PROTECTION ? Or something that carries that
> idea?

It's different, but hw poison [0] already has policies for running into poisoned
pages through MCA recovery, there are a few sysctl knobs to tune this,
for example vm.memory_failure_recovery set to 0 will panic on a hw
poison page.

A hw poison event without a panic seems like a possible use case for
such a taint TAINT_WEAKENED_PROTECTION?

[0] https://github.com/torvalds/linux/blob/master/Documentation/mm/hwpoison.rst

  Luis
