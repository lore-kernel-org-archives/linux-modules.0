Return-Path: <kay@vrfy.org>
MIME-Version: 1.0
In-Reply-To: <521BEFE3.4040801@barfooze.de>
References: <1377541250-10193-1-git-send-email-maillist-kmod@barfooze.de>
 <CAKi4VAJJScguBb_mMaFwieTcq0VpRXLVpKaXKx0_4M+6DuU3Xg@mail.gmail.com> <521BEFE3.4040801@barfooze.de>
From: Kay Sievers <kay@vrfy.org>
Date: Tue, 27 Aug 2013 02:58:18 +0200
Message-ID: <CAPXgP10d18QfqsUi-o5jAHgD=BreoFFNH7m7F-3rUOqvw9-WPw@mail.gmail.com>
Subject: Re: [PATCH 1/3] remove non-portable usage of strndupa
To: John Spencer <maillist-kmod@barfooze.de>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Aug 27, 2013 at 2:16 AM, John Spencer <maillist-kmod@barfooze.de> wrote:
> On 08/27/2013 01:46 AM, Lucas De Marchi wrote:
>>
>> On Mon, Aug 26, 2013 at 3:20 PM, John Spencer<maillist-kmod@barfooze.de>
>> wrote:
>>>
>>> usage of strndupa is neither C99 nor POSIX,
>>> so musl libc does not implement it.
>>> it's a glibc invention, and a dangerous one since
>>> usage of alloca() is considered bad practice.
>>
>>
>> If the input is already sanitized and checked for length, this is
>> isn't really dangerous. Particularly on recursive functions this also
>> avoids growing the stack much more than needed.
>
> yes, but it is a dangerous function which can and will be misused when it is
> provided.

Dangerous? Misused? That is just pure nonsense.

> musl usually doesn't add exotic functions only used by a single package,
> even moreso when the function in question can compromise security.

So, this exotic libc can't be used for kmod as it is. Fine. :)

> since kmod is not a red-hat-GNU-linux specific package like systemd (which
> is even proud of nonportable code), but a linux-specific one, portability at
> least among available linux libcs should be a concern.

Just a hint: I would try to be less confrontational, if you like stuff
to be changed in a way that matters only to you.

Kay
