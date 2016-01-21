Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([125.16.236.3]:52743 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759175AbcAUNYb (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 21 Jan 2016 08:24:31 -0500
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Thu, 21 Jan 2016 18:47:34 +0530
Message-ID: <1453382137.9549.134.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 09/11] ima: load policy using path
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: linux-security-module@vger.kernel.org,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	kexec@lists.infradead.org, linux-modules@vger.kernel.org,
	fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Thu, 21 Jan 2016 08:15:37 -0500
In-Reply-To: <20160121000536.GO11277@wotan.suse.de>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1453129886-20192-10-git-send-email-zohar@linux.vnet.ibm.com>
	 <20160121000536.GO11277@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Thu, 2016-01-21 at 01:05 +0100, Luis R. Rodriguez wrote:
> On Mon, Jan 18, 2016 at 10:11:24AM -0500, Mimi Zohar wrote:
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -903,6 +903,27 @@ out:
> >  	return ret;
> >  }
> >  
> > +int kernel_read_file_from_path(char *path, void **buf, loff_t *size,
> > +			       loff_t max_size, int policy_id)
> > +{
> > +	struct file *file;
> > +	int ret;
> > +
> > +	if (!path || !*path)
> > +		return -EINVAL;
> > +
> > +	file = filp_open(path, O_RDONLY, 0);
> > +	if (IS_ERR(file)) {
> > +		ret = PTR_ERR(file);
> > +		pr_err("Unable to open file: %s (%d)", path, ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = kernel_read_file(file, buf, size, max_size, policy_id);
> > +	fput(file);
> > +	return ret;
> > +}
> > +
> 
> EXPORT_SYMBOL_GPL() needed.

Yes.  Thank you for reviewing all the patches!

Mimi

