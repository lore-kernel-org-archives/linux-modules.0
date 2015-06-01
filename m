Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:58124 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbbFAGxb (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 1 Jun 2015 02:53:31 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andreas Mohr <andi@lisas.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Bertrand Jacquin <beber@meleeweb.net>, Marco d'Itri <md@linux.it>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Jon Masters" <jcm@redhat.com>
Subject: Re: [PATCH] modules: CONFIG_MODULE_COMPRESS: add hint that userspace support may easily be missing.
In-Reply-To: <20150531152932.GA16337@rhlx01.hs-esslingen.de>
References: <20150531152932.GA16337@rhlx01.hs-esslingen.de>
Date: Mon, 01 Jun 2015 15:56:44 +0930
Message-ID: <87r3pwgd0b.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Andreas Mohr <andi@lisas.de> writes:
> Hi,
>
> I just had a not so nice experience
> when finally upgrading to a new 4.1-rc5
> with CONFIG_MODULE_COMPRESS newly enabled -
> userspace binary parts (kmod 18 or 20 in my case)
> did not have compression enabled
> (at least on Debian 8pre, vs. encountering it enabled on FC21)
> since it does not seem to be
> the default build configuration of kmod (yet?).

Sure.  Let's get the maintainers to insert the actual version required
in the help text though.

Thanks,
Rusty.

> Doing a manual
>     for gz in $(find . -name "*.gz"); do echo gunzip $gz; done
>     depmod -a (somewhere temporarily in bootup scripts)
> manages to fix the grave problem
> introduced by erroneously having enabled CONFIG_MODULE_COMPRESS.
>
> Thus it seems that the Kconfig text was much more optimistic
> than a hapless user would want to encounter,
> thus I decided to have it updated.
>
>
> BTW: kmod and/or module-init-tools packages
> might want to provide a generic way to openly advertise
> certain build-configured "capabilities" in the binary -
> neither
>     kmod --help
> nor
>     kmod -V
> indicated whether or not they provided capabilities
> such as e.g. providing or not providing support of compression types
> and which ones.
> That would have been a very helpful way
> to reliably determine
> that support in fact is missing in the binary,
> rather than having to resort to clumsy hacks
> such as ldd or even strings.
>
>
> While this is a minor but useful addition
> rather than a severe fix,
> having a CC to stable@ added subsequently might be useful.
>
> Thanks!
>
> Signed-off-by: Andreas Mohr <andim2@users.sf.net>
>
> ---
>  init/Kconfig | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index dc24dec..8e451f30 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1951,11 +1951,19 @@ config MODULE_COMPRESS
>  	  This option compresses the kernel modules when 'make
>  	  modules_install' is run.
>  
> -	  The modules will be compressed either using gzip or xz depend on the
> -	  choice made in "Compression algorithm".
> -
> -	  module-init-tools has support for gzip format while kmod handle gzip
> -	  and xz compressed modules.
> +	  The module files will be compressed either using gzip or xz
> +	  depending on the choice made in "Compression algorithm".
> +
> +	  Obviously one will then need appropriate userspace parts
> +	  which are actually able to deal with compressed files, too:
> +	  module-init-tools has support for gzip format
> +	  while kmod handles gzip and xz compressed modules.
> +	  However, we observed that in several environments
> +	  module loader binaries do not have that enabled (yet?)
> +	  and thus bootup will fail fatally -
> +	  manually doing ldd on these binaries
> +	  to detect compression libraries
> +	  is a tell-tale sign of having support enabled.
>  
>  	  When a kernel module is installed from outside of the main kernel
>  	  source and uses the Kbuild system for installing modules then that
> -- 
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
