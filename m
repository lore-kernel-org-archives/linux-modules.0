Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3516238757B
	for <linux-modules@vger.kernel.org>; Thu,  6 Aug 2026 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009227; cv=none; b=IeMR8/ZKt9uLGlQyEaofgM9AnkoTcAjySD9DX5zeai4OFfC4mH/wQ/+0fqS0HvqYrOeSI4+SF0T4nY2TnhMqA0seIlY/UquMZel6ORaFqdbyGbmNp/p9QdZMl2VWAuUUEvLKnYakpZa4fBXERi6xHKdsX1E2l8RxewQUlk+CHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009227; c=relaxed/simple;
	bh=5dt7Ut+ce+0A7hb3GNnep+6IYCFby+drFLyhJLYg4Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSkjqnnwVJKC+4k2RAkT6/OsXutAzmCF/OsxoI71mPnAA3ep8LEqx9YxOXt8/LfLK1o8eNBEgcxMd4NieTQosk7/gHa671JGkB3ZVVHGePUME9P9Ig2MK/NwRdHhEO+ibQ0syZC7XrYlCUx4mdBztNIRaZid1XMzflV2DJOaWkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eV2jhNiT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eV2jhNiT"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f7027ca11so1374317f8f.3
        for <linux-modules@vger.kernel.org>; Thu, 06 Aug 2026 02:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786009224; x=1786614024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1LAD7QVIQ9IN0uV0OgxzHXNFiJRLLBuHpOekRGHt874=;
        b=eV2jhNiT40X64wlUyZsGOG10Nmf2mGiudgMTuGo6DzgiMLmAY9PFZXfwAuFLlwsA6j
         AeQvIFbcJFUeHZK8mMWf1RndM1nIqIZkzixJ0/9e4fbWcBvp+7zj8fdAv0bUptdwg4qy
         BLV1xqEYXQh3rT5jDmKvYlBqZOvXz6PTuLrO2gaYxoAc4pzFXFM5AbHe/nW3mcqV+tbg
         cyzVI9plUpdAVtlC7jWc7NFmZNlePwld2v64NZ5v0PXinqnGSgoSeDznPiKcnjGIMR29
         ly0tX4vKpF4JlzRsBlouCFJ7hxsz1O5LoHHUtDxSf6twKwdS6F39zzT1ri3eS+f0R3D4
         sEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786009224; x=1786614024;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1LAD7QVIQ9IN0uV0OgxzHXNFiJRLLBuHpOekRGHt874=;
        b=r6VlIR8biw/hbiHBF4uEa8OeGZeuqq/4pNQlxWqn1jsylCfgnHTYrtC4hnftBTrdoy
         EGw01/ZS9MHatFO1m+dzYeQDuzWCXaRx1R+OvCrNfCe3GEdSZJWc2r9k+9IQEEMPWIUe
         kXlisl4r4XURNNsgBqfiTpC2yd8Y1VLc6ra2mZ9LWViJITsirxbtN3Kt5p9WaWixIt7X
         zLaGgTVFRrEQstPViTWbYe1B4q699egFudr1hKsEsxFhWevx9W6tM18qdyu2EueFEZqT
         98A/VV0rA0W2D480QYZqjgFCTYFdZ3IvjUs9yJ3MMBcNRPQxqHdhejv1iUuOJ0yd6sd3
         q4yA==
X-Forwarded-Encrypted: i=1; AHgh+RrvM22ME9859Mn2AYHXc1XexAhSbw085B5rtux45YevGGaRst/XwvdqUSzWrN9ZBRmDIp29yIpnP552GoxQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxGaapxzmFyFt1WvDJbvDSONogRzJ2S7Zx1HSON+f6tkqNJ2YjZ
	0Hkat+6iPSlxYulCKmaNKZxu0ZER6TDCcrzhKy03XF0khfCP4iQLiyOYNBVIcE42M34=
X-Gm-Gg: AR+sD101DFY4rFhFOlUqAh8tkLqd7gdQfKxzRd3i7212S93ZQ858fYXEi7zjwnMliNX
	pM6zwZd9EPjr7JpaAFGd70UVEGF+8gSp6H2SA8oKiQCFN0ynPQipJtgakQe+HZ+25Tn5BvMK/M6
	mtubAysR9lgJGiAl7OiP1C1yWo7O4XyMdmS05k27wFEhgl9ekBTICWL4+f/QD/BrNFGUKZkVSk2
	V4LiNnL/hGt5uIL/iq3M4kIMCx1gpc4rc3kx7i65YSSMYatvJIde3Q02payu8to5fA2M49bSepg
	5V34GCeYaQ2dIEPjRVs89DMmw0tyZtMrE/L2i8HORfzkQUDoeuEsYZ6uuz+16osWRn1yoNY4QPd
	aCydgBiJLTqmhy+zaB/ZjWubdgWREeI+L3ZpGz3KGeTuQM5ugv9VcV/9TxrWzHfLcFqwf1PVVu9
	TvXZ3w8FV/qtWnVMXF0kqWQUE6vXc4y61CdzNXIpY0HKBGNPQAIJ9eIhfcaAv1CK666mk9Rlnoq
	qYWk53X4kYqEk0pvV4eDVguGzbR4HE0esBBog==
X-Received: by 2002:a05:6000:4796:b0:47f:8b2c:3d98 with SMTP id ffacd0b85a97d-47fec4e72b9mr17131460f8f.4.1786009224385;
        Thu, 06 Aug 2026 02:40:24 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b3279dsm4319973f8f.36.2026.08.06.02.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 02:40:24 -0700 (PDT)
Message-ID: <449549e3-8670-4c9e-a348-0ad3c6a521b2@suse.com>
Date: Thu, 6 Aug 2026 11:40:23 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: unwind: modules: Fix the mismatch between
 .ARM.exidx* and .text
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: linux@armlinux.org.uk, linusw@kernel.org, jpoimboe@kernel.org,
 rostedt@goodmis.org, mcgrof@kernel.org, da.gomez@kernel.org,
 samitolvanen@google.com, atomlin@atomlin.com,
 Xiao Junzhe <egg12138@foxmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 lilinjie8@huawei.com, liaohua4@huawei.com,
 Xiao Junzhe <xiaojunzhe1@h-partners.com>
References: <20260806041001.143888-1-xieyuanbin1@huawei.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260806041001.143888-1-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 6:10 AM, Xie Yuanbin wrote:
> For the new version of the compilers, C code that does not explicitly
> declare the section attribute may be split into sections other than
> ".text", such as ".text.unlikely" and ".text.hot". If unwind is enabled,
> this will also split the ".ARM.exidx.text.*" sections.
> 
> As scripts/module.lds.S, ".text.[0-9a-zA-Z_]*" sections will be merged
> into ".text" section. However, ".ARM.exidx.text.*" sections will not be
> merged.
> 
> For the following module code, using the gcc-16 compiler and the
> latest linux-next code, will result in dump_stack() failure.
> ```c
> void noinline stack_func_issue(void)
> {
> 	dump_stack();
> 	pr_emerg("dump stack finish!\n");
> }
> EXPORT_SYMBOL(stack_func_issue);
> 
> static int __init mmodule_init(void)
> {
> 	stack_func_issue();
> 	return 0;
> }
> 
> module_init(mmodule_init);
> ```
> ```log
> root@(none):/# busybox/usr/bin/busybox insmod test2.ko
> [   10.846774] test: loading out-of-tree module taints kernel.
> [   10.851840] CPU: 0 UID: 0 PID: 93 Comm: busybox Tainted: G        W  O        7.2.0-rc6-next-20260805-00002-g3d7269e6e98c #3 VOLUNTARY
> [   10.852350] Tainted: [W]=WARN, [O]=OOT_MODULE
> [   10.852405] Hardware name: Generic DT based system
> [   10.852516] Call trace:
> [   10.852939]  unwind_backtrace from show_stack+0x10/0x14
> [   10.853487]  show_stack from dump_stack_lvl+0x54/0x68
> [   10.853512]  dump_stack_lvl from stack_func_issue+0x8/0xc0 [test]
> [   10.854134] unwind: Index not found bf000008
> [   10.858157] dump stack finish!
> ```
> 
> Merge ".ARM.extab.text.[0-9a-z-A-Z_]*" sections into ".ARM.extab" section
> and merge ".ARM.exidx.text.[0-9a-z-A-Z_]*" sections into ".ARM.exidx"
> section to fix the issue.

A fix for this issue was posted previously:

https://lore.kernel.org/linux-modules/tencent_08845B64E5F38EB7FA1779982A071AB4A607@qq.com/

-- 
Thanks,
Petr
