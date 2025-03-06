Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314BF2571DA;
	Thu,  6 Mar 2025 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281679; cv=none; b=WRtOjKe5RMHrMCp8uoH8/b+fZfff0ckJNtVbKstc1SVnMFwjpQBqPtd64Infsmywn8t4xANRw5vA4EofkmOWhJeFRaM1R43yuly8cUNQ4k6xfoUdqEMGFUTIRTDbP2HvkUNsYppLX55hYGOl85IWn3dvc+sIGjL3sFZL6MrPDDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281679; c=relaxed/simple;
	bh=5Bvc9ud5a8OdhEve9BLHR7b9ZedTTQHeaVFBFAY4FR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojfsY3gCyeBZWQ55MLa6D44vz3vK0Hb/PVT3UVkPR0iN0rI80BmtaPran+0rl9cxT7ouuGDEZzwmKWFvajuSMo8eYNHL407D/crDYYFH66SqXyUqIbL5X2LyXxQk1cDpIOk9+gKVZSQ0dJ2htVQ0xMJZkZnKXTiyM5F/zWaVVs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfujXFgp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfujXFgp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ED1C4CEE0;
	Thu,  6 Mar 2025 17:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741281678;
	bh=5Bvc9ud5a8OdhEve9BLHR7b9ZedTTQHeaVFBFAY4FR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CfujXFgpWWVo7fel5Oz/JKpf24MqlqpTw9dq4IkKJa4YCbqn+PUb2iXsVaxDH5aHw
	 G+fhzYbpAxFNlHXUxPz+5NYLL3lbZqxGqUNJuBGtH2HZIw1zEMJUf9PGOUxB9dDzcs
	 Gd6i/CVLNqA57y7slRNbtUVkGPeOuGz0d7yqX22/AOXV6gaGQ6RTCQ7YkpRijosLhU
	 wW8YAVA9MOOJcneZA4M5Hnejrd9EElLrhGlcWUjbQrDHj6DG3p6CPPa7os2h2/6syD
	 GLK6kCEfNq9e3Gt32lNG3KUHpfegerlOOfW9tS7EOzHuIaeGk8Bx4i6fIgkO6o/hg3
	 ZifSJk1BybIWg==
Date: Thu, 6 Mar 2025 09:21:17 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update the MODULE SUPPORT section
Message-ID: <Z8nZjcKKLmFDh4ZP@bombadil.infradead.org>
References: <20250306162117.18876-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306162117.18876-1-petr.pavlu@suse.com>

On Thu, Mar 06, 2025 at 05:20:59PM +0100, Petr Pavlu wrote:
> Change my role for MODULE SUPPORT from a reviewer to a maintainer. We
> started to rotate its maintainership and I currently look after the modules
> tree. This not being reflected in MAINTAINERS proved to confuse folks.
> 
> Add lib/tests/module/ and tools/testing/selftests/module/ to maintained
> files. They were introduced previously by commit 84b4a51fce4c ("selftests:
> add new kallsyms selftests").
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e0736dc2ee0..0c8a00b0b49b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15982,7 +15982,7 @@ F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
>  
>  MODULE SUPPORT
>  M:	Luis Chamberlain <mcgrof@kernel.org>
> -R:	Petr Pavlu <petr.pavlu@suse.com>
> +M:	Petr Pavlu <petr.pavlu@suse.com>
>  R:	Sami Tolvanen <samitolvanen@google.com>
>  R:	Daniel Gomez <da.gomez@samsung.com>
>  L:	linux-modules@vger.kernel.org
> @@ -15993,8 +15993,10 @@ F:	include/linux/kmod.h
>  F:	include/linux/module*.h
>  F:	kernel/module/
>  F:	lib/test_kmod.c
> +F:	lib/tests/module/
>  F:	scripts/module*
>  F:	tools/testing/selftests/kmod/
> +F:	tools/testing/selftests/module/
>  
>  MONOLITHIC POWER SYSTEM PMIC DRIVER
>  M:	Saravanan Sekar <sravanhome@gmail.com>
> 
> base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43

And as a further note to Linus:

Petr, Sami and Daniel had volunteered to help with maintenance to help
with Rust module support. My requesto to the Rust community was that
while I don't speak Rust I'd be happy to support Rust provided we get
volunteers from the Rust community to help with maintenance of *both*
the C and Rust code. The Rust community came back strong with 3
volunteers.

To help with ramp up I decided that after a few months of them being
reviewers we'd rotate them to be the main maintainer for 6 months each.
Petr has been doing this since around November of last year and he's
been doing an incredible job. Next up will be Daniel and then 6 months
after Sami.

  Luis
