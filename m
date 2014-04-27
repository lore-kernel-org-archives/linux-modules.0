Return-Path: <matwey.kornilov@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANkykrBdJ-u-OWWgBZj_Jsghd8oqhC6AtRK7dvs=EGFt7EozMQ@mail.gmail.com>
References: <53484327.5Nr2aWdyWz5+36kD%matwey.kornilov@gmail.com>
	<CAKi4VALtbKS=wj1KncN+kt+5hRPLDYxzkuDDg-3Cm+wr2mK5JQ@mail.gmail.com>
	<CANkykrBdJ-u-OWWgBZj_Jsghd8oqhC6AtRK7dvs=EGFt7EozMQ@mail.gmail.com>
Date: Sun, 27 Apr 2014 23:44:54 +0400
Message-ID: <CAJs94EZbVaS=N0xpAQbAySBzX_e6JR1o8FJkrJ0f4buCWvsZSA@mail.gmail.com>
Subject: Re: [PATCH] Fix recursion loop in mod_count_all_dependencies()
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
To: Gustavo Sverzut Barbieri <barbieri@gmail.com>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	linux-modules <linux-modules@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a113467fcd3c55e04f80b6e74
List-ID: <linux-modules.vger.kernel.org>

--001a113467fcd3c55e04f80b6e74
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: quoted-printable

Can't answer the question. Looking the code, mod_count_all_dependencies has
to be fixed in that way. The code, running before and after, is
loop-tolerant.

However, I am not sure whether loops make sense. Can we load whole the loop
at once?
27.04.2014 19:30 =D0=CF=CC=D8=DA=CF=D7=C1=D4=C5=CC=D8 "Gustavo Sverzut Barb=
ieri" <barbieri@gmail.com>
=CE=C1=D0=C9=D3=C1=CC:

> patch itself is okay, (one minor syntax issue with lack of space
> between "if" and "(").
>
> But I wonder why just fail if we find loops, are those valid? If not,
> couldn't we fail earlier and ask people to fix it?
>
> On Fri, Apr 25, 2014 at 12:46 AM, Lucas De Marchi
> <lucas.de.marchi@gmail.com> wrote:
> > Hi
> >
> > On Fri, Apr 11, 2014 at 4:31 PM,  <matwey.kornilov@gmail.com> wrote:
> >> From 48d4d7ba1acbb5c0955f75c6bdda9cf0935240fd Mon Sep 17 00:00:00 2001
> >> From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
> >> Date: Fri, 11 Apr 2014 19:43:18 +0400
> >> Subject: [PATCH] Fix recursion loop in mod_count_all_dependencies() wh=
en
> >>  subgraph has a cycle.
> >>
> >> When cycle is detected in mod_count_all_dependencies, use total count =
of
> >> modules as an upper bound of needed memory. Correct number of nodes is
> determined by
> >> subsequent call of mod_fill_all_unique_dependencies().
> >
> > We should deal with this already in depmod_calculate_dependencies(),
> > otherwise I'd say it would be a bug there. How did you reproduce it?
> >
> >
> > Gustavo, could you take a look on the patch below?
> >
> > --
> > Lucas De Marchi
> >
> >> ---
> >>  tools/depmod.c | 20 ++++++++++++++------
> >>  1 file changed, 14 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/depmod.c b/tools/depmod.c
> >> index 1aedaaf..c83dee1 100644
> >> --- a/tools/depmod.c
> >> +++ b/tools/depmod.c
> >> @@ -1682,12 +1682,20 @@ static int depmod_load(struct depmod *depmod)
> >>         return 0;
> >>  }
> >>
> >> -static size_t mod_count_all_dependencies(const struct mod *mod)
> >> +static size_t mod_count_all_dependencies(const struct mod *mod, size_=
t
> upper_bound)
> >>  {
> >>         size_t i, count =3D 0;
> >> +       /* cycle is detected */
> >> +       if (mod->dep_loop)
> >> +               return upper_bound;
> >> +
> >>         for (i =3D 0; i < mod->deps.count; i++) {
> >>                 const struct mod *d =3D mod->deps.array[i];
> >> -               count +=3D 1 + mod_count_all_dependencies(d);
> >> +               const size_t child =3D mod_count_all_dependencies(d,
> upper_bound);
> >> +               if(child =3D=3D upper_bound)
> >> +                       return child;
> >> +
> >> +               count +=3D 1 + child;
> >>         }
> >>         return count;
> >>  }
> >> @@ -1722,12 +1730,12 @@ static int
> mod_fill_all_unique_dependencies(const struct mod *mod, const struct
> >>         return err;
> >>  }
> >>
> >> -static const struct mod **mod_get_all_sorted_dependencies(const struc=
t
> mod *mod, size_t *n_deps)
> >> +static const struct mod **mod_get_all_sorted_dependencies(const struc=
t
> mod *mod, size_t *n_deps, size_t count)
> >>  {
> >>         const struct mod **deps;
> >>         size_t last =3D 0;
> >>
> >> -       *n_deps =3D mod_count_all_dependencies(mod);
> >> +       *n_deps =3D mod_count_all_dependencies(mod, count);
> >>         if (*n_deps =3D=3D 0)
> >>                 return NULL;
> >>
> >> @@ -1771,7 +1779,7 @@ static int output_deps(struct depmod *depmod,
> FILE *out)
> >>                 if (mod->deps.count =3D=3D 0)
> >>                         goto end;
> >>
> >> -               deps =3D mod_get_all_sorted_dependencies(mod, &n_deps)=
;
> >> +               deps =3D mod_get_all_sorted_dependencies(mod, &n_deps,
> depmod->modules.count);
> >>                 if (deps =3D=3D NULL) {
> >>                         ERR("could not get all sorted dependencies of
> %s\n", p);
> >>                         goto end;
> >> @@ -1819,7 +1827,7 @@ static int output_deps_bin(struct depmod *depmod=
,
> FILE *out)
> >>                         continue;
> >>                 }
> >>
> >> -               deps =3D mod_get_all_sorted_dependencies(mod, &n_deps)=
;
> >> +               deps =3D mod_get_all_sorted_dependencies(mod, &n_deps,
> depmod->modules.count);
> >>                 if (deps =3D=3D NULL && n_deps > 0) {
> >>                         ERR("could not get all sorted dependencies of
> %s\n", p);
> >>                         continue;
> >> --
> >> 1.8.1.4
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe
> linux-modules" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Gustavo Sverzut Barbieri
> --------------------------------------
> Mobile: +55 (19) 99225-2202
> Contact: http://www.gustavobarbieri.com.br/contact
>

--001a113467fcd3c55e04f80b6e74
Content-Type: text/html; charset=KOI8-R
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Can&#39;t answer the question. Looking the code, mod_count_a=
ll_dependencies has to be fixed in that way. The code, running before and a=
fter, is loop-tolerant.</p>
<p dir=3D"ltr">However, I am not sure whether loops make sense. Can we load=
 whole the loop at once?</p>
<div class=3D"gmail_quote">27.04.2014 19:30 =D0=CF=CC=D8=DA=CF=D7=C1=D4=C5=
=CC=D8 &quot;Gustavo Sverzut Barbieri&quot; &lt;<a href=3D"mailto:barbieri@=
gmail.com">barbieri@gmail.com</a>&gt; =CE=C1=D0=C9=D3=C1=CC:<br type=3D"att=
ribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
patch itself is okay, (one minor syntax issue with lack of space<br>
between &quot;if&quot; and &quot;(&quot;).<br>
<br>
But I wonder why just fail if we find loops, are those valid? If not,<br>
couldn&#39;t we fail earlier and ask people to fix it?<br>
<br>
On Fri, Apr 25, 2014 at 12:46 AM, Lucas De Marchi<br>
&lt;<a href=3D"mailto:lucas.de.marchi@gmail.com">lucas.de.marchi@gmail.com<=
/a>&gt; wrote:<br>
&gt; Hi<br>
&gt;<br>
&gt; On Fri, Apr 11, 2014 at 4:31 PM, =9A&lt;<a href=3D"mailto:matwey.korni=
lov@gmail.com">matwey.kornilov@gmail.com</a>&gt; wrote:<br>
&gt;&gt; From 48d4d7ba1acbb5c0955f75c6bdda9cf0935240fd Mon Sep 17 00:00:00 =
2001<br>
&gt;&gt; From: &quot;Matwey V. Kornilov&quot; &lt;<a href=3D"mailto:matwey.=
kornilov@gmail.com">matwey.kornilov@gmail.com</a>&gt;<br>
&gt;&gt; Date: Fri, 11 Apr 2014 19:43:18 +0400<br>
&gt;&gt; Subject: [PATCH] Fix recursion loop in mod_count_all_dependencies(=
) when<br>
&gt;&gt; =9Asubgraph has a cycle.<br>
&gt;&gt;<br>
&gt;&gt; When cycle is detected in mod_count_all_dependencies, use total co=
unt of<br>
&gt;&gt; modules as an upper bound of needed memory. Correct number of node=
s is determined by<br>
&gt;&gt; subsequent call of mod_fill_all_unique_dependencies().<br>
&gt;<br>
&gt; We should deal with this already in depmod_calculate_dependencies(),<b=
r>
&gt; otherwise I&#39;d say it would be a bug there. How did you reproduce i=
t?<br>
&gt;<br>
&gt;<br>
&gt; Gustavo, could you take a look on the patch below?<br>
&gt;<br>
&gt; --<br>
&gt; Lucas De Marchi<br>
&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =9Atools/depmod.c | 20 ++++++++++++++------<br>
&gt;&gt; =9A1 file changed, 14 insertions(+), 6 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/tools/depmod.c b/tools/depmod.c<br>
&gt;&gt; index 1aedaaf..c83dee1 100644<br>
&gt;&gt; --- a/tools/depmod.c<br>
&gt;&gt; +++ b/tools/depmod.c<br>
&gt;&gt; @@ -1682,12 +1682,20 @@ static int depmod_load(struct depmod *depm=
od)<br>
&gt;&gt; =9A =9A =9A =9A return 0;<br>
&gt;&gt; =9A}<br>
&gt;&gt;<br>
&gt;&gt; -static size_t mod_count_all_dependencies(const struct mod *mod)<b=
r>
&gt;&gt; +static size_t mod_count_all_dependencies(const struct mod *mod, s=
ize_t upper_bound)<br>
&gt;&gt; =9A{<br>
&gt;&gt; =9A =9A =9A =9A size_t i, count =3D 0;<br>
&gt;&gt; + =9A =9A =9A /* cycle is detected */<br>
&gt;&gt; + =9A =9A =9A if (mod-&gt;dep_loop)<br>
&gt;&gt; + =9A =9A =9A =9A =9A =9A =9A return upper_bound;<br>
&gt;&gt; +<br>
&gt;&gt; =9A =9A =9A =9A for (i =3D 0; i &lt; mod-&gt;deps.count; i++) {<br=
>
&gt;&gt; =9A =9A =9A =9A =9A =9A =9A =9A const struct mod *d =3D mod-&gt;de=
ps.array[i];<br>
&gt;&gt; - =9A =9A =9A =9A =9A =9A =9A count +=3D 1 + mod_count_all_depende=
ncies(d);<br>
&gt;&gt; + =9A =9A =9A =9A =9A =9A =9A const size_t child =3D mod_count_all=
_dependencies(d, upper_bound);<br>
&gt;&gt; + =9A =9A =9A =9A =9A =9A =9A if(child =3D=3D upper_bound)<br>
&gt;&gt; + =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A return child;<br>
&gt;&gt; +<br>
&gt;&gt; + =9A =9A =9A =9A =9A =9A =9A count +=3D 1 + child;<br>
&gt;&gt; =9A =9A =9A =9A }<br>
&gt;&gt; =9A =9A =9A =9A return count;<br>
&gt;&gt; =9A}<br>
&gt;&gt; @@ -1722,12 +1730,12 @@ static int mod_fill_all_unique_dependencie=
s(const struct mod *mod, const struct<br>
&gt;&gt; =9A =9A =9A =9A return err;<br>
&gt;&gt; =9A}<br>
&gt;&gt;<br>
&gt;&gt; -static const struct mod **mod_get_all_sorted_dependencies(const s=
truct mod *mod, size_t *n_deps)<br>
&gt;&gt; +static const struct mod **mod_get_all_sorted_dependencies(const s=
truct mod *mod, size_t *n_deps, size_t count)<br>
&gt;&gt; =9A{<br>
&gt;&gt; =9A =9A =9A =9A const struct mod **deps;<br>
&gt;&gt; =9A =9A =9A =9A size_t last =3D 0;<br>
&gt;&gt;<br>
&gt;&gt; - =9A =9A =9A *n_deps =3D mod_count_all_dependencies(mod);<br>
&gt;&gt; + =9A =9A =9A *n_deps =3D mod_count_all_dependencies(mod, count);<=
br>
&gt;&gt; =9A =9A =9A =9A if (*n_deps =3D=3D 0)<br>
&gt;&gt; =9A =9A =9A =9A =9A =9A =9A =9A return NULL;<br>
&gt;&gt;<br>
&gt;&gt; @@ -1771,7 +1779,7 @@ static int output_deps(struct depmod *depmod=
, FILE *out)<br>
&gt;&gt; =9A =9A =9A =9A =9A =9A =9A =9A if (mod-&gt;deps.count =3D=3D 0)<b=
r>
&gt;&gt; =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A goto end;<br>
&gt;&gt;<br>
&gt;&gt; - =9A =9A =9A =9A =9A =9A =9A deps =3D mod_get_all_sorted_dependen=
cies(mod, &amp;n_deps);<br>
&gt;&gt; + =9A =9A =9A =9A =9A =9A =9A deps =3D mod_get_all_sorted_dependen=
cies(mod, &amp;n_deps, depmod-&gt;modules.count);<br>
&gt;&gt; =9A =9A =9A =9A =9A =9A =9A =9A if (deps =3D=3D NULL) {<br>
&gt;&gt; =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A ERR(&quot;could no=
t get all sorted dependencies of %s\n&quot;, p);<br>
&gt;&gt; =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A goto end;<br>
&gt;&gt; @@ -1819,7 +1827,7 @@ static int output_deps_bin(struct depmod *de=
pmod, FILE *out)<br>
&gt;&gt; =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A continue;<br>
&gt;&gt; =9A =9A =9A =9A =9A =9A =9A =9A }<br>
&gt;&gt;<br>
&gt;&gt; - =9A =9A =9A =9A =9A =9A =9A deps =3D mod_get_all_sorted_dependen=
cies(mod, &amp;n_deps);<br>
&gt;&gt; + =9A =9A =9A =9A =9A =9A =9A deps =3D mod_get_all_sorted_dependen=
cies(mod, &amp;n_deps, depmod-&gt;modules.count);<br>
&gt;&gt; =9A =9A =9A =9A =9A =9A =9A =9A if (deps =3D=3D NULL &amp;&amp; n_=
deps &gt; 0) {<br>
&gt;&gt; =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A ERR(&quot;could no=
t get all sorted dependencies of %s\n&quot;, p);<br>
&gt;&gt; =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A continue;<br>
&gt;&gt; --<br>
&gt;&gt; 1.8.1.4<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; To unsubscribe from this list: send the line &quot;unsubscribe lin=
ux-modules&quot; in<br>
&gt;&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.o=
rg">majordomo@vger.kernel.org</a><br>
&gt;&gt; More majordomo info at =9A<a href=3D"http://vger.kernel.org/majord=
omo-info.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html=
</a><br>
<br>
<br>
<br>
--<br>
Gustavo Sverzut Barbieri<br>
--------------------------------------<br>
Mobile: +55 (19) 99225-2202<br>
Contact: <a href=3D"http://www.gustavobarbieri.com.br/contact" target=3D"_b=
lank">http://www.gustavobarbieri.com.br/contact</a><br>
</blockquote></div>

--001a113467fcd3c55e04f80b6e74--
