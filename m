Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59D52417C2
	for <linux-modules@vger.kernel.org>; Sat, 27 Dec 2025 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766864157; cv=none; b=PZmfPmtX620fYahl99YQwTyztm7ht8X76r0wdaAPtvZZWNEowcfbBpCryjwxjApGDZMHgLvdWBmb4E04nXvS2EY/1q5jJHuzvunmtIVvBtPLBgEJ2oGz2Se0I1jZ+RPZEoLoK6f33bXImzRtEfw5lcJmF9GkXR8XasgiiKrb34U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766864157; c=relaxed/simple;
	bh=Ays4sQx/Nq4nCe0PJ0q8Ts2Inf96vnJULh6aklwYDa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJKD4yqpiDDsQMi1oCOiWFnX2DERprscbeLUqnYSo2P1PLQrXV7OQ7qAWB27kI8zqTrvRqHe8TRUUSwzCwUSDInlfjvd8/A2TxeekJRFL177wBJS9MrDRaK/eeavJnpFS6G3Scrlfh3IrocppICqK0c8eB4et1xOjrcdIHjmYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epiTrlKr; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epiTrlKr"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6467bed0d2fso4937030d50.0
        for <linux-modules@vger.kernel.org>; Sat, 27 Dec 2025 11:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766864155; x=1767468955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZscOEY94JtpqTuF2Rte0ITMRfXFqnWcGnNUyPWqzXog=;
        b=epiTrlKrRr+3319mz8eBhkiRN2E1uvlHs0N9/cvoE8bCoHocXByn51TtrCX8qdGIeM
         kYkdIBK7msTBOMwURrZgfwdAJ1X0AkCM5wGt2Nru6873cVUx1Y8Ew9zQn1XKJcOcgQYz
         4BF7NMnmFdmmthz6iZNe84T/iRGZrkNG/AhususXADiMkWX54HaWsF4YTdntA9sNd20K
         Jly+OiV60w3h8+Z0TFq1bG3kq1x8kMKTzwrY3Fwn+U/yewR6KpfvUSUd2N8X9btqhIs4
         s+QKnfivX3+TRb/w97Jzbs6/HNOeyo9KtK43S90ipA72l+hm0ay1OF/IaRXaEtvLtTP9
         eggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766864155; x=1767468955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZscOEY94JtpqTuF2Rte0ITMRfXFqnWcGnNUyPWqzXog=;
        b=N10hln7PgAfpCL5x4RYyNi9NK5rybD9PBM5VWe/uM1ul5TzArxjXX86zD+L4yZ/9aK
         LzEKrLMpFlHnIEBddSx4GA7Ski/hR7it1ByxtteoswvsQFUIeiyyvFUApkefGWOO2u5u
         Gl0FZj91cgCgI9OE6YoVFJkVIys6Z6QHijlKOtOGtdJ1iv4fwYs5j2+Yhp2OCAndgwYT
         suyVNSnTQOV7cE4aE7v+YwCI8IXEYWsTfbrtPIuAXvndP6eJb5y9d3MxzYI2ONqecStf
         LOzqgdcVN+uswBx04gRDZK8RwE24v2uqV996J2L5KMI/drIJBF59JrQFuSjC2oCihDXS
         m3KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmxhS8PmhZguEsJODQN7hxl+ioJ/dglFXN1HG8gZhcDsRU/HMHP8wgbvxFjTguq41sAGZU0CKRiRTWjkKf@vger.kernel.org
X-Gm-Message-State: AOJu0YwVkMR2q2xnhXF8s0SWRH5Q9clikkv1xowF/EtvCDIDXNzMOxMm
	PEDNjQa+SBgvrOdS/l3A1NKzQ48tRZbOMZMgB7kfvMD+OjLxnriZPstA
X-Gm-Gg: AY/fxX6Q09EzLkaJiYSs/rmNeyoRSrCOEQ1GpBY8AsCRa1OcXbM7HvPFCD2OM6lEoHz
	MCkggnuLPyUWvW0c5r7ENSjZrqF5P7HOd5eg9BT5xmJCaeV1etoNUoJ3IVXZwSCc9hKDWUKZAUt
	gOCCHLQnwomWGBqKxnqgFl+YlsMnx4Y4UuJIRw8+QLdFEBAj4pSFPNOLcGtziNslLE4mTZMSMAq
	UYkIsGWRU8mfP8CkncbRZDKzk/4gfo/cCjpWypFb9gitWhtMKy0CnNiaYqVzEdPqEs8X0tV8Zf4
	AwyX0VDssJ/F7zEeKsxrOitzsxQK/CdZ5yiEYeK/lmoTBfq7+A1VdyanRmQ6gu8JstG/hWBOZ/l
	Q1GzpW7/J+OGOrTTPHJeFb4yYUX6FdI26Qz8M/rCbInQ+lUIwyDI0UfM95JIxLdJbnEMEv0KNJ6
	eSgQfSxoY=
X-Google-Smtp-Source: AGHT+IFTyqtO8AIMR6I5RrW0NJVOngvdnp5kCSpfYPRgSEcWGvPmUWwG/Vuj1vc27aG6932toBOBHQ==
X-Received: by 2002:a05:690e:4106:b0:644:60d9:865e with SMTP id 956f58d0204a3-6466a8ede93mr19913042d50.97.1766864154604;
        Sat, 27 Dec 2025 11:35:54 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:f47d:8af8:869d:704b])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a8bd4c3sm12689811d50.8.2025.12.27.11.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 11:35:53 -0800 (PST)
Date: Sat, 27 Dec 2025 14:35:52 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] kernel.h: drop trace_printk.h
Message-ID: <aVA1GGfWAHSFdACF@yury>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
 <20251225170930.1151781-8-yury.norov@gmail.com>
 <20251226115848.298465d4@gandalf.local.home>
 <aU_xG7pK9iauff65@smile.fi.intel.com>
 <20251227105701.5cbeb47e@robin>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227105701.5cbeb47e@robin>

On Sat, Dec 27, 2025 at 10:57:01AM -0500, Steven Rostedt wrote:
> On Sat, 27 Dec 2025 16:45:47 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > > I'm fine for trying other ways to speed up the compilation, but removing
> > > full access to trace_printk() isn't one of them.  

OK, then let's keep trace_printk() available for kernel.h users.

Andrew, can you take the first 6 patches of the series, if no other
objections?

> > I interpreted this as if the header inclusion should be moved from kernel.h
> > to printk.h as a compromise that satisfies all (?) stakeholders. Is it possible
> > approach?
> 
> I'm fine with putting the include of trace_printk.h into printk.h. If
> you remove printk.h from kernel.h I would expect a lot more people to
> complain about it. Including Linus himself.

The difference is that printk() is not a debugging tool. It is used
widely to report errors and info messages. Normally, I want to cleanup
all debugging code from my module after finishing development. If
trace_printk.h will be a part of printk.h, there's always a chance to
miss trace_printk() somewhere. I'd prefer to keep them separate.

Thanks,
Yury

