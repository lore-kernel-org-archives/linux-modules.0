Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65CF1F4631
	for <linux-modules@vger.kernel.org>; Tue, 11 Aug 2026 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462574; cv=pass; b=ds3KSeirpwH6e9dfStI54f8T48RyKKYboNbUp1QnrOUND9TJWnOFdVvIfEktaczJ/9/qBWGri0Km4de1DYx9YIlqgjSVk/FYifONTTcy9MzbxLDtokbC/PdIEXCfQWS4yVvtMTzks9iW6XyLxwWtclZINhLQsvgQN38K9GkIXAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462574; c=relaxed/simple;
	bh=UGjmBnLSskHI7nXRul6AYIWNR9+V1zLg5q/EQLIYSSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWQJPvfgkjctQ5obVbkNdlN8g9g96ViLXU0BQwEOgtv44C+uUyxRgLQt5EdnC7ABb+jNb/P648l4QCpN8Jy3zdYhvGZjR3DC8I4PA5P/zi7BU0NPI8RcsdIk521fFVbxAM9vcIzelsbA4aYnmWHvEcsPcoehoNTqtF3J+VPeHZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DgpjdAuX; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DgpjdAuX"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c15a5b265so272741cf.0
        for <linux-modules@vger.kernel.org>; Tue, 11 Aug 2026 08:36:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786462572; cv=none;
        d=google.com; s=arc-20260327;
        b=FOvgfbJL77OYDC/Oiqp1Oue9pBNs4TtvmpnjtBu/1hdqvmeuuND4v1zXmNhfgDWq8b
         oF7fJ2XuBlGpFN2CWWUyCbbrflJUYmRLgDnTvr8+2ZCqIXh/G7S5MJMBjfrISUctuZDx
         ukBXh473mV/5C6egR/qyx8XdxTZ+wlC/wbYH8fkS5rH0pklCC8mHg34IZzHc7F/GIr+S
         0tlWThU+y7+l/JvLDqtbSKSpvn6LySXrgalrrSnnZezoCVkkMGmTNWFioyGFDNdGzhXA
         kCilaAUJPhyFOCElXq8UDgmZuSLkO6yno8Qmd5wxIeKJkGLRHYkUK7xNQzdnPSnuMWLH
         pGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QSbnyX+X/byoPpEOsc6XvB0JapembmgEXtZ5bd+IWFE=;
        fh=PmrsZp46NP7J1Xk6Gq6i25M/2oUb/83AJOQu6qh3ifU=;
        b=SS0C65YyaYjoQXTD9/kGAI79xr85Vtb+q1powfELkdJQJ43hIc2/DLfry+/8AHZZiE
         bornE4AIA9YZpXAPGpb6MgSzW4sT6uKDN1vf6WDOXjhQ68LHT+JmZtF+1sggMGgaiAng
         p4u21Jm/wloYWxnMhUuLxWorYl9yVx3X1huQ4tZsHHjI02Cps5gIZHa3BTswn7Om336D
         4S6upS++en0dKhqHoR1K/7SNmaTkcNSbjADef5A2oIvr2M8XYM7bR/CkcojskU3vHFAd
         03V1EOHl+Yvl/qrrDbwpaLtviV1SmGloByAdOq7ze/kYGM1HZqORhQmFkUrkM79KP0lK
         Ntcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786462572; x=1787067372; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QSbnyX+X/byoPpEOsc6XvB0JapembmgEXtZ5bd+IWFE=;
        b=DgpjdAuXck+ooks6lh+VokUHAu2N57XesXUZSRJZrydy8euaH+rF9Kdl5HPxD0Rqrq
         i4F0MvGIrqFhpcJ+KhwSSG5pYY5PxHJhefYa4btEZ6ht0mIXKpB7KHiVxJiq0yJC0mq+
         6/+5dPco2R5YwhGtbw6YhIyvUIuu9pNF0ap5pW4lFEVLJddyyu4uFzcuTUQ2eYLJqnoi
         qQr1Bvm87KVSKGmwiOF5ZeMNczE3O+jzaiv1xRR7NJdrOkTokfSV/JEcsdlHZ3LM9nOH
         2B5SFVFvA1SQ3j9uw+L5BDgxugja5e8ZiwphM0YIHM7i5QUjWqD7sKP0MZcyA9UyAHNX
         tmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462572; x=1787067372;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QSbnyX+X/byoPpEOsc6XvB0JapembmgEXtZ5bd+IWFE=;
        b=rfU9koUOyjJv1GmGL6t9W0ZUBAOQk06sa4hBH1fL19KqNSo15lzv1/xGAnzY7mZXMj
         d84MbpIw8csV0pCFjNhEKosH6/BcuOlLUV21StzBMIOj3WGlSSXoZ51pIwBIjDxWFwcU
         qM9EsU/Kh4ZhvXFjxeVZ+y+ok7yhPaZb00klwmehIWYS0BqevL6cmQYwKQL34v6/JYPD
         g7peeoORoOO988E6wFkeCke8U1SUcMMBiyxHl+ySueALjbxBZRPE1ax5yFg94XlmwJjR
         EO/lnnOKeSaEJEmJqcUZTau68EQJJrQ2HLP+Xpg6/uf+1RlX7MNSgKlPsUBaOyUXpZt1
         7/Xw==
X-Forwarded-Encrypted: i=1; AHgh+Rq9dgf8DlJee/4CWQphxZPE6p93H9f4nbP2vgpIIjOvVVaEKwys+CHXxL4AOY1kI9HOANn8gLWhvl4GFavp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6eSHRN4AnvgUe/EXUCE8leEcPtm8wyMUKUw5PmHp9+iR3/8zz
	EuUOjmS1Co9Mswdqe51As+lPqfuCnMGMqXAMktuGSxVPLdXOHbICt9KHyna+DnmjPXksw8Al8+4
	Gb0D1/AP+dca1euOZMW2TZOaVcDF8gubgnGchP4Bx
X-Gm-Gg: AR+sD11zlX+anA/bOks4E4fWzjX4sFb5ReGR1M/zdUqJkmTWYaoSbIOz7usx16RIxz5
	Zk649qIl/dJa0a3K4u4nYfachWv1HnpJvAeodSPPxyugX/L0taI2C6fN6qioDybetBnLokrYRbv
	u3jimIMbWyzP35ksjJ/fkv9OOgJCostEyhNCB/dU5G0ObOMPB9cOkM0Nr9NF3XlKnl4xaLQDSV3
	cBjUVwIeBZGRUsXArK+IjDnjUgCjrutpM0B9bokQYavo2c9/Afllzr/DX0tYkfHOaFxn1txYD/S
	0NBIsfXrMN7xF5+easu6dL9EoOoe+/yCRpk7uTOkHNfpI1Gd9dZtfWDe9t0EjXVM62e6SuYhdA=
	=
X-Received: by 2002:a05:622a:190c:b0:517:5d71:84e5 with SMTP id
 d75a77b69052e-52d580d6162mr12122271cf.5.1786462570992; Tue, 11 Aug 2026
 08:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810093955.153015-1-hao.ge@linux.dev> <20260810205251.3fce0ec86ee20925fd577c26@linux-foundation.org>
In-Reply-To: <20260810205251.3fce0ec86ee20925fd577c26@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 11 Aug 2026 08:35:59 -0700
X-Gm-Features: AUfX_mxmFUMMJNxASySaJAk1Wiidb9lbuMMRd31WwigRad3YmpinKxeeQ1tv5kQ
Message-ID: <CAJuCfpFRWcjB2MwVUS0j9=yFRDLWZdumovBoBi-xkwGW+y2Viw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] alloc_tag: fix undetected compressed tag overflow
 when profiling is disabled
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Ge <hao.ge@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 8:52=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 10 Aug 2026 17:39:53 +0800 Hao Ge <hao.ge@linux.dev> wrote:
>
> > v3 was a single patch. After discussion with Suren and Andrew we went
> > for a more graceful approach: rather than failing the module load on
> > overflow, let it load without profiling. Once profiling is disabled,
> > codetag_needs_module_section() returns false, so on retry the codetag
> > section is placed as regular module data.
> >
> > A new patch (1/2) is added to move release_module_tags() above
> > reserve_module_tags(), since the overflow path now has to call it and
> > the helper sits below it.
>
> Thing is, [2/2] has cc:stable but it requires [1/2] to be able to be
> compiled.  [1/2] doesn't have cc:stable so we're asking -stable folks
> to backport a patch which doesn't compile.
>
> Resolve this by using the same Fixes: and cc:stable in both patches.
>
> > release_module_tags() is what module unload calls to drop a module's
> > reservation from the maple tree. By the time reserve_module_tags()
> > detects the overflow it has already stored that reservation, and the
> > -EAGAIN return skips vm_module_tags_populate(), so the backing pages
> > never get mapped. If reserve_module_tags() returns without calling
> > release_module_tags(), the stale entry keeps pointing at that unmapped
> > range; when the module is later unloaded, release_module_tags() walks
> > it and panics.
>
> AI review had a lot to say about this patchset.  Some pre-existing, some
> not:
>         https://sashiko.dev/#/patchset/20260810093955.153015-1-hao.ge@lin=
ux.dev

Yeah, some of them are not related to this change but at least one does.
I need to address the unrelated ones. Will do that as a separate patchset.

>
>
>
> offtopic: alloc_tag isn't getting allmodconfig build coverage at this
> time because:
>
> 1: MEM_ALLOC_PROFILING depends on !DEBUG_FORCE_WEAK_PER_CPU (why?  I
>    can't figure that out)

DEBUG_FORCE_WEAK_PER_CPU forces weak percpu definitions everywhere,
even in the core kernel. This introduces the restriction of [1]:

2. Static percpu variables cannot be defined inside a function.

Memory allocation profiling relies on percpu variables inside a
function in DEFINE_ALLOC_TAG(). For
CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU we comporomise by accounting all
module allocations to a statically defined _shared_alloc_tag (see [2])
but we can't do that for all kernel allocations because profiling
becomes quite meaningless at that point (all allocations being
accounted in the same counter is not useful).

[1] https://elixir.bootlin.com/linux/v7.2-rc6/source/include/linux/percpu-d=
efs.h#L64
[2]  https://elixir.bootlin.com/linux/v7.2-rc6/source/include/linux/alloc_t=
ag.h#L91

>
> 2: x86_64 allmodconfig enables DEBUG_FORCE_WEAK_PER_CPU, despite it
>    being for s390 and alpha.  In fact it might be alpha-only.
>
> Adding
>
>         depends on ALPHA || S390
>
> in there fixes this.
