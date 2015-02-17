MIME-Version: 1.0
In-Reply-To: <1424177796-17923-1-git-send-email-harish_kandiga@mentor.com>
References: <1424177796-17923-1-git-send-email-harish_kandiga@mentor.com>
Date: Tue, 17 Feb 2015 15:30:58 -0200
Message-ID: <CAKi4VA+nJknEwkQfUWf0VbcEMzzz3uHwwNe8OuWQOi-K0sWxjQ@mail.gmail.com>
Subject: Re: [PATCH] libkmod-module: Remove directory existence check for KMOD_MODULE_BUILTIN
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Harish Jenny K N <harish_kandiga@mentor.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-modules <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Feb 17, 2015 at 10:56 AM, Harish Jenny K N
<harish_kandiga@mentor.com> wrote:
> usecase: two sd cards are being mounted in parallel at same time on
> dual core. example modules which are getting loaded is nls_cp437.
> While one module is being loaded , it starts creating sysfs files.
> meanwhile on other core, modprobe might return saying the module
> is KMOD_MODULE_BUILTIN, which might result in not mounting sd card.

an {f,}init_module() call should not return until the sysfs files are
created and if there is /sys/module/<module>/ there should be
/sys/module/<module>/initstate unless the module is builtin.

Rusty, was there any changes in this area in the kernel recently?

Or is the creation of /sys/module/<module> and
/sys/module/<module>/initstate not atomic?

See patch below.


-- 
Lucas De Marchi

>
> Experiments done to prove the issue in kmod.
> Added sleep in kernel module.c at the place of creation of sysfs files.
> Then tried `modprobe nls_cp437` from two different shells.
> While the first was still waiting for its completion ,
> the second one returned saying the module is built-in.
>
> built-in modules are handled by searching the modules.builtin file.
> mod->builtin gets set and are handled in kmod_module_get_initstate function.
> Removing the checking of the presence of /sys/module/<modulename>/
> directory, which may not be required. It has to be added in other place
> accordingly if required.
>
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> ---
>  libkmod/libkmod-module.c |   13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 30f15ca..21c2a7e 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -1708,7 +1708,7 @@ KMOD_EXPORT const char *kmod_module_initstate_str(enum kmod_module_initstate sta
>  KMOD_EXPORT int kmod_module_get_initstate(const struct kmod_module *mod)
>  {
>         char path[PATH_MAX], buf[32];
> -       int fd, err, pathlen;
> +       int fd, err;
>
>         if (mod == NULL)
>                 return -ENOENT;
> @@ -1716,7 +1716,7 @@ KMOD_EXPORT int kmod_module_get_initstate(const struct kmod_module *mod)
>         if (mod->builtin)
>                 return KMOD_MODULE_BUILTIN;
>
> -       pathlen = snprintf(path, sizeof(path),
> +       snprintf(path, sizeof(path),
>                                 "/sys/module/%s/initstate", mod->name);
>         fd = open(path, O_RDONLY|O_CLOEXEC);
>         if (fd < 0) {
> @@ -1725,15 +1725,6 @@ KMOD_EXPORT int kmod_module_get_initstate(const struct kmod_module *mod)
>                 DBG(mod->ctx, "could not open '%s': %s\n",
>                         path, strerror(-err));
>
> -               if (pathlen > (int)sizeof("/initstate") - 1) {
> -                       struct stat st;
> -                       path[pathlen - (sizeof("/initstate") - 1)] = '\0';
> -                       if (stat(path, &st) == 0 && S_ISDIR(st.st_mode))
> -                               return KMOD_MODULE_BUILTIN;
> -               }
> -
> -               DBG(mod->ctx, "could not open '%s': %s\n",
> -                       path, strerror(-err));
>                 return err;
>         }
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-modules" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
