Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1640420101F
	for <linux-modules@vger.kernel.org>; Fri, 21 Feb 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740134904; cv=none; b=Gm3jgz93SCrT8cQxdMnNrGuF8Ep0avcpqtmGCx2dkrpF+sLRNy58r8fyqYTZ2m+QjSiB9JCokvOpYiy3ktWu0PDKFs537EjCRKDKPN2SQN9QhY8tAExx663gao+VdMnGGYnFABtnO9i7yF3hbOqQOAbPNM4CuaLTv/sTtESJweU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740134904; c=relaxed/simple;
	bh=6vR+TEiH5suPoSHJ1QLKsqeNt+6EiaZqxxQ/iGHjpSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FVdMWno7XIkq70LPLLndI0z5XHqc8GtGpOy7A4xE+03ZG48M/IGpNYuX9MlPMZnkWEW2oN12QYkEYDh9hD4u+Ek7CBNTz6Tlgoify6oxOqYSua+hr64YLZGOgzjUos1JEfnyCysbAZzLtKAyQn7yN7uX9ZjP9HRuLkeyS5xCI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=bShylq91; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bShylq91"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30a440effcfso30396501fa.0
        for <linux-modules@vger.kernel.org>; Fri, 21 Feb 2025 02:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1740134901; x=1740739701; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6vR+TEiH5suPoSHJ1QLKsqeNt+6EiaZqxxQ/iGHjpSs=;
        b=bShylq91Xww3U2dPUsZr831raOnEXMxqm5dAGlIkcTwWQ5B4kyFY/bNcmZBsDLTjPD
         bnwgyLA/qTtjD6wDi3RNvb4S1aUaS5j3XF0tu/cPLmVrvziK+ah1+hkcE5adIUsW4v+o
         OauoHHp9WkRSyzGymyQj1bUWQ0zw5+CrsjyxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740134901; x=1740739701;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vR+TEiH5suPoSHJ1QLKsqeNt+6EiaZqxxQ/iGHjpSs=;
        b=CWjBL7gwpRDVwlJZOwE9q/YYI7GULMvWjvQtco/AxmPxMzBoQybwPOJds+lLfI2HLm
         4VxkiTWYoq5pF9HxUIO7gSYXexrzf+UNhcBdynRTo8FadCMY1w9e1QaXAUspiZ5vM2KZ
         NJjbVyZHI3pZSeQ9kLnPw1dIVKnGB/n6iCchOQQRcte7+CyqL6QjMhem+TOfw7PU2w7X
         V5GRk161o826Us4pMCs5cnwDYWxg0F3Zo8ZxiM043junUguHpLiVML5IFp2d78C5k0v5
         Hct9zS9Dz+Jv0dyHJQ4cFAWk4KoJ+ydXpe62MqsY+EBqfW98yTd4DgY8BA8X7ECWG9Eb
         HfyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc6w88zkvZWaBWdznvr3LlNELsek6AV79MLrtJLB9sGxlO4rtYS6/FRgK6KQN4f+CyoqXfPmpDlkc8pWrR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8C27VNx3sy5j7s7J0/HkUjCVehOTy+VJudqsfUba/YFQnkLTo
	P6uHhPwzQPC1U83ZRw8+i+xJfYdjFBqiUAE1YoV5P0qqfpAZc0yBAuB849hLuew=
X-Gm-Gg: ASbGncvGPmByEc53vsRBH2MS1V4aTGNn7PXmhQDfyuBmMGi5Hgn65ka5LLySGwYLK+s
	ec+XQ7ORcNcM7IVQUsb5w8+l5jNs1xrvoYdq+xt3o+r7ynV5GPnJjf04/fzddMPTvHB1U2ZH8LC
	rg6NEJONbPKyhG5CIRTV9T/cNrXyCA5YBwfYM6k+S3dhHU82fDUXIJIWVDFlx/tSXP3At0E5kqP
	svslts8qS8ebISfaDsebTWfOna9T2rLr2szHeRPqVrEEqlAX52rbxm5/46drfdAeAZDnTCl/aKF
	2gyl/tH2G7jjcSxv/SINlJiYhfY=
X-Google-Smtp-Source: AGHT+IEuI2ueJ54VQyWBbWJeHfFpz3nm7mH8Jqru0OTTgwkkKtB2v0B9s5ZZn+FWongNN/eNaVdGaQ==
X-Received: by 2002:a2e:98ce:0:b0:30a:2b40:af0a with SMTP id 38308e7fff4ca-30a505bbbb3mr22231871fa.2.1740134901015;
        Fri, 21 Feb 2025 02:48:21 -0800 (PST)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-30a29ab47adsm17629081fa.97.2025.02.21.02.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 02:48:20 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
  linux-kernel@vger.kernel.org,  linux-modules@vger.kernel.org,
  code@tyhicks.com,  christophe.leroy@csgroup.eu,  hch@infradead.org,
  mcgrof@kernel.org,  frkaya@linux.microsoft.com,
  vijayb@linux.microsoft.com,  linux@weissschuh.net,
  samitolvanen@google.com,  da.gomez@samsung.com,
  gregkh@linuxfoundation.org,  rafael@kernel.org,  dakr@kernel.org
Subject: Re: [PATCH v3 3/4] kernel: globalize lookup_or_create_module_kobject()
In-Reply-To: <450e8088-c239-4738-a996-834734f770a5@suse.com> (Petr Pavlu's
	message of "Thu, 13 Feb 2025 16:59:25 +0100")
References: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
	<20250211214842.1806521-4-shyamsaini@linux.microsoft.com>
	<450e8088-c239-4738-a996-834734f770a5@suse.com>
Date: Fri, 21 Feb 2025 11:48:19 +0100
Message-ID: <87pljbo9os.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 13 2025, Petr Pavlu <petr.pavlu@suse.com> wrote:

> On 2/11/25 22:48, Shyam Saini wrote:
>> lookup_or_create_module_kobject() is marked as static and __init,
>> to make it global drop static keyword.
>> Since this function can be called from non-init code, use __modinit
>> instead of __init, __modinit marker will make it __init if
>> CONFIG_MODULES is not defined.
>
> Hm, we should later clean up kernel/params.c to use __init_or_module
> from include/linux/module.h instead of its own __modinit implementation.

Good catch, yes. Mind sending the patch?

Rasmus
