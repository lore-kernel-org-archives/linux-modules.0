Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCD43BCD17
	for <linux-modules@vger.kernel.org>; Tue,  4 Aug 2026 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832984; cv=none; b=vBaIGJsb4UbBG9Ys07N3wQ5eRg+btEr73o2y+UdgiH+Tf8yPeRI4DPjJbTW9Cabzg1QddrfRUGf5PZFd5/6T8sCXRWXJiqK+Bn9ohoUi9HZSwX6J3U7gGkVIZCafoNa/Cdqi5Bw8j7kSVaUzlMoZahfABKiBpr3+4Xvee/e+CW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832984; c=relaxed/simple;
	bh=6TLC9/7ZoU9gYJEbBF5hXMTDlsm/DxMOhd7D4Yi4qP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCFVD/DQh7o+jaoTBDlh2PfqrjkQjQfHrUmT/P1KxP8xIc6qD1Ux41c1kg9ZSaefdJplFcF++QLia8/gLrftV5UEDOZAYkmDFm6k56ru02Ol1LejkIOkZdnDrkNGPYGIoZARamj2f1Mz+PuRzn79lM4BYFhgkxE0aJrtreqv2RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AOB4ewC2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AOB4ewC2"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49548e01d02so16721985e9.0
        for <linux-modules@vger.kernel.org>; Tue, 04 Aug 2026 01:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785832979; x=1786437779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jbldVeeF/KP7W3Olw45BNCoavqWALya2eVZqAm3Zd6k=;
        b=AOB4ewC2a1Yq7dVc90+FBvOuE3hzctE/+ZkWAPZKaZ3n9jwBTebc8HGri2X+OGdoxz
         3epvpQU4xlWhDKU09/dpYmlwD/sbOm2w1cpieT3HqesD/UhRQx5CGDHHhVLFEI4f0YUo
         I1fNWOLE1JgF1Ye5YKh41ugj5EXtzRr+uOoLVTS4z2UpWGqqqJggHVtFzYo1yVWOBdNC
         UgF+l/VjLHqhCOFrW8bd6UKRDmEx9Qyvl0QCrrL8LYvBSisWD25lUaDux4OHJ2f/hONk
         z429d3jS+k+XjyisSAta/g8kf4gmX+8zW0rwWEQqXzXlq1FHo5EFmulfNxEot6LBPj/V
         0U9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832979; x=1786437779;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbldVeeF/KP7W3Olw45BNCoavqWALya2eVZqAm3Zd6k=;
        b=Uq+AQehiO2OVb6aroM3at5qzo4SfZ79cHfoUBSxsM2eegX7BxZ5w9cNst/JmbX5sfx
         x2sOae/k/R+fgCxSZD/QXhnWC4mCzOWFt8sb+7TKxdtP3MD2UkxwYNusDVXFnYYkNxaT
         HAkfpsKbgfI6xi4b/FV7bxr+1cfKpBE4TFavRUfcPtlIUvOBs8IO01RIXexQeIzVXVIe
         ITA5NEBLjmaPSaA1s1cBmzrDdN5lq9wJ0y8ZdB3KTbCvlY0+lmnfe2Ao0+KcoOx9a7Te
         iq+cNlsfKr40wgrBtp8VOrU7tcO/iDTlxqCSJesCwdsrdhDjhbYxpyRBsgcMLQEuL9pV
         mIEw==
X-Forwarded-Encrypted: i=1; AHgh+RpUuJh1Ch3jb7aqa2slweDLSyz/68jqXixUmLuT4WOwqU9IJBvTuxjullK/gHHugCxFPXm4XgfeaX6wp4SW@vger.kernel.org
X-Gm-Message-State: AOJu0YwF6F7ikybiHPRyiIvnKuX55PmS584F5CAMFlohgo6/GpPxE96g
	zpkujJFrFiI0j6yxvtV3E6vVO9RiMtn+MC62orue6JR2uCGHe5n02n9jNVg7+57hQEs=
X-Gm-Gg: AR+sD13qB68wxmWHnTMFj5DejDrUeaLLwF0aH3M2MGeUlRmns3ZxxeFyDo6WCdMFNwc
	mo4spqHvX4VrQte3Wbd6oy32mdDxia+S+QuLHi0Y49F50rURXh/+BTizZeAfQfmMCSmFrjO4z6M
	hxwrIRULnlmkYooPigJ+F3WGV3n9nxFDTC+jHlUo/CLmmrvmAE7xkgxNrSKrDrSEtvjcHVKNcgr
	QcaXs/qkWoMAg7ce0QKHuoTDsfmEdcYqBfj+ns9eqNipc9rD4fvrynLDLERusRe3eJm9bfJ/vba
	+dy/utmXKuC6hWqK2Ulw+HenT03X+acvFYuQ/Sfc7ZvKNZq4OdsShbprw7ok8L8qyKVpWqaKIfC
	B/Oe7I5cUMBDKs2XbUGqZKFf4zR1vu4lPJhQXq7Zn+uaMl726+hudlrMz3AaDUnWIjcXqUq0hIf
	s9lTVRGgSltL6iew8YAf0hN2A2FhVNFPCysgJetYxuGrMqZz4Mg0Zf3F/NQdFItOLEYfQNjXD3h
	P2iNYRxQ/QFu5GESL1JR9QpEQ==
X-Received: by 2002:a05:600c:4e89:b0:495:5e3d:15e1 with SMTP id 5b1f17b1804b1-4980c6788f8mr270438195e9.16.1785832978799;
        Tue, 04 Aug 2026 01:42:58 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a1240sm40009708f8f.36.2026.08.04.01.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 01:42:58 -0700 (PDT)
Message-ID: <8d507b50-b5a2-48a8-a4bb-f196ac28b5e4@suse.com>
Date: Tue, 4 Aug 2026 10:42:57 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: fix UAF and GPF in idempotent_init_module via
 heap allocation
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Johan Hovold <johan@kernel.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260717082601.81704-1-25181214217@stu.xidian.edu.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260717082601.81704-1-25181214217@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/26 10:26 AM, Mingyu Wang wrote:
> During concurrent module loading (e.g., triggered by syzkaller), the
> idempotent module loading mechanism uses a local stack variable
> (`struct idempotent idem`) to track the state of waiters.
> 
> If a task executing idempotent_init_module() is abruptly terminated
> (e.g., killed by a fatal signal or otherwise completely exits before
> reaching the list cleanup paths) after adding its node to the global
> `idem_hash` list, its kernel stack is prematurely freed and reclaimed.

I'm confused by this description and I'm not sure what problem the patch
is trying to solve. A task is not normally terminated in the middle of
a syscall. This could happen only if it hits an oops. However, that
means there is an earlier bug and the module loader isn't expected to be
resilient to a post-oops state.

Could you clarify the scenario that you ran into?

-- 
Thanks,
Petr

> 
> However, the stack-allocated node remains linked in the list. Subsequent
> module loading attempts that traverse the list will dereference this
> stale stack pointer, leading to KASAN slab-out-of-bounds reads and
> General Protection Faults (GPF):
> 
>   BUG: KASAN: slab-out-of-bounds in idempotent_init_module+0x54a/0x620
>   Read of size 8 at addr ffff888106367df8 by task modprobe/433
>   ...
>   The buggy address belongs to the object at ffff8881063676c0
>    which belongs to the cache shmem_inode_cache of size 1392
>   ...
>   Oops: general protection fault, probably for non-canonical address
> 
> Fix this by dynamically allocating `struct idempotent` on the heap
> via `kmalloc_obj()`. This decouples the list node's lifespan from the
> process stack, ensuring that even if the task is abruptly terminated,
> the global list safely points to valid heap memory until properly
> unlinked, preventing memory corruption.
> 
> Fixes: 9b9879fc0327 ("modules: catch concurrent module loads, treat them as idempotent")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> ---
>  kernel/module/main.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a605..39f05ac4b1a1 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3779,21 +3779,29 @@ static int init_module_from_file(struct file *f, const char __user * uargs, int
>  
>  static int idempotent_init_module(struct file *f, const char __user * uargs, int flags)
>  {
> -	struct idempotent idem;
> +	struct idempotent *idem;
> +	int ret;
>  
>  	if (!(f->f_mode & FMODE_READ))
>  		return -EBADF;
>  
> +	idem = kmalloc_obj(*idem, GFP_KERNEL);
> +	if (!idem)
> +		return -ENOMEM;
> +
>  	/* Are we the winners of the race and get to do this? */
> -	if (!idempotent(&idem, file_inode(f))) {
> -		int ret = init_module_from_file(f, uargs, flags);
> -		return idempotent_complete(&idem, ret);
> +	if (!idempotent(idem, file_inode(f))) {
> +		ret = init_module_from_file(f, uargs, flags);
> +		ret = idempotent_complete(idem, ret);
> +	} else {
> +		/*
> +		 * Somebody else won the race and is loading the module.
> +		 */
> +		ret = idempotent_wait_for_completion(idem);
>  	}
>  
> -	/*
> -	 * Somebody else won the race and is loading the module.
> -	 */
> -	return idempotent_wait_for_completion(&idem);
> +	kfree(idem);
> +	return ret;
>  }
>  
>  SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
