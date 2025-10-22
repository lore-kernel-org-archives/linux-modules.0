Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A21A2E8B8A;
	Wed, 22 Oct 2025 22:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761173733; cv=none; b=aj/QRqHlt7pbFYkn35sLhINOyiijz36TUKP06v0544NbmQIwgwM3J0eoAs3X2uMO93v5oKRS78355KqQAd7eAF9gg8wgG1nzVK2EqQj549gad1sOxGQxkuoRN+uFNMx39kVcpyDsCrCzhhRWWc+9nagjBk6dV1oS+EPI8nEVy6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761173733; c=relaxed/simple;
	bh=st3keJq1SZOUE1wb/9HxrMJ0QXtAdueC+3uilToyRKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKijuVRx+om20ClP7v+JIjXG98ZWCJnVCuOkHLD/Ent9nXM//aOh8Fu/Ofc1sS7q/7FtP+0i9E2Lyyem56sNOMja/8JeMHxlSBHu7FaLE0VJzMfLOUwYT1wKevmT/eysZcdEsfd9QuO0O6nsmapYr+4Jh0Sc5Uz3bHSvR8I0UF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTSoNFMB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTSoNFMB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492EBC4CEE7;
	Wed, 22 Oct 2025 22:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761173732;
	bh=st3keJq1SZOUE1wb/9HxrMJ0QXtAdueC+3uilToyRKU=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oTSoNFMBQ4yT9ve8dhcsxhCnucYH9JP7iVEsteFPwVh1ISZOK3qsAmLlQc3Wg/drT
	 XuH1crSk2/7Yd+ZJMXAjdrS0I7Fn5CAo8bkxJOWf1j/pV9duQMYaAZaz0+9b9p9w7B
	 8v8GQw8mg2VVA+/MGUPT0zH4PaoEwY66p9jsoLx9VkkcKEONcN/iS79u2lGYOoiyCq
	 mglxN/8UdTISoEofmr4mLs4HnClfBmd/1LpA/yhs9ppKjYO2pNZ4Nz/tKKnlWnCjA0
	 CKZUVg69HXY0ttOenp/UbNCPqfKXTuLKHz+Ee667+f7z+daMQzlOgpSiCGTosSmdXl
	 S5gw2iJpe8BnQ==
Message-ID: <e237939e-3c59-40b0-97e2-6c038f9e22a9@kernel.org>
Date: Thu, 23 Oct 2025 00:55:29 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH] module: Remove unused __INIT*_OR_MODULE macros
To: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250819121423.460156-1-petr.pavlu@suse.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250819121423.460156-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2025 14.13, Petr Pavlu wrote:
> Remove the __INIT_OR_MODULE, __INITDATA_OR_MODULE and
> __INITRODATA_OR_MODULE macros. These were introduced in commit 8b5a10fc6fd0
> ("x86: properly annotate alternatives.c"). Only __INITRODATA_OR_MODULE was
> ever used, in arch/x86/kernel/alternative.c. In 2011, commit dc326fca2b64
> ("x86, cpu: Clean up and unify the NOP selection infrastructure") removed
> this usage.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

> ---
>  include/linux/module.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 3319a5269d28..e9e6eeb042aa 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -151,16 +151,10 @@ extern void cleanup_module(void);
>  #define __init_or_module
>  #define __initdata_or_module
>  #define __initconst_or_module
> -#define __INIT_OR_MODULE	.text
> -#define __INITDATA_OR_MODULE	.data
> -#define __INITRODATA_OR_MODULE	.section ".rodata","a",%progbits
>  #else
>  #define __init_or_module __init
>  #define __initdata_or_module __initdata
>  #define __initconst_or_module __initconst
> -#define __INIT_OR_MODULE __INIT
> -#define __INITDATA_OR_MODULE __INITDATA
> -#define __INITRODATA_OR_MODULE __INITRODATA
>  #endif /*CONFIG_MODULES*/
>  
>  struct module_kobject *lookup_or_create_module_kobject(const char *name);
> 
> base-commit: be48bcf004f9d0c9207ff21d0edb3b42f253829e

