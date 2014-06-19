MIME-Version: 1.0
In-Reply-To: <1403139060-147474-1-git-send-email-crrodriguez@opensuse.org>
References: <1403139060-147474-1-git-send-email-crrodriguez@opensuse.org>
Date: Thu, 19 Jun 2014 18:08:21 -0300
Message-ID: <CAKi4VAKh6Z67OQekiSxm_aY1i7u1v1_PDNW8CxTQOrPqfKktMg@mail.gmail.com>
Subject: Re: [PATCH] RESEND: add missing O_CLOEXEC in kmod_module_get_size()
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: =?UTF-8?Q?Cristian_Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jun 18, 2014 at 9:51 PM, Cristian Rodr=C3=ADguez
<crrodriguez@opensuse.org> wrote:
> ---
>  libkmod/libkmod-module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 1d90f34..8046262 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -1781,7 +1781,7 @@ KMOD_EXPORT long kmod_module_get_size(const struct =
kmod_module *mod)
>          * loaded.
>          */
>         snprintf(line, sizeof(line), "/sys/module/%s", mod->name);
> -       dfd =3D open(line, O_RDONLY);
> +       dfd =3D open(line, O_RDONLY|O_CLOEXEC);
>         if (dfd < 0)
>                 return -errno;
>
> --

I don't know what's  the RESEND in the subject, but the patch looks
good. I removed it and applied.

Thanks.

--=20

Lucas De Marchi
