MIME-Version: 1.0
In-Reply-To: <1463829319-1668-1-git-send-email-peter@lekensteyn.nl>
References: <1463829319-1668-1-git-send-email-peter@lekensteyn.nl>
Date: Sat, 21 May 2016 14:28:49 -0300
Message-ID: <CAKi4VA+CtjX-hY_2LPwh4A8y1pFU2mnk3ziRvD25HSaXVJF35w@mail.gmail.com>
Subject: Re: [PATCH] kmod_module_get_refcnt: fix documentation
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Peter Wu <peter@lekensteyn.nl>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Sat, May 21, 2016 at 8:15 AM, Peter Wu <peter@lekensteyn.nl> wrote:
> ---
>  libkmod/libkmod-module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 50b2ff9..1460c67 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -1863,7 +1863,7 @@ done:
>   * Get the ref count of this @mod, as returned by Linux Kernel, by reading
>   * /sys filesystem.
>   *
> - * Returns: 0 on success or < 0 on failure.
> + * Returns: the reference count on success or < 0 on failure.
>   */
>  KMOD_EXPORT int kmod_module_get_refcnt(const struct kmod_module *mod)
>  {
> --

Applied, thanks.

Lucas De Marchi
