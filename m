MIME-Version: 1.0
In-Reply-To: <CAKi4VAJ3H90PLNYSdL-VueF9CQD01P+w0DrdOCt06_xCJZv7Xw@mail.gmail.com>
References: <1394022461-1657-1-git-send-email-mmarek@suse.cz>
	<CAKi4VAJ3H90PLNYSdL-VueF9CQD01P+w0DrdOCt06_xCJZv7Xw@mail.gmail.com>
Date: Thu, 6 Mar 2014 11:03:51 -0300
Message-ID: <CAKi4VALsNKSABf6Umi1VP-27zGDCEcHjogPwiq3b4AJMcLs3ww@mail.gmail.com>
Subject: Re: [PATCH] libkmod-config: Only match dot before '=' in /proc/cmdline
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Michal Marek <mmarek@suse.cz>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Wed, Mar 5, 2014 at 12:30 PM, Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
> Hi,
>
> On Wed, Mar 5, 2014 at 9:27 AM, Michal Marek <mmarek@suse.cz> wrote:
>> Otherwise, we also parse strings like
>>
>>   BOOT_IMAGE=/boot/vmlinuz-3.12.12-57.g5f654cf-default
>>
>> In practice, this is not a problem, because there is no module named
>> BOOT_IMAGE=/boot/vmlinuz-3. It just disturbs in modprobe -c output.
>> ---
>
> Applied.
>
> Since you already touched the testsuite in previous patches, could you
> add tests for these, too?

So... I went ahead and added some tests that I'm sending to the ML.
could you take a look?

thanks
Lucas De Marchi
