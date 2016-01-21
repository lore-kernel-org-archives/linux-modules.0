Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:32848 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759339AbcAUNTL (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 21 Jan 2016 08:19:11 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Thu, 21 Jan 2016 23:19:09 +1000
Message-ID: <1453382292.9549.136.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 03/11] ima: provide buffer hash calculation
 function
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 21 Jan 2016 08:18:12 -0500
In-Reply-To: <CACE9dm8nd+zf-GKzdo1xYfedGhKSEtUrS2UrmARf2t+PKYNTgA@mail.gmail.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1453129886-20192-4-git-send-email-zohar@linux.vnet.ibm.com>
	 <CACE9dm8nd+zf-GKzdo1xYfedGhKSEtUrS2UrmARf2t+PKYNTgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Tue, 2016-01-19 at 21:26 +0200, Dmitry Kasatkin wrote:
> On Mon, Jan 18, 2016 at 5:11 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > From: Dmitry Kasatkin <d.kasatkin@samsung.com>
> >
> > This patch provides convenient buffer hash calculation function.
> >
> > Changelog:
> > - rewrite to support loff_t sized buffers - Mimi
> >   (based on Fenguang Wu's testing)
> >
> > Signed-off-by: Dmitry Kasatkin <d.kasatkin@samsung.com>
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > ---
> >  security/integrity/ima/ima.h        |  2 ++
> >  security/integrity/ima/ima_crypto.c | 47 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 49 insertions(+)
> >
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > index fb8da36..de53631 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -107,6 +107,8 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
> >                            const char *op, struct inode *inode,
> >                            const unsigned char *filename);
> >  int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash);
> > +int ima_calc_buffer_hash(const void *buf, loff_t len,
> > +                        struct ima_digest_data *hash);
> >  int ima_calc_field_array_hash(struct ima_field_data *field_data,
> >                               struct ima_template_desc *desc, int num_fields,
> >                               struct ima_digest_data *hash);
> > diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> > index fb30ce4..8d86281 100644
> > --- a/security/integrity/ima/ima_crypto.c
> > +++ b/security/integrity/ima/ima_crypto.c
> > @@ -519,6 +519,53 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
> >         return rc;
> >  }
> >
> > +static int calc_buffer_shash_tfm(const void *buf, loff_t size,
> > +                               struct ima_digest_data *hash,
> > +                               struct crypto_shash *tfm)
> > +{
> > +       SHASH_DESC_ON_STACK(shash, tfm);
> > +       unsigned int len;
> > +       loff_t offset = 0;
> > +       int rc;
> > +
> > +       shash->tfm = tfm;
> > +       shash->flags = 0;
> > +
> > +       hash->length = crypto_shash_digestsize(tfm);
> > +
> > +       rc = crypto_shash_init(shash);
> > +       if (rc != 0)
> > +               return rc;
> > +
> > +       len = size < PAGE_SIZE ? size : PAGE_SIZE;
> > +       while (offset < size) {
> > +               rc = crypto_shash_update(shash, buf + offset, len);
> > +               if (rc)
> > +                       break;
> > +               offset += len;
> > +       }
> > +
> 
> Hello Mimi,
> 
> May be this was my earlier patch, but it seems to have a problem of
> accessing beyond end of buffer using the same len.
> When buffer always padded by zeros it is not a problem, but it is a bug.
> 
> This seems to be better version.
> 
>    while (size) {
>                len = size < PAGE_SIZE ? size : PAGE_SIZE;
>                rc = crypto_shash_update(shash, buf, len);
>                if (rc)
>                        break;
>                buf += len;
>                size -= len;
>     }
> 
> Please change my sign-of to: dmitry.kasatkin@huawei.com

Good catch!  I think I unfortunately introduce this bug.  Thank you for
the review!

Mimi

