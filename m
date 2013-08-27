MIME-Version: 1.0
In-Reply-To: <521BEFE3.4040801@barfooze.de>
References: <1377541250-10193-1-git-send-email-maillist-kmod@barfooze.de>
	<CAKi4VAJJScguBb_mMaFwieTcq0VpRXLVpKaXKx0_4M+6DuU3Xg@mail.gmail.com>
	<521BEFE3.4040801@barfooze.de>
Date: Tue, 27 Aug 2013 00:35:48 -0300
Message-ID: <CAKi4VAK-kVjumah76bOD9iWN+4fU+ekAGaRG67SjMJoTbu0ZFg@mail.gmail.com>
Subject: Re: [PATCH 1/3] remove non-portable usage of strndupa
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: John Spencer <maillist-kmod@barfooze.de>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Mon, Aug 26, 2013 at 9:16 PM, John Spencer <maillist-kmod@barfooze.de> wrote:
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
>
> yes, but it is a dangerous function which can and will be misused when it is
> provided.

If I wanted a language that doesn't allow me to shoot myself on the
foot, I'd rather be writing pascal,  basic or some other new
<name-your-preferred-script-language>

>
>
>>
>>>
>>> fixes build with musl libc.
>>
>>
>> for me it seems more like an excuse to not implement it in musl.
>> Particularly because there are other places in which we call alloca(),
>> that you didn't complain. What does musl do there? If musl has
>> alloca(), doing strndupa in missing.h would be doable.
>
>
> i just fixed strndupa usage in eudev's mkdir_p function a week ago, and that
> was the first usage of that function i've seen so far in ~500 packages i've
> ported. the function used by kmod seems to be derived from that one, since
> the context, name and everything else are nearly identical.

apart from the name, I don't think it's derived

>
> musl usually doesn't add exotic functions only used by a single package,

if you keep removing it from the packages, you may decrease the number
of users.... but counting now you just said you have 2. And I can name
some others, too.

> even moreso when the function in question can compromise security.
>
> since kmod is not a red-hat-GNU-linux specific package like systemd (which
> is even proud of nonportable code), but a linux-specific one, portability at
> least among available linux libcs should be a concern.

yes, I care. I do care other packages to be high quality too instead
of just throwing into kmod an insane amount of ifdefs and friends to
support everything. In the past this worked very well and allowed us
to move forward faster and link to bionic, dielibc, klibc and musl. I
appreciate patches adding support to other libc, but they have to be
reasonable.


>
>
>>
>>>
>>> Signed-off-by: John Spencer<maillist-kmod@barfooze.de>
>>>
>>> ---
>>>   libkmod/libkmod-util.c |    8 ++++++--
>>>   1 files changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/libkmod/libkmod-util.c b/libkmod/libkmod-util.c
>>> index d686250..9615d0f 100644
>>> --- a/libkmod/libkmod-util.c
>>> +++ b/libkmod/libkmod-util.c
>>> @@ -28,6 +28,7 @@
>>>   #include<unistd.h>
>>>   #include<errno.h>
>>>   #include<string.h>
>>> +#include<limits.h>
>>>   #include<ctype.h>
>>>
>>>   #include "libkmod.h"
>>> @@ -323,8 +324,11 @@ static inline int is_dir(const char *path)
>>>   int mkdir_p(const char *path, int len, mode_t mode)
>>>   {
>>>          char *start, *end;
>>> -
>>> -       start = strndupa(path, len);
>>> +       char buf[PATH_MAX+1];
>>> +       snprintf(buf, sizeof buf, "%s", path);
>>
>>
>> snprintf to dup a string? You already know the len. memcpy would be way
>> simpler
>
>
> this is to cover the potential case where len > strlen(path).
> there's no documentation indicating this case cannot happen.

there are only 2 callers of this function. Copying the entire string
here is actually the wrong thing to do.

Back to the subject, musl does provide alloca(), which is the
"dangerous" function according to you. If you or musl devs don't want
to provide strndupa(), the patch to be accepted in kmod is the one
that checks if strndupa() is available and add it to missing.h
otherwise. Why missing.h? To remember me to check it some time in
future to see if I can already remove some stuff.


Lucas De Marchi
