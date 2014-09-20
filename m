MIME-Version: 1.0
In-Reply-To: <20140917031328.089606663@bongo.bofh.it>
References: <20140917031225.559902121@bongo.bofh.it>
	<20140917031328.089606663@bongo.bofh.it>
Date: Sat, 20 Sep 2014 11:20:30 -0300
Message-ID: <CAKi4VAJ5oS2xpfYN-h0OcoVqv2Qs_5Scef7VP=ygzZx7xtVBYg@mail.gmail.com>
Subject: Re: [patch 2/2] Add the man page for kmod(8)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: "Marco d'Itri" <md@linux.it>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Sep 17, 2014 at 12:12 AM, Marco d'Itri <md@linux.it> wrote:
> --- /dev/null
> +++ b/man/kmod.xml
> @@ -0,0 +1,126 @@
> +<?xml version='1.0'?>
> +<!--*-nxml-*-->
> +<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML V4.2//EN"
> +        "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd">
> +<refentry id="kmod">
> +  <refentryinfo>
> +    <title>kmod</title>
> +    <productname>kmod</productname>
> +
> +    <authorgroup>
> +      <author>
> +        <contrib>Developer</contrib>
> +        <firstname>Jon</firstname>
> +        <surname>Masters</surname>
> +        <email>jcm@jonmasters.org</email>
> +      </author>

I can't see how he could be an author of the kmod tool.

For other tools, it's ok since they have the same (or similar)
interface as module-init-tools. But not for this one.

[ ... ]

> +  <refsect1>
> +    <title>COPYRIGHT</title>
> +    <para>
> +      This manual page originally Copyright 2014, Marco d'Itri.
> +      Maintained by Jon Masters and others.

He's not maintaining this.


-- 

Lucas De Marchi
