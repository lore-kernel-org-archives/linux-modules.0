Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <CAKi4VAL7HCm-zxhR6ZH2RqBtv4iEYMbJk6sHWU-2244pBDt7kQ@mail.gmail.com>
References: <CALCETrXtLvaJBvKmrT9jx_fRqVuKO1Xid8_vRoT1Nb+7HOZH2w@mail.gmail.com>
 <CAKi4VAL7HCm-zxhR6ZH2RqBtv4iEYMbJk6sHWU-2244pBDt7kQ@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 28 Feb 2014 12:23:45 -0800
Message-ID: <CALCETrXs6o0t5hJutE-uz4a7q8eGqRuhCXwJwbog4B606P0+pw@mail.gmail.com>
Subject: Re: Making depmod, etc more flexible?
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-modules.vger.kernel.org>

On Fri, Feb 28, 2014 at 10:27 AM, Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
> On Fri, Feb 28, 2014 at 2:33 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> I'm working on virtme
>> (https://git.kernel.org/cgit/utils/kernel/virtme/virtme.git/), a tool
>> to easily test a kernel without a disk image or any need to install
>> that kernel.  I want to have full support for loading modules from a
>> kernel tree, but depmod is getting in the way.
>>
>> What I think I want is a way to generate modules.dep, etc in a
>> subdirectory of the kernel build directory.  The hierarchy needs to be
>> such that:
>>
>>  - modprobe --show-depends would work.
>>  - I could symlink and/or bind-mount things into /lib/modules so that
>> modprobe, udev, etc all work.
>>
>> One approach that should work:
>>
>> .tmp_moddep/build: a symlink to '..'
>> .tmp_moddep/modules.dep, etc: the usual, with module paths that point
>> into build/
>>
>> The problem is that getting depmod to generate anything remotely like
>> this is basically impossible.
>>
>> Here are two changes to depmod that would, I think, make this possible:
>>
>> 1. Add --moddir, an option to specify the target directory directly.
>> That is, if --moddir is used, then -b would be illegal, the kernel
>> version could not be specified, and cfg.dirname would be set to the
>> argument of --moddir, literally.
>>
>> 2. Allow relative paths to modules on the command line.  Such paths
>> would be interpreted relative to cfg.dirname.  (That would probably be
>> easiest if depmod would chdir into cfg.dirname.)
>>
>> To finish the job, modprobe would need a --moddir argument as well.
>>
>> Thoughts?  Is there a different approach I should be taking here?
>
> Did you already take a look in the testsuite? We can execute modprobe
> and depmod there.
> Would that approach be feasible for you?

I don't think so.  I could make a silly hierarchy like
build_dir/lib/modules/version/whatever, but populating it is a PITA --
there's no good way to specify explicit *relative* paths.  I'll follow
up with a patch.

>
> Lucas De Marchi



-- 
Andy Lutomirski
AMA Capital Management, LLC
