Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235EA3EAC98;
	Tue,  4 Aug 2026 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858958; cv=none; b=l2xUtbQ0PF89M99GGekmRcO6hsgSxY10otXMYNVGwth1h8yWesJMaKNkMYcEwvRWtqucydpu/+MkFUm22ryxBAXl4hk0lkR9SnbKD6NoBHHfh4b6VD819535oaCNQywYCmTr/CWkmWqjs3I9fF58Yf/eZ4EZt6XhYK6N3XYYofk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858958; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu3ffckihobpwjczCGOr2C8znjcFRKSTyVWpV3Y6ml0seeaWZzNyadtmbdJH5+zoN6qGXEvE33KFPJPCb5wB33SJSlxCU4gHDh2FafpKZ1ePJRrGcthL9NnMPwppdo1aT9pK/WaTtlAwKV1LtsjlukRB5+sVSisQoHPueT1zdmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ch/BdxK/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ch/BdxK/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Ch/BdxK/Fv7MHBmfWe5LDbTrzf
	R7SDn0nqDk4Hw6aS2a1dAM5/IwPhIEf7JalDM8KU+Uez0nGI7h5/BdveJpqoQl5+xA9uZLH08r48j
	crrcs1bb/T+RmkrU7eG13y8D+iSY+WBTMRrtp+P5l1gh+mlz9YTzRgIHkd9revi73P7q5B+tem7dq
	FjLXh6bXFRioauuzRrMkKYkWbgYQDcqw7upn+svlIiZ6BUxWOznuaxhvvZMF7ejoDHyKuum1bJPZ1
	BKvFso6+PNYNvl/RkBH4ZeLl1T8cSvIWNPbTq7VQMeqvzPcpzvBorGSdtwbgEu6x3UjSCgttTwLjb
	t8MD7ALw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrHUg-00000002Fct-0Xv4;
	Tue, 04 Aug 2026 15:55:54 +0000
Date: Tue, 4 Aug 2026 08:55:54 -0700
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
Subject: Re: [PATCH v2 2/2] module: remove srcversion module attribute
Message-ID: <anILiinOFJ8Rxcao@infradead.org>
References: <20260731-module_ver_remove-v2-0-c9163858f382@linuxfoundation.org>
 <20260731-module_ver_remove-v2-2-c9163858f382@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-module_ver_remove-v2-2-c9163858f382@linuxfoundation.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

