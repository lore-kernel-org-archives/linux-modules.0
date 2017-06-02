MIME-Version: 1.0
In-Reply-To: <20170509190924.9087-5-yauheni.kaliuta@redhat.com>
References: <CAKi4VALJgW=RbpCT4kfix9sACzzz68=LZ-FhUUORXxHMcTA__g@mail.gmail.com>
	<20170509190924.9087-1-yauheni.kaliuta@redhat.com>
	<20170509190924.9087-5-yauheni.kaliuta@redhat.com>
Date: Thu, 1 Jun 2017 21:03:03 -0700
Message-ID: <CAKi4VA+YC8f5eAQJrSYJaQv0+XDuXAGqeU=tWE1asp4A8rT0EA@mail.gmail.com>
Subject: Re: [PATCHv2 4/4] testsuite: add tests for external directory support
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Tue, May 9, 2017 at 12:09 PM, Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
> The following tests added:
>
> - depmod_search_order_external_first -- checks if external module
>   is taken in use when it has higher priority;
> - depmod_search_order_external_last -- checks if external module
>   is skipped when it has lower priority;
> - test_modinfo_external -- checks if modinfo is able to look up
>   correct external module;
> - modprobe_external -- checks if modprobe is able to look up
>   correct external module and loads it.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>

Thanks, applied!

Lucas De Marchi
