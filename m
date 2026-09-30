Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546C2353A77
	for <linux-modules@vger.kernel.org>; Wed, 30 Sep 2026 02:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735985; cv=pass; b=u4GOxyTl/p0AvZCsiIlALhu1l/MF1/zMIfw+NQrz/S0v/PIUvuGs1akZiupU94rVYtW7b3sv33eZSSDlcA5xI5VWp6v1c5UzN52sT1sxb/fFt/sPOeuxibeT52YjPNjdpbwzP9qdid3nu+DEC0NK1i7y8wX+w2Psa6I+4a4QnG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735985; c=relaxed/simple;
	bh=xljuBUmPGxvGdH8UYvqPrM9rVQr+Ag7pK3OC7bFa6Rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJhxNJ127uvN593zq23oA8l43ARsni7Q9oOWC2h/LvpeAFkaoURU/pkGnU5lrNBWYiOGpUV3kmq18yhTnv141gsWU6HtBeT+0IhgN+t+9qXVaL3Egc67AdAh5Fw6nOz0SXIRbdTJXQe1QRU2G/HXpZ04YNwQVWCkrydqq1rhTb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mJAZFTre; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJAZFTre"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-533202fe429so139671cf.0
        for <linux-modules@vger.kernel.org>; Tue, 29 Sep 2026 19:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790735982; cv=none;
        d=google.com; s=arc-20260327;
        b=jTYGyumibDbU927r2P0NWqA0CgWdj2dWdexcADY87KucVj6dMcEcSkSsfPV34VrxtX
         2jM/WF12SYt9n9n3XnzvBPZZTAXwtrMW4dyoALr5r2Xi/OOyhXgOJgeYlt5aEplVFmax
         7GBoo1L5NK19juazOLjrnZjKS9fw/3mBgLBVTaKJr/PqaLPYOta1SXKYzaevVDrcCwzW
         B2l5PJssZIG5VhdXeiZz0B2FfDBa0fgMWzMDxBekmx8PVp+dhvs/1DVMz9IWZ51jokds
         VN2/ESsYmtblzn0pR0R9Z3JdA019SjURFrKHmZZPhRw16UOvfdcw65BQCqghAmt2k3QP
         B4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yZcAtDmdj1TXf2oHPw6z6v/buKgWsDNfkRToankrygM=;
        fh=UKwjjHwM8Ne1g+Kh99XYX8TPYi7btzMPdXS5Orw7jnk=;
        b=qkZjIeR4044I+S4LKGHtD+Tq0Tea9V9u59MmP442289bzgPozGe0RXh9v1Ip8thDRt
         5kNk0R3DnH03kB9lHDEcmuR0Q93yS1MY9/c8kYDYjBUv92IjL7N+Q6aWJWqC1wOw2Get
         rfc0eMJlHmR136ktDayT3AeGrohf0ZPMnW+XdwmZqFEJmLTnk2by1hEYGxfDNaPSB/kC
         vJ7eC2v1NL2HEXzI5ZIlFbz2P/Y26QuSvvcsQilLm0W5h7PxdLFnaDdVngpBfHK0DPhE
         MzCcW6KhydZvzk8dlWHaeqLvAODulk8o8C33Q1swUMjQWDvY60Myw8I39cVYWOJVs4Rz
         7S2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790735982; x=1791340782; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yZcAtDmdj1TXf2oHPw6z6v/buKgWsDNfkRToankrygM=;
        b=mJAZFTreNpa0TkvBrpvBwRMqo0KAv414WfoayD4Gti0syrMenkIq36dPBmV0tCsPE6
         igsKFVkB8ypjyXrrjbzHIGhdkAgWyOqO4nONyQs0Qy6NRXmmDXsQIMrGUDsSV3yyF3fj
         OT9pmRAZGOkRHa4dhCCdpPoxX1ih0qg2/PsaGLBssHn1Hhk/+jUvMokBvAQlw0+HVFlo
         Aa6TGOBpdlMkRunTgePJor35/Gsy39D0udNcHnb5l+CL19Wc8aj9/IIZ698dzmFZ55o4
         bS6C06lHVWheZaiMFzUezGkWlEHFAyXqX5nBGccCxVbycXGF7W43Z5V9ehYv5RROK4jZ
         EfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790735982; x=1791340782;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yZcAtDmdj1TXf2oHPw6z6v/buKgWsDNfkRToankrygM=;
        b=EY8XPcaYjT0ecYfhD95ddL/If8dMJogKP5sPOEdX3AqalxoJtteFMheo+kVsaHwESn
         Mct4f7vUYClhK0q8oMqbBbylL6KbQ6Ym0uqcy+tUnEcPuw+WvomEU2xTqOZNDINuH4JE
         nFQriqH38oKpmsfOHtym7e3TWBaoBqHI8Qe/I2KGAnNUXj2wW607AmRmnp0jqgvHcLWr
         4eCIsFMVVZ+BDrRp68w2v07WZMLzuKp03KP0iw+wF3G/lldQuiNeJt5jv/f87BDD4EJs
         H6pv1fP9NrseT31/A2wZEexKq5/VHYAJBmuK5MEfuTr81rUMvhXyrYZR3ajxLHdrY4oY
         YUtA==
X-Forwarded-Encrypted: i=1; AKwUvBwlExEsVWF/9exKSgnYeTrqjz0tlWfc2+T3T3AjZQWaiBnORy7krp8C+RZuo2KOrtcBBnIp+ChL0mclc3Ky@vger.kernel.org
X-Gm-Message-State: AFuF++kSPIXOp6SSYs7jKYuIzbqzXcFTMWn2a9ItxhLCpVmYyOpaIo0g
	ms03h8qtuUnbG7tfuX95iqJZJ/On8oyldFgz3FT3Q67GsGpflNvqmtNwoRnPMeUjVvROt9AGA5h
	9KsJ1slrR9cT7VNTGfQE6wBkb1nUQLaYL0/e9S+fo
X-Gm-Gg: AYBFou3C9J1dtwi7fCg/0oEeBLfIqbKLXjrvTcD6SzWy0prlaeFwYtnG7NvH0Eaw9L/
	0TmBPGMSnvrQin/Nw7oLoCOgMrn0e99DbylKrfqIJtaP1/Yk6nGfghxizUYSgi7rJAcpQTwf/3A
	7rGilVSQRWRBYNXGDvCGuE+p/eRKIFX2g/sBwX1uxjE/upLZX4flbU2zmEbfG6oEPZr02RJrXAz
	/30ejC/IF7caGtXOEoiJrZcQMA61Kr6yV/NaCV3eQ5asNV048m/EwctPuj4ZV+LfUiX1ulbiPkf
	TF1VsW8/7jh+BLvy+QkPvZoE+whXYNAmHv6yVsTm1wnP8EGOMG+WsGXtiXGCFjFE5b/c7zmDdFb
	HHAedtLw=
X-Received: by 2002:a05:622a:10b:b0:530:ac23:ff40 with SMTP id
 d75a77b69052e-5337423edf5mr1103181cf.5.1790735981251; Tue, 29 Sep 2026
 19:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929082014.160587-1-hao.ge@linux.dev> <20260929134401.a1a385ff4369661f879b5d2f@linux-foundation.org>
In-Reply-To: <20260929134401.a1a385ff4369661f879b5d2f@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 30 Sep 2026 02:39:30 +0000
X-Gm-Features: AclHuK_-aUPMeQc44-V_AL2TS77weF01uJnbgBxF4TBRUk7jsKIWk4H7GFwQgdU
Message-ID: <CAJuCfpFRW3uNUW_VrjpOfLwS1LBHqGEpqK3yBTPSpGOORY5jiQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/7] alloc_tag and module codetag section fixes
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Ge <hao.ge@linux.dev>, "=Kent Overstreet" <kent.overstreet@linux.dev>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 8:44=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 29 Sep 2026 16:20:07 +0800 Hao Ge <hao.ge@linux.dev> wrote:
>
> > With profiling toggled off, the overflow check in
> > reserve_module_tags() did not run, a module could load with more
> > tags than the page flags can address, and re-enabling profiling
> > then silently corrupted /proc/allocinfo. On overflow the fix shuts
> > profiling down, releases the reservation and returns -EAGAIN, and
> > the codetag section lands as regular module data in the same load,
> > so the module loads without profiling.
> >
> > Review of the earlier series by Sashiko turned up more problems.
> >
> > One is a race. layout_sections() and move_module() both asked
> > codetag_needs_module_section() where a codetag section goes, and
> > mem_profiling_support can change between the two calls, for instance
> > when another module load overflows the tag index and shuts profiling
> > down. move_module() then copied the codetag section to offset 0 of
> > its regular destination and clobbered the first section placed in
> > that region.
> >
> > v7 reworks where codetag sections are allocated, on a prototype by
> > Petr Pavlu [1]. The allocation runs before layout_sections() and the
> > placement is decided in one step, so nothing re-asks the question
> > and the race is gone. The retry is gone too, on -EAGAIN the section
> > is laid out as regular module data right in the same load.
>
> Thanks.
>
> Seven patches, all cc:stable.  Why is a backport proposed?
> Documentation/process/stable-kernel-rules.rst gives guidelines - does
> this series meet them?  Does Suren have thoughts?

I think vmalloc fix in patch#2 should be posted separately and clearly
quialifies for backporting as if fixes issues Hao found at [1].

The rest are also bug fixes but their size is concerning. I'll review
them first before advising on which ones should be backported. Some
fixes address issues that happen very rarely and if a fix is too
complex it might make sense to leave it be or fix it some other way
with less churn. Please give me a couple of days to review them. With
the upcoming LPC I'm trying to multiplex between several projects.

[1] https://lore.kernel.org/all/b8005c24-ecac-45c4-840a-fd282f9693b5@linux.=
dev/

>
> Also, Sashiko has been busy again:
>         https://sashiko.dev/#/patchset/20260929082014.160587-1-hao.ge@lin=
ux.dev
