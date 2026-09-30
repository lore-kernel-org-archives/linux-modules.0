Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEBB32B99F
	for <linux-modules@vger.kernel.org>; Wed, 30 Sep 2026 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757257; cv=none; b=Mstxa+08iWGPmwmam3lkaLrjBFqjPx87WlJi46yy7d9VF3VC+D5HrJ+h9YMovFkWlWZ3NWGpXkQWNnjZzP173FY1wCq8M0q6A4alu8wjpgjDckfLmjP8YCeuVhJDfzqA+xmXXJFvghS6ykLYqBIk3/+D+RBrYhjU9sDYr0m8Nn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757257; c=relaxed/simple;
	bh=pmdUtLHiDBYPwdKz6lOBEihhJVlCk8853EgW8s9fCWc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6Pg+KXGa+7UbzXvVDWbXGV26tz6SlzoSvBuKcfwRAkj2pw4RVQaVWhAdX0BTR+tUEzmxyc9/MIK4aENBuS+2vAQ7NM0XzzPaceRivnI5wGoj9H4NsplbYULX5BDlGqiFkk1tAr+xAML0UnSaqMQ1Kp/6srVaoBAn429cg7rq+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7KGKPAX; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7KGKPAX"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so782412366b.0
        for <linux-modules@vger.kernel.org>; Wed, 30 Sep 2026 01:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790757247; x=1791362047; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uQBLg1lOxnEKgr89MFlKuWhU+DKGispKKqyorNYQTaM=;
        b=i7KGKPAXmt+ZuptqaIzfIC3G6alJDnPdCO+Iy+N9tGHabaik0MKSu9XENv3X6z9nbi
         hthoqZ5J9eZi/sXH42cZsOpzE0tpcaxB6Q2aZwm2nsmWn0lTA9Am6Z7NtBO7mTRI0tBh
         A1Q8yqlOyK0YbpcsEl/3jiASAWVRVj2fdqAriZE9lmoUMbbrTqAFb3hF5F19j+NqYMiM
         sxZ+pCLJnoa/q39n4UefNPrsqjao3vwl2ori7MIUzj2vUpCJbSyKoxZuM8aQMocKimqF
         0H15Umgwf51PcgyWyroXUUlVCJjba6ERy50K2CvQ9I7vFE6U/f88AAZIqZIo3RGgCbh7
         ewUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790757247; x=1791362047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uQBLg1lOxnEKgr89MFlKuWhU+DKGispKKqyorNYQTaM=;
        b=VTUVCZcPhP13FqbnRp9r4IlrDemeY/OR3hdnnxW/0VT+y5jbibXQtPZwU4oHPBaQJE
         QhsS9bMsCC2uemIXz/EWDnoY4b2Fch80RI40eroJ14H1kuHP+qcv7kYBFMItzCf2ya7v
         UyFFexwQzdYdQPIax/JA+gGka61wdtqCafHnDYoSzR6UufScn2GzuHHkRwvq3zN8fn2v
         mcSh9V4DGyT1Y7zhdj14mTrjrT6ouN94/RhhPgtp9rsJlu+f+ibaIxCKQJzUw9xrKCBy
         WVuVG3pPDE1FlGvTh/gu9W4leeoo5pnYRGlQS51qidmAUhfhVySF5OMaae9Rr40sMAJS
         bJHw==
X-Forwarded-Encrypted: i=1; AKwUvBx+8SOe1vgLB3ET6PPv8evpKr0pBh+Lj9J4maWhfE3PdAVu5fYf8e7AJf+rG4M+0olUG+Ytxcpq9yj4L+iA@vger.kernel.org
X-Gm-Message-State: AFq9FYKF7Hv99+BtLlUbhSB9iOyFTZ56E4hPcNVr/vEkozmv8J11loO3
	dxDxzkuvS0YPnryghAOdAuhUfKNvVOcaoiUCtQvq/OzEwciVVgmSpA0t
X-Gm-Gg: AYBFou30Rt27ypX2TwrU0AYI4Gt7fVEGddbRkitCqvdv1mRQwD47vepCqZIZ+MYPa4M
	l6Pxmwu13RrWGaxZdbmpgam9qmQWJ/Tl2L2uDkwn5WO4R//rdUMNx6SxLyVYb7K+Pvdv+nD2n5o
	9V5FumNshSgFVPvsSj3dcFEjzkSrWifZPyV3ui+FYaGHnjcSSx1oW7D0HvFSaf2fVPm9QwrCWAU
	79tKqyCD23MxyfcDJIUuV1li42PLGO07ueV0JTsZz4JezhnNSy6HAG/YhHy933RGKkmt3rZxCom
	iJQpd+RibvFASH8O6Km4pegD2yQbfcTLjqnSKssIKVhOEirILJS3xBoDwPm/0IIEJtsg4cK98XQ
	Ai5ayKlTbIfiiXzg5V4HmmmYIoaQAB0cByc7mNbIzKqXPaA+TAz3SdXtP7578qXJNBbzbYZzd3H
	N/NCuiVo/2fuTOX9VvN2dBptzM7AAKT21tGXBH
X-Received: by 2002:a17:907:3f18:b0:c2d:d89d:346a with SMTP id a640c23a62f3a-c2e23663b74mr51705266b.3.1790757246934;
        Wed, 30 Sep 2026 01:34:06 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e22fa41e8sm27570366b.55.2026.09.30.01.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:34:06 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 30 Sep 2026 10:34:03 +0200
To: Hao Ge <hao.ge@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH v11 0/7] alloc_tag and module codetag section fixes
Message-ID: <arzJez4VNWEVnXiF@milan>
References: <20260929082014.160587-1-hao.ge@linux.dev>
 <20260929134401.a1a385ff4369661f879b5d2f@linux-foundation.org>
 <CAJuCfpFRW3uNUW_VrjpOfLwS1LBHqGEpqK3yBTPSpGOORY5jiQ@mail.gmail.com>
 <fc4f3d08-393f-43ed-934b-e7e1ba6d0137@linux.dev>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc4f3d08-393f-43ed-934b-e7e1ba6d0137@linux.dev>

On Wed, Sep 30, 2026 at 11:26:41AM +0800, Hao Ge wrote:
> Hi Suren and Andrew
> 
> 
> On 2026/9/30 10:39, Suren Baghdasaryan wrote:
> > On Tue, Sep 29, 2026 at 8:44 PM Andrew Morton <akpm@linux-foundation.org> wrote:
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
> Agreed. Patch #2 was added to this patch series because vm_module_tags_populate
> suffers from the same issue. If we want to be more conservative, I'd prefer to keep
> vm_module_tags_populate as it was in V10:
> https://lore.kernel.org/all/20260915070001.113559-3-hao.ge@linux.dev/
> 
> Then we can submit a fix for __GFP_NOFAIL retry loop in __vmalloc_area_node() as a hotfix together
> with our new patch #2. While at it, we can also check if there are any unnecessary calls to
> vunmap_range family functions that can be cleaned up now that patch #2 is applied.
> 
Yep, this should be a separate fix for vmalloc.

--
Uladzislau Rezki
