MIME-Version: 1.0
In-Reply-To: <1386554032-5877-1-git-send-email-vapier@gentoo.org>
References: <1386554032-5877-1-git-send-email-vapier@gentoo.org>
Date: Mon, 9 Dec 2013 10:25:11 -0200
Message-ID: <CAKi4VALF3p0UXaYw2T2G=zOH_1A6inNH7LeJrX2TvpAnUgpnxg@mail.gmail.com>
Subject: Re: [PATCH] add a flag to control linking of internal kmod library
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Mike,

On Sun, Dec 8, 2013 at 11:53 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> We shouldn't be penalizing everyone because some distros' initramfs
> tooling sucks.  So add a configure flag for controlling the linkage
> of the internal kmod library and default it to off.

Please write in the commit message why you are doing this instead of
ranting others distro's initramfs. I can only see here a save in total
disk space. Then please provide numbers.

>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

we don't use s-o-f

> ---
>  Makefile.am  | 8 ++++++--
>  configure.ac | 5 +++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index bdf758e..ee89ab1 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -116,8 +116,12 @@ tools_kmod_SOURCES = tools/kmod.c tools/kmod.h tools/lsmod.c \
>                      tools/modinfo.c tools/modprobe.c \
>                      tools/depmod.c tools/log.h tools/log.c \
>                      tools/static-nodes.c
> -tools_kmod_LDADD = libkmod/libkmod-util.la \
> -                  libkmod/libkmod-internal.la
> +tools_kmod_LDADD = libkmod/libkmod-util.la
> +if ENABLE_INTERNAL_STATIC
> +tools_kmod_LDADD += libkmod/libkmod-internal.la
> +else
> +tools_kmod_LDADD += libkmod/libkmod.la
> +endif
>
>  ${noinst_SCRIPTS}: tools/kmod
>         $(AM_V_GEN) ($(RM) $@; \
> diff --git a/configure.ac b/configure.ac
> index 5b484d6..fe83541 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -102,6 +102,11 @@ AC_SUBST([bashcompletiondir], [$with_bashcompletiondir])
>  # --enable-
>  #####################################################################
>
> +AC_ARG_ENABLE([internal-static],
> +        AS_HELP_STRING([--enable-internal-static], [enable static linking of internal kmod libraries for simple initramfs usage @<:@default=disabled@:>@]),
> +       [], enable_internal_static=no)
> +AM_CONDITIONAL([ENABLE_INTERNAL_STATIC], [test "x$enable_internal_static" = "xyes"])
> +
>  AC_ARG_ENABLE([tools],
>          AS_HELP_STRING([--disable-tools], [disable building tools that provide same functionality as module-init-tools @<:@default=enabled@:>@]),
>         [], enable_tools=yes)
> --

It's not only for simple initramfs usage. Some symbols are only
available in the internal version because they are not intended for
public consumption. If numbers are compelling we could move those
symbols to the utils internal lib instead (that's why I'm asking for a
better commit message). However you also need to fix the testsuite
then. It expects to be able to exec the just-compiled binaries.
Wrappers don't work very well because libtool fails to maintain the
same name (see 9de9e07 tools: Use test/kmod instead of kmod-nolib).
Try "make check" to see that with your patch it now fails the tests
that try to exec modprobe, modinfo and so on.


Regards,
Lucas De Marchi
