MIME-Version: 1.0
In-Reply-To: <1442004956-3868-3-git-send-email-labbott@fedoraproject.org>
References: <1442004956-3868-1-git-send-email-labbott@fedoraproject.org>
	<1442004956-3868-3-git-send-email-labbott@fedoraproject.org>
Date: Sat, 12 Sep 2015 15:45:47 -0300
Message-ID: <CAKi4VA+mR5qiP_qzsy9-NmA-VbXW+ZqiRCY3VCeOQLrC8rMCpg@mail.gmail.com>
Subject: Re: [PATCH 2/4] modprobe: Add appropriate error message when path is missing
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Laura Abbott <labbott@fedoraproject.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Fri, Sep 11, 2015 at 5:55 PM, Laura Abbott <labbott@fedoraproject.org> wrote:
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
> Add a message to give a better idea that something went wrong.
> ---
>  tools/modprobe.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/modprobe.c b/tools/modprobe.c
> index 3ba8f52..b50a385 100644
> --- a/tools/modprobe.c
> +++ b/tools/modprobe.c
> @@ -489,8 +489,11 @@ static int insmod(struct kmod_ctx *ctx, const char *alias,
>                                                 const char *options) = NULL;
>
>         err = kmod_module_new_from_lookup(ctx, alias, &list);
> -       if (err < 0)
> +       if (err < 0) {
> +               ERR("Could not generate list of modules from context\n");
> +               ERR("(Is your version correct)?)\n");

I think we should not ask "is your version correct?", but rather give
information for the user to figure it out. So... maybe export
kmod_get_dirname() from the library and here do something like:

err = kmod_module_new_from_lookup(ctx, alias, &list);
if (err < 0) {
        ERR("Could not lookup module '%s' from module directory '%s'\n",
            alias, kmod_get_dirname(ctx));
        return err;
}

Actually this case is very similar to the check "list == NULL" below
this and maybe we should merge them with the same log message. What do
you think?


Lucas De Marchi
