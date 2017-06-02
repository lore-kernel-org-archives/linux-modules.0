MIME-Version: 1.0
In-Reply-To: <20170509190924.9087-4-yauheni.kaliuta@redhat.com>
References: <CAKi4VALJgW=RbpCT4kfix9sACzzz68=LZ-FhUUORXxHMcTA__g@mail.gmail.com>
	<20170509190924.9087-1-yauheni.kaliuta@redhat.com>
	<20170509190924.9087-4-yauheni.kaliuta@redhat.com>
Date: Thu, 1 Jun 2017 20:30:50 -0700
Message-ID: <CAKi4VAKfwQ_NLauA181mDNHYGj-PhnwMYMBvoiVRpnNPpbOjPw@mail.gmail.com>
Subject: Re: [PATCHv2 3/4] depmod: implement external directories support
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Tue, May 9, 2017 at 12:09 PM, Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
> The idea is to add a configuration keyword, external, which
> will list directories for scanning for particular kernel version
> mask:
>
> external 4.10 /the/modules/dir /second/modules/dir
>
> And extend "search" keyword to set it's priority with pseudo dir
> "external" (as it's done for built-in):
>
> search subdir external subdir2 built-in subdir3
>
> (actually, the version is the same as for override keyword: * or
> posix regexp, so example above is a bit incorrect).
>
> All other logic left the same: if there are duplicates, only one
> is under consideration and it is unloadable if it is bad.
>
> The resulting modules.dep will contain entries a-la:
>
> /the/modules/dir/module1.ko:
> kernel/module2.ko: /the/modules/dir/module1.ko
>
> (here /lib/modules/$(uname -r)/kernel/module2.ko depends of
> symbols, provided by /the/modules/dir/module1.ko and external has
> higher priority).
>
> modprobe and modinfo understand it out of box.
>
> This is a pretty simple extention of existing logic, since now
> depmod already is able to:
>
> a) scan modules with full path from command line without -a
> switch;
> b) detects broken symbol dependencies and broken modversions,
> what assumes, that modules are already are not built for the
> existing kernel.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---


Thanks, applied!

Lucas De Marchi
