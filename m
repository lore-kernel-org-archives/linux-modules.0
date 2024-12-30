Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5901319CC3C
	for <linux-modules@vger.kernel.org>; Mon, 30 Dec 2024 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735593202; cv=none; b=dg1jn1g32b0ctlcMDw8fWZKhtFkO6cHR/oNZLrwKwEKcUYEoyfq4+N4YsxYuDJ6bjxgZXJuahAjOXlixjew4aOoxCmxFHbtLjncN2ODdoesyBcub1TEVzTRcIl243ZN7g1DzmPuCoq1Px4k2Nf+pvIRpzJnxcsgHsITYIxYhRHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735593202; c=relaxed/simple;
	bh=US/njxnskLMRQWPbs6FYhXrTfTlwiqhM9pzSV1hoRRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcK3YnZArtD4qQEnZDtHzwFGaswLaVJtAq5RTL2Pbo1goAS5AzgTS9PunD7nGekwNCWimEAIiJ4KR0MzMyuiLpsAwT7MfoT4nGa6Nwq44YTbaKtdNTQUYtfzmlKyC5AFMlkHpzZwaayzld7f49BEV4d/wbLHiftjii/qBLOK78E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DFqHyOZ7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DFqHyOZ7"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso8124390f8f.1
        for <linux-modules@vger.kernel.org>; Mon, 30 Dec 2024 13:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735593199; x=1736197999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBOnxzfVApiwH05Ju0EksnOX35OwJEW50GNlErilOTU=;
        b=DFqHyOZ7qkVGsczqjeQinw3UDPuNUwdIbbHvan8YcdfjefjaiftAcVtxXQOoZAfuJq
         ZAIf9Tr157hm/giq+46K7fpvDi3AIHYgASspoK7mssGMIRIPBd+wG6HxlM90hGbdNBvl
         p8sIbF2q5CS+NtheqNcI6q/DYtyH/tn5zuplovFWq/7Tg+RZOwtYtkS2abWod1/4Sdzb
         wBIsUMmPqetKR3KYYmoQZv34y6XjZorDtC8mTlYJb9jTXlYTmAeMpRfXnkZDweUwKVBS
         cGmO36mrk7k05Mim7eEubdjuJrnG5z5+uaHy9trh6myzxlKRwjXZIAZNkbJa9oXvrQW0
         3FXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735593199; x=1736197999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBOnxzfVApiwH05Ju0EksnOX35OwJEW50GNlErilOTU=;
        b=OPrsgo5HLQZrLhD0yuC92DreF4Mqio4QKvbpGcpVQW80azUyyCLpVw96JIbxVcrMJU
         Xr9u9nN7OEah6VC/nf14ACO/0oV2nn1jcOvSLiN7byqUgq9piCLPDD8M0CNn2uehuSBa
         R1+XRWRWHYeoBIfJ64ITqhXClnPQ4Mq90SfjzhRQcnh3djPTC/tbKqjnqsi2AmYbB1+H
         xFDDYMAwkiOnx6/dyalFLtaOfyiANDswrjngw1ISQeRXKKiJXTCN6diOAAQ96kiiwJWV
         sLMqHwglzxLecgK+M+BwYC8vKzozMzCVnBjtR3DUivMDppHMVF1yhHgWOpZ2cnPfVcqA
         ZY5w==
X-Gm-Message-State: AOJu0YyhdUhLUJX0vLEl5gYqPzM6imp63trDxAZ+xSFLnEwGlbY2G3LZ
	TqyTyJBSdZK9ESRJ4nq9BPbvhfSGotq3+fYNOYPBggFUtdcKbC9r3TRxRj5fSuM=
X-Gm-Gg: ASbGnctdPEVCVrFyzsyZ+kKW6Ro7DsprTzxqIlZYkyVb0Rc6gyIstb2YP7iCRQdsdhE
	SW0qH0eBFBdryP2nB1COpJlUJX9W29taeaU4jGEe8jHxrmqPi5gy6JFf+InjlVlpZHoNHTly/Xz
	73oU1Z1cJ/Qu+B4H7WoGxV5DidXRb13Dmp9HRv2oWKceaiogpxG6cL0ZuILixIQXiplVObH39PL
	AQavvF6ZkFqBSDsfrUGvd9LxJ5488MWDobKVZ8d7RVT8/vABKhJAIba2O+o
X-Google-Smtp-Source: AGHT+IF7h5BI1NldJMda9Dqho2Xa7ov7jxQIUb8SRuudW0sdbf1kjSQV/G1ZAAp7Zun0c1Ok5OtEEw==
X-Received: by 2002:a05:6000:184e:b0:386:3082:ee2d with SMTP id ffacd0b85a97d-38a223ffb7dmr22972983f8f.41.1735593198569;
        Mon, 30 Dec 2024 13:13:18 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661289995sm365070905e9.36.2024.12.30.13.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 13:13:18 -0800 (PST)
Message-ID: <24b66f6c-b8db-4f2d-bd46-e4417cda7ef7@suse.com>
Date: Mon, 30 Dec 2024 22:13:17 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/28] cfi: Use RCU while invoking __module_address().
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Sami Tolvanen <samitolvanen@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Gomez <da.gomez@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Elliot Berman <quic_eberman@quicinc.com>, Kees Cook <kees@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 llvm@lists.linux.dev
References: <20241220174731.514432-1-bigeasy@linutronix.de>
 <20241220174731.514432-29-bigeasy@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241220174731.514432-29-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/24 18:41, Sebastian Andrzej Siewior wrote:
> __module_address() can be invoked within a RCU section, there is no
> requirement to have preemption disabled.
> 
> I'm not sure if using rcu_read_lock() will introduce the regression that
> has been fixed in commit 14c4c8e41511a ("cfi: Use
> rcu_read_{un}lock_sched_notrace").
> 
> Cc: Elliot Berman <quic_eberman@quicinc.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: llvm@lists.linux.dev
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/cfi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/cfi.c b/kernel/cfi.c
> index 08caad7767176..c8f2b5a51b2e6 100644
> --- a/kernel/cfi.c
> +++ b/kernel/cfi.c
> @@ -71,6 +71,10 @@ static bool is_module_cfi_trap(unsigned long addr)
>  	struct module *mod;
>  	bool found = false;
>  
> +	/*
> +	 * XXX this could be RCU protected but would it introcude the regression
> +	 * fixed in 14c4c8e41511a ("cfi: Use rcu_read_{un}lock_sched_notrace")
> +	 */
>  	rcu_read_lock_sched_notrace();
>  
>  	mod = __module_address(addr);

I think that since 89245600941e ("cfi: Switch to -fsanitize=kcfi"), this
can be a call to rcu_read_lock_sched(), or in your case rcu_read_lock().
The recursive case where __cfi_slowpath_diag() could end up calling
itself is no longer present, as all that logic is gone. I then don't see
another reason this should use the notrace variant.

@Sami, could you please confirm this?

-- 
Thanks,
Petr
