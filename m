Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225BC3C2F
	for <linux-modules@vger.kernel.org>; Thu, 18 Dec 2025 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090030; cv=none; b=SjYTeckxwcmZCgjYoQs9MUHcbQm2akyROORyFP3iJ5tGmrUHnJPafGonW15xRrD3IL8zMlPrh+ZZT2g1SlzvjPCrLgS9L8dsO1KC3lSkVARZHrBPngToY8hL1AcgppbV8UwRaoxNYRb8cMDaEe85d2GMTDusGSKPS1a3ddgSK7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090030; c=relaxed/simple;
	bh=vph2t1gYAnPyZayhXZlTjkgMOzAZS2aCrAcp3tV4K2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggdLcbZoSU5asMfwP6w2Fb2AgzqOGSZ0puzAly8pbJEhpRt1zJuay9qDeIo+W2+TB54HyWsOzvoFy+3OF7Jg/Q6//OIBG/Mu0jN2ihmBkw01H02V2LCYmDzzAKTu+VZBzBE5F3BYMrFL/gzLlmE1Q70KE7K5zbM3ZwMcYnvcUbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO5oH/i6; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO5oH/i6"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-640c9c85255so1058111d50.3
        for <linux-modules@vger.kernel.org>; Thu, 18 Dec 2025 12:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766090028; x=1766694828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxI1KcKPoVD1Uiga6uN/7Y0Mz7a7b0eOjCBdzKpvt0Q=;
        b=lO5oH/i65hB8VfE6V39f9pXryjyFOQFPyOfYr3rtHIUEKfh9Kiine9Lo/vHB0cVRjI
         ZrC2KtkPGec8Vb9uGtsWM5VB5tioPeLxbP3Ygp9pJJaZiqpuVDeQjJSRHX7PWegIt7lg
         tzDM8g7hX7rLeg+9lyXNrmdU4NqbMUaFrgVPaVPg2eJUOV7H8FbeiSutqeeJ9KtcXHE1
         h62LMeC79OCMoQtUMN41GxNWgvea1JXtyvdOGBs4MbbpVBqDRcv+3qnQvr1OjBMOBSN9
         ybD3kvhJRNcS/2wfnpXn5zrtL/bqMsvr2RDcev9pd85Q74ObGJXMYsvGdKbJEYlZC+Oz
         X7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766090028; x=1766694828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxI1KcKPoVD1Uiga6uN/7Y0Mz7a7b0eOjCBdzKpvt0Q=;
        b=mE5d//stwKyy7jhVcBkVCxm6FkpAGkZpkGyUqgsI/3+syChT0qziCPb9KuPKLJwp7t
         njLHJazZHQj04Ud6PWb80kOf/etAaGSZZJxTyZcoWRHcKV2P324eZ6GgRCKpaF50GXIv
         830gU2UZGpgxhRNhanTu5Q4nlaimHqFkLDZtyt1J6XnGSUuB+1WUQHRGQmupZZzojZ1g
         Pu7jbPDs7P9ekYLaQCm49Zj+B9fJbPdXHssVsbEJTunYU+4s4kuJ4R+VJh28KB+PUTi9
         7C+FaroRpRdLychM17m1aUJmrsRWSnuBVYyQs/TYci9LeJw5uBbrIDaOffe/mCiaWAcr
         kunw==
X-Forwarded-Encrypted: i=1; AJvYcCXsJ455hk7QigZJBK19iOLZPuX8YaBSi5eJyFQcLSOisd0IXssefkWxJ4ev63T0mYdwBeWLA0EnGzo1AoKT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs4cIoOm3yI6FkiXz8tH1hGQNyK/mrLKePbvxOe+hWryzH5j1c
	tAcZiHgqbSfp5Bicp7qSEsXEb2H8LU0jCfzRRXIuuT/PU8BaUY+6bJI2
X-Gm-Gg: AY/fxX5uUI6y2bxXuKBRlvGGZTbhV3L9u9GGZXjgZRRPAbphhcm6hFbbSby+EDfHnLH
	e26cqfHPfjKsEVtinD7pT9f/N9HsQjP2Coo+dkrgewK1JIDcNPHn/y3Bkn6U0n7r6scAlKSGT+Y
	WbI44qR2vHCYFRagiIK24VJPo65nBiT4P/+GjTjS3aGYVBW6GanCZ1+GzP84U2GzO8iEBk4bPOY
	2BOWw1PTaeI4WQWsYSX4GNj1AKGJtfe0cXZDTRqnVdjCv6tX4z6zjXCq7vzQNtStYZhunaYi6yH
	ThqdE/oXi4p5puPaXYewf88xV5ajpqAIGCzAQ7tgMdk8+RCdBxgZPbGZw2BHg83XGZ1JxgEcSLw
	ddA/9dW8enIrffJXtA8XC3vy3uCbPUT/501ev62vV7u2ENj8igGaZsWi83zAXuL43hY3DktFO6s
	I+kAHFsA==
X-Google-Smtp-Source: AGHT+IFAJX9V2Yp2+qH1WSekUJE1tGwEk4Z57sP9mJ9kbl5NsNmWsxGEZgOmgfyGAsihFkzwCzGJlg==
X-Received: by 2002:a05:690e:1a48:b0:641:f5fa:e9be with SMTP id 956f58d0204a3-6466a844cbcmr429969d50.34.1766090028008;
        Thu, 18 Dec 2025 12:33:48 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:c44b:debe:992d:e6a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a8bcc06sm220174d50.7.2025.12.18.12.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 12:33:47 -0800 (PST)
Date: Thu, 18 Dec 2025 15:33:47 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <aURlK1gpCrfLEKN9@yury>
References: <20251205175237.242022-1-yury.norov@gmail.com>
 <20251205175237.242022-5-yury.norov@gmail.com>
 <20251216161316.45b3f19ff0ad482018137189@linux-foundation.org>
 <55ceb7bf-0fe9-4edc-81c2-d51366847eec@infradead.org>
 <aUN8Hm377C5A0ILX@yury>
 <20251218123349.35339242@gandalf.local.home>
 <20251218124326.22334325@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218124326.22334325@gandalf.local.home>

On Thu, Dec 18, 2025 at 12:43:26PM -0500, Steven Rostedt wrote:
> On Thu, 18 Dec 2025 12:33:49 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 17 Dec 2025 22:59:33 -0500
> > Yury Norov <yury.norov@gmail.com> wrote:
> > 
> > > I deem to drop trace_printk.h from kernel.h - it is more aligned with
> > > the idea of unloading the header. The original motivation to keep
> > > trace_printk.h in kernel.h was just because a similar printk.h is living
> > > there. But after all, this is a purely debugging header, so no need for
> > > almost every C file to bear debugging stuff.  
> > 
> > It is a big deal for debugging stuff. A lot of developers debug their code
> > with trace_printk(), and do the "shotgun approach", where they cut and
> > paste trace_printk()s all over their code in several files. Having to now add:
> > 
> >   #include <linux/trace_printk.h>
> > 
> > whenever a trace_printk() is added is going to be a big PITA and slow down
> > all debugging efforts.
> >
> 
> I don't actually remember why I had __trace_puts() pass in the size. I
> could change it to:

This is the best approach. I'll schedule it for v4. Would you like me to
take it as-is, or you'd send a patch?
 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 5b46924fdff5..d5a939b8c391 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -331,10 +331,10 @@ int __trace_printk(unsigned long ip, const char *fmt, ...);
>  	if (__builtin_constant_p(str))					\
>  		__trace_bputs(_THIS_IP_, trace_printk_fmt);		\
>  	else								\
> -		__trace_puts(_THIS_IP_, str, strlen(str));		\
> +		__trace_puts(_THIS_IP_, str);				\
>  })
>  extern int __trace_bputs(unsigned long ip, const char *str);
> -extern int __trace_puts(unsigned long ip, const char *str, int size);
> +extern int __trace_puts(unsigned long ip, const char *str);
>  
>  extern void trace_dump_stack(int skip);
>  
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e575956ef9b5..686741edb803 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1178,11 +1178,10 @@ EXPORT_SYMBOL_GPL(__trace_array_puts);
>   * __trace_puts - write a constant string into the trace buffer.
>   * @ip:	   The address of the caller
>   * @str:   The constant string to write
> - * @size:  The size of the string.
>   */
> -int __trace_puts(unsigned long ip, const char *str, int size)
> +int __trace_puts(unsigned long ip, const char *str)
>  {
> -	return __trace_array_puts(printk_trace, ip, str, size);
> +	return __trace_array_puts(printk_trace, ip, str, strlen(str));
>  }
>  EXPORT_SYMBOL_GPL(__trace_puts);
>  
> @@ -1201,7 +1200,7 @@ int __trace_bputs(unsigned long ip, const char *str)
>  	int size = sizeof(struct bputs_entry);
>  
>  	if (!printk_binsafe(tr))
> -		return __trace_puts(ip, str, strlen(str));
> +		return __trace_puts(ip, str);
>  
>  	if (!(tr->trace_flags & TRACE_ITER(PRINTK)))
>  		return 0;
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index b6d42fe06115..de4e6713b84e 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -2116,7 +2116,7 @@ extern void tracing_log_err(struct trace_array *tr,
>   * about performance). The internal_trace_puts() is for such
>   * a purpose.
>   */
> -#define internal_trace_puts(str) __trace_puts(_THIS_IP_, str, strlen(str))
> +#define internal_trace_puts(str) __trace_puts(_THIS_IP_, str)
>  
>  #undef FTRACE_ENTRY
>  #define FTRACE_ENTRY(call, struct_name, id, tstruct, print)	\
> 
> 
> 
> Which removes the strlen() altogether.
> 
> -- Steve
