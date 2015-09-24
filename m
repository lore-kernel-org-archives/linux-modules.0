MIME-Version: 1.0
In-Reply-To: <55FC4C03.4040101@redhat.com>
References: <1442004956-3868-1-git-send-email-labbott@fedoraproject.org>
	<1442004956-3868-2-git-send-email-labbott@fedoraproject.org>
	<CAKi4VAKzR+=Gnk1EGwe6a_Rmg5vA1dgLvZ9mwVcBrzjd+Ag-Pg@mail.gmail.com>
	<55FC4C03.4040101@redhat.com>
Date: Wed, 23 Sep 2015 22:11:03 -0300
Message-ID: <CAKi4VA++sfnC=yS-6q40jyoCOdOBTz+atFkBiia+NtuDYP6sYg@mail.gmail.com>
Subject: Re: [PATCH 1/4] build: Properly check for Cython
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Laura Abbott <labbott@redhat.com>
Cc: Laura Abbott <labbott@fedoraproject.org>, Lucas De Marchi <lucas.demarchi@intel.com>,
	linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Fri, Sep 18, 2015 at 2:38 PM, Laura Abbott <labbott@redhat.com> wrote:
> On 09/12/2015 11:27 AM, Lucas De Marchi wrote:
>>
>> On Fri, Sep 11, 2015 at 5:55 PM, Laura Abbott <labbott@fedoraproject.org>
>> wrote:
>>>
>>>
>>> Cython is necessary to compile if --enable-python is used.
>>> Currently, the configuration just sets Cython to ':' if
>>> it isn't found. ':' is a valid command which results in
>>> confusing build errors:
>>>
>>>    CCLD     libkmod/libkmod.la
>>>    CCLD     libkmod/libkmod-internal.la
>>> ar: `u' modifier ignored since `D' is the default (see `U')
>>>    CYTHON  libkmod/python/kmod/kmod.c
>>>    CC       libkmod/python/kmod/libkmod_python_kmod_kmod_la-kmod.lo
>>> gcc: error: ./libkmod/python/kmod/kmod.c: No such file or directory
>>> gcc: fatal error: no input files
>>>
>>> Explicitly check if cython is available and then error out
>>> if it isn't found.
>>> ---
>>
>>
>> Since we distribute the  generated python files, cython is only needed
>> on "building from git tree" cases, not for packages.
>>
>>
>> Lucas De Marchi
>>
>
> I don't think I have a clear answer about whether or not you want to take
> this patch even after Kay's response. If you don't want to add the
> autoconf check I'll update the README and put a note under hacking to make
> sure cython is installed if the intention is to ship the generated files.

Either update the README or remove everything from the build system
that makes the dependencies different for building from git and
building from package. Also make sure we don't ship prebuilt stuff
anymore.  I'll accept any of those approaches.

thanks

Lucas De Marchi
