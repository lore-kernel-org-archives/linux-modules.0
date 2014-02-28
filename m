MIME-Version: 1.0
In-Reply-To: <1393541533-14719-6-git-send-email-mmarek@suse.cz>
References: <1393541533-14719-1-git-send-email-mmarek@suse.cz>
	<1393541533-14719-6-git-send-email-mmarek@suse.cz>
Date: Fri, 28 Feb 2014 03:39:12 -0300
Message-ID: <CAKi4VAL7M0_mmefW++fbhNnC280Gr+zEpeok7j3+uuWDCKAycg@mail.gmail.com>
Subject: Re: [PATCH 5/5] libkmod-module: Simplify kmod_module_insert_module()
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Michal Marek <mmarek@suse.cz>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Thu, Feb 27, 2014 at 7:52 PM, Michal Marek <mmarek@suse.cz> wrote:
> Store the file and elf pointer in the kmod_module structure and have it
> freed together with the module.
> ---
>  libkmod/libkmod-module.c |   27 ++++++++++-----------------
>  1 files changed, 10 insertions(+), 17 deletions(-)
>
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 3d3325f..a6c8a6e 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -790,8 +790,7 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
>         int err;
>         const void *mem;
>         off_t size;
> -       struct kmod_file *file;
> -       struct kmod_elf *elf = NULL;
> +       struct kmod_elf *elf;
>         const char *path;
>         const char *args = options ? options : "";
>
> @@ -804,13 +803,13 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
>                 return -ENOSYS;
>         }
>
> -       file = kmod_file_open(mod->ctx, path);
> -       if (file == NULL) {
> +       mod->file = kmod_file_open(mod->ctx, path);
> +       if (mod->file == NULL) {
>                 err = -errno;
>                 return err;
>         }
>
> -       if (kmod_file_get_direct(file)) {
> +       if (kmod_file_get_direct(mod->file)) {
>                 unsigned int kernel_flags = 0;
>
>                 if (flags & KMOD_INSERT_FORCE_VERMAGIC)
> @@ -818,19 +817,16 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
>                 if (flags & KMOD_INSERT_FORCE_MODVERSION)
>                         kernel_flags |= MODULE_INIT_IGNORE_MODVERSIONS;
>
> -               err = finit_module(kmod_file_get_fd(file), args, kernel_flags);
> +               err = finit_module(kmod_file_get_fd(mod->file), args, kernel_flags);
>                 if (err == 0 || errno != ENOSYS)
>                         goto init_finished;
>         }
>
> -       size = kmod_file_get_size(file);
> -       mem = kmod_file_get_contents(file);
> -
>         if (flags & (KMOD_INSERT_FORCE_VERMAGIC | KMOD_INSERT_FORCE_MODVERSION)) {
> -               elf = kmod_elf_new(mem, size);
> +               elf = kmod_file_get_elf(mod->file);
>                 if (elf == NULL) {
>                         err = -errno;
> -                       goto elf_failed;
> +                       return err;
>                 }
>
>                 if (flags & KMOD_INSERT_FORCE_MODVERSION) {
> @@ -846,7 +842,10 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
>                 }
>
>                 mem = kmod_elf_get_memory(elf);
> +       } else {
> +               mem = kmod_file_get_contents(mod->file);
>         }
> +       size = kmod_file_get_size(mod->file);
>
>         err = init_module(mem, size, args);
>  init_finished:
> @@ -854,12 +853,6 @@ init_finished:
>                 err = -errno;
>                 INFO(mod->ctx, "Failed to insert module '%s': %m\n", path);
>         }
> -
> -       if (elf != NULL)
> -               kmod_elf_unref(elf);
> -elf_failed:
> -       kmod_file_unref(file);
> -
>         return err;
>  }

Ack.

Lucas De Marchi
