Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E91237180;
	Tue, 11 Aug 2026 03:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786420373; cv=none; b=V5jSJxE14RC19DCjvqE409pMvldjzTCA4aPB2l5xN1DV3AOtJJ7WIi4AQPBVzyisuJVgxjPW8b3sPcWSo6FHqlr34YCY1lQTZWJpzo0/x5ku6ZL0COQNSD6pT7oZ5A9vHbyxc2prjHj2hXRUP1ly2tul5qIBkky3RjgiVQBuKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786420373; c=relaxed/simple;
	bh=SIcrw8jz2TL5YSgaZdCMeOaKYAkUvmKaAujnQyj/r0Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nLqXgMnmCpLm+rGkTlbIP5iVmdsONrRNKjoELwU1yHLVADIpREioIuA530ibZqfl/zXcUfRjCAQYM1IKt4CDADXlY6MyknKo7SZNwCXFFtN4MaLgnHk7+SWR2Ag9cHaELPi9/TZ7URgA2WLxJlm/XfFZaq0V+72shn06csOu5OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DaEru8YP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DaEru8YP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900151F000E9;
	Tue, 11 Aug 2026 03:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786420371;
	bh=tQ8MTXU7PXH/k046gdgNu+2KYPZDiwOczpAepdH9QcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DaEru8YPOYGZZ6RTXqtSimMxPDe90BY2dH0YrIJI1Y6AP6qOdJn23xuERg9ByK+n0
	 jj/KDEDzHxxC69nBa8lwtpHndN0ygmu1lIdEuA2mtnKgm1pRfGsnHE5UpLPdlEgILn
	 bN+aN/0bFsp8KhGmm08kgcSaiq+B8P2IqQcE0eZQ=
Date: Mon, 10 Aug 2026 20:52:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez
 <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron
 Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 0/2] alloc_tag: fix undetected compressed tag
 overflow when profiling is disabled
Message-Id: <20260810205251.3fce0ec86ee20925fd577c26@linux-foundation.org>
In-Reply-To: <20260810093955.153015-1-hao.ge@linux.dev>
References: <20260810093955.153015-1-hao.ge@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 17:39:53 +0800 Hao Ge <hao.ge@linux.dev> wrote:

> v3 was a single patch. After discussion with Suren and Andrew we went
> for a more graceful approach: rather than failing the module load on
> overflow, let it load without profiling. Once profiling is disabled,
> codetag_needs_module_section() returns false, so on retry the codetag
> section is placed as regular module data.
> 
> A new patch (1/2) is added to move release_module_tags() above
> reserve_module_tags(), since the overflow path now has to call it and
> the helper sits below it.

Thing is, [2/2] has cc:stable but it requires [1/2] to be able to be
compiled.  [1/2] doesn't have cc:stable so we're asking -stable folks
to backport a patch which doesn't compile.

Resolve this by using the same Fixes: and cc:stable in both patches.

> release_module_tags() is what module unload calls to drop a module's
> reservation from the maple tree. By the time reserve_module_tags()
> detects the overflow it has already stored that reservation, and the
> -EAGAIN return skips vm_module_tags_populate(), so the backing pages
> never get mapped. If reserve_module_tags() returns without calling
> release_module_tags(), the stale entry keeps pointing at that unmapped
> range; when the module is later unloaded, release_module_tags() walks
> it and panics.

AI review had a lot to say about this patchset.  Some pre-existing, some
not:
	https://sashiko.dev/#/patchset/20260810093955.153015-1-hao.ge@linux.dev



offtopic: alloc_tag isn't getting allmodconfig build coverage at this
time because:

1: MEM_ALLOC_PROFILING depends on !DEBUG_FORCE_WEAK_PER_CPU (why?  I
   can't figure that out)

2: x86_64 allmodconfig enables DEBUG_FORCE_WEAK_PER_CPU, despite it
   being for s390 and alpha.  In fact it might be alpha-only.

Adding

	depends on ALPHA || S390

in there fixes this.
