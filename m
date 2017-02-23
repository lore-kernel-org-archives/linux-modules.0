MIME-Version: 1.0
In-Reply-To: <20170216172831.3019-2-lucas.demarchi@intel.com>
References: <20170216172831.3019-1-lucas.demarchi@intel.com>
	<20170216172831.3019-2-lucas.demarchi@intel.com>
Date: Thu, 23 Feb 2017 14:14:24 -0800
Message-ID: <CAKi4VA+xDWz=L_FozH8mG61R65VPAU6Esm0KYtZO_SSFPmAx-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] libkmod-config: fix parsing quoted kernel cmdline on params
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, James Minor <james.minor@ni.com>,
	julia.cartwright@ni.com, zach.brown@ni.com, ken.sharp@ni.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Thu, Feb 16, 2017 at 9:28 AM, Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
> We can only accept quoted values, not module names or parameter names.
> ---
>  libkmod/libkmod-config.c                                   | 14 ++++++++++++++
>  .../test-modprobe/module-param-kcmdline5/proc/cmdline      |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
> index 18f300a..aaac0a1 100644
> --- a/libkmod/libkmod-config.c
> +++ b/libkmod/libkmod-config.c
> @@ -517,10 +517,24 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
>         for (p = buf, modname = buf; *p != '\0' && *p != '\n'; p++) {
>                 if (*p == '"') {
>                         is_quoted = !is_quoted;
> +
> +                       if (is_quoted) {
> +                               /* don't consider a module until closing quotes */
> +                               is_module = false;
> +                       } else if (param != NULL && value != NULL) {
> +                               /*
> +                                * If we are indeed expecting a value and
> +                                * closing quotes, then this can be considered
> +                                * a valid option for a module
> +                                */
> +                               is_module = true;
> +                       }
> +
>                         continue;
>                 }
>                 if (is_quoted)
>                         continue;
> +
>                 switch (*p) {
>                 case ' ':
>                         *p = '\0';
> diff --git a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline5/proc/cmdline b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline5/proc/cmdline
> index 0c796b3..84e0168 100644
> --- a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline5/proc/cmdline
> +++ b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline5/proc/cmdline
> @@ -1 +1 @@
> -psmouse.foo psmouse.bar=1 psmouse.foobar="test 1" " notamodule" "noteamodule2 " notamodule3 " quiet rw
> +psmouse.foo psmouse.bar=1 psmouse.foobar="test 1" psmouse."invalid option" " notamodule" "noteamodule2 " notamodule3 quiet rw
> --

Both patches applied.

Lucas De Marchi
