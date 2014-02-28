MIME-Version: 1.0
In-Reply-To: <1393541533-14719-4-git-send-email-mmarek@suse.cz>
References: <1393541533-14719-1-git-send-email-mmarek@suse.cz>
	<1393541533-14719-4-git-send-email-mmarek@suse.cz>
Date: Fri, 28 Feb 2014 03:37:00 -0300
Message-ID: <CAKi4VALWBwufCSaMU4t3w+NYDEzyc5ap5ncObb=b=r0_VUWKiQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] testsuite: Do not provide finit_module(2) on older kernels
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Michal Marek <mmarek@suse.cz>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Thu, Feb 27, 2014 at 7:52 PM, Michal Marek <mmarek@suse.cz> wrote:
> If the test's uname -r is less that 3.8, return -ENOSYS from
> finit_module(), so that the fallback is tested.
> ---
>  testsuite/init_module.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
>
> diff --git a/testsuite/init_module.c b/testsuite/init_module.c
> index 42177e7..96f4aa7 100644
> --- a/testsuite/init_module.c
> +++ b/testsuite/init_module.c
> @@ -37,6 +37,7 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/syscall.h>
> +#include <sys/utsname.h>
>  #include <unistd.h>
>
>  /* kmod_elf_get_section() is not exported, we need the private header */
> @@ -280,6 +281,25 @@ long init_module(void *mem, unsigned long len, const char *args)
>         return err;
>  }
>
> +static int check_kernel_version(int major, int minor)
> +{
> +       struct utsname u;
> +       const char *p;
> +       int maj = 0, min = 0;
> +
> +       if (uname(&u) < 0)
> +               return false;
> +       for (p = u.release; *p >= '0' && *p <= '9'; p++)
> +               maj = maj * 10 + *p - '0';
> +       if (*p == '.')
> +               for (p++; *p >= '0' && *p <= '9'; p++)
> +                       min = min * 10 + *p - '0';
> +       if (maj > major || (maj == major && min >= minor))
> +               return true;
> +       return false;
> +}
> +
> +
>  TS_EXPORT int finit_module(const int fd, const char *args, const int flags);
>
>  int finit_module(const int fd, const char *args, const int flags)
> @@ -289,6 +309,11 @@ int finit_module(const int fd, const char *args, const int flags)
>         unsigned long len;
>         struct stat st;
>
> +       if (!check_kernel_version(3, 8)) {
> +               stat("/old/kernel", &st);

leftover?

-- 

Lucas De Marchi
