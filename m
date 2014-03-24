MIME-Version: 1.0
In-Reply-To: <CAKi4VAJe_ObudsdKJ5H=bWuA9Oa90FyxVBgWkJ-qOWmSQ6kApA@mail.gmail.com>
References: <509C4944.3040907@redhat.com>
	<CAMOw1v6xtqE4yTt4CBJ0fZP_wan2EOuPD8052L6Y_RU4g62agg@mail.gmail.com>
	<528132C5.9000908@redhat.com>
	<CAKi4VALDxMP9YmomHhi5CPaTxG1cjdX1Ab+XoNE4=v=4p_HFaw@mail.gmail.com>
	<52B249D9.9020805@redhat.com>
	<CAKi4VAJe_ObudsdKJ5H=bWuA9Oa90FyxVBgWkJ-qOWmSQ6kApA@mail.gmail.com>
Date: Mon, 24 Mar 2014 09:02:27 -0300
Message-ID: <CAKi4VA+ft=gM+QeqEYmy1eqRK==SGvCvTurEszf+ZLTCN8b3Wg@mail.gmail.com>
Subject: Re: [announce] python-kmod 0.9
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Andy Grover <agrover@redhat.com>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-modules <linux-modules@vger.kernel.org>, "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Andy,

On Sun, Dec 22, 2013 at 7:52 PM, Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
> Hi Andy,
>
> On Wed, Dec 18, 2013 at 11:20 PM, Andy Grover <agrover@redhat.com> wrote:
>> On 12/18/2013 11:38 AM, Lucas De Marchi wrote:
>>>>>
>>>>> Hey. I think I replied once that this could be better left off in its
>>>>> own repository. However I'm reconsidering this now... if you are still
>>>>> interested in merging into kmod, I think it would be good.
>>>>
>>>>
>>>>
>>>> You bet. I'll start work on a patch.
>>>
>>>
>>> Ping.
>>
>>
>> Hi Lucas,
>>
>> Sorry for the delay. Here's what I have so far:
>>
>> https://github.com/agrover/kmod.git
>>
>> Copied source in, modified configure.ac. But I'm pretty weak on automake.
>> Basically the Python bindings need "python setup.py build" and "python
>> setup.py install" for the relevant make targets, but that still needs to be
>> hooked up :-/
>>
>> Would you or some other kind soul that knows automake be willing to advise,
>> or even fix this up the rest of the way?
>
> Sure  I'll do the missing glue to the build system.

I've just pushed a branch named "python" which contains the python
bindings. I did it a bit different than you:

 - All the code from your repository was imported maintaining the
history. I would like to keep it, so I did a merge of the final import
(fast forward, but forced to contain a commit).
 - Python bindings are built with autotools. This allows to easily
express the dependency with libkmod... but I'm not sure this is ideal
as opposed to having a target to explicitely calling setuptools.  Any
opinion?

Then I noticed the example given in the README file doesn't work.
Neither by installing they original python-kmod package :-/

    >>> import kmod
    >>> km = kmod.Kmod()
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    AttributeError: 'module' object has no attribute 'Kmod'
    >>> dir(kmod)
    ['__builtins__', '__doc__', '__file__', '__loader__', '__name__',
'__package__', '__path__', '__version__', 'list', 'version']


--
Lucas De Marchi
