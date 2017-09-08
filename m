MIME-Version: 1.0
In-Reply-To: <20170901112801.11703-1-lkundrak@v3.sk>
References: <20170901112801.11703-1-lkundrak@v3.sk>
Date: Fri, 8 Sep 2017 14:03:59 -0700
Message-ID: <CAKi4VAKS7Vo6WoEJGjY6cRMZxmSsv4mj=eRhhHCnYno0DoP5Ag@mail.gmail.com>
Subject: Re: [RESEND PATCH] modprobe: install default configuration
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, linux-modules <linux-modules@vger.kernel.org>,
	jeyu@kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Fri, Sep 1, 2017 at 4:28 AM, Lubomir Rintel <lkundrak@v3.sk> wrote:
> Some network devices have an awful habit of creating interfaces when loaded,
> despite not asked for. Worse even, they do so while being autoloaded due to an
> attempt to create a device via netlink:
>
>   # rmmod dummy
>   # ip link add dummy0 type dummy
>   RTNETLINK answers: File exists
>
> The kernel maintainers seem opposed to fixing this in kernel (despite a similar
> thing has been done with loop block devices) [1]. Let's fix this my overriding the
> defaults from userspace.
>
> [1] http://comments.gmane.org/gmane.linux.kernel/2124714
> ---
> This seems to have slipped through the cracks.
>
>  Makefile.am                |  4 ++++
>  modprobe.d/50-default.conf | 24 ++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100644 modprobe.d/50-default.conf
>
> diff --git a/Makefile.am b/Makefile.am
> index 2a1eb50..b114db8 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -105,6 +105,10 @@ bashcompletiondir=@bashcompletiondir@
>  dist_bashcompletion_DATA = \
>         shell-completion/bash/kmod
>
> +modprobeddir=$(prefix)/lib/modprobe.d
> +dist_modprobed_DATA = \
> +       modprobe.d/50-default.conf
> +
>  install-exec-hook:
>         if test "$(libdir)" != "$(rootlibdir)"; then \
>                 $(MKDIR_P) $(DESTDIR)$(rootlibdir) && \
> diff --git a/modprobe.d/50-default.conf b/modprobe.d/50-default.conf
> new file mode 100644
> index 0000000..70d21f2
> --- /dev/null
> +++ b/modprobe.d/50-default.conf
> @@ -0,0 +1,24 @@
> +# default module parameters
> +#
> +# This file is part of kmod.
> +#
> +# Copyright 2016 Lubomir Rintel
> +#
> +# This program is free software; you can redistribute it and/or modify it
> +# under the terms of the GNU Lesser General Public License as published by
> +# the Free Software Foundation; either version 2.1 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful, but
> +# WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> +# General Public License for more details.
> +#
> +# You should have received a copy of the GNU Lesser General Public License
> +# along with this program; if not, see <http://www.gnu.org/licenses/>.
> +
> +# See modprobe.d(5) for the description of the files in this directory,
> +
> +options bonding max_bonds=0
> +options dummy numdummies=0
> +options ifb numifbs=0
> --
> 2.13.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-modules" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


It seems you forgot to follow up on the feedback I gave last time and
asked for opinions.

https://lkml.org/lkml/2016/6/14/336

CC'ing Jessica as well for opinions who is maintaining the kernel part.

Lucas De Marchi
