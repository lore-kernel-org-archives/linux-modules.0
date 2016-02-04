Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47061 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752495AbcBDU0Z (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 4 Feb 2016 15:26:25 -0500
Date: Thu, 4 Feb 2016 21:26:22 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Kees Cook <keescook@chromium.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	Kexec Mailing List <kexec@lists.infradead.org>,
	linux-modules@vger.kernel.org,
	"linux-fsdevel@vger.kernel.org" <fsdevel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v3 06/22] firmware: fold successful fw read early
Message-ID: <20160204202622.GH12481@wotan.suse.de>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-7-git-send-email-zohar@linux.vnet.ibm.com>
 <CAGXu5j+=4gWSuQHX-iBVGZTsL3UFsLFp74+QeVNcSJHyK+4v8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGXu5j+=4gWSuQHX-iBVGZTsL3UFsLFp74+QeVNcSJHyK+4v8w@mail.gmail.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Thu, Feb 04, 2016 at 09:36:50AM -0800, Kees Cook wrote:
> On Wed, Feb 3, 2016 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > From: David Howells <dhowells@redhat.com>
> >
> > We'll be folding in some more checks on fw_read_file_contents(),
> > this will make the success case easier to follow.
> >
> > Reviewed-by: Josh Boyer <jwboyer@fedoraproject.org>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > ---
> >  drivers/base/firmware_class.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
> > index fb64814..c658cec 100644
> > --- a/drivers/base/firmware_class.c
> > +++ b/drivers/base/firmware_class.c
> > @@ -361,20 +361,18 @@ static int fw_get_filesystem_firmware(struct device *device,
> >                         continue;
> >                 rc = fw_read_file_contents(file, buf);
> >                 fput(file);
> > -               if (rc)
> > +               if (rc == 0) {
> > +                       dev_dbg(device, "direct-loading %s\n",
> > +                               buf->fw_id);
> > +                       fw_finish_direct_load(device, buf);
> > +                       goto out;
> > +               } else
> >                         dev_warn(device, "loading %s failed with error %d\n",
> >                                  path, rc);
> > -               else
> > -                       break;
> >         }
> > +out:
> >         __putname(path);
> >
> > -       if (!rc) {
> > -               dev_dbg(device, "direct-loading %s\n",
> > -                       buf->fw_id);
> > -               fw_finish_direct_load(device, buf);
> > -       }
> > -
> >         return rc;
> >  }
> 
> Looking at this code, why does this use "break":
> 
>                 len = snprintf(path, PATH_MAX, "%s/%s",
>                                fw_path[i], buf->fw_id);
>                 if (len >= PATH_MAX) {
>                         rc = -ENAMETOOLONG;
>                         break;
>                 }
> 
> Shouldn't that emit a warning, set rc, and continue?

Yes but this is a separate piece of code, and that's a functional change but I
welcome the change for sure.  This could be done separately.

> Regardless, I think this is more readable. Adding an "out" target at
> the end of a for loop seems weird, given "break" existing. :)

Good call, goto mixed with while loops can be get iffy.  I'm fine with this
change as a replacement. To be fair we should also note both patches (the one
submitted and yours below) also make a small functional change so that the loop
continues over all other possible directories in the fw_path in case of failure
with the first directory used as a base. If we wanted to be pedantic and careful
we could split the functional change to not enable to continue in case of failure
onto the next directory, and instead require that as a separate patch. I'll leave
it to Mimi to decide.

> 
>                 rc = fw_read_file_contents(file, buf);
>                 fput(file);
> -               if (rc)
> +               if (rc) {
>                         dev_warn(device, "loading %s failed with error %d\n",
>                                  path, rc);
> +                       continue;
> +               }
> +               dev_dbg(device, "direct-loading %s\n", buf->fw_id);
> +               fw_finish_direct_load(device, buf);
> -               else
> -                       break;
> +               break;
>         }
>         __putname(path);
> -
> -       if (!rc) {
> -               dev_dbg(device, "direct-loading %s\n",
> -                       buf->fw_id);
> -               fw_finish_direct_load(device, buf);
> -       }
> -
>         return rc;
>  }

Can you provided a Signed-offy-by? If so consider my Acked-by.

  Luis
