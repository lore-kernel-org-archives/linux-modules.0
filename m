Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:35681 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbcBDRgv (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 4 Feb 2016 12:36:51 -0500
Received: by mail-io0-f177.google.com with SMTP id d63so100911911ioj.2
        for <linux-modules@vger.kernel.org>; Thu, 04 Feb 2016 09:36:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1454526390-19792-7-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1454526390-19792-7-git-send-email-zohar@linux.vnet.ibm.com>
Date: Thu, 4 Feb 2016 09:36:50 -0800
Message-ID: <CAGXu5j+=4gWSuQHX-iBVGZTsL3UFsLFp74+QeVNcSJHyK+4v8w@mail.gmail.com>
Subject: Re: [PATCH v3 06/22] firmware: fold successful fw read early
From: Kees Cook <keescook@chromium.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
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
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 3, 2016 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> From: David Howells <dhowells@redhat.com>
>
> We'll be folding in some more checks on fw_read_file_contents(),
> this will make the success case easier to follow.
>
> Reviewed-by: Josh Boyer <jwboyer@fedoraproject.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  drivers/base/firmware_class.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
> index fb64814..c658cec 100644
> --- a/drivers/base/firmware_class.c
> +++ b/drivers/base/firmware_class.c
> @@ -361,20 +361,18 @@ static int fw_get_filesystem_firmware(struct device *device,
>                         continue;
>                 rc = fw_read_file_contents(file, buf);
>                 fput(file);
> -               if (rc)
> +               if (rc == 0) {
> +                       dev_dbg(device, "direct-loading %s\n",
> +                               buf->fw_id);
> +                       fw_finish_direct_load(device, buf);
> +                       goto out;
> +               } else
>                         dev_warn(device, "loading %s failed with error %d\n",
>                                  path, rc);
> -               else
> -                       break;
>         }
> +out:
>         __putname(path);
>
> -       if (!rc) {
> -               dev_dbg(device, "direct-loading %s\n",
> -                       buf->fw_id);
> -               fw_finish_direct_load(device, buf);
> -       }
> -
>         return rc;
>  }

Looking at this code, why does this use "break":

                len = snprintf(path, PATH_MAX, "%s/%s",
                               fw_path[i], buf->fw_id);
                if (len >= PATH_MAX) {
                        rc = -ENAMETOOLONG;
                        break;
                }

Shouldn't that emit a warning, set rc, and continue?


Regardless, I think this is more readable. Adding an "out" target at
the end of a for loop seems weird, given "break" existing. :)

                rc = fw_read_file_contents(file, buf);
                fput(file);
-               if (rc)
+               if (rc) {
                        dev_warn(device, "loading %s failed with error %d\n",
                                 path, rc);
+                       continue;
+               }
+               dev_dbg(device, "direct-loading %s\n", buf->fw_id);
+               fw_finish_direct_load(device, buf);
-               else
-                       break;
+               break;
        }
        __putname(path);
-
-       if (!rc) {
-               dev_dbg(device, "direct-loading %s\n",
-                       buf->fw_id);
-               fw_finish_direct_load(device, buf);
-       }
-
        return rc;
 }



-- 
Kees Cook
Chrome OS & Brillo Security
