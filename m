MIME-Version: 1.0
In-Reply-To: <52A8273D.6060700@linux.vnet.ibm.com>
References: <52A8273D.6060700@linux.vnet.ibm.com>
Date: Thu, 12 Dec 2013 12:12:53 -0200
Message-ID: <CAKi4VA+AyBwpHNzHLqDAz09da-fvRzXRogXrPzqgwWazzQvh3A@mail.gmail.com>
Subject: Re: Question regarding kmod pkg
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: snehal <snehal@linux.vnet.ibm.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Deepak C Shetty <deepakcs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Snehal,

On Wed, Dec 11, 2013 at 6:50 AM, snehal <snehal@linux.vnet.ibm.com> wrote:
> Hello,
>
> I am working on a new architecture - ppc64le (powerpc 64-bit Little
> Endian) and I was working on kmod pkg on our ppc64le environment.
>
> The upstream tarball has the config.guess,config.sub, configure and
> libtool files
>
> I find that kmod already has updated config.guess, which supports ppc64le.
> Following is the latest file, I suppose this is already in tar.
> http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD.
>
>
> We have worked with libtool maintainer to get alpha source release
> that has all the needed bits to support building on ppc64le.We request you
> to spin
> off a new version of your package using the alpha libtool release. You
> can pick up the libtool alpha source release from either of the below :
>
> ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.418.tar.gz  (1.6MB)
>
> ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.418.tar.xz  (920KB)
>
>
> Could you please build and install the libtool alpha version and be able
> to spin new versions of kmod which would support ppc64le?
>
> Please let me know once you spin of the new pkg
>
> Your response is highly appreciated

This is something that could be easily done by distributions
supporting this new architecture.  Once libtool releases a new version
this patch can naturally be removed from kmod and other packages.

We already ship with a very recent version in the tarball and suffer
because of this (see 9de9e07da6ce6fc110b4359ff058b13b5e92dcf4). My
past experience with libtool developers fixing bugs or at least
answering the bugs reported is pretty bad, so I won't update to an
alpha version anytime soon.

regards,
Lucas De Marchi
