Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8BB3D81;
	Tue,  4 Feb 2025 05:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738646873; cv=none; b=ZqT9q0mZWbZ7CC5WrqSgUnN09c5EDVLw++hX9qVQP7/+ja2234Tkd6gG/NbKq1RrHHrNdTtrVtEXKLCeswt2OxVNQxfMPNSemqVbX5DkB+3wnB4VqHUiakG/dsTNO6x0A0FyZSi4V2j/Yz7GgGJkHn6qQxu9Pv0sN2J8jfeTAcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738646873; c=relaxed/simple;
	bh=HBmzJ9uLykcTL/fi/jPzGUcdIklHBtaW7ZrUOgVMk4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLXupeGIktckwQzsywQTDG/bYSItezbBgy6DWh4ZsuX7SkZZvdls5crBX2ayNgfUFWOdmKjMmhi5ixBpumBPNnX1M5LKekltU7thooj9yQ7zkIU/u8pDJ/fale4jwjw8bdPQEELhveBlWHlm2PsynAsLfB164tVwZEuIVVZOo4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ifpygeWg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ifpygeWg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iOyYuRMP5oEcjkyPYh/a70Gm3BXrAjJ9ffPFJOh+E+Q=; b=ifpygeWgCEBGpoDX83UmOWUnn2
	pkoQkvGRemGhd6hl+vtdKEmOIg6pIce24WbFExXZnpaEzwxvvJzoKyTPBWrQqNN2sc+4t9gMbec+5
	YUsWuZeHTqOFjWEH+6iDeD4rOybXLzv7NJheQgqUjrzD9hzTJgemkgXLD0TDWuxj6AnApf49QolTU
	PTAkCvDwbcXgcMfD++zzkPG3bzon5Uq0RrRX61QyD/ipZ0znPknzYx/FoyC9rbj1ytXV6oh1ISqIx
	enxwK8og8th5pIbkWdd4ltZUae9t2Bw6vSWjAjFjyXZQBk+guZ5/xXlqXR47W++ynPxJ/dE0+rmmZ
	F288nSaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfBTS-0000000HHY8-3XH6;
	Tue, 04 Feb 2025 05:27:50 +0000
Date: Mon, 3 Feb 2025 21:27:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	code@tyhicks.com, linux@rasmusvillemoes.dk, mcgrof@kernel.org,
	frkaya@linux.microsoft.com, vijayb@linux.microsoft.com,
	petr.pavlu@suse.com, linux@weissschuh.net, samitolvanen@google.com,
	da.gomez@samsung.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org
Subject: Re: [v1 2/3] include: move
 lookup_or_create_module_kobject()/to_module* to module.h
Message-ID: <Z6GlVpuR8MaR4XLN@infradead.org>
References: <20250204052222.1611510-1-shyamsaini@linux.microsoft.com>
 <20250204052222.1611510-3-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204052222.1611510-3-shyamsaini@linux.microsoft.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +static inline struct module_kobject * __init lookup_or_create_module_kobject(const char *name)

Crazily unreadable line.

Either way this is not a function that should be inline in a header.
Both due to sheer size, but also due to what it does and what it pulls
in.

> +{
> +	struct module_kobject *mk;
> +	struct kobject *kobj;
> +	int err;
> +
> +	kobj = kset_find_obj(module_kset, name);
> +	if (kobj) {
> +		mk = to_module_kobject(kobj);
> +	} else {

And I know this is just moving the code, but an ealy return here
would significanty clean up the function..

> +		mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
> +		BUG_ON(!mk);

.. and a BUG_ON on allocation failure is a no-go.

