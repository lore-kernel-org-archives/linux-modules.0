Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4231C284662;
	Wed, 18 Jun 2025 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255348; cv=none; b=uqhIHLYjLKdYulY7YN/kfUlKOYKhgNOD6qibzje4e2+C8gr8+mvQNLPbRipv3ozNXAI2yyyBuP1so/xfyTfIbWH6OfJrMZNhOTug2F+PhaKTBqWGU0UmP0q7dlX8qkiZlg8Stjnu/DP+rr/MOlJIGIJ70mK2TLjtprH6rkLsbt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255348; c=relaxed/simple;
	bh=asOR/3iEfhau6MrfKDoTqszE6kJktjHuGUyDhZZYKR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXm86d8VFVyTu9e6D94U6qFTGfKgr1Ai7hb1zfmErWMx+/Li2I7nRvmQy9wPJndM5jupxdleQnYoBrR4hWhnzQHN1PTC9jucK7gU3ZA1LG9MzPuKtSfdVa1hSTC0GI8HQR2zRgyT8Vdg1ZoYalJzV7JO77T1gt8/AgcsGyMfPik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtasbFNe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtasbFNe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C9AC4CEEE;
	Wed, 18 Jun 2025 14:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750255347;
	bh=asOR/3iEfhau6MrfKDoTqszE6kJktjHuGUyDhZZYKR0=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YtasbFNevI1ocnwsRxNWApoxe5yX7kFaq752PbGzjS5LTaNwK/L5ofbDhAOv+Pfi/
	 OpjkSwHwoosHM5UDIQXEiH7CR7AFWbRFP2ZvO5gdj33REzjbX/bc5l3I8FtQnnWrCu
	 6EvuTh7qkB/0N4HAgsgitwSneySV+9gYiAunVmQH2Zq0EAOyOSHjoqGvTlBYuKIuzG
	 v+t8wYRisf36MAiuziLzth/ZlGCzCLSRt3jMG34EBZfYPUqV3aW7j3JM7dHq5D8xg0
	 jSx9IA3fi9fU8CxnmVzMOfUFq7byjdpPHLxxDYQiU1qwHa0BJLlJWf4yIRMOL+yoJ8
	 dRDrABXw6X5Ig==
Message-ID: <ea71cdda-32ab-43c1-8135-25856e76dcf0@kernel.org>
Date: Wed, 18 Jun 2025 16:02:23 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH v2 2/2] module: Avoid unnecessary return value
 initialization in move_module()
To: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250618122730.51324-1-petr.pavlu@suse.com>
 <20250618122730.51324-3-petr.pavlu@suse.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250618122730.51324-3-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/2025 14.26, Petr Pavlu wrote:
> All error conditions in move_module() set the return value by updating the
> ret variable. Therefore, it is not necessary to the initialize the variable
> when declaring it.
> 
> Remove the unnecessary initialization.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  kernel/module/main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 9ac994b2f354..7822b91fca6b 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2696,9 +2696,8 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>  
>  static int move_module(struct module *mod, struct load_info *info)
>  {
> -	int i;
> +	int i, ret;
>  	enum mod_mem_type t = MOD_MEM_NUM_TYPES;
> -	int ret = -ENOMEM;
>  	bool codetag_section_found = false;
>  
>  	for_each_mod_mem_type(type) {

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
