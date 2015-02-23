MIME-Version: 1.0
Date: Mon, 23 Feb 2015 11:30:58 -0300
Message-ID: <CAKi4VA+1krn9rdBWE69DkhNZSrxJoeYzyPgvn-SUk8U0=CxFkw@mail.gmail.com>
Subject: Differences between builtins and modules
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Harish Jenny K N <harish_kandiga@mentor.com>,
	linux-modules <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	greg KH <gregkh@linuxfoundation.org>, Michal Marek <mmarek@suse.cz>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Changing the subject because this is unrelated to the patch to kmod. It was:
[PATCH] libkmod-module: Remove directory existence check for KMOD_MODULE_BUILTIN

CC'ing Michael Marek who created the modules.builtin file a while ago.

On Thu, Feb 19, 2015 at 12:25 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>> Rusty, thinking again if we fallback to "coming" instead of "builtin"
>> everything should be fine, no? Because the decision about builtin has
>> already been taken by looking at the modules.builtin index. If we
>> return "coming" here the second call to modprobe would call
>> init_module() again which would wait for the first one to complete (or
>> return EEXIST if it's already live) since we only shortcut the
>> init_module() call if the module is live or builtin
>
> It's weird that your code should care about this at all.  Ideally,
> userspace would see builtin modules as simply unremovable ones.
> Historically, it hasn't; it was only module parameters for builtins
> which caused us to expose built modules.

While integrating the patch above in kmod I noticed there are more differences.

/sys/module/<modname>/ may exist and modname not be present in
modules.builtin index. Looking in the kernel tree, this is because
Makefile.modbuiltin adds only those that can be tristate and not those
that can be only boolean. It may make sense because since a "module"
can never be compiled as a "module", there would be no reason to put
it in the index.

right now in kmod if we do this:

"modprobe --show-depends vt" it reports as "builtin" since there is a
directory in /sys/module

However if vt had no arguments, it would have been reported as "not found".

This could be particularly bad if in a kernel version an option was
tristate and in a new version it changed to boolean. I'm not sure if
this is common to happen in kernel. Any code that did "modprobe
<module>" would start to fail.

My questions are:
1) should we put *all* the "modules" in the builtin index?
2) should we actually check /sys/module/<modulename> to report a
module as builtin or just stop doing that and rely solely in the
index? Initially I'd like to do the opposite, but given the race in
deciding this I'm favoring the index.

thanks

-- 
Lucas De Marchi
