Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101728;
	b=fYkc0PV9xoCVF9Bi5rARv8hjMytC+ZNW4Xe7DshilUxdhnL3BfjLePO30yEb7lvu7uLb
	 6OUG498zmy7EtS+Syxh5Cf2tXOMkLxCfa+zOyxoN7Ele3ZDi68tkaa2HxD54wfK4VDD2S
	 kKeF09NrxPGWQWuLeXLw7b957R8NHGVHDg7FttL5BSb6y/1XFr3zqQUpNn2hCpsLQ2AIc
	 uHKuwy9If8Xf5JVLBgJCMsD9HH3YyTtz3FYN9rGmZFnS5fIUgAd3ke1h0xR+KFAj7n+tJ
	 AC+14nL1IUGK6eX9AUTu83sB/L3vk2ispw1sKKFCqSUYKZ3svK9wuRa5BdluEFZPlTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=oV4J42aG7aSlwZmO4hsI4nR3tdj4IKf86NVOjXkIpNI=;
	b=GEOhhYLNr4OXphEQo1z0QVYJMHNCX+QMwl7FIJSnQe5FcZwKCUUOcssmGcvfcuLtKllW
	 soIOGa9zVUTV+To+8YJLZjTnVm5PrQUwQpMWSG6g7Y7cTDqb8BX8d/y8hbg0Wf1BZocp7
	 iloSMDYDMLbmmPRkrqvxImU07to6dCh6Aw5deUIujKTDK6LShMQMsyYG93wrJGR4by4SB
	 OtMVOcujPuwBQ+m+KVM+bCwUvIKjr0w03oOkRbpwWWmFhuP/nSkTJqmW1R+h8WQgVbU4H
	 x77a6ub2arPBEc244caQfZz9dNuk5EUnxij5c38NC8ZIt5Y2SfoOcAEU73EfQB5fVNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ed9MC6g+;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90304606A325
	for <linux-modules@vger.kernel.org>; Thu, 19 Nov 2026 15:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90304606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ed9MC6g+
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb77a462c6so7798875e9.1
        for <linux-modules@vger.kernel.org>; Thu, 19 Nov 2026 07:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795101726; x=1795706526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oV4J42aG7aSlwZmO4hsI4nR3tdj4IKf86NVOjXkIpNI=;
        b=ed9MC6g+5Qtaoy2xB6R75hiktNRHrl7RaNAjvJeRhSHqpYmnLg4iyU3/hdIW4Pu90D
         a4LQmtDz7S9rGXQd8aG1A/52yzeUu+XvQDN90ggIDTb2We7bKM8vuvXuYrr9v7ehhHXK
         P7QBdQhyVZmPZydzQW88om3uzIo9thgVho6ku23S1CGgMS4BdIfOIiKtP50+yNHtvxJa
         KmtxG8XqHOaTzAS7jgYCxmxQTzMgfEsFdZPmlRsYoT29OqJYiNYjWC1tYEqdP0sMJwQc
         dlWpmyj71nQQ0v8C4hD6MEHQmwQRN2YbJ8uEGM8vF1OWA8ciDyydUn0Duphkcbv01yhy
         +P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795101726; x=1795706526;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oV4J42aG7aSlwZmO4hsI4nR3tdj4IKf86NVOjXkIpNI=;
        b=bPPTix1eRb8bPps76frqsks/WWjG50l9ocs3i15mTYWixvXnxC4Qzt87KHz67yr4Ez
         +dlMCvJpl8o2jpmNvGz69NDZEKWrxLrCi8beudVkgyPNvF3H8QCYjbdp6Wq8pciGpSwE
         hAOmHEjrcbugL/1mWmK4trd1x03wpUcyFSO5ABmWM+x7ZOfiSyfeNjx/d68t1R1E6GKv
         pd+sjSWlWMo6zsdXlK6kfUIm0tp/4ic1f4csU8IWIG9m81jskXm6POvmx6yoHhpi9guw
         LUkIgyc6pJy8h7Qbo4mTudEvycWkJxU/N7xSSDDaDNx/NdH7jx68CpvCoYCM8QBVhJKT
         4hug==
X-Forwarded-Encrypted: i=1; AL+hErFrSOnzhi5JUGCqMbLwpA+ZKGcSH5fAGl4BL3mh60Yk9QtsFuIGQ/dsVHDSnyvvThi7irvSzMV57Fym4cXN@vger.kernel.org
X-Gm-Message-State: APuU4Z9a6sw62dIg/hwGaAT96KtpE1NmmY5WkmiNFw13hOSc0f3NhwWk
	vj6f4DZtW7WGHpuaDuhvz3Fv4NhtujNP8Dc8aoIVvvg0Qx82Kpo+tIgWTx200aT1+EI=
X-Gm-Gg: AYBFou2ch/bbfvUCQXZHHZGzCjgn/aIh3Rxw00QpGW+/AfeSEAKpaCqpDtcgS5nkRgr
	P8wv0UcfDnIWR8mqiY/mKbk6urmjTsmWvsF4BEcBfjTxz4ayYz1dgzGLQWbkwUxNxOUuutm+JC/
	aH81VGrtEt8MOCCAj4L60w0vTu5S3hnSlyaJNGRjoSe+7BxB939uyntBtL8yhDArWeZhqI2W2Yy
	jaf38xQii14o0LdF8slz8chBGDjfbB7RaDnz2Hsa4Cxr0J+lkNTOv/I1XhvwR9+cZKQVC8PSEfj
	EZWssDATNiYUtqcx1nd8vfelSFQw8vDAakb6iQiARt7knNvZW9Opsg3buZBJSUOc/edQF5VbpJG
	snKD3XET4eaowlEA0zYK823T3mHLk/FCWeoCMqSHx97Y4TKueshPPMkpUGluGJfKR/l068ImrPK
	TpKoN/s2CkqO2fDBea1YwsLdsjuWfs0HK4f5Y0Vl9B2UguIjDwTGtd7F5YsDH2Qa75Qg1+B1UCE
	+NTcDbqCjC3S9IyJxzKO5lLM+EX2v7SqGT7TU0RMMtcC5XaAlhJmvoTlvI5EUasB9CjNID4Xd9D
	1dtBDlWyS3iKwpmx6VGMa9TslCjzJZNLA4h3lhL3r79x89dQoyWey/f8lha8tcCYNA==
X-Received: by 2002:a05:600c:674b:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4bb860ffbaamr34819435e9.5.1795101725389;
        Thu, 19 Nov 2026 07:22:05 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84cbc5d3sm29859235e9.0.2026.11.19.07.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 07:22:04 -0800 (PST)
Message-ID: <8b47b628-865a-416d-b9f9-fbeca3f9d649@suse.com>
Date: Thu, 19 Nov 2026 16:22:04 +0100
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] module: Add stubs.c for CONFIG_MODULES=n
 module_put_and_kthread_exit()
To: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
 John Fastabend <john.fastabend@gmail.com>, linux-modules@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261014-module-stubs-v3-1-319f2a7d4a55@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261014-module-stubs-v3-1-319f2a7d4a55@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/26 3:34 PM, Petr Pavlu wrote:
> Module-related stubs for CONFIG_MODULES=n can normally live in
> linux/module.h. This works well when the stub does nothing or simply
> returns a constant. However, some non-module implementations may be more
> expensive, either because they have a real implementation or because they
> require additional dependencies to be pulled into linux/module.h. This
> header appears in roughly 15k #include directives across the kernel, so it
> should avoid bringing in unnecessary definitions.
> 
> Specifically, linux/module.h defines module_put_and_kthread_exit() as an
> alias for kthread_exit() when CONFIG_MODULES=n. That in turn requires
> linux/kthread.h, even though linux/module.h otherwise has no need for it.
> Note that linux/module.h currently doesn't include linux/kthread.h and
> requires its users to pick it up through other paths, which is itself not
> quite right.
> 
> Introduce kernel/module/stubs.c to hold such stubs, built only for
> CONFIG_MODULES=n. This mirrors kernel/time/posix-stubs.c, which is used for
> CONFIG_POSIX_TIMERS=n.
> 
> Define module_put_and_kthread_exit() in both CONFIG_MODULES configurations
> to call __module_put_and_kthread_exit() and add a CONFIG_MODULES=n
> implementation of that function to kernel/module/stubs.c. Since
> __module_put_and_kthread_exit() is now implemented even when
> CONFIG_MODULES=n, remove the corresponding '#ifdef CONFIG_MODULES' from the
> noreturn_deny BPF list.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

I've queued the patch on modules-next.

-- Petr
