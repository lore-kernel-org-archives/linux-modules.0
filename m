Return-Path: <maillist-kmod@barfooze.de>
Message-ID: <521BEA45.9070502@barfooze.de>
Date: Tue, 27 Aug 2013 01:52:37 +0200
From: John Spencer <maillist-kmod@barfooze.de>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: John Spencer <maillist-kmod@barfooze.de>,
 linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 2/3] check if __GLIBC__ is defined before using _FILE_OFFSET_BITS
References: <1377541250-10193-1-git-send-email-maillist-kmod@barfooze.de> <1377541250-10193-2-git-send-email-maillist-kmod@barfooze.de> <CAKi4VALHoH3AYJff-AGNFKctrKX3vS8MFtLqos0ejv_pfaGjWQ@mail.gmail.com>
In-Reply-To: <CAKi4VALHoH3AYJff-AGNFKctrKX3vS8MFtLqos0ejv_pfaGjWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-modules.vger.kernel.org>

On 08/27/2013 01:18 AM, Lucas De Marchi wrote:
> On Mon, Aug 26, 2013 at 3:20 PM, John Spencer<maillist-kmod@barfooze.de>  wrote:
>> _FILE_OFFSET_BITS is a glibc internal macro.
>> musl provides 64bit off_t by default, but
>> defines stat64 etc as macros to make glibc-centric
>> programs happy. however the expansion causes
>> problems with the hack used here to work around
>> glibc's 32bit past...
>
> AFAIK this define comes from AC_SYS_LARGEFILE in autoconf and ends up
> in our config.h. Checking for the libc in source code is not much
> future proof and I'd like to avoid it.  If this is not the right
> define to pick, is there any other one?
>
> Maybe it would be better to do like this:
>
> #ifndef _FILE_OFFSET_BITS
> #ifndef stat64
> WRAP_2ARGS(int, -1, stat64, struct stat64*);
> #endif
> ...
>
> Because if it's a macro, there's no need to wrap the call.

Yes, that would work as well.

>
> Lucas De Marchi
>

Thanks,
--JS
