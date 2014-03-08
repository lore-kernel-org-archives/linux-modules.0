Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <2dfe2833a247d602a0038d28a3636a6d74bd1845.1393620082.git.luto@amacapital.net>
References: <CALCETrXs6o0t5hJutE-uz4a7q8eGqRuhCXwJwbog4B606P0+pw@mail.gmail.com>
 <2dfe2833a247d602a0038d28a3636a6d74bd1845.1393620082.git.luto@amacapital.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 8 Mar 2014 11:47:58 -0800
Message-ID: <CALCETrWrT1MniF=EHSfKw2QU5FOqQfXsSF4CxA5N=XcLOFd0Hg@mail.gmail.com>
Subject: Re: [PATCH] Add --moddir to depmod and modprobe to override the
 target directory
To: linux-modules <linux-modules@vger.kernel.org>,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-modules.vger.kernel.org>

On Fri, Feb 28, 2014 at 12:43 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> Currently, depmod and modprobe can only use directories of the form
> ROOT/lib/modules/VERSION, where ROOT and VERSION can be specified on
> the command line.  Additionally, when used with explicitly-listed
> modules depmod requires absolute paths, making it difficult to
> generate a nonstandard module layout without symlink hacks and
> absolute paths.
>
> This lifts both restrictions with a new --moddir option.  --moddir
> specifies an exact directory name and, when --moddir is used, depmod
> will accept relative module paths on the command line.

Will an approach like this be okay (possibly with further changes) or
do I need to find some hack to get existing depmod and modprobe
binaries to work?

--Andy
