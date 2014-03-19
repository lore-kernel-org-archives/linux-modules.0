Return-Path: <anssi@mageia.org>
Message-ID: <532A0840.4080101@mageia.org>
Date: Wed, 19 Mar 2014 23:12:32 +0200
From: Anssi Hannula <anssi@mageia.org>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 1/2] depmod: do not allow partial matches with "search"
 directive
References: <1395185161-13687-1-git-send-email-anssi@mageia.org> <CAKi4VAL_4owLJvML7H9kXwnsD586P0iXtOnaVBTgJOM+aqeV=w@mail.gmail.com>
In-Reply-To: <CAKi4VAL_4owLJvML7H9kXwnsD586P0iXtOnaVBTgJOM+aqeV=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

19.03.2014 14:24, Lucas De Marchi kirjoitti:
> Hi Anssi,

Hi,

> On Tue, Mar 18, 2014 at 8:26 PM, Anssi Hannula <anssi@mageia.org> wrote:
>> Currently e.g. "search foo foobar built-in" will cause unpredictable
>> results if baz.ko is in both foo/ and foobar/, since "foo" in search may
>> match both of those directories and the preferred module therefore
>> depends on processing order.
>>
>> Fix the code to ensure that the match is performed on full pathname
>> components only.
>> ---
>>  tools/depmod.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/depmod.c b/tools/depmod.c
>> index 9f83ee8..328e578 100644
>> --- a/tools/depmod.c
>> +++ b/tools/depmod.c
>> @@ -1153,10 +1153,10 @@ static int depmod_module_is_higher_priority(const struct depmod *depmod, const s
>>                 DBG("search %s\n", se->builtin ? "built-in" : se->path);
>>                 if (se->builtin)
>>                         bprio = i;
>> -               else if (newlen >= se->len &&
>> +               else if (newlen > se->len && newpath[se->len] == '/' &&
>>                          memcmp(se->path, newpath, se->len) == 0)
>>                         newprio = i;
>> -               else if (oldlen >= se->len &&
>> +               else if (oldlen > se->len && oldpath[se->len] == '/' &&
>>                          memcmp(se->path, oldpath, se->len) == 0)
>>                         oldprio = i;
>>         }
>> --
> 
> 
> Both patches have been applied. Thanks a lot.
> 
> I added some test cases for depmod. Could you take a look if they are ok?

Well, just reversing the "search" directive does not ensure the bug is
caught by the test (and indeed it is not on my testing, i.e. tests still
pass after reverting my fix locally), since it does not alter the
initial order the modules are found.

To hit the bug, the code needs to hit the short-directory module first,
so that the short path is in "oldpath" and the long path is in "newpath".

-- 
Anssi Hannula
