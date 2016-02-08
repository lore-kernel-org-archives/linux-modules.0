Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:31704 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbcBHJ6i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 8 Feb 2016 04:58:38 -0500
From: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
To: Petko Manolov <petkan@mip-labs.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>
CC: "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"fsdevel@vger.kernel.org" <fsdevel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>
Subject: RE: [PATCH v3 20/22] ima: load policy using path
Date: Mon, 8 Feb 2016 09:58:16 +0000
Message-ID: <C2D7A727C393B644B70DF4B4DCFB60B9C8A843@lhreml507-mbx.china.huawei.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-21-git-send-email-zohar@linux.vnet.ibm.com>,<20160207195945.GG17321@localhost>
In-Reply-To: <20160207195945.GG17321@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


________________________________________
From: Petko Manolov [petkan@mip-labs.com]
Sent: Sunday, February 07, 2016 9:59 PM
To: Mimi Zohar
Cc: linux-security-module@vger.kernel.org; Luis R. Rodriguez; kexec@lists.infradead.org; linux-modules@vger.kernel.org; fsdevel@vger.kernel.org; David Howells; David Woodhouse; Kees Cook; Dmitry Torokhov; Dmitry Kasatkin; Eric Biederman; Rusty Russell; Dmitry Kasatkin; Dmitry Kasatkin
Subject: Re: [PATCH v3 20/22] ima: load policy using path

On 16-02-03 14:06:28, Mimi Zohar wrote:
> From: Dmitry Kasatkin <d.kasatkin@samsung.com>
>
> We currently cannot do appraisal or signature vetting of IMA policies
> since we currently can only load IMA policies by writing the contents
> of the policy directly in, as follows:
>
> cat policy-file > <securityfs>/ima/policy
>
> If we provide the kernel the path to the IMA policy so it can load
> the policy itself it'd be able to later appraise or vet the file
> signature if it has one.  This patch adds support to load the IMA
> policy with a given path as follows:
>
> echo /etc/ima/ima_policy > /sys/kernel/security/ima/policy
>
> Changelog v3:
> - moved kernel_read_file_from_path() to a separate patch
> v2:
> - after re-ordering the patches, replace calling integrity_kernel_read()
>   to read the file with kernel_read_file_from_path() (Mimi)
> - Patch description re-written by Luis R. Rodriguez
>
> Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  include/linux/fs.h              |  1 +
>  security/integrity/ima/ima_fs.c | 43 +++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d4d556e..b648e6d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2531,6 +2531,7 @@ enum kernel_read_file_id {
>       READING_MODULE,
>       READING_KEXEC_IMAGE,
>       READING_KEXEC_INITRAMFS,
> +     READING_POLICY,
>       READING_MAX_ID
>  };
>
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index f355231..00ccd67 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -22,6 +22,7 @@
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
>  #include <linux/parser.h>
> +#include <linux/vmalloc.h>
>
>  #include "ima.h"
>
> @@ -258,6 +259,41 @@ static const struct file_operations ima_ascii_measurements_ops = {
>       .release = seq_release,
>  };
>
> +static ssize_t ima_read_policy(char *path)
> +{
> +     void *data;
> +     char *datap;
> +     loff_t size;
> +     int rc, pathlen = strlen(path);
> +
> +     char *p;
> +
> +     /* remove \n */
> +     datap = path;
> +     strsep(&datap, "\n");
> +
> +     rc = kernel_read_file_from_path(path, &data, &size, 0, READING_POLICY);
> +     if (rc < 0)
> +             return rc;
> +
> +     datap = data;
> +     while (size > 0 && (p = strsep(&datap, "\n"))) {
> +             pr_debug("rule: %s\n", p);
> +             rc = ima_parse_add_rule(p);
> +             if (rc < 0)
> +                     break;
> +             size -= rc;
> +     }
> +
> +     vfree(data);
> +     if (rc < 0)
> +             return rc;
> +     else if (size)
> +             return -EINVAL;
> +     else
> +             return pathlen;
> +}
> +
>  static ssize_t ima_write_policy(struct file *file, const char __user *buf,
>                               size_t datalen, loff_t *ppos)
>  {
> @@ -286,9 +322,12 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
>       result = mutex_lock_interruptible(&ima_write_mutex);
>       if (result < 0)
>               goto out_free;
> -     result = ima_parse_add_rule(data);
> -     mutex_unlock(&ima_write_mutex);
>
> +     if (data[0] == '/')

>It seems that if we feed relative path to ima_policy the update will fail...

Yes, i think it is always a good idea to pass absolute path.

Dmitry

> +             result = ima_read_policy(data);
> +     else
> +             result = ima_parse_add_rule(data);
> +     mutex_unlock(&ima_write_mutex);
>  out_free:
>       kfree(data);
>  out:
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
