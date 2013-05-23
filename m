MIME-Version: 1.0
In-Reply-To: <519E5423.3020902@canonical.com>
References: <519E5423.3020902@canonical.com>
Date: Thu, 23 May 2013 15:13:16 -0300
Message-ID: <CAKi4VAKZ-QzUgpohYjp4nSwfT4g3XSm-dt4Z67g3ADePw5K5_Q@mail.gmail.com>
Subject: Re: modprobe: Cannot load blacklisted module by symbol
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: David Henningsson <david.henningsson@canonical.com>
Cc: Wang Xingchao <xingchao.wang@intel.com>, Takashi Iwai <tiwai@suse.de>,
	linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi David,

On Thu, May 23, 2013 at 2:38 PM, David Henningsson
<david.henningsson@canonical.com> wrote:
> Hi Lucas,
>
> I'm not sure if you're the right person to contact, if not, feel free to
> redirect me.

Yes, but make sure to CC the mailing list (done now).

>
> While debugging and testing some other code, we were trying to use the
> kernel symbol_request() call. This does not work if the module to be loaded
> is blacklisted, whereas module_request() for the same module succeeds.
> E g, when "i915" is blacklisted, loading "i915" still succeeds, but not
> "symbol:i915_gpu_busy".
>
> I think I've traced this down to this commit [1]. Is this expected
> behaviour? We certainly did not expect it.

Yes, that's because blacklist doesn't apply to the module names,
unless "-b" is given (which I would expect to be the normal behavior,
but this inherited from module-init-tools).

Since symbol:i915_gpu_busy is treated as an alias, the blacklist
applies for this one though.

Why do you want to load i915 by symbol if it's blacklisted?

Lucas De Marchi
