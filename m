MIME-Version: 1.0
In-Reply-To: <87h9qouuny.fsf@rustcorp.com.au>
References: <20150531152932.GA16337@rhlx01.hs-esslingen.de>
	<87r3pwgd0b.fsf@rustcorp.com.au>
	<CAKi4VAJfhM0UMOmFkQ40RW5gJGKch8AH8QEvuiYtj93O+YTNwA@mail.gmail.com>
	<87h9qouuny.fsf@rustcorp.com.au>
Date: Wed, 3 Jun 2015 23:31:20 -0300
Message-ID: <CAKi4VA+4mFsg7VCqr+3wd4dCqUtCW02YP7KYmVYF0prH5bet0g@mail.gmail.com>
Subject: Re: [PATCH] modules: CONFIG_MODULE_COMPRESS: add hint that userspace
 support may easily be missing.
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andreas Mohr <andi@lisas.de>, Andrew Morton <akpm@linux-foundation.org>,
	Bertrand Jacquin <beber@meleeweb.net>, "Marco d'Itri" <md@linux.it>,
	linux-modules <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jun 3, 2015 at 10:30 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
>> On Mon, Jun 1, 2015 at 3:26 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>>> Andreas Mohr <andi@lisas.de> writes:
>>>> Hi,
>>>>
>>>> I just had a not so nice experience
>>>> when finally upgrading to a new 4.1-rc5
>>>> with CONFIG_MODULE_COMPRESS newly enabled -
>>>> userspace binary parts (kmod 18 or 20 in my case)
>>>> did not have compression enabled
>>>> (at least on Debian 8pre, vs. encountering it enabled on FC21)
>>>> since it does not seem to be
>>>> the default build configuration of kmod (yet?).
>>>
>>> Sure.  Let's get the maintainers to insert the actual version required
>>> in the help text though.
>>
>> kmod supports gz since the first version and xz since version 3.  So both
>> of them can be safely fall into "it's supported since the beginning of
>> kmod IMO".
>
> Thanks, that's what I needed.
>
> But disappointing that Debian doesn't configure with it, and there's no
> easy way to check it.  Looks like Ubuntu vivid is the same.
>
> Might be time to change the default in kmod?
>
> Anyway, here's my patch, comments welcome.
>
> Subject: modules: clarify CONFIG_MODULE_COMPRESS help, suggest 'N'.
>
> Andreas turned this option on, only to find out Debian (and Ubuntu!)
> don't enable support in their kmod builds.
>
> Shorten the text, and suggest N at the bottom (at least for now).
>
> Reported-by: Andreas Mohr <andim2@users.sf.net>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 968a001790af..5422c44be5f0 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1948,26 +1948,22 @@ config MODULE_COMPRESS
>         bool "Compress modules on installation"
>         depends on MODULES
>         help
> -         This option compresses the kernel modules when 'make
> -         modules_install' is run.
>
> -         The modules will be compressed either using gzip or xz depend on the
> -         choice made in "Compression algorithm".
> +         Compresses kernel modules when 'make modules_install' is run; gzip or
> +         xz depending on "Compression algorithm" below.
>
> -         module-init-tools has support for gzip format while kmod handle gzip
> -         and xz compressed modules.
> +         module-init-tools supports gzip, and kmod can be configured to handle
> +         gzip and xz (but doesn't by default, at least as of version 18!).

This is pretty much misleading. There's no such a default option. It's
like saying kernel doesn't support feature X, Y or Z by default
because make defconfig doesn't turn them on.

The option is there since the beginning for the distros to adapt to their needs.

-- 
Lucas De Marchi
