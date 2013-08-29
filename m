MIME-Version: 1.0
In-Reply-To: <1377541250-10193-3-git-send-email-maillist-kmod@barfooze.de>
References: <1377541250-10193-1-git-send-email-maillist-kmod@barfooze.de>
	<1377541250-10193-3-git-send-email-maillist-kmod@barfooze.de>
Date: Thu, 29 Aug 2013 01:23:38 -0300
Message-ID: <CAKi4VAJ6QRHEB+Pq8s41TQkLCrcTQnPv73L8xUVtoNb0N4whhA@mail.gmail.com>
Subject: Re: [PATCH 3/3] testsuite: fix usage of reserved names
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: John Spencer <maillist-kmod@barfooze.de>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Mon, Aug 26, 2013 at 3:20 PM, John Spencer <maillist-kmod@barfooze.de> wrote:
> stdout and stderr are names reserved for the implementation
> and musl uses them rightfully as macro - and the expansion
> causes (of course) unexpected results.
>
> renaming the struct members stdout to std_out and stderr
> to std_err, to be 1) compliant 2) cause compilation to
> succeed.
>
> fixes build with musl libc.
>
> Signed-off-by: John Spencer <maillist-kmod@barfooze.de>

We don't use signed-of-by in kmod.

Since this was the only issue I went ahead and applied the patch without it.


Thanks.

Lucas De Marchi
