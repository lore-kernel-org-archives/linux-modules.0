Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 30 Dec 2011 10:37:41 -0500
From: Dave Jones <davej@redhat.com>
To: Michal Marek <mmarek@suse.cz>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Sam Ravnborg <sam@ravnborg.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kbuild: add target to install gzipped modules
Message-ID: <20111230153741.GA2167@redhat.com>
References: <1325173819-26274-1-git-send-email-lucas.demarchi@profusion.mobi>
 <20111229172101.GB4101@redhat.com>
 <4EFD913E.7010707@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EFD913E.7010707@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Fri, Dec 30, 2011 at 11:23:58AM +0100, Michal Marek wrote:
 > On 29.12.2011 18:21, Dave Jones wrote:
 > > On Thu, Dec 29, 2011 at 01:50:18PM -0200, Lucas De Marchi wrote:
 > >  > Add target in Makefile to compress the module after it's installed.
 > >  > Module-init-tools and libkmod can handle gzipped modules.
 > >  > 
 > >  > This is not much useful for distributions because the package will gzip
 > >  > the modules and call depmod in a install rule. 
 > > 
 > > It might actually be a worthwhile thing for distributions.
 > > 
 > > For a Fedora kernel, gzipping modules saves around 80MB of diskspace per
 > > installed kernel.  That the RPM is compressed is irrelevant, the on-disk
 > > footprint is more interesting, given that the bulk of the modules installed
 > > will never even be loaded.
 > 
 > But it kills performance of the tools.

How often do you run depmod ?

If modprobe is a bottleneck, you have other problems.

	Dave

