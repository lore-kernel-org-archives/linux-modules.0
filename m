Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857601B1509;
	Wed, 11 Sep 2024 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078802; cv=none; b=BVfKoF3AMg6SZ28gfJsy+h1zVRRBlv4y6NDSXOJFnGhwt0Ii5QryVX3/pQBY9HmUdY2o0wCPydztpg9+Lo1Gu9aY9jIvuZXplACXwyYjaqbC38s70KbgmedZY1X/27I+k69QnS8jmay0Tron8nCwVsA9KsAFb2ls6nWvENnCHbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078802; c=relaxed/simple;
	bh=kWwM0yu77bo25m6/9DxRNtN6x6ZBKifWfjaOIV6g/6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDgYnQzdMh/007+6l7VAEvvH/Ewm1ncwJR8wCUvPwSH4eCjhuhGR3/+z0KUx3JPsrbyOagKbEJuytYw8fwad7UydQlXtWt3lQ2Xlc0i4iSzV4pEanfzoAT300V/b8uSdsN95XYVoGS5eX7+ed9KJ7BSg58cn5LJ+J1Kgi5Nl6ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH4jGMHK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH4jGMHK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1150C4CEC0;
	Wed, 11 Sep 2024 18:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726078802;
	bh=kWwM0yu77bo25m6/9DxRNtN6x6ZBKifWfjaOIV6g/6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GH4jGMHKLdIstdn31ZIMQ9q+NlcHzj132r12QT6w95pfy7ckYLeuf61S90NA9B0JI
	 fzWqTFo3BzSs7E3LwCoeQHlF5BR63jmfBpeUPn2+GdPDk9RM3R3Kvfmqg/u3nFDRCn
	 tLeP81aEO5Qcm9xMib6R/X3O9NKo7iDFjmlEzotwGKkbWGllGa0D66TjMKYhyGzy6i
	 61dS2gUhqNXGOEk21ZpjeNfwvOLwTKTanAXBaAbkcWj5Mj0s3Itlfkz+YoLXxbybK9
	 6dbsWE5vE7hyVLuaAVn6Pmj8UdIzCi9iVTnj3rinXH5lFggEywg3O6I8XwPr7/U1Xd
	 0GlD8iPlhQGWg==
Date: Wed, 11 Sep 2024 11:20:00 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com, Song Liu <song@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] module: Refine kmemleak scanned areas
Message-ID: <ZuHfUMgpNyPwuGmQ@bombadil.infradead.org>
References: <20240910073123.2362028-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910073123.2362028-1-vdonnefort@google.com>

On Tue, Sep 10, 2024 at 08:31:23AM +0100, Vincent Donnefort wrote:
> commit ac3b43283923 ("module: replace module_layout with module_memory")
> introduced a set of memory regions for the module layout sharing the
> same attributes. However, it didn't update the kmemleak scanned areas
> which intended to limit kmemleak scan to sections containing writable
> data. This means sections such as .text and .rodata are scanned by
> kmemleak.
> 
> Refine the scanned areas for modules by limiting it to MOD_TEXT and
> MOD_INIT_TEXT mod_mem regions.
> 
> CC: Song Liu <song@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Applied and pushed, thanks!

  Luis
