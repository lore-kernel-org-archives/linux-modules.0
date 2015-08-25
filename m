MIME-Version: 1.0
In-Reply-To: <CAKi4VA+48ccfqxQuPsvpGN41OML2BQGVBmNUzgsQ-CBmvYgaDw@mail.gmail.com>
References: <CANULwrQY+_Bv1r9V2FsVP=+ODSDVLsDicD+sBwcJYrZz60vCFQ@mail.gmail.com>
	<CAKi4VA+48ccfqxQuPsvpGN41OML2BQGVBmNUzgsQ-CBmvYgaDw@mail.gmail.com>
Date: Tue, 25 Aug 2015 12:23:11 -0300
Message-ID: <CAKi4VALhoYra2bd-JCUECup4Z87e5kf_01tVF5m_A+Mdj5bmQA@mail.gmail.com>
Subject: Re: fnmatch for modprobe.d "options" commands?
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Ari Entlich <atrigent@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Ari,

Just a ping to know if you are going to send a patch.

Lucas De Marchi

On Fri, Aug 7, 2015 at 7:21 AM, Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
> Hi Ari,
>
> On Fri, Aug 7, 2015 at 6:31 AM, Ari Entlich <atrigent@gmail.com> wrote:
>> I am trying to do some debugging of a sound issue, and in the process
>> I am having to use the "dynamic debug" feature of the kernel. I would
>> like to enable all debug messages for all of the sound modules on my
>> system. Once all of the modules are loaded, I can do this:
>>
>> echo 'module snd* +p' > /sys/kernel/debug/dynamic_debug/control
>>
>> However, by the time I do this, most of the messages that would have
>> happened have already happened. There is a module argument "dyndbg"
>> which can be used to set dynamic debug flags for a module, which will
>> obviously take effect immediately once the module has loaded. However,
>> in order to do the same thing that I am doing with the control file
>> above, I'd have to add options commands to my modprobe.d files for
>> each sound module on my system, or at least for each one which I know
>> will be loaded. Ideally, I'd like to be able to do this:
>>
>> options snd* dyndbg="+p"
>
> makes a lot of sense.
>
>>
>> From my reading of the kmod source code, it looks like enabling this
>> sort of thing would be a very trivial patch to the
>> kmod_module_get_options function in libkmod-module.c. Furthermore, it
>
> yep, mostly an oneliner.
>
>> looks like other modprobe.d commands (install, softdep, and remove)
>> are already using fnmatch for the module name. Would it be possible to
>> add the options command to that list?
>>
>> Whether this change is made or not, it might be a good idea to update
>> the documentation to reflect the fact that fnmatch is being used for
>> some of the commands.
>
> Could you send the patches to add fnmatch to options and update the man pages?
> I see no reason why we couldn't do like you said.
>
> thanks
>
> --
> Lucas De Marchi



-- 
Lucas De Marchi
