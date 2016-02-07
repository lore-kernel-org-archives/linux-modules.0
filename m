Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from lan.nucleusys.com ([92.247.61.126]:58626 "EHLO
	zztop.nucleusys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754379AbcBGUBM (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Sun, 7 Feb 2016 15:01:12 -0500
Date: Sun, 7 Feb 2016 22:01:48 +0200
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
Subject: Re: [PATCH v3 21/22] ima: measure and appraise the IMA policy itself
Message-ID: <20160207200148.GH17321@localhost>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-22-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454526390-19792-22-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On 16-02-03 14:06:29, Mimi Zohar wrote:
> Add support for measuring and appraising the IMA policy itself.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Acked-by: Petko Manolov <petkan@mip-labs.com>

> ---
>  security/integrity/ima/ima.h        |  2 ++
>  security/integrity/ima/ima_fs.c     |  9 ++++++++-
>  security/integrity/ima/ima_main.c   |  3 +++
>  security/integrity/ima/ima_policy.c | 10 +++++++++-
>  4 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 832e62a..6685968 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -149,6 +149,7 @@ enum ima_hooks {
>  	FIRMWARE_CHECK,
>  	KEXEC_CHECK,
>  	INITRAMFS_CHECK,
> +	POLICY_CHECK,
>  	MAX_CHECK
>  };
>  
> @@ -191,6 +192,7 @@ int ima_policy_show(struct seq_file *m, void *v);
>  #define IMA_APPRAISE_LOG	0x04
>  #define IMA_APPRAISE_MODULES	0x08
>  #define IMA_APPRAISE_FIRMWARE	0x10
> +#define IMA_APPRAISE_POLICY	0x20
>  
>  #ifdef CONFIG_IMA_APPRAISE
>  int ima_appraise_measurement(enum ima_hooks func,
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 00ccd67..7b15e80 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -325,7 +325,14 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
>  
>  	if (data[0] == '/')
>  		result = ima_read_policy(data);
> -	else
> +	else if (ima_appraise & IMA_APPRAISE_POLICY) {
> +		pr_err("IMA: signed policy required\n");
> +		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
> +				    "policy_update", "signed policy required",
> +				    1, 0);
> +		if (ima_appraise & IMA_APPRAISE_ENFORCE)
> +			result = -EACCES;
> +	} else
>  		result = ima_parse_add_rule(data);
>  	mutex_unlock(&ima_write_mutex);
>  out_free:
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index ccf9526..497a6f2 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -386,6 +386,9 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  	case READING_KEXEC_INITRAMFS:
>  		func = INITRAMFS_CHECK;
>  		break;
> +	case READING_POLICY:
> +		func = POLICY_CHECK;
> +		break;
>  	default:
>  		func = FILE_CHECK;
>  		break;
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index d02560e..39a811a 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -114,6 +114,7 @@ static struct ima_rule_entry default_measurement_rules[] = {
>  	 .uid = GLOBAL_ROOT_UID, .flags = IMA_FUNC | IMA_INMASK | IMA_UID},
>  	{.action = MEASURE, .func = MODULE_CHECK, .flags = IMA_FUNC},
>  	{.action = MEASURE, .func = FIRMWARE_CHECK, .flags = IMA_FUNC},
> +	{.action = MEASURE, .func = POLICY_CHECK, .flags = IMA_FUNC},
>  };
>  
>  static struct ima_rule_entry default_appraise_rules[] = {
> @@ -616,6 +617,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  				entry->func = KEXEC_CHECK;
>  			else if (strcmp(args[0].from, "INITRAMFS_CHECK") == 0)
>  				entry->func = INITRAMFS_CHECK;
> +			else if (strcmp(args[0].from, "POLICY_CHECK") == 0)
> +				entry->func = POLICY_CHECK;
>  			else
>  				result = -EINVAL;
>  			if (!result)
> @@ -774,6 +777,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  		temp_ima_appraise |= IMA_APPRAISE_MODULES;
>  	else if (entry->func == FIRMWARE_CHECK)
>  		temp_ima_appraise |= IMA_APPRAISE_FIRMWARE;
> +	else if (entry->func == POLICY_CHECK)
> +		temp_ima_appraise |= IMA_APPRAISE_POLICY;
>  	audit_log_format(ab, "res=%d", !result);
>  	audit_log_end(ab);
>  	return result;
> @@ -860,7 +865,7 @@ static char *mask_tokens[] = {
>  enum {
>  	func_file = 0, func_mmap, func_bprm,
>  	func_module, func_firmware, func_post,
> -	func_kexec, func_initramfs
> +	func_kexec, func_initramfs, func_policy
>  };
>  
>  static char *func_tokens[] = {
> @@ -940,6 +945,9 @@ static void policy_func_show(struct seq_file *m, enum ima_hooks func)
>  	case INITRAMFS_CHECK:
>  		seq_printf(m, pt(Opt_func), ft(func_initramfs));
>  		break;
> +	case POLICY_CHECK:
> +		seq_printf(m, pt(Opt_func), ft(func_policy));
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
