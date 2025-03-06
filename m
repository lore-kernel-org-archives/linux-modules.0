Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928F25C702;
	Thu,  6 Mar 2025 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281368; cv=none; b=PmhnK5u6Cd82/ypmsq+caqfRiUJbmopNmixOucOqVNnUsTRkkUOs5uPCtuDrvhyqzIEH11HsTE2CsO+qspujvREokoEuVFpojP8qJTiScNNjU6TL4N3c+utdwaeAcnatz+3n+pcxaFnd1nZq3fD7UEh6U4UWjbM82dzdHYOua70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281368; c=relaxed/simple;
	bh=Xuv1Bvf/aDmrlO89xjqbFHHL3xuT0+Dv5kCum5OqEF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vlb1bexpXUIAICxJOdktNXwXyRufO1rSzzg4YLdKJceopT55AhGuGDlejj5mh120KMWxXGHjKf8F/aWCHpo0xuXbmPAAU/z8fsQrQj1HktsEfgzNmxzdbWIwkc7oKnk1taMEHfREugVlPhPbA5lAytARbNz60+FUhrhNZhtlqc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlDBSjo3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlDBSjo3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4C7C4CEE0;
	Thu,  6 Mar 2025 17:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741281366;
	bh=Xuv1Bvf/aDmrlO89xjqbFHHL3xuT0+Dv5kCum5OqEF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LlDBSjo3CXe9xWZWJ/UgZ/q7oBbUN4eo2z/XiaRjhyRwTYO//RrCt82ttKAl8mk1T
	 pY+wTbO9d22mRKqD98XzQydBy2aeSl+ZzYsZ8VM2aLjdhEhQvet0SCZBX8XXbyuSVA
	 EqaZEgy7ecKu+rAKdwXIebqnFdZxOnT4I4I16urYWQyXszfKaCLJC9AI1i5QHA7rue
	 rLlQ27wFbBuLD+KZacOH9VRyllIxCxRbZCVvoQhoGqtEdhBPo0kF25ACyZ9O5yueZA
	 SnpTDoc0GhCLsImOBOyp17XLvEpOvO/MIC+BQqcbP30m0lo4xpuM6OnUq6XpjAA+Me
	 SM6IQwdSrU0fg==
Date: Thu, 6 Mar 2025 09:16:04 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] module: Make .static_call_sites read-only after
 init
Message-ID: <Z8nYVOIkUX5IXo-P@bombadil.infradead.org>
References: <20250306131430.7016-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306131430.7016-1-petr.pavlu@suse.com>

On Thu, Mar 06, 2025 at 02:13:51PM +0100, Petr Pavlu wrote:
> Section .static_call_sites holds data structures that need to be sorted and
> processed only at module load time. The section is never modified
> afterwards. Make it therefore read-only after module initialization to
> avoid any (non-)accidental modifications.
> 
> Changes since v1 [1]:
> * Rebase the patches. The kernel now has commit 110b1e070f1d ("module:
>   Don't fail module loading when setting ro_after_init section RO failed")
>   which addresses a previous problem with handling ro_after_init sections.
> 
> [1] https://lore.kernel.org/linux-modules/20241223093840.29417-1-petr.pavlu@suse.com/

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
