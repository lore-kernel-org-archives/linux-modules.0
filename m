Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90DA21C9F4
	for <linux-modules@vger.kernel.org>; Thu,  6 Nov 2025 02:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762397619; cv=none; b=b1mk8JeVr/YzClPXzBEpTdbaVrupI9Vxj0ru6kC0U4SPBEddyaShlql8n8U5j8J+3xqZHvrCgm1gVeDfV8qLXoplhqigaVRgoz++CBJeBM0p5iOsSlpg6lYJtReUDd+uSrq/YIIBJo5IpA6i0MvCGebvKMelRICKK14IWLEKb3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762397619; c=relaxed/simple;
	bh=qmfm4nTYXj4d67e/ZFdu+FoHVdOEgEHWQ62Qb0rfoMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChF4Xhu4N/JYQNgg67whErJs7em670aSBbHpeji0LVvMDNinVq42laZ/G7D01o8VzdJaOD2pUXhE+iQSoQt7jehhWtRH/P9RUz57YHf9MxVt8UM2K5+bWzYCZ0RMzDYCj2Pxk3e+bkpwyh7/W27ee57bCVt8HJM/3elaEzZz88g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llymclVl; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llymclVl"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so343981f8f.3
        for <linux-modules@vger.kernel.org>; Wed, 05 Nov 2025 18:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762397615; x=1763002415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcQMsNO0O8rvC7OlsNCiFi+ASZdXsyJZBbfNsI/gMNY=;
        b=llymclVl7fm/bsXzFmbKyOsGMBeHkOZJpK10Os23fNjfC7kLtvFM9tWARrgkeKb3GG
         4yu581xERMKR8xG61CvdBkK4jam/0CVFFrNXi/lkk0HSG+ttOugnDFEPTm/quU2T2RS5
         CAqpIAjTYFNSXeEmQi4i4Nh5y436lKmNPelwCvW5iPh8q7h4eQWPFJKl0Xozzyx6K6ts
         9f8CNiot6umhp2+q8g9HASs0wlH0AFdZKYQUbSuJnt63t2e15ruhFwvOPRtlWrO3HnJL
         ExL3xT3ovg/jH+poCfgbaLAewhpktYOMPwv1fKBcetcXDPQQeXlgI1dwUrQrJmd6KWrv
         qdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762397615; x=1763002415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcQMsNO0O8rvC7OlsNCiFi+ASZdXsyJZBbfNsI/gMNY=;
        b=Uc25daSa61jOi2oo2q6BTW/9teVIDv2k8Aj3OOmiXVQI0o/7N1TpsoBVZHbVpsuk50
         DUCqaj5s4CNytMGhdJcFsULdwYRmSEEb09RccRbu38h0rUelfxgM467nvPboXmxpqALQ
         d4nBg1KPo5Jd8yDGIZjoNNmUfn0AqAcdPsczQySXt+egqEzuPnaNslfZEKooVbkfQtym
         GHM7zVdWfkqmweoIkE9Z6z/lXmYbixEmXRfqlU9AjMEqIQUNfhDqjU7zwwntwJoi+Xwe
         Fn6QN6QhigoVFKNWpTAxWk1BFWgc4VMDkCF1mXJ1VbDNgZaxNo4szGp0ZyYM4EHRh0jp
         szvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzdVkVm/hkHnsZRQtjhLcj3moEBDX0CgJ0NPMSsdzdSuKqHYyqdBMvzqw6MAdYg5nIdKPCSw6lwPH8m7yI@vger.kernel.org
X-Gm-Message-State: AOJu0YwqtWQJWXbtZFQHv6gpoJaschokBwQKwI2LAJGX/okHHGdIDcgn
	3YLgv7WKUnSyxO0nrHUfeS95mfGFYLNV8Y2QU6YZ3THe1XwL68ZSPvQgdsGpOmZazA0sxox+QaY
	mZ657Ykwv73yJYffWAXTgR6VYaB+gmVI=
X-Gm-Gg: ASbGncvLxymitneLIsOGMU4fV/jZNNI/0K9ttSf7RXFeQzRyS/tjamojm/kYk2iESx7
	0/7VBci3P+SL/z9j6xtEjcJB2sbFLrRJZWOBpFeDkxcYkfMxPQxRrbZeZOaWS4A6I+/yqX1PDDQ
	JM5pv4DaqRD1xpgSjaH/aFv3RqYhL1ZPct331+GN29cwHmRYTxk1wWPeEPB4CpL8BMqVdLYrPrk
	OfWJ+Lih5CWeFSUiRgA6SK+/Z67NneJkkIE6s/hzv3S3TM8zPw/+qb1h0PmgC00s7x1O10a6Biu
	CBDq7P9WaAJyfzqAI+gzsV/j1XMo
X-Google-Smtp-Source: AGHT+IFgHo9WZJKTS4D4CZPHMvUuqKgcTvl9SJ9/dfT8HptvgBagea4p9NuA+sU2B75qOpkO7ninSQ0FH88nOttOqyg=
X-Received: by 2002:a05:6000:2287:b0:429:d6dc:ae3e with SMTP id
 ffacd0b85a97d-429e3313344mr4775045f8f.49.1762397614770; Wed, 05 Nov 2025
 18:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105142319.1139183-1-pmladek@suse.com> <20251105142319.1139183-4-pmladek@suse.com>
In-Reply-To: <20251105142319.1139183-4-pmladek@suse.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 18:53:23 -0800
X-Gm-Features: AWmQ_bmqzU40z-SC7k7ETvJcX5sVEBdPvjsWiXW7M4e2QXc-RoIMyuEO7uyuVL0
Message-ID: <CAADnVQ+kbQ4uwtKjD1DRCf702v0rEthy6hU4COAU9CyU53wTHg@mail.gmail.com>
Subject: Re: [PATCH 3/6] kallsyms/bpf: Set module buildid in bpf_address_lookup()
To: Petr Mladek <pmladek@suse.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, linux-modules@vger.kernel.org, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 6:24=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> Make bpf_address_lookup() compatible with module_address_lookup()
> and clear the pointer to @modbuildid together with @modname.
>
> It is not strictly needed because __sprint_symbol() reads @modbuildid
> only when @modname is set. But better be on the safe side and make
> the API more safe.
>
> Fixes: 9294523e3768 ("module: add printk formats to add module build ID t=
o stacktraces")
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  include/linux/filter.h | 15 +++++++++++----
>  kernel/kallsyms.c      |  4 ++--
>  2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f5c859b8131a..b7b95840250a 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1362,12 +1362,18 @@ struct bpf_prog *bpf_prog_ksym_find(unsigned long=
 addr);
>
>  static inline int
>  bpf_address_lookup(unsigned long addr, unsigned long *size,
> -                  unsigned long *off, char **modname, char *sym)
> +                  unsigned long *off, char **modname,
> +                  const unsigned char **modbuildid, char *sym)
>  {
>         int ret =3D __bpf_address_lookup(addr, size, off, sym);
>
> -       if (ret && modname)
> -               *modname =3D NULL;
> +       if (ret) {
> +               if (modname)
> +                       *modname =3D NULL;
> +               if (modbuildid)
> +                       *modbuildid =3D NULL;
> +       }
> +
>         return ret;
>  }
>
> @@ -1433,7 +1439,8 @@ static inline struct bpf_prog *bpf_prog_ksym_find(u=
nsigned long addr)
>
>  static inline int
>  bpf_address_lookup(unsigned long addr, unsigned long *size,
> -                  unsigned long *off, char **modname, char *sym)
> +                  unsigned long *off, char **modname,
> +                  const unsigned char **modbuildid, char *sym)
>  {
>         return 0;
>  }
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 9455e3bb07fc..efb12b077220 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -374,8 +374,8 @@ static int kallsyms_lookup_buildid(unsigned long addr=
,
>         ret =3D module_address_lookup(addr, symbolsize, offset,
>                                     modname, modbuildid, namebuf);
>         if (!ret)
> -               ret =3D bpf_address_lookup(addr, symbolsize,
> -                                        offset, modname, namebuf);
> +               ret =3D bpf_address_lookup(addr, symbolsize, offset,
> +                                        modname, modbuildid, namebuf);

The initial bpf_address_lookup() 8 years ago was trying
to copy paste args and style of kallsyms_lookup().
It was odd back then. This change is doubling down on the wrong thing.
It's really odd to pass a pointer into bpf_address_lookup()
so it zero initializes it.
bpf ksyms are in the core kernel. They're never in modules.
Just call __bpf_address_lookup() here and remove the wrapper.
