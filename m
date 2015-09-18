Return-Path: <labbott@redhat.com>
Subject: Re: [PATCH 4/4] depmod: Add error message for bad version
To: Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Laura Abbott <labbott@fedoraproject.org>
References: <1442004956-3868-1-git-send-email-labbott@fedoraproject.org>
 <1442004956-3868-5-git-send-email-labbott@fedoraproject.org>
 <CAKi4VAJiG3con6bcK5OkaBuFaeh19eyfUszE34Nt5e_Z2dYs5g@mail.gmail.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-modules <linux-modules@vger.kernel.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <55FC5841.1080501@redhat.com>
Date: Fri, 18 Sep 2015 11:30:25 -0700
MIME-Version: 1.0
In-Reply-To: <CAKi4VAJiG3con6bcK5OkaBuFaeh19eyfUszE34Nt5e_Z2dYs5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-modules.vger.kernel.org>

On 09/12/2015 12:00 PM, Lucas De Marchi wrote:
> On Fri, Sep 11, 2015 at 5:55 PM, Laura Abbott <labbott@fedoraproject.org> wrote:
>>
>> Currently, if a value that doesn't match a kernel version
>> ("%u.%u") is passed in, depmod silently falls back to
>> using uname. Make it clear to the user that this is happening
>> by giving a message to the user.
>> ---
>
> Actually I think we should not fallback. If the user passed a wrong
> number, fallbacking to the currently running kernel is plain wrong.
> This was done mostly due to compatibility with module-init-tools but I
> prefer breaking it rather than silently (or verbose as per your patch)
> doing the wrong thing.
>

Sounds fine to me if you are okay with the breakage.

Thanks,
Laura
