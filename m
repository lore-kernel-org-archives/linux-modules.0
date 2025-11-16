Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055333594F;
	Sun, 16 Nov 2025 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763325990; cv=none; b=rwY6jYlmdtunHsKcWdxYBu8FO0/SqPCNihWkvSx9BP+JstZjgWH4zkjteHb54wxXxe6DiPDKHNYsuAr+WBUYEtoH3BbqkYpvnzla+vRQ7QwkPIxFL/6yiAZy2/Y0qo2aqMMNq20RZ5PEOaS/KC3r9ztgBYbuL/GQWQrHEf39mAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763325990; c=relaxed/simple;
	bh=8IvvZgLhN59HeZjK9sFs0VyejYvKroOcAGKaEBMOefs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1/XakdO2J7mNmC3iqT/psVZdrqMKUWP+lmcpzq9VXf3yFn8YICfEG5Az3STeVTmP5rgTeOXMyVYO6wk7shM9YDJIdYktXnA/mwkROCcNn0/gwXqSRD/QV8Cex2WToKQNpIK37YtmEIjCIkIz29/sCVr28tDrIW5dVCdmbpEuNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcE67N0V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcE67N0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF152C4CEF1;
	Sun, 16 Nov 2025 20:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763325989;
	bh=8IvvZgLhN59HeZjK9sFs0VyejYvKroOcAGKaEBMOefs=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BcE67N0VO4OzCY1lUxzCNSP2A1jALcoY89I/NCIP2f7G3RdNaP8X3tOZcuiWwQ+zE
	 7UnBHl59YVHGNZ7R7h1M/W87Qp5hIYCtp1UwqaxQqo1fmUaAU1QXJbgyDOys5WkDUy
	 khJAQuUfSa6MeiSB0qN3uiy4YW+DrWcmCGl2MRQdKaUPIXRUsBwmkT4NBiE3vda1nD
	 ukria3obJ2XGoKvT1n1/Vune9c1K6kLIQP1IeY3XHnd7zMZ3Ck2b6lnD0cM+fG1TMe
	 HBAM+vt8dcNvp0wZYzyroptxSCgIkoDGikjV9UoiC9RZLe0/lSKe/eXTK+Mw7TgfiB
	 1sir8zEAEo7RQ==
Message-ID: <17dae27f-12c6-4a7b-b315-f7404abeae70@kernel.org>
Date: Sun, 16 Nov 2025 21:46:26 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 1/2] module: Override -EEXISTS module return
To: Lucas De Marchi <lucas.demarchi@intel.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Petr Pavlu <petr.pavlu@suse.com>
References: <20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com>
 <20251013-module-warn-ret-v1-1-ab65b41af01f@intel.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20251013-module-warn-ret-v1-1-ab65b41af01f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/10/2025 18.26, Lucas De Marchi wrote:
> The -EEXIST errno is reserved by the module loading functionality. When
> userspace calls [f]init_module(), it expects a -EEXIST to mean that the
> module is already loaded in the kernel. If module_init() returns it,
> that is not true anymore.
> 
> Add a warning and override the return code to workaround modules
> currently returning the wrong code. It's expected that they eventually
> migrate to a better suited error.
> 
> Closes: https://lore.kernel.org/all/aKLzsAX14ybEjHfJ@orbyte.nwl.cc/

Technically not true anymore since I delayed this review for quite some time.

FYI, this other patch actually fixes the problem for that driver:

54416fd76770 netfilter: conntrack: helper: Replace -EEXIST by -EBUSY

> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  kernel/module/main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c66b261849362..74ff87b13c517 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3038,6 +3038,11 @@ static noinline int do_init_module(struct module *mod)
>  	if (mod->init != NULL)
>  		ret = do_one_initcall(mod->init);
>  	if (ret < 0) {
> +		if (ret == -EEXIST) {
> +			pr_warn("%s: init suspiciously returned -EEXIST: Overriding with -EBUSY\n",
> +				mod->name);
> +			ret = -EBUSY;
> +		}
>  		goto fail_free_freeinit;
>  	}
>  	if (ret > 0) {
> 
