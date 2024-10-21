Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A3A1CEEBB;
	Mon, 21 Oct 2024 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540485; cv=none; b=h2rodDVkbRiw0urwHzdDcmsT8jp/5CS2DOLItVUw4HypYzi4glOoglVGYtCKvkTiqGsE94H72+/+d0sWjaAB/c+/hlaeGXOc1cP3mArql3FMX+qrHrae183QNlpMHTDQ5J0prSWqLvFrqC4cnt+Y8HsgbpWVTVYX7RUodb+mFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540485; c=relaxed/simple;
	bh=4N7BPzQcZHYwBzZG5nC5QJv1HlGgPxhhULIh4FGJ7NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDEjoAii4vx1LMiCF1xVUKO+RCZ9XU1oTkz6D5uRQKrCd7XlmnvuF/eZkqTPRLJEVlRu475NsYvugUZm64yEiL6uvg/VmCfOHYJIsghh+bB/JV/Mxp5KjmyV4yQZHFY+MknxIqH2klYQTz0P2tsULnLIX7J2EUdLtQYaB5nYuWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzDtMAQG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzDtMAQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225DEC4CEC3;
	Mon, 21 Oct 2024 19:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729540485;
	bh=4N7BPzQcZHYwBzZG5nC5QJv1HlGgPxhhULIh4FGJ7NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DzDtMAQGP5FlD7V+QIvxcXg/rSFXHGHfJOxtWlxEb+QeYben73C6lmjeRZKA6yZvm
	 GevEpee0TxnLJW3F5xp0l5gbKXGXZBSNINoeMJ3zB7RJkl4Y3SiJkjbgcf9YEt7Oc6
	 HAoh/MKiIx9/u7nnB/w/hY8erpmQH3C1njYWzyvOVZMLiSO/KrjR+udNM37hsk8jXj
	 i8BwH6/x0FtPfadY2FhPwDzhmJgahyar93HCeULuymycIT8/X24SwarYXn4K4KW0V5
	 f6+Hk1um3Hs5zhnYat3Cu8916ggDEQkcoPvGNZ8l1OzRMPDrECArqv0ve/KHswTUir
	 d0p7+q1BODpPA==
Date: Mon, 21 Oct 2024 12:54:43 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: .strtab must be null terminated
Message-ID: <Zxaxg5KZy9spBRM4@bombadil.infradead.org>
References: <5uwynkpfhtqbrq47nqvp2ixpjhstjl7o7uxqp3b6snj233tvzi@avfrbljjpdel>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5uwynkpfhtqbrq47nqvp2ixpjhstjl7o7uxqp3b6snj233tvzi@avfrbljjpdel>

On Sat, Oct 19, 2024 at 04:14:40PM +0200, Tobias Stoeckmann wrote:
> The string table must be NUL-terminated, just like the section name table.
> 
> Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
> ---
> In order to create a proof of concept, which I can't get into a simple
> script right now, it's easiest to move '.strtab' to the end of the module
> file, write as many 'A' characters at the end as required according to the
> section size, and try to insert the module.
> 
> In dmesg, you can see lines like:
> 
> ```
> poc: Unknown symbol AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\xc6\xe9<\xfe\xff\xff\x8b
> \xff\xc1\xe9\x03\xf3H\xa5\xeb\xa1I\x8b~ \xe8 (err -2)
> ```
> ---

Thanks can you post rebased aginst modules-next on the modules tree [0].
But please consider sending both patches and the new test one in a
series, I'll reply shortly about the other patch.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/

  Luisk
