Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7AE3B0AE1
	for <linux-modules@vger.kernel.org>; Thu, 16 Apr 2026 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776351270; cv=none; b=c37+XPmxcS3oIP4QgH6tX2xDSttyeoUEHCD9wn5x8ITZVu9X8gQwbMnfHl5t/ExY4+29DpEnIybX8h0ULLyOjIBB8P2emq8SoFBFpschx+BB2Hb8HhPuFi9Q+Y8ShVVN8rWvaWt/NvrbTm7mJafeOh/SXsb2zyV8wFRISoV3Fu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776351270; c=relaxed/simple;
	bh=EPHRfB7I5uH7xIWit20L1zYnCi9wOT2o59aqll9Yfh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCm2k/fA45G3gCOlbZN32LDOCSwLwKrDsbsvjHdaBYFhrzdCpgqDeYJuKBHGf3X0NMOKUy8rf6aaf6+9TMUd09REiQU9NbfNI2hiOajnsSXPJS9aZPfjRKmjslCpvqMaLbSB9Rw/PSNxfbMHHy1MXor+vCsyeCh4uRrhc5lb89M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AxvLgQs0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AxvLgQs0"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso79065005e9.1
        for <linux-modules@vger.kernel.org>; Thu, 16 Apr 2026 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776351266; x=1776956066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nUk9+5ugjhG90uPs8bskXfY1v/H6BYvalTyZQcNSMUA=;
        b=AxvLgQs0aTfo5aAuCATMtxqRRyrWZscAlPsA/t41RJ+9AHIVNMbCmUsIeVQrkPCx+c
         w6usVFoGLtuyL6ix3ExuPLMCE2wXopuILo7/owj/aeMHFfikW3URlwtyVLrBFDMGmC9R
         oriTluTZb8rpNneBcFfL6C9opqoTySGkMuV66LC6WpwfOpNLO3JZwFkHqLleCS4QYWsv
         7xNDCB+p2+IISzNFUXDt5Pq74+TRIkbYatSvjOFQ/jusNKjpBs6kIWj/kmd646CZan1f
         vOyVERub8RMzJxxLAGz5S3gV5TaQz7ehlGQp3Jm1jNc58JUIwHLYqgbcY3wChskeG4uz
         ABXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776351266; x=1776956066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUk9+5ugjhG90uPs8bskXfY1v/H6BYvalTyZQcNSMUA=;
        b=gZ/2w+VfehJk1lM+zZGHuEuLnWBP8QeLV1ssLtO+yKjC0yLrMNtLideLyAtpTu723v
         CnS2TRCzE8OZREiIktdfZ5TIHTRd8h+7mil9WcSfZynddGQDxH5s4AmR5bNkILvxhg45
         tLjAcb/Y8GArwDVuk6otrEA6VXPRPM0V0g9zzfrS4f83UzSjUWJMjQy0qQQ+N3aUeUyE
         oB02Whppu1pTlMJj1MVqGhO86q7GlqfgjWsD6uHNYVHaeOIjamyAbYIvMPp6/kB2jYgB
         J7vOass9YNby9yTM6Uh69TcuoRfBikQm2E1QLDc8tosAe+57FGnBP1aZyZT9t+iibSiZ
         Vvqw==
X-Forwarded-Encrypted: i=1; AFNElJ+IJU22Q36Kgd7ZE30Bn3N7oJ53EqvDrgbl6v5vPHq/sMMpP+XPIJ7VXlLWh6Kt9LariWGgJik6x7HcWzaB@vger.kernel.org
X-Gm-Message-State: AOJu0YxOVZ4XSddMgVnAUHPWQOFueEByvLs8zfRakfVd4A2B+3mfgYkl
	7msQwWMAsLc7+67iHNf2h5DNk4ft1zkzMc0nzxSd+uuvRVQXYU2HseeAqSWd30d+tIo=
X-Gm-Gg: AeBDieviQHkkiM6Zs1w7kPkLaN1JwfrjwGvcLUcxi3x0j9g+iRvSJBNBp5aIYIlV3TF
	ZXh3AQfKYSniA2U03mS8y++QVXKusDSqpqO+mwwl5kI1DchveZyZGbzWKDFbmv9VSVPTWGe4Ql8
	1CUdsApBpjdWEWJEBSx0a7Ib1ojiysXYdLt7xc/DJv643D7jTuosNb2wdJUIxZdBQzmtkjQLnuE
	0kd/GshK/Hqx+fngxE+QFD+DRpVWJzy7ACscfCPC0yBsILlZeO/gntj6HYmeI6DN6okSDi7GBrx
	bYIoJk67GnBcAY5YYFSqX4N/isdHHOa8YMnzwoRqnQRYc4iLvFJySzfFoANEmzLtZR0E9u4z9NC
	K4llhhFtHWLy40c1fqx4UNZoK3JQma806AQf8zrxElEKEtdFYqS2G5HhkcrJKfC0KZfnDkuEWWJ
	IpcNXzHES1+YcvEetiFacm07OIXw==
X-Received: by 2002:a05:600d:4:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-488d68ab2bfmr302762205e9.24.1776351266415;
        Thu, 16 Apr 2026 07:54:26 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead2decafsm12915427f8f.0.2026.04.16.07.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 07:54:26 -0700 (PDT)
Date: Thu, 16 Apr 2026 16:54:23 +0200
From: Petr Mladek <pmladek@suse.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: chensong_2000@189.cn, rafael@kernel.org, lenb@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, viresh.kumar@linaro.org,
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	bmarzins@redhat.com, song@kernel.org, yukuai@fnnas.com,
	linan122@huawei.com, jason.wessel@windriver.com, danielt@kernel.org,
	dianders@chromium.org, horms@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	paulmck@kernel.org, frederic@kernel.org, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	atomlin@atomlin.com, jpoimboe@kernel.org, jikos@kernel.org,
	mbenes@suse.cz, joe.lawrence@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, live-patching@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] kernel/notifier: replace single-linked list with
 double-linked list for reverse traversal
Message-ID: <aeD4H8P1DiPQoM8V@pathway.suse.cz>
References: <20260415070137.17860-1-chensong_2000@189.cn>
 <20260416133004.07bd2886@pumpkin>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416133004.07bd2886@pumpkin>

On Thu 2026-04-16 13:30:04, David Laight wrote:
> On Wed, 15 Apr 2026 15:01:37 +0800
> chensong_2000@189.cn wrote:
> 
> > From: Song Chen <chensong_2000@189.cn>
> > 
> > The current notifier chain implementation uses a single-linked list
> > (struct notifier_block *next), which only supports forward traversal
> > in priority order. This makes it difficult to handle cleanup/teardown
> > scenarios that require notifiers to be called in reverse priority order.
> 
> If it is only cleanup/teardown then the list can be order-reversed
> as part of that process at the same time as the list is deleted.

Interesting idea. But it won't work in all situations.

Note that the motivation for this update are the module loader
notifiers which are called several times for each loaded/removed module.

Best Regards,
Petr
