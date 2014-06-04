Return-Path: <gael.cadic@free.fr>
Date: Wed, 4 Jun 2014 21:31:45 +0200 (CEST)
From: gael.cadic@free.fr
To: Dave Reisner <d@falconindy.com>
Cc: linux-modules@vger.kernel.org, jcm@jonmasters.org,
	lucas de marchi <lucas.de.marchi@gmail.com>
Message-ID: <1440260372.30795006.1401910305918.JavaMail.root@zimbra44-e7.priv.proxad.net>
In-Reply-To: <20140604154442.GC27354@rampage>
Subject: Re: graph of modules
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-modules.vger.kernel.org>

Hello,

Interpret lsmod is hard without graphing
I can give you a use for this : data acc=C3=A8s tuning
You can follow data path from fiber card to lvm and so, tune every module t=
imout, retry and so on
every colleague said me automatic graphing is great because it takes time t=
o draw it by hand=20

Best regards

----- Mail original -----
De: "Dave Reisner" <d@falconindy.com>
=C3=80: "gael cadic" <gael.cadic@free.fr>
Cc: linux-modules@vger.kernel.org, jcm@jonmasters.org, "lucas de marchi" <l=
ucas.de.marchi@gmail.com>
Envoy=C3=A9: Mercredi 4 Juin 2014 17:44:42
Objet: Re: graph of modules

On Wed, Jun 04, 2014 at 05:39:04PM +0200, gael.cadic@free.fr wrote:
> Hello,
>=20
> I wrote a bit of Perl to build dynamically the graph of modules' dependen=
ces
>=20
> As sysadmin, I think it would be nice to have it on every Linux

I cobbled together something similar a few years ago:

https://github.com/falconindy/modtree

Since writing it, I can count the number of times I've used such a tool
on one hand. It's neat, but I'm really not sure it provides much value.

Cheers,
d
