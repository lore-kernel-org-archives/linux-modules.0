MIME-Version: 1.0
In-Reply-To: <52F539D1.3010204@ubuntu.com>
References: <52F539D1.3010204@ubuntu.com>
Date: Fri, 7 Feb 2014 18:13:59 -0200
Message-ID: <CAKi4VA+aqzFZ=AJyiXV3sF+K705ssT_sC0DwY1=Fd6-e3=-9uA@mail.gmail.com>
Subject: Re: kmod has no man page
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Philip,


On Fri, Feb 7, 2014 at 5:53 PM, Phillip Susi <psusi@ubuntu.com> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> There is no man page for kmod.  Rather than add one, I would suggest
> simply eliminating this apparently useless binary ( the only thing it
> seems to let you do is lsmod ) and replace the symlinks of the actual
> commands with hard links.

It's only *apparently* useless. If you use a more recent version of kmod you
will see there's at least static-nodes command, that is not available otherwise.

The plan has always been to create sane commands in the kmod tool
(like kmod insert, kmod info, kmod remove, etc) and let the symlinks
for when the compat behavior is expected.

Right now this is only half done, but removing it like you suggest is
not an option.


Lucas De Marchi
