MIME-Version: 1.0
In-Reply-To: <1377541250-10193-1-git-send-email-maillist-kmod@barfooze.de>
References: <1377541250-10193-1-git-send-email-maillist-kmod@barfooze.de>
Date: Mon, 26 Aug 2013 20:46:46 -0300
Message-ID: <CAKi4VAJJScguBb_mMaFwieTcq0VpRXLVpKaXKx0_4M+6DuU3Xg@mail.gmail.com>
Subject: Re: [PATCH 1/3] remove non-portable usage of strndupa
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: John Spencer <maillist-kmod@barfooze.de>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Mon, Aug 26, 2013 at 3:20 PM, John Spencer <maillist-kmod@barfooze.de> wrote:
> usage of strndupa is neither C99 nor POSIX,
> so musl libc does not implement it.
> it's a glibc invention, and a dangerous one since
> usage of alloca() is considered bad practice.

If the input is already sanitized and checked for length, this is
isn't really dangerous. Particularly on recursive functions this also
avoids growing the stack much more than needed.

>
> fixes build with musl libc.

for me it seems more like an excuse to not implement it in musl.
Particularly because there are other places in which we call alloca(),
that you didn't complain. What does musl do there? If musl has
alloca(), doing strndupa in missing.h would be doable.

>
> Signed-off-by: John Spencer <maillist-kmod@barfooze.de>
>
> ---
>  libkmod/libkmod-util.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/libkmod/libkmod-util.c b/libkmod/libkmod-util.c
> index d686250..9615d0f 100644
> --- a/libkmod/libkmod-util.c
> +++ b/libkmod/libkmod-util.c
> @@ -28,6 +28,7 @@
>  #include <unistd.h>
>  #include <errno.h>
>  #include <string.h>
> +#include <limits.h>
>  #include <ctype.h>
>
>  #include "libkmod.h"
> @@ -323,8 +324,11 @@ static inline int is_dir(const char *path)
>  int mkdir_p(const char *path, int len, mode_t mode)
>  {
>         char *start, *end;
> -
> -       start = strndupa(path, len);
> +       char buf[PATH_MAX+1];
> +       snprintf(buf, sizeof buf, "%s", path);

snprintf to dup a string? You already know the len. memcpy would be way simpler

Lucas De Marchi
