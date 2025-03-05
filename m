Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EE2249E5;
	Wed,  5 Mar 2025 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204871; cv=none; b=ab4Rz29kgkzYqsokUpk+2ri327WTGSnXmwkchZrgzhM7YoRWOMZp2TeUTlGdK6h7RNYAS6yKIln6QSmVf++zM5R+dDo7z3wbOgXWZNQqnGsIRdt5+jLcdkavDzfIOpLCXrROwdGES7a2DPOrwCxvJ8Nc2y+ZuTd7hsvgQGwtANw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204871; c=relaxed/simple;
	bh=OW5tNqcC06LX71bVhrCUPq7xKCsf7aUK6dXgcj4oRw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOZP3I8Jv+i37EoOMR+o6a9lvL4j2ituExn1IGbLXaX4buxSa/VmXASX2uxBzDT1EtONOpKRM9lt46y1wtK0aiLZHqa3Q+xhZ9W9Fl3yj/7i3wmon4SPny8z00/Xf6SCRKiwsWiABzBbF6vpkrZ/B+OQixjYpjnC9VITwk/zh1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pOmg8st0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pOmg8st0"
Received: by linux.microsoft.com (Postfix, from userid 1152)
	id 218C6210EAE7; Wed,  5 Mar 2025 12:01:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 218C6210EAE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741204863;
	bh=wmSzgtidej3ohh2j+A1e/osDQQnpcyEY8AEcwv5GPqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOmg8st0ZMMRp+mTI4YspADi64fHdLVJk4vcVf1ErY5+mkhSr7zWQOtfBpJ3Cv8GX
	 R5HKB2H/NwoTNDS0uDYffOW0C42+9s8rQEb+X7Xd684xPCO36E3vCpPgYLw5hrCdkS
	 QIfgsm5mXbywO1yurVEgtgjNyMGq06lHCaQKtKOU=
Date: Wed, 5 Mar 2025 12:01:03 -0800
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, code@tyhicks.com,
	linux@rasmusvillemoes.dk, christophe.leroy@csgroup.eu,
	hch@infradead.org, mcgrof@kernel.org, frkaya@linux.microsoft.com,
	vijayb@linux.microsoft.com, linux@weissschuh.net,
	samitolvanen@google.com, da.gomez@samsung.com, rafael@kernel.org,
	dakr@kernel.org
Subject: Re: [PATCH v4 0/4] Properly handle module_kobject creation
Message-ID: <20250305200103.GA5760@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

Hi Petr,

On Wed, Mar 05, 2025 at 10:55:03AM +0100, Petr Pavlu wrote:
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

Thank you for pointing that out, will take care of it next time.

I makred rest of the dependent patches for stable inclusion as per this [1] doc and, 
there was a warning from checkpatch scripts without Fixes: tag
WARNING: The commit message has 'stable@', `perhaps it also needs a 'Fixes:' tag?

Thanks,
Shyam

[1] https://docs.kernel.org/process/stable-kernel-rules.html#option-1
