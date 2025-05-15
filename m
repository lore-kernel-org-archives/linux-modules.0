Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7F22820D0
	for <linux-modules@vger.kernel.org>; Thu, 15 May 2025 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296315; cv=none; b=WZCGFkytAUTmcQnCpw/I8raqhU5AFuCf16CvwP0GQ6/psYNLAIFbNvulDqBc7kvDOPjK9c1gqPMvvhijoDPHNX+VF4OdFneqbf4NReEriMAvI2Dk5UjqPv3OASEBoilDQKlT2glUsxq1Z4ogDPLCsP6lRQStHFXuABMgMeuIxIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296315; c=relaxed/simple;
	bh=0tGKkkemugSf6qbz3gshaWCoVsCRbxCI+SQBbX3dIFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COcuADjP9JN/tbu/pT0tqJ77Ds5lNh3ISzjaTc0zwlnyMKbxJ2XcFkyFvmM/KboGII4uPltDlLJSYVMwDQ8aHEUBaD1pJpta/uknxRlQYuZDcrFzVfH11M4DPD2PsVh/eMDy2sXa8zD2gnJuwNY1AW17QJYFb5liNh5bN0zKRbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QleRWDJ1; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QleRWDJ1"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a108684f90so355734f8f.1
        for <linux-modules@vger.kernel.org>; Thu, 15 May 2025 01:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747296311; x=1747901111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=edff1LhptN7FQ5Bq2oruaEckY3n2IP7/Je81wTRfspE=;
        b=QleRWDJ1MjKGuTARD+JMrNkTAxf4HJRsTFLkXkCVtL9CbWW4H8867e4gRrYe6EwAgm
         XPMtN/ccgxu1Iakt4TGULyjyPIWkeK++REj8S0mb+Lp0Y5BdRQJ1RgMKofZ+1rn3lsyW
         bxi4phbRhYV5kVMHXtDrnLPMbUHaadKUFkpJh31Uhr5GNhzN3CoyH06OzrvpRMWIGd1p
         lPNsa58+0OPS7jisV6aHdqQaXvnPOoiqqmJRmt4T6k338Xqel0OrIM7fT7Wlbtpc6I1K
         tJpyOs9c9HSn4DpSUK56f70L5Bp4sMOeG4KS6HeQFC/D8fEHOlBzkrpRaFUFsy+XNvVH
         FJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747296311; x=1747901111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=edff1LhptN7FQ5Bq2oruaEckY3n2IP7/Je81wTRfspE=;
        b=L4p6qcUHKEaqf2BweKkSi4VxM4NBEpJKD7PTZQM86LCvKy0uSWpwB8OvNe64iNFQ9b
         cYpcACFynQw+zJDom6Wdw3LwYM9HG+y8WaYb8Lj2eo8D5viSWNx16WjbyBmbb9IzK20N
         nl3qfdINEm2QBg4nF/WjPPM9D2txU1NfrN3QtjMiHWS/Za+bkd3Sw1y1/UIeXbd3QV/N
         24dRQd/Frc+JQgLv5b1a7XhWF8T/Ke+piivdNySWwmlwY0OI/qzMwz/hrF++20rmO5xS
         ju3ru1UhlQq8h7pAA+DGctW4vMIBJUl1IpmwpFuTRNSq1CPhV91DHyI3kCYL5ao623qR
         V5fg==
X-Forwarded-Encrypted: i=1; AJvYcCU7mEg2rObh5tumDQNeYCR910TgJrt5zRTPASfANHp1yqpK0gtZ1bDFpxMob25s02njAk5ell021XwhOzha@vger.kernel.org
X-Gm-Message-State: AOJu0YzAKPcbrb2CUtn4JicoblYH5cHW2wVMnmu4+/OG9navjxrPj5GW
	/o6md4aCiikqCpbQ6al2ulVw9mjY3WeUPcANuJbqHcGnhxrZGrxat1tLndHMIRY=
X-Gm-Gg: ASbGnctwnYqMOpEZPtFmM1A4Dv/1VQuGGoe1LSMkxHbkN2+U2CkRKGCSb/oavS1/NEu
	ka/8TvVmh5BMT/Pw8SX2m+cQpti2K0AerJsZKmsQUJkU35wrH7ICAE4vKi2l8TLfARowmm8DJWS
	m2n4S0KGMmLSCKd+LHe1DjxOGLbEHEPSu2NlM0B1ybAF1PKzNXSWIKFWsrKx7sLGIyrvWKhzv6V
	H63gcqpYCTMhV2b7cPcOxko01JuJGpwaxWaREICRzuGeEVz/0abR9CbaipuXKJUK2KND92n+Km6
	I7boeUoHSAW7u7JoZeBaOP0/dMzRS5HVvRDaDbOwQ2WUQxMHbAjZow==
X-Google-Smtp-Source: AGHT+IGXvziHODCht+twr6uozgFfTyAclIKdnZuTVey4CsU1/XVbIcw96mTLNhe3rmJT4ESA13CsYg==
X-Received: by 2002:a05:6000:2911:b0:39e:dbb0:310f with SMTP id ffacd0b85a97d-3a34992746amr5945525f8f.39.1747296311397;
        Thu, 15 May 2025 01:05:11 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4dea85df68fsm9441727137.18.2025.05.15.01.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 01:05:10 -0700 (PDT)
Message-ID: <e2ebf88d-46a2-4f38-a0c8-940c3d3bee49@suse.com>
Date: Thu, 15 May 2025 10:04:53 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] module: Move modprobe_path and modules_disabled
 ctl_tables into the module subsys
To: Joel Granados <joel.granados@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Waiman Long <longman@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
 linux-parisc@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-1-d0ad83f5f4c3@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-1-d0ad83f5f4c3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 14:54, Joel Granados wrote:
> Move module sysctl (modprobe_path and modules_disabled) out of sysctl.c
> and into the modules subsystem. Make the modprobe_path variable static
> as it no longer needs to be exported. Remove module.h from the includes
> in sysctl as it no longer uses any module exported variables.
> 
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kernel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> [...]
> --- a/kernel/module/kmod.c
> +++ b/kernel/module/kmod.c
> @@ -60,7 +60,7 @@ static DEFINE_SEMAPHORE(kmod_concurrent_max, MAX_KMOD_CONCURRENT);
>  /*
>  	modprobe_path is set via /proc/sys.
>  */
> -char modprobe_path[KMOD_PATH_LEN] = CONFIG_MODPROBE_PATH;
> +static char modprobe_path[KMOD_PATH_LEN] = CONFIG_MODPROBE_PATH;
>  
>  static void free_modprobe_argv(struct subprocess_info *info)
>  {
> @@ -177,3 +177,33 @@ int __request_module(bool wait, const char *fmt, ...)
>  	return ret;
>  }
>  EXPORT_SYMBOL(__request_module);
> +
> +#ifdef CONFIG_MODULES
> +static const struct ctl_table kmod_sysctl_table[] = {
> +	{
> +		.procname	= "modprobe",
> +		.data		= &modprobe_path,
> +		.maxlen		= KMOD_PATH_LEN,
> +		.mode		= 0644,
> +		.proc_handler	= proc_dostring,
> +	},
> +	{
> +		.procname	= "modules_disabled",
> +		.data		= &modules_disabled,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		/* only handle a transition from default "0" to "1" */
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= SYSCTL_ONE,
> +	},

This is minor.. but the file kernel/module/kmod.c contains the logic to
request direct modprobe invocation by the kernel. Registering the
modprobe_path sysctl here is appropriate. However, the modules_disabled
setting affects the entire module loader so I don't think it's best to
register it here.

I suggest keeping a single table for the module sysctl values but moving
it to kernel/module/main.c. This means the variable modprobe_path must
retain external linkage, on the other hand, modules_disabled can be made
static.

-- 
Thanks,
Petr

> +};
> +
> +static int __init init_kmod_sysctl(void)
> +{
> +	register_sysctl_init("kernel", kmod_sysctl_table);
> +	return 0;
> +}
> +
> +subsys_initcall(init_kmod_sysctl);
> +#endif
