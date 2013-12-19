Return-Path: <agrover@redhat.com>
Message-ID: <52B249D9.9020805@redhat.com>
Date: Wed, 18 Dec 2013 17:20:25 -0800
From: Andy Grover <agrover@redhat.com>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        linux-modules <linux-modules@vger.kernel.org>, wking@tremily.us
Subject: Re: [announce] python-kmod 0.9
References: <509C4944.3040907@redhat.com> <CAMOw1v6xtqE4yTt4CBJ0fZP_wan2EOuPD8052L6Y_RU4g62agg@mail.gmail.com> <528132C5.9000908@redhat.com> <CAKi4VALDxMP9YmomHhi5CPaTxG1cjdX1Ab+XoNE4=v=4p_HFaw@mail.gmail.com>
In-Reply-To: <CAKi4VALDxMP9YmomHhi5CPaTxG1cjdX1Ab+XoNE4=v=4p_HFaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-modules.vger.kernel.org>

On 12/18/2013 11:38 AM, Lucas De Marchi wrote:
>>> Hey. I think I replied once that this could be better left off in its
>>> own repository. However I'm reconsidering this now... if you are still
>>> interested in merging into kmod, I think it would be good.
>>
>>
>> You bet. I'll start work on a patch.
>
> Ping.

Hi Lucas,

Sorry for the delay. Here's what I have so far:

https://github.com/agrover/kmod.git

Copied source in, modified configure.ac. But I'm pretty weak on 
automake. Basically the Python bindings need "python setup.py build" and 
"python setup.py install" for the relevant make targets, but that still 
needs to be hooked up :-/

Would you or some other kind soul that knows automake be willing to 
advise, or even fix this up the rest of the way?

Thanks -- Regards -- Andy
