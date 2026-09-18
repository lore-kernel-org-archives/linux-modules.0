Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3EC3126DF
	for <linux-modules@vger.kernel.org>; Fri, 18 Sep 2026 01:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693760; cv=pass; b=bv3xNPw34I+sUnDSas+5po6gj196dGUwbLuVlVrsL4NzJc/ula12B3RZr5MeRXYoBY9PmxbVJiXZBZpff/LYvsK6SwUmqGPpEHjC3JhDgYrKr1vkIh5kNcKE1Zv7Wwi2ruDiA98DoRltl4ZhYa6eFI/g8spA+3hWWzX9De8jneI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693760; c=relaxed/simple;
	bh=VQGIa5OfAJMQ4r3GsmpmN36ZDjm6tlTvjyCikjUyEUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSr6K6hCmYHmkeB+fFo/qwp1zUgPsceX6TtXWrYNIxeyHKESDPpcv6E4GXbeoR8ecBbEthheAhIOIPSx3W4fbwbvKDZzSBYJBZYNrWMDshfao4iVZcaG+xegLsndsMlUR/2t9LBu7d2UenWtVZlAw9A58K+7xnY+MS7nSdLQ89E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t6Ow9wej; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t6Ow9wej"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52faa58bff5so157791cf.0
        for <linux-modules@vger.kernel.org>; Thu, 17 Sep 2026 18:09:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789693754; cv=none;
        d=google.com; s=arc-20260327;
        b=HplTaINRIa2f/+dZrLiDsw+CrXV4PVkAoY3PQniQkrQr4kRTXH67bwvUjZ4xOccjjH
         Sf+nIAuT8/yCZJBW48wWQjhGvMLVsLoDwDBMEm64xxq6ZNdpo+Og8cJiz+veE3NbOYEh
         FUwGVSCpAlqo0k3Qt0pmQs57HxyxTHle19NCPC3bz2NU7YhJYjKWRrNbKa3/19z67BnG
         UepTepkKK99A7dJs7Xzg02F3hztGUWMc7D+JeztQFCwfuohfvifJK7PBCWvsR4hQakuN
         czOTqLQNf5Mc72qR3tef+Xn/HK+/XuFwc4R7PyIi/BUajLC2iAb7P/sXcY2u07972MYY
         Q7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9OH+vRLumsrAn2s1eXS41G1CuSBMFEgYn9wTdjASFyo=;
        fh=pt1SFPRg2MYgtjGpGtE14cyjmmIDfS5WIYG+JgwSsD4=;
        b=MX3bl/syLcMDJFxYjk+4p3Lk68xuaMDxkEsg2WYrLk0gQOB/99LgNcQEMEDOD9VeyU
         A0zKXUt1yMNXIiXP8Gzdpzbpp1kavypAVc1Hcl+PbJu9vdEbNa/dJs2TtL8T/5wlOoaD
         +sdlLfm61L7WS0hftW8lUErfZOMlIHz+D+7VnLIMlfV54iUQjGO2W3dCHgv0Zk/89KES
         zwhlQwdkZh0VDBKIUcFQ8s4VPqiFtUqwhWuN+BvTzBl+ku/KySogTRpukLdpHam9oT0R
         CdaxyA6uh2gW9IQiccTy1leBs2nJErK3P8g77vbAV0xAvEVbQvUhz8+RUkT25GfRCU2/
         uJeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789693754; x=1790298554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9OH+vRLumsrAn2s1eXS41G1CuSBMFEgYn9wTdjASFyo=;
        b=t6Ow9wejpsaNY3SU4XpVe+Zw0+ZiIQ09b6+mUxgxsFQx3nC86ClPH4yLjBFJjB8fhR
         5W7gdoCXu+FHW6Lnx7fV/RIUtxwuOTC41T5A3CDR1vecCUfwiyFs807NLZdOGp8pNawr
         JoGzjyOgp2/8sgXPlX0l6PcdzHNA8nYsJyQWlstqJpoLlXjhzQHhCEWup31W47pzOkQt
         5y044f19rSQyXhl3Jgtprq5I9D5vhqhe831v7pd5d3jq1UwCis8gK7WSWG2iUBJEQInD
         teur1dAy00Mx8L4HVGxWhlaMwhqQg9j+Ye0Ksfz0Qp9hQqOHdS1McpiQBWFIAfKv6dY+
         TRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789693754; x=1790298554;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9OH+vRLumsrAn2s1eXS41G1CuSBMFEgYn9wTdjASFyo=;
        b=IWucOq1qe/sudZqoSnEIgrT8HVP6KVyLOowg5LVg/7k8z22yHQBsWK8JmlXHiHsqSG
         YjN+olRPh5CZ2H1E+YY0oQXjbU16SJM4AQHBzAGylLqgSV7tBalRLuqGJSJe+VeFuMMo
         UcVNnlCZSbqybzLVdOWwUPbRLNnuC3GTZAKgPEMiYbDlOCQBweKlAKNeOBVSGbnIqSal
         6iUB7GeENlY+cmZ9rzv5xdoTadluqL1tPtdPpE4g9u+EJuEWyI6o8+tNtY8E6kmc6k3X
         mVKay6o4SpCxn+d2yp400xvNrJ5fsn+hJ0kI0do2nqEjMZXPFRKoJSQ9SMcC/FhzcdmQ
         fbTw==
X-Forwarded-Encrypted: i=1; AKwUvBxyRO1h7PPXeB3be+uzWINyPKo7WQHFeniqoXwysGc+MaiyvvHZ7qMNX+Cc9e1eg30AgJqiHVzaZiWr/a+H@vger.kernel.org
X-Gm-Message-State: AFuF++m3rg6MPNctR3H4Qdm6+72/AGwLiUKsMRmabP1hLTcd5GswDs9h
	Jj+g6NdXubXTgadkYmpNuKUCKoF7/U6JmzkSJdfrM9L32XvwQM0dAIghHUBASQAE3Z3iJUPoOzg
	mpkcfXeUkEeI3Gq+sbP3jjjUh8xOPBGrHIQUd2Xrj
X-Gm-Gg: AYBFou1fSYffU4c4l/DW6NVX5WxClVfIDQVBqGo3p16lX2YogKaQ7OKDdO09A5XANH3
	/rQ3J04QzWrCfS6aoSg7Z8kJ/CassehKExOjC6PjnCGHHLcs532B0Oe+DBKY/Sn4JvMKAFhwaOr
	9rt343Dt+PS3cqGz+1aV4LfzVNZ/sNTH81Z26uoGXTGfjwsPXEQAYYKza9KihY2JYdj7aqCmBKd
	SZYrS+GSofjAIB1PHB/78pt/Fjl55UAtX5ZIxhyX8NfKZX5w9pmQYt4S0kJ3y4pUaV38Ue244Nc
	RBSvxSLTtFKOpZk0wurQsHIHQmqYyMBPpMBiiedjsz8vVZFuZj3Q3w==
X-Received: by 2002:a05:622a:2d0:b0:51c:ca9:3d17 with SMTP id
 d75a77b69052e-5329d7a87a3mr7686831cf.12.1789693753565; Thu, 17 Sep 2026
 18:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915070001.113559-1-hao.ge@linux.dev> <20260915070001.113559-7-hao.ge@linux.dev>
In-Reply-To: <20260915070001.113559-7-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 17 Sep 2026 18:09:02 -0700
X-Gm-Features: AcwNN1WpdwzfsuEi7atSbmPcBeuY9CTLz0TyEvuZKGkV5swWnf0AU7r2YB5LThc
Message-ID: <CAJuCfpGMQqjHsAvW=XUA1Q3AyaVJKM2bKYVja_fgn0wa1tk7DA@mail.gmail.com>
Subject: Re: [PATCH v10 6/6] alloc_tag: Defer /proc/allocinfo removal to a workqueue
To: Hao Ge <hao.ge@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:59=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
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
>
> Move remove_proc_entry() to a workqueue.
>
> The file creation is moved to the end of alloc_tag_init() as well.
> If alloc_tag_init() fails with alloc_tag_cttype still NULL or an
> error pointer, a concurrent reader of the leftover file would
> dereference it in allocinfo_start() and panic.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/alloc_tag.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 1ca0409b492b..cfa0fc84b68f 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -15,6 +15,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/string_choices.h>
>  #include <linux/vmalloc.h>
> +#include <linux/workqueue.h>
>  #include <linux/kmemleak.h>
>  #include <uapi/linux/alloc_tag.h>
>
> @@ -591,6 +592,13 @@ void pgalloc_tag_swap(struct folio *new, struct foli=
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
> @@ -600,7 +608,7 @@ static void shutdown_mem_profiling(bool remove_file)
>                 return;
>
>         if (remove_file)
> -               remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
> +               schedule_work(&remove_allocinfo_work);
>         mem_profiling_support =3D false;
>  }
>
> @@ -1358,16 +1366,10 @@ static int __init alloc_tag_init(void)
>                 return 0;
>         }
>
> -       if (!proc_create(ALLOCINFO_FILE_NAME, 0400, NULL, &allocinfo_proc=
_ops)) {
> -               pr_err("Failed to create %s file\n", ALLOCINFO_FILE_NAME)=
;
> -               shutdown_mem_profiling(false);
> -               return -ENOMEM;
> -       }
> -
>         res =3D alloc_mod_tags_mem();
>         if (res) {
>                 pr_err("Failed to reserve address space for module tags, =
errno =3D %d\n", res);
> -               shutdown_mem_profiling(true);
> +               shutdown_mem_profiling(false);
>                 return res;
>         }
>
> @@ -1375,10 +1377,16 @@ static int __init alloc_tag_init(void)
>         if (IS_ERR(alloc_tag_cttype)) {
>                 pr_err("Allocation tags registration failed, errno =3D %p=
e\n", alloc_tag_cttype);
>                 free_mod_tags_mem();
> -               shutdown_mem_profiling(true);
> +               shutdown_mem_profiling(false);
>                 return PTR_ERR(alloc_tag_cttype);
>         }
>
> +       if (!proc_create(ALLOCINFO_FILE_NAME, 0400, NULL, &allocinfo_proc=
_ops)) {
> +               pr_err("Failed to create %s file\n", ALLOCINFO_FILE_NAME)=
;
> +               shutdown_mem_profiling(false);

You need free_mod_tags_mem() here.

> +               return -ENOMEM;
> +       }
> +
>         return 0;
>  }
>  module_init(alloc_tag_init);
> --
> 2.25.1
>
