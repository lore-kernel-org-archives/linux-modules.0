Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101369;
	b=3aV6ubhSVEGooVpJ8VcobLAfFUqqjnPclmd+i7bZ/B52QDbzbfwRSes/NKXtJnAXZOK7
	 tcR9LkwISEgvRksYWsmjY7jldIywVvc2thgD1/qFb3lWENXIJNsZp85R6hSTkad8vIfGg
	 m2MizVhSmrlpTcTRWZHTI0D5GbUpvHDJt6HGYFqqlBBM9UswEOVW1vDQgqwFAb3M7KtNn
	 R/2o/84NkBuilFDGXi2V10Yr+luC+xPp14tAEqhkJ9EH3m+Tznv9EWzXg9xpL1KWpyiUR
	 Om/6gH4+oqL3PA9oMd16dq20mhSF0kmpo8wlH61vuIp+cAjMI9dCn/hNxXQrN4ywSrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=s3CxcG8TjIsNEX3XTQx1RyQJmWbMCHa04pEFIgd8c4Y=;
	b=CHT/ozDCkSDqkryPJU/N4tkwzGVupkEXw4xPVche90Geht5Qt0Uy7jsXYrM3BuXd4Noh
	 AFVJ0OtY24megk3RLVGTP94cBLQ9zXkkCkd74LpgcOP4IwIwS2/dsRF/nbXJ3NHBeT9Pd
	 h/Fqk+gkvWzWdXYxugWd61na5aOiIkFe6hgCb6vcDZsD9d9GwBbZqoEwLQK0slK19/y0e
	 bE5ozVARkzEdYXpzgkRUafBhi2IeCgcFEpZUXfaHDBOSGphTcBBsZp7jr5+dOFDLAWm4d
	 oZsN0uDi4O/zL2XbfQlDL1qMnU10RD+9JPpgJIzNivFPUU7xZU4QA6W7LSQIMy0/cyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Sj7hk08a;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9586560A3817
	for <linux-modules@vger.kernel.org>; Thu, 19 Nov 2026 15:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9586560A3817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Sj7hk08a
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-49a92144733so1154048f8f.0
        for <linux-modules@vger.kernel.org>; Thu, 19 Nov 2026 07:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795101367; x=1795706167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s3CxcG8TjIsNEX3XTQx1RyQJmWbMCHa04pEFIgd8c4Y=;
        b=Sj7hk08amywV2a+ldixstVN+k0szBnA3hKiO33MD/5mvxxCEV+XsSYtkR7gWcYKapW
         aJFwfC6w6Wyt92615qCMVYnXzbZsq71rb6cWaFRPnTUoCZPwRd8q15dJiu1VMQEJV+Yu
         VzmpL2HqM4+I//pOBcI16qZ1Qj2Go7Ymjr1mu987B9n6nK769prPkE7Rxm99YSMp/ugs
         waVrlJP0zXXRIpov4AvcUMOigJemMCAGKvYA0tDCZx5tp7NxgOB16OhmpOHGExJ5bxr9
         +RWzfadp9Vj+VeDuPVRZnmyvgnNPVmVQskf0LwwzZNHykDyfnUzu6of3I9gvpO0Ujjgc
         Xolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795101367; x=1795706167;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s3CxcG8TjIsNEX3XTQx1RyQJmWbMCHa04pEFIgd8c4Y=;
        b=ZuO37dg3o+hq7nsgVs2/t42LoDRCGcTEtMCfp6AAduzzNY1Y7e6JY8LJ5m+iwBX/o4
         U4hxOBzm39tNuCFw3NVuqJokuSNcNBC/T91jo9OAr2XSABamzstLW741/kHu5tToZAWN
         t0640aO6lgLfdj0Q4pI0j4hgOCw+zNb9s8MmFBcZu2Y7Dl0RGKv3ISwFXpIjURjuCT5I
         eWFDrlPPT20sQUut1LWlleN258WNI3uTpVAba+pygjUnyyeIbAsV4zHvpeY7uJDhbyx8
         IkuH/QZYBzxpn3kN7KBvSFA+OFAjTZ7H6g+LXKUEBlmV0C3m1JNtqpB+fZ0NdXva06u1
         /hxQ==
X-Forwarded-Encrypted: i=1; AL+hErF4REQLBIhaCwQnbJNb6oi+4470GzXGs1bTZikj8vkgVEwLRAkQc96wP4oRgZnaSgmdY7vyhpttGI53kwpX@vger.kernel.org
X-Gm-Message-State: APuU4Z986xnF52uAXWfqBRDjIn1an4vfetEyBv63qy0MCye9LbB1v+DV
	oNmjh6x/LNRtl+diYRBdaDIPQZnbFWidNIz4FrkZDeALm6u1rka9UmZ9ZecXG5eMKGE=
X-Gm-Gg: AZFdTZcy8Qdq2XZOPgzMQOpOvYwHKne2euuJ6Kd9QeazNc3MkkNMj4vTN00jQhYVX3X
	TFKD3RMLCDkm0En7sOrN8qs193u6UKj6b77gHTHUjxRQXrJT0Y4Nj0IFDPFnCt5qIOmmrI37jPR
	L05EbltkbFh+LzgJLo1KShnZfv204tiErfNa4pvCz9wjkzTsM2OqG/ymr7uUaNj0G9MG9MuKPre
	HNy4+kZZwb5F0SFy9p2YKzMK5eNwlAVSB88URAnSPzpZx+V47NLPvzZ+Th2fs7Nc2OiXxslvMbw
	nlt7dWXbzxV1fZ2Uhhr8dJ9liGazbTJR0FPiLCnweshxmCXkKCJN+mzPwRDHres1TcfCDNCmyWU
	4kFIHHWZWpJUp412F/909AbSmnV+7Mnk+v/350u7LPf44aNCw1Xueonsp3jD7AWHCzAxX9nGw97
	RpjE3hnpUGLpFZX9JaWG3ptBugfEVn6vsMxV1FTTtroMgBnTGD+J0wXnsLNBXxkdGB8yCFVjt3V
	HNnoBpaymKBxODiYNfdy3O3ua4QA71lgZ1w0HmZcR5J7habmY7o6XTA7H33WgylaNPblka4a3Ge
	GRtSPQexN7yCuDxs0cwRuO43oC3u6uA8QrAbg6SZJeYUtrLjUyVc53cflk/PjeKw/HYti3/EQs8
	m9yAN1AIw6Q4=
X-Received: by 2002:a05:6000:4904:b0:493:2eb8:e7fb with SMTP id ffacd0b85a97d-4a65de20a60mr11890050f8f.41.1795101366881;
        Thu, 19 Nov 2026 07:16:06 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2c8csm179261f8f.2.2026.11.19.07.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 07:16:06 -0800 (PST)
Message-ID: <9fc53794-03b7-4092-b190-b56235765a2d@suse.com>
Date: Thu, 19 Nov 2026 16:16:05 +0100
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] module: Fixes to tracking taint flags for unloaded
 modules
To: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261020-taint-unload-v1-0-d1c764889afc@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261020-taint-unload-v1-0-d1c764889afc@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/26 4:05 PM, Petr Pavlu wrote:
> Fix missing taint flags for unloaded modules and a data race on
> mod_unload_taint::count, plus move mod_unload_taint into tracking.c.
> 
> ---
> Petr Pavlu (3):
>       module: Fix missing taint flags for unloaded modules
>       module: Fix data race on mod_unload_taint::count
>       module: Move mod_unload_taint to tracking.c
> 
>  kernel/module/internal.h |  7 -------
>  kernel/module/tracking.c | 28 ++++++++++++++++++++++------
>  2 files changed, 22 insertions(+), 13 deletions(-)

I've queued the series on modules-next.

-- Petr
