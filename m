Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:34912 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932702AbcAST0G (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Tue, 19 Jan 2016 14:26:06 -0500
MIME-Version: 1.0
In-Reply-To: <1453129886-20192-4-git-send-email-zohar@linux.vnet.ibm.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1453129886-20192-4-git-send-email-zohar@linux.vnet.ibm.com>
Date: Tue, 19 Jan 2016 21:26:04 +0200
Message-ID: <CACE9dm8nd+zf-GKzdo1xYfedGhKSEtUrS2UrmARf2t+PKYNTgA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/11] ima: provide buffer hash calculation function
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jan 18, 2016 at 5:11 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> From: Dmitry Kasatkin <d.kasatkin@samsung.com>
>
> This patch provides convenient buffer hash calculation function.
>
> Changelog:
> - rewrite to support loff_t sized buffers - Mimi
>   (based on Fenguang Wu's testing)
>
> Signed-off-by: Dmitry Kasatkin <d.kasatkin@samsung.com>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  security/integrity/ima/ima.h        |  2 ++
>  security/integrity/ima/ima_crypto.c | 47 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index fb8da36..de53631 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -107,6 +107,8 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>                            const char *op, struct inode *inode,
>                            const unsigned char *filename);
>  int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash);
> +int ima_calc_buffer_hash(const void *buf, loff_t len,
> +                        struct ima_digest_data *hash);
>  int ima_calc_field_array_hash(struct ima_field_data *field_data,
>                               struct ima_template_desc *desc, int num_fields,
>                               struct ima_digest_data *hash);
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> index fb30ce4..8d86281 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -519,6 +519,53 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
>         return rc;
>  }
>
> +static int calc_buffer_shash_tfm(const void *buf, loff_t size,
> +                               struct ima_digest_data *hash,
> +                               struct crypto_shash *tfm)
> +{
> +       SHASH_DESC_ON_STACK(shash, tfm);
> +       unsigned int len;
> +       loff_t offset = 0;
> +       int rc;
> +
> +       shash->tfm = tfm;
> +       shash->flags = 0;
> +
> +       hash->length = crypto_shash_digestsize(tfm);
> +
> +       rc = crypto_shash_init(shash);
> +       if (rc != 0)
> +               return rc;
> +
> +       len = size < PAGE_SIZE ? size : PAGE_SIZE;
> +       while (offset < size) {
> +               rc = crypto_shash_update(shash, buf + offset, len);
> +               if (rc)
> +                       break;
> +               offset += len;
> +       }
> +

Hello Mimi,

May be this was my earlier patch, but it seems to have a problem of
accessing beyond end of buffer using the same len.
When buffer always padded by zeros it is not a problem, but it is a bug.

This seems to be better version.

   while (size) {
               len = size < PAGE_SIZE ? size : PAGE_SIZE;
               rc = crypto_shash_update(shash, buf, len);
               if (rc)
                       break;
               buf += len;
               size -= len;
    }

Please change my sign-of to: dmitry.kasatkin@huawei.com

Thanks.
Dmitry
> +       if (!rc)
> +               rc = crypto_shash_final(shash, hash->digest);
> +       return rc;
> +}
> +
> +int ima_calc_buffer_hash(const void *buf, loff_t len,
> +                        struct ima_digest_data *hash)
> +{
> +       struct crypto_shash *tfm;
> +       int rc;
> +
> +       tfm = ima_alloc_tfm(hash->algo);
> +       if (IS_ERR(tfm))
> +               return PTR_ERR(tfm);
> +
> +       rc = calc_buffer_shash_tfm(buf, len, hash, tfm);
> +
> +       ima_free_tfm(tfm);
> +       return rc;
> +}
> +
>  static void __init ima_pcrread(int idx, u8 *pcr)
>  {
>         if (!ima_used_chip)
> --
> 2.1.0
>



-- 
Thanks,
Dmitry
