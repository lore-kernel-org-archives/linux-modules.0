MIME-Version: 1.0
In-Reply-To: <1465536270.26682.11.camel@ellerman.id.au>
References: <1465536270.26682.11.camel@ellerman.id.au>
Date: Sat, 11 Jun 2016 00:27:16 -0300
Message-ID: <CAKi4VA+7WZy_Pm7Am7PaSjQAp+jb6RAhXjZRMcjPxmy3o3joEQ@mail.gmail.com>
Subject: Re: [RESEND RESEND PATCH] depmod: Ignore PowerPC64 ABIv2 .TOC. symbol
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>, linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Fri, Jun 10, 2016 at 2:24 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> From: Anton Blanchard <anton@samba.org>
>
> The .TOC. symbol on the PowerPC64 ABIv2 identifies the GOT
> pointer, similar to how other architectures use _GLOBAL_OFFSET_TABLE_.
>
> This is not a symbol that needs relocation, and should be ignored
> by depmod.
>
> ---
>  tools/depmod.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/depmod.c b/tools/depmod.c
> index 6e9bb4d..a2e07c1 100644
> --- a/tools/depmod.c
> +++ b/tools/depmod.c
> @@ -2153,6 +2153,8 @@ static void depmod_add_fake_syms(struct depmod *depmod)
>         depmod_symbol_add(depmod, "__this_module", true, 0, NULL);
>         /* On S390, this is faked up too */
>         depmod_symbol_add(depmod, "_GLOBAL_OFFSET_TABLE_", true, 0, NULL);
> +       /* On PowerPC64 ABIv2, .TOC. is more or less _GLOBAL_OFFSET_TABLE_ */
> +       depmod_symbol_add(depmod, "TOC.", true, 0, NULL);
>  }
>
>  static int depmod_load_symvers(struct depmod *depmod, const char *filename)


Applied, thanks

Lucas De Marchi
