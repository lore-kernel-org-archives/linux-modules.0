Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Harish Jenny K N <harish_kandiga@mentor.com>, linux-modules <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "greg KH" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] libkmod-module: Remove directory existence check for KMOD_MODULE_BUILTIN
In-Reply-To: <CAKi4VAKpzUcakX+BY8dYE8Jx4BUOqy_-LZWH5gJWtwn3EdbE0g@mail.gmail.com>
References: <1424177796-17923-1-git-send-email-harish_kandiga@mentor.com> <CAKi4VA+nJknEwkQfUWf0VbcEMzzz3uHwwNe8OuWQOi-K0sWxjQ@mail.gmail.com> <874mqjuaky.fsf@rustcorp.com.au> <CAKi4VAKpzUcakX+BY8dYE8Jx4BUOqy_-LZWH5gJWtwn3EdbE0g@mail.gmail.com>
Date: Thu, 19 Feb 2015 09:10:12 +1030
Message-ID: <87vbiysv1v.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
> On Wed, Feb 18, 2015 at 2:07 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Yeah, I just thought (an wanted that) the attributes were being
> created first and then hooked up in the sysfs tree under
> /sys/module/<modulename>. I.e. if the directory exists and there's no
> initstate this is because it's a builtin module. I don't want to
> wait/sleep on the file to appear because users of
> kmod_module_get_initstate() may not tolerate this behavior.
>
> Looking up at the old module-init-tools, it used an ugly loop with
> usleep() before trying to read the file again :-/
>
> Can we change kernel side guaranteeing the initstate file appears
> together with the directory?

Greg?  The core problem is that kmod looks for
/sys/module/<name>/initstate; if it's not there, it assumes a builtin
module.

However, this is racy when a module is being inserted.  Is there a way
to create this sysfs file and dir atomically?

Thanks,
Rusty.
