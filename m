MIME-Version: 1.0
In-Reply-To: <1442004956-3868-4-git-send-email-labbott@fedoraproject.org>
References: <1442004956-3868-1-git-send-email-labbott@fedoraproject.org>
	<1442004956-3868-4-git-send-email-labbott@fedoraproject.org>
Date: Sat, 12 Sep 2015 15:55:16 -0300
Message-ID: <CAKi4VAKZRmiis6qD37OXZ5kxEXqy+rxVgYQrz=uVUSoY7ni_FQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] depmod: Fix message printing before log_setup_kmod_log
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Laura Abbott <labbott@fedoraproject.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Fri, Sep 11, 2015 at 5:55 PM, Laura Abbott <labbott@fedoraproject.org> wrote:
>
> Until log_setup_kmod_log is called, the only messages that
> can be printed are the default level. Bump a few deprecated
> messages to ERR to ensure they get printed and drop some DBG
> prints that will never occur unless the compiled default is DBG.
> ---
>  tools/depmod.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/tools/depmod.c b/tools/depmod.c
> index 2a08b6e..30f6191 100644
> --- a/tools/depmod.c
> +++ b/tools/depmod.c
> @@ -2455,10 +2455,10 @@ static int do_depmod(int argc, char *argv[])
>                 case 'r':
>                 case 'm':
>                         if (idx > 0)
> -                               WRN("Ignored deprecated option --%s\n",
> +                               ERR("Ignored deprecated option --%s\n",
>                                     cmdopts[idx].name);
>                         else
> -                               WRN("Ignored deprecated option -%c\n", c);
> +                               ERR("Ignored deprecated option -%c\n", c);

/me confused. The default priority for depmod is LOG_WARNING

>                         break;
>                 case 'h':
> @@ -2498,11 +2498,9 @@ static int do_depmod(int argc, char *argv[])
>                 if (out == stdout)
>                         goto done;
>                 /* ignore up-to-date errors (< 0) */
> -               if (depfile_up_to_date(cfg.dirname) == 1) {
> -                       DBG("%s/modules.dep is up to date!\n", cfg.dirname);
> +               if (depfile_up_to_date(cfg.dirname) == 1)
>                         goto done;
> -               }
> -               DBG("%s/modules.dep is outdated, do -a\n", cfg.dirname);
> +

I don't mind losing these log messages. I guess they were useful in
the beginning but they aren't anymore.


Lucas De Marchi


>                 all = 1;
>         }
>
> --
> 2.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-modules" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Lucas De Marchi
