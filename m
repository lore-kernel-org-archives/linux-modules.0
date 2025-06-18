Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17D82E7F34;
	Wed, 18 Jun 2025 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255377; cv=none; b=H7XvgRcq1C/8GCIHnARaXlh/Q/M9+WUwl7qSOeCrMohvgDUKW2iH6WNy6o4dmeeaVxpJj50mcPKXUbe4UEDWkf6mTeV76nBBoK4XZMTv8YKKSBqK4Zr51mPoYwzXdDz+BR78PoUIwRQeaNlTvpsx8ffP6h7JQi/HBIEoZWWYvTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255377; c=relaxed/simple;
	bh=G79munEcYtIpW+6TIz0FYZTbqw1Q12VEgJ/b2Srg43M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNKuiFwJ/77uxw91G789GOzKk8ustAjkLMgHQwPwhdDwSvj7LdYiTkRy3TINwcnbWJcqsqKcfoZUXehvmSUqf1oLLwHXXbZUulZPRkqSF7vGtt65HN1bVhuMggemZlnpcotg/Yts8odtG2fhCt8XDoPgAR0YuG3qjVDAlbrVlsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PriHkIOu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PriHkIOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA14C4CEE7;
	Wed, 18 Jun 2025 14:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750255377;
	bh=G79munEcYtIpW+6TIz0FYZTbqw1Q12VEgJ/b2Srg43M=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PriHkIOu+8RGIE2DZpBOq20BWXVxnTMcXRwcYgIg8eTi7T7edVakZSQ5x8HeBtipb
	 WzjfZ02sERcA7W4gpqHUlsq1qWfKYnPXQYjIuj8c5v9x4g6yA8uBlFqhQ4h3U8nVvr
	 8DlI1PjtYlo/U39bdbYkVL4HR+ASmG4tOmQan/PuNj8HvlSlJ7qEIuxVwHpCxTPT+Y
	 RYQNroYhj0pOPqNsUOPrPZMZ7hM+0xQDchqtyf4rJSnX+jJSSLgi3Y/HvY8HrPRMVB
	 Lj1IhNrV1UeEMG6wCch3hjxFhNYb8hJ+m5J6mUyfD+Sc6ARLjY5GbY26b7PQPsUmxL
	 /ialfmOrjwgiw==
Message-ID: <c74f3241-1184-49e8-b6c0-7f08c9c63814@kernel.org>
Date: Wed, 18 Jun 2025 16:02:54 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH v2 1/2] module: Fix memory deallocation on error path in
 move_module()
To: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250618122730.51324-1-petr.pavlu@suse.com>
 <20250618122730.51324-2-petr.pavlu@suse.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250618122730.51324-2-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/2025 14.26, Petr Pavlu wrote:
> The function move_module() uses the variable t to track how many memory
> types it has allocated and consequently how many should be freed if an
> error occurs.
> 
> The variable is initially set to 0 and is updated when a call to
> module_memory_alloc() fails. However, move_module() can fail for other
> reasons as well, in which case t remains set to 0 and no memory is freed.
> 
> Fix the problem by initializing t to MOD_MEM_NUM_TYPES. Additionally, make
> the deallocation loop more robust by not relying on the mod_mem_type_t enum
> having a signed integer as its underlying type.
> 
> Fixes: c7ee8aebf6c0 ("module: add stop-grap sanity check on module memcpy()")
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  kernel/module/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 413ac6ea3702..9ac994b2f354 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2697,7 +2697,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>  static int move_module(struct module *mod, struct load_info *info)
>  {
>  	int i;
> -	enum mod_mem_type t = 0;
> +	enum mod_mem_type t = MOD_MEM_NUM_TYPES;
>  	int ret = -ENOMEM;
>  	bool codetag_section_found = false;
>  
> @@ -2776,7 +2776,7 @@ static int move_module(struct module *mod, struct load_info *info)
>  	return 0;
>  out_err:
>  	module_memory_restore_rox(mod);
> -	for (t--; t >= 0; t--)
> +	while (t--)
>  		module_memory_free(mod, t);
>  	if (codetag_section_found)
>  		codetag_free_module_sections(mod);

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
