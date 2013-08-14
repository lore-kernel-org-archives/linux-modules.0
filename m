MIME-Version: 1.0
In-Reply-To: <CAKi4VAKBYBUH+=yioR7B8W06ZxeA=Fs05GGhJFD6csys48neRQ@mail.gmail.com>
References: <20130813210228.989279359@goodmis.org>
	<CAKi4VALgK94oiv68x6XxEnwbYJcAhQDwgNoAT=KSGmuV01zR+g@mail.gmail.com>
	<20130813201702.5aeca54c@gandalf.local.home>
	<CAKi4VAKBYBUH+=yioR7B8W06ZxeA=Fs05GGhJFD6csys48neRQ@mail.gmail.com>
Date: Tue, 13 Aug 2013 22:08:52 -0300
Message-ID: <CAKi4VAKm2_7MibUS4+fwnSfeB7-AdBshnzFBx94NV-4VKjk1eA@mail.gmail.com>
Subject: Re: [PATCH 0/3] module: Allow parameters without arguments
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@linux-foundation.org>, linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Aug 13, 2013 at 10:00 PM, Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
> On Tue, Aug 13, 2013 at 9:17 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>> On Tue, 13 Aug 2013 20:34:58 -0300
>> Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:
>>
>>
>>> so in kcmdline we would have modulename.param instead of modulename.param=1?
>>>
>>> I guess we need to update kmod then, because currently we ignore and
>>> treat this case as a wrong token. From a quick look, allowing it in
>>> kmod would be as simple as removing a condition check.
>>>
>>> Lucas De Marchi
>>
>> Note, both will still work. And it didn't change much. Today, anything
>> that uses "module_param()" with bool type (a quick git grep shows 570
>> users), already do not require a value.
>>
>> Randomly looking at one... drivers/input/mouse/synaptics_i2c.c, you can
>> just do:
>>
>>  insmod synaptics_i2c.ko no_filter
>>
>> no need to add a "=1" to that.
>>
>> But anything else will still require a value. I just want to allow
>> other parameters that act like a boolean to not require one.
>
> true... but currently "modprobe synaptics_i2c" doesn't get the
> parameter correctly from kernel command line if it doesn't have a
> value. And I agree this not something that changed but rather a bug in
> kmod waiting to be fixed.

And it's fixed now with a proper test added.

thanks

Lucas De Marchi
