Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45CF2BE639
	for <linux-modules@vger.kernel.org>; Wed,  9 Sep 2026 01:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788916288; cv=none; b=tnkpJapPoPEZsRalq94lOGxxRGZv0pt4N/SU/p0OIQ+oQjfUja4SDDSbUDyx55TxZ1HeLGPe4i3J83l4LjbTqB4EPzdMPCr/n8+mqwyDzAIRuezuwq/mEZQ8O3Mfowfh6ueeC3ehMR39M6jIJO/bEdPTW6aBluUmvcRbD9ODrMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788916288; c=relaxed/simple;
	bh=dilJALZR0Iw2A3dUnlZ2vtBCQGMOGUXA6WHLwwgfRjY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qDxFgLfC6TD9X9TGNk1Ca4xi7KY34dx+4Bdq7+jW1oUC6GIYQIALHgoz2X8j9si0EU90GL6WYb0Il76aDuLrFdFn9E57ZSHZgFh1oa5oVhaT92rp3GAXERiHdRbgmDpEO9hIa7al9LxjM8bvPeqeKC2ieutSPp3YvfQ8451wsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoB8+O37; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoB8+O37"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD781F00A3A;
	Wed,  9 Sep 2026 01:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788916287;
	bh=mp31WL0KaOcLWn0MxHzQy9GIxGIkZrtBQlY0NSQzurs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VoB8+O37fKchUSnj6n85+KeTsfkf6OjA6GQI7UWSKZLUYWwJcXcgW1y+IKnByf8ud
	 ne7g0USkpav8cNrv86vD9fzd+ADEzyLOI9oQL6A2blKcJ6Yq2bF16K65e+VqcqQFNT
	 di//A9DkgMDH0mUTx1Hn9ZuTGV3wtWIA0dQy7XI2Kn5UW/xIF8o0dBy6YczxYiQtPJ
	 3fWfZElCmpols72GFLhjgju77Y7baiDj6A91JmCnf+QC9aezJEX8K0EeyCYVUYN0V8
	 FlpHdst9M2mn9tKJZm89MCT+sBC13ZSHFdvx8pZNjMonjHfCjlOlVDzICMwlLb2kKy
	 KfReFwmoSyQ7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 38/39] dyndbg: add +c flag to count advantage of
 classmaps for DRM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-38-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-38-3a3f621f4a10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:11:27 +0000
Message-Id: <20260909011127.6AD781F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `+c` flag unintentionally triggers heavy logging and side-effe=
cts, and fails to increment the call counter for open-coded `DYNAMIC_DEBUG_=
BRANCH` callers.
- [Medium] The `reset_stats` command parsing in `ddebug_proc_write` silentl=
y drops batched queries, ignores leading whitespace, and falsely matches pa=
rtial commands.
--

commit 02710e8ae9ac8d54e910e1db01d0bb84fea61ee7
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: add +c flag to count advantage of classmaps for DRM

This commit introduces a +c flag to dynamic debug, allowing users to
increment a per-cpu counter when a flagged pr_debug() is called. It also
adds a reset_stats command to /proc/dynamic_debug/control.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 39de59c8bac2c..064df695b3a4c 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h

[ ... ]

> @@ -403,14 +407,20 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
> =20
>  #ifdef DEBUG
>  #define DYNAMIC_DEBUG_BRANCH(descriptor) \
> -	likely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
> +	likely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
>  #else
>  #define DYNAMIC_DEBUG_BRANCH(descriptor) \
> -	unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
> +	unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
>  #endif
> =20
>  #endif /* CONFIG_JUMP_LABEL */

[Severity: High]
Does changing this macro to check for _DPRINTK_FLAGS_ENABLED (which includes
the new +c count flag) break open-coded callers of DYNAMIC_DEBUG_BRANCH?

For instance, in include/linux/printk.h, pr_debug_ratelimited() uses this:

	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&
	    __ratelimit(&_rs))
		__dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);

If a user enables only the +c flag, DYNAMIC_DEBUG_BRANCH evaluates to true,
but because it bypasses the DYNAMIC_DEBUG_COUNT() macro, it fails to
increment the counter. Furthermore, it falls through to __dynamic_pr_debug()
causing it to print anyway.

Other callers like alloc_contig_dump_pages() in mm/page_alloc.c or
sdhci_dbg_dumpregs() in drivers/mmc/host/sdhci.h will similarly execute full
stack and register dumps unintentionally if the +c flag is set, without
counting the calls.

[ ... ]

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 77976e7b264ca..9fa1a6e3afe6c 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c

[ ... ]

> @@ -1104,6 +1122,11 @@ static ssize_t ddebug_proc_write(struct file *file=
, const char __user *ubuf,
>  		return PTR_ERR(tmpbuf);
>  	v2pr_info("read %zu bytes from userspace\n", len);
> =20
> +	if (len >=3D 11 && !strncmp(tmpbuf, "reset_stats", 11)) {
> +		reset_ddebug_call_count();
> +		kfree(tmpbuf);
> +		return len;
> +	}
>  	ret =3D ddebug_exec_queries(tmpbuf, NULL);
>  	kfree(tmpbuf);
>  	if (ret < 0)

[Severity: Medium]
Could this early return logic silently drop batched queries?

Since ddebug_exec_queries() handles parsing multiple commands separated by
newlines or semicolons, returning early here means a batched input like
"reset_stats\nfile foo.c +c" would reset the stats but completely ignore the
subsequent commands without returning an error.

Additionally, does this strncmp() check falsely match partial commands like
"reset_stats_and_more", while also failing to handle leading whitespace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dd-cmap-pa=
rt2-clean-v9-0-3a3f621f4a10@gmail.com?part=3D38
