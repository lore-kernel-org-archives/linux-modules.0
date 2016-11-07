Return-Path: <bjorn.andersson@linaro.org>
Return-Path: <bjorn.andersson@linaro.org>
Date: Mon, 7 Nov 2016 12:23:44 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	linux-modules <linux-modules@vger.kernel.org>, afaerber@suse.de
Subject: Re: [PATCH] depmod: ignore related modules in depmod_report_cycles
Message-ID: <20161107202344.GE25787@tuxbot>
References: <1478252037-5340-1-git-send-email-yousaf.kaukab@suse.com>
 <CAKi4VAKkpfdni-fVW+nr=at4YK3P8cvy+-mFpmJX2QURzOKMMQ@mail.gmail.com>
 <1478539679.8215.31.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1478539679.8215.31.camel@suse.com>
List-ID: <linux-modules.vger.kernel.org>

On Mon 07 Nov 09:27 PST 2016, Mian Yousaf Kaukab wrote:

> On Sat, 2016-11-05 at 21:50 -0200, Lucas De Marchi wrote:
> > Hi,
> > 
> > On Fri, Nov 4, 2016 at 7:33 AM, Mian Yousaf Kaukab
> > <yousaf.kaukab@suse.com> wrote:
> > > 
> > > Only print actual cyclic dependencies. Don't print count of all the
> > > modules as it includes other modules which have dependencies but
> > > not
> > > necessarily cyclic.
> > > 
> > > Printing related modules causes buffer overflow as m->modnamesz is
> > > not
> > > included in buffer size calculations (loop == m is never true).
> > > This buffer overflow causes kmod to crash.
> > > 
> > > Reported-by: Andreas F�rber <afaerber@suse.de>
> > > Signed-off-by: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
> > > ---
> > > As count of modules in cyclic dependency chain is not known at the
> > > start of this function, so it is not printed anymore. The output
> > > when cyclic dependency is detected is changed as following:
> > > 
> > > Old:
> > > depmod: ERROR: Found 8 modules in dependency cycles!
> > > 
> > > New:
> > > depmod: ERROR: Modules found in dependency cycles!
> > 
> > I think it would be good to fix this problem, but retaining the
> > behavior.
> Would it be OK if the modules names are printed first and count is
> printed afterward. Something like following:�
> 
> DEPMOD��4.9.0-rc4-default
> depmod: ERROR: Cycle detected: qcom_wcnss_iris -> qcom_wcnss ->
> qcom_wcnss_iris
> depmod: ERROR: Found 2 modules in dependency cycles!
> Makefile:1227: recipe for target '_modinst_post' failed
> 
> In this way modules names can still be printed in the loop and then the
> exact count of modules involved in cyclic dependency is printed at the
> end of the depmod_report_cycles().
> 
> > 
> > My first reaction to this is "how do I reproduce the issue?". This
> > number so far does tell us how many modules are involved in loops. 
> There is more info at the following link:
> https://bugzilla.opensuse.org/show_bug.cgi?id=1008186
> 
> You can reproduce the issue by enabling�CONFIG_QCOM_WCNSS_PIL as module
> in v4.9-rc4 for arm64.�
> +CONFIG_REMOTEPROC=m
> +CONFIG_QCOM_MDT_LOADER=m
> -# CONFIG_QCOM_WCNSS_PIL is not set
> +CONFIG_QCOM_WCNSS_IRIS=m
> +CONFIG_QCOM_WCNSS_PIL=m
> 

I added some debugging prints to track the stack management in
depmod_report_cycles().

remoteproc, mdt_loader, wcnss_iris and wcnss_pil are all roots and we
have dependencies like this.

       /---(rproc)
       |     ^
       |     |
(pil) -+-> (mdt)
  ^    |
  |    v
  +- (iris)

1) We pick rproc as first root, mark that as visited and see that we're
   done.

2) We pick mdt_loader as second root, we push remoteproc to the stack
   and find that it's already visited, so we found a loop!

     mdt_loader -> remoteproc

3) We pick iris as third root, we push wcnss which pushes remoteproc,
   mdt_loader and iris. All three have already been visited from root #1
   and #2, so we find that there's a loop in:

     iris -> wcnss -> iris
     iris -> wcnss -> mdt
     iris -> wcnss -> remoteproc

Only one of these cases are actually a cycle, but as we don't reset
visited between the searches we can't tell. Further more, if there was a
dependency from iris -> remoteproc that would have shown up earlier and
marked iris->visited and when we get to step #3 we would just have
bailed directly - completely missing the cycle.

So I think we need to reset the visited list on each run of the DFS from
each root.

Regards,
Bjorn
