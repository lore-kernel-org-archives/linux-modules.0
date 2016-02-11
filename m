Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from nm43-vm5.bullet.mail.bf1.yahoo.com ([216.109.114.236]:60829
	"EHLO nm43-vm5.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751624AbcBKRAc (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 11 Feb 2016 12:00:32 -0500
Subject: Re: [PATCH v3 14/22] security: define kernel_read_file hook
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	linux-security-module@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-15-git-send-email-zohar@linux.vnet.ibm.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <56BCBCA9.3040102@schaufler-ca.com>
Date: Thu, 11 Feb 2016 08:54:01 -0800
MIME-Version: 1.0
In-Reply-To: <1454526390-19792-15-git-send-email-zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On 2/3/2016 11:06 AM, Mimi Zohar wrote:
> The kernel_read_file security hook is called prior to reading the file
> into memory.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Being able to deny the read prior to performing any
real work makes a lot of sense.

> ---
>  fs/exec.c                         |  4 ++++
>  include/linux/ima.h               |  6 ++++++
>  include/linux/lsm_hooks.h         |  8 ++++++++
>  include/linux/security.h          |  7 +++++++
>  security/integrity/ima/ima_main.c | 16 ++++++++++++++++
>  security/security.c               | 12 ++++++++++++
>  6 files changed, 53 insertions(+)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 5629958..1d39c4e 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -842,6 +842,10 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>  	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
>  		return -EINVAL;
>  
> +	ret = security_kernel_read_file(file, id);
> +	if (ret)
> +		return ret;
> +
>  	i_size = i_size_read(file_inode(file));
>  	if (max_size > 0 && i_size > max_size)
>  		return -EFBIG;
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 7aea486..6adcaea 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -19,6 +19,7 @@ extern int ima_file_check(struct file *file, int mask, int opened);
>  extern void ima_file_free(struct file *file);
>  extern int ima_file_mmap(struct file *file, unsigned long prot);
>  extern int ima_module_check(struct file *file);
> +extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
>  extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  			      enum kernel_read_file_id id);
>  
> @@ -48,6 +49,11 @@ static inline int ima_module_check(struct file *file)
>  	return 0;
>  }
>  
> +static inline int ima_read_file(struct file *file, enum kernel_read_file_id id)
> +{
> +	return 0;
> +}
> +
>  static inline int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  				     enum kernel_read_file_id id)
>  {
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 7d04a12..d32b7bd 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -552,6 +552,12 @@
>   *	the kernel module to load. If the module is being loaded from a blob,
>   *	this argument will be NULL.
>   *	Return 0 if permission is granted.
> + * @kernel_read_file:
> + *	Read a file specified by userspace.
> + *	@file contains the file structure pointing to the file being read
> + *	by the kernel.
> + *	@id kernel read file identifier
> + *	Return 0 if permission is granted.
>   * @kernel_post_read_file:
>   *	Read a file specified by userspace.
>   *	@file contains the file structure pointing to the file being read
> @@ -1455,6 +1461,7 @@ union security_list_options {
>  	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
>  	int (*kernel_module_request)(char *kmod_name);
>  	int (*kernel_module_from_file)(struct file *file);
> +	int (*kernel_read_file)(struct file *file, enum kernel_read_file_id id);
>  	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
>  				     enum kernel_read_file_id id);
>  	int (*task_fix_setuid)(struct cred *new, const struct cred *old,
> @@ -1715,6 +1722,7 @@ struct security_hook_heads {
>  	struct list_head cred_transfer;
>  	struct list_head kernel_act_as;
>  	struct list_head kernel_create_files_as;
> +	struct list_head kernel_read_file;
>  	struct list_head kernel_post_read_file;
>  	struct list_head kernel_module_request;
>  	struct list_head kernel_module_from_file;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index cee1349..071fb74 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -302,6 +302,7 @@ int security_kernel_act_as(struct cred *new, u32 secid);
>  int security_kernel_create_files_as(struct cred *new, struct inode *inode);
>  int security_kernel_module_request(char *kmod_name);
>  int security_kernel_module_from_file(struct file *file);
> +int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
>  int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
>  				   enum kernel_read_file_id id);
>  int security_task_fix_setuid(struct cred *new, const struct cred *old,
> @@ -863,6 +864,12 @@ static inline int security_kernel_module_from_file(struct file *file)
>  	return 0;
>  }
>  
> +static inline int security_kernel_read_file(struct file *file,
> +					    enum kernel_read_file_id id)
> +{
> +	return 0;
> +}
> +
>  static inline int security_kernel_post_read_file(struct file *file,
>  						 char *buf, loff_t size,
>  						 enum kernel_read_file_id id)
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 4a5db31..6f79bdf 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -338,6 +338,22 @@ int ima_module_check(struct file *file)
>  }
>  
>  /**
> + * ima_read_file - pre-measure/appraise hook decision based on policy
> + * @file: pointer to the file to be measured/appraised/audit
> + * @read_id: caller identifier
> + *
> + * Permit reading a file based on policy. The policy rules are written
> + * in terms of the policy identifier.  Appraising the integrity of
> + * a file requires a file descriptor.
> + *
> + * For permission return 0, otherwise return -EACCES.
> + */
> +int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
> +{
> +	return 0;
> +}
> +
> +/**
>   * ima_post_read_file - in memory collect/appraise/audit measurement
>   * @file: pointer to the file to be measured/appraised/audit
>   * @buf: pointer to in memory file contents
> diff --git a/security/security.c b/security/security.c
> index 81a4c3a..1728fe2 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -899,6 +899,16 @@ int security_kernel_module_from_file(struct file *file)
>  	return ima_module_check(file);
>  }
>  
> +int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
> +{
> +	int ret;
> +
> +	ret = call_int_hook(kernel_read_file, 0, file, id);
> +	if (ret)
> +		return ret;
> +	return ima_read_file(file, id);
> +}
> +
>  int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
>  				   enum kernel_read_file_id id)
>  {
> @@ -1695,6 +1705,8 @@ struct security_hook_heads security_hook_heads = {
>  		LIST_HEAD_INIT(security_hook_heads.kernel_module_request),
>  	.kernel_module_from_file =
>  		LIST_HEAD_INIT(security_hook_heads.kernel_module_from_file),
> +	.kernel_read_file =
> +		LIST_HEAD_INIT(security_hook_heads.kernel_read_file),
>  	.kernel_post_read_file =
>  		LIST_HEAD_INIT(security_hook_heads.kernel_post_read_file),
>  	.task_fix_setuid =

