Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 Jan 2012 15:17:10 +0100
From: Michal Marek <mmarek@suse.cz>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Cong Wang <amwang@redhat.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH] kbuild: do not check for ancient modutils tools
Message-ID: <20120123141710.GA26809@sepie.suse.cz>
References: <1326819051-25712-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1326861219.490.4.camel@cr0>
 <CAPXgP12vChg=820uamRa6dTekEQD_xa6mg-nroOm1br+7-JCqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPXgP12vChg=820uamRa6dTekEQD_xa6mg-nroOm1br+7-JCqw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Fri, Jan 20, 2012 at 05:40:58PM +0100, Kay Sievers wrote:
> On Wed, Jan 18, 2012 at 05:33, Cong Wang <amwang@redhat.com> wrote:
> > On Tue, 2012-01-17 at 14:50 -0200, Lucas De Marchi wrote:
> >> scripts/depmod.sh checks for the output of '-V' expecting that it has
> >> module-init-tools in it. It's a hack to prevent users from using
> >> modutils instead of module-init-tools, that only works with 2.4.x
> >> kernels. This however prints an annoying warning for kmod tool, that is
> >> currently replacing module-init-tools.

You could call kmod "module-init-tools 3.13 (compatible; kmod 3)" ;)

Just kidding.


> >> Rather than putting another check for kmod's version, just remove it
> >> since users of 2.4.x kernel are unlikely to upgrade to 3.x, and if they
> >> do, let depmod fail in that case because they should know what they are
> >> doing.
> >>
> >> Signed-off-by: Lucas De Marchi <lucas.demarchi@profusion.mobi>
> >
> > Acked-by: WANG Cong <amwang@redhat.com>
> 
> Michal, mind picking this up? The warning it produces with kmod is
> really misleading, and the check seems unnecessary these days.

I applied it to kbuild.git#rc-fixes and will send it to Linus for 3.3.

Michal
