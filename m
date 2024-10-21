Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C89B1CBEB6
	for <linux-modules@vger.kernel.org>; Mon, 21 Oct 2024 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528385; cv=none; b=eECqaEK/Ceh6iEQm9MJ4y/9nv08lKfiYpkvWePSVDdCztR4s1C+RhOxlOpJkw+V02azGnNUMevdvo8U7NNTf1DuMkxFJtnrxJdf+FdH70G5r+JOttGZzNcuhLfNmOOBwQRmHorJK2U27HgKuMnJXWOG/aaBCDAREeaS9a+C9Z9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528385; c=relaxed/simple;
	bh=KhDaWTmJM6nlwXBFOjmpIqQOnLI9apyaahvjApCJ+z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfcVwZ3ZGOVsH5ZhWp4ug9RA9g7xAF921eF2NUREQg9YzM46nPRURUfYj4Y2QvG9svVlr2RMCSK4GVGx4bOmrAkS6XE1ibA5aw5b0WG7uskDqyZrK3gPxkWDtQmdwZ31qQzFdH2SGhsU1rSIZPF/up37w31DfFdV6dS8r3lfW6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n6M9c7RV; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n6M9c7RV"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460b295b9eeso341161cf.1
        for <linux-modules@vger.kernel.org>; Mon, 21 Oct 2024 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729528382; x=1730133182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhDaWTmJM6nlwXBFOjmpIqQOnLI9apyaahvjApCJ+z0=;
        b=n6M9c7RVzEEViJ1XxuCI3im2jeVzeN2MjKcPzEfFxyqpGPrro80d7rvy+M/tukB3n9
         gZujALNvyTjaZ9pgECRNj/9GE/TQCmdh4xyT6/hMwdqmWdWa4ZVWyLIvHEtElb8G3crq
         yZcj9w2axBanglhNnDcd0bNB14fB31cbB4LYFcC0BJ/lhTjxaSOAq5BJAEV1zKuPljTG
         7UvtTvLZO43ZSWZkRwvf+EDLjeH0C9zEgx2XoqWFdVfpzkjV8yiuKyELFaf9lKgb+Oj2
         tYH4SovYwr9BQdcY4yM+JhD2DpAZfOYAHLohuCEMHPpsZLPLPsxorSNDjS6z9Gcjzqq+
         vYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729528382; x=1730133182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhDaWTmJM6nlwXBFOjmpIqQOnLI9apyaahvjApCJ+z0=;
        b=XlwB4AMC1MgnEuZgE5Xty9npmLlW2cXUCHlyjVfpZWbwWo3aN+WuW8InrzTiUDQJgp
         KEo+CkMmTcLqWSTKAPJqAd2XjxuYYSvCah+JEr8lz8f5qXrDcAIbYOzYKUYnxtlDG9By
         Im8olnfyCljfHIDgqAhe96ANW36c3eVjiW9ubkzfqCWRj1Zc5UeV3uYBgEJPqLK9tsXG
         w98K0foy3cBhdDN7w+o6Qgh8HGOur2gSiAeepHUCUlMoOUAtErBcEL1Nt7zyIBGTtdlB
         PPFUS2FzAf0ofNb19hRHazCTraN5XnZFIC/QzelxObm73O2nrAPejhbMX3fSv6onn8LZ
         MwFA==
X-Forwarded-Encrypted: i=1; AJvYcCVwyaXZvKfrpflkluOFD4nQ/swfhGaivvlveLFfOn43Dx9/1CADQRNT4qYE0RLyNDPs2T+2AYmCo4Ey/Epf@vger.kernel.org
X-Gm-Message-State: AOJu0Yylka/vL18JaZ52QutS649iXYMOrKQDrPNZFLOSRZObHfhFlmMt
	PgQOE61q2agCdz8tDIedowxnwMzGqXJN4UwQniuMCNpZuV3lnQ0P4+O2xZtHW8Jz9UOiT/fiLyI
	vdIsUuOJXH2MBrsbnXNk8b/jdjhWgU4q+lhXH
X-Google-Smtp-Source: AGHT+IEQJ7/dyf+59nB7w/ddzz12Ku666cGjBPoxf5tsDd/h9NHtih3CUtvHgU9dx314ldpzIPEbnG3QzndRB2BJVaA=
X-Received: by 2002:a05:622a:1a18:b0:460:77ac:8773 with SMTP id
 d75a77b69052e-460bc5cf9c1mr4982821cf.26.1729528381808; Mon, 21 Oct 2024
 09:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxKWBfQ_Lps93fY1@tiehlicka> <CAJuCfpHa9qjugR+a3cs6Cud4PUcPWdvc+OgKTJ1qnryyJ9+WXA@mail.gmail.com>
 <CAJuCfpHFmmZhSrWo0iWST9+DGbwJZYdZx7zjHSHJLs_QY-7UbA@mail.gmail.com>
 <ZxYCK0jZVmKSksA4@tiehlicka> <62a7eb3f-fb27-43f4-8365-0fa0456c2f01@redhat.com>
 <CAJuCfpE_aSyjokF=xuwXvq9-jpjDfC+OH0etspK=G6PS7SvMFg@mail.gmail.com>
 <ZxZ0eh95AfFcQSFV@tiehlicka> <CAJuCfpGHKHJ_6xN4Ur4pjLgwTQ2QLkbWuAOhQQPinXNQVONxEA@mail.gmail.com>
 <ZxZ52Kcd8pskQ-Jd@tiehlicka> <CAJuCfpFr2CAKvfyTCY2tkVHWG1kb4N2jhNe5=2nFWH0HhoU+yg@mail.gmail.com>
 <ZxZ_99yLDhRMNr3p@tiehlicka>
In-Reply-To: <ZxZ_99yLDhRMNr3p@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 21 Oct 2024 09:32:50 -0700
Message-ID: <CAJuCfpFk+1R8JQc+w6r6NUDsmjFnh9K1_42AvG+qTZq4vimwKg@mail.gmail.com>
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

On Mon, Oct 21, 2024 at 9:23=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 21-10-24 09:16:14, Suren Baghdasaryan wrote:
> > On Mon, Oct 21, 2024 at 8:57=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Mon 21-10-24 08:41:00, Suren Baghdasaryan wrote:
> > > > On Mon, Oct 21, 2024 at 8:34=E2=80=AFAM Michal Hocko <mhocko@suse.c=
om> wrote:
> > > > >
> > > > > On Mon 21-10-24 08:05:16, Suren Baghdasaryan wrote:
> > > > > [...]
> > > > > > Yeah, I thought about adding new values to "mem_profiling" but =
it's a
> > > > > > bit complicated. Today it's a tristate:
> > > > > >
> > > > > > mem_profiling=3D0|1|never
> > > > > >
> > > > > > 0/1 means we disable/enable memory profiling by default but the=
 user
> > > > > > can enable it at runtime using a sysctl. This means that we ena=
ble
> > > > > > page_ext at boot even when it's set to 0.
> > > > > > "never" means we do not enable page_ext, memory profiling is di=
sabled
> > > > > > and sysctl to enable it will not be exposed. Used when a distri=
bution
> > > > > > has CONFIG_MEM_ALLOC_PROFILING=3Dy but the user does not use it=
 and does
> > > > > > not want to waste memory on enabling page_ext.
> > > > > >
> > > > > > I can add another option like "pgflags" but then it also needs =
to
> > > > > > specify whether we should enable or disable profiling by defaul=
t
> > > > > > (similar to 0|1 for page_ext mode). IOW we will need to encode =
also
> > > > > > the default state we want. Something like this:
> > > > > >
> > > > > > mem_profiling=3D0|1|never|pgflags_on|pgflags_off
> > > > > >
> > > > > > Would this be acceptable?
> > > > >
> > > > > Isn't this overcomplicating it? Why cannot you simply go with
> > > > > mem_profiling=3D{0|never|1}[,$YOUR_OPTIONS]
> > > > >
> > > > > While $YOUR_OPTIONS could be compress,fallback,ponies and it woul=
d apply
> > > > > or just be ignored if that is not applicable.
> > > >
> > > > Oh, you mean having 2 parts in the parameter with supported options=
 being:
> > > >
> > > > mem_profiling=3Dnever
> > > > mem_profiling=3D0
> > > > mem_profiling=3D1
> > > > mem_profiling=3D0,pgflags
> > > > mem_profiling=3D1,pgflags
> > > >
> > > > Did I understand correctly? If so then yes, this should work.
> > >
> > > yes. I would just not call it pgflags because that just doesn't reall=
y
> > > tell what the option is to anybody but kernel developers. You could a=
lso
> > > have an option to override the default (disable profiling) failure st=
rategy.
> >
> > Ok, how about "compressed" instead? Like this:
> >
> > mem_profiling=3D0,compressed
>
> Sounds good to me. And just to repeat, I do not really care about
> specific name but let's just stay away from something as specific as
> page flags because that is really not helping to understand the purpose
> but rather the underlying mechanism which is not telling much to most
> users outside of kernel developers.

Understood. Ok, I'll start changing my patchset to incorporate this
feedback and will post the new version this week.
Thanks for the input everyone!

>
> --
> Michal Hocko
> SUSE Labs
