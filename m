MIME-Version: 1.0
In-Reply-To: <521C6BB9.6000900@barfooze.de>
References: <1377541250-10193-1-git-send-email-maillist-kmod@barfooze.de>
	<CAKi4VAJJScguBb_mMaFwieTcq0VpRXLVpKaXKx0_4M+6DuU3Xg@mail.gmail.com>
	<521BEFE3.4040801@barfooze.de>
	<CAKi4VAK-kVjumah76bOD9iWN+4fU+ekAGaRG67SjMJoTbu0ZFg@mail.gmail.com>
	<521C6BB9.6000900@barfooze.de>
Date: Thu, 29 Aug 2013 00:49:27 -0300
Message-ID: <CAKi4VAKmn2cHteiem4woGqx_2uL2hK5YhdekGnnw+jScdPP74A@mail.gmail.com>
Subject: Re: [PATCH 1/3] remove non-portable usage of strndupa
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: John Spencer <maillist-kmod@barfooze.de>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi John,

On Tue, Aug 27, 2013 at 6:04 AM, John Spencer <maillist-kmod@barfooze.de> wrote:
> On 08/27/2013 05:35 AM, Lucas De Marchi wrote:
>>
>> On Mon, Aug 26, 2013 at 9:16 PM, John Spencer<maillist-kmod@barfooze.de>
>> wrote:
>>>
>>> On 08/27/2013 01:46 AM, Lucas De Marchi wrote:
>>>>
>>>>
>>>> On Mon, Aug 26, 2013 at 3:20 PM, John Spencer<maillist-kmod@barfooze.de>
>>>> wrote:
>>>>>
>>>>>
>>>>> usage of strndupa is neither C99 nor POSIX,
>>>>> so musl libc does not implement it.
>>>>> it's a glibc invention, and a dangerous one since
>>>>> usage of alloca() is considered bad practice.
>>>>
>>>>
>>>>
>>>> If the input is already sanitized and checked for length, this is
>>>> isn't really dangerous. Particularly on recursive functions this also
>>>> avoids growing the stack much more than needed.
>>>
>>>
>>>
>>> yes, but it is a dangerous function which can and will be misused when it
>>> is
>>> provided.
>>
>>
>> If I wanted a language that doesn't allow me to shoot myself on the
>> foot, I'd rather be writing pascal,  basic or some other new
>> <name-your-preferred-script-language>
>>
>
> yes, but there's a reason alloca is not in the C standard and gets() got
> deprecated.

the thing is... a standard is a live thing. New things are added.
Other things are removed. gets() was removed because there's no way to
use it correctly. New things are being added because people need and
because we are getting innovative things being done.

If we were to limit ourselves only to things that were already in a
standard, the standard would never need to be updated and how boring
would be life.


>
>
>>>
>>>
>>>>
>>>>>
>>>>> fixes build with musl libc.
>>>>
>>>>
>>>>
>>>> for me it seems more like an excuse to not implement it in musl.
>>>> Particularly because there are other places in which we call alloca(),
>>>> that you didn't complain. What does musl do there? If musl has
>>>> alloca(), doing strndupa in missing.h would be doable.
>>>
>>>
>>>
>>> i just fixed strndupa usage in eudev's mkdir_p function a week ago, and
>>> that
>>> was the first usage of that function i've seen so far in ~500 packages
>>> i've
>>> ported. the function used by kmod seems to be derived from that one,
>>> since
>>> the context, name and everything else are nearly identical.
>>
>>
>> apart from the name, I don't think it's derived
>>
>>>
>>> musl usually doesn't add exotic functions only used by a single package,
>>
>>
>> if you keep removing it from the packages, you may decrease the number
>> of users.... but counting now you just said you have 2. And I can name
>> some others, too.
>
>
> no, i have one, since eudev merged my patch without turning a hair.
> they didn't fight around just to keep their single strndupa call in some
> legacy systemd derived code.
> the others you can name are most likely udev and systemd, which i don't
> intend to ever compile, same as pulseaudio and other poettering crapware.


some projects are different and reviewers are picker about the changes
merged. If you are aiming to make several projects to build correctly
with musl, the best thing you do is to adapt yourself to the different
projects.

Strong words and bashing other projects won't help your cause.

>
>
>>
>>> even moreso when the function in question can compromise security.
>>>
>>> since kmod is not a red-hat-GNU-linux specific package like systemd
>>> (which
>>> is even proud of nonportable code), but a linux-specific one, portability
>>> at
>>> least among available linux libcs should be a concern.
>>
>>
>> yes, I care. I do care other packages to be high quality too instead
>> of just throwing into kmod an insane amount of ifdefs and friends to
>> support everything. In the past this worked very well and allowed us
>> to move forward faster and link to bionic, dielibc, klibc and musl. I
>> appreciate patches adding support to other libc, but they have to be
>> reasonable.
>>
>
> high quality, high portability, no ifdefs - this is exactly what the
> proposed patch here does.
>
> what exactly do you find non-reasonable regarding this patch ?

Because we/I like extensions and other projects could be improved by
not getting stuck on old things. GCC was improved because of that.
LLVM was improved because of that. Several libc's were improved
because of that.

I don't really mind if that particular piece of code is changed to a
fixed array. That function could be refactored to even not duplicate
each part of the path. However what I really want is people to *stop*
and *think* if other projects like musl could be improved instead of
just changing that piece of code.

For example, you didn't properly respond this particular question: if
musl already provides alloca(), why can't it provide str[n]dupa()? It
could be trivially done by a macro or static always inline function.

>
> kmod used to build just fine in the past, you're the one who broke it last
> month by throwing the mkdir_p code into the source tree.
> and the function has seen quite some refactoring already, using strdupa,
> then strndupa. who guarantees me that if i add strndupa (assuming rich would
> accept and merge my patch) to musl, you won't change your code back to use
> strdupa in the next release ?

None. And I can't guarantee you next release will be bug free neither.
 I don't use musl myself as I don't use plenty of other libc's or
architectures in which kmod runs on. This is one reason why we
appreciate bug reports and patches from others


>
>
>>
>>>
>>>
>>>>
>>>>>
>>>>> Signed-off-by: John Spencer<maillist-kmod@barfooze.de>
>>>>>
>>>>> ---
>>>>>    libkmod/libkmod-util.c |    8 ++++++--
>>>>>    1 files changed, 6 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/libkmod/libkmod-util.c b/libkmod/libkmod-util.c
>>>>> index d686250..9615d0f 100644
>>>>> --- a/libkmod/libkmod-util.c
>>>>> +++ b/libkmod/libkmod-util.c
>>>>> @@ -28,6 +28,7 @@
>>>>>    #include<unistd.h>
>>>>>    #include<errno.h>
>>>>>    #include<string.h>
>>>>> +#include<limits.h>
>>>>>    #include<ctype.h>
>>>>>
>>>>>    #include "libkmod.h"
>>>>> @@ -323,8 +324,11 @@ static inline int is_dir(const char *path)
>>>>>    int mkdir_p(const char *path, int len, mode_t mode)
>>>>>    {
>>>>>           char *start, *end;
>>>>> -
>>>>> -       start = strndupa(path, len);
>>>>> +       char buf[PATH_MAX+1];
>>>>> +       snprintf(buf, sizeof buf, "%s", path);
>>>>
>>>>
>>>>
>>>> snprintf to dup a string? You already know the len. memcpy would be way
>>>> simpler
>>>
>>>
>>>
>>> this is to cover the potential case where len>  strlen(path).
>>> there's no documentation indicating this case cannot happen.
>>
>>
>> there are only 2 callers of this function. Copying the entire string
>> here is actually the wrong thing to do.
>>
>> Back to the subject, musl does provide alloca(), which is the
>> "dangerous" function according to you. If you or musl devs don't want
>> to provide strndupa(), the patch to be accepted in kmod is the one
>> that checks if strndupa() is available and add it to missing.h
>> otherwise. Why missing.h? To remember me to check it some time in
>> future to see if I can already remove some stuff.
>
>
> actually i didn't even ask yet if we can ask strndupa, because it was first
> encountered a week back in said eudev code, and my patch got immediately
> merged.
> when i see non-portable code, i fix the nonportable code, not libc, and send
> a patch to upstream in the hope that it gets merged. if they don't merge it,
> ok - yet another fork caused by maintainer stubborness.

Again, getting personal is not helping your cause.

> how do you like "kemod" as a name for the fork ?

And neither threatening like this

>
> yes, alloca() was added as it is widely used - you can't even build gcc
> without it. the same can't be said about strndupa which is only used in one
> mkdir code snippet copy-pasted from udev into a handful of projects.

you should grep more code.

>
> besides, afaik strndupa can't even be implemented as a function, since it
> would return a pointer to automatic storage that's already out of scope (at
> least not without using asm).

See reply above.

>
> that said, i am not sending you a macro replacement for a missing strndupa
> and doing a full stop now. if you care about the musl userbase, merge this
> patch, otherwise ignore it and live with a fork.
>
>>
>>
>> Lucas De Marchi
>>
>
> P.S. i don't even use kmod myself (contrary to what poettering's twin
> sievers believes), i ported this quickly for usage in dragora linux which is

Enough of that. Please refrain to insult people on this mailing list.


Lucas De Marchi
