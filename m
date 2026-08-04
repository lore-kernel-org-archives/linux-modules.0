Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE9F3EAC98;
	Tue,  4 Aug 2026 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858949; cv=none; b=sja3fXEJVILrcEKeMp2bVVUA8EufntY9jFPQP2EjDoSz0N2Ve8vRhVjQ63JBHOJXq11v6Lmj12igdZ413s+XR7Le+WWq0wJ9hItsfMigdYiyYycQsVRgE8lIPecou7cBoeya/FIlpKsDS/mLED2JeuUiVebylI7xhTnD2Uh4t4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858949; c=relaxed/simple;
	bh=348FefFW3KfG8ml7pOSWJxBRb4s2ds1rqeNBJzuCsNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEhlddNocZvJ0gDD8H6Sm2M4iaQFq1uaQfIzpnvbs2z/PufTZej6PXtvbqFY+JsGsPxN2unPjaFmWWFLDCwVA8nZrQZgU+cXd2AGcC4IaPvljl3KWHEb4VdJXdI+g4UV8E7gs5XhXN6i54NpGwR4HQ4IWf4oqkPwzgMz/UFcHj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wauY2bia; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wauY2bia"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6JIa7jcIfkYcMT1Qc75/bq+S9jWjbB8g7z9rF0o0oLc=; b=wauY2bia2VUNqfL9sY1WQyMhj+
	2KSHkCYoFhiORbhTz/d4xVBYyOmzGlMLnn7TAvnOnI0/+U9eCrm0x1MCodI9GAap1hRsWPF1iIReF
	UaEgs9xXvTX6KJesGaBDHFDz/sG2dYPWqGf5KYj6AA5UDSicu0nX1i5cjVZIiRBo3EhTDhh+cnVdc
	LRlqYeNcY8EtqIcsGm4k9BVZ6++zECR6Rv5wbJf1xBh+Ispsnzr1dhkjwr3O4owbVuHDASytPrwSD
	MvMZl6ObXCq6yYae4zEdZGZ2fHjuGnQsNtF+p1LgHIPFL7HF+AMjczk/3HgOMJdbgtKLfEcNInv4K
	PzNwwv9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrHUU-00000002Fc4-0FkS;
	Tue, 04 Aug 2026 15:55:42 +0000
Date: Tue, 4 Aug 2026 08:55:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/2] module: remove MODULE_VERSION()
Message-ID: <anILftPYWfY3y-Ba@infradead.org>
References: <20260731-module_ver_remove-v2-0-c9163858f382@linuxfoundation.org>
 <20260731-module_ver_remove-v2-1-c9163858f382@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-module_ver_remove-v2-1-c9163858f382@linuxfoundation.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 31, 2026 at 03:02:23PM +0200, Greg Kroah-Hartman wrote:
> Module "versions" do not make sense as the kernel is built all at once,
> the "version" is the overall kernel version number, so modules can not
> really be described as having a unique version given that they rely on
> the infrastructure of the whole kernel.
> 
> For now, just make this an "empty" define, to keep existing code
> building properly as the tree is slowly purged of the use of this over
> time.
> 
> This macro will be removed entirely in the future when there are no
> in-tree users.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

