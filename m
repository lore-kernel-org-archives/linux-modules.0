MIME-Version: 1.0
In-Reply-To: <54810109.7030409@gentoo.org>
References: <54810109.7030409@gentoo.org>
Date: Tue, 16 Dec 2014 18:46:27 -0200
Message-ID: <CAKi4VAL1C00z-pO8ODcvDD-=CfPjgpM1SMg53HsDJ6QTWQFgDQ@mail.gmail.com>
Subject: Re: [PATCH] build: Do not force diagnostics-color flag
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Mike Auty <ikelos@gentoo.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Thu, Dec 4, 2014 at 10:49 PM, Mike Auty <ikelos@gentoo.org> wrote:
> The -fdiagnostics-color flag is only available on GCC >= 4.9, for
> older versions this could raise an error in certain circumstances
> (such as when using ccache).  Instead, since -fdiagnostic-color=auto
> by default  in gcc-4.9, simply set the required environment variable
> to the default one if it's undefined.
>
> Based mostly on the systemd commit f44541bc by Michal Schmidt.
> ---
>  Makefile.am  | 3 +++
>  configure.ac | 1 -
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index ea5cbac..51825f0 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -11,6 +11,9 @@ BUILT_FILES =
>  ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}
>  AM_MAKEFLAGS = --no-print-directory
>
> +GCC_COLORS ?=
> 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
> +export GCC_COLORS

Do we really need to specify the colors ourselves? Systemd's commit
seems to only export any value in the variable to get the default
ones.

I'm fine with this approach for compatibility with gcc < 4.9, but the
patch is corrupted by your mail client.
Could you send it with git-send-email or attach it.

Thanks.

Lucas De Marchi
