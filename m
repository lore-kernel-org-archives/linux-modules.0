MIME-Version: 1.0
In-Reply-To: <20160601111207.GB28228@dhcp-13-42.nay.redhat.com>
References: <20160601111207.GB28228@dhcp-13-42.nay.redhat.com>
Date: Sat, 4 Jun 2016 11:07:14 -0300
Message-ID: <CAKi4VALSHSvvXRGSsAL-34SRn9Nh0rqW7xFHpGJL1Kn88_1YCw@mail.gmail.com>
Subject: Re: kmod documentation issue -- module parameters must after modulename
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Honggang LI <honli@redhat.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jun 1, 2016 at 8:12 AM, Honggang LI <honli@redhat.com> wrote:
> upstream-git]$ git clone https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git
> upstream-git]$ cd kmod
> kmod]$ grep -w -n fred -r .
> ./man/modprobe.d.xml:144:            This can be useful because users expect "modprobe fred opt=1" to
>                                                                               ^^^^^^^^^^^^^^^^^^^
> ./man/modprobe.d.xml:148:            --ignore-install fred $CMDLINE_OPTS"
>                                                       ^^^^^^^^^^^^^^^^^^
>
> "modprobe fred opt=1" should be "modprobe opt=1 fred"
> "fred $CMDLINE_OPTS" should be "$CMDLINE_OPTS fred"

Have you tried that? The doc is actually correct that the options
should be after the module name, not before. And it *is* the modprobe
behavior: https://git.kernel.org/cgit/utils/kernel/kmod/kmod.git/tree/tools/modprobe.c#n591



Lucas De Marchi
