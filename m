MIME-Version: 1.0
In-Reply-To: <20150416105612.GA3204@bongo.bofh.it>
References: <20150416105612.GA3204@bongo.bofh.it>
Date: Thu, 16 Apr 2015 08:48:55 -0300
Message-ID: <CAKi4VALsr1+JZ9tY_3-VDWX-G6x++2i_hwJQ6ovje10DS5zHGA@mail.gmail.com>
Subject: Re: Bug#782692: kmod: spurious spaces in lsmod output
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Thu, Apr 16, 2015 at 7:56 AM, Marco d'Itri <md@linux.it> wrote:
> ----- Forwarded message from Santiago Vila <sanvila@unex.es> -----
>
> From: Santiago Vila <sanvila@unex.es>
> To: submit@bugs.debian.org
> Subject: Bug#782692: kmod: spurious spaces in lsmod output
>
> Package: kmod
> Version: 18-3
> Severity: minor
>
> While using "localyesconfig" to build a custom kernel I noticed that lsmod
> output now has trailing spaces when the list of "Used by" modules is empty.
>
> The following (untested but trivial) patch should fix it. It just delays
> the space to the point where we are sure that there are more things to print.


Applied, thanks.

-- 
Lucas De Marchi
