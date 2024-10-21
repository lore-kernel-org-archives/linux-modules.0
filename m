Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5F14A90
	for <linux-modules@vger.kernel.org>; Mon, 21 Oct 2024 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729527388; cv=none; b=sYhoX5dtMLawLR0I7yzdHs0P37YA1MSjt7qqFIcUz5CJI1Qhjp8ZXlAGXgkxoHOLkimnvVerYapN0uUmaYfyDojNpdR08d2hDlTlshcEqbO6fDZhlD0NzglbEmqsBPi5WhsPjD7X/et2ohJEra+IDcJajYv4o24lm36KEheTHYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729527388; c=relaxed/simple;
	bh=ayXmbob9V4y/ySOfVlxsuHYrsBNUOW7x+7DtgnXABUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjPlcpun1tKcF0dcoRYF/OM4c5MeW/gjRGG5HlYiZYGZeinlwc1SVWXlihxR0FgNQUZtrPyLKHQNcPRhyRHN5fYQgtzELMqirI62G43KB1e+Fip6yNKlbMnAK0bi4F+3uADivViONwoEQ816vjyWqpaP4FvyUp9PUZNq1M3qMDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1F113LQ6; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1F113LQ6"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460969c49f2so418691cf.0
        for <linux-modules@vger.kernel.org>; Mon, 21 Oct 2024 09:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729527386; x=1730132186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayXmbob9V4y/ySOfVlxsuHYrsBNUOW7x+7DtgnXABUo=;
        b=1F113LQ6bVnXZcWbjtAt1AFygqb8hbtBR2T5XmlgAA6r9rPPlVLOvx9Uu2DjZ+dpRg
         jwTNCvwY84sQTKAEMfIT3coMIXxV3xlt/V9KrxWWpK6OM7y8Mg4Q9Kv9DPlgZB1bjgiJ
         /CL3R3u/GPCZVA19KLrYnItjnLKED4aHD+iZ32BG4wq8HF/louy0TPobpbEAOPzRMNEE
         xdv2Z/b23m+TBngdapX//EGRvuO3YuOX5XPyVQZsqaQWVkE9nnY+y1rgZSUBrHi4eejC
         6gAw2MjbF2ONP5GpTY3Xz5snqWKaJICV7x0hriuRfabaD37lDEztvbz2Tfp3NML8TE3E
         FJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729527386; x=1730132186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayXmbob9V4y/ySOfVlxsuHYrsBNUOW7x+7DtgnXABUo=;
        b=npOuq5V6KMVEgCokNKIhlY4ohUGro4BtqrUfgOuq2ys1RezIrSLhGly7pd4Ij73vHt
         JiGt8QTY7VZjb0ZmaV7Zd+824WISUkXOFlNvEDcgEKngYXebHbbEm4RUC27rEpYdIizq
         hjILnUGQE99MmGrHNNGdbqSd5Lm3ZLEnOB/q3g9YFusY0vbuqvhX7gaUsAq5I63atZDD
         nT83xfxpY8yqXH63XQR+Y4qV+CUVgZxlLjAL47tykd85Ln+397cHjmfpgH0SnTFvEj1x
         zu/2X8XL6mGrQr1po2bF/JPHaH/Q6FQhJdwS3Jg5Fxu7/eKNEeqb4eqwTmoug4J1QI8q
         4xmA==
X-Forwarded-Encrypted: i=1; AJvYcCUjgvHtd9qH6QH824Q+SMYOi+I4NEYeKDluqw+z288iMufQO6PNyGv9ARShsGE/a1Nvv1LoIGYZDyavCSRO@vger.kernel.org
X-Gm-Message-State: AOJu0YzlhUw+br4sSGnNcp4LJQK4RPKcGN0a08YbnaT6VY0PTAAS2ofo
	R0D42+PL1UIzcrR6AaqIvOlytApP/VRD80FyGnBHB6+CLlUQaBO0ZhMaksNE4vZGPJCEhv8RRRc
	YfYCAyj/WQSkuJeZmbei9BdLARKXbbx2uD82D
X-Google-Smtp-Source: AGHT+IHu5uuCEIILVBFJcgGkovHuVbQvTad5oHeICGXHHCDN4MgHytihaDQwCWVdBHrIMPwEdvBuRY5y34KQCj9Y2Os=
X-Received: by 2002:ac8:5a16:0:b0:460:8406:2c2c with SMTP id
 d75a77b69052e-460be5cb3c7mr3983251cf.25.1729527385509; Mon, 21 Oct 2024
 09:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxJcryjDUk_LzOuj@tiehlicka> <CAJuCfpGV3hwCRJj6D-SnSOc+VEe5=_045R1aGJEuYCL7WESsrg@mail.gmail.com>
 <ZxKWBfQ_Lps93fY1@tiehlicka> <CAJuCfpHa9qjugR+a3cs6Cud4PUcPWdvc+OgKTJ1qnryyJ9+WXA@mail.gmail.com>
 <CAJuCfpHFmmZhSrWo0iWST9+DGbwJZYdZx7zjHSHJLs_QY-7UbA@mail.gmail.com>
 <ZxYCK0jZVmKSksA4@tiehlicka> <62a7eb3f-fb27-43f4-8365-0fa0456c2f01@redhat.com>
 <CAJuCfpE_aSyjokF=xuwXvq9-jpjDfC+OH0etspK=G6PS7SvMFg@mail.gmail.com>
 <ZxZ0eh95AfFcQSFV@tiehlicka> <CAJuCfpGHKHJ_6xN4Ur4pjLgwTQ2QLkbWuAOhQQPinXNQVONxEA@mail.gmail.com>
 <ZxZ52Kcd8pskQ-Jd@tiehlicka>
In-Reply-To: <ZxZ52Kcd8pskQ-Jd@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 21 Oct 2024 09:16:14 -0700
Message-ID: <CAJuCfpFr2CAKvfyTCY2tkVHWG1kb4N2jhNe5=2nFWH0HhoU+yg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
To: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>, 
	Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org, 
	kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, mcgrof@kernel.org, 
	rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, tglx@linutronix.de, 
	bp@alien8.de, xiongwei.song@windriver.com, ardb@kernel.org, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org, 
	iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 8:57=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 21-10-24 08:41:00, Suren Baghdasaryan wrote:
> > On Mon, Oct 21, 2024 at 8:34=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Mon 21-10-24 08:05:16, Suren Baghdasaryan wrote:
> > > [...]
> > > > Yeah, I thought about adding new values to "mem_profiling" but it's=
 a
> > > > bit complicated. Today it's a tristate:
> > > >
> > > > mem_profiling=3D0|1|never
> > > >
> > > > 0/1 means we disable/enable memory profiling by default but the use=
r
> > > > can enable it at runtime using a sysctl. This means that we enable
> > > > page_ext at boot even when it's set to 0.
> > > > "never" means we do not enable page_ext, memory profiling is disabl=
ed
> > > > and sysctl to enable it will not be exposed. Used when a distributi=
on
> > > > has CONFIG_MEM_ALLOC_PROFILING=3Dy but the user does not use it and=
 does
> > > > not want to waste memory on enabling page_ext.
> > > >
> > > > I can add another option like "pgflags" but then it also needs to
> > > > specify whether we should enable or disable profiling by default
> > > > (similar to 0|1 for page_ext mode). IOW we will need to encode also
> > > > the default state we want. Something like this:
> > > >
> > > > mem_profiling=3D0|1|never|pgflags_on|pgflags_off
> > > >
> > > > Would this be acceptable?
> > >
> > > Isn't this overcomplicating it? Why cannot you simply go with
> > > mem_profiling=3D{0|never|1}[,$YOUR_OPTIONS]
> > >
> > > While $YOUR_OPTIONS could be compress,fallback,ponies and it would ap=
ply
> > > or just be ignored if that is not applicable.
> >
> > Oh, you mean having 2 parts in the parameter with supported options bei=
ng:
> >
> > mem_profiling=3Dnever
> > mem_profiling=3D0
> > mem_profiling=3D1
> > mem_profiling=3D0,pgflags
> > mem_profiling=3D1,pgflags
> >
> > Did I understand correctly? If so then yes, this should work.
>
> yes. I would just not call it pgflags because that just doesn't really
> tell what the option is to anybody but kernel developers. You could also
> have an option to override the default (disable profiling) failure strate=
gy.

Ok, how about "compressed" instead? Like this:

mem_profiling=3D0,compressed

> --
> Michal Hocko
> SUSE Labs
