Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F948BE8;
	Mon, 28 Jul 2025 06:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753685285; cv=none; b=unpBGO2+eA2GZJJaBGx6RgNBClYMsEI5lYNntzWF+0u91Ma9pepCZTwkRYNFmikOlxWWyuh1qvAh4wv+hlo25hSF1kQW1EfMxvnXX0292NGB2uWL+G7mcHardhat8WJQOHaaTxr56fEtOunABV+0GpnG0LOwUUfENS87jnv8L5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753685285; c=relaxed/simple;
	bh=U87FNw2cjUC/aGeen0DnN0R08YPbs6mZ4gYru6nwT2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3WzlqjHG4tiYu2RgdG0jzWafr8cdc4/3QvKC3kFgmmzls1+jCwhricXbhL/2XaOBys1NDfeSx9+6dl1wSd5SoucKGaVGuktwZmDNIAaU+Bm/D2T6iTepzTA289m+4MDFeVN9h8cvD5wzbIjzfqmexbVIRAbhd4bhWhsIXZqC4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8u6lykz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8u6lykz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BF0C4CEE7;
	Mon, 28 Jul 2025 06:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753685284;
	bh=U87FNw2cjUC/aGeen0DnN0R08YPbs6mZ4gYru6nwT2k=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l8u6lykzFgVHvYLbLAc78I0X8mQdEwQbexFeKIRI1mGSdhHlGB8EGYHGr+Oh46s+m
	 rPQe7hYFyOKt48FoX0E41N46OcSAb3Skm930EmyPe5Sb3TajxPthS4y2Xd1u9yPfb/
	 GGZ3CLv2OtVFmAq9JPsx1gbHRlf2TPO8YmRYddvjqtaYdj/AoQdzQ/Z/JIJz5FIwgm
	 A+eSidu1qtT1qrs4MSN07Q/RkXF+a+uvHM6o3MANbA+TOv79AAL7KU4TIxU66FtowF
	 jBvChc6fKsMkfsv8xnWZKAkZWhFsB4ri8ip4F7iPzmd7+KNeDFZMd7IxQXRdBsSqiq
	 xyvQ59No5CVZw==
Message-ID: <e9caf91d-3a4b-4140-a3bc-0c2b53c0a220@kernel.org>
Date: Mon, 28 Jul 2025 08:48:01 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 4/5] tracing: Replace MAX_PARAM_PREFIX_LEN with
 MODULE_NAME_LEN
To: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630143535.267745-1-petr.pavlu@suse.com>
 <20250630143535.267745-5-petr.pavlu@suse.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250630143535.267745-5-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/06/2025 16.32, Petr Pavlu wrote:
> Use the MODULE_NAME_LEN definition in module_exists() to obtain the maximum
> size of a module name, instead of using MAX_PARAM_PREFIX_LEN. The values
> are the same but MODULE_NAME_LEN is more appropriate in this context.
> MAX_PARAM_PREFIX_LEN was added in commit 730b69d22525 ("module: check
> kernel param length at compile time, not runtime") only to break a circular
> dependency between module.h and moduleparam.h, and should mostly be limited
> to use in moduleparam.h.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>

Steven, Masami,

I'm planning to merge these series into modules-next. I think and Ack/Review
would be great from you. Otherwise, let me know if you'd rather take this patch
through tracing instead (in case it looks good from your side).

> ---
> 
> As a side note, I suspect the function module_exists() would be better
> replaced with !!find_module() + RCU locking, but that is a separate issue.
> 
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 95ae7c4e5835..b9da0c4661a0 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -10373,7 +10373,7 @@ bool module_exists(const char *module)
>  {
>  	/* All modules have the symbol __this_module */
>  	static const char this_mod[] = "__this_module";
> -	char modname[MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 2];
> +	char modname[MODULE_NAME_LEN + sizeof(this_mod) + 2];
>  	unsigned long val;
>  	int n;
>  

LGTM,

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
