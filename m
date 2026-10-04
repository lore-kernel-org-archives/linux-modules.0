Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3116946EF79
	for <linux-modules@vger.kernel.org>; Sun,  4 Oct 2026 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135762; cv=pass; b=grctbVWMugCasCVljQV73/oIeJul0ffkccXWlUphoTf74adgkI+/ZJF1CNopJGPMxpx7hE61JKCpGakR4C3OoCn6jSExzMcZAztHaYoQzTBWYicaXLWf35uZ8lgQPu9Cr4pTHcddeimlRRYicglWDvTgbqBAaa5wDBGpCmxirvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135762; c=relaxed/simple;
	bh=sxMMTuVTEl7CoGLRlL/TJtXt7LLwauyeOGkY4dD4JFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anOR58fi54k1q0dYyHmgy8NyPbOTjbGGsbqi6cYK9jksrEYME01QHj3ueFfqapFoKRkpe1PaJKqKmBTGQqTwnuEKqqedMkLSogHUFazUjBkCnnv3sXHdTlYL8EDhFAsZvLi3f/4TrkMwSNZOxISALXkwM3mOO9zZ81bL+D66E/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VlvcCLf1; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlvcCLf1"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5351f9dbfe0so95511cf.1
        for <linux-modules@vger.kernel.org>; Sun, 04 Oct 2026 10:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791135760; cv=none;
        d=google.com; s=arc-20260327;
        b=iOCPX/vy94O4rUfiDsBcTUdD7Ep3PxNnrOdUAdUZvcuP0mpBJFMS2BB9MCY3pPMxlj
         vRf7MLtLQgaVyMYwz82oEOdB0ynWYYil7bQGo9KwZtWNElqZJuy7wWThzrS1zG0xu9dy
         U8w6gh0DSvEgS1vmTlIFfGDeyMQTjGM8CGwcmdlyHaGK4DUJJT8QA5RkcqNbwVz+xCuj
         3PNopH5gujTr+B9XbnQo9Q8prS0IZPfROUXNjky98C/O4vyCQ3dBA6nz3ihM4ZsZDrON
         V+vCNZ8j4i6X55LTL8XmjuJFnDArA9IosGHcyizLwR/1Wd/6jQwfonA0VEJVSZJ0IqEu
         /1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uJD53HUZVgIGH/PLRRSHlx0uaJ8NtAGb26BTpZemPvE=;
        fh=Dxhc13FQZvi/HTPUslhTgz4HCpYzJ/UYxt3TwZITbro=;
        b=DMwrs7jo9h6AwOwIdqbWZtxius0XxVQcV9M/I15JTkPEU1noPVtNf8HXqvxVmHKuRp
         WaPWBzHYgzXCH/lsk6AkVb20UqN4ZAjt8pV1jKnLpte11uEqIraAvfBIIAEKtVVCzYqp
         feFokNKgaSfspOGy69/Ft8RxCb6JTYOLQvdfZ1z4rzwdWpFhTZBWhBZ3URlBqytmKF0P
         3Dq2OSITYxpw/jG4DiWTCrxqo7koVpK0bHY/T80Rim9A4EVZSYCrVGLSGxjL3O2nArQB
         y/P9jR7wQehuAloTDkr/TmlamOu0D0m0nNiRXvcdUhjtpzHaxmDm/tDtMOedJp9Xjls1
         doVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791135760; x=1791740560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uJD53HUZVgIGH/PLRRSHlx0uaJ8NtAGb26BTpZemPvE=;
        b=VlvcCLf1N3dvSSmAgsa6tf5hu5NVdIU0dtTA6YOXVHDrelKfE3jzxbw7d7rolxYEc6
         aRoEAiLBBVHRWWc5T1ijCURIG9FWcWM5bB64EnXXbjsCga/Z+obH+xoVkzgC1w8l+dGn
         q2bkmPpoib0UGUttnwfBkXrzWHAjG5sLaqCIMjU6OXidLurUznOvt7C6TWb101WfvP/P
         l5Yjx7Yq8v8CmB7xD3w7NcMTNN3g44sJ6stLs0FzZDjhr7GlaJ05jTWjbTFTl+KnaRyw
         +H+Jud94TsoM97OESrCDK6rojuzAiWfCsYt1hDfJZYACXQ3npe4tXg1hj8ApXASGf2Mk
         DzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791135760; x=1791740560;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJD53HUZVgIGH/PLRRSHlx0uaJ8NtAGb26BTpZemPvE=;
        b=n85cRVTv0lggoj3rxRxd/4kN86JVyzdi3fCYBgzo7T19NiWsNUfb/+vjKQ4pr5K2xY
         lyWvw6TAzVx+5ZuyF0Z2AjYJa8TUxy1fTALVG0+6ffg0R0Wj06mWWDSfKLuhrwwD+Cf0
         TGFjUWouTi2qKs/4ok+W1gIvFIA0pHNlmrvO0s+UM833Xa6PfaKY14fmYX47C9+oUuDa
         cJ9OjDprxGGDVHfsAVTwOoIExxldnyi+CBdGV3UwPeS79gCOiNQaYya4MzS+FvhQf3Qh
         6flBr6uj3OJM6C0q8Mt3pWnADi1wLaIUYhI0a+qOacVEj1tqmM01PeYrbZXp0cgI6fYm
         oNEA==
X-Forwarded-Encrypted: i=1; AKwUvBy5xa1YNwj3+dpQxRwPdSAVW4drrns+SV46M3+cECyEC2Z6l05tkbRF0HWasgblxJM6Jsz7XuBhk6fVIkUu@vger.kernel.org
X-Gm-Message-State: AFuF++mUTLA2VR7gIcck41KL057LOAB/zz/oOZxm5goRitydiVX3bdqG
	9IjpIVTaMnYujEMfVSh9sWOtCo0RPzMTzliBWuZkF88SZtwHP2ILWfxyInWRak6E1wEYclbJFpo
	B7O6xpnXvrUo7e10wCbbPntWYqMCV2GIJ4Znp9mBq
X-Gm-Gg: AYBFou3GAoZd8syYcwSCyx4M103QgQGZvR9AFi8a8gXIE1LGpxMkuMpV7PhH6GD6CHM
	9aWVwCguaHwYUFPe3vk/tU07RTC1yrHvvWIn8Mvp41w5TWgu4OO0jMrSGuhxe6Wbp+hzl4+j7C3
	pPgJ1y9UkkVT5d8IkSBRHG682NKTAIAHci1j5SN3oAKisrdbmSS9t2rUP9ZkCgIzvFQo/oVOlx9
	REC8G5VoYIb9pqEl6ZRPbBdawPO3S8G9vEo2E6OGHe46n+SiBlyLVyvZ8ST2CgkTGlEneDmlipn
	rGPkmCt3uD2y2UME+IT0mBgmtP6EE+Mp0L+0iHAmFoHzA9kg9Vw/MBa0
X-Received: by 2002:a05:622a:488d:b0:533:9746:9a86 with SMTP id
 d75a77b69052e-5351470cf22mr4172291cf.5.1791135759241; Sun, 04 Oct 2026
 10:42:39 -0700 (PDT)
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
Date: Sun, 4 Oct 2026 19:42:27 +0200
X-Gm-Features: AclHuK9bfK0yNJ_n96E9Lm8SQgMCYBLT6Ag9IyToQHJQ0m4bj2apFc6i6aDVObo
Message-ID: <CAJuCfpHXxDXs9w_FkfN0Z98qrtDQXb-=-AhcJMQ66m2W71UqEQ@mail.gmail.com>
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

You have no reasons to be sorry. It's me who is delaying the reviews.


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
