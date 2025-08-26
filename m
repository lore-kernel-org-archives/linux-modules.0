Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67C30BF59
	for <linux-modules@vger.kernel.org>; Tue, 26 Aug 2025 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200850; cv=none; b=Ea/ojacxpYOsbWwb+befWxGWj4qFEybFK/IfvmEljMnV+prFuLEU+tEw3i8pTXIcmNYdLimPPCSOAkrKm0Xw2cEsjXsY2iv4ruvw7WtCXWbGvdNerVNQRd2wqsEN7pgSolRfBunAuKfZ7XYCIsOIE9CC5nyXCOeiR+d4Xc0OIC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200850; c=relaxed/simple;
	bh=o+jb5g1N9AMYY67V/CA+UNo1y0YqSW+9qNLomu8Ob9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Lyu7bGtqpDlQ0UMlpmHz51zyrnjnXisHmoZuxP3zRafyDbVC12b4ZTuRmXVbq0A+TgG2R5pVUQKC5IX83R8MDV1pnRcTNQN1AnLsWNKaaVaeI6XIceO2/IkINn9UMJc8mEnhlXGy6blQXpRDKmcTja3rzK6i34Gj5KyCczUr8UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=USQXV8qF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="USQXV8qF"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c980bd5f48so1712893f8f.0
        for <linux-modules@vger.kernel.org>; Tue, 26 Aug 2025 02:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756200847; x=1756805647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HW2HUDWRHT4i1n5wE3yCr0uWi9l5RmK2kTtTDTdtzZk=;
        b=USQXV8qFOiuOjoAhVKHlJO4RST1Mg0DK9BuGkFgNtHAK+JCDbOHl2/mxZcDqGtwWPk
         /p1EblM16OQG89cwGpPqeuJKtwAWuDS9PmGINzYo8wxoqYwZXf8opIgZE4uj9CoTT1Z4
         zoSRZ7iAulkt5Bc+3vsBthkZUss6yj4g8eXFnEdx0mTtQNycUL/59VPzWIWwZW1M2zII
         L0u3fd2GQBEAspnwiJD2koXac32MMTdTdmbrMNMJdZY4FfeJ6pqE1WN7w1ytFykU5DX3
         Y3BBUDgnSysWwSZqMCRzjOPdk8e8O+8BDJ2dSMUcOh8vgBHUu0XnBtCMAm1g4R3D+KF2
         Tc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200847; x=1756805647;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HW2HUDWRHT4i1n5wE3yCr0uWi9l5RmK2kTtTDTdtzZk=;
        b=uyko1g7fJkmG+j7x0h92mgCfGXQ3/S+dsLtyjuE52V7c258zUEUSK2k63sHGzJ+UWk
         MAn5YDJxULu2cWIlS83w9OpxWAXPAiIl5s1/5f1gK/aV2WlRZu9ZHUAKHduY09fUsCkd
         hcch3bMihGCUoZIRE3B4hUtJT+Y46sQah0RN8YreceYLmt4JchovFminyQD/o6P6aczS
         bKS81IyA25gENs2b4SWgyPiaS54p44v3inoGDgfWF+Zv+hzP6BXiR8/2YCytiS9TpXxP
         bFGoQTOEDcYyieUg1kpmNJChlEZ/Viog+oMgYbbBqthqHl166Vmp+B+Acu3eMmwN5N7U
         G7jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVOK/RY6wRWkRPA+ERkLk7NA7vkTB4ydFSqGKDyOycXPdU4Sqf24DNKFs/hYqMx4a20hc9raXyFPqMR9Ey@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9jI0XaiY5y8fNnMXASuJSIbbo3Ebpd5gNMURnuikHo2QvEmIX
	eIneO3uxRd/qRk4JHgrFBwpqcpKRKiNlqtjG0HVQp1j3J6mk35FaS6LCNhSeAwCm2H1rkbUKCpp
	XFR0t
X-Gm-Gg: ASbGncsW7ZgB+o2+5vYlGtiZaVYDPYszjCZdJOgvKmHkUE0lxHVlgeJyrN0SAb31XCk
	atAvd87LqsjxftLUSYPf4p1PmA6ZzPdjHSTdPi/Y2KRlR9Er212QTmU+5gY5aw7Bir1etQcVGKE
	EKAuEn6HMA6PphRh2q77pZzxHlh/QO9ZRACAp8qtLXC6ItnuuUuRnBY8neouxYrYbu7p9GJZYq7
	EVyTiXTbSSZAc8dyIuFPcVQLpe3RlF2zinCWkJJFGCuoHJ63dGgxQZk42nBVRIp4l+O70nVdrrK
	AuTXqzq4r8gef+o+vYOpefIetkmzPfk2BeQ7etFM6b3Qh/c9Utw/YDD1n8bNTcunvx5b10n3J6J
	EW69aojOZD6RssF4IFKnH2PBp5P0EJOuSeY/iP+Hid+M=
X-Google-Smtp-Source: AGHT+IHbSrfiU+FOdt+Rd4z6vofZ+29eq0hImMmspUzv4cDgX3oovhP+aFGkM7q4vl/8i0/3uo6+QA==
X-Received: by 2002:a05:6000:240c:b0:3c9:9ec0:203b with SMTP id ffacd0b85a97d-3c99ec02f4bmr4771108f8f.27.1756200846753;
        Tue, 26 Aug 2025 02:34:06 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f7fe29b0sm1680228b3a.9.2025.08.26.02.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:34:06 -0700 (PDT)
Message-ID: <52288605-a16c-4a93-9e80-66d32de88847@suse.com>
Date: Tue, 26 Aug 2025 11:33:59 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] module: show why force load fails
To: Jinchao Wang <wangjinchao600@gmail.com>
References: <20250825091545.18607-1-wangjinchao600@gmail.com>
 <20250825091545.18607-3-wangjinchao600@gmail.com>
Content-Language: en-US
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250825091545.18607-3-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/25 11:15 AM, Jinchao Wang wrote:
> Include reason in error message when force loading is disabled.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  kernel/module/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c66b26184936..a426bd8a18b5 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1083,6 +1083,7 @@ int try_to_force_load(struct module *mod, const char *reason)
>  	add_taint_module(mod, TAINT_FORCED_MODULE, LOCKDEP_NOW_UNRELIABLE);
>  	return 0;
>  #else
> +	pr_err("%s force load is not supported\n", reason);
>  	return -ENOEXEC;
>  #endif
>  }

The module name is already available at all points where
try_to_force_load() is called, so the new error message should include
it.

Additionally, we should be careful about the message. In the case of the
init_module syscall, the missing modversions and vermagic could mean
that the data was deliberately stripped by kmod because the module was
inserted with --force, or it could mean that the module lacks this data
in the first place. In other words, it is not always the case that that
we're reaching this logic because of a force load.

My suggestion would be to use the following:

pr_err("%s: %s, force load is not supported\n", mod->name, reason);

-- 
Thanks,
Petr
