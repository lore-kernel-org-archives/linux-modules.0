Return-Path: <maillist-kmod@barfooze.de>
Message-ID: <521BE99B.8020206@barfooze.de>
Date: Tue, 27 Aug 2013 01:49:47 +0200
From: John Spencer <maillist-kmod@barfooze.de>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: John Spencer <maillist-kmod@barfooze.de>,
 linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 3/3] testsuite: fix usage of reserved names
References: <1377541250-10193-1-git-send-email-maillist-kmod@barfooze.de> <1377541250-10193-3-git-send-email-maillist-kmod@barfooze.de> <CAKi4VAL-hDyZvaUXoBMyYPjaA7hRhXNJt353HmvHF2kqkqHCEA@mail.gmail.com>
In-Reply-To: <CAKi4VAL-hDyZvaUXoBMyYPjaA7hRhXNJt353HmvHF2kqkqHCEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-modules.vger.kernel.org>

On 08/27/2013 01:07 AM, Lucas De Marchi wrote:
> On Mon, Aug 26, 2013 at 3:20 PM, John Spencer<maillist-kmod@barfooze.de>  wrote:
>> stdout and stderr are names reserved for the implementation
>> and musl uses them rightfully as macro - and the expansion
>> causes (of course) unexpected results.
>
> couldn't musl just do what glibc does here?

maybe, but often what glibc does is suboptimal or non-conforming, and 
relying on some  assumptions about how libc defines certain internal 
specifiers (possibly temporary) seems pretty fragile. even glibc may 
change its definition at some point to something that breaks kmod.

>
> <... define the types here ...>
> #define stdin stdin
> #define stdout stdout
> #define stderr stderr
>
> This would avoid patches like this to several projects.

i've ported about 500 packages to musl and this is first usage of stderr 
and stdout as variable names i've seen so far.

>
>>
>> renaming the struct members stdout to std_out and stderr
>> to std_err, to be 1) compliant 2) cause compilation to
>> succeed.
>
> uggh.. "out" and "err" otherwise. No need for the "std_" prefix.

right, that looks much nicer now. updated patch sent separately.

>
>
> Lucas De Marchi
>

thanks,
--JS
