Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9DD26C3BD
	for <linux-modules@vger.kernel.org>; Fri, 23 Jan 2026 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769209864; cv=pass; b=uqeT2aLZbt6+8o2l3mlAAHPM46Yqccl/9Avqx8SeeoAAgqzZ0/MpN244SrszTBhsYr4VPDPpbf+hIlDL+XbIScM44o91hZOqX239Zjq+G1S/eXafeip+hTQ5f65+V2xQOz0VQUkrVL1DnHcl3qeIkSOGXTf50sd2tPstNf1OpUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769209864; c=relaxed/simple;
	bh=pONGvq/fVa37p8dR24cLk7GrjvEw0COXqDHG3dK5Cnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuDps4hKRCFtN9gDSZcmyMVDemfK2LQqEVJlXoNTNCybGl916YAHGEzvlNnmyzNzs5IjaPJ7+Ebf6WOiD++ga6pXN5Q77BZRS4ax5y1SeaWEzqrNbkRVmhJ3tWoF2RRQkwjH0P/bMFKpyOlnWTaxSXRB27YC3GvfbimGaofFIQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1xuaYeI; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1xuaYeI"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79405f99b8eso40935067b3.0
        for <linux-modules@vger.kernel.org>; Fri, 23 Jan 2026 15:11:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769209860; cv=none;
        d=google.com; s=arc-20240605;
        b=jfTpy01azvo7S/sbiaUELMNA/wUXWzQhZPZFdBzgQO74yu9BSsisJjTfa1fe3yD4Kv
         H1oErAYoezH0Bw9+4KWLkyMJCMLdQtRcDdAzUQfYFDIEwEQVTRu46NrTEP1wZRg1d/tG
         6eok+z9CIWNjqHW5InhkL9ckUI0FKIbMQR8fh2Sg/KSAN/2uNOWjn53uV0ogpdTtZjBA
         HVjotBw0XK69HefRwJG5E7ns/TzMWr+eAYkWrtsRq+GahGuxoi4fYmN+YL3E+0QKBh71
         zY238QYZk10BjOZroT2ACcl/Zx4tgFUBfg4ucSmYZXbpaF+gpggO/1CpYTgozsODYA80
         krdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I2h9+cSXXIqEnX4VtPc3Fsjb7AKn1hPVqk7sWEwXQCM=;
        fh=YcN3Ba0tEKIwjz/nnKXVV4R6cOFPPusiGSIzz5oqEb8=;
        b=GimaL2PZl/f752l579l5EuW0fOcRLXolgiF1UpQQdwY/xBmDoATnXl8QzqGdzMZYZa
         HD33VHruZ4mAekfvLWS2gzFaPFLqJZgBqCETjzEoAV7NgHaX25f3Btk+VlOllmnT/Gwb
         a3Sz1uWAmxMIgYbAFsfV3Xp4tfwKJEj0dCaGwgCkTdhFzM68rOwzgOWslGmSAupmVeRv
         pfGkDp5dpKVTo7AYlBiH4nLA33zYnNoqTTT4hzCUoDurH9swuIHuJso2OrAhzwaV0iyZ
         75GBAorrkCNqwYrdh2UuOhfnYZLBdSf+MNbpsA0eW7BEvvx6or1xCBpgFb7xYP3avUsM
         dhEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769209860; x=1769814660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2h9+cSXXIqEnX4VtPc3Fsjb7AKn1hPVqk7sWEwXQCM=;
        b=G1xuaYeIWe3wAW2uj97On3FsHAN6QbQ/x1dyf83K55eCiaAH23Q1HhUw2zRaDqGhNj
         iacneIDCvXqZF5QGz5UMgl+7XPNDuRPQ35+59MO1Pymq6xj+3/SHR2YW3omo5jd7Dub2
         XvDL9WLV1vhNyd4OijfetfkKFJkK+ixTJt6GF66ojuepaV7Q+JIZzQW7goIoZlXVUDx4
         e3kEyQyCireGFgx4ZrJRiwiVD+DexNBjcVAPDohF3q2ZQPcd2JDLeXFcmzrPKA3RkoAq
         Kj5OUPAmpuAm7gJh6EH2N31mPJOLbFcbPR6oDvHkLikFQVGqM4l85IodI19MQzT78aeC
         21VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769209860; x=1769814660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I2h9+cSXXIqEnX4VtPc3Fsjb7AKn1hPVqk7sWEwXQCM=;
        b=SAk4I1En+H1HulbDhuocrKFW7CRNBtBC07t/E04gQORQYRneeKdZN3PAye+UVv7Xgt
         oSpgQu2zLQB3JsTr6PBo18cGD9u3dKsp6TPGkD3YLs96AooeGSi+cLCKkgWJBh3l/WEX
         zpJYHh5bKHkHqaraSgIau4438qP4VODy2nR2Ea5/Nn0LsOLoWykTdwj567/dmnDO4FR0
         wa/BLSWuYfuDxLapbxGXLRbqc3Y8Zyz6v9Lo7Ybo/TOjIJupZyO+5GKLkTa1Eb6DjPk7
         ry9x/lchJNZTRYzOWBGglRnFjxmDxXiLJxKfvyZKoSi4QuxJJS7LXDGOl/Dz/cckKbXK
         7Wng==
X-Forwarded-Encrypted: i=1; AJvYcCUXJKggDIfCYH+MnZMXa/wMUjmpBE3HqxSZ2RuLbO8gLLiauV92hlkEUgC65I9tGDRTxKOf1IKpU+bZtroS@vger.kernel.org
X-Gm-Message-State: AOJu0YyPlqew2Vdn2ywb2j0m2hCQbRJcFawuz6zs5sWKDbwriAPHNGZI
	nWBPViaMmQ8p4KOQzNpVk1FHFLroW84hd4d8Ajn6ajd3LLEl1lWLijs9zr4ikSZ9DlZ2nikbjqD
	3WdYaSzS12OOW4L9Isio/1jI9OtE34IY=
X-Gm-Gg: AZuq6aIDTCoupL/WRW5e1aoznlsNfPRFmYesy1SAoUfxbwQyfiF1pHKteMbv+a/mm3w
	NxArTpmjnAdsiprP38tOH+xTZPt7OBdDNrdfC+ReGpL8lvrvGQEl0ZeBoBulNg3UlN6JAe3CGno
	UQ/1+HNiRzpZuZp99Q1RDISdcB+Su75F3/wdLIeZgxXwctZWG7pMe8e7v1y9rLxjSQy7bqThi74
	eBI+ftDqTw/f6ZFeVwG8W7p06oBEQ7Vatg6HDK/1WenY48l7FLJXiwoFJl8HESjUhqA
X-Received: by 2002:a05:690e:4196:b0:649:681f:f85d with SMTP id
 956f58d0204a3-649681ffc63mr82558d50.5.1769209860598; Fri, 23 Jan 2026
 15:11:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122234621.3403276-1-jim.cromie@gmail.com> <6277616a-e66d-4ed1-b5d2-270f95d6eacc@kernel.org>
In-Reply-To: <6277616a-e66d-4ed1-b5d2-270f95d6eacc@kernel.org>
From: jim.cromie@gmail.com
Date: Fri, 23 Jan 2026 16:10:34 -0700
X-Gm-Features: AZwV_QjvtnBgNNP0A5GzxOOpRckT5XkbaUx52isDahE5ZQzfRnts7pf3-dAhsL0
Message-ID: <CAJfuBxx5q_jyDgH+dvJZSxwus5wxxo-4q6r0Mt1N49VLz96T4A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] module: speed modprobe by adding name_crc to
 struct module
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 4:39=E2=80=AFAM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
>
>
> Le 23/01/2026 =C3=A0 00:46, Jim Cromie a =C3=A9crit :
> > [Vous ne recevez pas souvent de courriers de jim.cromie@gmail.com. D=C3=
=A9couvrez pourquoi ceci est important =C3=A0 https://aka.ms/LearnAboutSend=
erIdentification ]
> >
> > "modprobe foo" currently does strcmp on the name, this can be improved.
> >
> > So this commit:
> >
> > 1. adds name_crc to struct module
> > 2. modpost.c computes the value and
> > 3. outputs it for "modinfo foo" to see/use.
> >
> > 4. adds hotpath to find_module_all()
> >     this uses name_crc to do quick "name-check"
> >     falls back to strcmp only to guard against collisions.
> >
> > This should significantly reduce modprobe workload, and shorten module
> > load-time.
>
> Any numbers of how significant is the reduction ?

Not at this time.
In absolute terms, my box is running fedora, has 165 modules,
so the significance is minor in most circumstances.
In relative terms, a numerical equality test is much faster than strcmp.

I recall seeing Luis doing quite a bit of work tuning module loading,
I was hoping he could shed light / opine / provide numbers
on the utility of this.

>
> >
> > Since it alters struct module, its binary incompatible. This means:
> >
> > 1. RFC for its wide "blast radius".
> > 2. suitable for major version bump *only*
> >
> > 3. it opens door for further struct module reorg, to:
> >     a. segregate fields by "temperature"
> >     b. pack out paholes.
> >     c. improve cache locality (by reordering coldest on bottom)
> >        name should be cold now.
> >        bikeshedding is appropriate here.
> >
> > NB: this isn't a substitute for CONFIG_MODULE_SIG.
> > It reimplements crc_le(), doesn't reuse kernel's version.
>
> Why not use the kernel's version ?

I briefly fiddled with doing so, but sorting the includes looked like a has=
sle,
so I punted and asked the AI for an implementation.


>
> >
> > CC: Luis Chamberlain <mcgrof@kernel.org>
> > CC: Petr Pavlu <petr.pavlu@suse.com>
> > CC: Daniel Gomez <da.gomez@kernel.org>
> > CC: Sami Tolvanen <samitolvanen@google.com>
> > CC: Aaron Tomlin <atomlin@atomlin.com>
> > CC: linux-modules@vger.kernel.org
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> >
> >   '#' will be ignored, and an empty message aborts the commit.
> > ---
> >   include/linux/module.h | 15 ++++++++-------
> >   kernel/module/main.c   |  8 ++++++--
> >   scripts/mod/modpost.c  | 18 ++++++++++++++++++
> >   scripts/mod/modpost.h  |  6 +++++-
> >   4 files changed, 37 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index d80c3ea57472..4ea6c5ae3374 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -402,10 +402,18 @@ struct klp_modinfo {
> >
> >   struct module {
> >          enum module_state state;
> > +       u32 name_hash;
>
> In the subject you say "name_crc"
>
> >
> >          /* Member of list of modules */
> >          struct list_head list;
> >
> > +       /* Sysfs stuff. */
> > +       struct module_kobject mkobj;
> > +       struct module_attribute *modinfo_attrs;
> > +       const char *version;
> > +       const char *srcversion;
> > +       struct kobject *holders_dir;
> > +
>
> Shouldn't this move be another patch ?
>
> >          /* Unique handle for this module */
> >          char name[MODULE_NAME_LEN];
> >
> > @@ -414,13 +422,6 @@ struct module {
> >          unsigned char build_id[BUILD_ID_SIZE_MAX];
> >   #endif
> >
> > -       /* Sysfs stuff. */
> > -       struct module_kobject mkobj;
> > -       struct module_attribute *modinfo_attrs;
> > -       const char *version;
> > -       const char *srcversion;
> > -       struct kobject *holders_dir;
> > -
> >          /* Exported symbols */
> >          const struct kernel_symbol *syms;
> >          const u32 *crcs;
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index d855f43a2be3..685218b2c5ef 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -39,6 +39,7 @@
> >   #include <linux/mutex.h>
> >   #include <linux/rculist.h>
> >   #include <linux/uaccess.h>
> > +#include <linux/crc32.h>
> >   #include <asm/cacheflush.h>
> >   #include <linux/set_memory.h>
> >   #include <asm/mmu_context.h>
> > @@ -431,13 +432,16 @@ struct module *find_module_all(const char *name, =
size_t len,
> >                                 bool even_unformed)
> >   {
> >          struct module *mod;
> > +       u32 incoming_name_hash =3D crc32_le(0, name, len);
> >
> >          list_for_each_entry_rcu(mod, &modules, list,
> >                                  lockdep_is_held(&module_mutex)) {
> >                  if (!even_unformed && mod->state =3D=3D MODULE_STATE_U=
NFORMED)
> >                          continue;
> > -               if (strlen(mod->name) =3D=3D len && !memcmp(mod->name, =
name, len))
> > -                       return mod;
> > +               if (mod->name_hash =3D=3D incoming_name_hash) {
> > +                       if (strlen(mod->name) =3D=3D len && !memcmp(mod=
->name, name, len))
> > +                               return mod;
> > +               }
>
> Why not just adding the following instead of modifing existing test:
>
>         if (mod->name_hash !=3D incoming_name_hash)
>                 continue;
>
> >          }
> >          return NULL;
> >   }
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 755b842f1f9b..ae90e0bf9330 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -21,6 +21,22 @@
> >   #include <stdbool.h>
> >   #include <errno.h>
> >
> > +/* Local CRC32 implementation for modpost.c */
> > +#define CRCPOLY_LE 0xEDB88320
> > +
> > +typedef uint32_t u32;
> > +
> > +static u32 crc32_le(u32 crc,  char  *p, size_t len)
> > +{
> > +       int i;
> > +       while (len--) {
> > +               crc ^=3D *p++;
> > +               for (i =3D 0; i < 8; i++)
> > +                       crc =3D (crc >> 1) ^ ((crc & 1) ? CRCPOLY_LE : =
0);
> > +       }
> > +       return crc;
> > +}
> > +
>
> Why do you re-implement crc32_le() ?
>
> >   #include <hash.h>
> >   #include <hashtable.h>
> >   #include <list.h>
> > @@ -1581,6 +1597,7 @@ static void read_symbols(const char *modname)
> >
> >          /* strip trailing .o */
> >          mod =3D new_module(modname, strlen(modname) - strlen(".o"));
> > +       mod->name_hash =3D crc32_le(0, mod->name, strlen(mod->name));
> >
> >          /* save .no_trim_symbol section for later use */
> >          if (info.no_trim_symbol_len) {
> > @@ -1834,6 +1851,7 @@ static void add_header(struct buffer *b, struct m=
odule *mod)
> >          buf_printf(b, "#include <linux/compiler.h>\n");
> >          buf_printf(b, "\n");
> >          buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
> > +       buf_printf(b, "MODULE_INFO(name_crc, \"0x%08x\");\n", mod->name=
_hash);
> >          buf_printf(b, "\n");
> >          buf_printf(b, "__visible struct module __this_module\n");
> >          buf_printf(b, "__section(\".gnu.linkonce.this_module\") =3D {\=
n");
> > diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> > index 2aecb8f25c87..3fc3cfd0a039 100644
> > --- a/scripts/mod/modpost.h
> > +++ b/scripts/mod/modpost.h
> > @@ -11,11 +11,14 @@
> >   #include <fcntl.h>
> >   #include <unistd.h>
> >   #include <elf.h>
> > +#include <stdint.h>
> >   #include "../../include/linux/module_symbol.h"
> >
> >   #include <list_types.h>
> >   #include "elfconfig.h"
> >
> > +typedef uint32_t u32;
> > +
> >   /* On BSD-alike OSes elf.h defines these according to host's word siz=
e */
> >   #undef ELF_ST_BIND
> >   #undef ELF_ST_TYPE
> > @@ -126,7 +129,8 @@ struct module {
> >          bool seen;
> >          bool has_init;
> >          bool has_cleanup;
> > -       char         srcversion[25];
> > +               char         srcversion[25];
> > +               u32          name_hash;
> >          // Missing namespace dependencies
> >          struct list_head missing_namespaces;
> >          // Actual imported namespaces
> > --
> > 2.52.0
> >
> >
>
