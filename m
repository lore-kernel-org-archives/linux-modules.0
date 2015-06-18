MIME-Version: 1.0
In-Reply-To: <CANq1E4R_4jG1BN03SYuQjjHOQa+6_hozmV+ZayfZPRYs5exUMQ@mail.gmail.com>
References: <1434231912-20614-1-git-send-email-lucas.de.marchi@gmail.com>
	<CANq1E4R_4jG1BN03SYuQjjHOQa+6_hozmV+ZayfZPRYs5exUMQ@mail.gmail.com>
Date: Thu, 18 Jun 2015 01:36:30 -0300
Message-ID: <CAKi4VAKst7_R0JZkXjziiOtgT4n6RRCSedyxZ9Fb3Z4bi7=K0g@mail.gmail.com>
Subject: Re: [PATCH] libkmod-module: fix return code in error path
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, Daniel Mack <daniel@zonque.org>,
	David Herrmann <dh.herrmann@googlemail.com>, Lennart Poettering <lennart@poettering.net>,
	Kay Sievers <kay@vrfy.org>, Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Sun, Jun 14, 2015 at 7:55 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> On Sat, Jun 13, 2015 at 11:45 PM, Lucas De Marchi
> <lucas.de.marchi@gmail.com> wrote:
>> From: Lucas De Marchi <lucas.demarchi@intel.com>
>>
>> ENOSYS is the wrong errno to return when we don't find a module in
>> kmod_module_insert_module(). Why is it there in the first place?  This
>> goes back to kmod v1 when we couldn't load modules by names, but we
>> should give a path instead.
>>
>> 708624a ("ELF: initial support for modinfo and strip of modversions and
>> vermagic.") changed that so we do a lazy-search by the module path in
>> this function. Later  f304afe ("Change error message to reflect
>> reality") fixed the log message but the return coded remained the same.
>> ---
>>
>> CC'ing here people from systemd who were bitten by this bug in kmod:
>> https://github.com/systemd/systemd/pull/166
>>
>> I'm not sure about changing the return code since it was returning ENOSYS since
>> v1 :-/.  However maybe the best thing to do is just treat it as a bug and let
>> the patch to be backported by distros that want it.  Thoughts?
>
> Looks all good to me. Treating this as a bugfix is probably the best
> thing to do. I'll revert the systemd patch once this is pushed.

Applied.  The next release will take a while but I do recommend all
distros to cherry-pick this patch.


thanks.

-- 
Lucas De Marchi
