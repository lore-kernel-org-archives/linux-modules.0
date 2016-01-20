Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43105 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933274AbcATDTg (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Tue, 19 Jan 2016 22:19:36 -0500
Date: Wed, 20 Jan 2016 11:22:34 +0800
From: Minfei Huang <mhuang@redhat.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org,
	Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	kexec@lists.infradead.org, David Howells <dhowells@redhat.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	linux-modules@vger.kernel.org
Subject: Re: [RFC PATCH v2 06/11] kexec: replace call to copy_file_from_fd()
 with kernel version
Message-ID: <20160120032234.GA20122@dhcp-128-25.nay.redhat.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-7-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453129886-20192-7-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On 01/18/16 at 10:11am, Mimi Zohar wrote:
> diff --git a/fs/exec.c b/fs/exec.c
> index 211b81c..a5ae51e 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -884,6 +884,21 @@ out:
>  }
>  EXPORT_SYMBOL_GPL(kernel_read_file);
>  
> +int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
> +			     int policy_id)
> +{
> +	struct fd f = fdget(fd);
> +	int ret = -ENOEXEC;
> +
> +	if (!f.file)
> +		goto out;

It is no need to call the fdput, if f.file is NULL. It is better to
return it directly.

> +
> +	ret = kernel_read_file(f.file, buf, size, max_size, policy_id);
> +out:
> +	fdput(f);
> +	return ret;
> +}
> +

Thanks
Minfei
