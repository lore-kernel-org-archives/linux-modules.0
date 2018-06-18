MIME-Version: 1.0
Date: Mon, 18 Jun 2018 09:49:16 -0700
References: <20180616064520.6426-1-jengelh@inai.de>
In-Reply-To: <20180616064520.6426-1-jengelh@inai.de>
Message-ID: <CAKi4VAKN5eCFFZd+A6PzZFf+5PmS-YYAFb5DH86CXPkrpgvjBw@mail.gmail.com>
Subject: Re: [PATCH] kmod: build: cure compiler warnings showing up externally
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Jan Engelhardt <jengelh@inai.de>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, Jan Engelhardt <jengelh@inai.de>,
	linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Fri, Jun 15, 2018 at 11:53 PM Jan Engelhardt <jengelh@inai.de> wrote:
>
> When building a C source file with gcc-7 -Wshift-overflow=2, this warning
> springs up:
>
> libkmod.h: warning: result of "1 << 31" requires 33 bits to
> represent, but "int" only has 32 bits [-Wshift-overflow=]
>
> Change the two _KMOD_* identifiers to fit into 32 bits.
> ---
>  libkmod/libkmod.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Lucas De Marchi

>
> diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
> index f9e33c6..352627e 100644
> --- a/libkmod/libkmod.h
> +++ b/libkmod/libkmod.h
> @@ -72,7 +72,7 @@ enum kmod_index {
>         KMOD_INDEX_MODULES_SYMBOL,
>         KMOD_INDEX_MODULES_BUILTIN,
>         /* Padding to make sure enum is not mapped to char */
> -       _KMOD_INDEX_PAD = (1 << 31),
> +       _KMOD_INDEX_PAD = 1U << 31,
>  };
>  int kmod_dump_index(struct kmod_ctx *ctx, enum kmod_index type, int fd);
>
> @@ -211,7 +211,7 @@ enum kmod_module_initstate {
>         KMOD_MODULE_COMING,
>         KMOD_MODULE_GOING,
>         /* Padding to make sure enum is not mapped to char */
> -       _KMOD_MODULE_PAD = (1 << 31),
> +       _KMOD_MODULE_PAD = 1U << 31,
>  };
>  const char *kmod_module_initstate_str(enum kmod_module_initstate state);
>  int kmod_module_get_initstate(const struct kmod_module *mod);
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-modules" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Lucas De Marchi
