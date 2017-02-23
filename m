MIME-Version: 1.0
In-Reply-To: <52857.bryanh@giraffe-data.com>
References: <52857.bryanh@giraffe-data.com>
Date: Thu, 23 Feb 2017 14:16:57 -0800
Message-ID: <CAKi4VAKo=LP783aZcCuwmq3ubzaJL7S9FdmCOrv8UPr+vgAGPw@mail.gmail.com>
Subject: Re: Build fails when Xsltproc not present
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Bryan Henderson <bryanh@giraffe-data.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Mon, Dec 19, 2016 at 4:50 PM, Bryan Henderson
<bryanh@giraffe-data.com> wrote:
>
> I believe in that case, it should just skip building the man pages.

We don't do auto-enabling/disabling.

> Or make 'configure' fail and suggest --disable-manpages.
>
> Or make the make fail gracefully, telling you you don't have the tools
> necessary to create man pages and suggesting --disable-manpages.

Failing on configure phase would be the desired solution. I'll take a
look on this for next release, but if  you have a patch ready it would
be appreciated.


thanks
Lucas De Marchi
