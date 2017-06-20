Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCHv2 0/4] depmod: implement external directories support
References: <CAKi4VALJgW=RbpCT4kfix9sACzzz68=LZ-FhUUORXxHMcTA__g@mail.gmail.com>
	<20170509190924.9087-1-yauheni.kaliuta@redhat.com>
Date: Tue, 20 Jun 2017 12:11:50 +0300
In-Reply-To: <20170509190924.9087-1-yauheni.kaliuta@redhat.com> (Yauheni
	Kaliuta's message of "Tue, 9 May 2017 22:09:20 +0300")
Message-ID: <xunyzid3f2g9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Hi!

>>>>> On Tue,  9 May 2017 22:09:20 +0300, Yauheni Kaliuta  wrote:

 > This is a pretty simple extention of existing logic, since now
 > depmod already is able to:

 > a) scan modules with full path from command line without -a
 > switch;
 > b) detects broken symbol dependencies and broken modversions,
 > what assumes, that modules are already are not built for the
 > existing kernel.

[...]


I've heared a concern about the feature, that it may make sense to limit
the possible external directories to some subdirectory(s). The idea is that
3rd party vendor packages can pollute filesystem with its modules and a
system administrator may like to be sure that they are in a more defined
place.

What do you think?

Of course, it is not security concern, just about unintentional
pollution. If there is the intention, in most cases from the package
maintainer scipts it's possible to install symbolic link under the
permitted directory, for example, with the file anywere.

-- 
WBR,
Yauheni Kaliuta
