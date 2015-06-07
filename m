Return-Path: <andi@rhlx01.hs-esslingen.de>
Date: Sun, 7 Jun 2015 11:17:42 +0200
From: Andreas Mohr <andi@lisas.de>
To: lucas.de.marchi@gmail.com
Cc: linux-modules@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	Andreas Mohr <andi@lisas.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bertrand Jacquin <beber@meleeweb.net>, Marco d'Itri <md@linux.it>,
	lkml <linux-kernel@vger.kernel.org>, Kay Sievers <kay@vrfy.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH kmod 3/3] tools: display features together with version
 information
Message-ID: <20150607091742.GA8285@rhlx01.hs-esslingen.de>
References: <1433658449-3931-1-git-send-email-lucas.de.marchi@gmail.com>
 <1433658449-3931-4-git-send-email-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433658449-3931-4-git-send-email-lucas.de.marchi@gmail.com>
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Sun, Jun 07, 2015 at 03:27:29AM -0300, lucas.de.marchi@gmail.com wrote:
> From: Lucas De Marchi <lucas.demarchi@intel.com>
> diff --git a/tools/kmod.c b/tools/kmod.c
> index c9d2cc8..28217df 100644
> --- a/tools/kmod.c
> +++ b/tools/kmod.c
> @@ -114,6 +114,7 @@ static int handle_kmod_commands(int argc, char *argv[])
>  			return EXIT_SUCCESS;
>  		case 'V':
>  			puts("kmod version " VERSION);
> +			puts(KMOD_FEATURES);
>  			return EXIT_SUCCESS;

Hmm - seems kmod.c is the only component
which open-codes literals
rather than making use of PACKAGE define?
If this is not intended,
then it would probably be useful
to have another correction commit prior to this one
included in the series,
to have this one gain properly fully symmetric content.

> diff --git a/tools/modinfo.c b/tools/modinfo.c
> index 94d55c9..86ac04b 100644
> --- a/tools/modinfo.c
> +++ b/tools/modinfo.c
> @@ -405,6 +405,7 @@ static int do_modinfo(int argc, char *argv[])
>  			return EXIT_SUCCESS;
>  		case 'V':
>  			puts(PACKAGE " version " VERSION);
> +			puts(KMOD_FEATURES);
>  			return EXIT_SUCCESS;

Thanks,

Andreas Mohr
