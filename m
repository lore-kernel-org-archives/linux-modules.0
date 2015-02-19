Return-Path: <gregkh@linuxfoundation.org>
Date: Wed, 18 Feb 2015 18:25:19 -0800
From: greg KH <gregkh@linuxfoundation.org>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
	Harish Jenny K N <harish_kandiga@mentor.com>,
	linux-modules <linux-modules@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libkmod-module: Remove directory existence check for
 KMOD_MODULE_BUILTIN
Message-ID: <20150219022519.GD8089@kroah.com>
References: <1424177796-17923-1-git-send-email-harish_kandiga@mentor.com>
 <CAKi4VA+nJknEwkQfUWf0VbcEMzzz3uHwwNe8OuWQOi-K0sWxjQ@mail.gmail.com>
 <874mqjuaky.fsf@rustcorp.com.au>
 <CAKi4VAKpzUcakX+BY8dYE8Jx4BUOqy_-LZWH5gJWtwn3EdbE0g@mail.gmail.com>
 <87vbiysv1v.fsf@rustcorp.com.au>
 <CAKi4VAKc_zrPptt2ZKT_Jj8bLdL1bt0emhtEuodV2WKkas9ZOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKi4VAKc_zrPptt2ZKT_Jj8bLdL1bt0emhtEuodV2WKkas9ZOw@mail.gmail.com>
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 18, 2015 at 11:19:14PM -0200, Lucas De Marchi wrote:
> On Wed, Feb 18, 2015 at 8:40 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> > Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
> >> On Wed, Feb 18, 2015 at 2:07 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> >> Yeah, I just thought (an wanted that) the attributes were being
> >> created first and then hooked up in the sysfs tree under
> >> /sys/module/<modulename>. I.e. if the directory exists and there's no
> >> initstate this is because it's a builtin module. I don't want to
> >> wait/sleep on the file to appear because users of
> >> kmod_module_get_initstate() may not tolerate this behavior.
> >>
> >> Looking up at the old module-init-tools, it used an ugly loop with
> >> usleep() before trying to read the file again :-/
> >>
> >> Can we change kernel side guaranteeing the initstate file appears
> >> together with the directory?
> >
> > Greg?  The core problem is that kmod looks for
> > /sys/module/<name>/initstate; if it's not there, it assumes a builtin
> > module.
> 
> Just to make it clear:
> 
> We try to open /sys/module/<name>/initstate. If it fails we stat
> /sys/module/<name> checking if it exists and is a directory. If it
> does then we assume the module is builtin.
> 
> > However, this is racy when a module is being inserted.  Is there a way
> > to create this sysfs file and dir atomically?
> 
> Greg, the question is still valid since it'd be nice to have this
> guarantee and be able to correctly reply the state with whatever is in
> initstate file, but...

You should always wait until you get the uevent that the object was
added before poking around in sysfs.  The kernel will guarantee all of
the needed files / directories will be created before that event is sent
out.  That's why we added the uevent message.

So by just busy-spinning on the directory and ignoring the uevent, you
are just blindly guessing as to when things are finished, which is racy
as you see.

So please just wait for the event, then you should be fine, that's what
it is there for.

thanks,

greg k-h
