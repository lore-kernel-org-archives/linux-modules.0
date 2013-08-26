MIME-Version: 1.0
In-Reply-To: <1377541250-10193-3-git-send-email-maillist-kmod@barfooze.de>
References: <1377541250-10193-1-git-send-email-maillist-kmod@barfooze.de>
	<1377541250-10193-3-git-send-email-maillist-kmod@barfooze.de>
Date: Mon, 26 Aug 2013 20:07:11 -0300
Message-ID: <CAKi4VAL-hDyZvaUXoBMyYPjaA7hRhXNJt353HmvHF2kqkqHCEA@mail.gmail.com>
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

couldn't musl just do what glibc does here?

<... define the types here ...>
#define stdin stdin
#define stdout stdout
#define stderr stderr

This would avoid patches like this to several projects.

>
> renaming the struct members stdout to std_out and stderr
> to std_err, to be 1) compliant 2) cause compilation to
> succeed.

uggh.. "out" and "err" otherwise. No need for the "std_" prefix.


Lucas De Marchi
