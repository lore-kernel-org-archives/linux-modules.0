MIME-Version: 1.0
In-Reply-To: <1487157483-12848-1-git-send-email-bgolaszewski@baylibre.com>
References: <1487157483-12848-1-git-send-email-bgolaszewski@baylibre.com>
Date: Thu, 16 Feb 2017 08:51:25 -0800
Message-ID: <CAKi4VA+3cj5-tOmBy1f5gzge2qOMp-Rjivn-NVpO9XdH9dFvqA@mail.gmail.com>
Subject: Re: [PATCH] module: fix a memory leak
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 15, 2017 at 3:18 AM, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> When a module is removed and re-inserted without unrefing, the
> kmod_file is unconditionally re-opened. This results in a memory
> and file descriptor leak.
>
> Fix it by checking if the file is already open in
> kmod_module_insert_module().
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  libkmod/libkmod-module.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index bf6a8d6..57da0a2 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -833,10 +833,12 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
>                 return -ENOENT;
>         }
>
> -       mod->file = kmod_file_open(mod->ctx, path);
> -       if (mod->file == NULL) {
> -               err = -errno;
> -               return err;
> +       if (!mod->file) {
> +               mod->file = kmod_file_open(mod->ctx, path);
> +               if (mod->file == NULL) {
> +                       err = -errno;
> +                       return err;
> +               }
>         }
>
>         if (kmod_file_get_direct(mod->file)) {
> --

Applied, thanks.

Lucas De Marchi
