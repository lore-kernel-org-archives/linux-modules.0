Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from lan.nucleusys.com ([92.247.61.126]:58674 "EHLO
	zztop.nucleusys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753774AbcBGUJ0 (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Sun, 7 Feb 2016 15:09:26 -0500
Date: Sun, 7 Feb 2016 22:10:00 +0200
From: Petko Manolov <petkan@mip-labs.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3 19/22] ima: support for kexec image and initramfs
Message-ID: <20160207201000.GJ17321@localhost>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-20-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454526390-19792-20-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On 16-02-03 14:06:27, Mimi Zohar wrote:
> Add IMA policy support for measuring/appraising the kexec image and
> initramfs.
> 
> Moving the enumeration to the vfs layer simplified the patches, allowing
> the IMA changes, for the most part, to be separated from the other
> changes.  Unfortunately, passing either a kernel_read_file_id or a
> ima_hooks enumeration within IMA is messy.
> 
> Option 1: duplicate kernel_read_file enumeration in ima_hooks
> 
> enum kernel_read_file_id {
> 	...
>         READING_KEXEC_IMAGE,
>         READING_KEXEC_INITRAMFS,
>         READING_MAX_ID
> 
> enum ima_hooks {
> 	...
> 	KEXEC_CHECK
> 	INITRAMFS_CHECK
> 
> Option 2: define ima_hooks as extension of kernel_read_file
> eg: enum ima_hooks {
>         FILE_CHECK = READING_MAX_ID,
>         MMAP_CHECK,
> 
> In order to pass both kernel_read_file_id and ima_hooks values, we
> would need to specify a struct containing a union.
> 
> struct caller_id {
>         union {
>                 enum ima_hooks func_id;
>                 enum kernel_read_file_id read_id;
>         };
> };
> 
> Option 3: incorportate the ima_hooks enumeration into kernel_read_file_id,
> perhaps changing the enumeration name.
> 
> For now, duplicate the new READING_KEXEC_IMAGE/INITRAMFS in ima_hooks.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Option 3 seems the right way to go, but for now:

Acked-by: Petko Manolov <petkan@mip-labs.com>

> ---
>  Documentation/ABI/testing/ima_policy |  2 +-
>  security/integrity/ima/ima.h         |  2 ++
>  security/integrity/ima/ima_main.c    | 19 ++++++++++++++++---
>  security/integrity/ima/ima_policy.c  | 13 ++++++++++++-
>  4 files changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 0a378a8..e80f767 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -26,7 +26,7 @@ Description:
>  			option:	[[appraise_type=]] [permit_directio]
>  
>  		base: 	func:= [BPRM_CHECK][MMAP_CHECK][FILE_CHECK][MODULE_CHECK]
> -				[FIRMWARE_CHECK]
> +				[FIRMWARE_CHECK] [KEXEC_CHECK] [INITRAMFS_CHECK]
>  			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
>  			       [[^]MAY_EXEC]
>  			fsmagic:= hex value
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index a5d2592..832e62a 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -147,6 +147,8 @@ enum ima_hooks {
>  	POST_SETATTR,
>  	MODULE_CHECK,
>  	FIRMWARE_CHECK,
> +	KEXEC_CHECK,
> +	INITRAMFS_CHECK,
>  	MAX_CHECK
>  };
>  
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 1e91d94..ccf9526 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -355,7 +355,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
>  int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  		       enum kernel_read_file_id read_id)
>  {
> -	enum ima_hooks func = FILE_CHECK;
> +	enum ima_hooks func;
>  
>  	if (!file && read_id == READING_FIRMWARE) {
>  		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> @@ -373,10 +373,23 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  		return 0;
>  	}
>  
> -	if (read_id == READING_FIRMWARE)
> +	switch (read_id) {
> +	case READING_FIRMWARE:
>  		func = FIRMWARE_CHECK;
> -	else if (read_id == READING_MODULE)
> +		break;
> +	case READING_MODULE:
>  		func = MODULE_CHECK;
> +		break;
> +	case READING_KEXEC_IMAGE:
> +		func = KEXEC_CHECK;
> +		break;
> +	case READING_KEXEC_INITRAMFS:
> +		func = INITRAMFS_CHECK;
> +		break;
> +	default:
> +		func = FILE_CHECK;
> +		break;
> +	}
>  
>  	return process_measurement(file, buf, size, MAY_READ, func, 0);
>  }
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 7571ce8..d02560e 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -612,6 +612,10 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  				entry->func = MMAP_CHECK;
>  			else if (strcmp(args[0].from, "BPRM_CHECK") == 0)
>  				entry->func = BPRM_CHECK;
> +			else if (strcmp(args[0].from, "KEXEC_CHECK") == 0)
> +				entry->func = KEXEC_CHECK;
> +			else if (strcmp(args[0].from, "INITRAMFS_CHECK") == 0)
> +				entry->func = INITRAMFS_CHECK;
>  			else
>  				result = -EINVAL;
>  			if (!result)
> @@ -855,7 +859,8 @@ static char *mask_tokens[] = {
>  
>  enum {
>  	func_file = 0, func_mmap, func_bprm,
> -	func_module, func_firmware, func_post
> +	func_module, func_firmware, func_post,
> +	func_kexec, func_initramfs
>  };
>  
>  static char *func_tokens[] = {
> @@ -929,6 +934,12 @@ static void policy_func_show(struct seq_file *m, enum ima_hooks func)
>  	case POST_SETATTR:
>  		seq_printf(m, pt(Opt_func), ft(func_post));
>  		break;
> +	case KEXEC_CHECK:
> +		seq_printf(m, pt(Opt_func), ft(func_kexec));
> +		break;
> +	case INITRAMFS_CHECK:
> +		seq_printf(m, pt(Opt_func), ft(func_initramfs));
> +		break;
>  	default:
>  		snprintf(tbuf, sizeof(tbuf), "%d", func);
>  		seq_printf(m, pt(Opt_func), tbuf);
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
