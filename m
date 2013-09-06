MIME-Version: 1.0
In-Reply-To: <1378474024-5391-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1378474024-5391-1-git-send-email-thomas.petazzoni@free-electrons.com>
Date: Fri, 6 Sep 2013 11:34:00 -0300
Message-ID: <CAKi4VAKW2Dq9Eau69Optn+uSwRQXwpcPY_knsKp+0qohTKhymA@mail.gmail.com>
Subject: Re: [PATCHv2] Add configure check for _Static_assert()
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Thomas,

On Fri, Sep 6, 2013 at 10:27 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Commit 8efede20ef ("Use _Static_assert") introduced the usage of
> _Static_assert(). However, _Static_assert() is a fairly new thing,
> since it was introduced only in gcc 4.6. In order to support older
> compilers, this patch adds a configure.in test that checks whether
> _Static_assert() is usable or not, and adjust the behavior of the
> assert_cc() macro accordingly.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Changes since v1:
>  * When _Static_assert() is not available, rely on the previously used
>    sizeof() trick, as suggested by Lucas de Marchi.
> ---
>  configure.ac    | 6 ++++++
>  libkmod/macro.h | 5 +++++
>  2 files changed, 11 insertions(+)
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

I've fixed the typo s/is/if/ and pushed.

Thanks
Lucas De Marchi
