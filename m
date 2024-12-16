Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D541E193430
	for <linux-modules@vger.kernel.org>; Mon, 16 Dec 2024 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367423; cv=none; b=uB+4vtjm3Qne19IsXDbpIl6jVUPTapkHpZBYu+kV5m+jVaXPA2+GqDWbo9Gn747SVdncTRTelx+JzR3VbyyA+CNGWbP2TVwvpEFyMY032FwxRwB/2qTjvtclwhgc1qtaPuqKGY15lgAYeJMQ02qN98R0U8PwMaTHbQZv+fzO8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367423; c=relaxed/simple;
	bh=QQWdPEYlmc+nZpMpl4HW1ioNsquXtY6DnMtqhLHrBBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJjQa+41Yd9WC0uFibgAwXekd+ApUjopPj/K+INfJr/VfT0joNS6w+043u3RQHcf9W9hn5LL8NP7r2ElbZx3oUI7BmCvZrU2eoEgfc68O8GmrxYGwA4I3Tq3ckJIanboEzQzI6Tk6oIoaDbb4lbKz6IlV+IUe6TqdGhzDUBP9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dmusf8Hm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dmusf8Hm"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso28444465e9.3
        for <linux-modules@vger.kernel.org>; Mon, 16 Dec 2024 08:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734367419; x=1734972219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eizGnDqNqlNpffP7llVarsh21KPFCtOjd1jz0iLgr2U=;
        b=dmusf8HmSeJWpefuvUAMrMSBUAq9wAznbx0p8qh+HHRrJVJg9njwCmJEw7WNpVw/+N
         5Ih3TaMKWNxx6eQB8uvw88wWBkhuhSg3Dind/PM8kojQrf5PMdZIZ0aR7Z72vDwt+7+v
         F2w9ZXr7ysXlrtm1j39z+fijjEkuuC2VEQpq9p81ptD4ERxMwuMmVAQLDGrWCaSToA+3
         vUdNLCMNlnwjX0uNqigu9CHhx+ijXdov2NtoFLWvsE5txcMlkwn2uJOuMJ/pBPzEZHJi
         AoHO/boldi0lFIQ6/buiuV0D43mqW57vWGBI+cR1zHruhB+0Tb3385VCBVFXYCPxxQMN
         vQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367419; x=1734972219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eizGnDqNqlNpffP7llVarsh21KPFCtOjd1jz0iLgr2U=;
        b=Oe4onSuaJTbSXs5BWWDAa3KpuPvoQukX05EJrjXwygaI7FZdWt/cgm7/yvgNgHUZMN
         L4MPCdNmoT0KqiBguMN0P57O0lwjOkRUibDdQUKHMN4F4qVuLRmOrczQ7ITg02nBC1Nu
         fywDNeqMs9sc/QyoO4gZGwxwIBghrK0EYHivQ+udjlaCSF6O0KtHGxNpCwTMZwFfuYj0
         KTboq4bTWmjqqndBwC7IAHd6TUcqocN3epbRwvRdJ7dwcGV7swcn/I64EvrrCinkhQih
         w3cD7ZA19/gzwB6WbjHTCUObta0Gv7fFO7wGVEaOMBlIIJMb1G5ld7UVmGM+HBRTcFQ5
         RN+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcJ6iOHVI7r/Wcxu88aefmWWB4vMGFOJQmaoojsD3qZf53gezMrqvYX+CLurI3J7/H3Dg/W3I1IMLhWBir@vger.kernel.org
X-Gm-Message-State: AOJu0YzppxbUKxZFydHCeJg6TxWkdzB3aP1Qox81nzs9W7Fr3slzU6vs
	0fxzPRZZ1smojLzImjO8qpCeSHHiq5UpuCC4UIpyCkMKilbx4YHN7NHtS/EpHsg=
X-Gm-Gg: ASbGncsu1AACLM/WyIUXzsUs/w02ng8AhLr4dACBX1CnnFeee+4lgtfivljXDNHXjcy
	WvmOrhMQ17fNvVTPOoGy3v07bf2NZAEqmZO6dQbSBS6vJnU4QNKDcEeiFYvXwnwxtGL1Wt4Gj0D
	k1PoNnXUiPXCFc+6pq+LqpBL3zirhuL0HKB7nmuhRjPoU8ZiSpLm5dmJcaYe3PhL4EAPT6Alxwj
	fLN1AmjUSfWZfU3MrVxPOhI3UATFaxPklBwOmYOZoD09TnpuAn4Vd6IB3WK
X-Google-Smtp-Source: AGHT+IEnPqo6gzVE3wILQI2tAtOM1/JutXdXz6dZd9o0VO/c42CFODH3r558QfMtWWjDDh1uD5CYkw==
X-Received: by 2002:a05:600c:510c:b0:436:1c04:aa8e with SMTP id 5b1f17b1804b1-4362aa3e398mr132593275e9.16.1734367419204;
        Mon, 16 Dec 2024 08:43:39 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436362b64a5sm91261215e9.29.2024.12.16.08.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 08:43:38 -0800 (PST)
Message-ID: <94bf84a7-13a3-4701-807e-fc0f10d4dc88@suse.com>
Date: Mon, 16 Dec 2024 17:43:38 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2 0/7] module: Strict per-modname namespaces
To: masahiroy@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, mcgrof@kernel.org, x86@kernel.org,
 hpa@zytor.com, petr.pavlu@suse.com, samitolvanen@google.com,
 da.gomez@samsung.com, nathan@kernel.org, nicolas@fjasle.eu,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, hch@infradead.org, gregkh@linuxfoundation.org
References: <20241202145946.108093528@infradead.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241202145946.108093528@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 15:59, Peter Zijlstra wrote:
> Hi!
> 
> Implement a means for exports to be available only to an explicit list of named
> modules. By explicitly limiting the usage of certain exports, the abuse
> potential/risk is greatly reduced.
> 
> The first 'patch' is an awk scripts that cleans up the existing module
> namespace code along the same lines of commit 33def8498fdd ("treewide: Convert
> macro and uses of __section(foo) to __section("foo")") and for the same reason,
> it is not desired for the namespace argument to be a macro expansion itself.
> 
> The remainder of the patches introduce the special "MODULE_<modname-list>"
> namespace, which shall be forbidden from being explicitly imported. A module
> that matches the simple modname-list will get an implicit import.

@Masahiro, I'd like to take this on the modules tree for 6.14. Can I get
an Acked-by you for the changes?

-- 
Thanks,
Petr
