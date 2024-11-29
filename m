Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6147C450EE
	for <linux-modules@vger.kernel.org>; Fri, 29 Nov 2024 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732907947; cv=none; b=gs8aisMUA6KEf1BDbA9fmIUZIM6kdj/0WrQc6OPVc11+TX1ZRoAiwFpZjzPbSlwfuuVcBKpSrfJY7LKaLK3Cg3KPy/3W/NusIH9O5Zr+8tWL/kTeFVxbtONUTAwX/wfbINlaPQ5yT/4JDPIpeAEcOEMl0pdBKNojNPOAXMWjaIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732907947; c=relaxed/simple;
	bh=mNS9FaMKCLppUduw748DyIhFvH81tqU2jublvdUmfik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xzo/AvBZq92yZPZGw00OKtgnd8INIM0RrTaK7i8WAHhNwWdha5VdjABpYSEYSfLSZb2a/7penOuusQSEqHPmqipyo8je5FPx1uQYFtNT1ZkeoaA7QPQWgbs9lkCFUwOISjczmREnrIWV6fDOX8asCWc5ZByOi3YHKSOpgCR8pV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TgBX6elN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TgBX6elN"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53de579f775so3355844e87.2
        for <linux-modules@vger.kernel.org>; Fri, 29 Nov 2024 11:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732907943; x=1733512743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XI/yTJn2K7uR/0ULxeWbYdLFp4HJLuDCg3+eK/ajORI=;
        b=TgBX6elNdI05dys4pYQACaKyxrUsLxDBhpPQfy+BqX2llgDvEbkoeMPpIKqLLRT+CD
         E5kCO6XHiXSdbL3UjemdiZs4+of+BkZlmtbUmtQxvHrWvarin6e10zVdVvuGTo90N/XR
         e3qC1YFa4fb+VcOG/y8cqZWHvLxBFFIpHi2EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732907943; x=1733512743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XI/yTJn2K7uR/0ULxeWbYdLFp4HJLuDCg3+eK/ajORI=;
        b=DeKwq1BZc9Z3hDvtHCFEwowKNLoYh0nWMnplrfvwnROAl/GYsex5tq1/9L1kIFkutp
         k643ALDvqstyNBUKutZYdznPd6Ie2UJrt8a8IpPrHUlrO1XasYDx9bjJaOixNSjp+biE
         do24ug/vzNjhuFf7KKGWuI8whPLjP+/IZWs1ygcw51beARxqmWsY+Th1VajMNoKAoeUA
         +skALOrkMPR1gzjvj2WwyUBbw2aoTmDQW/TpV8r9BKsIxIAEZLwrlyoiv58b2h5idiOX
         jEuN8rM7/JXHshpmcV/aafek8vcqhy32NS6eMY5piJURGdbjrEQunzSu1gQG1CvkeCJz
         rQcA==
X-Forwarded-Encrypted: i=1; AJvYcCX3cyMLdev2mF8nN4CMby/XZI8IhGQ1qU2NoDnSs8pD3LbzaYI4YfIM/NxUhltuVll1BtpH3F6gsTL8Wx5z@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRx5I+ryVgjUGqwML92546sqMxmbx4yWF0jtJUaycF4D6wu07
	ptRfg0jKRmJbsplGXxdGunNMvmiUw0gdcBpTWZ2ZRWtgmp9MNw28uP0V1/sUWSgdVMC1NntBmeG
	XJMEo1g==
X-Gm-Gg: ASbGncvjPnu29SVbR3KngpA5PefAQXJkdjWozPynWKZrx1ciQfCGlvah82U46gKwkY3
	Xxjh8Oaohx0/BExBdXRpJn30C7jS4jVmuHXZoCC6/DehCaerj8VZLeW59s3GTDJUpJf0XyZSniE
	kCO5sSFbtOyWnvJEwAHw9MvP4EQ1Zd91W4RK/LRDgOMiQdH7T+/Og1/O9tKIcBOGQNbN63jVtHk
	oDDjgAaeoFM6BTRUCQkr6lNxZuWUghESF5rcYn9H5BUHLkt58Jnb9qwQIoJYTQcSeX1rK+TEATK
	EMbrsfQNRldZ1V7cExy/X0Y7
X-Google-Smtp-Source: AGHT+IGYwVZOLP6au3jR/b+tKyzu2J6Dgybc/NgoVL+wKXNOI4y3c/Dm0fMo3l7SbX9FjMuGBNBH0Q==
X-Received: by 2002:a05:6512:3b96:b0:53d:ed19:d25a with SMTP id 2adb3069b0e04-53df00d9d71mr12166913e87.32.1732907943327;
        Fri, 29 Nov 2024 11:19:03 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a06fesm561079e87.258.2024.11.29.11.18.59
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 11:19:00 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53de92be287so3557520e87.1
        for <linux-modules@vger.kernel.org>; Fri, 29 Nov 2024 11:18:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5ZEMAprtlbgespzUiXIGWW3LS+R7VVDMneiNX8D0StiqHuhsiHNisTMhwZyZw8s+WsV9WWZsZHxr1XSFM@vger.kernel.org
X-Received: by 2002:a05:6512:3e23:b0:53d:e5fd:a453 with SMTP id
 2adb3069b0e04-53df010b140mr12908711e87.39.1732907939280; Fri, 29 Nov 2024
 11:18:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0jEBLLRoUKoBVPk@bombadil.infradead.org>
In-Reply-To: <Z0jEBLLRoUKoBVPk@bombadil.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Nov 2024 11:18:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh6SLoXB4zAY51yScDMwyauo0a8FJ05TO_bb6UVNXcCNQ@mail.gmail.com>
Message-ID: <CAHk-=wh6SLoXB4zAY51yScDMwyauo0a8FJ05TO_bb6UVNXcCNQ@mail.gmail.com>
Subject: Re: [GIT PULL] Modules fixes for v6.13-rc1
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: samitolvanen@google.com, petr.pavlu@suse.com, da.gomez@samsung.com, 
	linux-modules@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, geert@linux-m68k.org, masahiroy@kernel.org, 
	mmaurer@google.com, arnd@arndb.de, deller@gmx.de, song@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 11:27, Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> This consists of 3 fixes, the main one build that we build the kallsyms
> test modules all over again if we just run make twice.

Thanks, my empty builds went from 43s back to 23s where they belong.

(Obviously when some core header file changes and forces everything to
be re-built, that's all in the noise, but the small random pulls are
now much faster)

             Linus
