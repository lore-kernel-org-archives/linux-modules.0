Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47487 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753318AbcAWC7b (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Fri, 22 Jan 2016 21:59:31 -0500
Date: Sat, 23 Jan 2016 03:59:28 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	kexec@lists.infradead.org, linux-modules@vger.kernel.org,
	fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [RFC PATCH v2 09/11] ima: load policy using path
Message-ID: <20160123025928.GD20964@wotan.suse.de>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-10-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453129886-20192-10-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jan 18, 2016 at 10:11:24AM -0500, Mimi Zohar wrote:
> From: Dmitry Kasatkin <d.kasatkin@samsung.com>
> 
> echo /etc/ima/ima_policy > /sys/kernel/security/ima/policy

>  fs/exec.c                       | 21 ++++++++++++++++++++

> diff --git a/fs/exec.c b/fs/exec.c
> index 3524e5f..5731b40 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -903,6 +903,27 @@ out:
>  	return ret;
>  }
>  
> +int kernel_read_file_from_path(char *path, void **buf, loff_t *size,
> +			       loff_t max_size, int policy_id)
> +{
> +	struct file *file;
> +	int ret;
> +
> +	if (!path || !*path)
> +		return -EINVAL;
> +
> +	file = filp_open(path, O_RDONLY, 0);
> +	if (IS_ERR(file)) {
> +		ret = PTR_ERR(file);
> +		pr_err("Unable to open file: %s (%d)", path, ret);
> +		return ret;
> +	}
> +
> +	ret = kernel_read_file(file, buf, size, max_size, policy_id);
> +	fput(file);
> +	return ret;
> +}
> +

I like this strategy, and can see it being further generalized in
areas of the kernel where we may want self policy / file loading
appraisal. Those policies are now defined through LSMs, in IMA
here you do your own vetting but -- it seems we might better
want instead to enable easily *any* LSM to do its vetting. In this
case I suppose that's still possible given kernel_read_file() is
used and that in turn would have a pre LSM hook and post-LSM hook.

Is that right? If so then it should just be a matter of all other
areas of the kernel to use kernel_read_file_from_path() or
kernel_read_file() to take advantage of similar strategies. Or
is there more work? The other obvious alternative for the heavy
handed users would be to just use the future sysdata helpers, that
in turn would use kernel_read_file_from_path() and still if a
distribution wants can also in the future get kernel signature
verification.

  Luis
