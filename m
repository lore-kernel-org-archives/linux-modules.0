MIME-Version: 1.0
In-Reply-To: <20150603180525.GB4306@bongo.bofh.it>
References: <20150603180525.GB4306@bongo.bofh.it>
Date: Mon, 8 Jun 2015 22:49:15 -0300
Message-ID: <CAKi4VAK8WObUq3tUwWU_yWYacVkYLZSweH-RRWX0kjQ+UZZm6Q@mail.gmail.com>
Subject: Re: Bug#787548: kmod: Small typo in rmmod(8)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Wed, Jun 3, 2015 at 3:05 PM, Marco d'Itri <md@linux.it> wrote:
>
> --
> ciao,
> Marco
>
>
> ---------- Forwarded message ----------
> From: Santiago Vila <sanvila@unex.es>
> To: submit@bugs.debian.org
> Cc:
> Date: Tue, 2 Jun 2015 19:25:34 +0200 (CEST)
> Subject: Bug#787548: kmod: Small typo in rmmod(8)
> Package: kmod
> Version: 20-1
> Severity: minor
> Tags: upstream, patch
>
> This is how rmmod(8) looks like:
>
> SEE ALSO
>        modprobe(8), insmod(8), lsmod(8)modinfo(8)
>
> The attached trivial patch fixes it:
>
> SEE ALSO
>        modprobe(8), insmod(8), lsmod(8), modinfo(8)

Patch has been applied.

Could you please ask people to send properly formatted patch with git
format-patch so there's no need to get author and message by hand?

thanks

-- 
Lucas De Marchi
