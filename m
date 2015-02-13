MIME-Version: 1.0
In-Reply-To: <20150210184640.GA25175@localhost>
References: <20150210184640.GA25175@localhost>
Date: Fri, 13 Feb 2015 01:23:31 -0200
Message-ID: <CAKi4VAJzuzPVHdjczOKvQiKO-gs6+Yd-qUWy4RDXTHUVNPttyA@mail.gmail.com>
Subject: Re: [PATCH] libkmod: properly validate file size
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Tue, Feb 10, 2015 at 4:46 PM, Tobias Stoeckmann
<tobias@stoeckmann.org> wrote:
> Hi,
>
> in function kmod_elf_new, the file size has to be properly validated against
> section offset. Currently, the file size is considered valid based on
> ELF header size + section header size * section count. That is not sufficient.
>
> In fact, ELF specifies a section header offset, which doesn't have to be the
> size of the ELF header. The supplied test cases even cover this.

the supplied test cases? which test cases?

> The correct test is: section offset + section header size * section count

I'm not sure about this anymore without looking up to the
specification. Could you point here in the commit message?


thanks
Lucas De Marchi
