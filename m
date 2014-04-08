Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <CALCETrWrT1MniF=EHSfKw2QU5FOqQfXsSF4CxA5N=XcLOFd0Hg@mail.gmail.com>
References: <CALCETrXs6o0t5hJutE-uz4a7q8eGqRuhCXwJwbog4B606P0+pw@mail.gmail.com>
 <2dfe2833a247d602a0038d28a3636a6d74bd1845.1393620082.git.luto@amacapital.net> <CALCETrWrT1MniF=EHSfKw2QU5FOqQfXsSF4CxA5N=XcLOFd0Hg@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 8 Apr 2014 12:37:23 -0700
Message-ID: <CALCETrXL3Lq_2-tQq3nBQfWqcMwLhi_zqNEnKA3EgSFVqu20QQ@mail.gmail.com>
Subject: Re: [PATCH] Add --moddir to depmod and modprobe to override the
 target directory
To: linux-modules <linux-modules@vger.kernel.org>,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-modules.vger.kernel.org>

On Sat, Mar 8, 2014 at 11:47 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Fri, Feb 28, 2014 at 12:43 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> Currently, depmod and modprobe can only use directories of the form
>> ROOT/lib/modules/VERSION, where ROOT and VERSION can be specified on
>> the command line.  Additionally, when used with explicitly-listed
>> modules depmod requires absolute paths, making it difficult to
>> generate a nonstandard module layout without symlink hacks and
>> absolute paths.
>>
>> This lifts both restrictions with a new --moddir option.  --moddir
>> specifies an exact directory name and, when --moddir is used, depmod
>> will accept relative module paths on the command line.
>
> Will an approach like this be okay (possibly with further changes) or
> do I need to find some hack to get existing depmod and modprobe
> binaries to work?
>

Hi-

A quick ping on this, now that kmod 17 is out :)

Thanks,
Andy
