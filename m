Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA40E2114
	for <linux-modules@vger.kernel.org>; Tue, 31 Dec 2024 03:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735616031; cv=none; b=jqiJF54VNCCWGrdzg2ZbF5Iw3Xc0bX3aMpfMo7jf5+GbuMqvJ8GJhyDnN1/OhvF4hJUouEIaHWcea2MoKlV/nSulL759H6ZlemBjdAkDSk4c2R07StcqTVPMXOWgQtvaT7YGqcIFfaVx/rLzKeG1qZN6hy3DhGRX+81xAP36JWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735616031; c=relaxed/simple;
	bh=acGKTC8N7xBcBPH29clLa/qcfRodutSkMabhv4kx+rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OShmUEFTdGXV6EUn5gAp2kBQnhry7K1naJR46Bkq88vRCuFtYeN46ax/wz6hv/N+jU15EwfyB/GyuFJ/wfMRzeX6E3ipRutnoYnJ9TSC2nItyx72ajeLvVVoGW/y3hVVbivoemWROgu+9i+saQmbSIgm6DVbzk8Awb3CsbdU+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M2XhLxZg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M2XhLxZg"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BV2khr7032225
	for <linux-modules@vger.kernel.org>; Tue, 31 Dec 2024 03:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LZ7v8jm16Hil/pksNnzk5waj
	wFJzjpwjwT7s4mkt0jA=; b=M2XhLxZgJiVT9geHm2eAh5+BfDReBJOM47YYnDxI
	txpLy29JDMpN5Ncai/kR624hmxCGO7bOq7buNN6KQycnd4qBAbMPfJakDq47A/La
	y7Aw9jY+5OYkZaZCx5hGGwFd0XW/GizBxzaIKxHfsJ7pJ2du+V9PjnJKO9ZDc9fj
	+1i4yR5qKOHGOHG/NlAAe8oncryZl0f2wrooMBnX0KBY7xfKr7nXmJ1EpDno3FUH
	DoR5b6E6ZX+5Wef4hV5k9XNzELGNQlF6A33JP1YLTquccCRh9awjUz7Y44gRwdBE
	18uHlKr9uGKoPv481uy+FQwwD/6ldmVgYetR0tZdQzNFdw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43v84jg2mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-modules@vger.kernel.org>; Tue, 31 Dec 2024 03:33:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef35de8901so12739119a91.3
        for <linux-modules@vger.kernel.org>; Mon, 30 Dec 2024 19:33:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735616028; x=1736220828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZ7v8jm16Hil/pksNnzk5wajwFJzjpwjwT7s4mkt0jA=;
        b=GLtTMJ33PLhoIcjHmulJhj/3AjyPjMFTjoMK7a4q0bQVr2EvZ2DmdeIr2xCloKZYd9
         v6Pl7zzM2VrISavBjcoTG+sX2LINGO2ysDZfDPWBAom7ZMKYlG1PPIfgYXgyx0yMO6CH
         AGGR4FmWYs7Q+RU9uAfkABBM/DhQO7YMqJwg+tVFW7wQHR0rtbjYe+r/p4ekNRGQp981
         iA/pfmmPlaTHqrh3raXvs7Q+8+9115wJSzgL/pSoA0JvbLAzK7EzAiYXSyeKZwi9NLKs
         uUiyXQ5ssghkCoo3dmohMJ8e+bB2c5QmPrpxeh3kLCpaHfHgrRVq3NTABY1ATTn5Ms9k
         tkww==
X-Gm-Message-State: AOJu0YwdWJvQWWlxWXno4kQFr16znkziSc8KiaKMNJw9Ftl/AsRr+zDh
	tSE+dxJzANjM1BvQfsZzhGIFO+lHQ3SP00F2KajpInVsX2Jj3NODooHxiKy9tzcyyA86QsyKvHq
	SWzCLgmILjNGmHWsZ8nqHje8sa/xoOCU6UProQzpUG8XPz7l9csRigV/mW8ArtFjC
X-Gm-Gg: ASbGncsatHpMzbkIfVvbMhqPHF/oiAh1nobgxSRa0FDNy4duMP7llPzs3qNYJM5QQCI
	i3DwVrojTf8ocsM9BqX3e/r4qLcrbZSUUhxtRn0PvqV+sPzgdDPk4RKipfuMTMWR2GaxtystKsN
	mx4iXMR146JuKLpGVioC/p2ci2+/arqdf2iBwXw5QVxYcrUW6NHAXYbin3nBJ3p1fXTDIsppE8x
	8I9UZnibhkXlYrbWsPNlfILYe7Qc0/3lQMICOGzTYL1InclbcN3NI5SjYnnuOotkRFdKWgy3b8w
	cx8+Z6zycKHwaN2xgxDrSKGeKtXIpZ0ELBWZ
X-Received: by 2002:a05:6a00:1411:b0:725:f376:f4f4 with SMTP id d2e1a72fcca58-72abde01aa8mr55840928b3a.13.1735616027921;
        Mon, 30 Dec 2024 19:33:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZwi81tswp0lqrn1YgXNMxMkrFIdc4Z48lc1H1/ClA4kxkVwHUin8C6iGgtHNm6Juv6r87vw==
X-Received: by 2002:a05:6a00:1411:b0:725:f376:f4f4 with SMTP id d2e1a72fcca58-72abde01aa8mr55840899b3a.13.1735616027505;
        Mon, 30 Dec 2024 19:33:47 -0800 (PST)
Received: from hu-eberman-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad816187sm19902800b3a.16.2024.12.30.19.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 19:33:47 -0800 (PST)
Date: Mon, 30 Dec 2024 19:33:45 -0800
From: Elliot Berman <elliot.berman@oss.qualcomm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Gomez <da.gomez@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Pavlu <petr.pavlu@suse.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elliot Berman <quic_eberman@quicinc.com>, Kees Cook <kees@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2 28/28] cfi: Use RCU while invoking __module_address().
Message-ID: <20241230185812429-0800.eberman@hu-eberman-lv.qualcomm.com>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
 <20241220174731.514432-29-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220174731.514432-29-bigeasy@linutronix.de>
X-Proofpoint-GUID: pc4mLFm9PgtDXwEps3fNxsaQuOX03nZM
X-Proofpoint-ORIG-GUID: pc4mLFm9PgtDXwEps3fNxsaQuOX03nZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412310027

On Fri, Dec 20, 2024 at 06:41:42PM +0100, Sebastian Andrzej Siewior wrote:
> __module_address() can be invoked within a RCU section, there is no
> requirement to have preemption disabled.
> 
> I'm not sure if using rcu_read_lock() will introduce the regression that
> has been fixed in commit 14c4c8e41511a ("cfi: Use
> rcu_read_{un}lock_sched_notrace").
> 

You can replace the rcu_read_lock_sched_notrace() with guard(rcu)().
Regular rcu lock doesn't generate function traces, so the recursive loop
isn't possible.

I've tested:
 - the current kernel (no recursive loop)
 - Revert back to rcu_read_lock_sched() (fails)
 - Your series as-is (no recurisve loop)
 - Replace with guard(rcu)() (no recursive loop)

Whether you'd like to stick with the current patch or replace with
guard(rcu)():

Tested-by: Elliot Berman <elliot.berman@oss.qualcomm.com>  # sm8650-qrd

-

I don't know why I didn't mention steps to reproduce, even for my own
benefit. Lesson learned :)

Here are the steps to reproduce; you'll need a system with support for
CFI: qemu arm64 probably does the trick and you'll need clang>=16. I'm
happy to help test future revisions of this series since I have the
setup all done.

```
modprobe -a dummy_stm stm_ftrace stm_p_basic
mkdir -p /sys/kernel/config/stp-policy/dummy_stm.0.my-policy/default
echo function > /sys/kernel/tracing/current_tracer
echo 1 > /sys/kernel/tracing/tracing_on
echo dummy_stm.0 > /sys/class/stm_source/ftrace/stm_source_link
```

The trace buffer should not be full of stm calls due to the recursive
loop as mentioned in my original commit.


Regards,
Elliot Berman

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
> -- 
> 2.45.2
> 
