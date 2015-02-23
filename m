Return-Path: <mmarek@suse.cz>
Message-ID: <54EB4C83.2000500@suse.cz>
Date: Mon, 23 Feb 2015 16:51:31 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.de.marchi@gmail.com>,
 Rusty Russell <rusty@rustcorp.com.au>
CC: Harish Jenny K N <harish_kandiga@mentor.com>,
 linux-modules <linux-modules@vger.kernel.org>,
 lkml <linux-kernel@vger.kernel.org>,
 greg KH <gregkh@linuxfoundation.org>
Subject: Re: Differences between builtins and modules
References: <CAKi4VA+1krn9rdBWE69DkhNZSrxJoeYzyPgvn-SUk8U0=CxFkw@mail.gmail.com>
In-Reply-To: <CAKi4VA+1krn9rdBWE69DkhNZSrxJoeYzyPgvn-SUk8U0=CxFkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-modules.vger.kernel.org>

On 2015-02-23 15:30, Lucas De Marchi wrote:
> This could be particularly bad if in a kernel version an option was
> tristate and in a new version it changed to boolean. I'm not sure if
> this is common to happen in kernel. Any code that did "modprobe
> <module>" would start to fail.

I think it's quite uncommon (*) and also the use case for loading
builtin modules is not that common. I can think of:
1) building the initramfs, to determine which *.ko files need to be
   copied to it. Since such tools are often updated for other reasons,
   it's not a big deal.
2) Hardcoded module names in things like softdep -- hopefully not that
   common either, plus the kernel-provided soft dependencies can be
   fixed together with the change.

Until not so long ago, the kernel would return EINVAL if passed a
non-existent (renamed, removed) module option to init_module, yet there
were no attempts at preserving the module options for compatibility reasons.

(*) I now did a quick search:
$ git log -p origin/master --no-merges -- '*/Kconfig*' | grep -C3 '^-
*tristate' | grep '^+ *bool'
+       bool "Intel P state control"
+       bool "Intel microcode patch loading support"
+       bool "AMD microcode patch loading support"
+        bool "STI text console"
+       bool "Enable DDC2 Support"
+       bool "Enable Console Acceleration"

That's only 6 cases in the whole git history. Maybe there are a few more
hidden outside the three-line context as part of larger edits, but I'm
sure more modules have been *removed* entirely from the kernel over this
period.


> My questions are:
> 1) should we put *all* the "modules" in the builtin index?

You mean all *.o files that do not end up in some *.ko? That won't work,
because unlike module names, the names of object files are not global.
Plus, there was IIRC an idea to teach lsmod to print builtin modules --
listing all *.o would make it rather useless.


> 2) should we actually check /sys/module/<modulename> to report a
> module as builtin or just stop doing that and rely solely in the
> index? Initially I'd like to do the opposite, but given the race in
> deciding this I'm favoring the index.

If the race between the creation of /sys/module/<modulename> and
/sys/module/<modulename>/initstate is inevitable, then I'm afraid we
have to rely on the index.

Michal
