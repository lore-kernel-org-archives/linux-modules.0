Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9583038C2C8;
	Mon, 16 Mar 2026 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655388; cv=none; b=J7dYemPmUX53C+VZ8kdHTK1zLNztNLr/ZJNTQYUvRNpMZFYdalDOlYIecqcEchTPsZyej6GAYH3Sa0L/Xtkye97cHQrHH/LtyoSQ3oishMi3L028MVpBgl7P/s8tw5B/biw7S2YSI62Q3gZd/iTWMOowiVM/oYVmxAnUIf3lUYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655388; c=relaxed/simple;
	bh=THNcfZ0++srLzzaWy3ftlDPtfcjjqIQGjT6qrdeMrOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mU2KOaB3bS19BB9naarh4+a9UsOQ5nJbzc3stUHLYRyJM4Q24sFwCrVyqHx/eGTl7vqNOt9yVzweG7fo/Nf+8pDx+rfTRyfAgMYtwX4Ji+sLGewrUbDTI4o60OkVgmiP7NGLXRZWGex63ccKAU8AYjM/bNnWhCaPP7CVy841/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FdYDbfW1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FdYDbfW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B73C19421;
	Mon, 16 Mar 2026 10:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773655388;
	bh=THNcfZ0++srLzzaWy3ftlDPtfcjjqIQGjT6qrdeMrOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FdYDbfW1t6V76qLyQGQIc3LgIXhICtdy3f5FvdwepmX0Q2Ge5g1R3EChLi9uA4kds
	 jwlfqz9gIZkTzyUVir8GDRG70RKY5lVSLo+oX0KT94nZdzAz3OTY7B5GVjHihgh9n6
	 7b+3BtDVEpGfoN1A+5JPSQX28Os9ZLjb1vXX/uGA=
Date: Mon, 16 Mar 2026 11:03:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] module: remove MODULE_VERSION()
Message-ID: <2026031630-linseed-powdered-a0d1@gregkh>
References: <2026031341-evolve-repeater-987b@gregkh>
 <d622c70a-f79a-4215-84fb-c5de0a8f6ce5@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d622c70a-f79a-4215-84fb-c5de0a8f6ce5@suse.com>

On Mon, Mar 16, 2026 at 10:37:38AM +0100, Petr Pavlu wrote:
> On 3/13/26 3:20 PM, Greg Kroah-Hartman wrote:
> > Module "versions" do not make sense as the kernel is built all at once,
> > the "version" is the overall kernel version number, so modules can not
> > really be described as having a unique version given that they rely on
> > the infrastructure of the whole kernel.
> > 
> > For now, just make this an "empty" define, to keep existing code
> > building properly as the tree is slowly purged of the use of this over
> > time.
> > 
> > This macro will be removed entirely in the future when there are no
> > in-tree users.
> 
> I share a similar sentiment that module versions set by MODULE_VERSION()
> are not particularly useful for in-tree modules and the macro is often
> used unnecessarily. However, I don't think this patch takes the best
> approach to phase it out.
> 
> The file Documentation/ABI/stable/sysfs-module documents
> /sys/module/<MODULENAME>/version as a stable ABI. Searching for
> '^MODULE_VERSION' in v7.0-rc4 shows 600 uses of the macro. My concern is
> that if any of these modules has a userspace part that checks the
> version, this patch could potentially break users' systems.

sysfs use is ALWAYS "if the file is not there, the userspace tool should
keep working".  How would userspace every do something different if a
module version flag is not there, that is not how a kernel driver should
ever be attempting to communicate with userspace as to what the api is,
or is not.

And as the module version does not even work for any stable kernel
release, it's kind of proof that userspace does not rely on this.

> I believe it would be safer to start by removing individual uses of
> MODULE_VERSION(). That way, we can also learn if we're missing any use
> cases for having module versions.

Sure, I'll make up a patch to drop all 700 uses, but how is that much
different?  :)

> The original patch "Add a MODULE_VERSION macro" [1] from 2004 doesn't
> say much about the motivation for adding module versions, but it does
> mention that they should be accessible via sysfs.

That was because we were just exporting all of the module information in
sysfs, not due to us attempting to do anything special with that info in
userspace other than "hey we have an attribute, let's export it!"

> That was implemented
> a year later in commit c988d2b28454 ("[PATCH] modules: add version and
> srcversion to sysfs") [2], which primarily discusses use cases related
> to DKMS, and to administrators + tech support needing to know what is
> actually loaded on the system. For the latter, I believe srcversion (or
> something similar) should be sufficient.

And does dkms actually do anything with this sysfs value?  At quick
glance, I couldn't see anything.

thanks,

greg k-h
