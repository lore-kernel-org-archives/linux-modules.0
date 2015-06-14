Return-Path: <dh.herrmann@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1434231912-20614-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1434231912-20614-1-git-send-email-lucas.de.marchi@gmail.com>
Date: Sun, 14 Jun 2015 12:55:04 +0200
Message-ID: <CANq1E4R_4jG1BN03SYuQjjHOQa+6_hozmV+ZayfZPRYs5exUMQ@mail.gmail.com>
Subject: Re: [PATCH] libkmod-module: fix return code in error path
From: David Herrmann <dh.herrmann@gmail.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
	David Herrmann <dh.herrmann@googlemail.com>, Lennart Poettering <lennart@poettering.net>,
	Kay Sievers <kay@vrfy.org>, Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi

On Sat, Jun 13, 2015 at 11:45 PM, Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
> From: Lucas De Marchi <lucas.demarchi@intel.com>
>
> ENOSYS is the wrong errno to return when we don't find a module in
> kmod_module_insert_module(). Why is it there in the first place?  This
> goes back to kmod v1 when we couldn't load modules by names, but we
> should give a path instead.
>
> 708624a ("ELF: initial support for modinfo and strip of modversions and
> vermagic.") changed that so we do a lazy-search by the module path in
> this function. Later  f304afe ("Change error message to reflect
> reality") fixed the log message but the return coded remained the same.
> ---
>
> CC'ing here people from systemd who were bitten by this bug in kmod:
> https://github.com/systemd/systemd/pull/166
>
> I'm not sure about changing the return code since it was returning ENOSYS since
> v1 :-/.  However maybe the best thing to do is just treat it as a bug and let
> the patch to be backported by distros that want it.  Thoughts?

Looks all good to me. Treating this as a bugfix is probably the best
thing to do. I'll revert the systemd patch once this is pushed.

Thanks
David

>
>  libkmod/libkmod-module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 366308f..50b2ff9 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -830,7 +830,7 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
>         path = kmod_module_get_path(mod);
>         if (path == NULL) {
>                 ERR(mod->ctx, "could not find module by name='%s'\n", mod->name);
> -               return -ENOSYS;
> +               return -ENOENT;
>         }
>
>         mod->file = kmod_file_open(mod->ctx, path);
> --
> 2.4.3
>
