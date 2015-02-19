Return-Path: <Harish_Kandiga@mentor.com>
Message-ID: <54E5795C.5050804@mentor.com>
Date: Thu, 19 Feb 2015 11:19:16 +0530
From: Harish Jenny Kandiga Nagaraj <harish_kandiga@mentor.com>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.de.marchi@gmail.com>, Rusty Russell
	<rusty@rustcorp.com.au>
CC: linux-modules <linux-modules@vger.kernel.org>, lkml
	<linux-kernel@vger.kernel.org>, greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] libkmod-module: Remove directory existence check for
 KMOD_MODULE_BUILTIN
References: <1424177796-17923-1-git-send-email-harish_kandiga@mentor.com> <CAKi4VA+nJknEwkQfUWf0VbcEMzzz3uHwwNe8OuWQOi-K0sWxjQ@mail.gmail.com> <874mqjuaky.fsf@rustcorp.com.au> <CAKi4VAKpzUcakX+BY8dYE8Jx4BUOqy_-LZWH5gJWtwn3EdbE0g@mail.gmail.com> <87vbiysv1v.fsf@rustcorp.com.au> <CAKi4VAKc_zrPptt2ZKT_Jj8bLdL1bt0emhtEuodV2WKkas9ZOw@mail.gmail.com>
In-Reply-To: <CAKi4VAKc_zrPptt2ZKT_Jj8bLdL1bt0emhtEuodV2WKkas9ZOw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-modules.vger.kernel.org>


On Thursday 19 February 2015 06:49 AM, Lucas De Marchi wrote:
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
>> Greg?  The core problem is that kmod looks for
>> /sys/module/<name>/initstate; if it's not there, it assumes a builtin
>> module.
> Just to make it clear:
>
> We try to open /sys/module/<name>/initstate. If it fails we stat
> /sys/module/<name> checking if it exists and is a directory. If it
> does then we assume the module is builtin.
>
>> However, this is racy when a module is being inserted.  Is there a way
>> to create this sysfs file and dir atomically?
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
>
> what do you think?
>
>
> Harrish, in your patch if you just change the "return
> KMOD_MODULE_BUILTIN;" to "return KMOD_MODULE_COMING;" does it work?
>


Yes. Returning KMOD_MODULE_COMING instead of KMOD_MODULE_BUILTIN  works. The built-in modules are handled by looking at the modules.builtin index file. Is there any chance of returning KMOD_MODULE_COMING for builti-in modules? If it does not have any impact, then the fix should be fine.

Do I need to send a separate patch ?
