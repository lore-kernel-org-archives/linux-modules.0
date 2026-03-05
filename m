Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985783CB2D2;
	Thu,  5 Mar 2026 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740553; cv=none; b=kUrrp+wLR1ly9ns/uSwwsOVHq1uHqUwQ2H6ajlJ713S36jwLzXHbD9d1SFXRVAMhdpqWbOj/XRUGFEWUqW6sMtxDq4z4T4fWk4tFcG6ZbD+RT1+5tevuQyaFJpJRAXZLV7z/9Fk1c+2WoLawhrgVFbEKlrBRu+6vTK30kJIqxwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740553; c=relaxed/simple;
	bh=tO6nbcRGpeabrFXkXzNEp8tdoT8UB8lhKuCOc1lIS2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9IDa5onzi3y6rgA0w61EplfiiafX2+3S5DduzECgLZF/TsUtRQ8SGFL8ISH02jkQEpSHKXmXGFue4EJu5AEUiip+lxRP0MtCDBN09q5N8gsUlhJsYQ+S/0nKLLWHYkjwZaFiOtXs7pzhe6HbofFRww+HWYqDG+QZEkgChkKpCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdBnU08N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdBnU08N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64773C116C6;
	Thu,  5 Mar 2026 19:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772740553;
	bh=tO6nbcRGpeabrFXkXzNEp8tdoT8UB8lhKuCOc1lIS2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jdBnU08N7MH6AFI9LPaMfE0SiVqildPhmekfs6q1qK+7cmF1pLAtNLQNt6NNVUnoy
	 TTAfyMh2CGeSIhEEQvL02ba04YQ3BaU4IToDeTYmiQodNEvZNMxT0Iv3I7WcNGIg3Q
	 S1c1OB/tys18fu3CVlvIMVBkuOt4i2HQTcQOUZdzhg+xBk/3CV/yp9fxu7WUzt/nKe
	 P832Ma/gFEWzszPIrtZPee3qsc6oH1AvPht81lx61TvzVSoJ6iAOpEBDun0bm+Cz9K
	 wAtIwkQn95/U6q/aQSf9Shu5MKxbnvb488bf1+vO7Fby65SHubtrydgBIf/41VFTmk
	 UwG28sNz+aUhg==
Date: Thu, 5 Mar 2026 11:55:50 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2] module.lds,codetag: force 0 sh_addr for sections
Message-ID: <b356bqjcgmbqrqwfmou27qzv2ldjhitnlbcaeehzhe5indv3au@vpvay3pnmzmr>
References: <20260305015237.299727-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260305015237.299727-1-joe.lawrence@redhat.com>

On Wed, Mar 04, 2026 at 08:52:37PM -0500, Joe Lawrence wrote:
> Commit 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and
> related macros") added .text and made .data, .bss, and .rodata sections
> unconditional in the module linker script, but without an explicit
> address like the other sections in the same file.
> 
> When linking modules with ld.bfd -r, sections defined without an address
> inherit the location counter, resulting in non-zero sh_addr values in
> the .ko.  Relocatable objects are expected to have sh_addr=0 for these
> sections and these non-zero addresses confuse elfutils and have been
> reported to cause segmentation faults in SystemTap [1].
> 
> Add the 0 address specifier to all sections in module.lds, including the
> .codetag.* sections via MOD_SEPARATE_CODETAG_SECTIONS macro.
> 
> Link: https://sourceware.org/bugzilla/show_bug.cgi?id=33958
> Fixes: 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros")
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  include/asm-generic/codetag.lds.h |  2 +-
>  scripts/module.lds.S              | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> v2:
> - Update the MOD_SEPARATE_CODETAG_SECTION for .codetag.* as well [Petr]
> 
> v1: https://lore.kernel.org/lkml/20260304160611.143862-1-joe.lawrence@redhat.com

Thanks for the fix!

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
