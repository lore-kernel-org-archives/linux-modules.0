Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:41456 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759175AbcAUNZL (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 21 Jan 2016 08:25:11 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Thu, 21 Jan 2016 23:25:08 +1000
Message-ID: <1453382652.9549.142.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 02/11] vfs: define a generic function to read a
 file from the kernel
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Thu, 21 Jan 2016 08:24:12 -0500
In-Reply-To: <20160120010936.GD11277@wotan.suse.de>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1453129886-20192-3-git-send-email-zohar@linux.vnet.ibm.com>
	 <20160120010936.GD11277@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Wed, 2016-01-20 at 02:09 +0100, Luis R. Rodriguez wrote:
> On Mon, Jan 18, 2016 at 10:11:17AM -0500, Mimi Zohar wrote:
> > diff --git a/fs/exec.c b/fs/exec.c
> > index b06623a..6d623c2 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -831,6 +832,58 @@ int kernel_read(struct file *file, loff_t offset,
> >  
> >  EXPORT_SYMBOL(kernel_read);
> >  
> > +int kernel_read_file(struct file *file, void **buf, loff_t *size,
> > +		     loff_t max_size)
> > +{
> > +	loff_t i_size, pos;
> > +	ssize_t bytes = 0;
> > +	int ret;
> > +
> > +	if (!S_ISREG(file_inode(file)->i_mode))
> > +		return -EINVAL;
> > +
> > +	i_size = i_size_read(file_inode(file));
> > +	if (max_size > 0 && i_size > max_size)
> > +		return -EFBIG;
> 
> loff_t is a __kernel_loff_t, which in turn is a long long, and that's
> signed. We don't catch a negative value here, for max_size, we could
> return -EINVAL if its < 0.
> 
> > +	if (i_size == 0)
> > +		return -EINVAL;
> 
> Likewise for i_size. The setter of the size will depend on how the
> code calling this routine setup the struct file passed.
> 
> So how about adding a i_size <= 0 check here as well here?
> At least fw_read_file_contents() has historically done this,
> so if this generic read is going to skip that I'd like to
> see why. We're unifying so I rather be more pedantic.
> 
> Provided this is addressed feel free to peg:
> 
> Reviewed-by: Luis R. Rodriguez <mcgrof@suse.com>

Don't know how I missed that.  Thanks!

Mimi

