Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A971D63D1
	for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 22:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729033179; cv=none; b=ssdCEivENIlr0eXcR+mzULFf65vuZrBR+9vP1U/XGRBGhUfhXfxELDwCII69Th5mC2L4iLSEiioE5tFphFZ7MuIXT9ket8jG6/wzDjdf9HMBJAzoprhfzYoLb/6eEZqAl9ZXbV4/HYrbp4lPr/ywY0BCeVC7IcjvYkjhOeWMS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729033179; c=relaxed/simple;
	bh=glZWFHnHemFUqJOD7Sb/Nrj7aOzGfWHp45F6CqIEbr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/ud0sVvmasAzccUpU0UQoC1CtwtH2YhuV/YKlgFK6e6ov2oCdXNYAiA/utypzbsIzsf8Ztp7SopkqvKiwdEDEfnmd23q5bbIQlUYG+eZSie5xMUa62RBeYKj/7GX7qBTKw1Y38J644Mo4ioHyzkI0jgeiHZggpPx2AKdk73bss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J05FT0bO; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J05FT0bO"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4601a471aecso26391cf.1
        for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 15:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729033177; x=1729637977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aatrfRIq+KwjGDMApdNFzlbuQ/dlgztbUi1A7FhVako=;
        b=J05FT0bOE/56N47S34Yh9y9yYelnXGECE9sqe20xEqWvNSfTUpFm7GvPs9+YlP2ncc
         k8FcVB+w0kSuDwYXWEs9/9MjRQxG9VOB0w/6iAJgwLn8aEsbP1VhyxY2NFHplMFjixPj
         lLTP3D16J1QFfhZ9VAk9wz5cNjSkQyW06Eec8GlrbkBWNOQiHuStDRld8dYEDmztADLk
         aAdaez/3k4ff3VIHcDJYQz5XXW7iSEjj+GY3bXbfOIyjAuiR/fDRUgFfWewOEM8kTSuh
         NY3d0B+FzsFsm/OQ33NxLWipHrocPxdB+LbBVZ4IHAQ5zkpqSwuA244oEomF2cjLR+BL
         RHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729033177; x=1729637977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aatrfRIq+KwjGDMApdNFzlbuQ/dlgztbUi1A7FhVako=;
        b=Ch5WWRhWecL/fsmunGuvAztJ2QgL5gG5TPFl6xrNWlFyLQjtNQrkZVl0HEjcJ6rAdJ
         BC9FMIzgPR/Lo55VZ5Hfy0bLTBp+mx1yJ0rVG2sHuZFrBrAJd4TCGyKvlUp/aQ0MKiIa
         EuxN/XJHtCjVS6oNnO/631zmz84lORgT0shz0rIWyB4jX4k9fD0pTtXkYauTdKtU2VCW
         Nc8ZkUKUCkcJW3biTz+H0pVAvy0L3zCHkGMtnY9aawLiri1j5DhW0zAIq8AKjvgwziH9
         ddLg+Nx7AQE2vREXKLawdB8HWL7MIL6MBPeWX/ofyvAWL4Lz6/dD3ojGBJx/dyilMuxF
         CSrw==
X-Forwarded-Encrypted: i=1; AJvYcCXvXju9fEHUOLSTmp/GQ2/CIpnCLY3RkJ3HZkiYD6CoFnhvVogDh5iK0DBGiucPqGD/Cb4wRfRDAbwjhS4R@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs1ZDLC9N+CFwfbKDoT9nFG4MWa6GUMLiNGaRU+wFh9pHdDQh8
	eQLHGi2T3GAYqe5K0jvk3InyraA6XnjCdSPaCpDbumJVuD/r/Hz0ZJxMp8ypRp++vpJJY9F/gYI
	P9hgcIZF3QikayjxH5yEhb+xOQxR2yy9ES6Yt
X-Google-Smtp-Source: AGHT+IELTeVk+3ZUTk+NpnVTeDJUGBGjLAiZXyLrgAjXmAsx+E8kO4d8VubcdugaUnODGJwHhuL8CSe4MgIy4xCWvP4=
X-Received: by 2002:a05:622a:46cb:b0:45c:9d26:8f6e with SMTP id
 d75a77b69052e-4608ed29b69mr572131cf.21.1729033176389; Tue, 15 Oct 2024
 15:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com> <20241014203646.1952505-3-surenb@google.com>
 <20241014165149.6adebbf38fdc0a1f79ded66b@linux-foundation.org>
 <CAJuCfpETusPzdjEg01zahF7NOStQJZmoM5Jabqd5tJpCCQrj2g@mail.gmail.com> <k4uejpziyyhcuozdpm6x6iy5zuugfhozilmgmjvo574yuq2oen@zvdoiqmk2mii>
In-Reply-To: <k4uejpziyyhcuozdpm6x6iy5zuugfhozilmgmjvo574yuq2oen@zvdoiqmk2mii>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 15 Oct 2024 15:59:23 -0700
Message-ID: <CAJuCfpEdkVkeBvHyusiY8XQaM22vP_LZr9LnWxesHMt7f=No4g@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] alloc_tag: load module tags into separate
 contiguous memory
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	dennis@kernel.org, jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 2:08=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Oct 14, 2024 at 07:10:56PM GMT, Suren Baghdasaryan wrote:
> > On Mon, Oct 14, 2024 at 4:51=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Mon, 14 Oct 2024 13:36:43 -0700 Suren Baghdasaryan <surenb@google.=
com> wrote:
> > >
> > > > When a module gets unloaded there is a possibility that some of the
> > > > allocations it made are still used and therefore the allocation tag=
s
> > > > corresponding to these allocations are still referenced. As such, t=
he
> > > > memory for these tags can't be freed. This is currently handled as =
an
> > > > abnormal situation and module's data section is not being unloaded.
> > > > To handle this situation without keeping module's data in memory,
> > > > allow codetags with longer lifespan than the module to be loaded in=
to
> > > > their own separate memory. The in-use memory areas and gaps after
> > > > module unloading in this separate memory are tracked using maple tr=
ees.
> > > > Allocation tags arrange their separate memory so that it is virtual=
ly
> > > > contiguous and that will allow simple allocation tag indexing later=
 on
> > > > in this patchset. The size of this virtually contiguous memory is s=
et
> > > > to store up to 100000 allocation tags.
> > > >
> > > > ...
> > > >
> > > > --- a/kernel/module/main.c
> > > > +++ b/kernel/module/main.c
> > > > @@ -1254,22 +1254,17 @@ static int module_memory_alloc(struct modul=
e *mod, enum mod_mem_type type)
> > > >       return 0;
> > > >  }
> > > >
> > > > -static void module_memory_free(struct module *mod, enum mod_mem_ty=
pe type,
> > > > -                            bool unload_codetags)
> > > > +static void module_memory_free(struct module *mod, enum mod_mem_ty=
pe type)
> > > >  {
> > > >       struct module_memory *mem =3D &mod->mem[type];
> > > > -     void *ptr =3D mem->base;
> > > >
> > > >       if (mem->is_rox)
> > > >               vfree(mem->rw_copy);
> > > >
> > > > -     if (!unload_codetags && mod_mem_type_is_core_data(type))
> > > > -             return;
> > > > -
> > > > -     execmem_free(ptr);
> > > > +     execmem_free(mem->base);
> > > >  }
> > >
> > > The changes around here are dependent upon Mike's "module: make
> > > module_memory_{alloc,free} more self-contained", which is no longer i=
n
> > > mm-unstable.  I assume Mike is working on a v2 so I'll park this seri=
es
> > > for now.
> >
> > Looks like the last update on Mike's patchset was back in May. Let me
> > check with Mike if he is planning to get it out soon. I would like my
> > patchset to get into 6.12 if possible.
>
> 6.12 or 6.13?

Right, it's 6.13 at this point.
