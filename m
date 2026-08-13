Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF33243F4B3
	for <linux-modules@vger.kernel.org>; Thu, 13 Aug 2026 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615076; cv=none; b=Vbfu9nKd1v8JkkhpfZakOVTrBHx2/oZJ+wRRrmWmxnzgYx70YB/86mDxmgTa34eF9rAXAQzIUhdEGY1F76/yxu46BDXWwbQpc7RRoch50BzzPVkLOMVqoy7qsfsNpfMDhXDJgwIh1NlSSzgug3hrypJK3blPHhLQvJ/qAef0DD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615076; c=relaxed/simple;
	bh=PspiG0ufW/4bsWiTBCVUzXWFrW4kGI6F2SLQ1xEQzUo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cff8DQpqqbpPHuOU7y6t95sdfzopDKS7FNJQeZV9ri5lB7D5TT1uJqHhel+I84BOJUaPCGW5E8gquQEdbic3G615ozSg8J/MtCy7UW2mXXFEDKezt3hZ/0HTNEshdJJ+JyzEEGMZmYn+g7pLLAQc2QMqTvkJQQnqjvHPI6Zh0R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj8kobcc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj8kobcc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1871F000E9;
	Thu, 13 Aug 2026 09:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786615074;
	bh=kgRj2S+ZSR9iNwXG2JiEeJ5z7F/yqQy0+APe1vn37wA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oj8kobccx74gpqUSMVR/ogbeMOPi39EdURNgzfZC4VpXhJIMjSXrFBKgENVE36yKF
	 RrTq3XrczUNCv+3SZ0xE+b5iTSVXxdu4u9f4/qk6hW+XGVAThYd9jZrRYA0AwRjjr/
	 JgSgyCGgZRFEChUa4sVslMX4yis3JiRdkL/Z/veaK5Ro3HQRnRvbwy8EZ6vNowC5KW
	 LYGwkwb82sb7XVjZ1jM0Rur3BC1160DtqLuwZ1qzeaUQjzhPynCv+Ut3U/NMBiyHaJ
	 XuwLLuWvaBnLSdb8HdZyJqYnTsrzpS3oLrImF5+2AIbI4DiX50Z+Aci207AB88u/UZ
	 BsK4IflVRYCWA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] alloc_tag: remove /proc/allocinfo outside of
 mod_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260813093421.135230-4-hao.ge@linux.dev>
References: <20260813093421.135230-1-hao.ge@linux.dev>
 <20260813093421.135230-4-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 09:57:53 +0000
Message-Id: <20260813095754.5B1871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] TOCTOU race in sysctl handler allows memory profiling to remain ac=
tive without support structures.
--

--- Patch [3]: [RFC PATCH 3/3] alloc_tag: remove /proc/allocinfo outside of=
 mod_lock ---
commit 8d4c5cdeb441b4a47f3511f205a68485820706b0
Author: Hao Ge <hao.ge@linux.dev>

alloc_tag: remove /proc/allocinfo outside of mod_lock

shutdown_mem_profiling() calls remove_proc_entry() from
reserve_module_tags(), which runs under mod_lock held for write.
remove_proc_entry() waits for readers, and a reader takes mod_lock for
read in allocinfo_start(). Move remove_proc_entry() to a workqueue.

> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 26c6ebc96a6ae..65d0ae9af94b2 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c

[ ... ]

> @@ -600,7 +607,7 @@ static void shutdown_mem_profiling(bool remove_file)
>  		return;
> =20
>  	if (remove_file)
> -		remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
> +		schedule_work(&remove_allocinfo_work);
>  	mem_profiling_support =3D false;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does shutdown_mem_profiling()
have a TOCTOU race with the sysctl handler proc_mem_profiling_handler()?

If a concurrent module load fails setup and calls shutdown_mem_profiling(),
it disables the static key and sets mem_profiling_support =3D false.

Concurrently, could a sysctl write to /proc/sys/vm/mem_profiling evaluate
mem_profiling_support before it is set to false:

mm/alloc_tag.c:proc_mem_profiling_handler() {
    ...
        if (!mem_profiling_support)
            return -EINVAL;
    }

    return proc_do_static_key(table, write, buffer, lenp, ppos);
}

and then execute proc_do_static_key() after shutdown_mem_profiling() has
finished, errantly re-enabling the static key?

If the static key is enabled but mem_profiling_support is false, any
subsequent module load will skip allocating per-cpu tag counters. When
the new module executes a memory allocation, would alloc_tag_ref_set()
unconditionally dereference a NULL tag->counters?

include/linux/alloc_tag.h:alloc_tag_ref_set() {
    ...
    this_cpu_inc(tag->counters->calls);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813093421.1352=
30-1-hao.ge@linux.dev?part=3D3
