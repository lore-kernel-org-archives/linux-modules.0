Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6AF288C25
	for <linux-modules@vger.kernel.org>; Tue,  9 Sep 2025 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757414258; cv=none; b=ge6XyZlUAhq6IVaBtzA24rXeqQtvGS0FWGbrxdfaDlsFIMcWudlg4w7vegrZtHCLtPy9NnanWLeaARwC1pRRRzeadta6UGFKaujoMOqcb/irGD/SKrEHoKz8gegeYCRZJzkisk3RnhZ4YBELtRrpU04QWLFekVH+qwxbORCyQjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757414258; c=relaxed/simple;
	bh=tOVPEp/MTlKsJFucvk1mXnIhVJM5p8v/XPG9VoLfBuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyRQDeN4UKtfm51huBXAUER8Vk+hV9FkSftuCNrKeJJ7rZ0xJ9r6dNROnOtBDdODVW841k0zVK5IpvsIKN1vi7aXotmeSym24T7ia4Tw70Ef31kkuEP9c6CEnW0DX93BC3einEuQoJDbV5dWQFt468s/Dco62q0gfI8wFdUlfD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hd7Mb8x7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hd7Mb8x7"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b9853e630so50532675e9.0
        for <linux-modules@vger.kernel.org>; Tue, 09 Sep 2025 03:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757414254; x=1758019054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0XPlXUkVSDBce9fC5gXbf4dXNkncu4g8eJn8Euj7FzU=;
        b=Hd7Mb8x7KxzhzpWvyuHJ3sami7aSvxmfh827g0N++Jo63qRk5pc6WyOlx4WJWFoR9h
         nLrG7litHw4bBYEVQUnYhMLt5k1nRnkKs3IlNShyV5dB+t3pV05Ek6my3fgsUesbmSdN
         qk1XhePFkyc0xtColFltMaqJ0OstCAXRWJKnPGKEr2esVuXUem+lwE783r451y7k5gCI
         fcgj79PuDNmnNK9Gx0eZqmh/rKDdIoKMKKxomn/mkNl47tde+VEe6OO5vvckqBEsVmyn
         xW7OGQXV7NszOEjplhBQuVgu+91GCa6Hc4u0U8nd6qae8aCgKsT3FtcgRLPrkqvWg6NG
         y8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757414254; x=1758019054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XPlXUkVSDBce9fC5gXbf4dXNkncu4g8eJn8Euj7FzU=;
        b=bg+tUCH6BpQLVRb2OxfOlkwUU7MyKljzV6L+WppArKXwPydQec0FXr2R71jTrgfa9J
         lnlQ+5Y3H1EGfndoBdFCO44TC0894R7+6GVJoqeJm2yrIBZXZRFL6CJK6V8V1BCfp791
         KobuNiq74vWTVO/l67Su54NkJ1cY8TMAJucQDwc1VYd2PYkpR8jb9sanaKs7ihqdFcUu
         6qjw5zHvM8KaXCZ+ZozjoAlWyfr2NqBre5MUhmZsbaW7XlEKmkmOpVlPXB4YADHrdmxA
         bP8SyCrGnM328pLoThIo6LidaZJxID75tHTDry0ZqCMTWqdxiVERDzUJnWi6vFE1ymfp
         2F1g==
X-Forwarded-Encrypted: i=1; AJvYcCVHFO9vA0z1ba9FtS7b+JTtHuEXdMmoBb4dRs66Co5LkHAcaZtpJG2mQ05szRBFx3/zwUNA8XeW48ub9Sv+@vger.kernel.org
X-Gm-Message-State: AOJu0YzvwUlVwUUj/wzJGai75aDIXfa8aLaGTQcyeSNeqwtQEKPm2mFT
	Lbf9Ptv/w36gy0aF0UOiK0vSRpVkbtMON1FrSBYsZITj+hIXpMm2C0P6+vmfzAOlMrU=
X-Gm-Gg: ASbGncs6jZXCzI1Nm1DjimJC5adfQL5TVviDTHxoW+KP3ILhQGy9aXzGbgL+J05ZWlb
	SlHWs9CJuju4OjxtiXZvwWQgEoIId0GUF+BAY3P6w05IbeHaq1snzBTo3BHWUNk/1rJNGnuUcZq
	zZFamiA8FVHESkMewCAwnBeh6iAzI5WkaIfbcuRF2TwPgAEUDOjSAWK8OxCoGwazjo/psG0/j88
	YEHSu6nHEtnFoAKqFoCb8H9/DhjyW7YTrzABAGRjt/1JrNwNxI1ANm6ahQXVpJbm0v1kQjNf77Y
	aJdB8aK2Qmvy3+LhuB3qoJyxGXfzzZyLmAr/zzmcWbPGs+vT2vDAtKtRgA8u3Iz59jyQ5h/ztoT
	4/TJ2tc0NXXo/gKL1CHhfbahS562jXNBmKhbdpSSquPzhk0f5WWX0Bwc9/zbOhg==
X-Google-Smtp-Source: AGHT+IGfn5SNs2T4O4mexjZwwy/qa+n2mx++98ZDMfxB1oIvg1Yybuz8AnmZMY2FNi85sSn/pbd64Q==
X-Received: by 2002:a05:600c:a09:b0:45b:73be:c707 with SMTP id 5b1f17b1804b1-45dddecf59cmr94488625e9.22.1757414253934;
        Tue, 09 Sep 2025 03:37:33 -0700 (PDT)
Received: from [10.0.1.24] (90-181-92-26.rco.o2.cz. [90.181.92.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521d88e8sm2105829f8f.27.2025.09.09.03.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 03:37:33 -0700 (PDT)
Message-ID: <3e007a66-419d-4933-942e-4e5cdfb06887@suse.com>
Date: Tue, 9 Sep 2025 12:37:32 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] module: replace use of system_wq with
 system_percpu_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <20250905090130.101724-1-marco.crivellari@suse.com>
 <20250905090130.101724-2-marco.crivellari@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250905090130.101724-2-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 11:01 AM, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> system_wq is a per-CPU worqueue, yet nothing in its name tells about that
> CPU affinity constraint, which is very often not required by users. Make
> it clear by adding a system_percpu_wq.
> 
> queue_work() / queue_delayed_work() mod_delayed_work() will now use the
> new per-cpu wq: whether the user still stick on the old name a warn will
> be printed along a wq redirect to the new one.
> 
> This patch add the new system_percpu_wq except for mm, fs and net
> subsystem, whom are handled in separated patches.
> 
> The old wq will be kept for a few release cylces.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  kernel/module/dups.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/module/dups.c b/kernel/module/dups.c
> index bd2149fbe117..e72fa393a2ec 100644
> --- a/kernel/module/dups.c
> +++ b/kernel/module/dups.c
> @@ -113,7 +113,7 @@ static void kmod_dup_request_complete(struct work_struct *work)
>  	 * let this linger forever as this is just a boot optimization for
>  	 * possible abuses of vmalloc() incurred by finit_module() thrashing.
>  	 */
> -	queue_delayed_work(system_wq, &kmod_req->delete_work, 60 * HZ);
> +	queue_delayed_work(system_percpu_wq, &kmod_req->delete_work, 60 * HZ);
>  }
>  
>  bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
> @@ -240,7 +240,7 @@ void kmod_dup_request_announce(char *module_name, int ret)
>  	 * There is no rush. But we also don't want to hold the
>  	 * caller up forever or introduce any boot delays.
>  	 */
> -	queue_work(system_wq, &kmod_req->complete_work);
> +	queue_work(system_percpu_wq, &kmod_req->complete_work);
>  
>  out:
>  	mutex_unlock(&kmod_dup_mutex);

The two work items queued by the dups.c code can run anywhere. I don't
see a reason why they need to be bound to a specific CPU.

If I understand the cover letter and its linked discussion correctly,
the aim is to eventually move users to unbound workqueues unless they
really need to use per-CPU workqueues.

If it helps, I believe you can already update this code to use the new
system_dfl_wq.

-- 
Thanks,
Petr
