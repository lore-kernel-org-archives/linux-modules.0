Return-Path: <andi@rhlx01.hs-esslingen.de>
Date: Thu, 4 Jun 2015 22:09:27 +0200
From: Andreas Mohr <andi@lisas.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
	Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Andreas Mohr <andi@lisas.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bertrand Jacquin <beber@meleeweb.net>, Marco d'Itri <md@linux.it>,
	linux-modules <linux-modules@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>, Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH] modules: CONFIG_MODULE_COMPRESS: add hint that userspace
 support may easily be missing.
Message-ID: <20150604200927.GB15890@rhlx01.hs-esslingen.de>
References: <20150531152932.GA16337@rhlx01.hs-esslingen.de>
 <87r3pwgd0b.fsf@rustcorp.com.au>
 <CAKi4VAJfhM0UMOmFkQ40RW5gJGKch8AH8QEvuiYtj93O+YTNwA@mail.gmail.com>
 <87h9qouuny.fsf@rustcorp.com.au>
 <20150604131946.6441b568@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150604131946.6441b568@canb.auug.org.au>
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Thu, Jun 04, 2015 at 01:19:46PM +1000, Stephen Rothwell wrote:
> Hi Rusty,
> > But disappointing that Debian doesn't configure with it, and there's no
> > easy way to check it.  Looks like Ubuntu vivid is the same.
>=20
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D772628

Crap, that URL now is an implicit strong suggestion
that I didn't do my homework ;)
(it already described large parts
prior to me regurgitating this issue
due to being unaware of this history here).


Thanks to R.Russell for a very nice shortening
and extension of the help text!


Since the issue of .gz vs. .xz redundancy came up
(with people "threatening" to support only one alternative),
I want to mention that
when having to choose one
I'd tend to activating the .xz library dependency:
- while it has higher compression demands,
  hardware is getting beefier all the time,
  thus it should not matter
  (especially vs. the dominantly many decompression runs)
- it's simply the "more modern" and future-proof option,
  thus it should be favoured slightly
  since the system as a whole
  would want to make reasonably quick
  development/evolution "forward progress"
  rather than sticking to less favourable mechanisms
- .xz has been available for some time already
  i.e. the time window of "distro support maturity" is a given
[a counter-point might be that module-init-tools supports .gz only,
but then modern binary setups which chose .xz
would already have been shipped with kmod only]

OK, having said that,
I'm unsure what to think of the Debian package's decision
to not support compression so far
(and that even in times
where kmod does not provide a runtime option yet
to query the actual set of support flags).
=46rom a library dependency POV it may be attractive to skip compression,
and since Debian usually has a fixed setup
where non-compressed files are a given,
this seems like a valid choice.
It's just that for e.g. these situations:
- people with many custom kernels installed
- space-constrained systems
this is quite a nuisance that is a wee bit too unexpected (/show-stopper) -
took me roughly > 30 minutes to get it researched / resolved.

Thanks,

Andreas
