Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D886721ADAB
	for <linux-modules@vger.kernel.org>; Mon, 13 Jan 2025 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736766571; cv=none; b=JCs1yZc8zwQDMMTJhfMdTdBXm+3ArbUA/kn15wjtVb1OxudRK9vi7mkNtvt1dm5hq8BKM2yGwhkd2+f51fg1eF5VX74veVQzkX4wIsDFRuNKy9bpwcvLohVxpNLFELoecQy0pls/S0nWpZ9/O3U3rTDk3c5SufEX2nuyIw7IF8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736766571; c=relaxed/simple;
	bh=ZBe0sfnc7zg6JURaS/7mGb9fnjhzTgloK+gGjDevo7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vz/woMw+gjY9KB9r7qL8p4TBnWl1uADCiqnNAHfLHOkwVBi6d3tNvtcvAbfqpDx2tJLKHkhmMM49amZ2GZ8XZSOuqImoxYPJWWB2DMY//+fpwD9xqjAqAA/npjU5lh4krt4GkdmLGqyY/1V2PErJGJ3PEQEiR1gOM5P5yigTF0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aeEvQD+c; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aeEvQD+c"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43618283d48so29319965e9.1
        for <linux-modules@vger.kernel.org>; Mon, 13 Jan 2025 03:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736766568; x=1737371368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yO9jB5U55CFpa8FrMbQGZSIRIawhRGDMMcZsD4aYNRg=;
        b=aeEvQD+ctOGeqc8Mi+Yf6atL96YkH3wy7sxAQXX/SefAekeD4I6jQO3us8UnXiPsoL
         fwtZdJLoKqyIt2rgq/QjxGU9Wb0rzdGEW58zfAHFXIyepHjf75rRbiGuj5Lr58x+svdw
         MRg6+j2zA2SSl9UcU5rLu9KE6YFW/8s4xTFmCaD9DaEePR+r0Shbn7pdv9LC0lzFjkK0
         /d9Blp2i+ubwwI9hlaXSAGX6wzhgFO86hK+c/kxc+IGyQ0ZYh3jvuk7yfVyrHaYdXmq6
         Ev/VZ0OyLI9u67+P/OWFr1LW63XpVF07k9y5WzRFkJahJ3VEDr4VeHCdpFShyjv1CwK9
         biyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736766568; x=1737371368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yO9jB5U55CFpa8FrMbQGZSIRIawhRGDMMcZsD4aYNRg=;
        b=b+xD890NtnpTHsj5II86EtGNOqWu6s9m66dJA7HCVSOBwyFmjKtvrTIZzDNNLSMcxp
         Kow2r+iDUcZHUFXraqiCmDq9o3sVZ8MBi9tmXINvzQrklyafKY0co7Hkpuf4JfFZv/GB
         lrywijQGuWoJ3bIMLxhbbDHFg9KySSEt01oTLNrrwPvxZPhYaJKUe6zpQ3TT6DqA9H1F
         uH0C7MX/tLpzb0W/3yRSI1n7QE6g1blEt/Uh+6pp3UgmOMwJxT0f2fqYnr9qCl5UQ1Ko
         +QggLYwNOPx3InkfyZKdsxaUVyV42LdYr9zuyugyYaiY56qhEU/7MB2Vngm/J/yfZJ6u
         s8BA==
X-Gm-Message-State: AOJu0Yw1sl+JKw1kNAgN1jziicYQ+5pmpvHFjwp5IpW1kRI7nB8iwgld
	CZ5qgaseIskgX8QZ9aGtRAHp2+F+3HQaPEsvwrP0F/3N+YHnM0uQj9WfMB6+qrtO1SM88Sbbyj3
	b
X-Gm-Gg: ASbGncu8TlvqftEuUpEWsB8tc9NRcAv255nMcA+TTdO/Y4XqRVGouM84BR9VXTfwAdM
	mY3G9JegaDWRwwq+DZD6+nvwEeUenLCnWeiwZu/Q79tDicpcwWUlvzxVnD0ZdPv1j8dEm43ZPwq
	rsj13diabb+tYfsTm/TPHaOMwiKqOPpxajchO6N2DgZ8UmRf39X+Hdi82kEvFI/3CwCyDJzFENv
	1/vGjK8sleJo2up15P8UiQZ9lNdCTIynTyCbs9rsh+sLQn7+5hcKkNjsaha
X-Google-Smtp-Source: AGHT+IENA+enFa1LzVadzvoc7JlGnknzs3GtfFMxYVtUJ6zon2z4vMH3vBcpISCENkUttlp97mJA0Q==
X-Received: by 2002:a05:600c:3588:b0:434:fdbc:5cf7 with SMTP id 5b1f17b1804b1-436e26f4aecmr163912805e9.27.1736766568030;
        Mon, 13 Jan 2025 03:09:28 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6336sm174905805e9.8.2025.01.13.03.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 03:09:27 -0800 (PST)
Message-ID: <f4e953a4-4458-4034-b91b-7a433f20114b@suse.com>
Date: Mon, 13 Jan 2025 12:09:27 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/28] module: Use RCU instead of RCU-sched.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Gomez <da.gomez@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250108090457.512198-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/25 10:04, Sebastian Andrzej Siewior wrote:
> This is an updated version of the initial post after PeterZ made me
> aware that there are users outside of the module directory.
> The goal is replace the mix auf rcu_read_lock(), rcu_read_lock_sched()
> and preempt_disable() with just rcu_read_lock().

Thanks for this cleanup. I've queued the fix in patch #1 on
modules-fixes. For the rest, I plan to give folks more time to look at
the changes as this affects a number of subsystems. If there are no
other concerns, I'd then add the series on modules-next.

-- 
Cheers,
Petr
