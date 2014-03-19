MIME-Version: 1.0
In-Reply-To: <1395185161-13687-1-git-send-email-anssi@mageia.org>
References: <1395185161-13687-1-git-send-email-anssi@mageia.org>
Date: Wed, 19 Mar 2014 09:24:10 -0300
Message-ID: <CAKi4VAL_4owLJvML7H9kXwnsD586P0iXtOnaVBTgJOM+aqeV=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] depmod: do not allow partial matches with "search" directive
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Anssi Hannula <anssi@mageia.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Anssi,

On Tue, Mar 18, 2014 at 8:26 PM, Anssi Hannula <anssi@mageia.org> wrote:
> Currently e.g. "search foo foobar built-in" will cause unpredictable
> results if baz.ko is in both foo/ and foobar/, since "foo" in search may
> match both of those directories and the preferred module therefore
> depends on processing order.
>
> Fix the code to ensure that the match is performed on full pathname
> components only.
> ---
>  tools/depmod.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/depmod.c b/tools/depmod.c
> index 9f83ee8..328e578 100644
> --- a/tools/depmod.c
> +++ b/tools/depmod.c
> @@ -1153,10 +1153,10 @@ static int depmod_module_is_higher_priority(const struct depmod *depmod, const s
>                 DBG("search %s\n", se->builtin ? "built-in" : se->path);
>                 if (se->builtin)
>                         bprio = i;
> -               else if (newlen >= se->len &&
> +               else if (newlen > se->len && newpath[se->len] == '/' &&
>                          memcmp(se->path, newpath, se->len) == 0)
>                         newprio = i;
> -               else if (oldlen >= se->len &&
> +               else if (oldlen > se->len && oldpath[se->len] == '/' &&
>                          memcmp(se->path, oldpath, se->len) == 0)
>                         oldprio = i;
>         }
> --


Both patches have been applied. Thanks a lot.

I added some test cases for depmod. Could you take a look if they are ok?

--
Lucas De Marchi
