Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:35029 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933466AbcBDR1o (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 4 Feb 2016 12:27:44 -0500
Received: by mail-io0-f176.google.com with SMTP id d63so100604355ioj.2
        for <linux-modules@vger.kernel.org>; Thu, 04 Feb 2016 09:27:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1454526390-19792-6-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1454526390-19792-6-git-send-email-zohar@linux.vnet.ibm.com>
Date: Thu, 4 Feb 2016 09:27:43 -0800
Message-ID: <CAGXu5jJwZzYm5ZEMRmypg7auJaPsRS4GM2ES9uGQj81LFqQrQQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/22] firmware: move completing fw into a helper
From: Kees Cook <keescook@chromium.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Kexec Mailing List <kexec@lists.infradead.org>,
	linux-modules@vger.kernel.org, David Howells <dhowells@redhat.com>,
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
> From: "Luis R. Rodriguez" <mcgrof@kernel.org>
>
> This will be re-used later through a new extensible interface.
>
> Reviewed-by: Josh Boyer <jwboyer@fedoraproject.org>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/base/firmware_class.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
> index 3358f5d..fb64814 100644
> --- a/drivers/base/firmware_class.c
> +++ b/drivers/base/firmware_class.c
> @@ -322,6 +322,15 @@ fail:
>         return rc;
>  }
>
> +static void fw_finish_direct_load(struct device *device,
> +                                 struct firmware_buf *buf)
> +{
> +       mutex_lock(&fw_lock);
> +       set_bit(FW_STATUS_DONE, &buf->status);
> +       complete_all(&buf->completion);
> +       mutex_unlock(&fw_lock);
> +}
> +
>  static int fw_get_filesystem_firmware(struct device *device,
>                                        struct firmware_buf *buf)
>  {
> @@ -363,10 +372,7 @@ static int fw_get_filesystem_firmware(struct device *device,
>         if (!rc) {
>                 dev_dbg(device, "direct-loading %s\n",
>                         buf->fw_id);
> -               mutex_lock(&fw_lock);
> -               set_bit(FW_STATUS_DONE, &buf->status);
> -               complete_all(&buf->completion);
> -               mutex_unlock(&fw_lock);
> +               fw_finish_direct_load(device, buf);
>         }
>
>         return rc;
> --
> 2.1.0
>



-- 
Kees Cook
Chrome OS & Brillo Security
