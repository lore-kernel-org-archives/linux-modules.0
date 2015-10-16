Return-Path: <philippedeswert@gmail.com>
Return-Path: <philippedeswert@gmail.com>
Message-ID: <5620E7CA.3020509@gmail.com>
Date: Fri, 16 Oct 2015 15:04:26 +0300
From: Philippe De Swert <philippedeswert@gmail.com>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] insmod: do support -f
References: <1444232218-22150-1-git-send-email-philippedeswert@gmail.com> <CAKi4VAKvhn53jSHju9_wbXtt_Unhpxayf3ayKq5endOG4LzxDw@mail.gmail.com>
In-Reply-To: <CAKi4VAKvhn53jSHju9_wbXtt_Unhpxayf3ayKq5endOG4LzxDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-modules.vger.kernel.org>

Hi Lucas,

On 11/10/15 21:59, Lucas De Marchi wrote:
> Hi Pom: Philippe De Swert <philippe.deswert@jollamobile.com>
>
> The -f switch is accepted by insmod, but silently ignored. This
> causes the user to wonder why things don't work. As insmod is
> most often used with "evil" modules, -f is almost default and
> thus needs to work.
> I'd encourage people for actually *not* using -f.

Well unfortunately we still do not live in a perfect world yet. Reality 
is that I had to yet again
deal with a mystery module from the deep...
> I have mixed feelings here because this is disabled in insmod since
> forever (it's already on the first git commit from module-init-tools).
> If anyone knows the reason it would be nice... at least to include in
> the commit message.

Well the weirdest thing is that it is ignored without warning. With as a 
result it lets you wonder why it
did not work. I wasted quite some time checking if the last -f fix 
actually did what it was supposed to do.
As making -f work was not that hard I quickly did it. Another option 
would at least let the user of it know
that it won't work. However imho insmod -f is the first command you will 
use trying to insert a mystery module
as it will most likely also not be visible to modprobe as the location 
of it can be arbitrary.

Regards,

Philippe
