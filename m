Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DA5280A5C
	for <linux-modules@vger.kernel.org>; Mon,  3 Nov 2025 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191447; cv=none; b=gwCChsOpcxuGEK0+OZOgpzLNKz0b06zz6apYcZj1r4UntpopbV3x1ItMKLsPSPxSCS3uKAoNauZYsiBaZRV5ksOEy1tRS9Mc6RS8kc0enhPF9i5YSUGJWO9Ag5IEmDMd3CJmyELj51WQcyFhPGoi5inxo7g6gE4FsvvgeWDoT7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191447; c=relaxed/simple;
	bh=XbRkkU/y+WXWuRuCcmwKBN7yxN8eo0c4Ja83KHz78Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ysvw8PCs7OP+b16qbvK8B1TuJzfX17UF/DgCq0MEMv88xyfWr5dbJ6HEbf1yBIjBVvTdWxzYIFFetytaTPATorilH7qzxiUsh5x/FqyAUoU0GiwyUWo+wbUYkjB+hRSZjMhRxKKGfBpc6HB2no85A+xiDD00eOZ8eRG6QRejEH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQFg2V5Y; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQFg2V5Y"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b715064bed6so88100266b.3
        for <linux-modules@vger.kernel.org>; Mon, 03 Nov 2025 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762191444; x=1762796244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xv2TUizFlKHrEoEkI9C+SG7QzMAufZsMKxgTYMKXnw=;
        b=nQFg2V5YuXhssjYkat9ydQy4WgBH8JETvYAksJGOVvMcIks3POkeTua6FyqGkxiqN9
         s2H4py/bYoVpPK+flmGWwju94PApbIacP8Xq36jZVUGjeIUOz/i2DzMM4j4otvjc1PMx
         Bamfhzd8QR8lnMRx29DqVPWrPW/+JCo4aY3zHNb9fMkM8SVP5u+QP8tg+6HHlPsfUjdg
         N3eLHe/vtNC7bEaSfDXIGLipfpCSzqMPNMGwUTGk4rjpJHro/iQHdAqnRauWlsMpwQOG
         ww7QuJ7PFKq1UDGR9xU3HlzRHf1sDUf4av3rsXdmNTaCIeziajCWm3syMnpimmiWjrGa
         mCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762191444; x=1762796244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xv2TUizFlKHrEoEkI9C+SG7QzMAufZsMKxgTYMKXnw=;
        b=k7Ay345XEteuS18vJ2eG1o45U1qBQKg5b9V0jtuPTkusvCTnrpxWTa1sa804KxZHks
         2rGfidlSEyaDcbqD9Aw6i+oWPMlAshZfad08xPJXscg3LeFw1HazyyyC36srlfEsZisI
         RUryMI2FVMyJkGqHNfyV13YiTUvqfAvpESDf2pf1no3dYC2sAFN5HJ1phGy7DXl6IZ+U
         uWvDcDIui2ou6aNVLU/QVzUNYpNCu8uIeM5QydMI+GbTtMPJ/XFfYkLuBphqmr5Ds+wf
         L7zDHO/KJwUXyBBYkDhhPPeiSFAPZZ9JaAMmm2IT1aeOgrBeNB46uPpsGMwDUuuqe7Nu
         gmpw==
X-Forwarded-Encrypted: i=1; AJvYcCUt3bxH1uH4hlH1P78OHUMiSuMbW+dHviUWfqToY6wWWUM+Hbi3UcXuE5s3fLr0bdiwfVTq8ll1L6mWOX5c@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm275mI6Js7/aqbwpm2UEZo5ItXr/XANc5HGKzOgKoIWtWGVT7
	9B5Y+4moOLza9ECort7YAM5/MvHBJyVs8KBR+PCsysfyyS+4OHgdNzeb
X-Gm-Gg: ASbGncvK4/NeSqpTDEunq5/cOakPr7LKcG6Yt7FVGrNd558uuWcBegaSm17bypbOV2w
	z549s9Rl3DVdWr2Wnj90LQ2K2sEk8hyWNCqWH7g/cu8BniEhu4bXW7Mv18dFFPN9SKqHMdLHVEY
	eGfItr78snc66ED8zwvLs/X78mgF/ao3fVT4xlh0QO3ryonxdYE8OpDUdaRacca8VNbPo4iMma4
	zt+Xgj+yuEGuVzAtotflrgF8agc2b/XaGPPJ/xdjKIJR0VAO8N7QdSat6nWuTa/YwRmzMstD1M7
	QylzBY9w4RJpg3G3hilG7QEF6wdCBBNtrlwOoUB3Fklbg1qv0LkUQGM6jEK8EAJ9zC8P7G22W4F
	EFste2twXyooHZOAcIPCoyfSSQnupSOnEPIDjBymhPiF0zEsMNviDvC49gld1oN+amR0/J7ey5+
	B98a442EbclMx1
X-Google-Smtp-Source: AGHT+IHk868j9a9wb2OAGpqZlWfOedq09o6IrtN/LlLShyla2ph8C3h2GPaP3U2BeMZDni3GJkgNbg==
X-Received: by 2002:a17:907:9448:b0:b4b:caf9:8cc4 with SMTP id a640c23a62f3a-b707012901dmr1383853666b.15.1762191444213;
        Mon, 03 Nov 2025 09:37:24 -0800 (PST)
Received: from foxbook (bgu110.neoplus.adsl.tpnet.pl. [83.28.84.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70acf84c51sm573083166b.30.2025.11.03.09.37.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Nov 2025 09:37:19 -0800 (PST)
Date: Mon, 3 Nov 2025 18:37:13 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bp@alien8.de, da.gomez@samsung.com, dave.hansen@linux.intel.com,
 hpa@zytor.com, jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, mcgrof@kernel.org, mingo@redhat.com,
 paulmck@kernel.org, peterz@infradead.org, petr.pavlu@suse.com,
 samitolvanen@google.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH v3 22/28] x86: Use RCU in all users of
 __module_address().
Message-ID: <20251103182917.74ecb8a6.michal.pecio@gmail.com>
In-Reply-To: <20251103113750.qam3KIkT@linutronix.de>
References: <20250108090457.512198-23-bigeasy@linutronix.de>
	<20251103110835.1dca378c.michal.pecio@gmail.com>
	<20251103103434.D6m23Iud@linutronix.de>
	<20251103113907.4e647f33.michal.pecio@gmail.com>
	<20251103113750.qam3KIkT@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Nov 2025 12:37:50 +0100, Sebastian Andrzej Siewior wrote:
> Now, get_stack_info() where the warning originates: It starts with a
> check to see if the stack pointer belongs to the current task's stack
> frame which it does not. Then it checks if the task found is the
> currently running task. That it does. So in that case, we must be
> serving an exception (such as an IRQ) because the stack does not
> belong to the current task.  However preemption is not disabled which
> indicates that we do not do this.
> This in turn suggests that nvidia replaced the stack from while
> entering the syscall probably in _nv003168kms() or the binary blob
> which invokes the kernel function does not have a proper ORC entry
> which leads to a wrong turn in the process.

OK, I see, preemption should only be enabled in the first case, so
others are free to assume it's disabled. No bug.

Thank you.
