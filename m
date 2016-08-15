MIME-Version: 1.0
In-Reply-To: <CAKi4VALH8cJEXnYsMVA99+JF13HAyX0AKd0n8qvkfX0sC5Ehig@mail.gmail.com>
References: <1470854233-19810-1-git-send-email-lucas.de.marchi@gmail.com>
	<1470854233-19810-3-git-send-email-lucas.de.marchi@gmail.com>
	<CAKi4VALH8cJEXnYsMVA99+JF13HAyX0AKd0n8qvkfX0sC5Ehig@mail.gmail.com>
Date: Mon, 15 Aug 2016 10:28:08 -0300
Message-ID: <CAKi4VAKn5nNmeeSEK4RSArkT_T9iai9uRcsoxt5J-qEfFbeCQw@mail.gmail.com>
Subject: Re: [PATCH 3/3] depmod: fix string overflow
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules <linux-modules@vger.kernel.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Sat, Aug 13, 2016 at 5:31 PM, Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
> On Wed, Aug 10, 2016 at 3:37 PM, Lucas De Marchi
> <lucas.de.marchi@gmail.com> wrote:
>> From: Lucas De Marchi <lucas.demarchi@intel.com>
>>
>> Use scratchbuf to fix issue with strcpy that may overflow the buffer we
>> declared in the stack.
>> ---
>>  tools/depmod.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/depmod.c b/tools/depmod.c
>> index a2e07c1..be9e001 100644
>> --- a/tools/depmod.c
>> +++ b/tools/depmod.c
>> @@ -35,6 +35,7 @@
>>  #include <shared/hash.h>
>>  #include <shared/macro.h>
>>  #include <shared/util.h>
>> +#include <shared/scratchbuf.h>
>>
>>  #include <libkmod/libkmod.h>
>>
>> @@ -1920,6 +1921,7 @@ static int output_symbols_bin(struct depmod *depmod, FILE *out)
>>  {
>>         struct index_node *idx;
>>         char alias[1024];
>> +       struct scratchbuf salias;
>>         size_t baselen = sizeof("symbol:") - 1;
>>         struct hash_iter iter;
>>         const void *v;
>> @@ -1932,16 +1934,21 @@ static int output_symbols_bin(struct depmod *depmod, FILE *out)
>>                 return -ENOMEM;
>>
>>         memcpy(alias, "symbol:", baselen);
>> +       scratchbuf_init(&salias, alias, sizeof(alias));
>> +
>>         hash_iter_init(depmod->symbols, &iter);
>>
>>         while (hash_iter_next(&iter, NULL, &v)) {
>>                 int duplicate;
>>                 const struct symbol *sym = v;
>> +               size_t len;
>>
>>                 if (sym->owner == NULL)
>>                         continue;
>>
>> -               strcpy(alias + baselen, sym->name);
>> +               len = strlen(sym->name);
>> +               scratchbuf_alloc(&salias, baselen + len + 1);
>
> err... the whole point of scratchbuf was to be able to increase the
> buffer size and check for errors. Here I forgot to check them.

I fixed this and pushed.


Lucas De Marchi
