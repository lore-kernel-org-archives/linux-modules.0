Return-Path: <bjorn.andersson@linaro.org>
Return-Path: <bjorn.andersson@linaro.org>
Date: Tue, 8 Nov 2016 09:03:32 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	linux-modules <linux-modules@vger.kernel.org>, afaerber@suse.de
Subject: Re: [PATCH] depmod: ignore related modules in depmod_report_cycles
Message-ID: <20161108170332.GM25787@tuxbot>
References: <1478252037-5340-1-git-send-email-yousaf.kaukab@suse.com>
 <CAKi4VAKkpfdni-fVW+nr=at4YK3P8cvy+-mFpmJX2QURzOKMMQ@mail.gmail.com>
 <1478539679.8215.31.camel@suse.com>
 <20161107202344.GE25787@tuxbot>
 <1478597819.6418.13.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1478597819.6418.13.camel@suse.com>
List-ID: <linux-modules.vger.kernel.org>

On Tue 08 Nov 01:36 PST 2016, Mian Yousaf Kaukab wrote:

> On Mon, 2016-11-07 at 12:23 -0800, Bjorn Andersson wrote:
> > On Mon 07 Nov 09:27 PST 2016, Mian Yousaf Kaukab wrote:
[..]
> > 
> > I added some debugging prints to track the stack management in
> > depmod_report_cycles().
> > 
> > remoteproc, mdt_loader, wcnss_iris and wcnss_pil are all roots and we
> > have dependencies like this.
> > 
> > �������/---(rproc)
> > �������|�����^
> > �������|�����|
> > (pil) -+-> (mdt)
> > � ^����|
> > � |����v
> > � +- (iris)
> AFAICT this is not correct. Dependencies are like following:
> 
> pil -> rproc
> pil -> mtd -> rproc
> pil -> iris -> pil

All dependencies are:

pil -> rproc
pil -> mdt
mdt -> rproc
pil -> iris
iris -> pil

The last two forming a cyclic subgraph in a dependency graph including
all of them.

> 
> > 
> > 1) We pick rproc as first root, mark that as visited and see that
> > we're
> > ���done.
> > 
> > 2) We pick mdt_loader as second root, we push remoteproc to the stack
> > ���and find that it's already visited, so we found a loop!
> > 
> > �����mdt_loader -> remoteproc
> This is not cyclic.
> 

Exactly my point. But the DFS will find this cycle, as we don't reset
"visited" between the iterations in the loop.

> > 
> > 3) We pick iris as third root, we push wcnss which pushes remoteproc,
> > ���mdt_loader and iris. All three have already been visited from root
> > #1
> > ���and #2, so we find that there's a loop in:
> > 
> > �����iris -> wcnss -> iris
> > �����iris -> wcnss -> mdt
> > �����iris -> wcnss -> remoteproc
> > 
> > Only one of these cases are actually a cycle, but as we don't reset
> > visited between the searches we can't tell. Further more, if there
> > was a
> > dependency from iris -> remoteproc that would have shown up earlier
> > and
> > marked iris->visited and when we get to step #3 we would just have
> > bailed directly - completely missing the cycle.
> In case we have more than one cyclic dependencies around same modules?

Well in this case we have a mixture of cyclic and non-cyclic subgraphs
that the DFS hits due to the "visited" issue above, the non-cyclic ones
are what triggers the buffer overflow.

> May be we should add a testcase for such a scenario so that its easy to
> understand and reproduce.
> 

+1

Thanks for looking at this!

Regards,
Bjorn
