Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897AC337BBC
	for <linux-modules@vger.kernel.org>; Fri,  5 Dec 2025 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764939099; cv=none; b=KYItMnGCeD9woXa/09h4uw8Gq2PSKrxVevJELxPrXdFyA8+Qic9QfgDhGvMuSxpOCGHNyFy3e4/e9YyYttpcXE6C/GVDN+IBXlcHe+KcpXBoIrr54h2L74bYXEcj4XZM7kMidokiUmddDIM1+uSz0VXwOzfcbp8kthPZjRJhHFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764939099; c=relaxed/simple;
	bh=O2r5wrCl4s3mj2Q0Ka25Nr6a0JvqNX3Ja1kWgpZm1qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ZFeeailJXcBNZhiVXUUIaS6oAxvmP5wDgvuE0er15piYT+m+LFI5/RyGBCfH/3g4J6ztZ6uyf/P0gW33sFyS4nWxsV7mopkpu9yDwkMIGFi1BcQPm9XWArTKzVcyl3/2YS6NevWCb2fdjad0VcyBr7gpAngz6XShj/hYgKD9pLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MqVl05lK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MqVl05lK"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42e2e445dbbso1057705f8f.2
        for <linux-modules@vger.kernel.org>; Fri, 05 Dec 2025 04:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764939093; x=1765543893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9MzpLnNl9vvJw+1q+qMx3EcEk0gQb02lA2SLfXsZdJo=;
        b=MqVl05lKXg36NAU4jea8HgQRuyQYObwZ3lE8c7FUiPyhDdrrTVt4a1jfG791cclolM
         QRgkt7k6V4Dyahe//DJTMiPu2trZqgZdaoeAMgUHCZLxGJD7I51wwUZUX8aMonU+H+YT
         pP/Uvsf/u9E3ZdL6EyxiJB7IuyLUERBf3Q2x0erfYZg2/gQAUywXZDRGYZI8nsuppmvF
         MtGWUZLXLrcn4jldcACWn7sWlqqazJKoNRmSiVCCgt8lB/ouaNyZgWm6s4NEFZNc7Jwn
         DBV856OQ99O33ZYZdntSJvEOJ5zjA9kfN9DLEvKugVEaufqLpyMW/Fp7B0gHXtmaKGAN
         6sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764939093; x=1765543893;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MzpLnNl9vvJw+1q+qMx3EcEk0gQb02lA2SLfXsZdJo=;
        b=WQ1mBzjrB8M3W5qCwAtpPRyTk1qJvmCUhxbfR47w86pQPVKSpPQKqKs1mu9eOEqgfp
         4LRzxRW5JPcjkwRnlcw+P60M2HjGT2SBHkp1P+7pyZwI9H1A1gmWLUv3+Zg24VeZTPJm
         rqHEZhkTu9/gH2UL5n96Y7R0rDso6oQ1wizxNEMlfGFPxvxA+H4VG0zSAD3Hf8OqsbP5
         VkQyc4IpcZ+xUDKVNt6KzHTn0WGvcukwbeCYpPlSaYMmSN0CkTy5JwROJNdQ0g/be08v
         Edauo4b/WfXwx8NEESWx8ZWWtK1Es99ngdGRLkz/qRg4tuerQOedKt+wLpNWg0OtVH4i
         pi0A==
X-Forwarded-Encrypted: i=1; AJvYcCVdRohTRKCyZvd9QYtdGYsClbieRlYaoVwZwzX7Myf5nfKGysD5zmXmZ2pkiVwLexjKK3W+e+0uDhr/Yhcf@vger.kernel.org
X-Gm-Message-State: AOJu0YyAw9O1e4o1wXH7bNsaeHz0PrKNteRBTLLUY7O942+M4U18gXGj
	3PzxasXVJrG/c2l6ZgJ65dt/6ZczpWtgfUfr8K7bFJwjEqTEQ9x4rpE7QxolTvw7cEWzElKgJw3
	wPRh2
X-Gm-Gg: ASbGncviluDjenfTbbLLkF4Bk253FEYa8eReXhAP9WATwJG4kRf89brs57ek6wVljR6
	eOsWD3dNS0gRjJGq7aZRwlgwQDC/HgHa7rcC+eFKSHbg2eZ5t0H2l7uhIWOnc+7Z8C1e9f7vftg
	vkVzvG/lxgLC03CA36OaPXFsaP7/ZYGkbCMzJ6Jmd27kinZWEJgj3nV1KVs9RGrCaD81vQPRv2e
	VRPNsWVsUbglerWJUYHg//lJH6uPYYAcXHSfAY6WwFOMJXc1NAeOYa/0q15Vo/vJIYEhbmjZ5r3
	GCTZrgfG3mMET0ImyL+ayb2DDvQNmH2CZ5JDCn3Lkh1mBQt4DH2hmUhr4CJ9cNKbZg3cTiqI8R1
	YSarZQhJQn/9ioKcI4K9OjYBD5gImS9yo/lGoORYfplMiAfeJwQnVjVTrb2Q775EHdAay+ML1zf
	zEk+nxHHzNmfT1zw4SvzMReV022aHlTA==
X-Google-Smtp-Source: AGHT+IFF2YOP1yOKobPpwIABM0ALpDzm5Ux8rx9pH99/QlqE0Zty3TPaCCS2gXj6vJWnXG2wdtohyQ==
X-Received: by 2002:a05:6000:18a3:b0:42b:3272:c4a7 with SMTP id ffacd0b85a97d-42f731a2e9amr10500166f8f.29.1764939092550;
        Fri, 05 Dec 2025 04:51:32 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331af5sm8375239f8f.31.2025.12.05.04.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 04:51:32 -0800 (PST)
Message-ID: <14cffb34-1c56-4119-af76-e8ead8099a9d@suse.com>
Date: Fri, 5 Dec 2025 13:51:29 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] moduleparam: include required headers explicitly
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
References: <20251203162329.280182-1-yury.norov@gmail.com>
 <20251203162329.280182-3-yury.norov@gmail.com>
Content-Language: en-US
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christophe Leroy <chleroy@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 David Laight <david.laight@runbox.com>, Andi Shyti <andi.shyti@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Daniel Gomez <da.gomez@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251203162329.280182-3-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/25 5:23 PM, Yury Norov (NVIDIA) wrote:
> The following patch drops moduleparam.h dependency on kernel.h. In
> preparation to it, list all the required headers explicitly.
> 
> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
> CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
