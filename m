Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 29 Dec 2011 12:21:02 -0500
From: Dave Jones <davej@redhat.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Michal Marek <mmarek@suse.cz>, Sam Ravnborg <sam@ravnborg.org>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kbuild: add target to install gzipped modules
Message-ID: <20111229172101.GB4101@redhat.com>
References: <1325173819-26274-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325173819-26274-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Thu, Dec 29, 2011 at 01:50:18PM -0200, Lucas De Marchi wrote:
 > Add target in Makefile to compress the module after it's installed.
 > Module-init-tools and libkmod can handle gzipped modules.
 > 
 > This is not much useful for distributions because the package will gzip
 > the modules and call depmod in a install rule. 

It might actually be a worthwhile thing for distributions.

For a Fedora kernel, gzipping modules saves around 80MB of diskspace per
installed kernel.  That the RPM is compressed is irrelevant, the on-disk
footprint is more interesting, given that the bulk of the modules installed
will never even be loaded.

	Dave

