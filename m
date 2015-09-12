MIME-Version: 1.0
In-Reply-To: <1442004956-3868-5-git-send-email-labbott@fedoraproject.org>
References: <1442004956-3868-1-git-send-email-labbott@fedoraproject.org>
	<1442004956-3868-5-git-send-email-labbott@fedoraproject.org>
Date: Sat, 12 Sep 2015 16:00:55 -0300
Message-ID: <CAKi4VAJiG3con6bcK5OkaBuFaeh19eyfUszE34Nt5e_Z2dYs5g@mail.gmail.com>
Subject: Re: [PATCH 4/4] depmod: Add error message for bad version
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Laura Abbott <labbott@fedoraproject.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Fri, Sep 11, 2015 at 5:55 PM, Laura Abbott <labbott@fedoraproject.org> wrote:
>
> Currently, if a value that doesn't match a kernel version
> ("%u.%u") is passed in, depmod silently falls back to
> using uname. Make it clear to the user that this is happening
> by giving a message to the user.
> ---

Actually I think we should not fallback. If the user passed a wrong
number, fallbacking to the currently running kernel is plain wrong.
This was done mostly due to compatibility with module-init-tools but I
prefer breaking it rather than silently (or verbose as per your patch)
doing the wrong thing.

thanks

Lucas De Marchi
