Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:36368 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925AbcAHUYm (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 8 Jan 2016 15:24:42 -0500
Received: by mail-io0-f180.google.com with SMTP id g73so100241091ioe.3
        for <linux-modules@vger.kernel.org>; Fri, 08 Jan 2016 12:24:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1452280924-28774-2-git-send-email-zohar@linux.vnet.ibm.com>
References: <1452280924-28774-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1452280924-28774-2-git-send-email-zohar@linux.vnet.ibm.com>
Date: Fri, 8 Jan 2016 12:24:41 -0800
Message-ID: <CAGXu5jLBJJ70D7-6JGQ6NEPHHpGia-qFCQfrOt07Kdh+z7x+Lw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] vfs: define a generic function to read a file
 from the kernel
From: Kees Cook <keescook@chromium.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Kexec Mailing List <kexec@lists.infradead.org>,
	linux-modules@vger.kernel.org,
	"linux-fsdevel@vger.kernel.org" <fsdevel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Fri, Jan 8, 2016 at 11:22 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> In order to measure and appraise files being read by the kernel,
> new module and kexec syscalls were defined which include a file
> descriptor.  Other places in the kernel (eg. firmware, IMA,
> sound) also read files.
>
> This patch introduces a common function for reading files from
> the kernel with the corresponding security post-read hook and
> function.
>
> Changelog:
> - Add missing <linux/vmalloc.h>
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  fs/exec.c                 | 56 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h        |  1 +
>  include/linux/lsm_hooks.h | 11 ++++++++++
>  include/linux/security.h  |  9 ++++++++
>  security/security.c       | 16 ++++++++++++++
>  5 files changed, 93 insertions(+)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index b06623a..3c48a19 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -56,6 +56,7 @@
>  #include <linux/pipe_fs_i.h>
>  #include <linux/oom.h>
>  #include <linux/compat.h>
> +#include <linux/vmalloc.h>
>
>  #include <asm/uaccess.h>
>  #include <asm/mmu_context.h>
> @@ -831,6 +832,61 @@ int kernel_read(struct file *file, loff_t offset,
>
>  EXPORT_SYMBOL(kernel_read);
>
> +int kernel_read_file(struct file *file, void **buf, loff_t *size,
> +                    loff_t max_size, int policy_id)
> +{
> +       loff_t i_size, pos;
> +       ssize_t bytes = 0;
> +       int ret;
> +
> +       if (!S_ISREG(file_inode(file)->i_mode))
> +               return -EINVAL;
> +
> +       i_size = i_size_read(file_inode(file));
> +       if (max_size > 0 && i_size > max_size)
> +               return -EFBIG;
> +       if (i_size == 0)
> +               return -EINVAL;
> +
> +       *buf = vmalloc(i_size);

This could get very large -- what risks do we have to system stability
here? Having userspace able to trigger such a massive allocation could
be a problem. The firmware loader was limited to MAX_INT...

-Kees

> +       if (!*buf) {
> +               ret = -ENOMEM;
> +               goto out;
> +       }
> +
> +       pos = 0;
> +       while (pos < i_size) {
> +               bytes = kernel_read(file, pos, (char *)(*buf) + pos,
> +                                   i_size - pos);
> +               if (bytes < 0) {
> +                       ret = bytes;
> +                       goto out_free;
> +               }
> +
> +               if (bytes == 0)
> +                       break;
> +               pos += bytes;
> +       }
> +
> +       if (pos != i_size) {
> +               ret = -EBADF;  /* firmware uses -EIO */
> +               goto out_free;
> +       }
> +
> +       ret = security_kernel_post_read_file(file, *buf, i_size, policy_id);
> +       if (!ret)
> +               *size = pos;
> +
> +out_free:
> +       if (ret < 0) {
> +               vfree(*buf);
> +               *buf = NULL;
> +       }
> +out:
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(kernel_read_file);
> +
>  ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
>  {
>         ssize_t res = vfs_read(file, (void __user *)addr, len, &pos);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3aa5142..9b1468c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2527,6 +2527,7 @@ static inline void i_readcount_inc(struct inode *inode)
>  extern int do_pipe_flags(int *, int);
>
>  extern int kernel_read(struct file *, loff_t, char *, unsigned long);
> +extern int kernel_read_file(struct file *, void **, loff_t *, loff_t, int);
>  extern ssize_t kernel_write(struct file *, const char *, size_t, loff_t);
>  extern ssize_t __kernel_write(struct file *, const char *, size_t, loff_t *);
>  extern struct file * open_exec(const char *);
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 71969de..10baa8f 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -561,6 +561,14 @@
>   *     the kernel module to load. If the module is being loaded from a blob,
>   *     this argument will be NULL.
>   *     Return 0 if permission is granted.
> + * @kernel_post_read_file:
> + *     Read a file specified by userspace.
> + *     @file contains the file structure pointing to the file being read
> + *     by the kernel.
> + *     @buf pointer to buffer containing the file contents.
> + *     @size length of the file contents.
> + *     @policy_id contains the calling function identifier.
> + *     Return 0 if permission is granted.
>   * @task_fix_setuid:
>   *     Update the module's state after setting one or more of the user
>   *     identity attributes of the current process.  The @flags parameter
> @@ -1457,6 +1465,8 @@ union security_list_options {
>         int (*kernel_fw_from_file)(struct file *file, char *buf, size_t size);
>         int (*kernel_module_request)(char *kmod_name);
>         int (*kernel_module_from_file)(struct file *file);
> +       int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
> +                                    int policy_id);
>         int (*task_fix_setuid)(struct cred *new, const struct cred *old,
>                                 int flags);
>         int (*task_setpgid)(struct task_struct *p, pid_t pgid);
> @@ -1716,6 +1726,7 @@ struct security_hook_heads {
>         struct list_head kernel_act_as;
>         struct list_head kernel_create_files_as;
>         struct list_head kernel_fw_from_file;
> +       struct list_head kernel_post_read_file;
>         struct list_head kernel_module_request;
>         struct list_head kernel_module_from_file;
>         struct list_head task_fix_setuid;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 4824a4c..44d8832 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -301,6 +301,8 @@ int security_kernel_create_files_as(struct cred *new, struct inode *inode);
>  int security_kernel_fw_from_file(struct file *file, char *buf, size_t size);
>  int security_kernel_module_request(char *kmod_name);
>  int security_kernel_module_from_file(struct file *file);
> +int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
> +                                  int policy_id);
>  int security_task_fix_setuid(struct cred *new, const struct cred *old,
>                              int flags);
>  int security_task_setpgid(struct task_struct *p, pid_t pgid);
> @@ -866,6 +868,13 @@ static inline int security_kernel_module_from_file(struct file *file)
>         return 0;
>  }
>
> +static inline int security_kernel_post_read_file(struct file *file,
> +                                                char *buf, loff_t size,
> +                                                int policy_id)
> +{
> +       return 0;
> +}
> +
>  static inline int security_task_fix_setuid(struct cred *new,
>                                            const struct cred *old,
>                                            int flags)
> diff --git a/security/security.c b/security/security.c
> index e8ffd92..e979c2d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -910,6 +910,20 @@ int security_kernel_module_from_file(struct file *file)
>         return ima_module_check(file);
>  }
>
> +int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
> +                                  int policy_id)
> +{
> +       int ret;
> +
> +       ret = call_int_hook(kernel_post_read_file, 0, file, buf, size,
> +                           policy_id);
> +       if (ret)
> +               return ret;
> +
> +       return ima_hash_and_process_file(file, buf, size, policy_id);
> +}
> +EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
> +
>  int security_task_fix_setuid(struct cred *new, const struct cred *old,
>                              int flags)
>  {
> @@ -1697,6 +1711,8 @@ struct security_hook_heads security_hook_heads = {
>                 LIST_HEAD_INIT(security_hook_heads.kernel_module_request),
>         .kernel_module_from_file =
>                 LIST_HEAD_INIT(security_hook_heads.kernel_module_from_file),
> +       .kernel_post_read_file =
> +               LIST_HEAD_INIT(security_hook_heads.kernel_post_read_file),
>         .task_fix_setuid =
>                 LIST_HEAD_INIT(security_hook_heads.task_fix_setuid),
>         .task_setpgid = LIST_HEAD_INIT(security_hook_heads.task_setpgid),
> --
> 2.1.0
>



-- 
Kees Cook
Chrome OS & Brillo Security
