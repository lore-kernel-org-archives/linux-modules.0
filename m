Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0B72877E5
	for <linux-modules@vger.kernel.org>; Tue, 30 Dec 2025 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767111521; cv=none; b=sbrH+wvGHDBBNrjwczaxU+TkIJkfIGSsfVwmuqQnowMKmsdvdPym94fU4nvMLlr2YRz2HQz8ewLQejI4n5KbvBjn+ED+eE2KwB+zZImwjG8uH86ptxI2NCvRHrlBijrJ97m6I9vwBR1ErZGPdd1MVQL3lpEUKR7/Zy5MdjiYh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767111521; c=relaxed/simple;
	bh=SEDmRYF3sC4jFxtJOkX4DoWYzz+dShc4NSCac80QCAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqaAJpueCJSQQkGa/UFUwU2qTtLi1F/fbzNghlsSmmXouNOvnmaYZMe+Nrh4o7unEhV+pYNS25c+cRvCcsvvmLrBNXPXMc1JS2bSasTxz+w4GnrDX44PdTEh4jq7GVv3QMWcEZUtQhGosX7S4GEyL1tCwgG7joU4jMaoace6P00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7oBMHjE; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7oBMHjE"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-644798bb299so7938973d50.3
        for <linux-modules@vger.kernel.org>; Tue, 30 Dec 2025 08:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767111519; x=1767716319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPsyxbejDKzht/HLlmTw2OYeWbm6m6QfdKcYrQLdRPs=;
        b=E7oBMHjEr8dxA1QNQpikfjAU+/luKg1/T5q50ptUNYDcPBC5dIhMkIitf/wdtc7fd7
         IwqD6oDU6dseSl66oMkc2xNTR+uL0x4JlbIo3B+FVDOPr38qgEev7Gh4qO+TqqVCNVZO
         BooJB40h4D0129zZ2NMcCz2VIOlQzbv2aUDFW+F/QDMm1mSOHv9RcH+hW906jJZln3tF
         JISkuS+0ZX0eIybGeRknZKo2UN8Y9abDBE9rBevY6TIZh/mayax6xDBEG9TGLYlGTwI6
         HQ3Uj6W3fUmKF/6WDLE5jy/rXjT5bfUOjloZHsKHfQaV9Yx0KPOAyRHvpDEXhKf9pt+F
         SLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767111519; x=1767716319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPsyxbejDKzht/HLlmTw2OYeWbm6m6QfdKcYrQLdRPs=;
        b=gDONge4LBjDaKJQAQQp7jiHrnSntJSab7DkuVc+5ka+TW8R542uxTMhLCswBj78vJf
         Tpqw8mZYCYk2PqayywVu6TtVx8yvmpMfTKIPkPDWe3LUgBElfnmRlERouKEEbOjnquVJ
         1E0F78OlB6kSoBc1VR9NIPLhrN1vgcIjKfGAdOjaSdBdS7gLO8WZkzvkb2K1/u1zGlHc
         rLZ9R/bkzLjvc9ZfQyIXSM/Cl+Wju6+yhw0B/7y6X27x23Kb8fwTSdbK5sFjxLdUFVbi
         DrJ5L7M/j+8omjkqJdHZbuG8w3dynqxRzrnrnz+vD8k0cnGI+2NAq28t+NvYPjqiiX6y
         P3sA==
X-Forwarded-Encrypted: i=1; AJvYcCVa5MsNhSb0Xc5lep2AL6uUVsFcGzT3CpNte6sHURRP4OeTC1m6ktjwf00bGxYl/mLkHatYHgz/TDjvCaqd@vger.kernel.org
X-Gm-Message-State: AOJu0YzmejyeH6F965bGTTlbc923MxIOvSTmABeHuxWfaU5WDJUkOYa8
	T3uJgNp8EG9pccwpyC4c4W1dEjLGxFV3XAoMND2dfdOs6niQpdHCl9BH
X-Gm-Gg: AY/fxX6pNgmdO34qiGvAwgz6xc4Af/g9JCMZIUPSzpGy7U3G7SrBxeeyi/jsmCpj1WQ
	K1lpdzIW+V6eN/ORsZyxW5LeKX4zBvzWcjGv/4nvLiHa9cPKDWY4I9+5d5ISL7+ZTmpsMw5C0PN
	AYXRzSS90ttVMR9tdY6rDWjGggfZotOjl7gEY0vRBhKhwU6vwrNG/Hvr8eX1UUipDlDbz+f/o7+
	FPjXaypALeOrZw23oXu3Sed5kLZAvnICxz5P4j2gsV5CWUzkNe9By4eUWD+idC4JLfMAdXX86MJ
	0L+rFNiX9AqSkvfwC8UlwWkKfGxMdYBRlsG5E7V+wfar0d3MPsdG1sDauzV9EJU02Y5hCM8Tpof
	hplq9I2EWDLPI4BBeFE7jealzcvgqNP+O8sp2ARskv2r3F7d44s3HsgtM25P6Vogf6n6mjZ2Ab0
	FB4yN7GYI=
X-Google-Smtp-Source: AGHT+IEgiqEBna6+E3gk4ji1N98UDvQ4ZQ6HTSlvv4L7zUJHLtl+Nax+qoAvUGugh8jqgLuKhXifXA==
X-Received: by 2002:a05:690e:11c7:b0:644:6adf:cbf0 with SMTP id 956f58d0204a3-6466a8e6db0mr24510128d50.92.1767111518890;
        Tue, 30 Dec 2025 08:18:38 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:79bc:cbcc:ae9e:6e4e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb44f0670sm126746507b3.26.2025.12.30.08.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 08:18:38 -0800 (PST)
Date: Tue, 30 Dec 2025 11:18:37 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <aVP7XVtYwb4YV9gy@yury>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
 <20251225170930.1151781-8-yury.norov@gmail.com>
 <20251226115848.298465d4@gandalf.local.home>
 <20251228133150.1d5731d04bc1b685b0fe81c1@linux-foundation.org>
 <20251229111748.3ba66311@gandalf.local.home>
 <9833cb61-1ec5-4cc1-ad9d-3e07f3deff80@efficios.com>
 <aVOTbArAxmbT5LY9@smile.fi.intel.com>
 <71767aa7-0247-4bcc-8746-3338905197b3@efficios.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71767aa7-0247-4bcc-8746-3338905197b3@efficios.com>

On Tue, Dec 30, 2025 at 09:21:00AM -0500, Mathieu Desnoyers wrote:
> On 2025-12-30 03:55, Andy Shevchenko wrote:
> > On Mon, Dec 29, 2025 at 05:25:08PM -0500, Mathieu Desnoyers wrote:
> > 
> > ...
> > 
> > > One possible compromise would be to move it to its own header file,
> > > and introduce a CONFIG_TRACE_PRINTK Kconfig option (default Y) that
> > > would surround an include from linux/kernel.h with a preprocessor
> > > conditional.

We already have CONFIG_TRACING, and everything in the new
trace_printk.h is conditional on it. We can protect the header in
kernel.h with the same config.

> > > But please make sure the default stays as it is today:
> > > include the trace printk header by default.
> > 
> > "by default" where exactly?

Seemingly nowhere.

> > The problem is that kernel.h is a total mess and
> > it's included in a lot of mysterious ways (indirectly),

Yes!

> > and in C you _must_
> > include a header anyway for a custom API, just define *which* one.
>
> This patch series moves the guts of trace_printk into its own header
> file, which reduces clutter. So that's already progress. :)
> 
> > 
> > Based on the Steven's first replies I see a compromise in having it inside
> > printk.h. If you want to debug something with printf() (in general) the same
> > header should provide all species. Do you agree?
 
It may sound logical, but I don't like this idea. Printk() is used
for debugging by everyone, but its main goal is to communicate to
userspace and between different parts of the kernel. Notice how all
debugging and development API in linux/pritnk.h is protected with the
corresponding ifdefery. 

Contrary to that, trace_printk() is a purely debugging feature. There's
no use for it after the debugging is done. (Or I missed something?)

Everyone admits that kernel.h is a mess. Particularly, it's a mess of
development and production features. So, moving trace_printk() from an
already messy kernel.h to a less messy printk.h - to me it looks like
spreading the mess.

> I don't have a strong opinion about including trace_printk.h from either
> kernel.h or printk.h. As long as it's still included by a default kernel
> config the same way it has been documented/used since 2009.

Can you please point to the documentation and quote the exact piece
stating that? Git history points to the commit 40ada30f9621f from Ingo
that decouples tracers from DEBUG_KERNEL, and the following 422d3c7a577
from Kosaki that force-enables the new TRACING_SUPPORT regardless of
the DEBUG_KERNEL state.

To me, decoupling tracing from DEBUG_KERNEL looks accidental rather than
intentional. So maybe simply restore that dependency?

Currently, even with tinyconfig, DEBUG_KERNEL is enabled (via EXPERT).
And even if EXPERT and DEBUG_KERNEL are off, tracers are still enabled.
This doesn't look right...

Thanks,
Yury
