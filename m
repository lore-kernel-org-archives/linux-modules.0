Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11164C001B0
	for <linux-modules@archiver.kernel.org>; Wed, 19 Jul 2023 19:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjGSTwD (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 19 Jul 2023 15:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjGSTwC (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 19 Jul 2023 15:52:02 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0D61BF2
        for <linux-modules@vger.kernel.org>; Wed, 19 Jul 2023 12:52:00 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-799b3a301b0so12443241.3
        for <linux-modules@vger.kernel.org>; Wed, 19 Jul 2023 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689796320; x=1690401120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYOwNntA5WE6xe24NJ4pZv26m9x1H9FPfyiIwBhTOwY=;
        b=YLruMY8r1vjqEc9OKeC82gvXH4C9UyDZMonQnhIP72NhGaW1MgLJBnTRrW9L6uLRvd
         ebJTg1d214RL9UgRJHKzFBJBh9ugocEAkj1SjxbL25+KduqszB4IJ/yI4oxDJrhHb+Xs
         XwJ2SqGPKyqDIHygAS4QU38SQxCrgyHgBwGSG4eYFMUDSeMRxo5cR+x1T3zfZmtmqC2A
         xCRg9kGx8il5nMiqWqmAWMYY9EGJdpFvYJGCl1Ti07YZah0gfDAtp8dO2MdaQUllKvrb
         tY9aL4rko2x9jv+GavR/pairFVG8ksHdLw/XAL2Kj8I9rHd09XIBQ+W0uI6D+iPxjRE8
         arBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689796320; x=1690401120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYOwNntA5WE6xe24NJ4pZv26m9x1H9FPfyiIwBhTOwY=;
        b=HwwUvFVCOu4kfYOWbtQgjj2qk5KLBs9mIzNMGbeaqgUldI2FwiUgap/ZZV9KGz5xGV
         hC2w0X1eDywzXEQsCOzNgwNXHTFV/isRX7V5iy4WTlMusLCKE5AW7MNbngAu8xmgQlyA
         jXFM2rIKLhQddqpwcMIfL6NSaepI5wq+PtC88id8l9GVyLAqUEZAsjoqNwIFl6aVkg8s
         Pzv9aGw2jpN8gVH93RQkH4jqUJO4PNe0w6tk1k6IIxId5dVD3hFu/vjym93dW2gEdRb2
         094cZkAN07/cgiOHscwJ4bsBcODShpfidejzhBqItI5BZm1XHw4wqTISvQeq8tBI7hMI
         325A==
X-Gm-Message-State: ABy/qLagzdfgau1UouNc4JSne/LpC5Ba2fVid0iV60azgDOgBY0TOSd3
        50LWoKdxWUwEa7m8n8GNI3o5KwECbAIw7PPYPmGinQ==
X-Google-Smtp-Source: APBJJlFKL49KzazS4jd+QjD1HBJYykETwHvON7Of5qx39ifseYKwWKBElKzF04lhO++OWwX4U9Iztc5jELZKiOrn8o8=
X-Received: by 2002:a67:f648:0:b0:443:59e3:f4f6 with SMTP id
 u8-20020a67f648000000b0044359e3f4f6mr1439304vso.22.1689796319725; Wed, 19 Jul
 2023 12:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221219204619.2205248-1-allenwebb@google.com>
 <20230406190030.968972-1-allenwebb@google.com> <20230406190030.968972-9-allenwebb@google.com>
 <ZG22iPLED+SJsEFa@bombadil.infradead.org>
In-Reply-To: <ZG22iPLED+SJsEFa@bombadil.infradead.org>
From:   Allen Webb <allenwebb@google.com>
Date:   Wed, 19 Jul 2023 14:51:48 -0500
Message-ID: <CAJzde04MmfyGeAzQ_7FW-0sATk7TT-MkxCbNPSzb-94wK6nhkA@mail.gmail.com>
Subject: Re: [PATCH v10 08/11] build: Add modules.builtin.alias
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, christophe.leroy@csgroup.eu,
        nick.alcock@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

I finally got a chance to go through the comments and work on a
follow-up to this series, but it probably makes sense to get this
sorted ahead of the follow-up (if possible).

On Wed, May 24, 2023 at 2:02=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On Thu, Apr 06, 2023 at 02:00:27PM -0500, Allen Webb wrote:
> > Generate modules.builtin.alias using modpost and install it with the
> > modules.
>
> Why? This is probably one of the more important commits and the
> commit log is pretty slim.
>
> > Signed-off-by: Allen Webb <allenwebb@google.com>
> > ---
> >  .gitignore               |  1 +
> >  Makefile                 |  1 +
> >  scripts/Makefile.modpost | 15 +++++++++++++++
> >  3 files changed, 17 insertions(+)
> >
> > diff --git a/.gitignore b/.gitignore
> > index 13a7f08a3d73..ddaa622bddac 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -71,6 +71,7 @@ modules.order
> >  /System.map
> >  /Module.markers
> >  /modules.builtin
> > +/modules.builtin.alias
> >  /modules.builtin.modinfo
> >  /modules.nsdeps
> >
> > diff --git a/Makefile b/Makefile
> > index a2c310df2145..43dcc1ea5fcf 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1578,6 +1578,7 @@ __modinst_pre:
> >       fi
> >       @sed 's:^\(.*\)\.o$$:kernel/\1.ko:' modules.order > $(MODLIB)/mod=
ules.order
> >       @cp -f modules.builtin $(MODLIB)/
> > +     @cp -f modules.builtin.alias $(MODLIB)/
> >       @cp -f $(objtree)/modules.builtin.modinfo $(MODLIB)/
> >
> >  endif # CONFIG_MODULES
> > diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> > index 0980c58d8afc..e3ecc17a7a19 100644
> > --- a/scripts/Makefile.modpost
> > +++ b/scripts/Makefile.modpost
> > @@ -15,6 +15,7 @@
> >  # 2) modpost is then used to
> >  # 3)  create one <module>.mod.c file per module
> >  # 4)  create one Module.symvers file with CRC for all exported symbols
> > +# 5)  create modules.builtin.alias the aliases for built-in modules
>
> Does everyone want that file?

Not everyone needs it so we could exclude it, but the cost of adding
it isn't that high. I am fine with putting it behind a config, though
we would need to decide whether to have it default on/off.

>
> >  # Step 3 is used to place certain information in the module's ELF
> >  # section, including information such as:
> > @@ -63,6 +64,20 @@ modpost-args +=3D -T $(MODORDER)
> >  modpost-deps +=3D $(MODORDER)
> >  endif
> >
> > +ifneq ($(wildcard vmlinux.o),)
> > +output-builtin.alias :=3D modules.builtin.alias
> > +modpost-args +=3D -b .modules.builtin.alias.in
> > +.modules.builtin.alias.in: $(output-symdump)
> > +     @# Building $(output-symdump) generates .modules.builtin.alias.in=
 as a
> > +     @# side effect.
> > +     @[ -e $@ ] || $(MODPOST) -b .modules.builtin.alias.in vmlinux.o
>
> Does using -b create a delay in builds ? What is the effect on build
> time on a typical 4-core or 8-core build? Does everyone want it?

Here is some data I collected related to build time and memory usage impact=
:

Without builtin.alias:
TIME=3D"real %e\nuser %U\nsys %S\nres-max %M" time scripts/mod/modpost
-E -o Module.symvers -T modules.order
ERROR: modpost: "__x86_return_thunk"
[arch/x86/crypto/chacha-x86_64.ko] undefined!
ERROR: modpost: "kernel_fpu_end" [arch/x86/crypto/chacha-x86_64.ko] undefin=
ed!
ERROR: modpost: "hchacha_block_generic"
[arch/x86/crypto/chacha-x86_64.ko] undefined!
ERROR: modpost: "boot_cpu_data" [arch/x86/crypto/chacha-x86_64.ko] undefine=
d!
ERROR: modpost: "static_key_enable" [arch/x86/crypto/chacha-x86_64.ko]
undefined!
ERROR: modpost: "cpu_has_xfeatures" [arch/x86/crypto/chacha-x86_64.ko]
undefined!
ERROR: modpost: "crypto_register_skciphers"
[arch/x86/crypto/chacha-x86_64.ko] undefined!
ERROR: modpost: "crypto_unregister_skciphers"
[arch/x86/crypto/chacha-x86_64.ko] undefined!
ERROR: modpost: "__stack_chk_fail" [arch/x86/crypto/chacha-x86_64.ko] undef=
ined!
ERROR: modpost: "memset" [arch/x86/crypto/chacha-x86_64.ko] undefined!
WARNING: modpost: suppressed 17432 unresolved symbol warnings because
there were too many)
Command exited with non-zero status 1
real 0.44
user 0.43
sys 0.01
res-max 4896

With builtin.alias:
TIME=3D"real %e\nuser %U\nsys %S\nres-max %M" time scripts/mod/modpost
-E -o Module.symvers -T modules.order -b .modules.builtin.alias.in
vmlinux.o
real 1.43
user 1.38
sys 0.05
res-max 51920

Notice that modpost only uses a single core, so multicore isn't really
as much of a factor here. While it more than triples the time required
for the modpost operation the difference is only about one second of
CPU time. The memory usage is much larger when generating
modules.builtin.alias because of the size of vmlinux.o.

My biggest performance related concern is actually the size difference
of vmlinux caused by the modules.h changes, but it looks like that is
negligible (24KiB):

Without builtin.alias:
du vmlinux.o
663048  vmlinux.o

With builtin.alias:
du vmlinux.o
663072  vmlinux.o

>
> Should we add a new option which lets people decide if they want this
> at build time or not?

I don't feel strongly that there should or should not be a config for
this. On the side for a config the extra second of CPU time and space
taken up by the modules.builtin.alias file would add up across all the
builds and machines, so removing it where it isn't used would help
mitigate that. On the flip side if it isn't used widely enough, it is
more likely that breakages are missed until someone who actually uses
it notices.

Please let me know if you feel strongly either way given the data.

Thanks,
Allen

>
>   Luis
>
> > +
> > +$(output-builtin.alias): .modules.builtin.alias.in
> > +     sort -o $@ $^
> > +
> > +__modpost: $(output-builtin.alias)
> > +endif
> > +
> >  ifeq ($(KBUILD_EXTMOD),)
> >
> >  # Generate the list of in-tree objects in vmlinux
> > --
> > 2.39.2
> >
