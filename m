Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B59B3D8121;
	Tue, 29 Sep 2026 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790714644; cv=none; b=rKWM+AbsS7ba1NRCZIeruhJ4V17imzzmnVvVy0U7iZGLco9wclyPGwX2OdzLDZDx5LH0VUxRA3uXrbwMX7wQAqL662vOIGsb01sHAJpj/K8RiWJ3uX9YDeFYw0iMm/B3lk8yG7ZcFI+r3pqiO8AIDqW/jF3jcj54fC3oO4kL9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790714644; c=relaxed/simple;
	bh=9NWcm8Wym6yVVjfrHKdIqGkoicNRi2SLMVsPY4JpWpQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M3Al+cY/eCeg2XAWWucD9ATm43T84GuaGB6ZkSf3U5PmudoiyTGTRJ5UZ5LNr0RavqLJ5Jb/dBvKBITAbDObX+SCv6SCtFLHYxJIQ85j59K6hxK7oKxIJTogHWrB6CxeZvZvP3EUDlhpqjOZ4VJJhF5R1QFVRE5Mz5ru2yH7Ly4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NxiPSC9/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NxiPSC9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4661F000FF;
	Tue, 29 Sep 2026 20:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790714642;
	bh=Zz0B4XqWsy+qxFaMtyX0F1BfNEcbPkUQ0oH+i88JnoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NxiPSC9/iQaxEFIjneAiZnd5hzZTUgHlU5t4CE+9Sv378x0oBHn4Zyglt9rebVyHY
	 BsUkxmue92FcpicBaQWtw43kNGn0PuXIGAaTcbDK1qgHJV2y05+HMSv846F96Sxe4t
	 OLhsm+NoWgddAAa2O7M6fcIr0nL0AtUMfBvyxEZA=
Date: Tue, 29 Sep 2026 13:44:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, =Kent Overstreet
 <kent.overstreet@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, Petr
 Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman
 <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com
Subject: Re: [PATCH v11 0/7] alloc_tag and module codetag section fixes
Message-Id: <20260929134401.a1a385ff4369661f879b5d2f@linux-foundation.org>
In-Reply-To: <20260929082014.160587-1-hao.ge@linux.dev>
References: <20260929082014.160587-1-hao.ge@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 16:20:07 +0800 Hao Ge <hao.ge@linux.dev> wrote:

> With profiling toggled off, the overflow check in
> reserve_module_tags() did not run, a module could load with more
> tags than the page flags can address, and re-enabling profiling
> then silently corrupted /proc/allocinfo. On overflow the fix shuts
> profiling down, releases the reservation and returns -EAGAIN, and
> the codetag section lands as regular module data in the same load,
> so the module loads without profiling.
> 
> Review of the earlier series by Sashiko turned up more problems.
> 
> One is a race. layout_sections() and move_module() both asked
> codetag_needs_module_section() where a codetag section goes, and
> mem_profiling_support can change between the two calls, for instance
> when another module load overflows the tag index and shuts profiling
> down. move_module() then copied the codetag section to offset 0 of
> its regular destination and clobbered the first section placed in
> that region.
> 
> v7 reworks where codetag sections are allocated, on a prototype by
> Petr Pavlu [1]. The allocation runs before layout_sections() and the
> placement is decided in one step, so nothing re-asks the question
> and the race is gone. The retry is gone too, on -EAGAIN the section
> is laid out as regular module data right in the same load.

Thanks.

Seven patches, all cc:stable.  Why is a backport proposed? 
Documentation/process/stable-kernel-rules.rst gives guidelines - does
this series meet them?  Does Suren have thoughts?

Also, Sashiko has been busy again:
	https://sashiko.dev/#/patchset/20260929082014.160587-1-hao.ge@linux.dev
