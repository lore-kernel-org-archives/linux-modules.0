Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E12B335081
	for <linux-modules@vger.kernel.org>; Fri,  7 Nov 2025 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762537065; cv=none; b=ews0TNzAmoGbdOwt1xcfYfb8TwcHKQxqPOB4hG1kem+iVMHd5OAtD70HO0Tx/afnomRgSnLapaxGsrec9yb2zTihqHq0P8Aw7XVSWdUy42fqjiRdUUPJvwjuwF4bXbCpoo/U/OWWJvKCQZspe0ip5X22SXmSy//AER5mtKTyL+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762537065; c=relaxed/simple;
	bh=ufIasMXmrbykI1h7RIcJjNYMxgJoIysu+7F6qFsRmBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrP/OixGjmc832aNeGj+JviklHpopXe5rGfKQqonJJ+8lFgBZqVfv8tS4JpL+YPUgh/MnYUSacj3p6Yoz/PiEtg65QOFQDxJZSpcwxq+H19TPvTIPST9Khs2PwG57P6x7wChkINhdtP4vwcq0oVN3U84JgifX+r6AZvmwmaganw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRN45tTn; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRN45tTn"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-426fc536b5dso645323f8f.3
        for <linux-modules@vger.kernel.org>; Fri, 07 Nov 2025 09:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762537062; x=1763141862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHObz/27sv0COJISHz74cJj2IGM7c2IBQU/5nIifxWg=;
        b=DRN45tTn58oaMcU4kyAZFdBAAN5H17FaGvGm7edj/WA+dmxpgwVJHxnggaswS3LUtB
         /T6DtSy53K+wkGgu6iBb5w1gLIiHzOMthfp+to9aPlfvemajkEweJrnO2ZrNoMhjoUsA
         kRaGZ7kavcvw1RMvsbSBvE2M5dDaK3sqTE0aksKcE297E8hoiHxvMX9z+HO8zQpgDdfT
         qY58AS/Cuv9bF7xqLoXO2I0YA/6V5xQsO/IyyJB4CLwHHeYFIY3zNP76GKFMvqT6RwR9
         yMf8+1hTD37abC2PeJjBQPZ9xCQ8HNmaQ9afunDf9zJivLKsIQRbaR36g9AoVYN21RpT
         ioMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762537062; x=1763141862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AHObz/27sv0COJISHz74cJj2IGM7c2IBQU/5nIifxWg=;
        b=S9w+he9gNY4hpIqSqZGFTXIuH8pdv6JsDz10q4eeyw/oiKh42/73Yi9BM2kVhGFAUi
         LrIqG/G/jIDB1pb8DDkeCOa8VYBfQhctw1aP08wrBtJyCFwgtMGnzJDlu/TASI2rt86x
         dOcvYsBNK/mJTdzpxAIE8p/++bUC1tRkuP2Fn9e+y1FunkaextPEf+q2KEPLlXUTxZqq
         j+ZatctvnIWuKZOJLzyk116rWKRmx/FgyzOOIMICc/OihCVz89EJCcEMP0PkKorU77mW
         pRnyP/t6GItFqiw1DpOysvL+OMfZa8UawCUdGEnM0kFP1UwPm6c0wKUGdzoeo4m7zZaS
         IyNg==
X-Forwarded-Encrypted: i=1; AJvYcCUJKPfVIhqdDx+lNHcAmd9qWAF6Dm7OM7ZADp+kkhpjnJNtgXcge9Ud++FQ5lVi6i1y7VHQqZ9nSvOre1+q@vger.kernel.org
X-Gm-Message-State: AOJu0YzbhxnPdSZua9KTAVmHxkbly0qMZTtdS/zxhpFcukbDNWXhQilh
	HuPpQTo+3IgTDaa4Rn9Vl5Bk9wKhAC9HcGxnDYdEsC4A7aeMw1JU0W842hEo+kfp+B5HOJgqkA/
	lYZ2rNL7AfGw7SKgtRI6QvywhkTq/5pM=
X-Gm-Gg: ASbGnctIQ0TR2g3owdUTisO08BH9j/YXhbLKiIK1Qld+yQg5z1MLgjk/g+U317Zr4v4
	G0ilkhsaLD+FAyziZ9OJf/2ou68qGO9v3dCDKb5bwa+8pudh+Biyp31DLcNcEue260jV4vfIYPb
	mw45sdqxO83SF2BPUXAACFqHfpl/VEYb3qjRl1rFFeFg5wLkAh9Y5zVJHZ47TMGk7NvJnsap692
	ch1NUvlW4RvRJmW8aklVcOzCGOnippKbIKZyh3vT8o3QThSlvjK20N0OSXaeB+9w47z+Z27UCMw
	G9PO73kQUXCzxDZ02HQjwTSCThH9
X-Google-Smtp-Source: AGHT+IGJ9JVXSNfoFVt0zgc1KaFggpC3AxcNToWkOlY0xNrMkdGAWaJ3AOy9YEsJYQDtSGrGASi28GHO+RGf3ibia2A=
X-Received: by 2002:a05:6000:4008:b0:429:bac1:c7f5 with SMTP id
 ffacd0b85a97d-42ae5ae82c8mr3566390f8f.44.1762537061514; Fri, 07 Nov 2025
 09:37:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105142319.1139183-1-pmladek@suse.com> <20251105142319.1139183-4-pmladek@suse.com>
 <CAADnVQ+kbQ4uwtKjD1DRCf702v0rEthy6hU4COAU9CyU53wTHg@mail.gmail.com> <aQ3vWIqG31BgE4YD@pathway.suse.cz>
In-Reply-To: <aQ3vWIqG31BgE4YD@pathway.suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Nov 2025 09:37:29 -0800
X-Gm-Features: AWmQ_bkSjVWhwwiyAdu8xQ2wTU8xFFXQd6OpWnFcdI-Hml8q4hACs20Z2y_lQms
Message-ID: <CAADnVQL3q1GYZDWeRyAzz79H2WdW6w=hy+uyUfYABq1RLE-Taw@mail.gmail.com>
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

On Fri, Nov 7, 2025 at 5:08=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Wed 2025-11-05 18:53:23, Alexei Starovoitov wrote:
> > On Wed, Nov 5, 2025 at 6:24=E2=80=AFAM Petr Mladek <pmladek@suse.com> w=
rote:
> > >
> > > Make bpf_address_lookup() compatible with module_address_lookup()
> > > and clear the pointer to @modbuildid together with @modname.
> > >
> > > It is not strictly needed because __sprint_symbol() reads @modbuildid
> > > only when @modname is set. But better be on the safe side and make
> > > the API more safe.
> > >
> > > Fixes: 9294523e3768 ("module: add printk formats to add module build =
ID to stacktraces")
> > > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > > ---
> > >  include/linux/filter.h | 15 +++++++++++----
> > >  kernel/kallsyms.c      |  4 ++--
> > >  2 files changed, 13 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > > index f5c859b8131a..b7b95840250a 100644
> > > --- a/include/linux/filter.h
> > > +++ b/include/linux/filter.h
> > > @@ -1362,12 +1362,18 @@ struct bpf_prog *bpf_prog_ksym_find(unsigned =
long addr);
> > >
> > >  static inline int
> > >  bpf_address_lookup(unsigned long addr, unsigned long *size,
> > > -                  unsigned long *off, char **modname, char *sym)
> > > +                  unsigned long *off, char **modname,
> > > +                  const unsigned char **modbuildid, char *sym)
> > >  {
> > >         int ret =3D __bpf_address_lookup(addr, size, off, sym);
> > >
> > > -       if (ret && modname)
> > > -               *modname =3D NULL;
> > > +       if (ret) {
> > > +               if (modname)
> > > +                       *modname =3D NULL;
> > > +               if (modbuildid)
> > > +                       *modbuildid =3D NULL;
> > > +       }
> > > +
> > >         return ret;
> > >  }
> > >
> > > @@ -1433,7 +1439,8 @@ static inline struct bpf_prog *bpf_prog_ksym_fi=
nd(unsigned long addr)
> > >
> > >  static inline int
> > >  bpf_address_lookup(unsigned long addr, unsigned long *size,
> > > -                  unsigned long *off, char **modname, char *sym)
> > > +                  unsigned long *off, char **modname,
> > > +                  const unsigned char **modbuildid, char *sym)
> > >  {
> > >         return 0;
> > >  }
> > > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > > index 9455e3bb07fc..efb12b077220 100644
> > > --- a/kernel/kallsyms.c
> > > +++ b/kernel/kallsyms.c
> > > @@ -374,8 +374,8 @@ static int kallsyms_lookup_buildid(unsigned long =
addr,
> > >         ret =3D module_address_lookup(addr, symbolsize, offset,
> > >                                     modname, modbuildid, namebuf);
> > >         if (!ret)
> > > -               ret =3D bpf_address_lookup(addr, symbolsize,
> > > -                                        offset, modname, namebuf);
> > > +               ret =3D bpf_address_lookup(addr, symbolsize, offset,
> > > +                                        modname, modbuildid, namebuf=
);
> >
> > The initial bpf_address_lookup() 8 years ago was trying
> > to copy paste args and style of kallsyms_lookup().
> > It was odd back then. This change is doubling down on the wrong thing.
> > It's really odd to pass a pointer into bpf_address_lookup()
> > so it zero initializes it.
> > bpf ksyms are in the core kernel. They're never in modules.
> > Just call __bpf_address_lookup() here and remove the wrapper.
>
> I agree that it is ugly. It would make sense to initialize the
> pointers in kallsyms_lookup_buildid and call there
> __bpf_address_lookup() variant. Something like:
>
> static int kallsyms_lookup_buildid(unsigned long addr,
>                         unsigned long *symbolsize,
>                         unsigned long *offset, char **modname,
>                         const unsigned char **modbuildid, char *namebuf)
> {
>         int ret;
>
>         if (modname)
>                 *modname =3D NULL;
>         if (modbuildid)
>                 *modbuildid =3D NULL;
>         namebuf[0] =3D 0;
> [...]
>         if (!ret)
>                 ret =3D __bpf_address_lookup(addr, symbolsize, offset, na=
mebuf);
>
> }

Yes. Exactly.

> As a result bpf_address_lookup() won't have any caller.
> And __bpf_address_lookup() would have two callers.

yep

> It would make sense to remove bpf_address_lookup() and
> rename __bpf_address_lookup() to bpf_address_lookup().

yep

> How does that sound?
> Would you prefer to do this in one patch or in two steps, please?

Whichever way is easier. I think it's fine to do it in one go,
though it crosses different subsystems.
