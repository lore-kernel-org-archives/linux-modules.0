MIME-Version: 1.0
In-Reply-To: <54EB4C83.2000500@suse.cz>
References: <CAKi4VA+1krn9rdBWE69DkhNZSrxJoeYzyPgvn-SUk8U0=CxFkw@mail.gmail.com>
	<54EB4C83.2000500@suse.cz>
Date: Tue, 24 Feb 2015 22:02:55 -0300
Message-ID: <CAKi4VAJwvtLaF1GTw1dg__CXHGjwOwJqUS=g5B0rbPNp1w8dDg@mail.gmail.com>
Subject: Re: Differences between builtins and modules
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Michal Marek <mmarek@suse.cz>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Harish Jenny K N <harish_kandiga@mentor.com>,
	linux-modules <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Mon, Feb 23, 2015 at 12:51 PM, Michal Marek <mmarek@suse.cz> wrote:
> On 2015-02-23 15:30, Lucas De Marchi wrote:
>> This could be particularly bad if in a kernel version an option was
>> tristate and in a new version it changed to boolean. I'm not sure if
>> this is common to happen in kernel. Any code that did "modprobe
>> <module>" would start to fail.
>
> I think it's quite uncommon (*) and also the use case for loading
> builtin modules is not that common. I can think of:
> 1) building the initramfs, to determine which *.ko files need to be
>    copied to it. Since such tools are often updated for other reasons,
>    it's not a big deal.
> 2) Hardcoded module names in things like softdep -- hopefully not that
>    common either, plus the kernel-provided soft dependencies can be
>    fixed together with the change.
>
> Until not so long ago, the kernel would return EINVAL if passed a
> non-existent (renamed, removed) module option to init_module, yet there
> were no attempts at preserving the module options for compatibility reasons.
>
> (*) I now did a quick search:
> $ git log -p origin/master --no-merges -- '*/Kconfig*' | grep -C3 '^-
> *tristate' | grep '^+ *bool'
> +       bool "Intel P state control"
> +       bool "Intel microcode patch loading support"
> +       bool "AMD microcode patch loading support"
> +        bool "STI text console"
> +       bool "Enable DDC2 Support"
> +       bool "Enable Console Acceleration"
>
> That's only 6 cases in the whole git history. Maybe there are a few more
> hidden outside the three-line context as part of larger edits, but I'm
> sure more modules have been *removed* entirely from the kernel over this
> period.

thanks for looking in detail into this.

>
>
>> My questions are:
>> 1) should we put *all* the "modules" in the builtin index?
>
> You mean all *.o files that do not end up in some *.ko? That won't work,
> because unlike module names, the names of object files are not global.

I was actually meaning anything that can have a directory under
/sys/module/. I figure we can't easily know this.

> Plus, there was IIRC an idea to teach lsmod to print builtin modules --
> listing all *.o would make it rather useless.

This was one of my ideas... to traverse /sys/module and give more
information than we actually output right now, including builtin
modules. However, given the fact that builtin modules only have an
entry in /sys/module if they have params and now that I'm aware of the
race between the creation of the directory and the initstate file, I'm
giving up on this idea for now.

>> 2) should we actually check /sys/module/<modulename> to report a
>> module as builtin or just stop doing that and rely solely in the
>> index? Initially I'd like to do the opposite, but given the race in
>> deciding this I'm favoring the index.
>
> If the race between the creation of /sys/module/<modulename> and
> /sys/module/<modulename>/initstate is inevitable, then I'm afraid we
> have to rely on the index.

So my current plan is to rely solely on modules.builtin to output to
modprobe that a module is builtin. So things like "modprobe vt" will
start to fail saying there's no vt module. Any objections here?

-- 
Lucas De Marchi
