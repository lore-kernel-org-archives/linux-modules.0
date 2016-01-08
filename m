Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:34168 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932702AbcAHUhm (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 8 Jan 2016 15:37:42 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 9 Jan 2016 06:37:40 +1000
Message-ID: <1452285405.2651.23.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 2/5] firmware: replace call to
 fw_read_file_contents() with kernel version
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Kexec Mailing List <kexec@lists.infradead.org>,
	linux-modules@vger.kernel.org,
	"linux-fsdevel@vger.kernel.org" <fsdevel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 08 Jan 2016 15:36:45 -0500
In-Reply-To: <CAGXu5jKhjgqvSKiERuGojVX2AK8pubtUHJgR2S=rvbUOgdad3g@mail.gmail.com>
References: <1452280924-28774-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1452280924-28774-3-git-send-email-zohar@linux.vnet.ibm.com>
	 <CAGXu5jKhjgqvSKiERuGojVX2AK8pubtUHJgR2S=rvbUOgdad3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Fri, 2016-01-08 at 12:26 -0800, Kees Cook wrote:
> On Fri, Jan 8, 2016 at 11:22 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > Replace fw_read_file_contents() for reading a file with the common VFS
> > kernel_read_file() function.  Call the existing firmware security hook
> > from security_kernel_post_read_file() until the LSMs have been converted.
> >
> > This patch retains the kernel_fw_from_file() hook, but removes the
> > security_kernel_fw_from_file() function.
> >
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > ---
> >  drivers/base/firmware_class.c     | 51 +++++++++------------------------------
> >  include/linux/ima.h               |  6 -----
> >  include/linux/security.h          |  8 +-----
> >  security/integrity/ima/ima_main.c | 18 ++++++--------
> >  security/security.c               | 24 ++++++++----------
> >  5 files changed, 30 insertions(+), 77 deletions(-)
> >
> > diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
> > index 3ca96a6..4e4e860 100644
> > --- a/drivers/base/firmware_class.c
> > +++ b/drivers/base/firmware_class.c
> > @@ -292,44 +292,10 @@ static const char * const fw_path[] = {
> >  module_param_string(path, fw_path_para, sizeof(fw_path_para), 0644);
> >  MODULE_PARM_DESC(path, "customized firmware image search path with a higher priority than default path");
> >
> > -static int fw_read_file_contents(struct file *file, struct firmware_buf *fw_buf)
> > -{
> > -       int size;
> > -       char *buf;
> > -       int rc;
> > -
> > -       if (!S_ISREG(file_inode(file)->i_mode))
> > -               return -EINVAL;
> > -       size = i_size_read(file_inode(file));
> > -       if (size <= 0)
> > -               return -EINVAL;
> > -       buf = vmalloc(size);
> > -       if (!buf)
> > -               return -ENOMEM;
> > -       rc = kernel_read(file, 0, buf, size);
> > -       if (rc != size) {
> > -               if (rc > 0)
> > -                       rc = -EIO;
> > -               goto fail;
> > -       }
> > -       rc = ima_hash_and_process_file(file, buf, size, FIRMWARE_CHECK);
> > -       if (rc)
> > -               goto fail;
> > -
> > -       rc = security_kernel_fw_from_file(file, buf, size);
> > -       if (rc)
> > -               goto fail;
> > -       fw_buf->data = buf;
> > -       fw_buf->size = size;
> > -       return 0;
> > -fail:
> > -       vfree(buf);
> > -       return rc;
> > -}
> > -
> >  static int fw_get_filesystem_firmware(struct device *device,
> >                                        struct firmware_buf *buf)
> >  {
> > +       loff_t size;
> >         int i, len;
> >         int rc = -ENOENT;
> >         char *path;
> > @@ -355,13 +321,18 @@ static int fw_get_filesystem_firmware(struct device *device,
> >                 file = filp_open(path, O_RDONLY, 0);
> >                 if (IS_ERR(file))
> >                         continue;
> > -               rc = fw_read_file_contents(file, buf);
> > +
> > +               buf->size = 0;
> > +               rc = kernel_read_file(file, &buf->data, &size, UINT_MAX,
> 
> Strictly speaking, the originally code would max at INT_MAX, no UINT_MAX.

hm, I must have taken it from firmware_buf->size, which is defined as
size_t (unsigned).  Thanks for the correction.

Mimi  

