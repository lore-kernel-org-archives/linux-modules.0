Return-Path: <labbott@redhat.com>
From: Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH 1/4] build: Properly check for Cython
To: Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Laura Abbott <labbott@fedoraproject.org>
References: <1442004956-3868-1-git-send-email-labbott@fedoraproject.org>
 <1442004956-3868-2-git-send-email-labbott@fedoraproject.org>
 <CAKi4VAKzR+=Gnk1EGwe6a_Rmg5vA1dgLvZ9mwVcBrzjd+Ag-Pg@mail.gmail.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-modules <linux-modules@vger.kernel.org>
Message-ID: <55FC4C03.4040101@redhat.com>
Date: Fri, 18 Sep 2015 10:38:11 -0700
MIME-Version: 1.0
In-Reply-To: <CAKi4VAKzR+=Gnk1EGwe6a_Rmg5vA1dgLvZ9mwVcBrzjd+Ag-Pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-modules.vger.kernel.org>

On 09/12/2015 11:27 AM, Lucas De Marchi wrote:
> On Fri, Sep 11, 2015 at 5:55 PM, Laura Abbott <labbott@fedoraproject.org> wrote:
>>
>> Cython is necessary to compile if --enable-python is used.
>> Currently, the configuration just sets Cython to ':' if
>> it isn't found. ':' is a valid command which results in
>> confusing build errors:
>>
>>    CCLD     libkmod/libkmod.la
>>    CCLD     libkmod/libkmod-internal.la
>> ar: `u' modifier ignored since `D' is the default (see `U')
>>    CYTHON  libkmod/python/kmod/kmod.c
>>    CC       libkmod/python/kmod/libkmod_python_kmod_kmod_la-kmod.lo
>> gcc: error: ./libkmod/python/kmod/kmod.c: No such file or directory
>> gcc: fatal error: no input files
>>
>> Explicitly check if cython is available and then error out
>> if it isn't found.
>> ---
>
> Since we distribute the  generated python files, cython is only needed
> on "building from git tree" cases, not for packages.
>
>
> Lucas De Marchi
>

I don't think I have a clear answer about whether or not you want to take
this patch even after Kay's response. If you don't want to add the
autoconf check I'll update the README and put a note under hacking to make
sure cython is installed if the intention is to ship the generated files.

Thanks,
Laura
