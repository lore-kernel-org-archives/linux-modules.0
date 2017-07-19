MIME-Version: 1.0
In-Reply-To: <xunyzid3f2g9.fsf@redhat.com>
References: <CAKi4VALJgW=RbpCT4kfix9sACzzz68=LZ-FhUUORXxHMcTA__g@mail.gmail.com>
	<20170509190924.9087-1-yauheni.kaliuta@redhat.com>
	<xunyzid3f2g9.fsf@redhat.com>
Date: Wed, 19 Jul 2017 11:07:11 -0700
Message-ID: <CAKi4VA+PMniY-4W2J5pQkcZ=6ZRCLWQAWLJHwX8642S8025nSQ@mail.gmail.com>
Subject: Re: [PATCHv2 0/4] depmod: implement external directories support
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jun 20, 2017 at 2:11 AM, Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
> Hi!
>
>>>>>> On Tue,  9 May 2017 22:09:20 +0300, Yauheni Kaliuta  wrote:
>
>  > This is a pretty simple extention of existing logic, since now
>  > depmod already is able to:
>
>  > a) scan modules with full path from command line without -a
>  > switch;
>  > b) detects broken symbol dependencies and broken modversions,
>  > what assumes, that modules are already are not built for the
>  > existing kernel.
>
> [...]
>
>
> I've heared a concern about the feature, that it may make sense to limit
> the possible external directories to some subdirectory(s). The idea is that
> 3rd party vendor packages can pollute filesystem with its modules and a
> system administrator may like to be sure that they are in a more defined
> place.
>
> What do you think?

Humn... doesn't that completely defeats the purpose of using it for development?

That just reminded me we missed the changes to the man page. Could you
take care of that?

> Of course, it is not security concern, just about unintentional
> pollution. If there is the intention, in most cases from the package
> maintainer scipts it's possible to install symbolic link under the
> permitted directory, for example, with the file anywere.

Not sure if kmod is the right place to restrict the directories.
Maybe it's a distro policy thing?
What would you restrict it to?


-- 
Lucas De Marchi
