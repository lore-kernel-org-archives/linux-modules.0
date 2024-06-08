Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAF71FDA;
	Sat,  8 Jun 2024 05:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717823241; cv=none; b=ARYhNu+i56ibMy9Cgshy06zqXNcShZTe33zBs4i7oVx2/oBiBDiShnkHuaQrZ2D/iSRDf2G+K/8AcHH8X2BG9a5rDnwMd5LzFuUMpn4QE73Wd6TuryJeDzSUmv/3ZBzCPrWzcrLgFOnWy/gV3ra/bSxPPC4Js81/0IBhJIDJVJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717823241; c=relaxed/simple;
	bh=2+FztU1qVsUzMpbv2Y3TRsKUZHOWbMFrM2CD9ybjoNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHC3XE0NkFsJcWqxie82xsZp5x1F0ECrkzgG/cfjZbJM/frrxVZR+ROQ0aBKZdq6xEWLcS2wWeVfoD8ZpbE1whdtK9aJydIVQzdwyqX/EitbbQ3KsNCwX3lJn+yAlZm+BbH96doSSh5GfoPJiuWRX5CdBFhp51JW211GP1IjE/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i4XJm2dp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i4XJm2dp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WW9SR+GmQvoS8oWvwysSokTuVGvGjT1ciRouIMs0aUg=; b=i4XJm2dpphJ+nXjKA1YLEM+c2M
	CwgnXki755aR4V0dAabfDI4cOEGVDpZ/JkR1jV7TY/em/+pW4zcvXDQr1xlS5vPOlbdeOTTJA/Lwa
	W26r6OUGL6BhzkoxxooegDs6Ma299FIP9lpEK86STMGP77NdI64d5T9imF+XoeltfmOU/77hyESWd
	fMdvq9WYIvL7Gw4ZmJhbY1ncOrUiTrIWF84Qy5DsGWq9kRb/SUwK8NNx4aoXXr6nW4fv0VqhBpBmZ
	KA5EaUoHJDiYVfVW1UPuE04ThjsPIj0y+cY30WY3dfKq6BaubtVKEU7JnZXYtdu6Fp9HIn1OMYYKj
	HXzI225Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFoIO-0000000GaSm-3Aq1;
	Sat, 08 Jun 2024 05:07:16 +0000
Date: Fri, 7 Jun 2024 22:07:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Aditya Garg <gargaditya08@live.com>
Cc: "mcgrof@kernel.org" <mcgrof@kernel.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Current status and possible improvements in
 CONFIG_MODULE_FORCE_UNLOAD
Message-ID: <ZmPnBCvmkczqI4Z_@infradead.org>
References: <MA0P287MB021781F0CCD7C62CAC608714B8FA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB021781F0CCD7C62CAC608714B8FA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 06, 2024 at 06:49:59AM +0000, Aditya Garg wrote:
> Hi
> 
> I am Aditya Garg. I often require using out of tree drivers to support various hardwares on Linux.

Just stop buying hardwarew that requires this, or improve and upstream
the drivers to make your life easier instead of making other peoples
life worse.

