MIME-Version: 1.0
In-Reply-To: <1421244136-14606-1-git-send-email-caio.oliveira@intel.com>
References: <1421244136-14606-1-git-send-email-caio.oliveira@intel.com>
Date: Wed, 14 Jan 2015 14:24:15 -0200
Message-ID: <CAKi4VAKAdvB+Qkd-sf-HcrFuzkR3TrXA9T=h1zSFiyHHfaVxDw@mail.gmail.com>
Subject: Re: [PATCH] tools: kmod: break iteration once a command is executed
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jan 14, 2015 at 12:02 PM, Caio Marcelo de Oliveira Filho
<caio.oliveira@intel.com> wrote:
> ---
>  tools/kmod.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/kmod.c b/tools/kmod.c
> index abb1707..a8534cd 100644
> --- a/tools/kmod.c
> +++ b/tools/kmod.c
> @@ -124,10 +124,10 @@ static int handle_kmod_commands(int argc, char *argv[])
>         cmd = argv[optind];
>
>         for (i = 0, err = -EINVAL; i < ARRAY_SIZE(kmod_cmds); i++) {
> -               if (strcmp(kmod_cmds[i]->name, cmd) != 0)
> -                       continue;
> -
> -               err = kmod_cmds[i]->cmd(--argc, ++argv);
> +               if (strcmp(kmod_cmds[i]->name, cmd) == 0) {
> +                       err = kmod_cmds[i]->cmd(--argc, ++argv);
> +                       break;
> +               }
>         }
>
>         if (err < 0) {
> --

Applied, thanks.

-- 
Lucas De Marchi
