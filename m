Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68513C465
	for <linux-modules@vger.kernel.org>; Fri, 23 Jan 2026 23:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769210684; cv=pass; b=pjL7yWrEYnp72w8KDf7N6emJbLL+Z10DgFIy1w+MUnNzGwBngF6Hdi32jnKG1/Z6fTjBovNq4WlUjsZvHv9v371KJIq0KiIJx5iTL1kTQPgwXWCqw6IFQzGVbF4kmQljNm5+DQ4X8WIx/way4xiC3a7gsXR+RKsF98UcpU6lJns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769210684; c=relaxed/simple;
	bh=vmPeAcRFYgBHBastyIMScN/xRq86zsvyQsMHsfeP9nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+ler28oy8jVLlvcK2Ljb2O4lxqh7v177/cQAN8QqlVJuUNGD5SpSYtwDbiqJ6qEiSmVCaQlIPGur/XgECFH4XzZy8WsrotO4PpEdAoZ6ykszWlNDW6yHHMvHy0QidTqmfiL5u70PEbtMqci+qIZZeDKnfLowNi4L8eb7lEBjRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG3ffiS5; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG3ffiS5"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64938fce805so2661852d50.1
        for <linux-modules@vger.kernel.org>; Fri, 23 Jan 2026 15:24:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769210682; cv=none;
        d=google.com; s=arc-20240605;
        b=ACfUz4eTXG4jxzjXyy57BuxuKYQq/O+1/eJHb2HIydcEdhEifxxcupIxQP3wBA+mnC
         SiKBSW2Z3HsBcLORLmZi+pKXKl7a0pVq1Mo8T14Ii8NPEy7CqIvCN0URvN8ETjQYYxqY
         vBqYyyKYYT8jMzvyLQlSdRaYu54GipUGT05H8hEzV5zU668s5Ls9bn90fgpP/nSOov7J
         s2H1PAX1hhD/ol1J8pC284L1kS2UCDgwLy+aOVLEMe7urzea1A1i8qjMtNViMOwh89Vz
         VVWAHBMOZvfP5Mev5zXC14Zb6I6U9jLFBQbe9G9k/7fzcUrWb9eQ6qqqmOIpCRLatIQv
         Aq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CFserzf0IJ4e3cug1ldMbMkOE2yraJY4+MDF6LCHyMM=;
        fh=BbOiD5qJo8jBgg6EKWSL8pxf/tMxNelYWbFO3YS8u2A=;
        b=BgIrjROYoFM2Yy9TDPsVo1QRWxtf+eWzlKcwDGE5CpL0YCCMFvfpnJW9kPzTdfsO3r
         kbkl3cDLCNdHCDOscPRKFvw+b/GAZlLjFhjkqsTTvx4lk7dPPfPEXWxIJbsZos6ZeOuF
         fuPuBnmi2vQ6k7lZK79GxFm1wMvmYZMtsQQEhY+VH5AygWW6nJ31uolQ8orFgNhjL42p
         tdlDDtrDK0U4sx77W+RG1FAmDNAFuIdbzubQTU2VM4vjjJESkdtRI+6nnTyxU8BOvSGt
         Ythmp4KzRBd555t8DYBdbkDPWxYILw6s5PX1yyBfKp03bsIZueUKazvVcBEcY+PdNQQe
         BWFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769210682; x=1769815482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFserzf0IJ4e3cug1ldMbMkOE2yraJY4+MDF6LCHyMM=;
        b=OG3ffiS5v03pBmZRfIjSl7yvAbek5NjDGiIrIW11UlAQC71XgB8frvZ2onf+hiAahP
         yeu+JdIuOAL06Xm+ckC0HS9D0uYwY5nfOxUY42XJFp7Oq66MfST5dnuBL4NPTmiQQ5OT
         +ebaqJQ0nJ679eNlosoRNBb71agAWUpv4d5PddpLEVk0wP+TKhaw9wcw066HW6Av0+JT
         geHSz1nR3d7z7fIGVT3yg7X6TQfmukKhtYxx+J4bGYLuuA7px8KMabsZK00f6k5e2RAk
         kYOg4NDeELS52qT75v9w3DbAug2cVaR0I1oXv6OyfzbwVj1aaGWWy6p66HJIhxXFK93d
         Dnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769210682; x=1769815482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CFserzf0IJ4e3cug1ldMbMkOE2yraJY4+MDF6LCHyMM=;
        b=S/geQvNSPqpg6F4OGfumIBKU+0c5rwssnutJzvxScSSd8xK1RcKEHokuZdL0XDYIpn
         gkip+LT5x2Nx+mFxs8aDvvK29jBEPD+DUqqo4nRl82PrLNb1BR3KPWYYCk3RfKnS8ThR
         dGikG/58QXH10gvOR2Y6qG+vIyHpdo4ESZJ6pymzdcPoDnHIsaMJQJh/TlaPQJG4Z2go
         dYk6NTFFrEFTgJYcKOMtgDAhD70MKL+XEALTMUR0KcSwUElbI9ahmsuxuPIZjGrCpL4I
         46556i8eN2n4m8n+vbCGLZS4WybW7FSGvc+SBQFHrBc4YY/R43mNWvdjrKXl96wu45B3
         x1LA==
X-Forwarded-Encrypted: i=1; AJvYcCUPi+nLI+6OxBA6nKIszwbUR249F1uhHi6BO7SueBCQCnIe5CdvvH2w3CBUirASJbGZy1SMT71ndgjbHtxh@vger.kernel.org
X-Gm-Message-State: AOJu0YyA9rBoi3iw9zYer5Qv7EXwVE+XGJ+/Rbzzf+W7GEzQ8zAkLMsz
	UtvoJhWaQxFRj2iWguE/NO13xoycdmfGNdcEyDFb6Zr6H+ceRl8rU0mwvKIoPE3EyHCN3TJUon0
	b+5GdF1FA+cgKUAO4X9zRBuU5BflIqXQ1FvZoY3M=
X-Gm-Gg: AZuq6aJ50HCzTILiIzOtTCG6Oe/cwzvYPEgUugEg9SHbJp7+YU1O5vx8nY3kV+dkZe6
	2YlJeL7+4ySHuK/BTzmgSgJ6HNWNcfzEwL/5hL4lWIBqUvCnEu6ogoGwZcNr5vU93pZOvlrHQsB
	oDiEu+cGxcY6V37NcO1ZbpVCe0qC5mcjRQqdtNb8Nax3lv9/qj47qg/9VvOc7QU4o7xUXV+wCCE
	bH6xzmn+G/67npoPn1xzquT3926gd6qEtX5Sqf/Wlm6mFZJ6kRbJl2tQdz3bM3N3x/S
X-Received: by 2002:a53:d80a:0:b0:647:116a:f67f with SMTP id
 956f58d0204a3-6495c019b0emr2905374d50.94.1769210681897; Fri, 23 Jan 2026
 15:24:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122234621.3403276-1-jim.cromie@gmail.com>
 <6277616a-e66d-4ed1-b5d2-270f95d6eacc@kernel.org> <CAJfuBxx5q_jyDgH+dvJZSxwus5wxxo-4q6r0Mt1N49VLz96T4A@mail.gmail.com>
In-Reply-To: <CAJfuBxx5q_jyDgH+dvJZSxwus5wxxo-4q6r0Mt1N49VLz96T4A@mail.gmail.com>
From: jim.cromie@gmail.com
Date: Fri, 23 Jan 2026 16:24:16 -0700
X-Gm-Features: AZwV_QheE9EiGuMZw6OY0PGLtzawMF_1XYYldo79cwY-74hkp6-w2WWhcs_P52s
Message-ID: <CAJfuBxz9LseSsTccsVnu4BB6cbve97PmnxjP8jt33WhRqUUgQA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] module: speed modprobe by adding name_crc to
 struct module
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies, I hit send too soon, and missed some of your points.

name_hash vs name_crc
was failure to recheck my names for consistency.

On Fri, Jan 23, 2026 at 4:10=E2=80=AFPM <jim.cromie@gmail.com> wrote:
>
> On Fri, Jan 23, 2026 at 4:39=E2=80=AFAM Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
> >
> >
> >
> > Le 23/01/2026 =C3=A0 00:46, Jim Cromie a =C3=A9crit :
> > > [Vous ne recevez pas souvent de courriers de jim.cromie@gmail.com. D=
=C3=A9couvrez pourquoi ceci est important =C3=A0 https://aka.ms/LearnAboutS=
enderIdentification ]
> > >
> > > "modprobe foo" currently does strcmp on the name, this can be improve=
d.
> > >
> > > So this commit:
> > >
> > > 1. adds name_crc to struct module
> > > 2. modpost.c computes the value and
> > > 3. outputs it for "modinfo foo" to see/use.
> > >
> > > 4. adds hotpath to find_module_all()
> > >     this uses name_crc to do quick "name-check"
> > >     falls back to strcmp only to guard against collisions.
> > >
> > > This should significantly reduce modprobe workload, and shorten modul=
e
> > > load-time.
> >
> > Any numbers of how significant is the reduction ?
>
> Not at this time.
> In absolute terms, my box is running fedora, has 165 modules,
> so the significance is minor in most circumstances.
> In relative terms, a numerical equality test is much faster than strcmp.
>
> I recall seeing Luis doing quite a bit of work tuning module loading,
> I was hoping he could shed light / opine / provide numbers
> on the utility of this.
>
> >
> > >
> > > Since it alters struct module, its binary incompatible. This means:
> > >
> > > 1. RFC for its wide "blast radius".
> > > 2. suitable for major version bump *only*
> > >
> > > 3. it opens door for further struct module reorg, to:
> > >     a. segregate fields by "temperature"
> > >     b. pack out paholes.
> > >     c. improve cache locality (by reordering coldest on bottom)
> > >        name should be cold now.
> > >        bikeshedding is appropriate here.
> > >
> > > NB: this isn't a substitute for CONFIG_MODULE_SIG.
> > > It reimplements crc_le(), doesn't reuse kernel's version.
> >
> > Why not use the kernel's version ?
>
> I briefly fiddled with doing so, but sorting the includes looked like a h=
assle,
> so I punted and asked the AI for an implementation.
>
>
> >
> > >
> > > CC: Luis Chamberlain <mcgrof@kernel.org>
> > > CC: Petr Pavlu <petr.pavlu@suse.com>
> > > CC: Daniel Gomez <da.gomez@kernel.org>
> > > CC: Sami Tolvanen <samitolvanen@google.com>
> > > CC: Aaron Tomlin <atomlin@atomlin.com>
> > > CC: linux-modules@vger.kernel.org
> > >
> > > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > >
> > >   '#' will be ignored, and an empty message aborts the commit.
> > > ---
> > >   include/linux/module.h | 15 ++++++++-------
> > >   kernel/module/main.c   |  8 ++++++--
> > >   scripts/mod/modpost.c  | 18 ++++++++++++++++++
> > >   scripts/mod/modpost.h  |  6 +++++-
> > >   4 files changed, 37 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/include/linux/module.h b/include/linux/module.h
> > > index d80c3ea57472..4ea6c5ae3374 100644
> > > --- a/include/linux/module.h
> > > +++ b/include/linux/module.h
> > > @@ -402,10 +402,18 @@ struct klp_modinfo {
> > >
> > >   struct module {
> > >          enum module_state state;
> > > +       u32 name_hash;
> >
> > In the subject you say "name_crc"
> >
> > >
> > >          /* Member of list of modules */
> > >          struct list_head list;
> > >
> > > +       /* Sysfs stuff. */
> > > +       struct module_kobject mkobj;
> > > +       struct module_attribute *modinfo_attrs;
> > > +       const char *version;
> > > +       const char *srcversion;
> > > +       struct kobject *holders_dir;
> > > +
> >
> > Shouldn't this move be another patch ?
> >
> > >          /* Unique handle for this module */
> > >          char name[MODULE_NAME_LEN];
> > >
> > > @@ -414,13 +422,6 @@ struct module {
> > >          unsigned char build_id[BUILD_ID_SIZE_MAX];
> > >   #endif
> > >
> > > -       /* Sysfs stuff. */
> > > -       struct module_kobject mkobj;
> > > -       struct module_attribute *modinfo_attrs;
> > > -       const char *version;
> > > -       const char *srcversion;
> > > -       struct kobject *holders_dir;
> > > -
> > >          /* Exported symbols */
> > >          const struct kernel_symbol *syms;
> > >          const u32 *crcs;
> > > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > > index d855f43a2be3..685218b2c5ef 100644
> > > --- a/kernel/module/main.c
> > > +++ b/kernel/module/main.c
> > > @@ -39,6 +39,7 @@
> > >   #include <linux/mutex.h>
> > >   #include <linux/rculist.h>
> > >   #include <linux/uaccess.h>
> > > +#include <linux/crc32.h>
> > >   #include <asm/cacheflush.h>
> > >   #include <linux/set_memory.h>
> > >   #include <asm/mmu_context.h>
> > > @@ -431,13 +432,16 @@ struct module *find_module_all(const char *name=
, size_t len,
> > >                                 bool even_unformed)
> > >   {
> > >          struct module *mod;
> > > +       u32 incoming_name_hash =3D crc32_le(0, name, len);
> > >
> > >          list_for_each_entry_rcu(mod, &modules, list,
> > >                                  lockdep_is_held(&module_mutex)) {
> > >                  if (!even_unformed && mod->state =3D=3D MODULE_STATE=
_UNFORMED)
> > >                          continue;
> > > -               if (strlen(mod->name) =3D=3D len && !memcmp(mod->name=
, name, len))
> > > -                       return mod;
> > > +               if (mod->name_hash =3D=3D incoming_name_hash) {
> > > +                       if (strlen(mod->name) =3D=3D len && !memcmp(m=
od->name, name, len))
> > > +                               return mod;
> > > +               }
> >
> > Why not just adding the following instead of modifing existing test:

thats an alternative.
I modified the existing test cuz its qualitatively the same test,
except for collisions.

> >
> >         if (mod->name_hash !=3D incoming_name_hash)
> >                 continue;
> >
> > >          }
> > >          return NULL;
> > >   }
> > > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > > index 755b842f1f9b..ae90e0bf9330 100644
> > > --- a/scripts/mod/modpost.c
> > > +++ b/scripts/mod/modpost.c
> > > @@ -21,6 +21,22 @@
> > >   #include <stdbool.h>
> > >   #include <errno.h>
> > >
> > > +/* Local CRC32 implementation for modpost.c */
> > > +#define CRCPOLY_LE 0xEDB88320
> > > +
> > > +typedef uint32_t u32;
> > > +
> > > +static u32 crc32_le(u32 crc,  char  *p, size_t len)
> > > +{
> > > +       int i;
> > > +       while (len--) {
> > > +               crc ^=3D *p++;
> > > +               for (i =3D 0; i < 8; i++)
> > > +                       crc =3D (crc >> 1) ^ ((crc & 1) ? CRCPOLY_LE =
: 0);
> > > +       }
> > > +       return crc;
> > > +}
> > > +
> >
> > Why do you re-implement crc32_le() ?

I didnt want to wrestle with the headers.
If theres utility here, I can do so.

> >
> > >   #include <hash.h>
> > >   #include <hashtable.h>
> > >   #include <list.h>
> > > @@ -1581,6 +1597,7 @@ static void read_symbols(const char *modname)
> > >
> > >          /* strip trailing .o */
> > >          mod =3D new_module(modname, strlen(modname) - strlen(".o"));
> > > +       mod->name_hash =3D crc32_le(0, mod->name, strlen(mod->name));
> > >
> > >          /* save .no_trim_symbol section for later use */
> > >          if (info.no_trim_symbol_len) {
> > > @@ -1834,6 +1851,7 @@ static void add_header(struct buffer *b, struct=
 module *mod)
> > >          buf_printf(b, "#include <linux/compiler.h>\n");
> > >          buf_printf(b, "\n");
> > >          buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
> > > +       buf_printf(b, "MODULE_INFO(name_crc, \"0x%08x\");\n", mod->na=
me_hash);
> > >          buf_printf(b, "\n");
> > >          buf_printf(b, "__visible struct module __this_module\n");
> > >          buf_printf(b, "__section(\".gnu.linkonce.this_module\") =3D =
{\n");
> > > diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> > > index 2aecb8f25c87..3fc3cfd0a039 100644
> > > --- a/scripts/mod/modpost.h
> > > +++ b/scripts/mod/modpost.h
> > > @@ -11,11 +11,14 @@
> > >   #include <fcntl.h>
> > >   #include <unistd.h>
> > >   #include <elf.h>
> > > +#include <stdint.h>
> > >   #include "../../include/linux/module_symbol.h"
> > >
> > >   #include <list_types.h>
> > >   #include "elfconfig.h"
> > >
> > > +typedef uint32_t u32;
> > > +
> > >   /* On BSD-alike OSes elf.h defines these according to host's word s=
ize */
> > >   #undef ELF_ST_BIND
> > >   #undef ELF_ST_TYPE
> > > @@ -126,7 +129,8 @@ struct module {
> > >          bool seen;
> > >          bool has_init;
> > >          bool has_cleanup;
> > > -       char         srcversion[25];
> > > +               char         srcversion[25];
> > > +               u32          name_hash;
> > >          // Missing namespace dependencies
> > >          struct list_head missing_namespaces;
> > >          // Actual imported namespaces
> > > --
> > > 2.52.0
> > >
> > >
> >
