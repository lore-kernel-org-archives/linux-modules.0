Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andreas Robinson <andr345@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhao Hongjiang <zhaohongjiang@huawei.com>, David Miller <davem@davemloft.net>, tim.c.chen@linux.intel.com, Andrew Morton <akpm@linux-foundation.org>, "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>, linux-crypto@vger.kernel.org, linux-modules <linux-modules@vger.kernel.org>, Tom Gundersen <teg@jklm.no>
Subject: Re: [PATCH] modules: add support for soft module dependencies
In-Reply-To: <CAKi4VA+=1vOOt0BqdQHQaeF1hP3DrRtCL_ObXY0cPeO7S_MtYw@mail.gmail.com>
References: <20130724071757.GA30970@gondor.apana.org.au> <87siz38q2t.fsf@rustcorp.com.au> <20130725020329.GA14625@gondor.apana.org.au> <CAKi4VA+=1vOOt0BqdQHQaeF1hP3DrRtCL_ObXY0cPeO7S_MtYw@mail.gmail.com>
Date: Fri, 13 Sep 2013 09:37:33 +0930
Message-ID: <87ob7x37p6.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-modules.vger.kernel.org>

Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
> On Wed, Jul 24, 2013 at 11:03 PM, Herbert Xu
> <herbert@gondor.apana.org.au> wrote:
>> On Thu, Jul 25, 2013 at 09:32:02AM +0930, Rusty Russell wrote:
>>> Herbert Xu <herbert@gondor.apana.org.au> writes:
>>> > Hi Rusty:
>>> >
>>> > I don't know why this patch never went into the kernel, even
>>> > though the corresponding features have been added to modprobe
>>> > in most if not all distros.
>>>
>>> Because Andreas never sent me the patch?  This is the first I've *heard*
>>> of this feature.  Looks like it didn't hit lkml either.  And what was
>>> 2/2?
>>
>> 2/2 was the patch to actually use this in crc32c.
>>
>>> It's not how I would have done this: post-deps are more flexibly done at
>>> runtime, because the module may have to do work to figure out what to
>>> pull in.  But since it already exists, I'll apply this patch: it doesn't
>>> cost the kernel anything.
>
> But it did cause boot failures. The file modules.softdep file was
> supposed to be informational until now. That's why depmod put a
> comment saying to "copy on user's discretion to /etc/modules.d"
> instead of parsing it directly.

I'm happy to change this macro to create a modinfo line like
"softdep:<modname>"

ie. tools like mkinitrd could pick it up and try to find a matching
module, but depmod would ignore it.

It's really up to Lucas, since this affects him.

Cheers,
Rusty.
