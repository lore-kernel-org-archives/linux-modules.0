MIME-Version: 1.0
In-Reply-To: <20160110151023.GA9659@x>
References: <20160110151023.GA9659@x>
Date: Mon, 11 Jan 2016 10:43:56 -0200
Message-ID: <CAKi4VAJJJ+nDene80fmzzm4WN_2=VLXrq7qc-urNYToQew+LgQ@mail.gmail.com>
Subject: Re: [PATCH] depmod: Don't insert comment in modules.devname if
 otherwise empty
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-modules <linux-modules@vger.kernel.org>, 810367@bugs.debian.org,
	kmod@packages.debian.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Sun, Jan 10, 2016 at 1:10 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> This allows tools to detect the file as empty, such as via systemd's
> ConditionFileNotEmpty.
> ---
>
> The string constant extends past 80 columns, per CODING-STYLE.
>
> The motivation for this patch came from Debian bug 810367.  This change
> would allow kmod-static-nodes.service to use ConditionFileNotEmpty
> instead of ConditionPathExists.
>
>  tools/depmod.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/depmod.c b/tools/depmod.c
> index a585d47..6e9bb4d 100644
> --- a/tools/depmod.c
> +++ b/tools/depmod.c
> @@ -1999,8 +1999,7 @@ static int output_builtin_bin(struct depmod *depmod, FILE *out)
>  static int output_devname(struct depmod *depmod, FILE *out)
>  {
>         size_t i;
> -
> -       fputs("# Device nodes to trigger on-demand module loading.\n", out);
> +       bool empty = true;
>
>         for (i = 0; i < depmod->modules.count; i++) {
>                 const struct mod *mod = depmod->modules.array[i];
> @@ -2036,10 +2035,15 @@ static int output_devname(struct depmod *depmod, FILE *out)
>                 }
>
>                 if (devname != NULL) {
> -                       if (type != '\0')
> +                       if (type != '\0') {
> +                               if (empty) {
> +                                       fputs("# Device nodes to trigger on-demand module loading.\n",
> +                                             out);
> +                                       empty = false;
> +                               }
>                                 fprintf(out, "%s %s %c%u:%u\n", mod->modname,
>                                         devname, type, major, minor);
> -                       else
> +                        } else
>                                 ERR("Module '%s' has devname (%s) but "
>                                     "lacks major and minor information. "
>                                     "Ignoring.\n", mod->modname, devname);
> --

Applied, thanks.


Lucas De Marchi
