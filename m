Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EEF2D5C95
	for <linux-modules@vger.kernel.org>; Fri,  7 Nov 2025 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521304; cv=none; b=GU9ohAtysb4jIaZ9YZvz23bqZwlV38jkp6Z3y11zdIedt1GhUbHUpI4nJuJSH8TXgbE1ErNtigBTyyjyNdNaupUyDPibGsriYxGdg7LWcm7L04Mh8zyqJ04wjGxRYwjjum9/NOCuB8BeiMoIiNaB4yS+NIcjjK7NIOW3iI4sQLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521304; c=relaxed/simple;
	bh=0mPhFFV27EI4HWkCT/K0CutZwM23pABS/zg6xhegD68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A43zyPv1xm5MedLLCC3ST8rpe9qWI8yQ1Ix5aNsQ/IRA4gSq4KrxNQDW+nO3o62yz9pV1mlSrhkx1yODx6onEYKZPFVUYbgi2np9fuubicMc0E1qIDy42MHd3w616Lg0C0IOxV0Q8XBnLvAy2cimB97Ms94Xe9xQZaUvMY1HbZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BlHoPCu3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BlHoPCu3"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so1273109a12.0
        for <linux-modules@vger.kernel.org>; Fri, 07 Nov 2025 05:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762521300; x=1763126100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8HZ8kO1EbOdno/Z6LWKvw9cCt6xKTq52Mcwxm+AjrMQ=;
        b=BlHoPCu3NqtLtozYF0ZyHTBdobJJ/cANVGnsDwuY6T8dx2F6BpG8CLWuG2V1KWCPn9
         rJqzhFhR33ZMV++LnBz96/RuLoQJElQKD/XgdMcwXWV7h9QKhE6GKnV5S15pYGxSNGqu
         KqaXf2ahPz1ifbkNBO7u8j2yiZH6M0K6PrgMzHi6k6ovXdGBxghrOCwCc/pEwIl/Eo01
         Pk2HH4fQOf3Bw6VYHGk0nxbI0DXzJSh5ufcLRQ9l6RwgF98tgxr22FjT0cjpknUAGNCF
         BA2TawykZDjdpivWUQQk7vyA0EjOpZxziWhEOwjmij06OkYHzpG2iI9J48haI79hsRab
         cxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762521300; x=1763126100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HZ8kO1EbOdno/Z6LWKvw9cCt6xKTq52Mcwxm+AjrMQ=;
        b=Puq+WyK0lGMHwQDolX2bYWE/5efwTfyGAJWvZxDbRa4ASb5NEvlNKiMa5+3vVAZRJa
         YWhTMxP6CWuv8fl3Qy8Lv+euWj5j2KC9rO/8acrVBYtnkvNbdfeRuJRN+OK27j1QLOU1
         IH7uJOZjNSXTY25tqmGC6gx6n7IN+MIpUfw1B+DaiuH7VhaEQ0RRSry1Pqr2A7cvAfY4
         /5DTM87jrocKKyB/kFcNvMJ+lzBpMDVD2JOtD9D3HFz1V4z5eth+Hy8/Dv/KusIz55SD
         HhGB9kY2Lpi0rqvIfWHbHMW35gWCkB0ebEvYEa1s/Mubs5QOtnIND4Cg2Xlmf7cNs4R9
         cEgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC89VoDgp4fLgo4NiCNGiYtFGvdQ34zRL5CsGj4McmxteBFwn7DXvQefdQJCaCV4rJ+SM9PgFZIJR68LuW@vger.kernel.org
X-Gm-Message-State: AOJu0YzaYeqET5Gd9lb2GUe/N9088ClvMKITXB4OwD5b44O1Rtivzg2F
	Pxl4++RJkq43YQVCC89kdwjz2CR2EShk7f73s9c99EEvwb2aJHTqkaT9X00N6iGsp1A=
X-Gm-Gg: ASbGncut3/m8S5AtEELj0Mmu6T4WuYe3LlVbudSuJ862yn5haBLNFq1zv4xeNShXbfT
	b+lFJIlZdrIUI9BEJgnG2TAEXM5axcIaJR/SC62IrJwcUSfn85YtZNq+OjxqAYlas9wEkyZ7Uwh
	dqHWvXs5ejaEG8A22LPC/Kmp94dPCPLUvFxQWcIc6wQpMH620frxul5RBH7td6VcDybDgCf8xOz
	vdS+Am1bLlJ451pOSL4NIzYy5Lkvx9lNHVIp6oWdrQglp4D4Rkd9jHOnOCDXC4Ao+6iZuy9IzNF
	9xegyo8ZUUFxNaOat1LsnTkgnsvLSv6y9L6MRfGtLrZRWBY0lg1o1y1nSje3r9nv12mTYrojHo+
	ii1+ydhVWwNlpj3I1QE5JnAjMexH72C07eOPM2dXWq85u7P4rFoRXtJI3wTBjsEJLTkiYJxNyVR
	RWRwI=
X-Google-Smtp-Source: AGHT+IFE2eYy0+Px5WausE/jRL0XZhUzH9bbFk8nsiudCpX/vMQhbSO5rZNKcgvz0+P/IDwF6D5asw==
X-Received: by 2002:a17:907:2da2:b0:b6d:5914:30c with SMTP id a640c23a62f3a-b72c090e4b7mr299535266b.34.1762521300369;
        Fri, 07 Nov 2025 05:15:00 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa24d1fsm233492666b.73.2025.11.07.05.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:14:59 -0800 (PST)
Date: Fri, 7 Nov 2025 14:14:57 +0100
From: Petr Mladek <pmladek@suse.com>
To: bot+bpf-ci@kernel.org
Cc: petr.pavlu@suse.com, rostedt@goodmis.org, ast@kernel.org,
	akpm@linux-foundation.org, kees@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, mhiramat@kernel.org, mark.rutland@arm.com,
	mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	andrii@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 2/6] kallsyms: Cleanup code for appending the module
 buildid
Message-ID: <aQ3w0awU61mrS_AF@pathway.suse.cz>
References: <20251105142319.1139183-3-pmladek@suse.com>
 <451acb410ee1ce42f7fb2da9f3b8162708f40788cb849cc0f50851ad16813349@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451acb410ee1ce42f7fb2da9f3b8162708f40788cb849cc0f50851ad16813349@mail.kernel.org>

On Wed 2025-11-05 14:59:53, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 1e7635864..9455e3bb0 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -423,6 +423,37 @@ int lookup_symbol_name(unsigned long addr, char *symname)
> >  	return lookup_module_symbol_name(addr, symname);
> >  }
> >
> > +#ifdef CONFIG_STACKTRACE_BUILD_ID
> > +
> > +static int append_buildid(char *buffer,  const char *modname,
> > +			  const unsigned char *buildid)
> > +{
> > +	if (!modname)
> > +		return 0;
> > +
> > +	if (!buildid) {
> > +		pr_warn_once("Undefined buildid for the module %s\n", modname);
> > +		return 0;
> > +	}
> 
> When ftrace_mod_address_lookup() succeeds in kallsyms_lookup_buildid(),
> it sets *modname but doesn't initialize *modbuildid. This leaves the
> buildid variable uninitialized when __sprint_symbol() calls
> append_buildid().

Just for record. This is a great analyze. This patchset is fixing
this bug in a later patch. ;-)

> Can the check above read uninitialized memory?> 
> Looking at kallsyms_lookup_buildid():
> - module_address_lookup() properly initializes both modname and
>   modbuildid
> - bpf_address_lookup() sets modname=NULL (so append_buildid isn't
>   called)
> - ftrace_mod_address_lookup() sets modname=mod_map->mod->name but has
>   no modbuildid parameter
> 
> The commit message mentions wanting to catch when lookup functions don't
> handle buildid, but shouldn't kallsyms_lookup_buildid() initialize
> *modbuildid=NULL before calling the lookup functions to avoid undefined
> behavior?

It seems that we are going this way, see
https://lore.kernel.org/all/aQ3vWIqG31BgE4YD@pathway.suse.cz/

Best Regards,
Petr
