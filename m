Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A07158DD8;
	Tue,  8 Apr 2025 19:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139964; cv=none; b=P0xX7goX5kGqqb4QFvZkv4dn6MEELrvZHW2pkmfRGuGMhulpwuYHvB2dakTA43tv181iOEnqCsyQL+MBONVq2Qv05nLiaS3vYOSamL6JH4O4b+iABZxHSLxyGukUCjpVjvmy3+sBpEBlVGA1mNbIIJfOwXqOqaNZQAFOTYDWZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139964; c=relaxed/simple;
	bh=A7IwUd4QZ8+UrR9RJGg2Ngbu0P/FJmrd+5uVDcuUtnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Md70XWEE5rmLiBHISQCyT3EpZkCnwzvs+A1lUj5MIYrkpmOPfrw0MkW013B8V1GCxCeYzQHjzYBz58Tlij3F2KLssMK0V1pnKf45ioVZgyst5yqLwLccE76ffRcv3Vg56z7FQxyS13NNkBS7Iar5PerkS5A6cZ3eIS96pdUKj+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=R2qbf+px; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="R2qbf+px"
Received: by linux.microsoft.com (Postfix, from userid 1152)
	id DEDE52113E93; Tue,  8 Apr 2025 12:19:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DEDE52113E93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744139962;
	bh=WBCPzbnAp+2ozc5rW0RmWhRD4Gw4jg0TidVEx4G5Bxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2qbf+pxf405gn++jArGSz3Z2sAZlfjEIVS8kqQppbFgECEOigRVfl2deveRiLG+Q
	 bxHy0f60mCOlRPt1cW3k/Zp1ns/8nePbOk35Cahlaovp6AsyzklOy/ypolXl0IMSUw
	 lwBlBUMIuvTzbJ4iGLSXDwhNIgqph8A+/jpHIca4=
Date: Tue, 8 Apr 2025 12:19:22 -0700
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	code@tyhicks.com, linux@rasmusvillemoes.dk,
	christophe.leroy@csgroup.eu, hch@infradead.org, mcgrof@kernel.org,
	frkaya@linux.microsoft.com, vijayb@linux.microsoft.com,
	linux@weissschuh.net, samitolvanen@google.com, da.gomez@samsung.com,
	rafael@kernel.org, dakr@kernel.org
Subject: Re: [PATCH v4 0/4] Properly handle module_kobject creation
Message-ID: <20250408191922.GA21875@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250227184930.34163-1-shyamsaini@linux.microsoft.com>
 <ae1f74bd-4e8c-4031-8175-240f5f8d7f17@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae1f74bd-4e8c-4031-8175-240f5f8d7f17@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Greg,

> On 2/27/25 19:49, Shyam Saini wrote:
> > Hi Everyone,
> > 
> > This patch series fixes handling of module_kobject creation.
> > A driver expect module_kset list populated with its corresponding
> > module_kobject to create its /sys/module/<built-in-module>/drivers
> > directory.
> > 
> > Since,
> > [1] commit 96a1a2412acb ("kernel/params.c: defer most of param_sysfs_init() to late_initcall time")
> > Call to populate module_kset list is deferred to save init time so that
> > external watchdog doesn't fireup on some boards and Linux can take
> > responsibility of feeding watchdog before it spuriously resets the
> > system. However, [1] this fix caused another issue i.e, consumers
> > of module_kset can't get related module_kobject during driver
> > initialisation and hence can't create their
> > /sys/module/<built-in-module>/drivers directory.
> > 
> > Consequently, [1] breaks user-space applications for eg: DPDK, which
> > expects /sys/module/vfio_pci/drivers/pci:vfio-pci/new_id to be present.
> > 
> > The second issue was reported and the [2] revert of [1] was
> > proposed. However, [2] the Revert doesn't address the original issue
> > reported in [1].
> > 
> > This patch series addresses both issues reported in [1] and [2].
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96a1a2412acb
> > [2] https://lore.kernel.org/lkml/20250130225803.321004-1-shyamsaini@linux.microsoft.com/
> 
> This looks ok to me. I only think the Fixes: tag should have remained
> solely on the last patch in the series as that is the actual fix. I'll
> adjust it when picking up the patches.
> 
> I'm going to wait for a few days if others still would like to comment
> and then plan to queue this on modules-next.
> 
> @Greg, could I please get an Acked-by from you on the last patch in the
> series as this affects the code in the driver core?
> 

sorry for the frequent pings, could you please Ack last patch of this series
or perhaps provide any feedback ?

Thanks,
Shyam
