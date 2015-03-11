Return-Path: <jdub@bethesignal.org>
MIME-Version: 1.0
In-Reply-To: <CAKi4VAKfYP8uYuXb6kwULikjySq7ZD-nBK+1i2-AfK1ARCaJdQ@mail.gmail.com>
References: <20150305210547.GA24297@ubuntu>
	<CAKi4VAKfYP8uYuXb6kwULikjySq7ZD-nBK+1i2-AfK1ARCaJdQ@mail.gmail.com>
Date: Wed, 11 Mar 2015 11:26:20 +1100
Message-ID: <CAGAEFzKwX4DgpEOy+81USM3vogHwM28v8mTy+kKHL4YKz1nKUQ@mail.gmail.com>
Subject: Re: [PATCH] build: generate libkmod.pc during autoconf
From: Jeff Waugh <jdub@bethesignal.org>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a113eeca8009dd10510f85188
List-ID: <linux-modules.vger.kernel.org>

--001a113eeca8009dd10510f85188
Content-Type: text/plain; charset=UTF-8

Hi Lucas,

On Wed, Mar 11, 2015 at 4:04 AM, Lucas De Marchi <lucas.de.marchi@gmail.com>
wrote:

> what exactly are you solving here? What's the problem with doing it
> during make not during configure?
>

It certainly affects cross-compiling. Possibly other stuff.


Here's the relevant part of libkmod.pc when produced during make:

prefix=/usr
exec_prefix=/usr
libdir=/usr/lib
includedir=/usr/include


And during configure:

prefix=/usr
exec_prefix=/usr
libdir=${exec_prefix}/lib
includedir=${prefix}/include



> > like other packages do. (Patch from OpenWrt's contributed packages
> project.)
>
> others do like we do, too:
>
> https://git.kernel.org/cgit/linux/kernel/git/kay/libabc.git/tree/Makefile.am
> http://cgit.freedesktop.org/systemd/systemd/tree/Makefile.am
>
> should they be changed, too?
>

Yes! I was just about to send a fix for systemd, as that burned me too. :-)

(If you check any of the libraries on git.gnome.org, their pkg-config files
are generated during configure.)

Thanks,
Jeff

--001a113eeca8009dd10510f85188
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">Hi L=
ucas,</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">=
On Wed, Mar 11, 2015 at 4:04 AM, Lucas De Marchi <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:lucas.de.marchi@gmail.com" target=3D"_blank">lucas.de.marchi@=
gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex">what exactly are you s=
olving here? What&#39;s the problem with doing it<br>
during make not during configure?<br></blockquote><div><br></div><div>It ce=
rtainly affects cross-compiling. Possibly other stuff.</div><div><br></div>=
<div><br></div><div>Here&#39;s the relevant part of libkmod.pc when produce=
d during make:</div><div><br></div><div><div>prefix=3D/usr</div><div>exec_p=
refix=3D/usr</div><div>libdir=3D/usr/lib</div><div>includedir=3D/usr/includ=
e</div><div><br></div></div><div><br></div><div>And during configure:</div>=
<div><br></div><div><div>prefix=3D/usr</div><div>exec_prefix=3D/usr</div><d=
iv>libdir=3D${exec_prefix}/lib</div><div>includedir=3D${prefix}/include</di=
v><div><br></div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rg=
b(204,204,204);border-left-style:solid;padding-left:1ex"><span class=3D"">&=
gt; like other packages do. (Patch from OpenWrt&#39;s contributed packages =
project.)<br>
<br>
</span>others do like we do, too:<br>
<a href=3D"https://git.kernel.org/cgit/linux/kernel/git/kay/libabc.git/tree=
/Makefile.am" target=3D"_blank">https://git.kernel.org/cgit/linux/kernel/gi=
t/kay/libabc.git/tree/Makefile.am</a><br>
<a href=3D"http://cgit.freedesktop.org/systemd/systemd/tree/Makefile.am" ta=
rget=3D"_blank">http://cgit.freedesktop.org/systemd/systemd/tree/Makefile.a=
m</a><br>
<br>
should they be changed, too?<br></blockquote></div><br></div><div class=3D"=
gmail_extra">Yes! I was just about to send a fix for systemd, as that burne=
d me too. :-)</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail=
_extra">(If you check any of the libraries on <a href=3D"http://git.gnome.o=
rg">git.gnome.org</a>, their pkg-config files are generated during configur=
e.)</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Th=
anks,</div><div class=3D"gmail_extra">Jeff</div></div>

--001a113eeca8009dd10510f85188--
