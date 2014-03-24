Return-Path: <agrover@redhat.com>
Message-ID: <5330677A.5030005@redhat.com>
Date: Mon, 24 Mar 2014 10:12:26 -0700
From: Andy Grover <agrover@redhat.com>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        linux-modules <linux-modules@vger.kernel.org>,
        "W. Trevor King" <wking@tremily.us>
Subject: Re: [announce] python-kmod 0.9
References: <509C4944.3040907@redhat.com> <CAMOw1v6xtqE4yTt4CBJ0fZP_wan2EOuPD8052L6Y_RU4g62agg@mail.gmail.com> <528132C5.9000908@redhat.com> <CAKi4VALDxMP9YmomHhi5CPaTxG1cjdX1Ab+XoNE4=v=4p_HFaw@mail.gmail.com> <52B249D9.9020805@redhat.com> <CAKi4VAJe_ObudsdKJ5H=bWuA9Oa90FyxVBgWkJ-qOWmSQ6kApA@mail.gmail.com> <CAKi4VA+ft=gM+QeqEYmy1eqRK==SGvCvTurEszf+ZLTCN8b3Wg@mail.gmail.com>
In-Reply-To: <CAKi4VA+ft=gM+QeqEYmy1eqRK==SGvCvTurEszf+ZLTCN8b3Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-modules.vger.kernel.org>

On 03/24/2014 05:02 AM, Lucas De Marchi wrote:
> I've just pushed a branch named "python" which contains the python
> bindings. I did it a bit different than you:
>
>   - All the code from your repository was imported maintaining the
> history. I would like to keep it, so I did a merge of the final import
> (fast forward, but forced to contain a commit).
>   - Python bindings are built with autotools. This allows to easily
> express the dependency with libkmod... but I'm not sure this is ideal
> as opposed to having a target to explicitely calling setuptools.  Any
> opinion?
>
> Then I noticed the example given in the README file doesn't work.
> Neither by installing they original python-kmod package :-/
>
>      >>> import kmod
>      >>> km = kmod.Kmod()
>      Traceback (most recent call last):
>        File "<stdin>", line 1, in <module>
>      AttributeError: 'module' object has no attribute 'Kmod'
>      >>> dir(kmod)
>      ['__builtins__', '__doc__', '__file__', '__loader__', '__name__',
> '__package__', '__path__', '__version__', 'list', 'version']
>

The old 'python-kmod' pkg works for me:

[agrover@work ~/.../python/kmod ((fac4d09...))]$ ipython

In [1]: import kmod

In [2]: km = kmod.Kmod()

In [3]: sc = list(km.lookup("soundcore"))[0]

In [4]: sc.path
Out[4]: u'/lib/modules/3.13.6-200.fc20.x86_64/kernel/sound/soundcore.ko'

but when I try to use the new stuff:

[agrover@work ~/.../python/kmod ((fac4d09...))]$ 
PYTHONPATH="/home/agrover/git/kmod/libkmod/python/kmod/.libs" ipython

In [1]: import kmod
---------------------------------------------------------------------------
ImportError                               Traceback (most recent call last)
<ipython-input-1-ff824b795612> in <module>()
----> 1 import kmod

ImportError: dynamic module does not define init function (initkmod)

Is this what you're seeing as well?

Regards -- Andy
