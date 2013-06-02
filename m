MIME-Version: 1.0
In-Reply-To: <519F5064.8000908@canonical.com>
References: <519E5423.3020902@canonical.com>
	<CAKi4VAKZ-QzUgpohYjp4nSwfT4g3XSm-dt4Z67g3ADePw5K5_Q@mail.gmail.com>
	<519F5064.8000908@canonical.com>
Date: Sun, 2 Jun 2013 14:13:53 -0300
Message-ID: <CAKi4VA+A9a-dDC64b6kYy387eXb5UettgQoe-ooW_rHenRYrRw@mail.gmail.com>
Subject: Re: modprobe: Cannot load blacklisted module by symbol
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: David Henningsson <david.henningsson@canonical.com>
Cc: Wang Xingchao <xingchao.wang@intel.com>, Takashi Iwai <tiwai@suse.de>,
	linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Fri, May 24, 2013 at 8:35 AM, David Henningsson
<david.henningsson@canonical.com> wrote:
> On 05/23/2013 08:13 PM, Lucas De Marchi wrote:
>>
>> Hi David,
>>
>> On Thu, May 23, 2013 at 2:38 PM, David Henningsson
>> <david.henningsson@canonical.com> wrote:
>>>
>>> Hi Lucas,
>>>
>>> I'm not sure if you're the right person to contact, if not, feel free to
>>> redirect me.
>>
>>
>> Yes, but make sure to CC the mailing list (done now).
>
>
> Ok, thanks. I tried to find references to a mailing list in the code (README
> etc) but didn't find any.
>
>
>>> While debugging and testing some other code, we were trying to use the
>>> kernel symbol_request() call. This does not work if the module to be
>>> loaded
>>> is blacklisted, whereas module_request() for the same module succeeds.
>>> E g, when "i915" is blacklisted, loading "i915" still succeeds, but not
>>> "symbol:i915_gpu_busy".
>>>
>>> I think I've traced this down to this commit [1]. Is this expected
>>> behaviour? We certainly did not expect it.
>>
>>
>> Yes, that's because blacklist doesn't apply to the module names,
>> unless "-b" is given (which I would expect to be the normal behavior,
>> but this inherited from module-init-tools).
>>
>> Since symbol:i915_gpu_busy is treated as an alias, the blacklist
>> applies for this one though.
>>
>> Why do you want to load i915 by symbol if it's blacklisted?
>
>
> The example is a bit contrived, but it was to test our module loading code:
> without blacklisting, i915 would always load before the module that was
> supposed to load it (snd-hda-intel), and so blacklisting was our way of
> making sure snd-hda-intel was loaded first, so we could test that the module
> loading worked.
>
> What bothers me is the inconsistency though: either blacklisting applies,
> and then it should apply to both names, aliases, symbols etc.

This is the case when calling modprobe with -b option. For example,
udev uses it.

> Or blacklisting does not apply, and then it should not apply to either
> names, aliases nor symbols.

I agree.

>
> Is this inconsistency also inherited from module-init-tools?

Yes, it's like this only because modprobe from module-init-tools had
this behavior. I don't think we can change this without breaking
others.

What we could do is to create a "more modern" tool and put the options
and behaviors we are expecting now. This is what I am doing for "kmod
load" but this depends on the effort to allow the kernel to call
another tool instead of modprobe [1]. However in this front we also
have incompatibilities with previous behavior :-(

Lucas De Marchi

[1] https://lkml.org/lkml/2013/5/10/3
