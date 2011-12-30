Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4EFD913E.7010707@suse.cz>
Date: Fri, 30 Dec 2011 11:23:58 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Sam Ravnborg <sam@ravnborg.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kbuild: add target to install gzipped modules
References: <1325173819-26274-1-git-send-email-lucas.demarchi@profusion.mobi> <20111229172101.GB4101@redhat.com>
In-Reply-To: <20111229172101.GB4101@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On 29.12.2011 18:21, Dave Jones wrote:
> On Thu, Dec 29, 2011 at 01:50:18PM -0200, Lucas De Marchi wrote:
>  > Add target in Makefile to compress the module after it's installed.
>  > Module-init-tools and libkmod can handle gzipped modules.
>  > 
>  > This is not much useful for distributions because the package will gzip
>  > the modules and call depmod in a install rule. 
> 
> It might actually be a worthwhile thing for distributions.
> 
> For a Fedora kernel, gzipping modules saves around 80MB of diskspace per
> installed kernel.  That the RPM is compressed is irrelevant, the on-disk
> footprint is more interesting, given that the bulk of the modules installed
> will never even be loaded.

But it kills performance of the tools.

Michal
