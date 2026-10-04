Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B5F477292
	for <linux-modules@vger.kernel.org>; Sun,  4 Oct 2026 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791139091; cv=pass; b=SvEWvS/THB7tXdOXxbB6M09MbfBfBPdrfF1S0LI9XZvibEAtRGZ0SUfDwPTC8LgK17JESYdzyM7Ibh9odqnuLcgYS0r8vaEtVaHCbO1n/iEpxmudDzFS69gy4hHrXbB2U7ngeumXxpEiGfHcjQHe4ueDdfVqAWnl9Ies7YQ6Sbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791139091; c=relaxed/simple;
	bh=czHf1y5s0XiTKD3HwlV6gqG6rPLD25IXCbNXKX3jGrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbIJzhg6SernBI0bsD0jf7x217PaALTpDvn6AtMrKrBWh3hu8m6lrT90q7pBT130eTSkkfS8EvzosHZSD6Rh6AjAnjTXguSnYEpcAahdvuuO11lIp28neqYOfEpiEdsfPG9u2lhZdhp/JLXyOTLMtVfyHvMNlxySxd4fmF7SNf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cUgA/H2U; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUgA/H2U"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5337c7b9937so265301cf.0
        for <linux-modules@vger.kernel.org>; Sun, 04 Oct 2026 11:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791139088; cv=none;
        d=google.com; s=arc-20260327;
        b=n1f60G4DTauQWJV+y1uk1mgwy3/3HZaLft5e5CeKrVfMnRuYxaltu0IMdztINgv8Iu
         owmy5v/X0g29soBdlHb1g46a0gCORkKcFP1rp0qn9++DMDaSoWZd6WNIweS99EKF0P56
         yBPtLwUTMIIO5kHskVe6+BAg29ihownoGkZI8nsFd6MJFWnRJNm7A14uuVeBu/hAITD9
         WXdT/8dHRgCdKXS5Fk1d0wd1sz0cKke5Rv8Pcyplc00B2RUyrqRhO/aP0RnCqeZSvNG6
         O5X9U5kSy1EjYp+vuXzXTlIWdGetFguzP6lU3FVFcTBZArlK79vYypdBuGJVH1nMTLNU
         rdyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4c7dYjrT6sZNHYJQlTA+JnOu2XHVq9WNP85b0Iivahw=;
        fh=e1ESbJ6Io5Sdlid4Xyt9bme3Z6RAq/VZbDOxXVCyXoM=;
        b=ZtV9XAuU3YlkgVyb+NjfWnR1F3qsIwTDxe3g4GWiBMpOWWi2OwqCjv3hsIHyBD5AJm
         Zl12FRR/WhRKoinM+NWMsgKWW07t/RptDWpZFHFE5YhJ+lSGHRl5udlbWjz8BTIPM52Z
         iY+ifUsEOK5OKHO7qyqKSj4MyYtDzvqLR98L77TubOIlDAisLcLGgpzgzc2FYuGzTTz/
         wkApd9RrmdcJhh4BZDX++JRUglJvNsI95kuAaOJRA7bAAeqO+xEv6hScT/icE0agc4rv
         0G2HtAC8j/hHTiqVqwEwTNCSxn1pSXaCB721Vke9Dth4j2+sm1/usr4MFcf5UOsFySf8
         S0Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791139088; x=1791743888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4c7dYjrT6sZNHYJQlTA+JnOu2XHVq9WNP85b0Iivahw=;
        b=cUgA/H2UGYjty5o+6+XxOm/pWmTA1x+NpJxEjouio3RqmFvE5jBaLDRh8hzE77DDe6
         gIaHAWWp37fgVb9W0DH93Ka/t+R95qpqUehK4s+5PIF0gsC4RlzulW4ijRW9G6HPRAc1
         4u3d6X26e+ZYAzJ23yP14GHWFtQnG59Lk4CQUSgpz9+5UNwDQWlCkrdviru7HB/CpWj+
         vUeZuCO8u4f7BuCfSA533lzfDtFL00p0ISt6uwz0C9TrPRw5NbSsuF8WdY5Yh81Aw7U4
         8IWko+WPfdnWGjVKONtU81hsKnC95i/qLSq4aSd5WQBXI03GZSAwuffUVOuLeTpLdK6m
         5TWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791139088; x=1791743888;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4c7dYjrT6sZNHYJQlTA+JnOu2XHVq9WNP85b0Iivahw=;
        b=Cm0S7OoFgq6ENXxdBnir6fILI8tD8cBTFwuw5jlmqgsbO/kpxpgMONBgJwqjVCpkAQ
         R25ygwgLr2nBnxrzW3zdwsIxK9hNTANdhy/avD1yyKjMVhawVg+X3zEskXsjncjgbfuT
         Uyi+6MjlRrwql3Ztt5+ib2f7GXCi96OES0wR916C1VNhhSOYXInOAaBS8kFTGYFz3CS7
         g1dw1s0wuJaJSEXAjlrCYkrZtNsDCFHI1Wd5pU7Wr+wriZR4dyIGlzBZd2Wo3JFJh8HJ
         DAWqX+zdhBnnwAHe7w+TRWeY8ROeMvLkWVSQXY9z8fKbrz2yJZ8VAq+bF7Gacg1yaM+0
         Uw8g==
X-Forwarded-Encrypted: i=1; AKwUvByp0RNqN0J0mjFxUzF2JXiZWtNrqfufgf3n8JYBQ9UP0pVsEB3+hKhzO5dTfmKiqI2eU43zdzYOd4dAPmnk@vger.kernel.org
X-Gm-Message-State: AFuF++mXQ/xIiQk/Q5zGtw0pQUYe4VJJ3Cvhyxjyzdw33e7VVXPQhLrS
	3TwSYSmLpnurzUhS6Tltuq02ajW37z65YIXHCyJZrhEDd8d47OQh+rfefzIxU1BHy6yRFIcgnkr
	9nz4ttsz+1iZ1FPMqBeKPoblwOMCPoLzwOSKzF1Qb
X-Gm-Gg: AYBFou3wYdJTBvrOW/T4xP5JOHemadg1VE6so25C7VOn7KlFXaGWlDrwzcwSxS4bMWO
	5OpDLWTXYPq7W4KC3YGgPG0bSochPDeT1OLZtdAp0RgVWrhwk8ayZwqkHYJj9/3Fb9pWBEnkyHO
	NAu3I4bBkmrgur3xlb5D3/Do1/bL2BIHAbqTuYKgBia3v7TEdeyD3ADl+l0osK5Ri/QmadoQnTX
	Rcsw5LqBHwNa4iOzYgUu7GbY69e32j/m847qjS0n+VpJseF3syfMZKWEyn4fJMYPn4Hnl4nHD9m
	h+jxgVJI4k8Bb3ORTVyROaq/uiPQCxWUxpXqyCoxfF18pmlrIIYl9OOT
X-Received: by 2002:a05:622a:5984:b0:532:858d:e791 with SMTP id
 d75a77b69052e-535131b5a91mr17889301cf.8.1791139087466; Sun, 04 Oct 2026
 11:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929082014.160587-1-hao.ge@linux.dev> <20260929134401.a1a385ff4369661f879b5d2f@linux-foundation.org>
 <CAJuCfpFRW3uNUW_VrjpOfLwS1LBHqGEpqK3yBTPSpGOORY5jiQ@mail.gmail.com> <fc4f3d08-393f-43ed-934b-e7e1ba6d0137@linux.dev>
In-Reply-To: <fc4f3d08-393f-43ed-934b-e7e1ba6d0137@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 20:37:54 +0200
X-Gm-Features: AclHuK-tgnRy3c8tRpdQgoIviLT7ezLMAJcWRyqSp8rv6XK6Qm-JduLkT1yGnnc
Message-ID: <CAJuCfpGAZUcQnursYh=rvp+EzckvDmXX_KveJvEuyjzzG=9mww@mail.gmail.com>
Subject: Re: [PATCH v11 0/7] alloc_tag and module codetag section fixes
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 5:25=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren and Andrew
>
>
> On 2026/9/30 10:39, Suren Baghdasaryan wrote:
> > On Tue, Sep 29, 2026 at 8:44=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> >>
> >> On Tue, 29 Sep 2026 16:20:07 +0800 Hao Ge <hao.ge@linux.dev> wrote:
> >>
> >>> With profiling toggled off, the overflow check in
> >>> reserve_module_tags() did not run, a module could load with more
> >>> tags than the page flags can address, and re-enabling profiling
> >>> then silently corrupted /proc/allocinfo. On overflow the fix shuts
> >>> profiling down, releases the reservation and returns -EAGAIN, and
> >>> the codetag section lands as regular module data in the same load,
> >>> so the module loads without profiling.
> >>>
> >>> Review of the earlier series by Sashiko turned up more problems.
> >>>
> >>> One is a race. layout_sections() and move_module() both asked
> >>> codetag_needs_module_section() where a codetag section goes, and
> >>> mem_profiling_support can change between the two calls, for instance
> >>> when another module load overflows the tag index and shuts profiling
> >>> down. move_module() then copied the codetag section to offset 0 of
> >>> its regular destination and clobbered the first section placed in
> >>> that region.
> >>>
> >>> v7 reworks where codetag sections are allocated, on a prototype by
> >>> Petr Pavlu [1]. The allocation runs before layout_sections() and the
> >>> placement is decided in one step, so nothing re-asks the question
> >>> and the race is gone. The retry is gone too, on -EAGAIN the section
> >>> is laid out as regular module data right in the same load.
> >>
> >> Thanks.
> >>
> >> Seven patches, all cc:stable.  Why is a backport proposed?
> >> Documentation/process/stable-kernel-rules.rst gives guidelines - does
> >> this series meet them?  Does Suren have thoughts?
>
> Thanks, I've just gone through this carefully.
>
> >
> > I think vmalloc fix in patch#2 should be posted separately and clearly
> > quialifies for backporting as if fixes issues Hao found at [1].
>
> Agreed. Patch #2 was added to this patch series because vm_module_tags_po=
pulate
> suffers from the same issue. If we want to be more conservative, I'd pref=
er to keep
> vm_module_tags_populate as it was in V10:
> https://lore.kernel.org/all/20260915070001.113559-3-hao.ge@linux.dev/

I disagree with this approach. That means we are introducing an extra
code inside vm_module_tags_populate() only to clean it up later.
Instead please post Patch #2 separately. That posting should have your
current patch that changes vmap_pages_xxx() to clean up on failure,
followed by patch(es) which remove unnecessary cleanup that some
functions currently perform by themselves. This patchset should
definitely be tagged for stable.
Once that patchset is accepted, the rest of your current patchset
fixing alloc_tags can be posted with correct assumption that
vmap_pages_range() cleans up its partial mapping when it fails.

I know this sequence will take longer to upstream but I think it's the
right way to go.

>
> Then we can submit a fix for __GFP_NOFAIL retry loop in __vmalloc_area_no=
de() as a hotfix together
> with our new patch #2. While at it, we can also check if there are any un=
necessary calls to
> vunmap_range family functions that can be cleaned up now that patch #2 is=
 applied.
>
>
> >
> > The rest are also bug fixes but their size is concerning. I'll review
> > them first before advising on which ones should be backported. Some
> > fixes address issues that happen very rarely and if a fix is too
> > complex it might make sense to leave it be or fix it some other way
> > with less churn. Please give me a couple of days to review them. With
> > the upcoming LPC I'm trying to multiplex between several projects.
>
> Thanks, sorry for all the hassle on you folks.
>
> Thanks
> Best Regards
> Hao
>
> >
> > [1] https://lore.kernel.org/all/b8005c24-ecac-45c4-840a-fd282f9693b5@li=
nux.dev/
> >
> >>
> >> Also, Sashiko has been busy again:
> >>         https://sashiko.dev/#/patchset/20260929082014.160587-1-hao.ge@=
linux.dev
