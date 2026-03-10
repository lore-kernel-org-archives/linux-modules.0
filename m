Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BF83A5447
	for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2026 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148884; cv=none; b=jN9XDffQrD5sSQa0VsGIqdj7UxuU4zy2uvYAqTqdiB9WwasOqVzoMM2SUxZHlayl7E64Ba1W6VbHGh3xDs0JyPmm4okVbsVNVGKXWh5ukAw5ZyhZ42Fh/Cif4HJQ4iLexYVuslhDZLmR/Zzoa0StNSYmOWTjkFogPm3As2pArkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148884; c=relaxed/simple;
	bh=gYbmvHWG+uv3Q6l2mat6TP34tBEF7dbjfOXXSNwqF44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjW0HKaQsZBasVAPkFmPXu3cCznvRVnJLpSycdVYxdguisfInZeP4VXDwlBE1SxnRWL7YlwPiUpXemyUPOMbq87El/V50R1km3oNvttWJAGBFTE2s2uUQ67rogsSwrbv+0rW7QHRS+Eh3iIvmNDkr/NiY7Bb9nIaRM0Ht3lNWvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xle91yO+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xle91yO+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3PmWFAxuYAgFRgQE1lT4fhSbgwxkkFQhUozuWpAfNWU=; b=xle91yO+B7G/mwxwlV8Te7bPZ5
	p90yKR4UbEwR/mQzddYrqxQ9gvFEmPWB8KjHtfqtlAX987ggk9HgbM5LyqyzBVmv5eiSb2ojq93Lq
	z8QkBS2UkbupOgqE2owWYJA8MaG1Z8kxWjV95vu0v4P9H2ZHgCX3B7fu1Fj0zNah+H2ZwZ07SqSHw
	DhdhQcGjJyui1YYJXXANgB/t7af/lqAgu2PI2gosey5O1EYf8EqJ/z9t6zeu7+EQR3/M3485qZ3e5
	NhzX0i3KEU9u+aXBRA9lSFmtqDBJPGaQO0BxoyqRW5ZoGLk0Q0/1z+Gr2+/Hlc9Y0fR/jcIFtXSXS
	cY7N+qQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzx1X-00000009aB8-0ZPD;
	Tue, 10 Mar 2026 13:21:23 +0000
Date: Tue, 10 Mar 2026 06:21:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, atomlin@atomlin.com,
	da.gomez@kernel.org, linux-modules@vger.kernel.org,
	mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com
Subject: Re: [PATCH v3] module: print version for external modules in
 print_modules()
Message-ID: <abAa03DO9aLxWcwX@infradead.org>
References: <aa-6wILF90Y4ndnd@infradead.org>
 <4215f061-488b-4c2b-98b3-45db4aabed5e@gmail.com>
 <abAXjc6OihRcdoAA@infradead.org>
 <CALOAHbA3g=UVavYgxJXH_5v0TYMLd6QKUTd=HDbD74Cp+9Kgvg@mail.gmail.com>
 <abAZSCbSEGUhTdUn@infradead.org>
 <CALOAHbBpAi_FM=odrNkGwXGj1d-ydn=cwURXkUGLawzOMUufuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbBpAi_FM=odrNkGwXGj1d-ydn=cwURXkUGLawzOMUufuQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 10, 2026 at 09:19:22PM +0800, Yafang Shao wrote:
> Given that the Linux kernel officially supports out-of-tree modules,

It does not officially support them as a first class entity.

> we should aim to support them where reasonable. My change is generic
> and improves the core code without being tied to any specific external
> module.

It adds overhead to the kernel just for leechers like you that don't
actually contibute their code upstream.  That's always a bad idea.

