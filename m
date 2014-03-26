MIME-Version: 1.0
In-Reply-To: <53333970.8060403@redhat.com>
References: <509C4944.3040907@redhat.com>
	<CAMOw1v6xtqE4yTt4CBJ0fZP_wan2EOuPD8052L6Y_RU4g62agg@mail.gmail.com>
	<528132C5.9000908@redhat.com>
	<CAKi4VALDxMP9YmomHhi5CPaTxG1cjdX1Ab+XoNE4=v=4p_HFaw@mail.gmail.com>
	<52B249D9.9020805@redhat.com>
	<CAKi4VAJe_ObudsdKJ5H=bWuA9Oa90FyxVBgWkJ-qOWmSQ6kApA@mail.gmail.com>
	<CAKi4VA+ft=gM+QeqEYmy1eqRK==SGvCvTurEszf+ZLTCN8b3Wg@mail.gmail.com>
	<5330677A.5030005@redhat.com>
	<20140326174508.GA15805@intel.com>
	<53333970.8060403@redhat.com>
Date: Wed, 26 Mar 2014 17:49:12 -0300
Message-ID: <CAKi4VALM+7T59L9ZPsJq5Mhu7Qz0FWGHo_XpJ=HD9D_WORtFPA@mail.gmail.com>
Subject: Re: [announce] python-kmod 0.9
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Andy Grover <agrover@redhat.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, linux-modules <linux-modules@vger.kernel.org>,
	"W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Mar 26, 2014 at 5:32 PM, Andy Grover <agrover@redhat.com> wrote:
> On 03/26/2014 10:45 AM, Lucas De Marchi wrote:
>>
>> On Mon, Mar 24, 2014 at 10:12:26AM -0700, Andy Grover wrote:
>>>
>>> On 03/24/2014 05:02 AM, Lucas De Marchi wrote:
>>>>
>>>> I've just pushed a branch named "python" which contains the python
>>>> bindings. I did it a bit different than you:
>>>>
>>>>   - All the code from your repository was imported maintaining the
>>>> history. I would like to keep it, so I did a merge of the final import
>>>> (fast forward, but forced to contain a commit).
>>>>   - Python bindings are built with autotools. This allows to easily
>>>> express the dependency with libkmod... but I'm not sure this is ideal
>>>> as opposed to having a target to explicitely calling setuptools.  Any
>>>> opinion?
>>>>
>>>> Then I noticed the example given in the README file doesn't work.
>>>> Neither by installing they original python-kmod package :-/
>>>>
>>>>      >>> import kmod
>>>>      >>> km = kmod.Kmod()
>>>>      Traceback (most recent call last):
>>>>        File "<stdin>", line 1, in <module>
>>>>      AttributeError: 'module' object has no attribute 'Kmod'
>>>>      >>> dir(kmod)
>>>>      ['__builtins__', '__doc__', '__file__', '__loader__', '__name__',
>>>> '__package__', '__path__', '__version__', 'list', 'version']
>>>>
>>>
>>> The old 'python-kmod' pkg works for me:
>>>
>>> [agrover@work ~/.../python/kmod ((fac4d09...))]$ ipython
>>>
>>> In [1]: import kmod
>>>
>>> In [2]: km = kmod.Kmod()
>>>
>>> In [3]: sc = list(km.lookup("soundcore"))[0]
>>>
>>> In [4]: sc.path
>>> Out[4]: u'/lib/modules/3.13.6-200.fc20.x86_64/kernel/sound/soundcore.ko'
>>>
>>> but when I try to use the new stuff:
>>>
>>> [agrover@work ~/.../python/kmod ((fac4d09...))]$
>>> PYTHONPATH="/home/agrover/git/kmod/libkmod/python/kmod/.libs" ipython
>>>
>>> In [1]: import kmod
>>>
>>> ---------------------------------------------------------------------------
>>> ImportError                               Traceback (most recent call
>>> last)
>>> <ipython-input-1-ff824b795612> in <module>()
>>> ----> 1 import kmod
>>>
>>> ImportError: dynamic module does not define init function (initkmod)
>>>
>>> Is this what you're seeing as well?
>>
>>
>>
>> humn... indeed. The error was obfuscated for me because in the
>> __init__.py you catch the exception and make it pass silently.
>>
>> In the build system I was inheriting the CFLAGS from the library and
>> unfortunately PyMODINIT_FUNC doesn't include the visibility attribute.
>> Since we use -fvisibility=hidden by default, this was breaking the
>> module.
>>
>> It's working now, though I don't like to let it as -fvisibility=default.
>>
>> I just pushed the python branch again. Could you ack on it?
>
>
> I'm still getting this error.
>
> [agrover@work ~/git/kmod (python)]$
> PYTHONPATH="/home/agrover/git/kmod/libkmod/python/kmod/.libs" python
> Python 2.7.5 (default, Feb 19 2014, 13:47:28)
> [GCC 4.8.2 20131212 (Red Hat 4.8.2-7)] on linux2
> Type "help", "copyright", "credits" or "license" for more information.
>>>> import kmod
>
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
>   File "list.pxd", line 21, in init kmod.kmod
> (libkmod/python/kmod/kmod.c:3831)
> ImportError: No module named list
>
> I'm sorry I'm not being more help.. maybe we could get W. Trevor King or
> another Cython contributor to help us out here? I played around with it a
> bit and changing "kmod.list" to "list" on the line reporting an error in
> kmod.c seemed to help, and then repeating for additional errors, but kmod.c
> is a generated file so that's not the actual solution.

Humn... yes. If I set PYTHONPATH as opposed to installing I get this
error. I'm not sure what's happening.

-- 
Lucas De Marchi
