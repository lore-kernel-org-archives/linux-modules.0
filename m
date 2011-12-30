Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20111230153741.GA2167@redhat.com>
References: <1325173819-26274-1-git-send-email-lucas.demarchi@profusion.mobi>
 <20111229172101.GB4101@redhat.com> <4EFD913E.7010707@suse.cz> <20111230153741.GA2167@redhat.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 30 Dec 2011 14:40:29 -0200
Message-ID: <CAMOw1v6U+pTHbR=qZQyeQ0_oUOwKudxc=fyhLgcVCT=B_-2_kQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: add target to install gzipped modules
To: Dave Jones <davej@redhat.com>, Michal Marek <mmarek@suse.cz>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Sam Ravnborg <sam@ravnborg.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jan Engelhardt <jengelh@medozas.de>,
	Kay Sievers <kay.sievers@vrfy.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Fri, Dec 30, 2011 at 1:37 PM, Dave Jones <davej@redhat.com> wrote:
> On Fri, Dec 30, 2011 at 11:23:58AM +0100, Michal Marek wrote:
> �> On 29.12.2011 18:21, Dave Jones wrote:
> �> > On Thu, Dec 29, 2011 at 01:50:18PM -0200, Lucas De Marchi wrote:
> �> > �> Add target in Makefile to compress the module after it's installed.
> �> > �> Module-init-tools and libkmod can handle gzipped modules.
> �> > �>
> �> > �> This is not much useful for distributions because the package will gzip
> �> > �> the modules and call depmod in a install rule.
> �> >
> �> > It might actually be a worthwhile thing for distributions.
> �> >
> �> > For a Fedora kernel, gzipping modules saves around 80MB of diskspace per
> �> > installed kernel. �That the RPM is compressed is irrelevant, the on-disk
> �> > footprint is more interesting, given that the bulk of the modules installed
> �> > will never even be loaded.
> �>
> �> But it kills performance of the tools.
>
> How often do you run depmod ?
>
> If modprobe is a bottleneck, you have other problems.

modprobe is not a problem because it needs to read the entire blob to
insert regardless. The only affected tools would be depmod and
modinfo, but if this is really a problem, we could change the loader
of gz and xz files to stop when the ".modinfo" section was read for
the modinfo command.

As I said, I don't want to debate here whether it's good or not to
have compressed modules. It would be nice though to cook up some
numbers on different setups with the different compression methods
(none, gz, xz).

Lucas De Marchi
