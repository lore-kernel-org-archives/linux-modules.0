MIME-Version: 1.0
In-Reply-To: <874mqjuaky.fsf@rustcorp.com.au>
References: <1424177796-17923-1-git-send-email-harish_kandiga@mentor.com>
	<CAKi4VA+nJknEwkQfUWf0VbcEMzzz3uHwwNe8OuWQOi-K0sWxjQ@mail.gmail.com>
	<874mqjuaky.fsf@rustcorp.com.au>
Date: Wed, 18 Feb 2015 14:50:36 -0200
Message-ID: <CAKi4VAKpzUcakX+BY8dYE8Jx4BUOqy_-LZWH5gJWtwn3EdbE0g@mail.gmail.com>
Subject: Re: [PATCH] libkmod-module: Remove directory existence check for KMOD_MODULE_BUILTIN
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Harish Jenny K N <harish_kandiga@mentor.com>,
	linux-modules <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 18, 2015 at 2:07 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
>> On Tue, Feb 17, 2015 at 10:56 AM, Harish Jenny K N
>> <harish_kandiga@mentor.com> wrote:
>>> usecase: two sd cards are being mounted in parallel at same time on
>>> dual core. example modules which are getting loaded is nls_cp437.
>>> While one module is being loaded , it starts creating sysfs files.
>>> meanwhile on other core, modprobe might return saying the module
>>> is KMOD_MODULE_BUILTIN, which might result in not mounting sd card.
>>
>> an {f,}init_module() call should not return until the sysfs files are
>> created and if there is /sys/module/<module>/ there should be
>> /sys/module/<module>/initstate unless the module is builtin.
>>
>> Rusty, was there any changes in this area in the kernel recently?
>
> Not deliberately.
>
>> Or is the creation of /sys/module/<module> and
>> /sys/module/<module>/initstate not atomic?
>
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

Yeah, I just thought (an wanted that) the attributes were being
created first and then hooked up in the sysfs tree under
/sys/module/<modulename>. I.e. if the directory exists and there's no
initstate this is because it's a builtin module. I don't want to
wait/sleep on the file to appear because users of
kmod_module_get_initstate() may not tolerate this behavior.

Looking up at the old module-init-tools, it used an ugly loop with
usleep() before trying to read the file again :-/

Can we change kernel side guaranteeing the initstate file appears
together with the directory?

>
> So, the second init_module should be waiting.
>
> I tested this by putting a sleep in the nls_cp437 init, and watching
> what modprobe did.  It works correctly.
>
> You are checking initstate, and getting caught in the race:
>
> 783   14:33:14.170205 open("/sys/module/nls_cp437/initstate", O_RDONLY|O_LARGEFILE|O_CLOEXEC)
>
> You should probably check initstate *after* loading fails.  It's
> possible that it's unloaded in the meantime, but the race is pretty
> narrow and unloading is unusual.

This call may be called in other paths, not while loading a module.
Otherwise just removing the check like what this patch does would be
sufficient.

We don't check the initstate after loading fails because we rely on
the return code of init_module, i.e. errno==EEXISTS if the previous
call succeeded.


-- 
Lucas De Marchi
