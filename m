Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59566 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348AbcATXMp (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Wed, 20 Jan 2016 18:12:45 -0500
Date: Thu, 21 Jan 2016 00:12:40 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [RFC PATCH v2 06/11] kexec: replace call to copy_file_from_fd()
 with kernel version
Message-ID: <20160120231240.GL11277@wotan.suse.de>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-7-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453129886-20192-7-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jan 18, 2016 at 10:11:21AM -0500, Mimi Zohar wrote:
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
> +
> +	ret = kernel_read_file(f.file, buf, size, max_size, policy_id);
> +out:
> +	fdput(f);
> +	return ret;
> +}
> +

Don't you need to EXPORT_SYMBOL_GPL() here as well?

> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 4edf47f..3adf937 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -78,6 +78,8 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
>  		return iint->ima_module_status;
>  	case FIRMWARE_CHECK:
>  		return iint->ima_firmware_status;
> +	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
> +		return iint->ima_read_status;

I didn't get the memo that we're OK to use compiler specific extensions
like this. I'm sure if you are using it its not the first case, just
want to be sure we are aware of possible issues if some compiler doesn't
support this.

If we don't have a precedence can we just avoid its use?

Cc'd Julia in case this might be of interest for Coccinelle to grok.

>  	case FILE_CHECK:
>  	default:
>  		return iint->ima_file_status;
> @@ -100,6 +102,9 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
>  	case FIRMWARE_CHECK:
>  		iint->ima_firmware_status = status;
>  		break;
> +	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
> +		iint->ima_read_status = status;
> +		break;
>  	case FILE_CHECK:
>  	default:
>  		iint->ima_file_status = status;

Likewise.

> @@ -122,6 +127,8 @@ static void ima_cache_flags(struct integrity_iint_cache *iint, int func)
>  	case FIRMWARE_CHECK:
>  		iint->flags |= (IMA_FIRMWARE_APPRAISED | IMA_APPRAISED);
>  		break;
> +	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
> +		break;
>  	case FILE_CHECK:
>  	default:
>  		iint->flags |= (IMA_FILE_APPRAISED | IMA_APPRAISED);

Likewise.

> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 595e038..4711083 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -306,6 +306,8 @@ static int get_subaction(struct ima_rule_entry *rule, int func)
>  		return IMA_MODULE_APPRAISE;
>  	case FIRMWARE_CHECK:
>  		return IMA_FIRMWARE_APPRAISE;
> +	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
> +		return IMA_READ_APPRAISE;
>  	case FILE_CHECK:
>  	default:
>  		return IMA_FILE_APPRAISE;

Likewise.

> @@ -948,10 +956,19 @@ int ima_policy_show(struct seq_file *m, void *v)
>  			seq_printf(m, pt(Opt_func), ft(func_post));
>  			break;
>  		default:
> -			snprintf(tbuf, sizeof(tbuf), "%d",
> -				 entry->hooks.func);
> -			seq_printf(m, pt(Opt_func), tbuf);
> -			break;
> +			switch (entry->hooks.policy_id) {
> +			case KEXEC_CHECK:
> +				seq_printf(m, pt(Opt_func), ft(func_kexec));
> +				break;
> +			case INITRAMFS_CHECK:
> +				seq_printf(m, pt(Opt_func), ft(func_initramfs));
> +				break;
> +			default:
> +				snprintf(tbuf, sizeof(tbuf), "%d",
> +					 entry->hooks.func);
> +				seq_printf(m, pt(Opt_func), tbuf);
> +				break;
> +			}
>  		}
>  		seq_puts(m, " ");
>  	}

Two switches wrapped tend to lead to messy and hard to read code,
is using a function here better?

  Luis
