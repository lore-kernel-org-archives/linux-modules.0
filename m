Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2129AD49
	for <linux-modules@vger.kernel.org>; Tue, 13 Feb 2024 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707784499; cv=none; b=syUtDitzLmHnw7SliVaawyGykxQuYnaW8xedFCljwHn0mtSaNYb5WTjH+8Q7nRRzj8ioMUxSQtFwc6MSMc5u6f9GziqRrpzSHKipWUrxfmZcOBxO9AAMP3MDgU1ZTnEg/NNKHIMWa0VGsa46KuRYIrD/iFq8lRv+qq2fXiDbMRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707784499; c=relaxed/simple;
	bh=UHD/3jMRU1ccG3YkQIqWf6JR5thVdXFBz5XlT+Q0DtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRyU5OfegVYEnw9ZOr2wyMKZLsz0q6+9dzSc13DfqAOKoLoCWeQ27iPS8rL3fp1aUUBuIARllk/TUcVj1SY0vqW71NcXebR6V0mZzqoekpnQUiAP2oGkw/XVL2k8Nl8Aqlx26Cfg5uuZg34/T2vQime0uMDATPt3rwTAiyHL+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VcnH2OX3; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VcnH2OX3"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc5aa17c34so266487276.2
        for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 16:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707784496; x=1708389296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHD/3jMRU1ccG3YkQIqWf6JR5thVdXFBz5XlT+Q0DtQ=;
        b=VcnH2OX3DeUYPZWgyAWCfueir+Il6fPz5xsjgcxjJc6gSreMJHykBs1T7paTrRdt9h
         tK9mmlEcqb98YAbYrTWTW6vFGd39hug9H0qEo39nVQ5YKDiWgeSB9tCgFV9Iiron+AdD
         zF26crCCuv1evyhr0gKl4S1xjBsvwV40azO3KrXpzLaNWBnUNxejrwBNRu33N6+Et+ja
         uy+3Qjp7QeyqzPjSQBCvw7BCbuaUz5Zgu2E68BJHV9ysk7VNJFvyQXLZxbdWiQOQP4Zf
         3l04OZiHfuUCkcAgTGD+tfA50CzhGG+YuUPpImoCGc5mG1Cggx5Qw3cDaaWjDxeZPV5l
         yvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707784496; x=1708389296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHD/3jMRU1ccG3YkQIqWf6JR5thVdXFBz5XlT+Q0DtQ=;
        b=G8gvWnCHKsReVnAEAQFgxXHwbG3QI2rezIs4YOSaC/lPUUopi15NL7wh01UvnaecEP
         OlCi7vLJ2s9tjvfZEkYpRre2VmHPG3ugmO88D4Msqmt1c+XF33l0E1mK5fUjNRRb7cKe
         JCNJrNl3iq48sO43e42qOY1DK7k51Y2o+CyeQd0yy6paO80z3/zTOVPP0Sc+aCg8tg8g
         vXtBZTwdrxEapJD9bwPEk6qlPgE5SzkEUywp6Aqt8Ct8/Zsmnp3dkwEHt7bgoK9DvDL2
         2c0yKu63YAyUdva48EbSOuFYp9vC5Yi+evxRp75eVwPgxVVBFT8LIZADxgMS9LtJVNMj
         0I9g==
X-Forwarded-Encrypted: i=1; AJvYcCU+P+a+Rks8TMCAUuLGA0fheab0dcqHAHWUHqOrJFwUg/7Yw1B6mv+zkPORNq7oScf2EfhEY2vS+cidmazsfXFfh+sOJlu3dRPjjBGuhg==
X-Gm-Message-State: AOJu0YzH80Q2vJ28xd98jfjaaRRU48PjrUHTwecEqd6zHNWRqDLbPUsC
	4ObJhCctgTH5sqQX90vhObAUUIkGwowSQRyFuEPELwYVFs1BZoNjLdnear8GSECq6rrU1qFAR1e
	8X5cekJdOwSYMZ6/l3iaieUh/mOtPIUKLmPMb
X-Google-Smtp-Source: AGHT+IFjB55gPzAJ3uayg/3DbZropi86YtyNQzi/ARRSHghfRy48VLa7tw6T2sjep0csYIBMYiEo+U9Z3yu21UMYcUw=
X-Received: by 2002:a25:b389:0:b0:dcb:ca7e:7e6f with SMTP id
 m9-20020a25b389000000b00dcbca7e7e6fmr1832315ybj.55.1707784495521; Mon, 12 Feb
 2024 16:34:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-24-surenb@google.com>
 <202402121631.5954CFB@keescook>
In-Reply-To: <202402121631.5954CFB@keescook>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 12 Feb 2024 16:34:44 -0800
Message-ID: <CAJuCfpHf+EUPL7ObG7ghVhQShcJJSwMjNcUAzeg-x1BoS5OeEw@mail.gmail.com>
Subject: Re: [PATCH v3 23/35] mm/slub: Mark slab_free_freelist_hook() __always_inline
To: Kees Cook <keescook@chromium.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 4:31=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Feb 12, 2024 at 01:39:09PM -0800, Suren Baghdasaryan wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > It seems we need to be more forceful with the compiler on this one.
>
> Sure, but why?

IIRC Kent saw a case when it was not inlined for some reason... Kent,
do you recall this?

>
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook
