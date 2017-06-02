MIME-Version: 1.0
In-Reply-To: <20170509190924.9087-1-yauheni.kaliuta@redhat.com>
References: <CAKi4VALJgW=RbpCT4kfix9sACzzz68=LZ-FhUUORXxHMcTA__g@mail.gmail.com>
	<20170509190924.9087-1-yauheni.kaliuta@redhat.com>
Date: Thu, 1 Jun 2017 21:05:07 -0700
Message-ID: <CAKi4VALY4oLcE2VkDtu3VYupVB7RcRxsYRx7wj3OHRD9Pa0F4g@mail.gmail.com>
Subject: Re: [PATCHv2 0/4] depmod: implement external directories support
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Tue, May 9, 2017 at 12:09 PM, Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> This is a pretty simple extention of existing logic, since now
> depmod already is able to:
>
> a) scan modules with full path from command line without -a
> switch;
> b) detects broken symbol dependencies and broken modversions,
> what assumes, that modules are already are not built for the
> existing kernel.
>
> See PATCH3 description.
>
>
> V1->V2:
>
> - rewrite directory scanning code to use scratchbuf;
> - add tests.
>
> Yauheni Kaliuta (4):
>   depmod: create depmod dir independent search function
>   depmod: rewrite depmod modules search with scratchbuf
>   depmod: implement external directories support
>   testsuite: add tests for external directory support

Thanks a lot. All 4 patches applied and this new feature will appear
on v25 soon. Sorry for the delay in reviewing and applying this.

Lucas De Marchi
