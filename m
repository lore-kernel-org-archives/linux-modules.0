Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0FF26A09B
	for <linux-modules@vger.kernel.org>; Thu, 18 Dec 2025 05:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037223; cv=none; b=DuVSXXBFXv78meSFeRpaJRQDl+Dqan+NFx4WdSUUmF9xS1EXdXJxCDjJ1T0bc0KwN6TeJZ8HQwJLSMc02MKzBkuPYTgLfiu7EFTNNioRuA7leezl8ctH5+V/Sx5zBahEpLQmdTJWvr5cjqNqDQAsmZ2mBH6+t36adTi498U+M20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037223; c=relaxed/simple;
	bh=1WKmwxIykHwtmPt6271x4VTejLBDKzjIsnD15tHvQrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxCFFigtAHt7J29c50Cf382fImP3JdSXbDk7frlGz+Q7UNIwShN/A1y3WZ/9bldMx0UrlUE+gXHE/MRrBK1Yb3hjh4jJrQVsFh3MeQZhvmfk60FxPQtXZTcByLydyQvfBCHoB9DFuTt4juZqUML5iwyyf/45bSw6fWugQ891ems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzLKG4g1; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzLKG4g1"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c9edf63a7so294536a91.1
        for <linux-modules@vger.kernel.org>; Wed, 17 Dec 2025 21:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766037221; x=1766642021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yaGJpOKqg8zQltJlD/AWg9VGkTrfZMf+YGQyTVj+MTg=;
        b=LzLKG4g1arCpN48IvvOzeJGcougBWsvNxHXnakURo7L989fGf+bqwG7tUQhhOLlQoC
         BY70EIyKXNxwTiR0qM9S1faRX4L/n2kIy6+WQdiHQAPkeBrabSeXHj9bfIY3pS7v7trm
         Y8wLWM6GM6Ww4C/GGXmGoWunFKhlBHK07v2z2iznnGvu/QHFTtQIwmdFoURlWkDaJt3z
         KjbIptUtMBFe3ckGBvd9/QyVq4b9pHiYMCWS6rBqKQR7eyabomfkVdjeNliCh7i7rjZb
         z7BNWCjljsBUgvhYkiF6kWKK3rkiPV8DqdBbxcDYfH/u3xJmLQV1/w7OnuXyxnRUVPH8
         s0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766037221; x=1766642021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaGJpOKqg8zQltJlD/AWg9VGkTrfZMf+YGQyTVj+MTg=;
        b=bnWck5YIX0zxcU0ykzZklFsq5PYjS2xSMuSPp+NxZHuPr7mfzFTtSorHycNYg1loup
         jKLus7ZQm4nm9HZA9QzHgFkmPyEGrc+fEJL8oNFpg+vCTViJ4TZ7F2rrIeLXEc3ugka1
         Z7uBljbtoNF/lbdlKHGHr1bn2UOpoj5+2LaSM/6EJLAaOPLg6RMomw3lIg4gH0uyrMpN
         rX0GMJWd6k994mm6nciKREWIoZh2qJLM2wGRDaahHRFNY9dNMuo24oRGWvdX7ZYX184s
         EloXW3S4S47LKAbEUNGDBu+da1CmOX5uDNy17TazTV+BBp4hPfo3TSSKGI39tPntd/ZD
         3xbg==
X-Forwarded-Encrypted: i=1; AJvYcCWEE2rJL572HLGSy0f963hUf2hzcLQM9m6W/ZvYi1+IKziK+aghx7roPgv/YVKIGJ/7dFl+Q2znBNhACvou@vger.kernel.org
X-Gm-Message-State: AOJu0YwIS68zBsGE5w3+nv4D5iEy8YIirMhRfIW+6h3raEFto51L1lS5
	wRcIHC91f8y4nNLrPEpe6Z+HJcC7/WI+12KfpV50EIrVy6ZcytdlTmCK3WFsgQ==
X-Gm-Gg: AY/fxX4pz+j7Vvn5cuU2n3GoXxaxIX9N88fbR08JQKir4aSqt8FP2TKh3HM30oIYxBU
	TUgz/tNiYFAILCpIwzi4FiHQP1p2M/+h5gaysgs+tceC/ihK6CPwDhLM38pQT8iZaTbgnjfMQTz
	nLsdDNSFAchcOHiEqTmFXVS7MiJ9DE/kYMKbsj2H2YKkFHLHTyeHysoF2Yh3j5mx3u4OD9o8zt2
	P8RMC5a0Y+rmuH2T56W/JjNte+Ow5IEPnXjA3Aynoe17TzQTycpDFt+TlURsCfW/ZydecrC3Ce2
	bvidAagvT+aZR5Loc4f6GXfwCJBjq+PlCPPT38WrN5h6StdeXVmjO54Ic5kEi7MInLg3buspJIN
	ECxyj1uzPSBT/Q9+8S3vYp5d2AXH0DyGjU0qEOaAH2ODzpkMbAsT58v1Oy72emjQnMgJJxc59uI
	QZ174BuqU=
X-Google-Smtp-Source: AGHT+IHIeJZ6pUO0IWI3BZr8YKRR4WYcObEmm4ye3CL4DoHkOxJXpQslAZeBIjOMe9+OleYRLYL1Lg==
X-Received: by 2002:a53:a090:0:b0:63f:bd67:7c52 with SMTP id 956f58d0204a3-645555e7c66mr12186194d50.29.1766030374328;
        Wed, 17 Dec 2025 19:59:34 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:52c0:aec0:bf15:a891])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-646636e8a2csm581612d50.4.2025.12.17.19.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 19:59:33 -0800 (PST)
Date: Wed, 17 Dec 2025 22:59:33 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
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
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 4/4] tracing: move tracing declarations from kernel.h
 to a dedicated header
Message-ID: <aUN8Hm377C5A0ILX@yury>
References: <20251205175237.242022-1-yury.norov@gmail.com>
 <20251205175237.242022-5-yury.norov@gmail.com>
 <20251216161316.45b3f19ff0ad482018137189@linux-foundation.org>
 <55ceb7bf-0fe9-4edc-81c2-d51366847eec@infradead.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55ceb7bf-0fe9-4edc-81c2-d51366847eec@infradead.org>

On Tue, Dec 16, 2025 at 09:24:55PM -0800, Randy Dunlap wrote:
> [adding Kees]
> 
> On 12/16/25 4:13 PM, Andrew Morton wrote:
> > On Fri,  5 Dec 2025 12:52:35 -0500 "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
> > 
> >> Tracing is a half of the kernel.h in terms of LOCs, although it's
> >> a self-consistent part. It is intended for quick debugging purposes
> >> and isn't used by the normal tracing utilities.
> >>
> >> Move it to a separate header. If someone needs to just throw a
> >> trace_printk() in their driver, they will not have to pull all
> >> the heavy tracing machinery.
> >>
> >> This is a pure move, except for removing a few 'extern's.
> >>
> 
> Hm, for a pure move, this shouldn't be necessary. Anyway, not using
> FORTIFY in purgatory.o fixes this build error.
> Or maybe there's a better answer.
> 
> ---
>  arch/x86/purgatory/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -62,7 +62,7 @@ PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_C
>  endif
>  
>  CFLAGS_REMOVE_purgatory.o	+= $(PURGATORY_CFLAGS_REMOVE)
> -CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
> +CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS) -D__NO_FORTIFY
>  
>  CFLAGS_REMOVE_sha256.o		+= $(PURGATORY_CFLAGS_REMOVE)
>  CFLAGS_sha256.o			+= $(PURGATORY_CFLAGS)

That happened because the new trace_printk.h includes string.h for
strlen(), so all kernel.h users now indirectly include it, and it
causes, seemingly, a circular dependency if FORTIFY is enabled.

A fix would be dropping trace_printk.h from kernel.h, or switching the
only user of string.h, trace_puts(), to __builtin_strlen().

Notice, Andy has concerned about this on the previous round, and also
suggested __builtin_strlen():

        https://lkml.org/lkml/2025/12/3/910

I deem to drop trace_printk.h from kernel.h - it is more aligned with
the idea of unloading the header. The original motivation to keep
trace_printk.h in kernel.h was just because a similar printk.h is living
there. But after all, this is a purely debugging header, so no need for
almost every C file to bear debugging stuff.

I can actually do both - switch to an intrinsic and drop the header.

Guys, please let me know what do you thing.

Thanks,
Yury
