Return-Path: <yousaf.kaukab@suse.com>
Message-ID: <1478539679.8215.31.camel@suse.com>
Subject: Re: [PATCH] depmod: ignore related modules in depmod_report_cycles
From: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
 bjorn.andersson@linaro.org,  afaerber@suse.de
Date: Mon, 07 Nov 2016 18:27:59 +0100
In-Reply-To: <CAKi4VAKkpfdni-fVW+nr=at4YK3P8cvy+-mFpmJX2QURzOKMMQ@mail.gmail.com>
References: <1478252037-5340-1-git-send-email-yousaf.kaukab@suse.com>
	 <CAKi4VAKkpfdni-fVW+nr=at4YK3P8cvy+-mFpmJX2QURzOKMMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-modules.vger.kernel.org>

On Sat, 2016-11-05 at 21:50 -0200, Lucas De Marchi wrote:
> Hi,
> 
> On Fri, Nov 4, 2016 at 7:33 AM, Mian Yousaf Kaukab
> <yousaf.kaukab@suse.com> wrote:
> > 
> > Only print actual cyclic dependencies. Don't print count of all the
> > modules as it includes other modules which have dependencies but
> > not
> > necessarily cyclic.
> > 
> > Printing related modules causes buffer overflow as m->modnamesz is
> > not
> > included in buffer size calculations (loop == m is never true).
> > This buffer overflow causes kmod to crash.
> > 
> > Reported-by: Andreas Färber <afaerber@suse.de>
> > Signed-off-by: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
> > ---
> > As count of modules in cyclic dependency chain is not known at the
> > start of this function, so it is not printed anymore. The output
> > when cyclic dependency is detected is changed as following:
> > 
> > Old:
> > depmod: ERROR: Found 8 modules in dependency cycles!
> > 
> > New:
> > depmod: ERROR: Modules found in dependency cycles!
> 
> I think it would be good to fix this problem, but retaining the
> behavior.
Would it be OK if the modules names are printed first and count is
printed afterward. Something like following: 

DEPMOD  4.9.0-rc4-default
depmod: ERROR: Cycle detected: qcom_wcnss_iris -> qcom_wcnss ->
qcom_wcnss_iris
depmod: ERROR: Found 2 modules in dependency cycles!
Makefile:1227: recipe for target '_modinst_post' failed

In this way modules names can still be printed in the loop and then the
exact count of modules involved in cyclic dependency is printed at the
end of the depmod_report_cycles().

> 
> My first reaction to this is "how do I reproduce the issue?". This
> number so far does tell us how many modules are involved in loops. 
There is more info at the following link:
https://bugzilla.opensuse.org/show_bug.cgi?id=1008186

You can reproduce the issue by enabling CONFIG_QCOM_WCNSS_PIL as module
in v4.9-rc4 for arm64. 
+CONFIG_REMOTEPROC=m
+CONFIG_QCOM_MDT_LOADER=m
-# CONFIG_QCOM_WCNSS_PIL is not set
+CONFIG_QCOM_WCNSS_IRIS=m
+CONFIG_QCOM_WCNSS_PIL=m

Issue will reproduce when depmod is run at the end of modules_install.

> So,
> for example:
> 
> A -> B -> D -> A
> B -> C -> B
C -> X
C -> Y
C -> Z
In this case count becomes 7. Which is misleading.

> This line should point to 4 modules. We don't know which module is
> wrong. But there are 4 modules involved in the loops. D could be the
> culprit.
> 
> The function should show what are the loops present (in "first found
> order" - it could very well report as "B -> D -> A -> B" the line
> above).
> 
> We have a testsuite to check if the loop detection is working in
> depmod. See testsuite/test-depmod.c:depmod_detect_loop().
> Would it be possible to add your use case there? [...]
Yes I can take a look.

> [...] If you tell me what
> are your dependency chain and cycle I can take a look.
> 
> If I misunderstood the issue with the total number, then at least the
> testsuite needs to be fixed, because right now it expects that number
> to be in the output (see
> testsuite/rootfs-pristine/test-depmod/detect-loop/correct.txt)
> 
> 
> thanks
> Lucas De Marchi
> 
BR,
Yousaf
