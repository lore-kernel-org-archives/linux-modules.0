Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:35969 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbcBJTdF (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 10 Feb 2016 14:33:05 -0500
MIME-Version: 1.0
In-Reply-To: <1454526390-19792-3-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1454526390-19792-3-git-send-email-zohar@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2016 21:33:03 +0200
Message-ID: <CACE9dm_knTPnEfw8RXzFux50gJqaECFfGeTDaeLxWuc5KNqvxQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/22] ima: refactor ima_policy_show() to display
 "ima_hooks" rules
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 3, 2016 at 9:06 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Define and call a function to display the "ima_hooks" rules.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>

> ---
>  security/integrity/ima/ima_policy.c | 63 +++++++++++++++++++++----------------
>  1 file changed, 36 insertions(+), 27 deletions(-)
>
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index e0e18cc..43b6425 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -903,6 +903,40 @@ void ima_policy_stop(struct seq_file *m, void *v)
>  #define mt(token)      mask_tokens[token]
>  #define ft(token)      func_tokens[token]
>
> +/*
> + * policy_func_show - display the ima_hooks policy rule
> + */
> +static void policy_func_show(struct seq_file *m, enum ima_hooks func)
> +{
> +       char tbuf[64] = {0,};
> +
> +       switch (func) {
> +       case FILE_CHECK:
> +               seq_printf(m, pt(Opt_func), ft(func_file));
> +               break;
> +       case MMAP_CHECK:
> +               seq_printf(m, pt(Opt_func), ft(func_mmap));
> +               break;
> +       case BPRM_CHECK:
> +               seq_printf(m, pt(Opt_func), ft(func_bprm));
> +               break;
> +       case MODULE_CHECK:
> +               seq_printf(m, pt(Opt_func), ft(func_module));
> +               break;
> +       case FIRMWARE_CHECK:
> +               seq_printf(m, pt(Opt_func), ft(func_firmware));
> +               break;
> +       case POST_SETATTR:
> +               seq_printf(m, pt(Opt_func), ft(func_post));
> +               break;
> +       default:
> +               snprintf(tbuf, sizeof(tbuf), "%d", func);
> +               seq_printf(m, pt(Opt_func), tbuf);
> +               break;
> +       }
> +       seq_puts(m, " ");
> +}
> +
>  int ima_policy_show(struct seq_file *m, void *v)
>  {
>         struct ima_rule_entry *entry = v;
> @@ -924,33 +958,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>
>         seq_puts(m, " ");
>
> -       if (entry->flags & IMA_FUNC) {
> -               switch (entry->func) {
> -               case FILE_CHECK:
> -                       seq_printf(m, pt(Opt_func), ft(func_file));
> -                       break;
> -               case MMAP_CHECK:
> -                       seq_printf(m, pt(Opt_func), ft(func_mmap));
> -                       break;
> -               case BPRM_CHECK:
> -                       seq_printf(m, pt(Opt_func), ft(func_bprm));
> -                       break;
> -               case MODULE_CHECK:
> -                       seq_printf(m, pt(Opt_func), ft(func_module));
> -                       break;
> -               case FIRMWARE_CHECK:
> -                       seq_printf(m, pt(Opt_func), ft(func_firmware));
> -                       break;
> -               case POST_SETATTR:
> -                       seq_printf(m, pt(Opt_func), ft(func_post));
> -                       break;
> -               default:
> -                       snprintf(tbuf, sizeof(tbuf), "%d", entry->func);
> -                       seq_printf(m, pt(Opt_func), tbuf);
> -                       break;
> -               }
> -               seq_puts(m, " ");
> -       }
> +       if (entry->flags & IMA_FUNC)
> +               policy_func_show(m, entry->func);
>
>         if (entry->flags & IMA_MASK) {
>                 if (entry->mask & MAY_EXEC)
> --
> 2.1.0
>



-- 
Thanks,
Dmitry
