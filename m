Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14418BE8;
	Mon, 28 Jul 2025 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753685313; cv=none; b=Gerd38S8yWK2iaqM4tFFhivbX2LDsJI1pgUWqJamr0xHra3yg4eCJbklOkzPVaiiGUwqP2mpNBr7HWI/Yxm56pyWbMwfctlKrurW1lKXI2VGEDaRsCmqpy2OnVWKzfChJr6GB4Em7pHfgsoMPMJQdQQIeBWJD4Zoe7BPeIWEb2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753685313; c=relaxed/simple;
	bh=k7Nd1SEj8Pv+9T8aTbXxS7qhS46/yo1STbc53+lA/7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fcvor2ODQYmd51UMoeKS9Nq/KndoM1Nw/hfeptzB9eRAe/na1xK66V4x1GLh/zFC07Q4R33w5uBkniGssvVE5NXirsBtJPam76LW2Md+u/0ropAX9lYZazEHdOPXFSwOXVYYESRMS/MpAIkM3f/eKr/7VLl9Rxl3U444Z8IWiQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moRdVbfz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moRdVbfz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DECBC4CEE7;
	Mon, 28 Jul 2025 06:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753685312;
	bh=k7Nd1SEj8Pv+9T8aTbXxS7qhS46/yo1STbc53+lA/7I=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=moRdVbfzBEy/JuL3fAPVGuWLO3d4AobDa7+w40Ug3v1UpnxaD0OkBz8fmrZbTNzBF
	 vkCVyMxSpcKBWw92lGIUH1bAz4OE0paZTYm/E2Qzu34iLvXqm73MsEw+wbv/2dBtJ8
	 tnykY1vUe3pGW4FpM2zmCpGdjHYGwDISMRqQyFEbXWfSJK6D2iMf3VSwCLmbj+0LFk
	 BvLu13q2Coq23f1i+y79huGZy4oZ/oCdeHwJmfX7y0kb62u+41iU1u6AZah762lOVn
	 6v3+urmQ04q/olO811wtY9tTLcjEvEXHJr+5z6qVbyGLXgtBdTjonseQPdXLbnaP1u
	 6kYN1hL9Y6jhA==
Message-ID: <93b81672-0604-42d1-8a10-0fc88ba2efd6@kernel.org>
Date: Mon, 28 Jul 2025 08:48:29 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 5/5] module: Rename MAX_PARAM_PREFIX_LEN to
 __MODULE_NAME_LEN
To: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630143535.267745-1-petr.pavlu@suse.com>
 <20250630143535.267745-6-petr.pavlu@suse.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250630143535.267745-6-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/06/2025 16.32, Petr Pavlu wrote:
> The maximum module name length (MODULE_NAME_LEN) is somewhat confusingly
> defined in terms of the maximum parameter prefix length
> (MAX_PARAM_PREFIX_LEN), when in fact the dependency is in the opposite
> direction.
> 
> This split originates from commit 730b69d22525 ("module: check kernel param
> length at compile time, not runtime"). The code needed to use
> MODULE_NAME_LEN in moduleparam.h, but because module.h requires
> moduleparam.h, this created a circular dependency. It was resolved by
> introducing MAX_PARAM_PREFIX_LEN in moduleparam.h and defining
> MODULE_NAME_LEN in module.h in terms of MAX_PARAM_PREFIX_LEN.
> 
> Rename MAX_PARAM_PREFIX_LEN to __MODULE_NAME_LEN for clarity. This matches
> the similar approach of defining MODULE_INFO in module.h and __MODULE_INFO
> in moduleparam.h.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  include/linux/module.h      |  2 +-
>  include/linux/moduleparam.h | 12 ++++++++----
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 5faa1fb1f4b4..0f1dde3996d9 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -32,7 +32,7 @@
>  #include <linux/percpu.h>
>  #include <asm/module.h>
>  
> -#define MODULE_NAME_LEN MAX_PARAM_PREFIX_LEN
> +#define MODULE_NAME_LEN __MODULE_NAME_LEN
>  
>  struct modversion_info {
>  	unsigned long crc;
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index 110e9d09de24..a04a2bc4f51e 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -6,6 +6,13 @@
>  #include <linux/stringify.h>
>  #include <linux/kernel.h>
>  
> +/*
> + * The maximum module name length, including the NUL byte.
> + * Chosen so that structs with an unsigned long line up, specifically
> + * modversion_info.
> + */
> +#define __MODULE_NAME_LEN (64 - sizeof(unsigned long))
> +
>  /* You can override this manually, but generally this should match the
>     module name. */
>  #ifdef MODULE
> @@ -17,9 +24,6 @@
>  #define __MODULE_INFO_PREFIX KBUILD_MODNAME "."
>  #endif
>  
> -/* Chosen so that structs with an unsigned long line up. */
> -#define MAX_PARAM_PREFIX_LEN (64 - sizeof(unsigned long))
> -
>  #define __MODULE_INFO(tag, name, info)					  \
>  	static const char __UNIQUE_ID(name)[]				  \
>  		__used __section(".modinfo") __aligned(1)		  \
> @@ -284,7 +288,7 @@ struct kparam_array
>  
>  /* This is the fundamental function for registering boot/module parameters. */
>  #define __module_param_call(prefix, name, ops, arg, perm, level, flags)	\
> -	static_assert(sizeof(""prefix) - 1 <= MAX_PARAM_PREFIX_LEN);	\
> +	static_assert(sizeof(""prefix) - 1 <= __MODULE_NAME_LEN);	\
>  	static const char __param_str_##name[] = prefix #name;		\
>  	static struct kernel_param __moduleparam_const __param_##name	\
>  	__used __section("__param")					\


LGTM,

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
