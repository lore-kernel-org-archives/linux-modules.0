Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40388 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933501AbcATBJi (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Tue, 19 Jan 2016 20:09:38 -0500
Date: Wed, 20 Jan 2016 02:09:36 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [RFC PATCH v2 02/11] vfs: define a generic function to read a
 file from the kernel
Message-ID: <20160120010936.GD11277@wotan.suse.de>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-3-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453129886-20192-3-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jan 18, 2016 at 10:11:17AM -0500, Mimi Zohar wrote:
> diff --git a/fs/exec.c b/fs/exec.c
> index b06623a..6d623c2 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -831,6 +832,58 @@ int kernel_read(struct file *file, loff_t offset,
>  
>  EXPORT_SYMBOL(kernel_read);
>  
> +int kernel_read_file(struct file *file, void **buf, loff_t *size,
> +		     loff_t max_size)
> +{
> +	loff_t i_size, pos;
> +	ssize_t bytes = 0;
> +	int ret;
> +
> +	if (!S_ISREG(file_inode(file)->i_mode))
> +		return -EINVAL;
> +
> +	i_size = i_size_read(file_inode(file));
> +	if (max_size > 0 && i_size > max_size)
> +		return -EFBIG;

loff_t is a __kernel_loff_t, which in turn is a long long, and that's
signed. We don't catch a negative value here, for max_size, we could
return -EINVAL if its < 0.

> +	if (i_size == 0)
> +		return -EINVAL;

Likewise for i_size. The setter of the size will depend on how the
code calling this routine setup the struct file passed.

So how about adding a i_size <= 0 check here as well here?
At least fw_read_file_contents() has historically done this,
so if this generic read is going to skip that I'd like to
see why. We're unifying so I rather be more pedantic.

Provided this is addressed feel free to peg:

Reviewed-by: Luis R. Rodriguez <mcgrof@suse.com>

  Luis
