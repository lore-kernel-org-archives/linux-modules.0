Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:37827 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbcAHUap (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 8 Jan 2016 15:30:45 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 9 Jan 2016 06:30:42 +1000
Message-ID: <1452284986.2651.18.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/5] vfs: define a generic function to read a file
 from the kernel
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
Date: Fri, 08 Jan 2016 15:29:46 -0500
In-Reply-To: <CAGXu5jLBJJ70D7-6JGQ6NEPHHpGia-qFCQfrOt07Kdh+z7x+Lw@mail.gmail.com>
References: <1452280924-28774-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1452280924-28774-2-git-send-email-zohar@linux.vnet.ibm.com>
	 <CAGXu5jLBJJ70D7-6JGQ6NEPHHpGia-qFCQfrOt07Kdh+z7x+Lw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Fri, 2016-01-08 at 12:24 -0800, Kees Cook wrote:
> On Fri, Jan 8, 2016 at 11:22 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > In order to measure and appraise files being read by the kernel,
> > new module and kexec syscalls were defined which include a file
> > descriptor.  Other places in the kernel (eg. firmware, IMA,
> > sound) also read files.
> >
> > This patch introduces a common function for reading files from
> > the kernel with the corresponding security post-read hook and
> > function.
> >
> > Changelog:
> > - Add missing <linux/vmalloc.h>
> >
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > ---
> >  fs/exec.c                 | 56 +++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/fs.h        |  1 +
> >  include/linux/lsm_hooks.h | 11 ++++++++++
> >  include/linux/security.h  |  9 ++++++++
> >  security/security.c       | 16 ++++++++++++++
> >  5 files changed, 93 insertions(+)
> >
> > diff --git a/fs/exec.c b/fs/exec.c
> > index b06623a..3c48a19 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -56,6 +56,7 @@
> >  #include <linux/pipe_fs_i.h>
> >  #include <linux/oom.h>
> >  #include <linux/compat.h>
> > +#include <linux/vmalloc.h>
> >
> >  #include <asm/uaccess.h>
> >  #include <asm/mmu_context.h>
> > @@ -831,6 +832,61 @@ int kernel_read(struct file *file, loff_t offset,
> >
> >  EXPORT_SYMBOL(kernel_read);
> >
> > +int kernel_read_file(struct file *file, void **buf, loff_t *size,
> > +                    loff_t max_size, int policy_id)
> > +{
> > +       loff_t i_size, pos;
> > +       ssize_t bytes = 0;
> > +       int ret;
> > +
> > +       if (!S_ISREG(file_inode(file)->i_mode))
> > +               return -EINVAL;
> > +
> > +       i_size = i_size_read(file_inode(file));
> > +       if (max_size > 0 && i_size > max_size)
> > +               return -EFBIG;
> > +       if (i_size == 0)
> > +               return -EINVAL;
> > +
> > +       *buf = vmalloc(i_size);
> 
> This could get very large -- what risks do we have to system stability
> here? Having userspace able to trigger such a massive allocation could
> be a problem. The firmware loader was limited to MAX_INT...

The different callers allowed different sizes.  Instead of hard coding
the max size for all callers, the third parameter of kernel_file_read is
the caller max_size.
  
Mimi

