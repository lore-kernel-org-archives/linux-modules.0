Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9767D139E;
	Thu, 20 Mar 2025 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473995; cv=none; b=j5LWE3wz3LgU2CoVQuEB5vDxmE8Fnfquqd6Os2Lu4zGne+r/FmRCPCtCxQebLbrSCpZ8l416oHUgHnIazOGjHU5PTG1iiJ7mSiG08iN94fqUIk4WblfbCoA7bv/7hLu+engloojk9OFbXQdek8gHIn8/w3vIKDADCqthgrtPKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473995; c=relaxed/simple;
	bh=8G0b6aj9wz9P0NoVVC9GJR8BMwPTa2rqfrK2RhHdplM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmbvNiwVa4EApOocSED3/oqN9wISp41JzTxEARUex+yVYWH993NQB0sqRD+ZVOGB9gV8ExpJjIfcvZS9rjh0dzRba0oKoX5DmMRQecE/VmseAevEw00t9jOngP81WzBCM0dCbHeXmoajxlmGhjKdb6e/lgqlW258p+4d5mBrLAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTjbgLvX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTjbgLvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88562C4CEDD;
	Thu, 20 Mar 2025 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742473995;
	bh=8G0b6aj9wz9P0NoVVC9GJR8BMwPTa2rqfrK2RhHdplM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bTjbgLvXivLxdxDwR/uQQTB2BWwiOcbehfh/Dg+pWiz+BXP1sgTL8MW3JikJrMCwR
	 K0Vj7DzWCTInPcV9CdsxXJ8or0R0foJrFB2XqbY7BHC1I3suwivpa26LKkJr4uM5pJ
	 DrKAbgRRK2dDT5CIrvZKyJiyGWOIh1tGp1EwXSFkOnrN+Ci9WcbwHAcu7jUnQlxA3s
	 GtNLaZDgSC28Y+6CBCUQvlE+rttwN+33DXNNApY6QvoFdcj/hAhTcnv/+xMnbKZh59
	 igxsNz96VbGH2jyXc3ZutOJQFliELZjwd2ibwczdbjXKqnVq2i7JtUUOmNxNyIW1tG
	 0VS9AjEh9Bfaw==
Date: Thu, 20 Mar 2025 13:33:12 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Jani Nikula <jani.nikula@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, John Ogness <john.ogness@linutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Taint the kernel when write-protecting
 ro_after_init fails
Message-ID: <d65wbmp54onniprsai73siwa4pqcmmzlzag53l72sucq6irp6r@vwhbn2bkvptu>
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

This is quite large. Can we simplify it?

For 1 line grep parsing we can start writing at the beginning of the line as
it's done in some cases in fs/xfs/xfs_super.c. Proposals:

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 6d1094c6dea8..fc5510b8aa14 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2982,7 +2982,8 @@ static noinline int do_init_module(struct module *mod)
 #endif
        ret = module_enable_rodata_ro_after_init(mod);
        if (ret) {
-               pr_warn("%s: write-protecting ro_after_init data failed with %d, the data might still be writable - tainting kernel\n",
+               pr_warn(
+"%s: write-protecting ro_after_init failed with %d - tainting kernel\n",
                        mod->name, ret);
                add_taint_module(mod, TAINT_BAD_PAGE, LOCKDEP_STILL_OK);
        }


diff --git a/kernel/module/main.c b/kernel/module/main.c
index 6d1094c6dea8..4fa0c80b2bb4 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2982,7 +2982,8 @@ static noinline int do_init_module(struct module *mod)
 #endif
        ret = module_enable_rodata_ro_after_init(mod);
        if (ret) {
-               pr_warn("%s: write-protecting ro_after_init data failed with %d, the data might still be writable - tainting kernel\n",
+               pr_warn(
+"%s: ro_after_init failed with %d, data might be writable - tainting kernel\n",
                        mod->name, ret);
                add_taint_module(mod, TAINT_BAD_PAGE, LOCKDEP_STILL_OK);
        }

Daniel
