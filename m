Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCHv2 0/4] depmod: implement external directories support
References: <CAKi4VALJgW=RbpCT4kfix9sACzzz68=LZ-FhUUORXxHMcTA__g@mail.gmail.com>
	<20170509190924.9087-1-yauheni.kaliuta@redhat.com>
	<xunyzid3f2g9.fsf@redhat.com>
	<CAKi4VA+PMniY-4W2J5pQkcZ=6ZRCLWQAWLJHwX8642S8025nSQ@mail.gmail.com>
Date: Wed, 19 Jul 2017 21:57:49 +0300
In-Reply-To: <CAKi4VA+PMniY-4W2J5pQkcZ=6ZRCLWQAWLJHwX8642S8025nSQ@mail.gmail.com>
	(Lucas De Marchi's message of "Wed, 19 Jul 2017 11:07:11 -0700")
Message-ID: <xunyo9sgqmoi.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

>>>>> On Wed, 19 Jul 2017 11:07:11 -0700, Lucas De Marchi  wrote:

 > On Tue, Jun 20, 2017 at 2:11 AM, Yauheni Kaliuta
 > <yauheni.kaliuta@redhat.com> wrote:
 >> Hi!
 >> 
 >>>>>>> On Tue,  9 May 2017 22:09:20 +0300, Yauheni Kaliuta  wrote:
 >> 
 >> > This is a pretty simple extention of existing logic, since now
 >> > depmod already is able to:
 >> 
 >> > a) scan modules with full path from command line without -a
 >> > switch;
 >> > b) detects broken symbol dependencies and broken modversions,
 >> > what assumes, that modules are already are not built for the
 >> > existing kernel.
 >> 
 >> [...]
 >> 
 >> 
 >> I've heared a concern about the feature, that it may make sense to limit
 >> the possible external directories to some subdirectory(s). The idea is that
 >> 3rd party vendor packages can pollute filesystem with its modules and a
 >> system administrator may like to be sure that they are in a more defined
 >> place.
 >> 
 >> What do you think?

 > Humn... doesn't that completely defeats the purpose of using it for
 > development?

 > That just reminded me we missed the changes to the man page. Could you
 > take care of that?

Oh yes, sure. Just may be after vacations (next two weeks).

 >> Of course, it is not security concern, just about unintentional
 >> pollution. If there is the intention, in most cases from the package
 >> maintainer scipts it's possible to install symbolic link under the
 >> permitted directory, for example, with the file anywere.

 > Not sure if kmod is the right place to restrict the directories.
 > Maybe it's a distro policy thing?

I think the same. But it is about 3rd party modules.

 > What would you restrict it to?

I was thinking about that a bit.

What if I implement some configuration keyword, "restrict_external" for
example, with a directory prefix (up to the distribution, /lib/modules or
whatever) which is impossible then to override (by the additional configs
from the 3rd party module package) and if depmod finds such external
configuration, it ignores it with a warning?

-- 
WBR,
Yauheni Kaliuta
