Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-modules <linux-modules@vger.kernel.org>
Cc: "Kent Overstreet" <koverstreet@google.com>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Subject: Re: module refcnt underflow
In-Reply-To: <CAKi4VA+RBToB3fO21N-QWdPZeqGpg1ASHzn3vwB9t64ApdwrsA@mail.gmail.com>
References: <CAKi4VA+RBToB3fO21N-QWdPZeqGpg1ASHzn3vwB9t64ApdwrsA@mail.gmail.com>
Date: Mon, 01 Jul 2013 12:08:36 +0930
Message-ID: <8738rzt36b.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-modules.vger.kernel.org>

Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
> Hi,
>
> While checking somethings for a next release of kmod I noticed this
> strange thing:
>
> cat /sys/module/acpi_cpufreq/refcnt
> 18446744073709551614
>
> We outputs this as "-1" in lsmod because we treat the value as signed.
> I was just going to change it to unsigned to make it compatible with
> what module-init-tools does but... For me it looks like a bug in the
> kernel since in this file we just have the output of
> kernel/module.c:module_refcount()
>
> I have this behavior on 3.9.2 but judging by the missing commits in
> kernel/module.c, this would also happen in latest head. I've never
> seen such a value so I guess it might be difficult to reproduce it
> again.
>
> Any hints on what could cause decs to be greater than incs in module_refcount()?

That points to a bug in the cpufreq code.

At a glance, there's nothing obvious, but there are quite a few
reference counts in that code.

Informed people cc'd...

Thanks,
Rusty.
