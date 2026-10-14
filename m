Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01583CE4BE
	for <linux-modules@vger.kernel.org>; Wed, 14 Oct 2026 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969818; cv=none; b=sCLSi+mrie1RHu4fQjgUGp/9wG/OAPnIJByUda/kjUbtyPwvVJHPMGMLYDVD0QinfdqnuqrOWg8FE6SJBzu6iBSPBmz9cL+4yvms0xk0nhOPBGSC3VpQdSxv6X/GCUMs5Z1IUB5HT7kYm617D/5NXsbqyUI2eLRfJaEudwfrGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969818; c=relaxed/simple;
	bh=u6gJt68ISLg/Q/lSHY/blmq+R/ptxrk0Ef36hoJfBtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgvPvihohMIhQQYfTdnMYcgLPEMczludDk7eIxCLur5vaNXUrFExR19EkhyiQ8B7SlfXmnioAJaq9lCx0tDaCSKzMlTG0kzC9SFA/IbGOvCVEObKUlf4YxZCUSoNRR3iAsdHrrE2tNco0xufG6M1L6o6dP17cWS5yxTHy82RdAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RfbbcaWy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RfbbcaWy"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso36078745e9.1
        for <linux-modules@vger.kernel.org>; Wed, 14 Oct 2026 02:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791969815; x=1792574615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rwAvbxpdHB7rTBg456HuEiK17XkREdk4sHLAdbrMzFg=;
        b=RfbbcaWyAEI4lgszSQdm2yDMR1LKRJ7phHIf53UIS/vtTzqB80tunQPWRBwOp5okzU
         +hFTystB3VyTZnKRNwJcMF0rwQmQFFgl4yOfK2mAJtY1Ah5SIRfDG5w8vQzb66WkDd/j
         InjGistHKAWaaY9bZcqIi0ux7xYnfXHS9fOef+UHZdwlWxmRsbm9MG2OnX3bOkI1ta1h
         N4nJwC6wnHaWTwYni/8YxolvVfpNjiF5GCh1GbGsertwqncDUf7i/mRYxgAH4kCDsB5W
         lZAhlJwwXXgkX2peCGQoFAZTmshMRC13R8WzqDJacUHfKQRNYP3f1nMr4/280dJsotJL
         3ydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791969815; x=1792574615;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rwAvbxpdHB7rTBg456HuEiK17XkREdk4sHLAdbrMzFg=;
        b=syngkYNCEx8pPAoMH83cQtCe2Qy7cH6e6juF83FtZRK1WneQ1r+ibqoi5GmVgzkllu
         JgmaYebK58PAn92a+IIl9BvAk8fSgVLUuVSAlcTqD6qrrP+FqK4EmCJysbz9L5JHnMIq
         0/s9qnGagORj5oZ3qEnQsf1SK+0bPSMwBPsPrCKBVnzHvVbVHgwfu0dKT87XHOQkQF8m
         A4MaaahQ45ALhOlLuIP0Vwo3kEwcYEj9dVsLPwYynYMLyzsFpCY2rS1y3kk2YRYY5kTt
         DVPuw6lVuJDBysTe4cr62NhmsT//W0ShZutW3tGEHpahOMpKVYy/UcGSgIu9PAjh6ekO
         Y2QQ==
X-Forwarded-Encrypted: i=1; AKwUvByDuwiGSNHkhL6DPjU08XTUlVnT+uZTGpfeRTw2k3aSrQWU64OftGT5+fVAaZkY2670/ZlZ/DyXulC8wip4@vger.kernel.org
X-Gm-Message-State: AFq9FYIgxu8Hgz8nSfyhG5rI9sEQXZpH16jkrn4zAINPm51LXWiQAUU4
	oFl47jJMDNzwtQCXOwRWWwHI/0WTIZdMY+Etbu4Zu41nnIlVmPgsczcF2OpTWH4icMQ=
X-Gm-Gg: AYBFou3rZMPpCZXbPJseHTML0khVunkX2QKdKZSlyD+5Xm6krBdeZGJ0ZOXaK4oPjQi
	epa2AB/dTugfHUQJZdDQrQsochd3SYBqtTwqsAQXk3FhgflLOsEFSu/Glng1cwDSp9cPckyH6SJ
	5SUxlJGLUp+i0M7fj3/wA9abJ/IEpeBVd+6TNj0T8aaRktn27emI4QItnluHT2Y2i3yBnX5DoK8
	whYtdmjIMk4YEHit3WeXaye7JyQ2VVX0ZMwiGk7Btp9ji5AKQW7gB+K21Fwb8T/auCaLJ5YAtgn
	OaAgr9HdMiV9HPFLNCJ8/bfvv0CjDBMKN9AopONI4vlCpq0pAsL1Jasj0VVJSUfwexyoyb5tPpD
	Kkaliyun9UxLpqLwYyP5f/zan/Yrtqy9WDi1oZ+rpFY81eZ+LwmmQj1elrwybeX24di3NisGCt/
	DuD0KW0Dy3J7JOzHnpRsPU5QfD57mak4eeX5G0HHatpRx7+Tac59rma7/MM9PTanwEMrLHOXA6n
	+BpV5mcJxViyOA7Z0szbd6+lMp5L8SIaHdtJzndHP3+zFAkhI4QpxVZRTiDKYaULyxarC1c8M2m
	gPsSCwhJEdcOdNaJ/TXcl4a/Gc2BjGEH/atavG3C
X-Received: by 2002:a05:600c:a112:b0:4a1:9663:7633 with SMTP id 5b1f17b1804b1-4a1966379f7mr198616185e9.11.1791969814987;
        Wed, 14 Oct 2026 02:23:34 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab4f34sm10988702f8f.28.2026.10.14.02.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 02:23:34 -0700 (PDT)
Message-ID: <ded7205e-3dc4-473f-bc83-3bed6d4fb605@suse.com>
Date: Wed, 14 Oct 2026 11:23:33 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH module v2] module: Fix uninitialized count read of
 unloaded taint tracking record
To: Binbin Deng <18983559317@163.com>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 atomlin@atomlin.com, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261010080356.6596-1-18983559317@163.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261010080356.6596-1-18983559317@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/26 10:03 AM, Binbin Deng wrote:
> try_add_tainted_module() allocates the tracking record without zeroing
> it and initializes the fields in this order:
> 
> 	mod_taint = kmalloc_obj(*mod_taint);
> 	strscpy(mod_taint->name, mod->name, MODULE_NAME_LEN);
> 	mod_taint->taints = mod->taints;
> 	list_add_rcu(&mod_taint->list, &unloaded_tainted_modules);
> 	mod_taint->count = 1;
> 
> The record is published by list_add_rcu() before the count field is
> written.  The readers, unloaded_tainted_modules_seq_show() (debugfs,
> under rcu_read_lock()) and print_unloaded_tainted_modules() (panic
> path, under guard(rcu)), traverse the list under RCU and read
> mod_taint->count.  module_mutex, which the writer holds, does not
> exclude RCU readers.
> 
> A reader that observes the new node between the list_add_rcu() and
> the count store reads an uninitialized u64 left over from previous
> slab use.  This is a data race and leaks kernel heap residue through
> the debugfs file and the panic message.
> 
> The race window is two adjacent instructions; it is reachable when a
> tainted module is unloaded (rmmod) concurrently with a read of
> /sys/kernel/debug/module/unloaded_tainted, or with the module list
> printout of an oops on another CPU.
> 
> Fix this by initializing count before the record is published.
> 
> Found during a static-analysis-assisted audit: candidate sites were
> surfaced by a Coccinelle rule, and the reader/writer paths were
> confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
> not observed at runtime; it is identified by code inspection only.
> 
> Fixes: 99bd9956551b ("module: Introduce module unload taint tracking")
> Signed-off-by: Binbin Deng <18983559317@163.com>

Looks ok, I've queued the patch on modules-next for v7.4-rc1.

-- 
Thanks,
Petr
