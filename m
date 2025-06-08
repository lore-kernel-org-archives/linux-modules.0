Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7325115D1
	for <linux-modules@vger.kernel.org>; Sun,  8 Jun 2025 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749367540; cv=none; b=CirheSpuY9VkfpvsQ05rwmm9kOwGhXHChjbsW19oOG2FE53A49fvfi0U0KGktS07keyFACZ3bzqiBwMVq05dLf8QCla6EwrgQiMnAu20vUIZ/fQawDYeDzdMMgcgv7C04lKWMJMw9B6fohow/eFhy8g2ZtKDCu0pheMpIoDAKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749367540; c=relaxed/simple;
	bh=CjBYKoeh+JUKRiVHmPnsj1xPsz1WrazHWtHcqg6xjhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoFQnjp0WDDzC0IW2BYV/WXVcFjAzaVHwXFSxr/jtKR/HTuID/NJRHo28bTQMLSgdwnhmV+HdCGheWb+of1x3oyk3dzvY6Svjho+vFygKGLnoJ9i0u5q745ZISgPvDDCDNbu99qi1KDGs3ntrG6ChuMvgDmAQYI/TDeWpJ9IqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dO6hgtBL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dO6hgtBL"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so39541585e9.1
        for <linux-modules@vger.kernel.org>; Sun, 08 Jun 2025 00:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749367536; x=1749972336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U5zxKH1RRPFE+pq7qzzrPXBdTSkahxpWL82kTyaPaww=;
        b=dO6hgtBLENEsjmIlf2spsPRu1O5YEurQAXwTlM+ZKvpXbhtyjsXXOPJrYjqJ5WCcmz
         4swoMVswMGwYpL8YGPN9B0iCHXQpJJqGwt7AIAp1IC3Nt3yhhHd4hSY/3PgieJrCe9jj
         cQSUB1K/A23Uhnxq1yZshaMP6ODGCuieTq+PpFHgZOxKRgFN0lUi+ZigiNNgReKaOD6f
         UbcbtZYwjnt943IjT5+ku+9bLNl2dK1v3wkQebqFMmT5SSWfPpNKyTmtLJE9IHaEmKcd
         /ZGl7zQ1B8l+tPcrHG6slaE/gCSZBgB7OFrGmPgV4NOZgwYJbWAAjZUwk5RM7ifIR9hU
         FBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749367536; x=1749972336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U5zxKH1RRPFE+pq7qzzrPXBdTSkahxpWL82kTyaPaww=;
        b=iwOwyE2VopTm2WDPg7IXK41bmHsK3AxJUGEXwJMjebR0hmA6GetOge1gUzxBDrokpZ
         BKzvUUeI+zlzVupuCc6DhSswNjrsR0o3dzWnoFLQUYvYfF5A7Ns+D/dzGzRChbXGPQTt
         h/hm8eIL4IT9qsbjte8TXUNlFcLkLXxB+nM42BYjIuobj7o9XBJljId+LJ7EAFw7p2o5
         eFdTx+FAynbOJM7fHozL+lwq8PLachD+MNyn8TVC0/3F+6ll9E9hGWTBfnACYr1q7ITe
         VJq9lorPFVXA7Wk9inFOr2IZ+ZbS7R2w2yYnlG3ceqtPtN9gwM004/JP4U1WNeXKqZHo
         L5aA==
X-Gm-Message-State: AOJu0Yya70Kby+eX9jVMARH9Jjxn29foMwxkXtrpraHz37Tppkrk/jcM
	lSLAvbf3LkTzh+nUKDWMxnmhOPUr74E9djEkvryzkKq/cyI+RZYahlJfwwTDvV6k9+Y=
X-Gm-Gg: ASbGncsdpUcMeVHdflRtVYnF5MAUXEQyOVDLM0emVLAC5YJzC7J898vREGGrw/LfED7
	Dys/x4eOGn51CRqUmV8N4rFXoBVXb5sVzEH+4WtBjSD6PGpM/ZZdLQ1mEgDnJm+/5yMsoMl25iW
	2II1Xhkgghm0N5E46e71QhX3HKx4l0IYDanxpmJ6Mn0hX3lLughhGw+VzzCjRu8k22QNAo3pdOj
	/YqhrTmhGkJJMnIzEay4cJwTrcSFmIN2SUzntUpg6P+YOQaj6liURqQybsje0ztFdEluiAirEGG
	whVoazo7Y7sJmJeFkq5FTi19ijWAx4R4UG7jxNdrwz/70RL5xtibr8OXZw5VPeecWr04yA==
X-Google-Smtp-Source: AGHT+IF/TT9gpo9gWlFm0wUaY6aLXBpdcRMEPm4klh6YKqHJVpnZ2y/4vfFm+DSI/hGsGt0wqWEm6w==
X-Received: by 2002:a05:600c:1913:b0:453:9bf:6f7c with SMTP id 5b1f17b1804b1-45309bf71a7mr19489325e9.9.1749367535678;
        Sun, 08 Jun 2025 00:25:35 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-248.rct.o2.cz. [109.81.1.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45213754973sm77337195e9.35.2025.06.08.00.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jun 2025 00:25:35 -0700 (PDT)
Message-ID: <f6fa3df3-38d5-4191-96d1-9a8a2152cedf@suse.com>
Date: Sun, 8 Jun 2025 09:25:34 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] module: Fix memory deallocation on error path in
 move_module()
To: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250607161823.409691-1-petr.pavlu@suse.com>
 <20250607161823.409691-2-petr.pavlu@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250607161823.409691-2-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/25 6:16 PM, Petr Pavlu wrote:
> The function move_module() uses the variable t to track how many memory
> types it has allocated and consequently how many should be freed if an
> error occurs.
> 
> The variable is initially set to 0 and is updated when a call to
> module_memory_alloc() fails. However, move_module() can fail for other
> reasons as well, in which case t remains set to 0 and no memory is freed.
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
> [...]
>  	pr_debug("Final section addresses for %s:\n", mod->name);
> @@ -2693,8 +2694,8 @@ static int move_module(struct module *mod, struct load_info *info)
>  	return 0;
>  out_err:
>  	module_memory_restore_rox(mod);
> -	for (t--; t >= 0; t--)
> -		module_memory_free(mod, t);
> +	for (; t > 0; t--)
> +		module_memory_free(mod, t - 1);
>  	if (codetag_section_found)
>  		codetag_free_module_sections(mod);
>  

This can actually be simply:

	while (t--)
		module_memory_free(mod, t);

-- Petr
