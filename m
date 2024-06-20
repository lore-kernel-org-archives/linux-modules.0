Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCAF1459F2;
	Thu, 20 Jun 2024 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718927054; cv=none; b=OzNDSycCf0SF2a8EF9vNGLs14el6fmu6v6j3wuSUmlj0AM/fEwRZ3IGG0p2A06IgEodh08aeyMublYMsrA2JP3cFxToPgDlCredXpeYF1Es1cdHReLXhhV+q6p9fJYYfziLJ5nwsa3628Z72ZF6IiUghnJsx36+/wCo/p2Lm6fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718927054; c=relaxed/simple;
	bh=Br/LIGP/W7ancnLuPn4+olOcv67Djp3dUyhu2uV1J3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohb0BvhiIG19rd+FwFYhN8GvfT2rZdQZR4FbExnFnhR9XQRqB3pREKAA+eKopHjKUf8UzvAggpZjfIWz4jScfk+N0ABg92u4ygAGROgSaEFNmsk8ulO7RfDwMyjFYLfK/pSQvkqZSPRbgJL9ZL6S0UMbnUhTITWfJ9KxdCM2P04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vgVJWSIL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vgVJWSIL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DLwRv8BOS4/4ytu2UjnpHES9HQWbhLlUdznZ3C/ypxY=; b=vgVJWSILghNAk6BFzvpy8+ycCj
	ZNmGrsocEB+GZ9CxOpV8miAT/VHjcSzwrWq/cWGPx6aJDqrC+4t1DuvAWbQFZQTBKi/CjZ8+mFowj
	HKDp6PEvTvVVeJfBdggeVF+lhFQOtCOs2TQd0o6x2r0xUOctnzRPDiKLXuGrFddpPLVm09V4uTNGl
	MPe94Z9x1cno9wycb13rV+X7q24NaJN+Ey6OpSe/RgtKRvB3hM97Us7jFzigym3hDKL6JvOs+9a7K
	2c3vGYlKT5Ywzd+WzGB84wJ2JpFTHV7a6YYhXkA+z5aqaJiB20SHLs0nDUco6PcYUAogrjgmSedz1
	HufUgq9w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKRRr-000000079Fw-1Jfe;
	Thu, 20 Jun 2024 23:44:11 +0000
Date: Thu, 20 Jun 2024 16:44:11 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Yusong Gao <a869920004@gmail.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: Add log information for loading module
 failures
Message-ID: <ZnS-y94qwA1Wmlo8@bombadil.infradead.org>
References: <20240619083037.1070310-1-a869920004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619083037.1070310-1-a869920004@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Jun 19, 2024 at 08:30:37AM +0000, Yusong Gao wrote:
> Add log information in kernel-space when loading module failures.
> Try to load the unsigned module and the module with bad signature
> when set 1 to /sys/module/module/parameters/sig_enforce.
> 
> Unsigned module case:
> (linux) insmod unsigned.ko
> [   18.714661] Loading of unsigned module is rejected
> insmod: can't insert 'unsigned.ko': Key was rejected by service
> (linux)
> 
> Bad signature module case:
> (linux) insmod bad_signature.ko
> insmod: can't insert 'bad_signature.ko': Key was rejected by service
> (linux)
> 
> There have different logging behavior the bad signature case only log
> in user-space, add log info for fatal errors in module_sig_check().
> 
> Signed-off-by: Yusong Gao <a869920004@gmail.com>
> ---
> V2: Change print level from notice to debug.
> ---
>  kernel/module/signing.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/module/signing.c b/kernel/module/signing.c
> index a2ff4242e623..b0c7b30e4d89 100644
> --- a/kernel/module/signing.c
> +++ b/kernel/module/signing.c
> @@ -113,6 +113,7 @@ int module_sig_check(struct load_info *info, int flags)
>  		 * unparseable signatures, and signature check failures --
>  		 * even if signatures aren't required.
>  		 */
> +		pr_debug("Loading module failed (errno=%d)\n", -err);

There are so many debug message, this doesn't help explain why, ie, tha
this is a signature issue.

  Luis
