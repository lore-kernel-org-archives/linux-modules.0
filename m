Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3622B3033C0
	for <linux-modules@vger.kernel.org>; Fri, 20 Mar 2026 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028759; cv=none; b=b5NvV2nhcUfWtwHm2+mlRHUZQhgu5iBNjR+9xiHqp0IsVh1+I5QldE8l4ZdoyIOX2kyaQoVxuNFyIHVeacM+z81hNijl+Mt9/m7ji3zBm2Ntzm7bHs5pEfMh7XMJCi2tJ4ciK6yKTbaMfDB19Kfi5ncYgAXVGmS8FwaDp0gtH4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028759; c=relaxed/simple;
	bh=EcOY+3sl/y3gmE/1cHinofuMdoJkfkIO2WeYZw2TDjw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lyZxpicZC2rfLHfF8nw6xSRVrdjpQpzNImuWMjs5r9/jzCtgNy7ILJDFYV6AwDE88ccX96umsA7SnBfbOo05AmmhoYbZ04QMewwqpZmFi5eA34/YXMpb3atXesEgfOuVfxLyErhM8z8gWCNsLX3p01/A1KwN/EetSl0zhvNmtEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BRSLTSxC; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BRSLTSxC"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so752381eec.1
        for <linux-modules@vger.kernel.org>; Fri, 20 Mar 2026 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774028757; x=1774633557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7jADpC9+tWP1R9nEbp5/ZrMMGvQP1aDHnBRajrcrePs=;
        b=BRSLTSxCv8PXV5DZqrwhNOuyWO0dgKiuqZxqh4UOorXHdTABNTegv8klIgEu0aaN15
         XfFU2pDYBhwruylXWjRKHerYhEElgyT4DJWp9awLOOW0w+IXjHoOINnwt4AA6qd9tiiF
         OwXKA4PnUBMSj69H1wdWqxG9JmgIrHXZOzNWHNU9g7x3i/DwG1qELspaxFYU2er5byBy
         yOt6luvXYYREJbEVuSSLHOZ04xE88U7QdopYc0O+8MA8sykSJ5FjLy+6z/AxdXAUj5Uo
         eOcv7wz6oQTa4yVdVg/Q3hhjYAbLCu7BA87G2qoiz4CJWuDRQkkPscVcOnrzAcSlq58r
         pYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774028757; x=1774633557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jADpC9+tWP1R9nEbp5/ZrMMGvQP1aDHnBRajrcrePs=;
        b=AoPSJHQT/JLZ2Ko6cj8a1LfSjBqjzOqTzbVuEzpF4ZR0MqhxrzgrdRTMnmgfkn36PL
         wIif5ErflrpVTwlJhvT0Pda1pHxDNzcDcP9QRGnKumJ9vM1aR05GnYGxKAiavdGuY2pR
         +lmdXH/e+BaC/KM0EsX1TG5GjDH9y25kFXFl04t3ukvQdaxuUaCyKA0K4H3bJk6W+kAD
         MtTMkA0IpyWrgjH7rqC3YzMRVpBK2t95UD6YASTFLD+2fQixty8KESCBmx3oU+KA8Jit
         ybaTQbWJ3mQrsAWnIMWuQpW9z+yxCw5Aj/MbA+Wl+lTuFQaMW4a8svPa2z58F4dXEqEn
         +Jpg==
X-Forwarded-Encrypted: i=1; AJvYcCW+xyMF3mvg0t7JEBgpD054lYwosoJLq+4r+yVdbxU6egj+aT6xTvVEw5rFAgETvg4T5r0ugKCIlSCfPLXL@vger.kernel.org
X-Gm-Message-State: AOJu0YyPUKeEfv8LSuGxl6EtB127ALmVGuXb/ef81eX2mRBT0USfuh7x
	CBDp2ObmWL+QPoTyJedxvfC6L/1rrYqJWAnl7UfNRNRoxMjeLxdhuU4M1o0kQ4kybbgSHsA3SVP
	/fW7jC4zDkTao41hbq7W35BiZktW5eQ==
X-Received: from dyu19.prod.google.com ([2002:a05:693c:8113:b0:2be:4b94:33af])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:1f05:b0:2be:1246:4dad with SMTP id 5a478bee46e88-2c1095a8109mr1574829eec.8.1774028757194;
 Fri, 20 Mar 2026 10:45:57 -0700 (PDT)
Date: Fri, 20 Mar 2026 17:45:55 +0000
In-Reply-To: <20260307090010.20828-1-linux@opensource.nslick.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260307090010.20828-1-linux@opensource.nslick.com>
X-Mailer: b4 0.14.3
Message-ID: <177402875586.3545153.7837463244242752504.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] module: expose imported namespaces via sysfs
From: Sami Tolvanen <samitolvanen@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Nicholas Sielicki <linux@opensource.nslick.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, Matthias Maennich <maennich@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, 07 Mar 2026 03:00:08 -0600, Nicholas Sielicki wrote:
> Add /sys/module/*/import_ns to expose the symbol namespaces imported
> by a loaded module.
> 
> Changes since v1:
> - Simplified commit message to drop unnecessary/incorrect background
> - Use .setup/.free callbacks in module_attribute to ensure
>   imported_namespaces is NULL-initialized before error paths and
>   NULL'd after kfree (Sami)
> - Updated KernelVersion to 7.1 in docs for next merge window
> 
> [...]

Applied to modules-next, thanks!

[1/2] module: expose imported namespaces via sysfs
      commit: 3fe1dcbc2d20c5dbc581c0bb458e05365bfffcf7
[2/2] docs: symbol-namespaces: mention sysfs attribute
      commit: f15dbe8a94b6e3768b10e10bf8ab95b28682db80

Best regards,

	Sami


