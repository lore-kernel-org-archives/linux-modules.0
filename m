MIME-Version: 1.0
In-Reply-To: <1423523713-3595-2-git-send-email-caio.oliveira@intel.com>
References: <1423523713-3595-1-git-send-email-caio.oliveira@intel.com>
	<1423523713-3595-2-git-send-email-caio.oliveira@intel.com>
Date: Tue, 10 Feb 2015 01:11:26 -0200
Message-ID: <CAKi4VAKf0gj9mkuwGfUA=DGobcNhNugF-iw-Y2u5q=j=jMowgw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools: add kmod info
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Mon, Feb 9, 2015 at 9:15 PM, Caio Marcelo de Oliveira Filho
<caio.oliveira@intel.com> wrote:
> From: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
>         printf("Usage:\n"
> -               "\t%s [options] filename [args]\n"
> +               "\t%s%s [options] filename [args]\n"
>                 "Options:\n"
>                 "\t-a, --author                Print only 'author'\n"
>                 "\t-d, --description           Print only 'description'\n"
> @@ -343,7 +343,8 @@ static void help(void)
>                 "\t-b, --basedir=DIR           Use DIR as filesystem root for /lib/modules\n"
>                 "\t-V, --version               Show version\n"
>                 "\t-h, --help                  Show this help\n",
> -               program_invocation_short_name);
> +               program_invocation_short_name,
> +               is_kmod_cmd() ? " info" : "");

humn... what I really wanted with the commands was to normalize the
common options. For example, --version would only be used as an option
to kmod, not "kmod info".
"-b, --basedir"... this should be an option to kmod as well. depmod
and modprobe also make use of it, though with a different name (-d in
modprobe, -b in depmod)


>  }
>
>  static bool is_module_filename(const char *name)
> @@ -464,3 +465,9 @@ const struct kmod_cmd kmod_cmd_compat_modinfo = {
>         .cmd = do_modinfo,
>         .help = "compat modinfo command",
>  };
> +
> +const struct kmod_cmd kmod_cmd_info = {
> +       .name = "info",
> +       .cmd = do_modinfo,
> +       .help = "show information about a module",
> +};

anyway... I think we can merge something like this and start factoring
out the common options later.

-- 
Lucas De Marchi
