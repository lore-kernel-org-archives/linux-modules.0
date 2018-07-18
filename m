MIME-Version: 1.0
Date: Wed, 18 Jul 2018 11:46:16 -0700
References: <20180718084340.4305-1-jengelh@inai.de>
In-Reply-To: <20180718084340.4305-1-jengelh@inai.de>
Message-ID: <CAKi4VAJebEif94k6Zf9NR043HgkaqaEnD74ybXm5JFTu7uFSfA@mail.gmail.com>
Subject: Re: [PATCH] libkmod: drop _PAD enum constants
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Jan Engelhardt <jengelh@inai.de>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, linux-modules <linux-modules@vger.kernel.org>,
	Jan Engelhardt <jengelh@inai.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jul 18, 2018 at 1:44 AM Jan Engelhardt <jengelh@inai.de> wrote:
>
> When are enums ever mapped to something smaller than int, other than
> willful packing into a bitfield?

When users do bad things like passing a flag to the compiler
instructing it to do so: -fshort-enums.
That was the reason to add it back several years ago and I'd rather
not break that user now whoever it was,
although I don't think I would care adding it now if it was requested.


Lucas De Marchi

> ---
>  libkmod/libkmod.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
> index 352627e..4fb5ba8 100644
> --- a/libkmod/libkmod.h
> +++ b/libkmod/libkmod.h
> @@ -71,8 +71,6 @@ enum kmod_index {
>         KMOD_INDEX_MODULES_ALIAS,
>         KMOD_INDEX_MODULES_SYMBOL,
>         KMOD_INDEX_MODULES_BUILTIN,
> -       /* Padding to make sure enum is not mapped to char */
> -       _KMOD_INDEX_PAD = 1U << 31,
>  };
>  int kmod_dump_index(struct kmod_ctx *ctx, enum kmod_index type, int fd);
>
> @@ -210,8 +208,6 @@ enum kmod_module_initstate {
>         KMOD_MODULE_LIVE,
>         KMOD_MODULE_COMING,
>         KMOD_MODULE_GOING,
> -       /* Padding to make sure enum is not mapped to char */
> -       _KMOD_MODULE_PAD = 1U << 31,
>  };
>  const char *kmod_module_initstate_str(enum kmod_module_initstate state);
>  int kmod_module_get_initstate(const struct kmod_module *mod);
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-modules" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Lucas De Marchi
