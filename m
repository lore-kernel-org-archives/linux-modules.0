Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D7D248F73;
	Tue, 10 Jun 2025 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749581474; cv=none; b=nEP2LgYSng+q7Crwd8SVki21qRftbjzCCK45HkAj3D/o8sf+Rqu21Ce7z6V9EVzNhC5Eoqot+8hw5FBrtdCXiOmy+2bqGsbBx6SQbqEkRDv/QNS5CrJ/P0VJiOPHGeNci1evc0E8KpUcCaREwwoPolvuv1xbzrPiohPN9PADEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749581474; c=relaxed/simple;
	bh=m9y2P9EaULw/gmgZbggcLisvtPPWJ0chjfyR/LQuqt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDJHGVXCkowuECK3v4UKsFEt+lj2DOyq2ZCB/vKSF9gY9suOrYEPw8YxbJuxChTc5yFR99hsYRn6F7r+P7+/i5dtosLHD5KCqFh+KaE8nhvBaWUasL5RE4glql4/X8ot4QbnIwn076xwrRDY/ZEz41Lc+AaqXXqDgdtYGowvV2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb0EshtA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb0EshtA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8426C4CEED;
	Tue, 10 Jun 2025 18:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749581473;
	bh=m9y2P9EaULw/gmgZbggcLisvtPPWJ0chjfyR/LQuqt4=;
	h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
	b=Qb0EshtAiMHY/HarTJpAGEVcSi2EkI4TDnAtSGHZ+mPlDm1jqEIjqMSnvdr8YpweB
	 YaZWwqvqYkFLppGnM9h9Y/9pLpOcHQTSXf+N/wTcFysUogsZrikIX3FSCY479fU5IX
	 Q8xWx+zZqZfVUulgvEEreNUaZkQGHeRso8G43rCf2d1ClohfMqRlFtFXl/Vb+RUSP0
	 dYxH+7mLtV9bTeoWDrCfVHY/ElUYFU861WLYnkX/GxWmIkvYhC1vpI9UdgAZw73jhC
	 R5ZY/IvZCsYL77vAR933GBsBxT1qszy95qaQMp3p6wo/G6hfHNU7kN9/Ebud/bHk0O
	 R9HIXFcpSznZA==
Message-ID: <ae967353-71fa-4438-a84b-8f7e2815f485@kernel.org>
Date: Tue, 10 Jun 2025 20:51:09 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] module: Fix memory deallocation on error path in
 move_module()
To: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250607161823.409691-1-petr.pavlu@suse.com>
 <20250607161823.409691-2-petr.pavlu@suse.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Reply-To: da.gomez@kernel.org
Organization: kernel.org
In-Reply-To: <20250607161823.409691-2-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/06/2025 18.16, Petr Pavlu wrote:
> The function move_module() uses the variable t to track how many memory
> types it has allocated and consequently how many should be freed if an
> error occurs.
> 
> The variable is initially set to 0 and is updated when a call to
> module_memory_alloc() fails. However, move_module() can fail for other
> reasons as well, in which case t remains set to 0 and no memory is freed.

Do you have a way to reproduce the leak?

> 
> Fix the problem by setting t to MOD_MEM_NUM_TYPES after all memory types
> have been allocated. Additionally, make the deallocation loop more robust
> by not relying on the mod_mem_type_t enum having a signed integer as its
> underlying type.
> 
> Fixes: c7ee8aebf6c0 ("module: add stop-grap sanity check on module memcpy()")
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  kernel/module/main.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 08b59c37735e..322b38c0a782 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2614,7 +2614,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>  static int move_module(struct module *mod, struct load_info *info)
>  {
>  	int i;
> -	enum mod_mem_type t = 0;
> +	enum mod_mem_type t;
>  	int ret = -ENOMEM;
>  	bool codetag_section_found = false;
>  
> @@ -2630,6 +2630,7 @@ static int move_module(struct module *mod, struct load_info *info)
>  			goto out_err;
>  		}
>  	}
> +	t = MOD_MEM_NUM_TYPES;

Why forcing to this? I think we want to loop from the last type found, in case
move_module() fails after this point. Here's my suggestion:

diff --git a/kernel/module/main.c b/kernel/module/main.c
index ada44860a868..c66881d2fb62 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2697,7 +2697,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 static int move_module(struct module *mod, struct load_info *info)
 {
        int i;
-       enum mod_mem_type t;
+       enum mod_mem_type t = MOD_TEXT;
        int ret;
        bool codetag_section_found = false;

@@ -2708,12 +2708,10 @@ static int move_module(struct module *mod, struct load_info *info)
                }

                ret = module_memory_alloc(mod, type);
-               if (ret) {
-                       t = type;
+               t = type;
+               if (ret)
                        goto out_err;
-               }
        }
-       t = MOD_MEM_NUM_TYPES;

        /* Transfer each section which specifies SHF_ALLOC */
        pr_debug("Final section addresses for %s:\n", mod->name)
