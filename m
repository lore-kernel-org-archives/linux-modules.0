Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145CA3DD861
	for <linux-modules@vger.kernel.org>; Sun, 16 Aug 2026 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786872608; cv=none; b=bYERIwsTq59dyb1mgsQTqMFAf+FDElspiNtTOmzprnUIUD93mhCtMLJTufa1fbxz/RL6zIqEZzmgNgxtVrEIit03KGZFM/n/VeVlY6o820WvLsa8h+TEMfljdb/fCqvUN1w7KWiPE3V/ulTcOXhmI+fR9I24rCa8xY8qR59Sigs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786872608; c=relaxed/simple;
	bh=rf6Zv7aaumfL97sFKfE4by4/1kdp0Np8vyoyNbuZMdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pWkARWzbDeuJfuyhLJgsIHmJ2AFbsiXUPSCjZsSM1q1DjiDRq+p0d2rpn9QVEjcXkOZoDA9+xfK8BiT6kR1mgO7wb7wAdK3Lsyw+2cVs4wygvWEjBKXKQmtkpJgIvxdteOBMYTT344qsFwK/CIim0ppxzmMcZpv39hcJklfXcdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KAcK3ivp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KAcK3ivp"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f904e80eeso2442213f8f.1
        for <linux-modules@vger.kernel.org>; Sun, 16 Aug 2026 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786872603; x=1787477403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HYO0v0mYby1fN7mZljAuJT92KJjaxa1LNtL8cC5NBWA=;
        b=KAcK3ivpRVWYn790jZUwJYlxGgjkDtGPnVtIWfIpuAmeeILXnJHsbOJDpDHzJbrxe+
         IH1W3U04a4Y4CkdSudZCCIaV7vRSz/mQSLC0Kw8iS2AxZdl9udff50Fj0th6k9ApsVUy
         8R5C+3fOFuijlUtVxi5XLQLRrFDmfDpQsOyO/lGIT6qYME4P0xSaaYKCz+JEPoBe7XLX
         vu85TDFwgs/k9yK5704SuleNPjIHfU1iEjTbNCFrHsYGD7YLN+Iv3oz+e/H0Wg/CGv19
         qD/vH8ULN5xXdP35xpxQjtT5vDJjmjEFw7GCOyx8Cz927j9UMRYbUDqU+qaEKP9ld6Kb
         hm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786872603; x=1787477403;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HYO0v0mYby1fN7mZljAuJT92KJjaxa1LNtL8cC5NBWA=;
        b=N/1m9SiDunsMU1prJXDgbGbc9csGQvMoibAkzz4P+F5FS5JmrE5iYTMhOzG1KBj1F5
         ypMOoa1z784vqLs8Jxds1JbhJ6qxw4b5r2btLhJr2tOZVoB+7mVqt6vdIMNBVTiXYLBI
         WwsAVkCfb51GBYBkOwqxT6RmqKJ945exOmXr4a4uPr++5nr3PrdW+j8UEUWwvuy+7QC7
         JkemRuF58S+Zw2YvBXrJHHH0FNftus4hLjIH5pIqEqPs1IAPJ9JtvvPsO2idI0E2B5T/
         2RZXormuphd8cfJjfRMo1PoGTCHz7sVxPHbV84hBSUvhHzYnPtNhu1X+ICTSyisxVFaZ
         UyFg==
X-Gm-Message-State: AOJu0YwxWZEVtC06Go7CJvTdjE4e1oavBp4irFQHA0jtoA9uga7VzcbN
	vzbIZhUMhKsxO/ALNbad/Y0WTKtADdFCpHsaKH72e/z7ink7cVsVnkN6N4bJBDQi5bk=
X-Gm-Gg: AR+sD13H5j7vYbrGAv/03QwmXtAmq09IRLfsG8jGSRjY0ak+c7Git6dW1vTOixTEIdU
	JIz4p/NcZYzeNH9dyy57eH//pdUm2z8xs7dqvTkRX3YLbUpAKHhe4IMpbroF8Q/vNe/FYb4IIrb
	diMOPovoSEjl17UDnsQkQZLjVL6AV/GVlb3vii2oDUiXULRSOA/CHn4eCJBQOFzkkKnD8LG/lKs
	+q43DUQ2dqNC/8H2kqoawoWotAJy+YJS65IlF3o6WhcKI7aDrTYN8QhzwWiG3voopALIecsTHRc
	/nGXjYaVJJtKjO0kIBmET2Wj+qFSecP4FP8t4A5b+KDx6hfys5EqRo/U9uTbQpuZHztH+E2IPs1
	Zp42ncQW6xDHxild9Ywg29RHPq7ijwDyVH1frRDeAzpMVdfZSYYWWp9SNeJxM+smNOjguHSBLY7
	YO0mUNdx0HN8yqA+pj6mOqOFWe0S43Exf7ob47mqYhB9zrBLG4n680zGuo7xpFWtMSyjBw1+NRq
	ZRbudHMWOr5FV7aS8bmgdiUYTYqKpUWURA=
X-Received: by 2002:a05:6000:41e8:b0:481:5edd:1b6c with SMTP id ffacd0b85a97d-4816070c47emr28246971f8f.7.1786872603310;
        Sun, 16 Aug 2026 02:30:03 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2cc811sm23769861f8f.33.2026.08.16.02.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2026 02:30:03 -0700 (PDT)
Message-ID: <0d11ebbb-2e9c-49f3-a550-760b5a94dfe0@suse.com>
Date: Sun, 16 Aug 2026 11:30:02 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] slab-use-after-free in idempotent() during concurrent
 finit_module [syzkaller] [ath10k_pci]
To: Yang Zi <2959243019@qq.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_95B4D4B2EC1DAF3C31FDD07D6FA8B3FA9907@qq.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <tencent_95B4D4B2EC1DAF3C31FDD07D6FA8B3FA9907@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/8/26 7:00 PM, Yang Zi wrote:
> Hi,
> 
> While fuzzing the kernel with syzkaller (KASAN), we hit a slab
> use-after-free in the module loader's idempotent path. The crash is a
> Read of size 8 in `idempotent()` in kernel/module/main.c while
> concurrently loading modules via `finit_module`, when the load fd is
> `close()`d from another thread.
> 
> Reproducer summary:
> 
>     BUG: KASAN: slab-use-after-free in idempotent kernel/module/main.c:3682 [inline]
>     BUG: KASAN: slab-use-after-free in idempotent_init_module kernel/module/main.c:3788 [inline]
>     BUG: KASAN: slab-use-after-free in __do_sys_finit_module kernel/module/main.c:3815 [inline]
>     Read of size 8 at addr ffff88800d36fe48 by task modprobe/715
> 
>     The buggy address belongs to the object at ffff88800d36f700
>     which belongs to the cache UNIX-STREAM of size 2048
>     The buggy address is located 1864 bytes inside of a freed 2048-byte region
> 
> Allocated by task 634: __sys_socket → unix_create1 → sk_alloc → kmem_cache_alloc (2048 B)
> Freed by task 634:  __x64_sys_close → __fput → sock_close → unix_release_sock → __sk_destruct → sk_prot_free → kmem_cache_free
> 
> `idempotent()` uses `file_inode(f)` as the cookie to compare entries on the
> global `idem_hash` list. `fdget` only holds a reference on the `struct file`,
> not on the inode/socket object. When a concurrent thread `close()`s the
> module-load fd while another `finit_module` is inside `idempotent()`, the
> `UNIX-STREAM` socket object is freed and the inode-cookie is dereferenced on
> the hash list → slab-use-after-free (Read 8 B).
> 
> Root-cause hypothesis: the `file_inode(f)` cookie has no lifetime protection
> across the `hlist_for_each_entry` in `idempotent()`; the concurrent `close`
> can release the object underneath the traversal.

This doesn't quite hold up. 1) idempotent() never dereferences the
file_inode(f) cookie, so it cannot cause a use-after-free.
2) finit_module() calls fdget() on the input file and the file itself
pins its inode.

I'm afraid this looks very much like AI-generated spam. If it is
a genuine report, please provide more information, such as a syzkaller
reproducer and the full boot log.

-- 
Thanks,
Petr
