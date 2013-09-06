Return-Path: <Randy.MacLeod@windriver.com>
Message-ID: <5229D6DA.1080007@windriver.com>
Date: Fri, 6 Sep 2013 09:21:30 -0400
From: Randy MacLeod <randy.macleod@windriver.com>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] kmod-native: Add back-up implementation of be32toh().
References: <1378447141-11568-1-git-send-email-Randy.MacLeod@windriver.com> <1378447141-11568-2-git-send-email-Randy.MacLeod@windriver.com> <CAKi4VA+DShUeusWBndRg=Uvqv5ayxdM7W4tp=RzS_3_-D1NVWQ@mail.gmail.com>
In-Reply-To: <CAKi4VA+DShUeusWBndRg=Uvqv5ayxdM7W4tp=RzS_3_-D1NVWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-modules.vger.kernel.org>

On 13-09-06 08:55 AM, Lucas De Marchi wrote:
> Hi Randy,
>
>
> On Fri, Sep 6, 2013 at 2:59 AM, Randy MacLeod
> <Randy.MacLeod@windriver.com> wrote:
>>
>> Older hosts may not have the be32toh function defined. Check for this and
>> fall back to checking the endianness and calling bswap_32 directly if needed.
>> This works on both old and new hosts.
>
> I'm fine with adding fallback code, even if I'm surprised with it.
> However see comments below.
>
>
>>
>> Signed-off-by: Randy MacLeod <Randy.MacLeod@windriver.com>
>
> We don't use s-o-b.

ok.
>
>
>> ---
>>   configure.ac                |  1 +
>>   libkmod/libkmod-signature.c | 14 +++++++++++++-
>>   2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 40e54cf..de2ee49 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -45,6 +45,7 @@ PKG_PROG_PKG_CONFIG
>>   AC_CHECK_FUNCS_ONCE(__xstat)
>>   AC_CHECK_FUNCS_ONCE([__secure_getenv secure_getenv])
>>   AC_CHECK_FUNCS_ONCE([finit_module])
>> +AC_CHECK_FUNCS_ONCE([be32toh])
>
> I guess you could use AC_CHECK_DECLS_ONCE so the check below is
> simpler, since you don't need to care if it's a macro or a function.
>
>
>>
>>   # dietlibc doesn't have st.st_mtim struct member
>>   AC_CHECK_MEMBERS([struct stat.st_mtim], [], [], [#include <sys/stat.h>])
>> diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
>> index 6237ab7..791d092 100644
>> --- a/libkmod/libkmod-signature.c
>> +++ b/libkmod/libkmod-signature.c
>> @@ -18,7 +18,7 @@
>>    * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>>    */
>>
>> -#include <endian.h>
>> +#include <byteswap.h>
>>   #include <stdint.h>
>>   #include <stdlib.h>
>>   #include <string.h>
>> @@ -26,6 +26,18 @@
>>
>>   #include "libkmod-internal.h"
>>
>> +/* be32toh is usually a macro definend in <endian.h>, but it might be
>> + * a function in some system so check both, and if neither is defined
>> + * then define be32toh (for RHEL 5).
>> + */
>
> by using AC_CHECK_DECLS_ONCE this comment would be gone
>
>> +#if !defined(HAVE_BE32TOH) && !defined(be32toh)
>
> as well as the double test.

Will do, simpler is better.

>
>
>> +#if __BYTE_ORDER == __LITTLE_ENDIAN
>> +#define be32toh(x) __bswap_32 (x)
>
> Is there any reason to include byteswap.h and then end up using the
> __bswap* variant?

No, it was late and I wanted to know if you guys would
take a patch to make kmod build on old hosts so I
sent this a little early.

>
>> +#else
>> +#define be32toh(x) (x)
>> +#endif
>> +#endif
>> +
>
> Please add this check to the missing.h header. We may want to use this
> function in more places. Then in this file you just need to include
> this file.

Ok.
Thanks for the review.
v2 coming later today.

// Randy
>
> Thanks,
> Lucas De Marchi
>


-- 
# Randy MacLeod. SMTS, Linux, Wind River
Direct: 613.963.1350
