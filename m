MIME-Version: 1.0
In-Reply-To: <20180108213146.GA8638@cmdeoliv-mobl2.jf.intel.com>
References: <20180108162708.16662-1-lucas.demarchi@intel.com>
	<20180108212829.14484-1-lucas.demarchi@intel.com>
	<20180108213146.GA8638@cmdeoliv-mobl2.jf.intel.com>
Date: Mon, 8 Jan 2018 13:55:39 -0800
Message-ID: <CAKi4VAKDwn6Nq8TmaH+jvfFosH5R+u719yqSExibseMNv2bjSg@mail.gmail.com>
Subject: Re: [PATCH v2] testsuite: also wrap gettid in syscall()
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jan 8, 2018 at 1:31 PM, Caio Marcelo de Oliveira Filho
<caio.oliveira@intel.com> wrote:
> +1
>
> On Mon, Jan 08, 2018 at 01:28:29PM -0800, Lucas De Marchi wrote:
>> Not a perfect solution for overriding syscall(), but at least
>> it makes the testsuite to pass in a modified nsswitch.conf (one that has
>> a module which calls syscall() to get the thread id).
>> ---
>>
>> v2:
>>       - Check nextlib_syscall rather than nextlib to avoid races in
>>         multithreaded programs
>>       - Add error message in case we fail to get symbol
>>
>>  testsuite/init_module.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/testsuite/init_module.c b/testsuite/init_module.c
>> index 199186b..c70147e 100644
>> --- a/testsuite/init_module.c
>> +++ b/testsuite/init_module.c
>> @@ -355,6 +355,26 @@ TS_EXPORT long int syscall(long int __sysno, ...)
>>               return ret;
>>       }
>>
>> +     if (__sysno == __NR_gettid) {
>> +             static void *nextlib = NULL;
>> +             static long (*nextlib_syscall)(long number, ...);
>> +
>> +             if (nextlib_syscall == NULL) {
>> +#ifdef RTLD_NEXT
>> +                     nextlib = RTLD_NEXT;
>> +#else
>> +                     nextlib = dlopen("libc.so.6", RTLD_LAZY);
>> +#endif
>> +                     nextlib_syscall = dlsym(nextlib, "syscall");
>> +                     if (nextlib_syscall == NULL) {
>> +                             fprintf(stderr, "FIXME FIXME FIXME: libc is missing syscall symbol\n");

I added a call to dlerror() here and applied.

thanks for reviewing.

Lucas De Marchi
