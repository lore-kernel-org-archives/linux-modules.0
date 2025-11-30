Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65F285C99
	for <linux-modules@vger.kernel.org>; Sun, 30 Nov 2025 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764526583; cv=none; b=gzR489TyFXMgu8plweiPfEeuSimdkG8UKiX1xzv6BWafGPfYbm/9JXsOuXsomB2WJPrKmvBC5S90GsXr9pxxaxRZqqmZE93oe1FaqxU9xp9qh4MRp2OtorwKQHmvgEgyKpyT1xsIkHq7skMqVr9I4/c6wFDpDu7PX3VQILmlO9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764526583; c=relaxed/simple;
	bh=xMe2StGzK5NX+kq6kKhx0Deffi5L07sCSW856vZYwzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5Q5MeeAGGjwmkp/aluTU190Tno5o11wiluDTf2Vsa5yFhj7GWQcdjEH8VJluHbS7dxe1kSbwezVRei19ckYXqL4uabfUNRfdoUjlNdb8urX9WMqExwfUEjA+pziBnKV7OovMWHVMR/xU9VQFxgZAt+SMJYREQdE5FqydlcNaWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAt4cI59; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAt4cI59"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-640d43060d2so2467824d50.2
        for <linux-modules@vger.kernel.org>; Sun, 30 Nov 2025 10:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764526580; x=1765131380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPTHL8VwtfKfk45TFU08paMyal7EO1gfKoy+e7omzHs=;
        b=eAt4cI59JxPsGjtJ11O+7GH/oETePW6BnD31pPwEe+xo4Ko+0S079pSUzzoJBtfdzl
         bkRcWar8e1ngKub1JmKn8XVrwPU9L2AyUljdDOFnVYuDuqvsJwlRGdLLGUhs6FMf1TU1
         X520Iww3vfK0Q5CpmAsbwR1G5SDoHlpK3TWUksPKx3dVKsU5SEW+yEKrhE87yvd8uorA
         fYT8Xyv1NYoyDYGzFApp8UX+OaLsn8GwiFIf4C0xQfMhQOUP9OhToVffECMlLUj62TNO
         HMfWONadLlZC8QfZ5/Uf9Ayra6tU+ufYTCQgQVK+s8JUnjDLok2J42BwnebyXmDMip+O
         GETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764526580; x=1765131380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPTHL8VwtfKfk45TFU08paMyal7EO1gfKoy+e7omzHs=;
        b=FMZgLwC28fhCZvLfb6Xv18ACRSFEKepxYLShqksz+WGguM+ZIU3iOTiXBoVgzo/iLA
         ZEuRUVv32pgHiWAPa0xdyNnrUCUKC2CalZ+WJtSi5OUvgcGszNy2fUQC8iMLl6Hh0Jf/
         uAPIzu8HINfu7rcQrakTQNUdlqSucwXqSNc3qewiMfPMUsHOgG5+nL6gdcuPBWne2lTc
         7EVA3vLlElhN0cP2fMhf1wqXaPB+mTF26AzZErKYJosaXc9Lecy6W1UhO048uRaUKFDp
         PQIPxiGa4MHsq3H9W8RyfPkeV6KjR9KhteJJPBoXIolEcYk8/7RLdglVRz+JebrgUPiA
         gHbg==
X-Forwarded-Encrypted: i=1; AJvYcCX9al/CSBGneFozfT3UAoGulYwt1pcp0tfLC9EMPb6IW3PxDa/HlbSp9MitinrQQMOCfKZ5JFAIQYM2KCmY@vger.kernel.org
X-Gm-Message-State: AOJu0YyypDMuE80UQ/JdiABOc2kAQ+PdbrILio9ivhrly+Wu9f2Ye4qu
	oslRkV2FtEyKmwjSmaxZ9Na3D7ey8qQY1OG6AnuGNYbqVVaejrzfgP4V
X-Gm-Gg: ASbGncv01hVp0jQG1b7HRf6Vba6zonUiC8R6UDeIRwtX71yBf/UEuKMdrFjmyWrCIOw
	fo1gDQ/8WhyZQMbG5oi2AtbC3cXEwOpFSAOHK+IYjA4ygQ9N3TyZKp5X26wcTLcNnie+IucQ4X7
	eZSB1Stta2KKkaNwgmtRa+DipyNUk3Aln5ImSK8nPcr8mlmopDL/zGxF0d17hUQFgiMJ+m0F+FE
	RDLAWwmSc+fGRu5Kd3vISNJ0QgVx4UgHBnxblTk6HW+CdONKpWSSN78lUn7kgA4d4C1rUFFeZww
	fxtuzqYHF6ACabsypISfIq38bDymjfPoIUhwthsOTzCWA+rBT0nJze/lfcC+6fJmJbKb9m2rZ8u
	YM8l8SH3xg9UgJhD02OhIvnxpXxvH5EQZoHNxit8iyhKA4XUpnJkXAYaFlaTenIgbSQJ8spH8Dm
	xlHtK1zldganOlGHQbaA==
X-Google-Smtp-Source: AGHT+IEQcHwA7T6ktmCXafon70hVlddeX9BaPXERtnLHGkMmTox+ufRP6CsVlNJn8W2ToaNF/lgtHw==
X-Received: by 2002:a53:acc9:0:10b0:63f:beb2:9519 with SMTP id 956f58d0204a3-64302a2fb59mr21422815d50.5.1764526580498;
        Sun, 30 Nov 2025 10:16:20 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:b42b:4ad9:10af:cabc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d603f5sm39289087b3.19.2025.11.30.10.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 10:16:20 -0800 (PST)
Date: Sun, 30 Nov 2025 13:16:19 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tracing: move tracing declarations from kernel.h to
 a dedicated header
Message-ID: <aSyJ83v7EEAPHXeU@yury>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-4-yury.norov@gmail.com>
 <aStX3242e3mo5H05@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aStX3242e3mo5H05@smile.fi.intel.com>

On Sat, Nov 29, 2025 at 10:30:23PM +0200, Andy Shevchenko wrote:
> On Sat, Nov 29, 2025 at 02:53:02PM -0500, Yury Norov (NVIDIA) wrote:
> > Tracing is a half of the kernel.h in terms of LOCs, although it's a
> > self-consistent part. Move it to a separate header.
> > 
> > This is a pure move, except for removing a few 'extern's.
> 
> Yeah, I also have something similar (but half-baked) locally, the Q I wanted to
> ask is why a separate header? We have already some of tracing headers. Doesn't
> suit well?

Just as said in the commit message - this part is more or less
self-consistent and debugging-oriented. If someone needs to just
throw trace_printk() in their driver, they will not have to pull
all the heavy tracing machinery.

> ...
> 
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -27,6 +27,7 @@
> >  #include <linux/math.h>
> >  #include <linux/minmax.h>
> >  #include <linux/typecheck.h>
> 
> > +#include <linux/tracing.h>
> 
> There is better place for t*.h, i.e. after static_call_types.h.

They are poorly sorted for seemingly no good reason. I found the first
t*.h and just put this header next to it. Don't think that placing it
next to static_call_types.h is any better or worse.
 
> Btw, have you tried to sort alphabetically the bulk in the kernel.h after
> your series. Does it still build? (Just wondering about state of affairs
> with the possible cyclic dependencies.)

I didn't try. Sorting #include's is not the purpose of the series.

Thanks,
Yury
