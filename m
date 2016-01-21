Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33495 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670AbcAUAFj (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Wed, 20 Jan 2016 19:05:39 -0500
Date: Thu, 21 Jan 2016 01:05:36 +0100
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
Message-ID: <20160121000536.GO11277@wotan.suse.de>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-10-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453129886-20192-10-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jan 18, 2016 at 10:11:24AM -0500, Mimi Zohar wrote:
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

EXPORT_SYMBOL_GPL() needed.

  Luis
