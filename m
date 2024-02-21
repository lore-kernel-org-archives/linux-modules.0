Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882CA86AD5
	for <linux-modules@vger.kernel.org>; Wed, 21 Feb 2024 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550195; cv=none; b=SOfWCA3k7eoM6+i/d6M2IZKKNL9iNB6H83qIf+SxqTakgr0gkNLwrbLOBE/FELNJvAyuT5zOG/mwMrbFw733Vh3fHRCgrt4Mmg7MKKA83xhEijlPuU14Ii8P+r0j9MM+KVHDK3W9SHsoIsB2DuwasanoB0rd9uFJppoVIxNj6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550195; c=relaxed/simple;
	bh=04iwdfiihTWiqSIzPHAdzy89EcAty14KO44MmWzyPPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsAwwlLlRfOpGhlS8t7Uep5YmkdzoqTDYxK/fCT9eAGzO03Pspxei8e7hJlPTDgDGWaRs0vUoZKWNoIfD0IFFsMn1s1p63ujhTKPt6jN4BY1LwF/vKtV1aiAKfCMnRX+DiQhq5LzIvO4iwCPThcQ3oZC9PWDnT6fIe5kWF1E36g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=lwP34nuD; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="lwP34nuD"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e2da00185dso3808960a34.1
        for <linux-modules@vger.kernel.org>; Wed, 21 Feb 2024 13:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708550192; x=1709154992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWpAXMfptvXBWhPj/Zu9FAZfSnAxEQBXKk45RWYFa4c=;
        b=lwP34nuD6nw4awH46Am+5av5lRCOibnaz9Ie7pvz945R95r/dnwwF5031LRlEHIX06
         9rbHEtXuoNoO2ozZ3VkcvznexnbC5ACiq5lQ+15Zwd9MW5YQpfJ4uNfhX9aBR2oI3q0p
         55vt5GxmCf/Y52qtArIACuoNxJ0H8rROljiOqAA35XrVj1E48Cgm1Sofi8C/ZOX+g1xM
         HY0EkiGd9ugAvCz9VIxfX/Zmmn+CrHJzr9bzu3mrq0riPB5lgk6KV4jYnoWt/0RvwDiB
         7/rOeNZkit6L36UCGeGm0ouAhXQjAy9f245UHOd5wo8kcyHXeV2Uoj7fZNBbA8IFBjrg
         abUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550192; x=1709154992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWpAXMfptvXBWhPj/Zu9FAZfSnAxEQBXKk45RWYFa4c=;
        b=eFWcVSyH2lw/zlHF3sdP9PGQdv1B3x1wB8amR9SmA8qC0R2iVVzCFqkWg900rLjy+b
         JfF7zaRvhitM81AyjvqEQRMGED+c/f5T+TOrMs5E7F+OHQGBRDGLdW5gyctQ2pgAxZE4
         pPSH1Tyat6br26D1wUxkHjNWRGMa0e2OAlSmipgV5jAbco61/CbH49hBlTbfhatVjEvo
         +9Ku3Ue+QPh1A2p+XzRXN1RQhsf0EuegE3gCFsdQ4I8yqdxsapLJRQy1PC885MScdnMV
         5suBKahfVNt2iFGdiRjWY+vrM9HQ4P5U5x6mn5qBPkQrICQjM+WOb/zlBG6Sd7VQK0UK
         7a2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGK+vOEjWNa26JG5Vcm0oYaIO8nMba3mWtALcmNooO/3t/m03NTjvYkByrZ1G2Dc3CaMD5BfFaF7l9ebAnl4xtGucNQ/+Xllaecg1Twg==
X-Gm-Message-State: AOJu0YzMDO0LRQ70AnJ1Vs9wBGgzTb8jQTrRUAfCkDVRz/+HgVwLSwqA
	Dacfy2UtXsSbM7wWdkfSQ5EG4Z7lKtEkNTrIrlXBb/m5u86MJasqoNIYbJRsBwQX9NfihA7Whtq
	V4RbwezMK1XoC0wsjXqRuNS/pCfYXx49OWnraTQ==
X-Google-Smtp-Source: AGHT+IFlqSylMCeI6KGNha3000K+lFHjDKANDOKnq2alJEDr9oyGg2RKFtJGNI+yjwYm19RTm7J/7Xp71REjuXyqMMY=
X-Received: by 2002:a05:6830:1345:b0:6e2:f2cc:e985 with SMTP id
 r5-20020a056830134500b006e2f2cce985mr19962028otq.13.1708550192733; Wed, 21
 Feb 2024 13:16:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-4-surenb@google.com>
In-Reply-To: <20240221194052.927623-4-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:15:56 -0500
Message-ID: <CA+CK2bD8Cr1V2=PWAsf6CwDnakZ54Qaf_q5t4aVYV-jXQPtPbg@mail.gmail.com>
Subject: Re: [PATCH v4 03/36] mm/slub: Mark slab_free_freelist_hook() __always_inline
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> It seems we need to be more forceful with the compiler on this one.
> This is done for performance reasons only.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 2ef88bbf56a3..d31b03a8d9d5 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2121,7 +2121,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, =
bool init)
>         return !kasan_slab_free(s, x, init);
>  }
>
> -static inline bool slab_free_freelist_hook(struct kmem_cache *s,
> +static __always_inline bool slab_free_freelist_hook(struct kmem_cache *s=
,

__fastpath_inline seems to me more appropriate here. It prioritizes
memory vs performance.

>                                            void **head, void **tail,
>                                            int *cnt)
>  {
> --
> 2.44.0.rc0.258.g7320e95886-goog
>
