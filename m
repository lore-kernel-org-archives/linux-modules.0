Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F91116EB76;
	Mon, 12 Aug 2024 10:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458126; cv=none; b=pIa3Teub9np0tQ/k786KKahPJ2niQOf9KTBiq9+EIFdKthrXW+Ff8PPfz9DH0/gctEa7LhbWs/mB4uhYLNhBiebbkQPzXrkzOtcAYKDd9oHWiyc1+u3OyXnjEk+n3qS3ZY3F6gGRj4R918/7cAWrjMk/9WICGpQK0SyhLGtVVKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458126; c=relaxed/simple;
	bh=mXVVIu4+qZY7l0BsfOFXqRGQkdyYfMDlSfr8awgwSnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5Em//T/YIelS6+ZSWZrmf0N95pKIx1fFSZh0Bvtp/D3L7QFODysO29QPA0vF7cwf7c+MvuwYnU5O9lUBVbjZLYnWfDzLDF2HZZ8HpDBb3PrQ7XOF2R8E/VSdbViMN3iZXrfiN8zBFRRu8QItrs7Ty5nG0951zqwGmKkh56YrIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PFOQ8hqq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PFOQ8hqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BD7C32782;
	Mon, 12 Aug 2024 10:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723458126;
	bh=mXVVIu4+qZY7l0BsfOFXqRGQkdyYfMDlSfr8awgwSnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFOQ8hqqSdEC6pLGqQ2vqFxnwTftAmHj6Q2/tVMdc96ouS3zG2lxA58cdXEwH+QFY
	 FnteX2xntHa6zxWAUrQGss6qkApJAIN6pnSp03Yn2ggwX7CtCQsCzGzButh9/VtsCQ
	 iz6qcrROkeFNvHVjrpUEMegCVljI9tJoWbWasAa0=
Date: Mon, 12 Aug 2024 12:22:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, linux-modules@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: Fix a null-ptr-deref in module_add_driver()
Message-ID: <2024081255-yearly-unaligned-f2ed@gregkh>
References: <20240812080658.2791982-1-ruanjinjie@huawei.com>
 <7ea59d03-701c-4555-a8e8-5d7272b9381c@web.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ea59d03-701c-4555-a8e8-5d7272b9381c@web.de>

On Mon, Aug 12, 2024 at 12:18:17PM +0200, Markus Elfring wrote:
> > Inject fault while probing of-fpga-region, if kasprintf() fails in
> > module_add_driver(), the second sysfs_remove_link() in exit path will cause
> > null-ptr-deref as below because kernfs_name_hash() will call strlen() with
> > NULL driver_name.
> …
> 
> How do you think about to use the term “null pointer dereference”
> for the commit message (and summary phrase)?
> 
> 
> …
> > +++ b/drivers/base/module.c
> > @@ -66,27 +66,31 @@ int module_add_driver(struct module *mod, const struct device_driver *drv)
> …
> >  	sysfs_remove_link(mk->drivers_dir, driver_name);
> > +
> > +out_free_driver_name:
> >  	kfree(driver_name);
> >
> > +out_remove_kobj:
> > +	sysfs_remove_link(&drv->p->kobj, "module");
> …
> 
> I suggest to omit two blank lines here.


Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
