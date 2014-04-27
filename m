MIME-Version: 1.0
In-Reply-To: <CAKi4VA+R6TBbgVv1yAjKi0cU=Q+X8zFDQQ0e3hNiQ5meDhsiEg@mail.gmail.com>
References: <53484327.5Nr2aWdyWz5+36kD%matwey.kornilov@gmail.com>
	<CAKi4VALtbKS=wj1KncN+kt+5hRPLDYxzkuDDg-3Cm+wr2mK5JQ@mail.gmail.com>
	<CANkykrBdJ-u-OWWgBZj_Jsghd8oqhC6AtRK7dvs=EGFt7EozMQ@mail.gmail.com>
	<CAKi4VA+R6TBbgVv1yAjKi0cU=Q+X8zFDQQ0e3hNiQ5meDhsiEg@mail.gmail.com>
Date: Sun, 27 Apr 2014 17:04:39 -0300
Message-ID: <CAKi4VAK0=2dLOmoAaNTWW9yxb73ZRH6wFsuVEFXPvO=AL4R0Vw@mail.gmail.com>
Subject: Re: [PATCH] Fix recursion loop in mod_count_all_dependencies()
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Gustavo Barbieri <barbieri@gmail.com>
Cc: matwey.kornilov@gmail.com, linux-modules <linux-modules@vger.kernel.org>
Content-Type: multipart/alternative; boundary=089e0115eada71f62704f80bb535
List-ID: <linux-modules.vger.kernel.org>

--089e0115eada71f62704f80bb535
Content-Type: text/plain; charset=UTF-8

Adding back CC I forgot.
 Em 27/04/2014 12:40, "Lucas De Marchi" <lucas.de.marchi@gmail.com>
escreveu:

>
> Em 27/04/2014 12:30, "Gustavo Sverzut Barbieri" <barbieri@gmail.com>
> escreveu:
> >
> > patch itself is okay, (one minor syntax issue with lack of space
> > between "if" and "(").
> >
> > But I wonder why just fail if we find loops, are those valid? If not,
> > couldn't we fail earlier and ask people to fix it?
>
> I think it would be better to fail early indeed. Just breaking the loop
> and continuing to output the dependencies won't make it work at runtime.
>
> --
> Lucas De Marchi
>

--089e0115eada71f62704f80bb535
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Adding back CC I forgot.<br>
</p>
<div class=3D"gmail_quote">Em 27/04/2014 12:40, &quot;Lucas De Marchi&quot;=
 &lt;<a href=3D"mailto:lucas.de.marchi@gmail.com">lucas.de.marchi@gmail.com=
</a>&gt; escreveu:<br type=3D"attribution"><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<p dir=3D"ltr"><br>
Em 27/04/2014 12:30, &quot;Gustavo Sverzut Barbieri&quot; &lt;<a href=3D"ma=
ilto:barbieri@gmail.com" target=3D"_blank">barbieri@gmail.com</a>&gt; escre=
veu:<br>
&gt;<br>
&gt; patch itself is okay, (one minor syntax issue with lack of space<br>
&gt; between &quot;if&quot; and &quot;(&quot;).<br>
&gt;<br>
&gt; But I wonder why just fail if we find loops, are those valid? If not,<=
br>
&gt; couldn&#39;t we fail earlier and ask people to fix it?</p>
<p dir=3D"ltr">I think it would be better to fail early indeed. Just breaki=
ng the loop and continuing to output the dependencies won&#39;t make it wor=
k at runtime.</p>
<p dir=3D"ltr">--<br>
Lucas De Marchi</p>
</blockquote></div>

--089e0115eada71f62704f80bb535--
