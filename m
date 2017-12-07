MIME-Version: 1.0
In-Reply-To: <20171207143119.7046-1-msuchanek@suse.de>
References: <20171207143119.7046-1-msuchanek@suse.de>
Date: Thu, 7 Dec 2017 11:07:59 -0800
Message-ID: <CAKi4VAK9QNE6F+7EX1t2fNx2zooxtV7qToED41j=vS-LZ0K6Nw@mail.gmail.com>
Subject: Re: [PATCH] depmod: Don't add .TOC. when it's in the kernel.
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Michal Suchanek <msuchanek@suse.de>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Thu, Dec 7, 2017 at 6:31 AM, Michal Suchanek <msuchanek@suse.de> wrote:
> d46136bb59c4 ("depmod: Ignore PowerPC64 ABIv2 .TOC. symbol") adds fake
> .TOC. unconditionally but when there is .TOC. in the kernel adding the
> fake one breaks resolving .TOC.
>
> Fixes: d46136bb59c4 ("depmod: Ignore PowerPC64 ABIv2 .TOC. symbol")
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  tools/depmod.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/depmod.c b/tools/depmod.c
> index 7ff3e9ed191e..9db602d76ee4 100644
> --- a/tools/depmod.c
> +++ b/tools/depmod.c
> @@ -2480,7 +2480,8 @@ static void depmod_add_fake_syms(struct depmod *depmod)
>         /* On S390, this is faked up too */
>         depmod_symbol_add(depmod, "_GLOBAL_OFFSET_TABLE_", true, 0, NULL);
>         /* On PowerPC64 ABIv2, .TOC. is more or less _GLOBAL_OFFSET_TABLE_ */
> -       depmod_symbol_add(depmod, "TOC.", true, 0, NULL);
> +       if (!depmod_symbol_find(depmod, "TOC."))
> +               depmod_symbol_add(depmod, "TOC.", true, 0, NULL);
>  }
>
>  static int depmod_load_symvers(struct depmod *depmod, const char *filename)
> --

Applied, thanks.


Lucas De Marchi
