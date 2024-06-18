Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0E64654E;
	Tue, 18 Jun 2024 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718736902; cv=none; b=K8Pb3pGcHJNkiI/CKfNrIqPyWlM8XoDtvrojCWK98uI8/Lz6R0oDuy9hdlmBFdL02cZWdiHwD+GKQtGRAH0F3tkjbc87MWXTCDd5myaehXbHM61Cd0UDJkPF+6nvNZjqc2MW4108VZOpfOo0UTJTkANZmKbzXkxuav/1E14H/iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718736902; c=relaxed/simple;
	bh=t4EqGHW5fyaATtO+CwxVtRvurq2G9JFw2lTHdVP0YSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etR8zH+IP5WWX32HgZ+rkYDAIuwkC7/A3ZN742Qoycsll4VUCavHTYD/rjLO5PCSgT2+iZGTIGRV4kTPOxLhHCv4+GSm9c94t9BbtbreyU2HMpcqW1cE2N3Sse23GFI8r6z8GiqM028cKUCtr+LVGt1Nb27/LhAObPqwCh7QVEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wGOkpV3f; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wGOkpV3f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kk5EHzQ8aWV3rqKBi34gZ1PvbS8WzVa5AK1EvoPjDCw=; b=wGOkpV3f7fi1BsRYSWISoyDLWZ
	JXRCed7MCNaXPAl9NG93lR+etAIOM9ABlUwLA2hsp/bkoPhZxW+o9IV9kk7THxFtCBevfqKapk5ti
	4qyOelg67H6FqQHWR9xYJK5VZL4Wy2vtOftfGr/W9KAvWqnenJzQEwZoHyHWREFvXe0PeMLezvSpm
	vXDxfouAMDbhA1wVD9NOXU323swCPfQI4aDSwpVhKWTG6dxlzk6k8iNs5kuIJf7HhNn8nW0Rn0w7M
	BT6/pVeC4FNiNV0TQkHQPl/L2yzqmyyGF/GFuXt3nOcu98vqwb+JLtg3XgDjSST8ogb5b3pQ6LY67
	r9iSwY/w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJdyt-0000000GGqb-2lbW;
	Tue, 18 Jun 2024 18:54:59 +0000
Date: Tue, 18 Jun 2024 11:54:59 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Yusong Gao <a869920004@gmail.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Add log information for loading module failures
Message-ID: <ZnHYA9dmtUEPLgYP@bombadil.infradead.org>
References: <20240614092519.1611533-1-a869920004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614092519.1611533-1-a869920004@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Jun 14, 2024 at 09:25:19AM +0000, Yusong Gao wrote:
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
>  kernel/module/signing.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/module/signing.c b/kernel/module/signing.c
> index a2ff4242e623..6a6493c8f7e4 100644
> --- a/kernel/module/signing.c
> +++ b/kernel/module/signing.c
> @@ -113,6 +113,7 @@ int module_sig_check(struct load_info *info, int flags)
>  		 * unparseable signatures, and signature check failures --
>  		 * even if signatures aren't required.
>  		 */
> +		pr_notice("Loading module failed (errno=%d)\n", -err);
>  		return err;

I welcome pr_debug() messages but if we were to add a regular print for every
single type of failure we'd clutter the code, we don't want that.

  Luis
