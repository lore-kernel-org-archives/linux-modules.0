MIME-Version: 1.0
In-Reply-To: <20161123152339.27531-2-yauheni.kaliuta@redhat.com>
References: <20161123152339.27531-1-yauheni.kaliuta@redhat.com>
	<20161123152339.27531-2-yauheni.kaliuta@redhat.com>
Date: Mon, 8 May 2017 23:56:42 -0700
Message-ID: <CAKi4VAKesTLCAo2KRJEA0RBEd4ayEjO7_4Xp07j=GjnuyptKgQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] depmod: create depmod dir independent search function
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, aris@redhat.com,
	Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Wed, Nov 23, 2016 at 7:23 AM, Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
> Prepare to implement external directories support.
>
> The patch splits depmod_modules_search() function to two
> functions: depmod_modules_search(), called by the high level with
> intention to search all possible modules, and
> depmod_module_search_path(), which takes path as a parameter and
> scans modules under the path only. Initially it is used to scan
> the same depmod->cfg->dirname path only.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>  tools/depmod.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/tools/depmod.c b/tools/depmod.c
> index f2b370f146bb..a96501d1cbfb 100644
> --- a/tools/depmod.c
> +++ b/tools/depmod.c
> @@ -1186,29 +1186,42 @@ static int depmod_modules_search_dir(struct depmod *depmod, DIR *d, size_t basel
>         return err;
>  }
>
> -static int depmod_modules_search(struct depmod *depmod)
> +static int depmod_modules_search_path(struct depmod *depmod,
> +                                     const char *path)
>  {
> -       char path[PATH_MAX];
> -       DIR *d = opendir(depmod->cfg->dirname);
> +       char path_buf[PATH_MAX];

not required for this, but since now the path can be anywhere, this is
more prone to failures and could be a good candidate to use
scratchbuf.


> +       DIR *d;
>         size_t baselen;
>         int err;
> +
> +       d = opendir(path);
>         if (d == NULL) {
>                 err = -errno;
> -               ERR("could not open directory %s: %m\n", depmod->cfg->dirname);
> +               ERR("could not open directory %s: %m\n", path);
>                 return err;
>         }
>
> -       baselen = depmod->cfg->dirnamelen;
> -       memcpy(path, depmod->cfg->dirname, baselen);
> -       path[baselen] = '/';
> +       baselen = strlen(path);
> +       memcpy(path_buf, path, baselen);
> +       path_buf[baselen] = '/';
>         baselen++;
> -       path[baselen] = '\0';
> +       path_buf[baselen] = '\0';
>
> -       err = depmod_modules_search_dir(depmod, d, baselen, path);
> +       err = depmod_modules_search_dir(depmod, d, baselen, path_buf);
>         closedir(d);
>         return err;
>  }
>
> +static int depmod_modules_search(struct depmod *depmod)
> +{
> +       int err;
> +
> +       err = depmod_modules_search_path(depmod, depmod->cfg->dirname);
> +       if (err < 0)
> +               return err;
> +       return 0;
> +}

LGTM


Lucas De Marchi
