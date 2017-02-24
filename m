Return-Path: <bryanh@giraffe-data.com>
Message-ID: <35934.bryanh@giraffe-data.com>
Date: 24 Feb 2017 16:32:20 +0000
From: Bryan Henderson <bryanh@giraffe-data.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: linux-modules@vger.kernel.org
In-reply-to: 
	<CAKi4VAJ178U+Zx1SRsqROcPpEDiZmOckiRDOnNg==XnW=FZ5YA@mail.gmail.com>
	(lucas.de.marchi@gmail.com)
Subject: Re: Build fails when Xsltproc not present
References: <52857.bryanh@giraffe-data.com> <CAKi4VAKo=LP783aZcCuwmq3ubzaJL7S9FdmCOrv8UPr+vgAGPw@mail.gmail.com>
 <CAKi4VA+dom7PwCkfCNrWH-1sEo5sLjOOuBNRKhH+cFRjvefr1g@mail.gmail.com> <8812.bryanh@giraffe-data.com> <CAKi4VAJ178U+Zx1SRsqROcPpEDiZmOckiRDOnNg==XnW=FZ5YA@mail.gmail.com>
List-ID: <linux-modules.vger.kernel.org>

>They are already built on the distributed tarball, those coming from
>https://www.kernel.org/pub/linux/utils/kernel/kmod/
>If you are building from the git repository then yes, you need
>xsltproc. I pushed this patch:

Well, I built from the tarball, which I still have and see contains
e.g. man/kmod.8, and yet the build failed on me.  I will try to reproduce it
and see what happened, but looking at my local patch to the package, I see
that I 1) used --disable-manpages and 2) modified libkmod/docs/Makefile.in to
prevent that directory from building.  There are no man pages in libkmod/docs/
.

Your change is still right, of course.  The make files should be able to
tolerate these null values.

-- 
Bryan Henderson                                   San Jose, California
