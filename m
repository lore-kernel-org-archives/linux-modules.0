Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7381AA1DB
	for <linux-modules@vger.kernel.org>; Tue, 10 Dec 2024 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838749; cv=none; b=tONwegbIch6PpnN2nyGeapBx72pszMvE8iisYVYqK/H/UTyuMrPuEF9QKqesOyyUtj1bXVE8wop6yeC1zKdrmXEA4MJLyLtufuQlMHjT1fw2BkYq8F9uUOOc8IZMwdbz5Se3Fh+hN1TYe7UTPXs5UGDWbH/EntEA4kxpXlfXaXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838749; c=relaxed/simple;
	bh=eTvs5riH8tSrK6NhT+XShii162RwKvN3oQT3o2VTsl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFqYL46e+WScYG0UJX425GWQoGx4/Y6LwPV/ogdtAMHOZ5zq/X80YpVdUATpWTYz1jqcfi+MnAud/l0hN2POBDyGVus3uCY31t6o6H0X0nLhx/0tLD0b5H31IG6klvaGz4ufr9Fv5a4sSBGeTP52drNs1EQHIRRZIxV+iGD8wjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jt867Xw8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jt867Xw8"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a766b475so53988695e9.1
        for <linux-modules@vger.kernel.org>; Tue, 10 Dec 2024 05:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733838746; x=1734443546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lhx1xbgYInSsXWN8qyC5hVEOzsd3WRPdyx4lY/Rs4X8=;
        b=Jt867Xw8UjHxLAIysofXhNwziIdPkyFv2FDkQAp/jnfQNTzoUHNN/d5oQ7jXMahD3p
         TvXI0h44kGk5hdBAQB+PLyfsAlXIjFcN3tOU4Yt/HtVN9ARwWBpJM98kGz2rjz4YLsbP
         7cMxPhYDekv6Cw1T3+CSw2O9YMsS7KY2Eo5lSBhFqGahGCcfo5wPXKvgL/pa9ZX7gZpB
         4TTryZDknioMPkNODLh+zIo9uSgUGU6uGONmYFGIZyVXLMDbMJm2QEG7zoWqz694aXs7
         Sna6qIRc9Nqq6KbgSKKnUUMwGjxSiWmeh7AdtdRnSz1yJkQ1LtyDnZhkXCweDH5RymHa
         kI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733838746; x=1734443546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lhx1xbgYInSsXWN8qyC5hVEOzsd3WRPdyx4lY/Rs4X8=;
        b=Iw6uPYiM6wBxplRjWOzefaA9wVg3wvTHwQGvlsD3PMxHT6x13yUaw2lT8qzq9MFfxT
         gLQlnp9AU3CHAegb1JmatxPXIY9vccSDKZXm4qBJDXRYO/XxBYL0mYOnX4OEjc7fKxFL
         SCf42fBLdGj76SyPs45OL65OJQFlQ6vIVUB7DiF+SGoCHkBHfKuKpZrBXvDsDtle4HmE
         J6V5MjeuvhlDrcvg4tk6fBtp0HkTY5n1Yt7Uxr9uN3/HsC5a4RSqxyEU9cKzB4Nj3lWj
         lHPYxNRrj0Kwl0nO5AbdNwX6arlczJLDmzobP4Agct7xZPbuMJgpeCtsT98AtUmJTxGD
         4r0w==
X-Gm-Message-State: AOJu0Yzdz9dRco3KuxIi7eUkhlE54xC7B2tLQAymgGgduF6KIjvNfTWU
	WtgtIXVBQ6h8TQ2VnoEkucCzzf09rv0jX6nhadiVkUxClc6qlfhNEFvawuhPPUw=
X-Gm-Gg: ASbGncvcmT/epdSJAu0LgTH1MrarC3h7xhap1iT6c7ABXpconmsPCMlm56R+wo7RljD
	x4X3hkiyo596MZ7LA63OPWSDOZBgl+gstz9rMiYtbEgvx82DBDiEeU3JC8y6foONd6ntH87XcT4
	yWoLpnBCBtXg2JCmS3uPJjDzwy8KFYxLr1Bt0EID8eH4vRJZx36/mBYIi9ct2j79eLs2z8x+RdL
	jpW1X/cfNl52gMjAVkJG4TWjZa0icHJCKhTsmS/sIKuYXtHB92p4vghuA==
X-Google-Smtp-Source: AGHT+IHWpMN+fVfSVKuGOy0PyOh+ZtL2oZY0kTB/HI7meXZfOL2asRPIibq5YY2frWH9ySWGPM1agg==
X-Received: by 2002:a05:6000:1f8c:b0:385:f0dc:c9f4 with SMTP id ffacd0b85a97d-386453d6a9cmr3568988f8f.20.1733838746047;
        Tue, 10 Dec 2024 05:52:26 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-435d4cd4a78sm17722155e9.28.2024.12.10.05.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 05:52:25 -0800 (PST)
Message-ID: <21f75fd1-58f3-4c80-8527-55282518c802@suse.com>
Date: Tue, 10 Dec 2024 14:52:23 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] preempt: Move PREEMPT_RT before PREEMPT in vermagic.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Ben Segall <bsegall@google.com>,
 Clark Williams <clrkwllms@kernel.org>, Daniel Gomez <da.gomez@samsung.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20241205160602.3lIAsJRT@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241205160602.3lIAsJRT@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 17:06, Sebastian Andrzej Siewior wrote:
> Since the dynamic preemption has been enabled for PREEMPT_RT we have now
> CONFIG_PREEMPT and CONFIG_PREEMPT_RT set simultaneously. This affects
> the vermagic strings which comes now PREEMPT with PREEMPT_RT enabled.
> 
> The PREEMPT_RT module usually can not be loaded on a PREEMPT kernel
> because some symbols are missing.
> However if the symbols are fine then it continues and it crashes later.
> The problem is that the struct module has a different layout and the
> num_exentries or init members are at a different position leading to a
> crash later on. This is not necessary caught by the size check in
> elf_validity_cache_index_mod() because the mem member has an alignment
> requirement of __module_memory_align which is big enough keep the total
> size unchanged. Therefore we should keep the string accurate instead of
> removing it.
> 
> Move the PREEMPT_RT check before the PREEMPT so that it takes precedence
> if both symbols are enabled.
> 
> Fixes: 35772d627b55c ("sched: Enable PREEMPT_DYNAMIC for PREEMPT_RT")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

I'm going to wait for a few days if others want to comment and then plan
to take this through the modules tree for 6.13-rcX fixes.

[Luis asked me to look after the modules tree for a while, with the plan
to rotate it.]

-- 
Thanks,
Petr
