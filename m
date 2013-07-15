Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:40872 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932364Ab3GOPTv (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 15 Jul 2013 11:19:51 -0400
Received: by mail-bk0-f54.google.com with SMTP id it16so4684950bkc.13
        for <linux-modules@vger.kernel.org>; Mon, 15 Jul 2013 08:19:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1373865179-18366-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1373865179-18366-1-git-send-email-lucas.demarchi@profusion.mobi>
From: Tom Gundersen <teg@jklm.no>
Date: Mon, 15 Jul 2013 17:19:29 +0200
Message-ID: <CAG-2HqVy+H99Q5D=dFCkpfMS3bhYhdHUZO6Ux6HxufH6DE=gcg@mail.gmail.com>
Subject: Re: [PATCH 1/6] testsuite: Fix mkdir_p corner cases
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-modules@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi Lucas,

Thanks for picking this up.

All the patches look good to me, and "kmod static-nodes" now works as expected.

Cheers,

Tom

On Mon, Jul 15, 2013 at 7:12 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> From: Lucas De Marchi <lucas.demarchi@intel.com>
>
>  - Fix infinite loop when path is relative
>  - Fix not considering EEXIST as a success
>  - General refactor to mkdir_p so it never calls mkdir for an existing
>    dir (given no creates it from outside)
> ---
>  testsuite/mkdir.c | 54 +++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 19 deletions(-)
>
> diff --git a/testsuite/mkdir.c b/testsuite/mkdir.c
> index 0a7de69..be2e37b 100644
> --- a/testsuite/mkdir.c
> +++ b/testsuite/mkdir.c
> @@ -23,47 +23,63 @@
>  #include "mkdir.h"
>  #include "testsuite.h"
>
> +static inline int is_dir(const char *path)
> +{
> +       struct stat st;
> +
> +       if (stat(path, &st) >= 0) {
> +               if (S_ISDIR(st.st_mode))
> +                       return 1;
> +               return 0;
> +       }
> +
> +       return -errno;
> +}
> +
>  TS_EXPORT int mkdir_p(const char *path, mode_t mode)
>  {
>         char *start = strdupa(path);
>         int len = strlen(path);
>         char *end = start + len;
> -       struct stat st;
>
>         /*
>          * scan backwards, replacing '/' with '\0' while the component doesn't
>          * exist
>          */
>         for (;;) {
> -               if (stat(start, &st) >= 0) {
> -                       if (S_ISDIR(st.st_mode))
> -                               break;
> -                       return -ENOTDIR;
> -               }
> +               int r = is_dir(start);
> +               if (r > 0) {
> +                       end += strlen(end);
>
> -               /* Find the next component, backwards, discarding extra '/'*/
> -               for (; end != start && *end != '/'; end--)
> -                       ;
> +                       if (end == start + len)
> +                               return 0;
>
> -               for (; end != start - 1 && *end == '/'; end--)
> -                       ;
> +                       /* end != start, since it would be caught on the first
> +                        * iteration */
> +                       *end = '/';
> +                       break;
> +               } else if (r == 0)
> +                       return -ENOTDIR;
>
> -               end++;
>                 if (end == start)
>                         break;
>
>                 *end = '\0';
> -       }
>
> -       if (end == start + len)
> -               return 0;
> +               /* Find the next component, backwards, discarding extra '/'*/
> +               while (end > start && *end != '/')
> +                       end--;
>
> -       for (; end < start + len;) {
> -               *end = '/';
> -               end += strlen(end);
> +               while (end > start && *(end - 1) == '/')
> +                       end--;
> +       }
>
> -               if (mkdir(start, mode) < 0)
> +       for (; end < start + len;) {
> +               if (mkdir(start, mode) < 0 && errno != EEXIST)
>                         return -errno;
> +
> +               end += strlen(end);
> +               *end = '/';
>         }
>
>         return 0;
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-modules" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
