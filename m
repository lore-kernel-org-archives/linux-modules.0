MIME-Version: 1.0
In-Reply-To: <20160816005032.28881-1-ab@fmap.me>
References: <20160816005032.28881-1-ab@fmap.me>
Date: Fri, 11 Nov 2016 00:13:28 -0200
Message-ID: <CAKi4VAL4907RvRJFkUiyVEK3Qjd8EqvBus7T7J2pQLaRVm4prg@mail.gmail.com>
Subject: Re: Improvements in search of kernel modules directory
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Nikolay Amiantov <ab@fmap.me>
Cc: linux-modules <linux-modules@vger.kernel.org>, Shea Levy <shea@shealevy.com>
Content-Type: multipart/alternative; boundary=001a1148962a2940890540fd09ac
List-ID: <linux-modules.vger.kernel.org>

--001a1148962a2940890540fd09ac
Content-Type: text/plain; charset=UTF-8

Hi Nikolay,

I'm very sorry to miss these patches and not give an answer soon...
I totally forgot about them. I'll take a look this week.

Lucas De Marchi

On Mon, Aug 15, 2016 at 9:50 PM, Nikolay Amiantov <ab@fmap.me> wrote:

> These series of patches add more control over how kernel modules directory
> is
> found:
>
> * Add an environment variable which allows to override kernel modules
>   directory;
> * Allow to hardcode several paths which are searched in order for `uname
> -r`
>   subdirectory;
> * Add a configure option to set those paths, instead of hardcoding
>   /lib/modules.
>
> We have used the first patch in NixOS[1] for a long time to point kmod to
> kernel modules. While an environment variable is handy and has been
> solving our
> problems, it doesn't cover all our cases. We have two directories:
>
> * /run/current-system/kernel-modules/lib/modules
> * /run/booted-system/kernel-modules/lib/modules
>
> , which are symlinked to modules for current system configuration (i.e.
> after
> an update) and the one which the system was booted with. It allows us to
> both
> give users ability to install new modules and have their old kernel modules
> accessible until a reboot (which is useful in case of kernel upgrade).
>
> Before those patches the necessary logic (see if kernel modules for current
> kernel version are available in current-system, if not then fall back to
> booted-system) was implemented as a shell wrapper around kmod, which was
> unwieldy and didn't work for applications that use kmod directly. It was
> considered better to move this logic to kmod itself. Also, NixOS uses
> nixpkgs,
> a set of distribution-agnostic packages (which run on e.g. Ubuntu and even
> Mac
> OS X where applicable), so it was necessary to preserve /lib/modules as a
> fallback directory in kmod for it to work on FHS distributions.
>
> As a result a set of generic patches was written that implement necessary
> behaviour while being potentially useful for upstream. Environment
> variable is
> still used in several places (e.g. in automatic generation and running of
> virtual machines) and is useful for us even with the rest of those patches.
>
> A home of those patches can be found on GitHub[2] along with some
> discussion, as can be related NixOS patches and discussion[3].
>
> Big thanks to Shea Levy for the original patch, extensive code review and
> useful advices.
>
> Additionally, while working on those it was discovered that kmod makes use
> of
> PATH_MAX. This constant is considered harmful[4] because it doesn't
> correspond
> to real possible length of filesystem paths. This can be considered a bug,
> but
> in those patches it was decided to follow upstream design decisions
> wherever
> possible and so we also use it here.
>
> [1]: http://nixos.org/
> [2]: https://github.com/abbradar/kmod/
> [3]: https://github.com/NixOS/nixpkgs/pull/17738/
> [4]: http://insanecoding.blogspot.ru/2007/11/pathmax-simply-isnt.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-modules" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Lucas De Marchi

--001a1148962a2940890540fd09ac
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Nikolay,<div><br></div><div>I&#39;m very sorry to miss =
these patches and not give an answer soon...=C2=A0</div><div>I totally forg=
ot about them. I&#39;ll take a look this week.</div><div><br></div><div>Luc=
as De Marchi</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"=
>On Mon, Aug 15, 2016 at 9:50 PM, Nikolay Amiantov <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:ab@fmap.me" target=3D"_blank">ab@fmap.me</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">These series of patches add more cont=
rol over how kernel modules directory is<br>
found:<br>
<br>
* Add an environment variable which allows to override kernel modules<br>
=C2=A0 directory;<br>
* Allow to hardcode several paths which are searched in order for `uname -r=
`<br>
=C2=A0 subdirectory;<br>
* Add a configure option to set those paths, instead of hardcoding<br>
=C2=A0 /lib/modules.<br>
<br>
We have used the first patch in NixOS[1] for a long time to point kmod to<b=
r>
kernel modules. While an environment variable is handy and has been solving=
 our<br>
problems, it doesn&#39;t cover all our cases. We have two directories:<br>
<br>
* /run/current-system/kernel-<wbr>modules/lib/modules<br>
* /run/booted-system/kernel-<wbr>modules/lib/modules<br>
<br>
, which are symlinked to modules for current system configuration (i.e. aft=
er<br>
an update) and the one which the system was booted with. It allows us to bo=
th<br>
give users ability to install new modules and have their old kernel modules=
<br>
accessible until a reboot (which is useful in case of kernel upgrade).<br>
<br>
Before those patches the necessary logic (see if kernel modules for current=
<br>
kernel version are available in current-system, if not then fall back to<br=
>
booted-system) was implemented as a shell wrapper around kmod, which was<br=
>
unwieldy and didn&#39;t work for applications that use kmod directly. It wa=
s<br>
considered better to move this logic to kmod itself. Also, NixOS uses nixpk=
gs,<br>
a set of distribution-agnostic packages (which run on e.g. Ubuntu and even =
Mac<br>
OS X where applicable), so it was necessary to preserve /lib/modules as a<b=
r>
fallback directory in kmod for it to work on FHS distributions.<br>
<br>
As a result a set of generic patches was written that implement necessary<b=
r>
behaviour while being potentially useful for upstream. Environment variable=
 is<br>
still used in several places (e.g. in automatic generation and running of<b=
r>
virtual machines) and is useful for us even with the rest of those patches.=
<br>
<br>
A home of those patches can be found on GitHub[2] along with some<br>
discussion, as can be related NixOS patches and discussion[3].<br>
<br>
Big thanks to Shea Levy for the original patch, extensive code review and<b=
r>
useful advices.<br>
<br>
Additionally, while working on those it was discovered that kmod makes use =
of<br>
PATH_MAX. This constant is considered harmful[4] because it doesn&#39;t cor=
respond<br>
to real possible length of filesystem paths. This can be considered a bug, =
but<br>
in those patches it was decided to follow upstream design decisions whereve=
r<br>
possible and so we also use it here.<br>
<br>
[1]: <a href=3D"http://nixos.org/" rel=3D"noreferrer" target=3D"_blank">htt=
p://nixos.org/</a><br>
[2]: <a href=3D"https://github.com/abbradar/kmod/" rel=3D"noreferrer" targe=
t=3D"_blank">https://github.com/abbradar/<wbr>kmod/</a><br>
[3]: <a href=3D"https://github.com/NixOS/nixpkgs/pull/17738/" rel=3D"norefe=
rrer" target=3D"_blank">https://github.com/NixOS/<wbr>nixpkgs/pull/17738/</=
a><br>
[4]: <a href=3D"http://insanecoding.blogspot.ru/2007/11/pathmax-simply-isnt=
.html" rel=3D"noreferrer" target=3D"_blank">http://insanecoding.blogspot.<w=
br>ru/2007/11/pathmax-simply-<wbr>isnt.html</a><br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-module=
s&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<wbr>m=
ajordomo-info.html</a><br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature">Lucas De Marchi</di=
v>
</div></div>

--001a1148962a2940890540fd09ac--
