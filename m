Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254601DE894;
	Tue,  8 Apr 2025 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744140176; cv=none; b=iWcsbBL7PwRGrxY2dIB8kosscxf81fQaZJcZeofwsILP5/YKjaZS+zXN0CTZiotQmtEEucqqORvJKqCK0DyoLvWGmY4CtsfgMUgUJDis88Z82+CCL//hy0v905ys1h8GFQCbwtQ5Iso3suMsIId07jY6YqZC8cVbfHX9DOvT10I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744140176; c=relaxed/simple;
	bh=K+R5eNFDC+cCjzsNk7Oj+oftuLYW2skRr7/wgykknAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLP5eINNfKJLX7cC/85/hA5zT0TdLsZXx5EVxbDKoms0BmaFwWhy7CKoW0uHMnD/Af5tPDbCgQkKGRA51wsRrbiNxnD6okYzEaM73BRXT+pO1PO+zlzwj3+4w67AZFcBURJV99yRjoGlkMryhd1cAH6NoBnNfZIgGR5pwJ+Kj18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e7goulDZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e7goulDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB1CC4CEE5;
	Tue,  8 Apr 2025 19:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744140175;
	bh=K+R5eNFDC+cCjzsNk7Oj+oftuLYW2skRr7/wgykknAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7goulDZ6aqmNXbbKYms5lTjrrciPWfeWcjHr1z4I+MtS51Puk4DNegwL0HZOXY+o
	 9nJDj7akTkRFJPqiHU7QhezdxNqefl1cMRka8TKTcjMzlGKEkPbLiHK33iFXaxXWaj
	 4959Tvd+rJXj+N6ONffvdNlOcwCxzG1rKgYPOdu0=
Date: Tue, 8 Apr 2025 21:21:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, code@tyhicks.com,
	linux@rasmusvillemoes.dk, christophe.leroy@csgroup.eu,
	hch@infradead.org, mcgrof@kernel.org, frkaya@linux.microsoft.com,
	vijayb@linux.microsoft.com, linux@weissschuh.net,
	samitolvanen@google.com, da.gomez@samsung.com, rafael@kernel.org,
	dakr@kernel.org
Subject: Re: [PATCH v4 0/4] Properly handle module_kobject creation
Message-ID: <2025040804-ambiguous-monorail-53ff@gregkh>
References: <20250227184930.34163-1-shyamsaini@linux.microsoft.com>
 <ae1f74bd-4e8c-4031-8175-240f5f8d7f17@suse.com>
 <20250408191922.GA21875@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408191922.GA21875@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Tue, Apr 08, 2025 at 12:19:22PM -0700, Shyam Saini wrote:
> Hi Greg,
> 
> > On 2/27/25 19:49, Shyam Saini wrote:
> > > Hi Everyone,
> > > 
> > > This patch series fixes handling of module_kobject creation.
> > > A driver expect module_kset list populated with its corresponding
> > > module_kobject to create its /sys/module/<built-in-module>/drivers
> > > directory.
> > > 
> > > Since,
> > > [1] commit 96a1a2412acb ("kernel/params.c: defer most of param_sysfs_init() to late_initcall time")
> > > Call to populate module_kset list is deferred to save init time so that
> > > external watchdog doesn't fireup on some boards and Linux can take
> > > responsibility of feeding watchdog before it spuriously resets the
> > > system. However, [1] this fix caused another issue i.e, consumers
> > > of module_kset can't get related module_kobject during driver
> > > initialisation and hence can't create their
> > > /sys/module/<built-in-module>/drivers directory.
> > > 
> > > Consequently, [1] breaks user-space applications for eg: DPDK, which
> > > expects /sys/module/vfio_pci/drivers/pci:vfio-pci/new_id to be present.
> > > 
> > > The second issue was reported and the [2] revert of [1] was
> > > proposed. However, [2] the Revert doesn't address the original issue
> > > reported in [1].
> > > 
> > > This patch series addresses both issues reported in [1] and [2].
> > > 
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96a1a2412acb
> > > [2] https://lore.kernel.org/lkml/20250130225803.321004-1-shyamsaini@linux.microsoft.com/
> > 
> > This looks ok to me. I only think the Fixes: tag should have remained
> > solely on the last patch in the series as that is the actual fix. I'll
> > adjust it when picking up the patches.
> > 
> > I'm going to wait for a few days if others still would like to comment
> > and then plan to queue this on modules-next.
> > 
> > @Greg, could I please get an Acked-by from you on the last patch in the
> > series as this affects the code in the driver core?
> > 
> 
> sorry for the frequent pings, could you please Ack last patch of this series
> or perhaps provide any feedback ?

The merge window _just_ ended, please give us a chance to catch up...
