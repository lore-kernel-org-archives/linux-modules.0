MIME-Version: 1.0
In-Reply-To: <20150214233452.GA7778@localhost>
References: <20150214233452.GA7778@localhost>
Date: Wed, 18 Feb 2015 16:22:29 -0200
Message-ID: <CAKi4VAJuu+kQ2Xb-xrAJWuanCQFcpozvkaGQmWtbgZdZkp9Suw@mail.gmail.com>
Subject: Re: [PATCH] Fix segmentation fault on empty signature key
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Sat, Feb 14, 2015 at 9:34 PM, Tobias Stoeckmann
<tobias@stoeckmann.org> wrote:
> Hi,
>
> a segmentation fault occurs if a module has an empty key attached to
> its signature.
>
> This happens because it's assumed that at least one key byte is
> available, subtracting it in libkmod-module line 2249.  This -1 value
> is casted to an unsigned data type later on, resulting in illegal
> memory access.
>
> Attached please find a proof of concept module, tested on amd64:
>
> tobias:~$ modinfo 0sig.ko
> filename:       /home/tobias/0sig.ko
> Segmentation fault
>
> Tobias
> ---
>  libkmod/libkmod-module.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 30f15ca..ca703a7 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -2246,7 +2246,8 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
>                                 key_hex[i * 3 + 2] = ':';
>                 }
>                 n = kmod_module_info_append(list, "sig_key", strlen("sig_key"),
> -                               key_hex, sig_info.key_id_len * 3 - 1);
> +                               key_hex, sig_info.key_id_len == 0 ? 0 :
> +                               sig_info.key_id_len * 3 - 1);

This one I prefer changing kmod_module_signature_info() to do the
right thing. This is because a 0 len signature is not a valid
signature and I prefer outputting nothing in modinfo rather than a
bogus signature.

Just pushed a commit changing kmod_module_signature_info(). Please
take a look if it fixes your issue.

thanks

-- 
Lucas De Marchi
