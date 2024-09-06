Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2BA15AD83;
	Fri,  6 Sep 2024 23:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725665198; cv=none; b=bNkHRgyJpOJ6keWyiZMxL6C1E+Zz64JkjnGZrCbVPcLmhus+ldLtSAfzhlSpEdCGA3qQsOArp4ZzFItyGUUdSmWWww4j9JpOXQjOhoWBWlHQdkb+ETPurLUnzIISmZE1oB3rK6/UyV9r3Cii3Lf5G81W+1w2PBg9hviHQfp0ln0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725665198; c=relaxed/simple;
	bh=CfRdyYbFODOhY3FhQIOC4b6hTPf4vpwrRi+jpz0vT8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3tobh3o6NWu3W/Gg1lEuK1kodwhAz9O01Zqmk2zeA+dpa7CEJ7QANgc6dpyJ50UxJX6oIsjLNEbxCHULCUNBtGx3l5hjyzXdDQA3rNNFUWer8kCgFTyV23KnspNv3PkEAVg0Oz3hE50LSlua62Dh9/0GG2esp0KVTWnuMv1soE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j2ewMR3I; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j2ewMR3I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6H1yAFa5Qr3b4BRzHV4VtZ6uh+y/SH1IwtugfvaIzIs=; b=j2ewMR3I0dsO7W8+Vsjt1n1+zZ
	A6m2i7CuUUV0N+OaHJZF+HyIn1gYL2XCSXWcUTseziwPtXWZRTF1Y5B9YQfXi1JId2TGXjVCglDMF
	TfNMFspSj++z6+GkE2+ViiRteZ/Z+VsEk/K2SSQFvg3k12+ZDwVYSuytB+/YOJpyErxvBbyD3ESDt
	qpEM4wfhyMw3S1ZIT7rhT4Y3sIrVl9s+Fr8bOR8Ke1PITQj0eNIhfEIAUer0LDc0K3f5lwrTMdxTR
	Wl1Or65QkT0j6zS7W3XV4ZkxYwukoIpf4vmiMqGi2nw2NlY5u4RRseaYfbtwx/lqlGDo+sgfe10DS
	4IiSsrFg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smiLc-0000000DrW8-1rKE;
	Fri, 06 Sep 2024 23:26:36 +0000
Date: Fri, 6 Sep 2024 16:26:36 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com, Song Liu <song@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] module: Refine kmemleak scanned areas
Message-ID: <ZtuPrIhZfET7hLek@bombadil.infradead.org>
References: <20240906153856.22204-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906153856.22204-1-vdonnefort@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Sep 06, 2024 at 04:38:56PM +0100, Vincent Donnefort wrote:
> commit ac3b43283923 ("module: replace module_layout with module_memory")
> introduced a set of memory regions for the module layout sharing the
> same attributes but didn't update the kmemleak scanned areas which
> intended to limit kmemleak scan to sections containing writable data.
> This means sections such as .text and .rodata are scanned by kmemleak.
> 
> Refine the scanned areas for modules by limiting it to MOD_TEXT and
> MOD_INIT_TEXT mod_mem regions.
> 
> CC: Song Liu <song@kernel.org>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>


Refine or fix? If a fix, please use a Fixes tag.

  Luis
