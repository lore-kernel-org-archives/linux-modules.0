Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAC33D0A7
	for <linux-modules@vger.kernel.org>; Tue, 19 Dec 2023 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CW0UcQpE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bIK4NQ2uCyqG/mx4QsZDU6hdljZ6pWxROVLBZNXkXuw=; b=CW0UcQpENCMb3JHzOCUiAc8nzD
	vmabGNo6p8sharNPqpqJ0DW57qUKddK9wvA9cG+BjA71ga1HiRT//0MCvpKRgB759NRxQLtOklTG4
	2054OGDyPR1CPtrUucWJVXCJzK20E2ychWnbix19aAol/9mEza26GNNXugOjOpxL4S64L16W8lSDW
	jYh38Cp84dpqK/6RgT4qEAy3J46FtMmAp7YcuNlS5x60lt91bTN6NFPxPWD+SKUQ2lUmNb3E11Rkm
	Lh4SJiCSEzBzxCr03P2qOOgmsK+GDJlhldFETl66k+HKwpKFAdX3X3/tw9l2cQhzybR2kVVDK66XL
	w0Rdh8zg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFhfx-00FVGA-1F;
	Tue, 19 Dec 2023 21:30:53 +0000
Date: Tue, 19 Dec 2023 13:30:53 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Kevin Hao <haokexin@gmail.com>
Cc: linux-modules@vger.kernel.org
Subject: Re: [PATCH] module: Remove redundant TASK_UNINTERRUPTIBLE
Message-ID: <ZYILjVofSe4PSDPI@bombadil.infradead.org>
References: <20231208082934.1969383-1-haokexin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208082934.1969383-1-haokexin@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Dec 08, 2023 at 04:29:34PM +0800, Kevin Hao wrote:
> TASK_KILLABLE already includes TASK_UNINTERRUPTIBLE, so there is no
> need to add a separate TASK_UNINTERRUPTIBLE.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Applied and pushed, thanks!

  Luis
