Return-Path: <bryanh@giraffe-data.com>
Message-ID: <61432.bryanh@giraffe-data.com>
Date: 26 Feb 2017 23:09:14 +0000
From: Bryan Henderson <bryanh@giraffe-data.com>
To: lucas.de.marchi@gmail.com
CC: linux-modules@vger.kernel.org
In-reply-to: <35934.bryanh@giraffe-data.com>
Subject: Re: Build fails when Xsltproc not present
References: <52857.bryanh@giraffe-data.com> <CAKi4VAKo=LP783aZcCuwmq3ubzaJL7S9FdmCOrv8UPr+vgAGPw@mail.gmail.com>
 <CAKi4VA+dom7PwCkfCNrWH-1sEo5sLjOOuBNRKhH+cFRjvefr1g@mail.gmail.com> <8812.bryanh@giraffe-data.com> <CAKi4VAJ178U+Zx1SRsqROcPpEDiZmOckiRDOnNg==XnW=FZ5YA@mail.gmail.com> <35934.bryanh@giraffe-data.com>
List-ID: <linux-modules.vger.kernel.org>

>Well, I built from the tarball, which I still have and see contains
>e.g. man/kmod.8, and yet the build failed on me.  I will try to reproduce it
>and see what happened

OK, I figured it out.

'make clean' deletes the distributed man page files.  Neither 'make clean' nor
'make distclean' should delete distributed files, but 'make maintainer-clean'
should.

And while we're looking at clean, 'make clean' does _not_ delete the built
files 'rmmod', etc. from the tools/ directory, and it should.

-- 
Bryan Henderson                                   San Jose, California
