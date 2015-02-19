MIME-Version: 1.0
In-Reply-To: <87k2zeskm9.fsf@rustcorp.com.au>
References: <1424177796-17923-1-git-send-email-harish_kandiga@mentor.com>
	<CAKi4VA+nJknEwkQfUWf0VbcEMzzz3uHwwNe8OuWQOi-K0sWxjQ@mail.gmail.com>
	<874mqjuaky.fsf@rustcorp.com.au>
	<CAKi4VAKpzUcakX+BY8dYE8Jx4BUOqy_-LZWH5gJWtwn3EdbE0g@mail.gmail.com>
	<87vbiysv1v.fsf@rustcorp.com.au>
	<CAKi4VAKc_zrPptt2ZKT_Jj8bLdL1bt0emhtEuodV2WKkas9ZOw@mail.gmail.com>
	<87k2zeskm9.fsf@rustcorp.com.au>
Date: Thu, 19 Feb 2015 01:34:03 -0200
Message-ID: <CAKi4VAKBN0XrH5iUsR0orHOendbgE9dX=2Ye+013_C=o0JvB5Q@mail.gmail.com>
Subject: Re: [PATCH] libkmod-module: Remove directory existence check for KMOD_MODULE_BUILTIN
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Harish Jenny K N <harish_kandiga@mentor.com>,
	linux-modules <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Thu, Feb 19, 2015 at 12:25 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
>> On Wed, Feb 18, 2015 at 8:40 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>>> Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
>>>> On Wed, Feb 18, 2015 at 2:07 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>>>> Yeah, I just thought (an wanted that) the attributes were being
>>>> created first and then hooked up in the sysfs tree under
>>>> /sys/module/<modulename>. I.e. if the directory exists and there's no
>>>> initstate this is because it's a builtin module. I don't want to
>>>> wait/sleep on the file to appear because users of
>>>> kmod_module_get_initstate() may not tolerate this behavior.
>>>>
>>>> Looking up at the old module-init-tools, it used an ugly loop with
>>>> usleep() before trying to read the file again :-/
>>>>
>>>> Can we change kernel side guaranteeing the initstate file appears
>>>> together with the directory?
>>>
>>> Greg?  The core problem is that kmod looks for
>>> /sys/module/<name>/initstate; if it's not there, it assumes a builtin
>>> module.
>>
>> Just to make it clear:
>>
>> We try to open /sys/module/<name>/initstate. If it fails we stat
>> /sys/module/<name> checking if it exists and is a directory. If it
>> does then we assume the module is builtin.
>>
>>> However, this is racy when a module is being inserted.  Is there a way
>>> to create this sysfs file and dir atomically?
>>
>> Greg, the question is still valid since it'd be nice to have this
>> guarantee and be able to correctly reply the state with whatever is in
>> initstate file, but...
>>
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

yeah... ideally all modules would have their entries in /sys/module

> If we returned EEXIST for builtin modules, would you have to do the
> initstate check at all?

In this case there would be some behavior changes wrt blacklist,
softdeps and builtin modules. Currently if the module is live/builtin
we just return success (oh, unless --first-time is passed :-/).
Otherwise we apply blacklists, softdeps and dependencies. With this we
could reach a scenario in which we fail to load a builtin module which
is very weird.

And... the race for "lsmod" would still exist. Instead of thinking
about a race between 2 modprobe calls, think about a race between 1
modprobe and 1 lsmod. What do I answer for the module that is loading?
IMO the "coming" alternative is the one that makes sense (and would
also fix the 2 modprobes)

-- 
Lucas De Marchi
