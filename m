Return-Path: <Harish_Kandiga@mentor.com>
Message-ID: <54E42CBA.5010007@mentor.com>
Date: Wed, 18 Feb 2015 11:40:02 +0530
From: Harish Jenny Kandiga Nagaraj <harish_kandiga@mentor.com>
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>, Lucas De Marchi
	<lucas.de.marchi@gmail.com>
CC: linux-modules <linux-modules@vger.kernel.org>, lkml
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libkmod-module: Remove directory existence check for
 KMOD_MODULE_BUILTIN
References: <1424177796-17923-1-git-send-email-harish_kandiga@mentor.com> <CAKi4VA+nJknEwkQfUWf0VbcEMzzz3uHwwNe8OuWQOi-K0sWxjQ@mail.gmail.com> <874mqjuaky.fsf@rustcorp.com.au>
In-Reply-To: <874mqjuaky.fsf@rustcorp.com.au>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-modules.vger.kernel.org>


On Wednesday 18 February 2015 09:37 AM, Rusty Russell wrote:
> Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
>> On Tue, Feb 17, 2015 at 10:56 AM, Harish Jenny K N
>> <harish_kandiga@mentor.com> wrote:
>>> usecase: two sd cards are being mounted in parallel at same time on
>>> dual core. example modules which are getting loaded is nls_cp437.
>>> While one module is being loaded , it starts creating sysfs files.
>>> meanwhile on other core, modprobe might return saying the module
>>> is KMOD_MODULE_BUILTIN, which might result in not mounting sd card.
>> an {f,}init_module() call should not return until the sysfs files are
>> created and if there is /sys/module/<module>/ there should be
>> /sys/module/<module>/initstate unless the module is builtin.
>>
>> Rusty, was there any changes in this area in the kernel recently?
> Not deliberately.
>
>> Or is the creation of /sys/module/<module> and
>> /sys/module/<module>/initstate not atomic?
> No, it's not atomic :(  That makes it unreliable (it seemed like a good
> idea in 2006 I guess).
>
> Here's what happens from a kernel side:
>
> 1) Module is marked UNFORMED.
> 2) Check there's no module by same name already.  If there is, and it's
>    UNFORMED or COMING, we wait.
> 3) module is marked COMING
> 4) module parses arguments.
> 5) sysfs directory and attributes are created.
> 6) module's init is called.
> 7) module is marked LIVE.
These are the operations handled in kernel after syscall/init_module is called. Here is the list of operations which happen before point number 1)
0a) __request_module/try_then_request_module gets called from kernel.
0b) call_modprobe gets called which calls usermode modprobe to see if module is loaded.
0c) syscall init_module gets called from modprobe.
> So, the second init_module should be waiting.  
>
> I tested this by putting a sleep in the nls_cp437 init, and watching
> what modprobe did.  It works correctly.
Problem here is second init_module is not yet called. if it gets called , it is handled properly. Adding a sleep in nls_cp437 is handled properly.
We need to add sleep in module_add_modinfo_attrs ( module.c ) while creating sysfs files(sysfs_create_file) in order to reproduce the issue I mentioned.
>
> You are checking initstate, and getting caught in the race:
>
> 783   14:33:14.170205 open("/sys/module/nls_cp437/initstate", O_RDONLY|O_LARGEFILE|O_CLOEXEC)
>
> You should probably check initstate *after* loading fails.  It's
> possible that it's unloaded in the meantime, but the race is pretty
> narrow and unloading is unusual.
Did not get the point of checking initstate after loading fails. However we need to handle even unusual rare cases as well.
>
> Cheers,
> Rusty.
