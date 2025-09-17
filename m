Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F44372885;
	Wed, 17 Sep 2025 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110267; cv=none; b=suZFNb8iJNAoAA4GGwHcnpMCzNozC5p45sezSzLfNaaSQlrA0/RK7oGdEW8TBL57xklMGZDEovzHU4Fbf5jl22rJHxC3FK8zGPa07c+C4NHuwTNAAczQlM3lF7bmDMMpmCdCbs7m/ch9KGC/OdU3p14Nk3SkV7nc1aktJszUaoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110267; c=relaxed/simple;
	bh=OPvWIg5f8+EX3AW+6tBigjoRMmYFYreT6CNYUqFjc9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgH2hKC3tJ9rjan0Bb9EpLRsNeQoXkxw1CPzXXkJd3HonCyT1xC4cNVBjXWvFdu5SbXc+9W1kEWf6aTMvHi+UvwAgFbi1kQWFIXXhwynDJzG3xwMKbvda0+v/4+13zzTNW54Moqcmx2H0dhtEimMFfqOsNNs5xhqMYeMmfrytsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yh+eneIi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yh+eneIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAA5C4CEF0;
	Wed, 17 Sep 2025 11:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758110267;
	bh=OPvWIg5f8+EX3AW+6tBigjoRMmYFYreT6CNYUqFjc9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yh+eneIi7bnzqKC/I3ExxQdP1s6NMJGzAjrDwA9Bli/mSLvBkkmjSg+xasNPPg/ns
	 Uy3lanFCdbKRKCGkValn0fkCSA/M1lh+D0Q9TaHVorKF0toSfLIjYtPHFmIDMDQV+6
	 XxwvpvKUaP0YNKZ+AmA7bHmFoKLspoYxq6GXBgVgveBxR7fY3Qz8ke6iO0HAXdHmv7
	 VWcLaE6eHeYmhG+cMvMTNCGCp9miLOdjt7GnLQw93bIWw4bMO9KBpgFe4z8ADlmlql
	 5aeZUMPZHPb4IbixQIXBVeVtg9lo3u9VHeiagwUwM3XMNhe2G2wlaZA7E0YZ1rue0T
	 oVQd02yhbkE1A==
Date: Wed, 17 Sep 2025 13:57:28 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v7 4/8] kbuild: extract modules.builtin.modinfo from
 vmlinux.unstripped
Message-ID: <aMqiKCjYhRg0tx5h@levanger>
References: <cover.1755535876.git.legion@kernel.org>
 <ed2530db3903b1332ce4bc2aaf95a0397e1581e8.1755535876.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed2530db3903b1332ce4bc2aaf95a0397e1581e8.1755535876.git.legion@kernel.org>

On Mon, Aug 18, 2025 at 06:54:58PM +0200, Alexey Gladkov wrote:
> From: Masahiro Yamada <masahiroy@kernel.org>
> 
> Currently, we assume all the data for modules.builtin.modinfo are
> available in vmlinux.o.
> 
> This makes it impossible for modpost, which is invoked after vmlinux.o,
> to add additional module info.
> 
> This commit moves the modules.builtin.modinfo rule after modpost.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  scripts/Makefile.vmlinux   | 26 ++++++++++++++++++++++++++
>  scripts/Makefile.vmlinux_o | 26 +-------------------------
>  2 files changed, 27 insertions(+), 25 deletions(-)
> 

Reviewed-by: Nicolas Schier <nsc@kernel.org>
