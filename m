MIME-Version: 1.0
In-Reply-To: <1484954150-12831-1-git-send-email-james.minor@ni.com>
References: <1484954150-12831-1-git-send-email-james.minor@ni.com>
Date: Mon, 23 Jan 2017 12:05:44 -0800
Message-ID: <CAKi4VA+VQgLtTFNVpJWAR625L2hH-L7akQGUwmhi=8Z83ZQWvA@mail.gmail.com>
Subject: Re: [RFC v1] libkmod: Fix handling of quotes in kernel command line
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: James Minor <james.minor@ni.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, julia.cartwright@ni.com,
	zach.brown@ni.com, ken.sharp@ni.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Fri, Jan 20, 2017 at 3:15 PM, James Minor <james.minor@ni.com> wrote:
>
> If a module parameter on the command line contains quotes, any
> spaces inside those quotes should be included as part of the
> parameter.
>
> Signed-off-by: James Minor <james.minor@ni.com>
> ---
>  libkmod/libkmod-config.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
> index 19f56a7..0596025 100644
> --- a/libkmod/libkmod-config.c
> +++ b/libkmod/libkmod-config.c
> @@ -497,6 +497,7 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
>         char buf[KCMD_LINE_SIZE];
>         int fd, err;
>         char *p, *modname,  *param = NULL, *value = NULL, is_module = 1;
> +       bool is_quoted = false;
>
>         fd = open("/proc/cmdline", O_RDONLY|O_CLOEXEC);
>         if (fd < 0) {
> @@ -514,6 +515,12 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
>         }
>
>         for (p = buf, modname = buf; *p != '\0' && *p != '\n'; p++) {
> +               if (*p == '"') {
> +                       is_quoted = !is_quoted;
> +                       continue;
> +               }
> +               if (is_quoted)
> +                       continue;

Thanks for fixing this bug. However this would parse spaces in the
module name, which is not allowed by kernel. I think we should
maintain the "quoted" state across loop iterations and forbid it on
param names.

We also have a testsuite in which we add tests for this kind of stuff.
I added a test there:
https://git.kernel.org/cgit/utils/kernel/kmod/kmod.git/commit/?id=ded0bebca80ac1f20caa488efb412aa72ea8a7fd

thanks
Lucas De Marchi
