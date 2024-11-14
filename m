Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDE12D05D;
	Thu, 14 Nov 2024 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600542; cv=none; b=m40vl/t1iNcuqy4H1/KFjZNW0FEJ3302YCkC9egVgqW41xhk2lXh5wqNUM+I7RReFljOOQidwSgnCN6ZNb9+k2AUfSSPuH1sFLFZeRvs2O6aRqW8dtlXAYC1aEVjQG7aSH7y+Zcge8iJPOq9wr7oavsmcMLBxPg6BBGLaXPf3r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600542; c=relaxed/simple;
	bh=G4OcJ5qYIlBpiahrlpX0+t4O33rFs0Faj4geUO+J0os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIUbRIALxgH9W8xdxU3Eg4sut2ZMJyvPV/jIFeQgXrGXULQBivZEVLjAakh1i3wV3lDAfdfeFpq3HiC91T+VT3mTg+nuU19osDmlbtGRX9LiAjnzdDfFcAo+z6pHpLRKwX5kVSBOi4D7ZSeLPujhyTk/OY0UWek5R9+e066L4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QKrpxkpn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QKrpxkpn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LO6paHoWvX5u0KkgMvA/ZCaZ3pVmBtAHyb7dXhqiVZ8=; b=QKrpxkpnVPZM0GHFEIx9UMowN+
	JxZGohKimOLQiv3Yjk7icAzDUrAJxY7Gg0Qp/Swo0Pn701S6iB2U/BAqHHejt8RC1r3mMQfNIf+ab
	jPpFg19Yhe6Bc1gx3GAnS3EMiwRSVl3FRFgp91JvklCBE4WI1gJpt7FYakRriN036zBXfePeBPyIi
	6EPzDJ7TkTxG6nXt9rezipDvbz+/9LYKkZ2HfazCicwrsoielkEe8mYwIOElm73YE8i6BjUzTamh0
	Wd3dTdMDUTyBqKyfjdbuWZLQywnJ6GfnYvchEOw7JPh3vYE7rjXXhUtD20ouHXq+8dUBizBDsnFs+
	qPZYWr+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBcOv-000000002Gk-1NDC;
	Thu, 14 Nov 2024 16:08:57 +0000
Date: Thu, 14 Nov 2024 08:08:57 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Werner Sembach <wse@tuxedocomputers.com>, tux@tuxedocomputers.com,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 1/2] module: Put known GPL offenders in an array
Message-ID: <ZzYgmaUNYaZQ2enh@infradead.org>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <20241114103133.547032-5-ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114103133.547032-5-ukleinek@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 14, 2024 at 11:31:33AM +0100, Uwe Kleine-König wrote:
> Instead of repeating the add_taint_module() call for each offender, create
> an array and loop over that one. This simplifies adding new entries
> considerably.
> 
> Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

