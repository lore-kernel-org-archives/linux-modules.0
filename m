Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F6B149C53;
	Thu, 14 Nov 2024 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600560; cv=none; b=LkMUVyBUv7yog3nbXWn2Z7hjuawdl8kJZtej93c0uRSZIrUNC8/ZBzYhxvbSzALyC46D1JIMfZZ6hNbUEaO4D9QivG0yzO5+yeFpy2epgVTg6fr+plcuTf+6tuXijrd6pfyDVjS7+XgoHfrV/Unk17UcdTWPE8PpZDpTwIRRtig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600560; c=relaxed/simple;
	bh=K8VMSIXUGCzy157XO/mBFVOn6MZaAqSEXxjGJZZNYnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AR+GwZMnwLtrngrF4g2DeVFKZ3U6i8EbGBllvevJspe4dm1TIIG4PgmPCh4AuoDBDmTemscJPnezDFlKVf6CtOl4sFxhUgVuW/yTwQquVpqDei6/ORMJU/uRwYkfv0KF0zRBnfffGW7RHWxmiNSu6ASl2G/us9KVGJouizKYJA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iWz8417g; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iWz8417g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K8VMSIXUGCzy157XO/mBFVOn6MZaAqSEXxjGJZZNYnY=; b=iWz8417gfzi9SvIWuLS04cqEHq
	DDSvBGj7L6ysrQqGyQyKLiUIT7oronx1ofro7wWyO8VtYm/2PS6EFVw/OlL7A1Rt++Qx/k9wmjBwR
	RjE+JY6iztK5TTwKCaW+CDUe3xeDn67q1ubn2t6STAubnSIoAnYy8utuNMpIWJhdeEEN9CDkpq9hH
	CxmQ4OmAle8YfDId3iRFPMi/ByeUTm1kPs3GuYlm8F0PBe8sPUl/bKouD2ZH/eI4TyqNK0HxgyeDN
	UW4kbV3cjch6lyiCIu3fTG4LN0C6b79z6VaQHZC1zH0AyU72m/nzd3xplV4QUBZ5v/0gGkKU22k29
	2t/+dG7A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBcPF-000000002O1-0rhY;
	Thu, 14 Nov 2024 16:09:17 +0000
Date: Thu, 14 Nov 2024 08:09:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Werner Sembach <wse@tuxedocomputers.com>, tux@tuxedocomputers.com,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 2/2] module: Block modules by Tuxedo from accessing GPL
 symbols
Message-ID: <ZzYgrc4cNqlhezCs@infradead.org>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <20241114103133.547032-6-ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114103133.547032-6-ukleinek@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Thanks for doing this!

Reviewed-by: Christoph Hellwig <hch@lst.de>

