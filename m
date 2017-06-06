Return-Path: <thomas.petazzoni@free-electrons.com>
Date: Tue, 6 Jun 2017 09:16:35 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod] shared/util.c: assert_cc() can only be used inside
 functions
Message-ID: <20170606091635.7bc79852@free-electrons.com>
In-Reply-To: <CAKi4VA+CLw_QnPpMaiaRpAo+8oohNXha8CDdPR6sAn+DPDmJjw@mail.gmail.com>
References: <1496502202-9832-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAKi4VA+3azA-8pyNS0F73d_0ahCA7=n_opwnxp9A-2Y67oLe8w@mail.gmail.com>
	<20170605102237.4dd489c2@free-electrons.com>
	<CAKi4VA+CLw_QnPpMaiaRpAo+8oohNXha8CDdPR6sAn+DPDmJjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-modules.vger.kernel.org>

Hello,

On Mon, 5 Jun 2017 10:06:30 -0700, Lucas De Marchi wrote:

> > As you know, I'm contributing to Buildroot, an embedded Linux build
> > system, that allows to build from scratch lightweight, configurable
> > Linux systems through cross-compilation.  
> 
> Yep, I think I even may have 1 or 2 patches to buildroot :)

Yes, I know you're aware what Buildroot is :-) It was more an
explanation for the rest of the readers of this mailing list.

> > Buildroot is widely used in enterprise contexts, where sometimes very
> > old Linux distributions are used on build servers. As an example, we
> > even have to look at the version of the 'tar' utility available on the
> > host, and build our own if it's too old, because some old RHEL distros
> > have a tar version that is bogus.
> >
> > In order to make sure our users in this situation don't face problems,
> > we run test builds on old distros, and one of my automated build
> > machine has a Debian old enough to still be based on gcc 4.3.  
> 
> I don't want to personally maintain compatibility with that old
> compiler. I'll apply this, but it may break again in future.  If
> breakage is too often, then I'll ask for you to maintain those patches
> as downstream patches, ok?

We generally try to avoid maintaining downstream patches. So when that
happens, we'll probably just add the requirements that gcc version XYZ
is needed. And ask unhappy people to come complain to upstream
developers :-)

Thanks!

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
