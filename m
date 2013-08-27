Return-Path: <maillist-kmod@barfooze.de>
Message-ID: <521BEFE3.4040801@barfooze.de>
Date: Tue, 27 Aug 2013 02:16:35 +0200
From: John Spencer <maillist-kmod@barfooze.de>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: John Spencer <maillist-kmod@barfooze.de>,
 linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 1/3] remove non-portable usage of strndupa
References: <1377541250-10193-1-git-send-email-maillist-kmod@barfooze.de> <CAKi4VAJJScguBb_mMaFwieTcq0VpRXLVpKaXKx0_4M+6DuU3Xg@mail.gmail.com>
In-Reply-To: <CAKi4VAJJScguBb_mMaFwieTcq0VpRXLVpKaXKx0_4M+6DuU3Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-modules.vger.kernel.org>

On 08/27/2013 01:46 AM, Lucas De Marchi wrote:
> On Mon, Aug 26, 2013 at 3:20 PM, John Spencer<maillist-kmod@barfooze.de>  wrote:
>> usage of strndupa is neither C99 nor POSIX,
>> so musl libc does not implement it.
>> it's a glibc invention, and a dangerous one since
>> usage of alloca() is considered bad practice.
>
> If the input is already sanitized and checked for length, this is
> isn't really dangerous. Particularly on recursive functions this also
> avoids growing the stack much more than needed.

yes, but it is a dangerous function which can and will be misused when 
it is provided.

>
>>
>> fixes build with musl libc.
>
> for me it seems more like an excuse to not implement it in musl.
> Particularly because there are other places in which we call alloca(),
> that you didn't complain. What does musl do there? If musl has
> alloca(), doing strndupa in missing.h would be doable.

i just fixed strndupa usage in eudev's mkdir_p function a week ago, and 
that was the first usage of that function i've seen so far in ~500 
packages i've ported. the function used by kmod seems to be derived from 
that one, since the context, name and everything else are nearly identical.

musl usually doesn't add exotic functions only used by a single package, 
even moreso when the function in question can compromise security.

since kmod is not a red-hat-GNU-linux specific package like systemd 
(which is even proud of nonportable code), but a linux-specific one, 
portability at least among available linux libcs should be a concern.

>
>>
>> Signed-off-by: John Spencer<maillist-kmod@barfooze.de>
>>
>> ---
>>   libkmod/libkmod-util.c |    8 ++++++--
>>   1 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/libkmod/libkmod-util.c b/libkmod/libkmod-util.c
>> index d686250..9615d0f 100644
>> --- a/libkmod/libkmod-util.c
>> +++ b/libkmod/libkmod-util.c
>> @@ -28,6 +28,7 @@
>>   #include<unistd.h>
>>   #include<errno.h>
>>   #include<string.h>
>> +#include<limits.h>
>>   #include<ctype.h>
>>
>>   #include "libkmod.h"
>> @@ -323,8 +324,11 @@ static inline int is_dir(const char *path)
>>   int mkdir_p(const char *path, int len, mode_t mode)
>>   {
>>          char *start, *end;
>> -
>> -       start = strndupa(path, len);
>> +       char buf[PATH_MAX+1];
>> +       snprintf(buf, sizeof buf, "%s", path);
>
> snprintf to dup a string? You already know the len. memcpy would be way simpler

this is to cover the potential case where len > strlen(path).
there's no documentation indicating this case cannot happen.
otherwise an out-of-bounds read would happen which could potentially 
cause a segfault. i suspect this function is not called million of times 
in an inner loop, so i opted for security over speed.

>
> Lucas De Marchi
>
