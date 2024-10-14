Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03C41D9A5B
	for <linux-modules@vger.kernel.org>; Mon, 14 Oct 2024 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950232; cv=none; b=qcmfNmxnRcrl3SPc6iZf4y5h1lYzAr2455Zcv4CxCb1UwKsFr5ks3OBK6WJF4TgXAk7uaj77IwhiF/PQBK9wscm/sf0SbMv7txHljAyNQtNgXUXzM9qyDY2Ny7YmRHMUrixOJqYtTn376qrxPMrW7EZD3JiYbywtfPR/vhUOqUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950232; c=relaxed/simple;
	bh=8mMv1+/qYexUlPZZXjGJlHSVSZyeZZNxj0qHf5BogRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APXJ7NMiIx18qYFAFOEyh2Q8Dvc3FYiOfjNY9u2kt/W8Ignawrfb4MysZvHEkT++yel8A68v0+yfx+3+bebnugE0cvkdK/SlKZuIf90CB29T+Sg8ZDfJ5dWKiPx++CAU90CGFfNVNzjB6CPHNH/yVw9wRIUmcHD6aTpIcE2L3tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1F0Z/yp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1F0Z/yp"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a86e9db75b9so696562166b.1
        for <linux-modules@vger.kernel.org>; Mon, 14 Oct 2024 16:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728950229; x=1729555029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mMv1+/qYexUlPZZXjGJlHSVSZyeZZNxj0qHf5BogRM=;
        b=V1F0Z/yppu5snQoQNnKGiskGOaom5M9dE1nCdnqMx0Sh++MfM71joAGVJZc6E7bOyb
         TyFDdGnOY8VCIRMbR4sSUyaVfvXacXjuIoZthYs/tCYhIkatOkWWQsJ0Asjv1Kfmpgkd
         yy3x5B6alXQaGjMp+W6N4m5ZoYJaVsFT6tGCcQM13KfkAD/DhBmN5EJq/Z6Um3kfJI0q
         sxLaLNpjFZzTN+96+jC2jT4v0T4MXjHeOef6/b6hAWnCCgv0gmpNjxkkzhDxlrQ0VuGJ
         Reibacf8AB3o8kB3/7azJXsqY3UKHrsivIb5Kl3til7Wf4h3QQm03QsXS+/eFK9pBLvT
         86sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728950229; x=1729555029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mMv1+/qYexUlPZZXjGJlHSVSZyeZZNxj0qHf5BogRM=;
        b=WOdQoA0si6uxRgOAwb8Kmk7wbzFa8un7j3lSlRkrykD+kGkv5Dpm3/V0udlov6JCg/
         lPA6kzbECZbt9dYDBfgcL8PkfKyLFMBiRJWJ+mht+aHdbWv20sR3PIj17z8QIevIidb2
         Zp0PU+vedfF0kXJjo+nbPB15ZYmioIIi/3f0PF+MO7QPL0ItUOuQnTPy576/6Fc140TS
         X8WyESyQq65FDLjCLcOKbn5yziIA/DmuWmvu/ob5rjI9QSr75vMstX6GPEPmzZ3pLqP+
         H1o9ZwpXXesFikw+ZKgV2NhSB3u9UcvfBmt5mYcY9J4ATnwYq0FwPba4Hwvl/2bkdNG/
         9ezA==
X-Forwarded-Encrypted: i=1; AJvYcCUffUCyTpLyH9QBbMwgXMduY1CtU95E2/G3DcDcox50LydLhZvbFw7IceGLXA1RIQIEk/xCMpfKO9wJEoaa@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyd5jEYNJJaiauku9ew08PidGMjTFUGnz6P40xSgYBTgWVxfOx
	TM37lc/WOYt/yu2+i1WnK0X7H7K5UVNaOMSPvN/nLLBFQeXy7M3KmFhIG17xuO9G1x6Z0phtDF6
	Kw1H1jJCQyfMcJcORZ29lEm4GV7ZF89WhfYvs
X-Google-Smtp-Source: AGHT+IHCRbSEFH8dvrQfl8w/MPZdNADUHU+gGQqJoXe1fpzCrFvaqa6J94TlpNAt8drNzGuJlS0SjcmCg/I0CEvyR2M=
X-Received: by 2002:a17:907:2ce6:b0:a99:fb56:39cc with SMTP id
 a640c23a62f3a-a99fb563b89mr582010566b.38.1728950228942; Mon, 14 Oct 2024
 16:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com> <20241014203646.1952505-6-surenb@google.com>
 <CAJD7tkY0zzwX1BCbayKSXSxwKEGiEJzzKggP8dJccdajsr_bKw@mail.gmail.com> <cd848c5f-50cd-4834-a6dc-dff16c586e49@nvidia.com>
In-Reply-To: <cd848c5f-50cd-4834-a6dc-dff16c586e49@nvidia.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 14 Oct 2024 16:56:32 -0700
Message-ID: <CAJD7tkY8LKVGN5QNy9q2UkRLnoOEd7Wcu_fKtxKqV7SN43QgrA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
To: John Hubbard <jhubbard@nvidia.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	corbet@lwn.net, arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, 
	paulmck@kernel.org, thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	dennis@kernel.org, yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org, 
	iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 4:53=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> =
wrote:
>
> On 10/14/24 4:48 PM, Yosry Ahmed wrote:
> > On Mon, Oct 14, 2024 at 1:37=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> >>
> >> Add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS to store allocation tag
> >> references directly in the page flags. This eliminates memory
> >> overhead caused by page_ext and results in better performance
> >> for page allocations.
> >> If the number of available page flag bits is insufficient to
> >> address all kernel allocations, profiling falls back to using
> >> page extensions with an appropriate warning to disable this
> >> config.
> >> If dynamically loaded modules add enough tags that they can't
> >> be addressed anymore with available page flag bits, memory
> >> profiling gets disabled and a warning is issued.
> >
> > Just curious, why do we need a config option? If there are enough bits
> > in page flags, why not use them automatically or fallback to page_ext
> > otherwise?
>
> Or better yet, *always* fall back to page_ext, thus leaving the
> scarce and valuable page flags available for other features?
>
> Sorry Suren, to keep coming back to this suggestion, I know
> I'm driving you crazy here! But I just keep thinking it through
> and failing to see why this feature deserves to consume so
> many page flags.

I think we already always use page_ext today. My understanding is that
the purpose of this series is to give the option to avoid using
page_ext if there are enough unused page flags anyway, which reduces
memory waste and improves performance.

My question is just why not have that be the default behavior with a
config option, use page flags if there are enough unused bits,
otherwise use page_ext.
