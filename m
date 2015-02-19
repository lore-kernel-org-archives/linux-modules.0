Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Harish Jenny K N <harish_kandiga@mentor.com>, linux-modules <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] libkmod-module: Remove directory existence check for KMOD_MODULE_BUILTIN
In-Reply-To: <CAKi4VAKc_zrPptt2ZKT_Jj8bLdL1bt0emhtEuodV2WKkas9ZOw@mail.gmail.com>
References: <1424177796-17923-1-git-send-email-harish_kandiga@mentor.com> <CAKi4VA+nJknEwkQfUWf0VbcEMzzz3uHwwNe8OuWQOi-K0sWxjQ@mail.gmail.com> <874mqjuaky.fsf@rustcorp.com.au> <CAKi4VAKpzUcakX+BY8dYE8Jx4BUOqy_-LZWH5gJWtwn3EdbE0g@mail.gmail.com> <87vbiysv1v.fsf@rustcorp.com.au> <CAKi4VAKc_zrPptt2ZKT_Jj8bLdL1bt0emhtEuodV2WKkas9ZOw@mail.gmail.com>
Date: Thu, 19 Feb 2015 12:55:34 +1030
Message-ID: <87k2zeskm9.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
> On Wed, Feb 18, 2015 at 8:40 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>> Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
>>> On Wed, Feb 18, 2015 at 2:07 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>>> Yeah, I just thought (an wanted that) the attributes were being
>>> created first and then hooked up in the sysfs tree under
>>> /sys/module/<modulename>. I.e. if the directory exists and there's no
>>> initstate this is because it's a builtin module. I don't want to
>>> wait/sleep on the file to appear because users of
>>> kmod_module_get_initstate() may not tolerate this behavior.
>>>
>>> Looking up at the old module-init-tools, it used an ugly loop with
>>> usleep() before trying to read the file again :-/
>>>
>>> Can we change kernel side guaranteeing the initstate file appears
>>> together with the directory?
>>
>> Greg?  The core problem is that kmod looks for
>> /sys/module/<name>/initstate; if it's not there, it assumes a builtin
>> module.
>
> Just to make it clear:
>
> We try to open /sys/module/<name>/initstate. If it fails we stat
> /sys/module/<name> checking if it exists and is a directory. If it
> does then we assume the module is builtin.
>
>> However, this is racy when a module is being inserted.  Is there a way
>> to create this sysfs file and dir atomically?
>
> Greg, the question is still valid since it'd be nice to have this
> guarantee and be able to correctly reply the state with whatever is in
> initstate file, but...
>
> Rusty, thinking again if we fallback to "coming" instead of "builtin"
> everything should be fine, no? Because the decision about builtin has
> already been taken by looking at the modules.builtin index. If we
> return "coming" here the second call to modprobe would call
> init_module() again which would wait for the first one to complete (or
> return EEXIST if it's already live) since we only shortcut the
> init_module() call if the module is live or builtin

It's weird that your code should care about this at all.  Ideally,
userspace would see builtin modules as simply unremovable ones.
Historically, it hasn't; it was only module parameters for builtins
which caused us to expose built modules.

If we returned EEXIST for builtin modules, would you have to do the
initstate check at all?

Thanks,
Rusty.
