Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6083123392A
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515876; cv=none; b=HVu55xj5X0a+LEDzJB9VJon5vBLep2942YMX5DoIV+SOb089KfqxEr9+BQBZQkpGZI7aO5tCxil6/eQLjuCakO9jtSr6Du5Rwe2WvQk9GEq/yUlVzmrVnsLhAtYpcEB4rA2nKvH7ivwYkkhHYEXXgauqbh/uewHEFKvRzVk0rfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515876; c=relaxed/simple;
	bh=TPmuL1ero5zv+WHjvwHCf1loe950mWpRMqA8MpPKYCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/4pFbBKuHtjzhXPpMVECsn/bI5sg0hEPSAEdSAuJVwe9564rpJDfjnctUqA2wh611+Uzz+Bbav08L1OToiVPcFpzx+0X7bwZ4I2vPkbyWz0qr0BIdtgey7n7C4aCJwg2vDfWtEwbsPRdwMZmeuDYWWTP8IAFgwGO62n4/w/FSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YI5qyFe7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YI5qyFe7"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b7612475so5498055e9.3
        for <linux-modules@vger.kernel.org>; Wed, 08 Jul 2026 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783515874; x=1784120674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/x6FSTkcJjBlea16+XEShOIorxoX9U0UFrtSrJcffgE=;
        b=YI5qyFe7tEZCsTz+ih+tFtd+C3xTfwWeqycM/atEgEyS4s3WQrW1tcxy2wWjQiAnyC
         DVAmhSUTaATJhG3Xamh6PbUYXiNIfpiJSLubeZgNA6DL6pRWX50q2PH6N30QWYwK+6ck
         YdKmwW7rlplvz4gDEaNdNQkJMA5RZ96NttJcgrvjGAkS1TUsVsis9HNQBu0hTHYR4Bqw
         pxWoLy1ymZsRqVNq90byKnqIHs7P81KZsdbX23mcR74L7nOhnf1ZPqiPnTK+vYe4yixN
         Fo3QuZyYWpq/Hry7rA/ahUiL7o6p9CY3LR1tfPDdx9ZJO/szkd0SLw7zYmNPBFpzfiZ9
         isNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783515874; x=1784120674;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/x6FSTkcJjBlea16+XEShOIorxoX9U0UFrtSrJcffgE=;
        b=ZSzusXrRGYgSdFuMrV6OL+0ge1vPtRiY+EjGoDNkflJrAZK3Hb2IkMlaBznKzPCfr1
         cdcqRRpq1LHjlc8/4Q7Sk+z959eoGjkYpY8nP+cwrAruioEZ8IYuFaSIDj0sMpV/AuyW
         uymbbK7DuIiiPlTl7SHGOhh996WZf8YpfiqcQ7RPf7eb1C0cTHf9SfXMGuB3r01TZ0v1
         n4k3Rt7n0jGT2kzqT614luyQTxh1tS7qFCftN6rIB7a5dHvf9C5tEimOINB+bUqKhiIe
         5hl/hSd7MtSjjvQLrbixCwQ5t2qmq7wQZQs8OQ72G6CIF3V/pyNQ256d8As2zivEtion
         dv9Q==
X-Forwarded-Encrypted: i=1; AHgh+RoyVM96/isgztqe5MoyIEU5BxmiF7kwMNEa/hFKQojQ2KbQS//Z99KuG2S5bZSuQRkXG3auKdnuLYaeD6NX@vger.kernel.org
X-Gm-Message-State: AOJu0YwH6VNzuF5H8hVbVltksrqM/NwMSCeQtJmwSYZqqf4XEiXrKm8z
	7HYOtPDsAUqtydPLw4tGgRRsV4+OacbintFxbjfGqD5qqTJvQOMlhKIAox4YPigvPK4=
X-Gm-Gg: AfdE7cl5rbAUz+mWoXdiggWaJthO7+9aurtO9V8e031gJDzElCXiztiXqx+30tQtqxJ
	UqqW2JiGjncKpiwpFkW1xZ7ILPGKjBSWELQ+yOwlrWerJpavQkr/Qf7p49y0SD0+Srm3fo339IG
	UR7eX9PWWS7v1sOjbDS/yeXYSSvrIFIYQBmXJOQQj1NP2zC0dzbG6vZI44FpVD+5vM7lgjeQRwR
	o8u6aTrjEC+S54DByhQKS8PyOSBUIsU0y/oZ8KE0UssN9b/lwLYtU3Q0C/d540w6SZZT1KK8qvL
	5MTHmMlHAF3mkfgISKkMrrIi2DRN1lkDcrdcfmSSGE7fSLRnWvh3i6byIn70/jFLcq/BMBHFMYg
	0N04MV8dc2/5QIvCJRlrEIzwg4LxBf92fYe6UljwBR6qoFzjisveSXzTPpXZ4/A54Y/5Bhg8SKj
	a8An4b7Fx8Qmb1SPpY35Q6+rCT5P0Hy7i8Qj1qkivxFGCL
X-Received: by 2002:a05:600c:1da8:b0:492:63c3:8eeb with SMTP id 5b1f17b1804b1-493e687cb4amr21521735e9.35.1783515873732;
        Wed, 08 Jul 2026 06:04:33 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f4e3afsm158975915e9.7.2026.07.08.06.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 06:04:33 -0700 (PDT)
Message-ID: <bef05178-4856-4b62-9c3b-62bf636c239d@suse.com>
Date: Wed, 8 Jul 2026 15:04:32 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ppp: defer channel free to an RCU grace period to
 fix pppol2tp RX UAF
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Qingfang Deng <qingfang.deng@linux.dev>, Breno Leitao
 <leitao@debian.org>, Norbert Szetei <norbert@doyensec.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Taegu Ha <hataegu0826@gmail.com>, Kees Cook <kees@kernel.org>,
 linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org,
 Guillaume Nault <gnault@redhat.com>, netdev@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
References: <D9C0245B-608B-4884-8A09-F55BA4A9F948@doyensec.com>
 <de2616b3-6edf-4255-ba77-0674e225ab27@linux.dev> <akfjpBVML_1RFF91@gmail.com>
 <87111f02-5b7a-4185-8364-2faba650578b@linux.dev>
 <20260706092926.PIlrhRKz@linutronix.de>
 <0dfe59c2-bf60-40fe-90e6-d6e1003709d0@suse.com>
 <20260708074904.xnpi0mlh@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260708074904.xnpi0mlh@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/26 9:49 AM, Sebastian Andrzej Siewior wrote:
> On 2026-07-07 17:32:10 [+0200], Petr Pavlu wrote:
>>> --- a/kernel/module/main.c
>>> +++ b/kernel/module/main.c
>>> @@ -858,6 +858,9 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>>>  		goto out;
>>>  
>>>  	mutex_unlock(&module_mutex);
>>> +
>>> +	/* Ensure all rcu callbacks issued by the module have completed */
>>> +	rcu_barrier();
>>>  	/* Final destruction now no one is using it. */
>>>  	if (mod->exit != NULL)
>>>  		mod->exit();
>>>
>>> make sense?
>>
>> This is discussed in Documentation/RCU/rcubarrier.rst and
>> Documentation/RCU/Design/Requirements/Requirements.rst. The latter
>> contains:
> 
> I am aware of this. It is just not the first time I stumble about this.
> But maybe with the AI review these days there won't be a miss.
> 
>> I don't know if the last part about unacceptable latencies is still
>> relevant. I haven't done any measurements myself.
> 
> There is a synchronize_rcu() later on. I think I could replace it with a
> call_rcu() so we might end up even. I was thinking about about it last
> time I was touching modules but somehow I stopped where I stopped.
> The question is just, is it worth doing it or is it reasonable to expect
> that it is done correctly.

As RCU usage in modules is now more common, I see an argument for the
module loader to invoke rcu_barrier() during module unload to make RCU
usage easier. In general, module unloading is a rare operation, so even
if it becomes somewhat slower, I don't expect it to be a significant
issue.

One problem is that I'm not sure where the new rcu_barrier() call should
be placed. The prototype adds it before calling the module's exit
function. Would this actually fit all modules? From a quick look, I can
see that various modules call it at different points during their exit.

-- 
Thanks,
Petr
