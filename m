Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:64304 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbaABTTU (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 2 Jan 2014 14:19:20 -0500
Received: by mail-ee0-f52.google.com with SMTP id d17so6426620eek.11
        for <linux-modules@vger.kernel.org>; Thu, 02 Jan 2014 11:19:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140102030708.GA2731@bongo.bofh.it>
References: <20140102030708.GA2731@bongo.bofh.it>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 2 Jan 2014 17:18:59 -0200
Message-ID: <CAMOw1v7itnBqZzDvZMHfh0JQ6Ug_76fKEPBoeFyhJY7aqQX5Jw@mail.gmail.com>
Subject: Re: Bug#687435: kmod: Minor documentation discrepancy
To: "Marco d'Itri" <md@linux.it>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi Marco,

On Thu, Jan 2, 2014 at 1:07 AM, Marco d'Itri <md@linux.it> wrote:
> I can provide a patch if needed, but which option(s) should actually be
> documented?

Just like in modprobe (see --help there)... we have both of them since
they were supported in module-init-tools.


Lucas De Marchi


>
> ----- Forwarded message from "Marc F. Clemente" <marc@mclemente.net> -----
>
> From: "Marc F. Clemente" <marc@mclemente.net>
> To: Debian Bug Tracking System <submit@bugs.debian.org>
> Subject: Bug#687435: kmod: Minor documentation discrepancy
>
> Package: kmod
> Version: 9-2
> Severity: minor
>
> When I get help from the program with "depmod --help" I get:
>   -n, --show           Write the dependency file on stdout only
>
> But the documentation "man depmod" says:
>   -n --dry-run
>
> All three options work fine and do the same thing, so it's really no big deal.
>
> -- System Information:
> Debian Release: wheezy/sid
>   APT prefers unstable
>   APT policy: (500, 'unstable'), (1, 'experimental')
> Architecture: amd64 (x86_64)
>
> Kernel: Linux 3.2.0-3-amd64 (SMP w/8 CPU cores)
> Locale: LANG=en_US.UTF-8, LC_CTYPE=en_US.UTF-8 (charmap=UTF-8)
> Shell: /bin/sh linked to /bin/dash
>
> Versions of packages kmod depends on:
> ii  libc6     2.13-35
> ii  libkmod2  9-2
> ii  lsb-base  4.1+Debian7
>
> kmod recommends no packages.
>
> kmod suggests no packages.
>
> -- no debconf information
>
> ----- End forwarded message -----
>
> --
> ciao,
> Marco
