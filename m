MIME-Version: 1.0
In-Reply-To: <1412062906-27378-1-git-send-email-patrickdepinguin@gmail.com>
References: <1412062906-27378-1-git-send-email-patrickdepinguin@gmail.com>
Date: Wed, 1 Oct 2014 17:48:02 -0300
Message-ID: <CAKi4VAKVL7oxZ6dvHbixeihtiOD2GDkHLknht_jSg3-+hWWGBQ@mail.gmail.com>
Subject: Re: [PATCH] Add dummy definition of O_CLOEXEC
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Thomas De Schampheleire <patrickdepinguin@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, Robert Yang <liezhi.yang@windriver.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Sep 30, 2014 at 4:41 AM, Thomas De Schampheleire
<patrickdepinguin@gmail.com> wrote:
> From: Robert Yang <liezhi.yang@windriver.com>
>
> O_CLOEXEC is introduced from Linux 2.6.23, so old kernel doesn't have
> it, we need check before use.

Humn... Do we really want to support kernels older than 2.6.23?

Adding a workaround like this IMO will just hide bugs because we rely
on O_CLOEXEC semantics. Doing nothing is not really what we want.
Maybe if ancient downstream distros want the workaround they can
define O_CLOEXEC by themselves during build... passing it in CFLAGS
should work

-- 
Lucas De Marchi
