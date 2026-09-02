Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FED537BE6A;
	Wed,  2 Sep 2026 22:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788386707; cv=none; b=OQVOFkp853Dg+33v9DhGgRbMhE6uiXfMtEIPkF7MbfSxZ5FqUfgyGei5XlqPgaoOmhf7tjJ7iZ6VAxarFWBS9b9saFDq5VIQrPT4vrpCgBm8EczpgqL91tVNvtIwXAAqgEdg0/n7MZ+dpDVnjTIZsTjugNL3Zu/CmFo2SxT/aws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788386707; c=relaxed/simple;
	bh=3prdQ3Nue1CX4GrTl25sh0gxDAsAU18h3IQal4/rPGs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eKpjWipTJoiBp1erAgrJdX/uQTTjxgftXeYU1Zjl8Tsp7qOyIBUa5afnIdxZVU4s/rSRjD0bRmZRiPz9lXV3k/et1LvgnIZRzEIoxlWfG+3a1RBH7FWPitFQEExATOJxAGX/+6BvN68hjiLt+j7OiKPgP0C/adS8+MRmZ5neUT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NvdhBAgb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NvdhBAgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB681F000E9;
	Wed,  2 Sep 2026 22:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788386702;
	bh=q10ap3BJjJmXb1B2/mUS9+xzKZ0SLxvApYs4zp88+e8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NvdhBAgbgO6F3L6t0gQuYc0SqaEJhHiwXKzF/hHQiK9xpKZ3bv64aofAX8OqJvWoa
	 nwXT23Hi2LTwfMTAi89Db3NSklOK6zLHYREM8rTDie69CHVqLePeYIu1ZqSud8DEmZ
	 /ELfN7dp4BsyH7DYmey93odUsZTGAfoF8co7mRxw=
Date: Wed, 2 Sep 2026 15:05:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Suren
 Baghdasaryan <surenb@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 0/4] alloc_tag and module codetag section fixes
Message-Id: <20260902150501.d589742ba33d0beeb0cdb21f@linux-foundation.org>
In-Reply-To: <20260902081802.146145-1-hao.ge@linux.dev>
References: <20260902081802.146145-1-hao.ge@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Sep 2026 16:17:58 +0800 Hao Ge <hao.ge@linux.dev> wrote:

> I ran into an overflow problem in the module tag area. With profiling
> toggled off, the overflow check in reserve_module_tags() did not
> run, a module could load with more tags than the page flags can
> address, and re-enabling profiling then silently corrupted
> /proc/allocinfo. On overflow the fix shuts profiling down, releases
> the reservation and returns -EAGAIN, and the codetag section lands
> as regular module data in the same load, so the module loads without
> profiling.
> 
> Review of the earlier series by Sashiko turned up two more problems.

Thanks.  Sashiko had a lot more to say, as I assume you've seen:
	https://sashiko.dev/#/patchset/20260902081802.146145-1-hao.ge@linux.dev

Also, "Based-on-a-patch-by:" isn't a recognized thing, although it's
been used ~30 times in the past.

I'm ambivalent about ad-hoc invention of new tags, although it happens
a lot.  Perhaps it would be better to do


	Based on a patch by Petr Pavlu [1].
	...
	Link: ... [1]

?
