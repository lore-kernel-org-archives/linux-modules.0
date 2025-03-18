Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375D521127E;
	Tue, 18 Mar 2025 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315027; cv=none; b=Ndk8qNAx3iVfT7RdZlx1YjEOaWQlNZFInrrhlr8WY0EawEF17m9BDQP7NeosekPCOngqykhGszRG5dCsrX/jUTVuWDwEy3ce34k0RZu+FZaYk5SOg86RIiuzO0kwrlzLhsIcvGN7Yn/x0WD97+1qLKECtDCjZDzly4kRqphDCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315027; c=relaxed/simple;
	bh=H0VyU5niPt2Corc3rgjQq4JMZQW1ybxG++hZ0Pgp9lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IamuT6v4UBuzB1iXZaTkkyQMckNLUmqDfavnnJAG6fF1d87wyXK8J8itpaB4LKNaiBVNuOs5D8Z9lggQS64JfoD5K6aBC79ll88YfWX7FN+NHqwbW+UN/gggyRN9Wy1raS8RPq+0gDQhNsFpfwWHuEjtrnXiFrRr/ULz5QPZf2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WtYCInzU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WtYCInzU"
Received: by linux.microsoft.com (Postfix, from userid 1152)
	id C1547210B142; Tue, 18 Mar 2025 09:23:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C1547210B142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742315024;
	bh=UYVcYJMuH7XdIAr0gl7kC0+gfugmYJMN1BRCXLDbk1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WtYCInzUBtOxmwdCZuliQKhgyN3DcFxVBeU4m+M2qQ7uv54cpwFSffVWBEl318FTp
	 JqdcpNXI+HOvFpkC5ANXDoWqmvTqiyfUyWfYJDHa3m0j5lgTNc9Y9Pef7X4kmZQPZt
	 fB/KhvAA0JKnAPnmL9U6XnwipWGgkBEIfSQ4d75c=
Date: Tue, 18 Mar 2025 09:23:44 -0700
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, code@tyhicks.com,
	linux@rasmusvillemoes.dk, christophe.leroy@csgroup.eu,
	hch@infradead.org, mcgrof@kernel.org, frkaya@linux.microsoft.com,
	vijayb@linux.microsoft.com, linux@weissschuh.net,
	samitolvanen@google.com, da.gomez@samsung.com, rafael@kernel.org,
	dakr@kernel.org
Subject: Re: [PATCH v4 0/4] Properly handle module_kobject creation
Message-ID: <20250318162344.GA21474@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

do you have any feedback on last patch of this series?

Thanks,
Shyam
