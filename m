MIME-Version: 1.0
In-Reply-To: <20171106215703.GA24781@asgard.redhat.com>
References: <20171106215703.GA24781@asgard.redhat.com>
Date: Mon, 6 Nov 2017 19:24:55 -0800
Message-ID: <CAKi4VA+Q_WRsSyA-7uffSXRf+N7rz1_VSuMmqpQXMrT+bxgOBw@mail.gmail.com>
Subject: Re: [PATCH] libkmod: fix uninitialized variable usage warnings
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Eugene Syromiatnikov <esyr@redhat.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Mon, Nov 6, 2017 at 1:57 PM, Eugene Syromiatnikov <esyr@redhat.com> wrote:
> There are two places where _cleanup_free_ variables are not initialised
> by the time function exits that have been caught by gcc:
>
>         In file included from libkmod/libkmod.c:35:0:
>         libkmod/libkmod.c: In function 'kmod_lookup_alias_is_builtin':
>         ./shared/util.h:73:13: warning: 'line' may be used uninitialized in this function [-Wmaybe-uninitialized]
>                  free(*(void**) p);
>                      ^
>         libkmod/libkmod.c:551:23: note: 'line' was declared here
>           _cleanup_free_ char *line;
>                                ^
>         In file included from libkmod/libkmod-module.c:42:0:
>         libkmod/libkmod-module.c: In function 'kmod_module_probe_insert_module':
>         ./shared/util.h:73:13: warning: 'cmd' may be used uninitialized in this function [-Wmaybe-uninitialized]
>                  free(*(void**) p);
>                      ^
>         libkmod/libkmod-module.c:996:23: note: 'cmd' was declared here
>           _cleanup_free_ char *cmd;
>                        ^
>
> This patch initializes them to NULL so free become no-op in these cases.
> ---
>  libkmod/libkmod-module.c | 2 +-
>  libkmod/libkmod.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 0a3ef11..6f23c1a 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -995,7 +995,7 @@ static int module_do_install_commands(struct kmod_module *mod,
>  {
>         const char *command = kmod_module_get_install_commands(mod);
>         char *p;
> -       _cleanup_free_ char *cmd;
> +       _cleanup_free_ char *cmd = NULL;
>         int err;
>         size_t cmdlen, options_len, varlen;
>
> diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
> index 69fe431..964772d 100644
> --- a/libkmod/libkmod.c
> +++ b/libkmod/libkmod.c
> @@ -556,7 +556,7 @@ finish:
>
>  bool kmod_lookup_alias_is_builtin(struct kmod_ctx *ctx, const char *name)
>  {
> -       _cleanup_free_ char *line;
> +       _cleanup_free_ char *line = NULL;

This seems to be a bogus warning. See the line just below... there's
no way to exit this function without first  assigning 'line'.

Lucas De Marchi
