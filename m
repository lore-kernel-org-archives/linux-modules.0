MIME-Version: 1.0
In-Reply-To: <1478252037-5340-1-git-send-email-yousaf.kaukab@suse.com>
References: <1478252037-5340-1-git-send-email-yousaf.kaukab@suse.com>
Date: Sat, 5 Nov 2016 21:50:37 -0200
Message-ID: <CAKi4VAKkpfdni-fVW+nr=at4YK3P8cvy+-mFpmJX2QURzOKMMQ@mail.gmail.com>
Subject: Re: [PATCH] depmod: ignore related modules in depmod_report_cycles
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Fri, Nov 4, 2016 at 7:33 AM, Mian Yousaf Kaukab
<yousaf.kaukab@suse.com> wrote:
> Only print actual cyclic dependencies. Don't print count of all the
> modules as it includes other modules which have dependencies but not
> necessarily cyclic.
>
> Printing related modules causes buffer overflow as m->modnamesz is not
> included in buffer size calculations (loop =3D=3D m is never true).
> This buffer overflow causes kmod to crash.
>
> Reported-by: Andreas F=C3=A4rber <afaerber@suse.de>
> Signed-off-by: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
> ---
> As count of modules in cyclic dependency chain is not known at the
> start of this function, so it is not printed anymore. The output
> when cyclic dependency is detected is changed as following:
>
> Old:
> depmod: ERROR: Found 8 modules in dependency cycles!
>
> New:
> depmod: ERROR: Modules found in dependency cycles!

I think it would be good to fix this problem, but retaining the behavior.

My first reaction to this is "how do I reproduce the issue?". This
number so far does tell us how many modules are involved in loops. So,
for example:

A -> B -> D -> A
B -> C -> B

This line should point to 4 modules. We don't know which module is
wrong. But there are 4 modules involved in the loops. D could be the
culprit.

The function should show what are the loops present (in "first found
order" - it could very well report as "B -> D -> A -> B" the line
above).

We have a testsuite to check if the loop detection is working in
depmod. See testsuite/test-depmod.c:depmod_detect_loop().
Would it be possible to add your use case there? If you tell me what
are your dependency chain and cycle I can take a look.

If I misunderstood the issue with the total number, then at least the
testsuite needs to be fixed, because right now it expects that number
to be in the output (see
testsuite/rootfs-pristine/test-depmod/detect-loop/correct.txt)


thanks
Lucas De Marchi
