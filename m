Return-Path: <david.henningsson@canonical.com>
Message-ID: <519F5064.8000908@canonical.com>
Date: Fri, 24 May 2013 13:35:00 +0200
From: David Henningsson <david.henningsson@canonical.com>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: Wang Xingchao <xingchao.wang@intel.com>, Takashi Iwai <tiwai@suse.de>,
 linux-modules <linux-modules@vger.kernel.org>
Subject: Re: modprobe: Cannot load blacklisted module by symbol
References: <519E5423.3020902@canonical.com> <CAKi4VAKZ-QzUgpohYjp4nSwfT4g3XSm-dt4Z67g3ADePw5K5_Q@mail.gmail.com>
In-Reply-To: <CAKi4VAKZ-QzUgpohYjp4nSwfT4g3XSm-dt4Z67g3ADePw5K5_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-modules.vger.kernel.org>

On 05/23/2013 08:13 PM, Lucas De Marchi wrote:
> Hi David,
>
> On Thu, May 23, 2013 at 2:38 PM, David Henningsson
> <david.henningsson@canonical.com> wrote:
>> Hi Lucas,
>>
>> I'm not sure if you're the right person to contact, if not, feel free to
>> redirect me.
>
> Yes, but make sure to CC the mailing list (done now).

Ok, thanks. I tried to find references to a mailing list in the code 
(README etc) but didn't find any.

>> While debugging and testing some other code, we were trying to use the
>> kernel symbol_request() call. This does not work if the module to be loaded
>> is blacklisted, whereas module_request() for the same module succeeds.
>> E g, when "i915" is blacklisted, loading "i915" still succeeds, but not
>> "symbol:i915_gpu_busy".
>>
>> I think I've traced this down to this commit [1]. Is this expected
>> behaviour? We certainly did not expect it.
>
> Yes, that's because blacklist doesn't apply to the module names,
> unless "-b" is given (which I would expect to be the normal behavior,
> but this inherited from module-init-tools).
>
> Since symbol:i915_gpu_busy is treated as an alias, the blacklist
> applies for this one though.
>
> Why do you want to load i915 by symbol if it's blacklisted?

The example is a bit contrived, but it was to test our module loading 
code: without blacklisting, i915 would always load before the module 
that was supposed to load it (snd-hda-intel), and so blacklisting was 
our way of making sure snd-hda-intel was loaded first, so we could test 
that the module loading worked.

What bothers me is the inconsistency though: either blacklisting 
applies, and then it should apply to both names, aliases, symbols etc.
Or blacklisting does not apply, and then it should not apply to either 
names, aliases nor symbols.

Is this inconsistency also inherited from module-init-tools?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
