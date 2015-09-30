MIME-Version: 1.0
In-Reply-To: <1443479954-31484-2-git-send-email-labbott@fedoraproject.org>
References: <1443479954-31484-1-git-send-email-labbott@fedoraproject.org>
	<1443479954-31484-2-git-send-email-labbott@fedoraproject.org>
Date: Wed, 30 Sep 2015 15:35:35 -0300
Message-ID: <CAKi4VALPkjG+X3s-67txdOMQ-1jzsE6rxx=1RxUM4g+cxN=+7g@mail.gmail.com>
Subject: Re: [PATCHv2 2/5] modprobe: Update error message when path is missing
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Laura Abbott <labbott@fedoraproject.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Mon, Sep 28, 2015 at 7:39 PM, Laura Abbott <labbott@fedoraproject.org> wrote:
>
> Currently, modprobe fails with no output by default if the
> search paths it tries are missing:
>
> $ modprobe -S notakernel dm-crypt
> $
> $ modprobe -S notakernel lkjjweiojo
> $
>
> This is fairly cryptic and not at all obvious there is a problem
> unless the error code is checked or verbose flags are used.
> Update the error message to indicate a problem and print out the
> directory that failed.
> ---
>  libkmod/libkmod-internal.h | 2 --
>  libkmod/libkmod.h          | 1 +
>  tools/modprobe.c           | 7 +++----
>  3 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
> index 3e9839d..4d9db6b 100644
> --- a/libkmod/libkmod-internal.h
> +++ b/libkmod/libkmod-internal.h
> @@ -85,8 +85,6 @@ struct kmod_list *kmod_list_append_list(struct kmod_list *list1, struct kmod_lis
>                 container_of(list_entry->node.prev, struct kmod_list, node)))
>
>  /* libkmod.c */
> -const char *kmod_get_dirname(const struct kmod_ctx *ctx) __attribute__((nonnull(1)));
> -
>  int kmod_lookup_alias_from_config(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
>  int kmod_lookup_alias_from_symbols_file(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
>  int kmod_lookup_alias_from_aliases_file(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
> diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
> index fe53a59..f9e33c6 100644
> --- a/libkmod/libkmod.h
> +++ b/libkmod/libkmod.h
> @@ -51,6 +51,7 @@ void kmod_set_log_priority(struct kmod_ctx *ctx, int priority);
>  void *kmod_get_userdata(const struct kmod_ctx *ctx);
>  void kmod_set_userdata(struct kmod_ctx *ctx, const void *userdata);
>
> +const char *kmod_get_dirname(const struct kmod_ctx *ctx);

I also added a patch to make sure this function is exported in the
library. Otherwise we limit its usage to the internal tools and it
doesn't fail since we statically link the tools with libkmod:
https://git.kernel.org/cgit/utils/kernel/kmod/kmod.git/commit/?id=f7f28510244e22c3676cea40f55dbed6338005f3

Lucas De Marchi
