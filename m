MIME-Version: 1.0
In-Reply-To: <52B249D9.9020805@redhat.com>
References: <509C4944.3040907@redhat.com>
	<CAMOw1v6xtqE4yTt4CBJ0fZP_wan2EOuPD8052L6Y_RU4g62agg@mail.gmail.com>
	<528132C5.9000908@redhat.com>
	<CAKi4VALDxMP9YmomHhi5CPaTxG1cjdX1Ab+XoNE4=v=4p_HFaw@mail.gmail.com>
	<52B249D9.9020805@redhat.com>
Date: Sun, 22 Dec 2013 19:52:59 -0200
Message-ID: <CAKi4VAJe_ObudsdKJ5H=bWuA9Oa90FyxVBgWkJ-qOWmSQ6kApA@mail.gmail.com>
Subject: Re: [announce] python-kmod 0.9
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Andy Grover <agrover@redhat.com>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-modules <linux-modules@vger.kernel.org>, wking@tremily.us
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Andy,

On Wed, Dec 18, 2013 at 11:20 PM, Andy Grover <agrover@redhat.com> wrote:
> On 12/18/2013 11:38 AM, Lucas De Marchi wrote:
>>>>
>>>> Hey. I think I replied once that this could be better left off in its
>>>> own repository. However I'm reconsidering this now... if you are still
>>>> interested in merging into kmod, I think it would be good.
>>>
>>>
>>>
>>> You bet. I'll start work on a patch.
>>
>>
>> Ping.
>
>
> Hi Lucas,
>
> Sorry for the delay. Here's what I have so far:
>
> https://github.com/agrover/kmod.git
>
> Copied source in, modified configure.ac. But I'm pretty weak on automake.
> Basically the Python bindings need "python setup.py build" and "python
> setup.py install" for the relevant make targets, but that still needs to be
> hooked up :-/
>
> Would you or some other kind soul that knows automake be willing to advise,
> or even fix this up the rest of the way?

Sure  I'll do the missing glue to the build system.

>
> Thanks -- Regards -- Andy

I decided to let this out of kmod 16 so we have more time to play with
the python bindings...


regards,
Lucas De Marchi
