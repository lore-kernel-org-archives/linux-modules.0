Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <CAKi4VA+gdJjYgQcvykTF70AH1YvqA=EmT4xZPZgjRz5mXww4zw@mail.gmail.com>
References: <CALCETrXs6o0t5hJutE-uz4a7q8eGqRuhCXwJwbog4B606P0+pw@mail.gmail.com>
 <2dfe2833a247d602a0038d28a3636a6d74bd1845.1393620082.git.luto@amacapital.net> <CAKi4VA+gdJjYgQcvykTF70AH1YvqA=EmT4xZPZgjRz5mXww4zw@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 29 Apr 2014 11:48:34 -0700
Message-ID: <CALCETrVdDuqvLO5yPtH0om-LjDV3sD3AYoP7qrp2OJ2kMdn1Lw@mail.gmail.com>
Subject: Re: [PATCH] Add --moddir to depmod and modprobe to override the
 target directory
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a11336a8e36003104f832e2d8
List-ID: <linux-modules.vger.kernel.org>

--001a11336a8e36003104f832e2d8
Content-Type: text/plain; charset=UTF-8

On Apr 29, 2014 5:33 AM, "Lucas De Marchi" <lucas.de.marchi@gmail.com>
wrote:
>
> Hi Andy,
>
> sorry for taking so long to reply
>
> On Fri, Feb 28, 2014 at 5:43 PM, Andy Lutomirski <luto@amacapital.net>
wrote:
> > Currently, depmod and modprobe can only use directories of the form
> > ROOT/lib/modules/VERSION, where ROOT and VERSION can be specified on
> > the command line.  Additionally, when used with explicitly-listed
> > modules depmod requires absolute paths, making it difficult to
> > generate a nonstandard module layout without symlink hacks and
> > absolute paths.
> >
> > This lifts both restrictions with a new --moddir option.  --moddir
> > specifies an exact directory name and, when --moddir is used, depmod
> > will accept relative module paths on the command line.
> >
> > Signed-off-by: Andy Lutomirski <luto@amacapital.net>
> > ---
>
> First the reasoning why we still don't have something like this:
>
> I was trying to avoid adding new options to modprobe/depmod. My hope
> was to finish the tool interface so they could share command options.
> It's already a mess between modprobe and depmod (--dirname vs
> --basedir, -S vs positional arg).
>
> And now a new option... incompatible with the previous 2 to operate in
> the same string.
>
> However I realize the usefulness of this option. It's intended for
> people developing modules, right? So you don't have to install it and
> can run depmod/modprobe on the local dir. What if you depend on
> another module? That dependency won't be satisfied and you will need
> to start copying other modules to your "staging" dir. Is this really
> the use-case? I can't imagine another one.
>

Here are a couple use cases:

1.  The current parameters are awkwardly magical.  See the "3.0" screwup.
The new parameter would have helped.

2. Staging modules, as you said.  Admittedly, one can stage modules in a
directory called lib/modules/version.

3. I want to do a lightweight module install from a kernel build tree.
That module install will be consumed by QEMU.  Using a directory called
lib/modules/version will require lying about the version or cleaning up
stale directories.

4. Current behavior is annoying wrt absolute paths.  IIRC I tried just
changing the computed pathname, but it resulted in unfortunate paths being
written into modules.dep.  Let me see if I can reproduce the exact issue.


Re: #4, it may make sense to fix it separately, but with this patch, I
tried to take the approach of not changing behavior at all for existing
users.


--Andy

--001a11336a8e36003104f832e2d8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p dir=3D"ltr"><br>
On Apr 29, 2014 5:33 AM, &quot;Lucas De Marchi&quot; &lt;<a href=3D"mailto:=
lucas.de.marchi@gmail.com" target=3D"_blank">lucas.de.marchi@gmail.com</a>&=
gt; wrote:<br>
&gt;<br>
&gt; Hi Andy,<br>
&gt;<br>
&gt; sorry for taking so long to reply<br>
&gt;<br>
&gt; On Fri, Feb 28, 2014 at 5:43 PM, Andy Lutomirski &lt;<a href=3D"mailto=
:luto@amacapital.net" target=3D"_blank">luto@amacapital.net</a>&gt; wrote:<=
br>
&gt; &gt; Currently, depmod and modprobe can only use directories of the fo=
rm<br>
&gt; &gt; ROOT/lib/modules/VERSION, where ROOT and VERSION can be specified=
 on<br>
&gt; &gt; the command line. =C2=A0Additionally, when used with explicitly-l=
isted<br>
&gt; &gt; modules depmod requires absolute paths, making it difficult to<br=
>
&gt; &gt; generate a nonstandard module layout without symlink hacks and<br=
>
&gt; &gt; absolute paths.<br>
&gt; &gt;<br>
&gt; &gt; This lifts both restrictions with a new --moddir option. =C2=A0--=
moddir<br>
&gt; &gt; specifies an exact directory name and, when --moddir is used, dep=
mod<br>
&gt; &gt; will accept relative module paths on the command line.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Andy Lutomirski &lt;<a href=3D"mailto:luto@amacapi=
tal.net" target=3D"_blank">luto@amacapital.net</a>&gt;<br>
&gt; &gt; ---<br>
&gt;<br>
&gt; First the reasoning why we still don&#39;t have something like this:<b=
r>
&gt;<br>
&gt; I was trying to avoid adding new options to modprobe/depmod. My hope<b=
r>
&gt; was to finish the tool interface so they could share command options.<=
br>
&gt; It&#39;s already a mess between modprobe and depmod (--dirname vs<br>
&gt; --basedir, -S vs positional arg).<br>
&gt;<br>
&gt; And now a new option... incompatible with the previous 2 to operate in=
<br>
&gt; the same string.<br>
&gt;<br>
&gt; However I realize the usefulness of this option. It&#39;s intended for=
<br>
&gt; people developing modules, right? So you don&#39;t have to install it =
and<br>
&gt; can run depmod/modprobe on the local dir. What if you depend on<br>
&gt; another module? That dependency won&#39;t be satisfied and you will ne=
ed<br>
&gt; to start copying other modules to your &quot;staging&quot; dir. Is thi=
s really<br>
&gt; the use-case? I can&#39;t imagine another one.<br>
&gt;</p>
<p dir=3D"ltr">Here are a couple use cases:</p>
<p dir=3D"ltr">1.=C2=A0 The current parameters are awkwardly magical.=C2=A0=
 See the &quot;3.0&quot; screwup.=C2=A0 The new parameter would have helped=
.</p>
<p dir=3D"ltr">2. Staging modules, as you said.=C2=A0 Admittedly, one can s=
tage modules in a directory called lib/modules/version.</p>
<p dir=3D"ltr">3. I want to do a lightweight module install from a kernel b=
uild tree.=C2=A0 That module install will be consumed by QEMU.=C2=A0 Using =
a directory called lib/modules/version will require lying about the version=
 or cleaning up stale directories.</p>



<p dir=3D"ltr">4. Current behavior is annoying wrt absolute paths.=C2=A0 II=
RC I tried just changing the computed pathname, but it resulted in unfortun=
ate paths being written into modules.dep.=C2=A0 Let me see if I can reprodu=
ce the exact issue.</p>

<p dir=3D"ltr"><br></p><p>Re: #4, it may make sense to fix it separately, b=
ut with this patch, I tried to take the approach of not changing behavior a=
t all for existing users.</p><p><br></p><p>--Andy<br></p><p dir=3D"ltr"><br=
>


</p>
</div>

--001a11336a8e36003104f832e2d8--
