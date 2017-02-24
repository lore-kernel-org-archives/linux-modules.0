MIME-Version: 1.0
In-Reply-To: <8812.bryanh@giraffe-data.com>
References: <52857.bryanh@giraffe-data.com>
	<CAKi4VAKo=LP783aZcCuwmq3ubzaJL7S9FdmCOrv8UPr+vgAGPw@mail.gmail.com>
	<CAKi4VA+dom7PwCkfCNrWH-1sEo5sLjOOuBNRKhH+cFRjvefr1g@mail.gmail.com>
	<8812.bryanh@giraffe-data.com>
Date: Thu, 23 Feb 2017 20:03:13 -0800
Message-ID: <CAKi4VAJ178U+Zx1SRsqROcPpEDiZmOckiRDOnNg==XnW=FZ5YA@mail.gmail.com>
Subject: Re: Build fails when Xsltproc not present
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Bryan Henderson <bryanh@giraffe-data.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Thu, Feb 23, 2017 at 7:17 PM, Bryan Henderson
<bryanh@giraffe-data.com> wrote:
>>Actually I did it on make because man pages are  with the distributed tarball
>
> I'm not sure I understand this.  Are you saying a person doesn't need Xsltproc
> to do a default build because the man pages are already built?  Then I wonder
> why I encountered this problem.  I had no reason to want to rebuild something
> that was distributed.

They are already built on the distributed tarball, those coming from
https://www.kernel.org/pub/linux/utils/kernel/kmod/
If you are building from the git repository then yes, you need
xsltproc. I pushed this patch:

https://git.kernel.org/cgit/utils/kernel/kmod/kmod.git/commit/?id=72167ba113c00eea6eb73cd91ce173e5c734564b

So now when building from git it will say xsltproc is missing

Lucas De Marchi
