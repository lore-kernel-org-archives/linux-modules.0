MIME-Version: 1.0
In-Reply-To: <56A91B6A.2060205@oracle.com>
References: <56A91B6A.2060205@oracle.com>
Date: Thu, 28 Jan 2016 17:21:34 -0200
Message-ID: <CAKi4VA+MC=hXMQ2kHi4_Xv2w7qQcG443zj9+rKo_JKoSzgDvYQ@mail.gmail.com>
Subject: Re: modinfo crc32 broken after fd44a98ae2eb
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Samson Yeung <samson.yeung@oracle.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Samson,

On Wed, Jan 27, 2016 at 5:32 PM, Samson Yeung <samson.yeung@oracle.com> wrote:
> Hi all,
>
> Please reply directly as I am not on this list.
>
> Commit "fd44a98ae2eb Fix race while loading modules" also broke 'modinfo
> crc32', specifically, for me.
>
> Is this a bug, is it something strange going on with crc32, or is it
> intended behavior?

breaking is never intended ;-). What do you mean by "break"? Does it crash?

I can't see how this commit is related to modinfo. You will need to
give more details. Check if you can get the output by passing the
complete path to the module and make sure it's actually a module (and
not builtin) in your kernel configuration

Lucas De Marchi
