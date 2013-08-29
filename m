MIME-Version: 1.0
In-Reply-To: <1377704031-12501-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1377704031-12501-1-git-send-email-thomas.petazzoni@free-electrons.com>
Date: Thu, 29 Aug 2013 00:55:04 -0300
Message-ID: <CAKi4VALsZAMwKyT8U-Jcg+E_Hm_CyiwKJf+Kr3Y-JP_7Ze5D6w@mail.gmail.com>
Subject: Re: [PATCH] Add configure check for _Static_assert()
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Thomas,

On Wed, Aug 28, 2013 at 12:33 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Commit 8efede20ef ("Use _Static_assert") introduced the usage of
> _Static_assert(). However, _Static_assert() is a fairly new thing,
> since it was introduced only in gcc 4.6. In order to support older

What distro is still in gcc 4.6? Is it a LTS one?

> compilers, this patch adds a configure.in test that checks whether
> _Static_assert() is usable or not, and adjust the behavior of the
> assert_cc() macro accordingly.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  configure.ac    | 6 ++++++
>  libkmod/macro.h | 4 ++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/configure.ac b/configure.ac
> index 40e54cf..cbe12f3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -52,6 +52,12 @@ AC_CHECK_MEMBERS([struct stat.st_mtim], [], [], [#include <sys/stat.h>])
>  # Check kernel headers
>  AC_CHECK_HEADERS_ONCE([linux/module.h])
>
> +AC_MSG_CHECKING([whether _Static_assert() is supported])
> +AC_COMPILE_IFELSE(
> +       [AC_LANG_SOURCE([[_Static_assert(1, "Test");]])],
> +        [AC_DEFINE([HAVE_STATIC_ASSERT], [1], [Define is _Static_assert() is available])
> +        AC_MSG_RESULT([yes])],
> +       [AC_MSG_RESULT([no])])
>
>  #####################################################################
>  # --with-
> diff --git a/libkmod/macro.h b/libkmod/macro.h
> index c6ba855..5992026 100644
> --- a/libkmod/macro.h
> +++ b/libkmod/macro.h
> @@ -21,8 +21,12 @@
>
>  #include <stddef.h>
>
> +#if defined(HAVE_STATIC_ASSERT)
>  #define assert_cc(expr) \
>         _Static_assert((expr), #expr)
> +#else
> +#define assert_cc(expr)

could you then define it similarly to what it was before then in this #else?

I think this would do it (totally untested) with the downside of an
ugly build error.

#define assert_cc(expr) \
       do { (void) sizeof(char [1 - 2*!(expr)]); } while(0)


thanks
Lucas De Marchi
