Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F063D5C38
	for <linux-modules@vger.kernel.org>; Sat, 15 Aug 2026 06:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776695; cv=pass; b=g03+grxLgSIMybCm5JkkMTgRjALHrAOF3N1IDwHXcXna1Xd4AQG7x9LeNF1SAhAkyju5NsHlk4mC5u2l4o36l79k6PkQBkqJbbT6sc9jyNAM8b9+1JNURWGicvr+cvfzODkRumxm1bqTbF687NmqncogQL77SpF3dqhRQQ+iFxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776695; c=relaxed/simple;
	bh=LOJjF2L/Hw97+zA54YTMzFQ2dp+58kZzIwVj0qcqR5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvAmbXPmYY41ZaBa+ZN+/JL1VLNoy6pKzZ7Gt+9VxM3cYQp35Wo7Dfcsm2S6fCuSl4Ce5pv/zpW2cU0e6MaTSLI8flzFebbq4WVaVN9CSIR+oUy5IUQJABqavipuEN7ZuSaTZJlHhNaV3OIX0KO/iZRJxg5blgv26HCFQyrzTMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=anSpR0bM; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="anSpR0bM"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c01c79467so481691cf.0
        for <linux-modules@vger.kernel.org>; Fri, 14 Aug 2026 23:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786776683; cv=none;
        d=google.com; s=arc-20260327;
        b=BJVqf/uXzYYrGkwWyqEpFeb5uxa+aZf0mNLGCXxLZfpOQN/wBBZKOtTBV0JBHmfIL+
         kcWM7hVoVEMd5sC5pU5sP+8dUrYWZY2d2eu4J32/1WqBi1/WN9ulF6dbA4VeGkQBqcjH
         nKdSpd7Rpcy/Rn6+6SYcIjOE1d9RFeOJB6pF3FaEKs+3nKFuN1xmWNso0VHFnodK1FjE
         aGiW0bPiDcss/pWyw9b7kF3mx/R6KIw/cTO+wQsZF655ETn1pYdIUdpqUAllKuwf5zjo
         53EdE3t/vUxqQBxdwM0G4SeZKsZ7axmflvkvPQXEoYDdwPpIjp6ztPep0P9ovd0RI9EA
         BrRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zq2c0RpFytAPpB30mO0XEj2mdkMZ8ArlW2dXXmz706Y=;
        fh=Vk+HF2o4D9SchNAyzGaZXZJqtMpPYotXt6PGrArMx5Y=;
        b=M6h3NvXY5Cufvcy+cPvb98EUWONfx1CIW/psdnzvJX2ukNaUF/dNQxlZ9cTsPTr+J/
         d8BOzsy/zl3DqbEeNwHxx1yUNZBbifUzMypcW8IeNWWMmzC1bQm+GjauFjZAYJGTx5n2
         AHzTtrgyz41lU7PeF/e5gxjVj4PJYrwcnFMYeu+6kqXmZ3+JvKvcpb39zRRe9NCn9wg8
         WQYwUaYcmbAG64pyzLJa0fqRs9RduE6gYaDdLnf5TFo8pCTs0Pd0oQTLvNtHRp/CirVD
         ud6rbVL45FhI+wkmmOOM8GjIPJ1y6Rl4XzhJ2rGDpWq6UPHnDdylsdXpf7CH25ZxAxoy
         4L6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786776683; x=1787381483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zq2c0RpFytAPpB30mO0XEj2mdkMZ8ArlW2dXXmz706Y=;
        b=anSpR0bMxhC9y4pF8S5DoJYOToHO4GXiskrXyGOxJ23MH70zRisZ7lD4MftqiFfo7F
         Htqp0xBgZZEhysK8MjAF8klEOGoCT8+GbhO2mhMsVSWAG5aXQ/eBzJTbZndyXNtemEkQ
         O4YJ9qnt6iBODrH0F1xRM2RIj7mPjXzxAhPiWnxRmxdSw5yC9jxUWpM2cw22H4IUknCx
         JjLTrVuJJjq7eSyvpQBNpKFNaZqa+h9MvMEwZ8v6rzMgTZSQ3+zgG6Z/umynG80boeSQ
         WSlfyM/91GP0YKd+odXs9rMMYi9MUekMh4shpbgZWEyg9jp06cqTe9R25f0x5V6vnODb
         AXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786776683; x=1787381483;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zq2c0RpFytAPpB30mO0XEj2mdkMZ8ArlW2dXXmz706Y=;
        b=SorYqSzmpEQlr7VBrvnCpm64bWiHunwfeM4Ej3/7TjdSbgRj9NOnRb0bdASftAvr8v
         rF1lCNphCC+2NwxCkijCwTe1aHKAmgxZrLbGucwqHwVakc0VXjgPY6Jvxc6VTP09FOz0
         +ZmrJDwy+FvFIzPAMuTPE5Bih4bTOfJ5cah1jD0mllEbov7D46y4JBt0IGWEdmSWL97E
         ESUBzWCSsqY+O75f6AsFl4a5jUUUJU+E8OwVRXCTiLubqs1EnnNTYB+vIa99dpQHxd+P
         QG5lXHkRdbo1CBi1osIL7C1l1YyQdWxBZvaVN6YK2mlSxmmj2LLjm50x0fDIGC2+fDpT
         He5A==
X-Forwarded-Encrypted: i=1; AHgh+RoXGpimhP4SVbKtL8d6bd50LfsADiZnFrJgl09qWebdTQKIqMArlJ3l4beMPafHXvG7g3G6DXQYPe/GHi6v@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/7xrRMDD8fpNjOnf78Z8ntsbxOdCuwwHPWLsepTkg2ojTeZuR
	ctqPHtl4ZEgVZ5//ImY4OrgC03o3jSzxaLEInFgwww459GYhtS8YBXBFyEkAaA0OOK09xZo8Rsq
	HomunleU/i1i0jooOKS46R9wCE5tNwD1TRN8F7RH+
X-Gm-Gg: AR+sD129obrgPS+2zB0cnNqzQj+Rb6kigDJ3r+a2C+NqsUNzi6zxoL/ofgcyMJT/MMT
	tVnBQ03UovSTQurzKsN8LzP1Ac3F8sui0axwx0DbmMXgwpco1oZTLEx/7ZKZkRI+iV/UlF4mVm3
	E7idb2oLBgdY7rwLXKqV83d9SEsr9Sb+03+nCwgpAEWS+RWsmAJ7l4Bu+gLgMYOgwLR4yLNkKVG
	NMUVwPQ0I1HxhaAdQD4P0FiQeqr8nbjPyc6G/qmNW4BHo+grqh4pClKwOMKVRClyt/tsoVSMcaI
	RfCDuivyCzuhnOCs8LfGM6MHp5A4ZQgP9JXG0ADRcr0=
X-Received: by 2002:ac8:5f8b:0:b0:50d:edb1:6bd1 with SMTP id
 d75a77b69052e-52d8631482dmr11055441cf.13.1786776682352; Fri, 14 Aug 2026
 23:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813093421.135230-1-hao.ge@linux.dev> <20260813093421.135230-4-hao.ge@linux.dev>
In-Reply-To: <20260813093421.135230-4-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 14 Aug 2026 23:51:10 -0700
X-Gm-Features: AcwNN1VO4OZ-i99wJIbsAO44f2g8Nco5BTsyXPWH4YOr-l5zjYCr5D9HdcxgZ24
Message-ID: <CAJuCfpGfQrYJ=Rgrar-8btsiUCg=OQotWPou0J-mpMFNzrJC6A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] alloc_tag: remove /proc/allocinfo outside of mod_lock
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 2:34=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> shutdown_mem_profiling() calls remove_proc_entry() from
> reserve_module_tags(), which runs under mod_lock held for write.
> remove_proc_entry() waits for readers, and a reader takes mod_lock for
> read in allocinfo_start():
>
>   CPU0 (insmod)                      CPU1 (read /proc/allocinfo)
>   ----------------                   ----------------------------
>   reserve_module_tags()
>     down_write(&mod_lock)  [held]
>                                      use_pde()            [in_use++]
>                                      allocinfo_start()
>                                        down_read(&mod_lock)  <- blocks
>     shutdown_mem_profiling()
>       remove_proc_entry()
>         wait for in_use =3D=3D 0         <- blocks

Yes, this is indeed a possible race.

>
> Move remove_proc_entry() to a workqueue.
>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")

I think all these issues were reported by Sashiko, so you should add a
Reported-by tag.

> Signed-off-by: Hao Ge <hao.ge@linux.dev>

LGTM

> ---
>  mm/alloc_tag.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 7481180dadd2..b80f5a151f28 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -591,6 +591,13 @@ void pgalloc_tag_swap(struct folio *new, struct foli=
o *old)
>         put_page_tag_ref(handle_new);
>  }
>
> +static void remove_allocinfo_file(struct work_struct *work)
> +{
> +       remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
> +}
> +
> +static DECLARE_WORK(remove_allocinfo_work, remove_allocinfo_file);
> +
>  static void shutdown_mem_profiling(bool remove_file)
>  {
>         if (mem_alloc_profiling_enabled())
> @@ -600,7 +607,7 @@ static void shutdown_mem_profiling(bool remove_file)
>                 return;
>
>         if (remove_file)
> -               remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
> +               schedule_work(&remove_allocinfo_work);
>         mem_profiling_support =3D false;
>  }
>
> --
> 2.25.1
>
