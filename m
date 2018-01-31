Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Ferry van Steen <Ferry.van.Steen@citrus.nl>,  "jcm\@jonmasters.org" <jcm@jonmasters.org>,  David Howells <dhowells@redhat.com>,  linux-modules <linux-modules@vger.kernel.org>
Subject: Re: modinfo shows md4 signature instead of sha256
References: <093e06b77d7e44af8b9597f1a3701fa7@citrus.nl>
	<CAKi4VAKF5YCa8e2a1kEJU5MgecKWOdcPK94vWTgEzRM2j6CqYA@mail.gmail.com>
	<CAKi4VALzjGadjp1nHNUme65KsOcOpr=Xm5PzvWyZSaeK4cFbJw@mail.gmail.com>
Date: Wed, 31 Jan 2018 22:39:42 +0200
In-Reply-To: <CAKi4VALzjGadjp1nHNUme65KsOcOpr=Xm5PzvWyZSaeK4cFbJw@mail.gmail.com>
	(Lucas De Marchi's message of "Wed, 31 Jan 2018 09:40:47 -0800")
Message-ID: <xuny4ln1iwz5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

This is a better bugreport
https://bugzilla.redhat.com/show_bug.cgi?id=1320921 

I have a proof of concept realization of PKCS#7 parser based on the kernel
code, but haven't synced the further work with David yet.

>>>>> On Wed, 31 Jan 2018 09:40:47 -0800, Lucas De Marchi  wrote:

 > Now really CC Yauheni.
 > On Wed, Jan 31, 2018 at 9:39 AM, Lucas De Marchi
 > <lucas.de.marchi@gmail.com> wrote:
 >> Hi Ferry,
 >> 
 >> CC'ing mailing list and Yauheni who worked on fixing modinfo output in
 >> the last release.
 >> 
 >> 
 >> On Wed, Jan 31, 2018 at 1:23 AM, Ferry van Steen
 >> <Ferry.van.Steen@citrus.nl> wrote:
 >>> Hi,
 >>> 
 >>> 
 >>> sorry, not sure where to file this. There seems to be a bug in either the
 >>> kernel signing modules with a wrong signature algorithm, or modinfo is
 >>> reporting it incorrectly. I presume it's the latter.
 >>> 
 >>> 
 >>> More details are here: https://bugzilla.redhat.com/show_bug.cgi?id=1490975
 >> 
 >> Not showing the output on older versions is a known issue: support for
 >> PKCS#7 sig type was
 >> only added to kmod in v23.
 >> 
 >> Now for the incorrect info, the problem appears to be in the kernel
 >> implementation:
 >> it appends a PKCS#7, but doens't fill out the struct module_signature
 >> correctly. So in F27 I get this from, e.g.
 >> soundcore.ko:
 >> 
 >> $ xxd -c 8 -g 1 mod.ko | tail -n6
 >> 00004d80: b9 d5 04 00 00 02 00 00  ........   <<<<<<
 >> 00004d88: 00 00 00 00 00 02 d3 7e  .......~
 >> 00004d90: 4d 6f 64 75 6c 65 20 73  Module s
 >> 00004d98: 69 67 6e 61 74 75 72 65  ignature
 >> 00004da0: 20 61 70 70 65 6e 64 65   appende
 >> 00004da8: 64 7e 0a                 d~.
 >> 
 >> See line marked above. It should match a struct module_signature. So:
 >> id_type == 0x2 // PKCS7
 >> hash == 0 // md4
 >> algo == 0 // dsa
 >> 
 >> Looking at scripts/sign-file.c, indeed id_type is the only field that
 >> is filled out.
 >> CC'ing  David Howells as well. Any input here?
 >> 
 >> Lucas De Marchi
 >> 
 >>> 
 >>> 
 >>> Thanks in advance and kind regards,
 >>> 
 >>> 
 >>> Ferry van Steen
 >>> Linux Developer
 >>> Ferry.van.Steen@Citrus.nl
 >>> 
 >>> Citrus Software
 >>> ●  Almystraat 10A
 >>> ●  5061 PA Oisterwijk
 >>> ●  +31 (0)13 - 529 91 55
 >>> ●  www.citrus.nl
 >>> ______________________________________________________
 >>> 
 >>> This message may contain confidential or privileged information. If you are
 >>> not the addressee, please notify the sender and delete it from your files.
 >>> Please consider the environmental impact before printing this e-mail.
 >>> 
 >> 
 >> 
 >> 
 >> --
 >> Lucas De Marchi



 > -- 
 > Lucas De Marchi

-- 
WBR,
Yauheni Kaliuta
