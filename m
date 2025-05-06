Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24E525D54E
	for <linux-modules@vger.kernel.org>; Tue,  6 May 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523520; cv=none; b=gaddUDFKJK0cBfpi72cSGF1inxZGoepIcgcovHWktZ+GNcctRYgj4Rf5euSVZeRelUYDMpqpizR65pOk+46G7MGKeM0v2NVc+ta2vBr/8QBa5Vv6WFnOH4CsLZ8HxwgcegEgaqHwCnSgRYaSXliVvIeHVgnnp6EJlUwAN2nMH/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523520; c=relaxed/simple;
	bh=u/fjceFFYQeTWywO/Seg4JF6qIiA9+WAhSikZDLBgdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvNIXrskud/jl69QQLHovww6udCkKOuBenD/tm3TTcPVuVNHX03XK0ihfVnjy9TzOuY/pnszlo6tYSFCRkkbMVXAE7wv2KbPNDkYSpCFLtvWmFK8RO2OcgOKy5Rb7OV4zFCsi2PVKNi9hzBkunzzojufl1fNrMQN+5WjIXKAZbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SVjZVqlC; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SVjZVqlC"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f5bef591d6so10951772a12.1
        for <linux-modules@vger.kernel.org>; Tue, 06 May 2025 02:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746523517; x=1747128317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DdF+CAHcMRS7HlmyHTj6/cf2/xdE8uY87Wf9zE4PiJU=;
        b=SVjZVqlC3G7FQ2kaxMZ3ibJaVdQN8m1rQPsTUyG0o1xk6d5I21X0ditdtcenVa1mCl
         vKjtATTjQG/nmT/pn+W44ub9n0oQVpp7dcdg6bPxdPhNNeFr1ayz/e2SasKajQCYKL7z
         13GQTwlPLMH8dSzbXG8gUVj4jY9gfgOgpEt3noyw9qYo3mJvlB9p0QdYy5SdG4QNc9FF
         IV5Jm4mo777Wm1OuMf3XDnBFPrlt210KSoTpFlao+mZee9Y2OBffaO4daSzFQ/6DuDR2
         u8nU0lEvpD/lSDJPIJF4YQs2N+PX/n24rajR0AeSUa1wDryRq1CL8KZeUF+kSmxj/Hdy
         PT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746523517; x=1747128317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdF+CAHcMRS7HlmyHTj6/cf2/xdE8uY87Wf9zE4PiJU=;
        b=ZNyw4sVDaHmx5ckti0t+lZIAg+CEcA841Ucbgqk/QxTzT45MOTLZzwXSuDYxuti6sI
         eSDz/cyJXuC0oROyuB/CH1hIvP/w1ZbCyJSyxJueu9x+yomHicQ3qXYyL80C40IMu7Wv
         gbS47iiehkiWY9nBXn+yZnC7l5pevQvJLC3+pTx4fXU6bFT3Igf1dvLZhCSc32E5yqMx
         x/S7x3QV88vL/373ZXeCJ/8B0dY+M+sQof5zugBex1fJBJIVG6xyQ5+sEUm8zF/P3+E/
         UnKtHtT3SahSwuUCpTdo42be9lpwcZqDHYECrhVBFUL86+rolwLGckXkFchr78MEWQUk
         veFg==
X-Forwarded-Encrypted: i=1; AJvYcCWsQWjp2DnnBlWH3W3A/aWMBb14zspyptCVHy0hZ/Q1Hn3/NUchxvOfyCKF4R4aF55qqKDiQu/m63vjH0cO@vger.kernel.org
X-Gm-Message-State: AOJu0YxA9d0uc9LuZ2k+aLHxAtdpVsEfDuHS7eLNfmsFy+u/UY1jdkTC
	GrMzYVTDGEFbkmuUiChYxMKweORw4PBEBkBK9x5d6ynw15T3BnoLTY2DvjUIbe0=
X-Gm-Gg: ASbGncshkHa5pGWqSh0w7hENH5PHQdFdEh+tzFPvAuccXy3+3ob2g+u0CkE393YBfvQ
	v1yo2dAhfoQ/lpk0+NoXMgQmEmj20Bv0fcrQqWWYQVpWq6P+wRAKYS+bFn2d7rSlS/fPhpfBQ+m
	cW8o99vtaa7jZBhObd6hJ63b8X296s4jri/ChBbBAYCI2ILpj1m8Xm3GOTfbE+KRLHEhlk0OAwB
	sloccrzXOU1pGhrijnIJQtu370rkkdRYZTavvW+pHqVRqOZoOxCv0AI2Mj6T2GqLV+clIfT5m2s
	xoNTAPTJl3/aOOBcm/NJJvPE9lwE8nxi2QXQBQxa5Pw=
X-Google-Smtp-Source: AGHT+IFJwd3zspYui36u1KUzmHMVo7G43aqyrNepvwB6J1nr5ibdR0TaraM6KsH+9IsD5N40UWm8xA==
X-Received: by 2002:a05:6402:268c:b0:5fb:3ca1:fb3c with SMTP id 4fb4d7f45d1cf-5fb3ca1fcdamr3871684a12.27.1746523517074;
        Tue, 06 May 2025 02:25:17 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa7781d7d9sm7310792a12.47.2025.05.06.02.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 02:25:16 -0700 (PDT)
Message-ID: <7803cd39-8b40-4956-86de-f2750d8e3b13@suse.com>
Date: Tue, 6 May 2025 11:25:16 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] gendwarfksyms: Add a kABI rule to override type
 strings
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@samsung.com>,
 linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, Giuliano Procida <gprocida@google.com>
References: <20250505212401.3379699-6-samitolvanen@google.com>
 <20250505212401.3379699-9-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250505212401.3379699-9-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/25 23:24, Sami Tolvanen wrote:
> In rare situations where distributions must make significant
> changes to otherwise opaque data structures that have
> inadvertently been included in the published ABI, keeping
> symbol versions stable using the existing kABI macros can
> become tedious.
> 
> For example, Android decided to switch to a newer io_uring
> implementation in the 5.10 GKI kernel "to resolve a huge number
> of potential, and known, problems with the codebase," requiring
> "horrible hacks" with genksyms:
> 
>   "A number of the io_uring structures get used in other core
>   kernel structures, only as "opaque" pointers, so there is
>   not any real ABI breakage.  But, due to the visibility of
>   the structures going away, the CRC values of many scheduler
>   variables and functions were changed."
>     -- https://r.android.com/2425293
> 
> While these specific changes probably could have been hidden
> from gendwarfksyms using the existing kABI macros, this may not
> always be the case.
> 
> Add a last resort kABI rule that allows distribution
> maintainers to fully override a type string for a symbol or a
> type. Also add a more informative error message in case we find
> a non-existent type references when calculating versions.
> 
> Suggested-by: Giuliano Procida <gprocida@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
