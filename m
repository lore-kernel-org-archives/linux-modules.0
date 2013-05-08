MIME-Version: 1.0
In-Reply-To: <1367938456-13058-1-git-send-email-chengwei.yang@intel.com>
References: <1367938456-13058-1-git-send-email-chengwei.yang@intel.com>
Date: Tue, 7 May 2013 23:57:28 -0300
Message-ID: <CAKi4VAKBuD4JM-OoHRuHxE7KZgWxHNt=tuCJr6pHrV-aHY9WUQ@mail.gmail.com>
Subject: Re: [PATCH] Fix 'make check': undeclared __NR_finit_module
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Chengwei Yang <chengwei.yang@intel.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, May 7, 2013 at 11:54 AM, Chengwei Yang <chengwei.yang@intel.com> wrote:
> This issue introduced by a fix for syscall(-1, ...) is invalid on some
> arch. The error thrown by 'make check' likes below.
>
> testsuite/init_module.c: In function 'syscall':
> testsuite/init_module.c:317:17: error: '__NR_finit_module' undeclared
> (first use in this function)
> testsuite/init_module.c:317:17: note: each undeclared identifier is
> reported only once for each function it appears in
> make[2]: *** [testsuite/init_module.lo] Error 1
> make[1]: *** [check-am] Error 2
> make: *** [check-recursive] Error 1
> ---
>  libkmod/missing.h |   16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/libkmod/missing.h b/libkmod/missing.h
> index b31af84..52dbcc7 100644
> --- a/libkmod/missing.h
> +++ b/libkmod/missing.h
> @@ -12,6 +12,10 @@
>  # define MODULE_INIT_IGNORE_MODVERSIONS 1
>  #endif
>
> +#ifndef __NR_finit_module
> +# define __NR_finit_module -1
> +#endif
> +
>  #ifndef MODULE_INIT_IGNORE_VERMAGIC
>  # define MODULE_INIT_IGNORE_VERMAGIC 2
>  #endif
> @@ -19,11 +23,11 @@
>  #ifndef HAVE_FINIT_MODULE
>  static inline int finit_module(int fd, const char *uargs, int flags)
>  {
> -#ifndef __NR_finit_module
> -       errno = ENOSYS;
> -       return -1;
> -#else
> -       return syscall(__NR_finit_module, fd, uargs, flags);
> -#endif
> +       if (__NR_finit_module == -1) {
> +               errno = ENOSYS;
> +               return -1;
> +       } else {
> +               return syscall(__NR_finit_module, fd, uargs, flags);
> +       }

humn... my bad not applying it to testsuite.

But I would expect the same fix being applied to testsuite instead of
changing the check to runtime.

Lucas De Marchi
