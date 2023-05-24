Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D3DC77B73
	for <linux-modules@archiver.kernel.org>; Wed, 24 May 2023 05:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbjEXFgr (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 24 May 2023 01:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjEXFgq (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 24 May 2023 01:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5A4B3
        for <linux-modules@vger.kernel.org>; Tue, 23 May 2023 22:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684906557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sYWSCZWSoZ/yhfINuAN5NPLl1eSeL3h1FfSVoHk+QUw=;
        b=CZcrdZmsecKaFYCgQoYOfa6PrZg5B1qAUUN/xJWqfpjtRnm0IlgEqdvWHrm1UF8XKD/VqP
        3zvK4xZlfyOOVxwNiMp6+VOoMK611mVpXQB/iCAzdkfAxzgJT82ji4PlwkvOoPlWYux1GO
        +oRa4YvdP5KsXFFlf6Zn1s7TNzF8504=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-mBcoslk4OhG0isNBs2lSbg-1; Wed, 24 May 2023 01:35:54 -0400
X-MC-Unique: mBcoslk4OhG0isNBs2lSbg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f51ea554a8so3704701cf.2
        for <linux-modules@vger.kernel.org>; Tue, 23 May 2023 22:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684906553; x=1687498553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYWSCZWSoZ/yhfINuAN5NPLl1eSeL3h1FfSVoHk+QUw=;
        b=ghvHc+TvBhP7RWxnJ/Aswmx8oARZM3Osa8F4KLyaKq6kX6ig7FZQ/Rc5yeALZY+wWV
         6HX5ij4nz7oABTeMpBhHtknWFCHxbuwsiZZYJEJSekc/6Ij3rITtdKrBCbzHsQdwE9js
         0VDfxHBxnxfXYR99dgfU1bmHLl7K6ygpiWxeYP33YWANbD6dVdXIQFlmNmyjASYVYZaJ
         L/+tx6stDhn34LH4wWSqgXGVPPVEKNWN+RTS1OfECJucYVdcDf7LhFyUhHkLiekuBcQ0
         ODnJcew9FVOcx1i40YUNYR8bfc/CXD9l+ie/OQVoWS4neRheJZWUCecvaY7lJ09RH63i
         8kRw==
X-Gm-Message-State: AC+VfDwhSYf/VZlnSpmWC/cerIrv7JeJHosf2Izl6FDO2HZsMf+c6g+4
        EwgvXAeXzW9lOHnL6LW3YpvRKwN3iA2bwan3bSHxs1L6kza889f8ir848Vwr8WURoz08Ma5vPyE
        t3+SKQOHkfQqZyRIFMxDBRhJbp/F+gdpBVwqZyr6qUg==
X-Received: by 2002:ac8:5f0d:0:b0:3ea:bac1:a5a0 with SMTP id x13-20020ac85f0d000000b003eabac1a5a0mr19403628qta.37.1684906553580;
        Tue, 23 May 2023 22:35:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4zoHUTXzLdb1Nxh2pNoR/xydQsi1zuA0cn/ITqVkoEy+kEK/SZQChxAk6qBXDSg2cjFosMJuogOiOThzMtK7o=
X-Received: by 2002:ac8:5f0d:0:b0:3ea:bac1:a5a0 with SMTP id
 x13-20020ac85f0d000000b003eabac1a5a0mr19403618qta.37.1684906553312; Tue, 23
 May 2023 22:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230419043652.1773413-1-airlied@gmail.com> <ck2dzxvllhhh74oa3vjlacutc7rdmgl7cfrfq7vgx4w3jcufrz@7jbgxcat42yn>
 <CAPM=9tw0Y2A4DvuTHT_yd58Eit+tUmo63pbEOHwRJ66LeqznEQ@mail.gmail.com>
 <fsleccud43leoioli6bj4xoydwbdcjb5qr4denuf6morhgtqki@t6xya2mygon5>
 <ZEcJNcz+ArLfUSJ1@bombadil.infradead.org> <n6gwizwt26ucpuva2kt35rprth6iqeibi3inq2qrn5qhs3aa3b@4hjbhgnskutq>
 <CAPM=9txLf2NbuZSM5CLYT4wA5mbQ=+ssm9tdzh6JJ=gtEBeqAA@mail.gmail.com> <ZG2gBJbwX73owRYu@bombadil.infradead.org>
In-Reply-To: <ZG2gBJbwX73owRYu@bombadil.infradead.org>
From:   David Airlie <airlied@redhat.com>
Date:   Wed, 24 May 2023 15:35:41 +1000
Message-ID: <CAMwc25poqP-S2DSXLZuRA7F20fHsiq7uACbxUvYHCEkpY7BoHA@mail.gmail.com>
Subject: Re: [PATCH] modules/firmware: add a new option to denote a firmware
 group to choose one.
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, May 24, 2023 at 3:26=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On Wed, May 03, 2023 at 01:19:31PM +1000, Dave Airlie wrote:
> > >
> > > >
> > > >> > the GROUP until after the FIRMWARE, so this can't work, as it al=
ready
> > > >> > will have included all the ones below, hence why I bracketed top=
 and
> > > >> > bottom with a group.
> > > >>
> > > >> well... that is something that can be adapted easily by using a 2 =
pass
> > > >> approach, filtering out the list based on the groups.
> > > >>
> > > >> I agree that yours is simpler though.  If we can rely on the
> > > >> order produced by the compiler and we document the expectations of
> > > >> MODULE_FIRMWARE_GROUP_ONLY_ONE, then I believe we can stay with th=
e
> > > >> simpler approach.
> > > >>
> > > >> Luis, any thoughts here?
> > > >
> > > >I see the Dracut code indicates that the order says now that you sho=
uld
> > > >put the preferred firmware last, and that seems to match most coding
> > > >conventions, ie, new firmwares likely get added last, so it's a nice
> > >
> > > not all. i915 for example keeps it newest first so when attempting
> > > multiple firmware versions it starts from the preferred version.  It
> > > will be harder to convert since it also uses a x-macro to make sure t=
he
> > > MODULE_FIRMWARE() and the the platform mapping are actually using the=
 same
> > > firmware.
> > >
> > > >coincidence. Will this always work? I don't know. But if you like to
> > >
> > > short answer: it depends if your compiler is gcc *and* -O2 is used
> > > Longer debug ahead. Simple test with the expansion of MODULE_FIRMWARE
> > > baked in:
> > >
> > >         $ cat /tmp/a.c
> > >         static const __attribute__((section("__modinfo_manual"), used=
, aligned(1))) char foo[] =3D "modinfo_manual_foo";
> > >         static const __attribute__((section("__modinfo_manual"), used=
, aligned(1))) char bar[] =3D "modinfo_manual_bar";
> > >         $ gcc -c -o /tmp/a.o /tmp/a.c
> > >         $ objcopy -O binary --only-section=3D__modinfo_manual /tmp/a.=
o /tmp/modinfo_manual
> > >         $ strings /tmp/modinfo_manual
> > >         modinfo_manual_foo
> > >         modinfo_manual_bar
> > >
> > > However that doesn't match when building modules. In kmod:
> > >
> > > diff --git a/testsuite/module-playground/mod-simple.c b/testsuite/mod=
ule-playground/mod-simple.c
> > > index 503e4d8..6dd5771 100644
> > > --- a/testsuite/module-playground/mod-simple.c
> > > +++ b/testsuite/module-playground/mod-simple.c
> > > @@ -30,3 +30,9 @@ module_exit(test_module_exit);
> > >
> > >   MODULE_AUTHOR("Lucas De Marchi <lucas.demarchi@intel.com>");
> > >   MODULE_LICENSE("GPL");
> > > +
> > > +
> > > +static const char __UNIQUE_ID_firmware404[] __attribute__((__used__)=
) __attribute__((__section__("__modinfo_cpp"))) __attribute__((__aligned__(=
1))) =3D "modinfo_cpp_foo";
> > > +static const char __UNIQUE_ID_firmware405[] __attribute__((__used__)=
) __attribute__((__section__("__modinfo_cpp"))) __attribute__((__aligned__(=
1))) =3D "modinfo_cpp_bar";
> > >
> > >         $ make ....
> > >         $ objcopy -O binary --only-section=3D__modinfo_cpp testsuite/=
module-playground/mod-simple.ko /tmp/modinfo_cpp
> > >         $ strings /tmp/modinfo_cpp
> > >         modinfo_cpp_bar
> > >         modinfo_cpp_foo
> > >
> > > It doesn't seem to be ./scripts/Makefile.modfinal neither as it's als=
o
> > > inverted in testsuite/module-playground/mod-simple.o
> > >
> > > After checking the options passed to gcc, here is the "culprit": -O2
> > >
> > >         $ gcc -c -o /tmp/a.o /tmp/a.c && objcopy -O binary --only-sec=
tion=3D__modinfo_manual /tmp/a.o /tmp/modinfo_manual && strings /tmp/modinf=
o_manual
> > >         modinfo_manual_foo
> > >         modinfo_manual_bar
> > >         $ gcc -O2 -c -o /tmp/a.o /tmp/a.c && objcopy -O binary --only=
-section=3D__modinfo_manual /tmp/a.o /tmp/modinfo_manual && strings /tmp/mo=
dinfo_manual
> > >         modinfo_manual_bar
> > >         modinfo_manual_foo
> > >
> > > It seems anything but -O0 inverts the section.
> > >
> > >         $ gcc --version
> > >         gcc (GCC) 12.2.1 20230201
> > >
> > > It doesn't match the behavior described in its man page though. Manua=
lly
> > > specifying all the options that -O1 turns on doesn't invert it.
> > >
> > >         $ gcc -fauto-inc-dec -fbranch-count-reg -fcombine-stack-adjus=
tments \
> > >                 -fcompare-elim -fcprop-registers -fdce -fdefer-pop -f=
delayed-branch
> > >                 -fdse -fforward-propagate -fguess-branch-probability =
-fif-conversion \
> > >                 -fif-conversion2 -finline-functions-called-once -fipa=
-modref \
> > >                 -fipa-profile -fipa-pure-const -fipa-reference -fipa-=
reference-addressable \
> > >                 -fmerge-constants -fmove-loop-stores -fomit-frame-poi=
nter -freorder-blocks \
> > >                 -fshrink-wrap -fshrink-wrap-separate -fsplit-wide-typ=
es -fssa-backprop \
> > >                 -fssa-phiopt -ftree-bit-ccp -ftree-ccp -ftree-ch -ftr=
ee-coalesce-vars \
> > >                 -ftree-copy-prop -ftree-dce -ftree-dominator-opts -ft=
ree-dse -ftree-forwprop \
> > >                 -ftree-fre -ftree-phiprop -ftree-pta -ftree-scev-cpro=
p -ftree-sink -ftree-slsr \
> > >                 -ftree-sra -ftree-ter -funit-at-a-time -c -o /tmp/a.o=
 /tmp/a.c \
> > >                 && objcopy -O binary --only-section=3D__modinfo_manua=
l /tmp/a.o /tmp/modinfo_manual && strings /tmp/modinfo_manual
> > >         cc1: warning: this target machine does not have delayed branc=
hes
> > >         modinfo_manual_foo
> > >         modinfo_manual_bar
> > >
> >
> > Thanks Lucas,
> >
> > -ftoplevel-reorder is the one that does it, now that does mean how
> > I've done it isn't going to be robust.
> >
> > I will reconsider but in order to keep backwards compat, it might be
> > easier to add firmware groups as an explicit list, but also spit out
> > the individual names, but not sure how clean this will end up on
> > dracut side.
> >
> > I'll take a look at the other options, but it does seem like reworking
> > dracut is going to be the harder end of this, esp if I still want to
> > keep compat with older ones.
>
> Hey Dave, just curious if there was going to be another follow up patch
> for this or if it was already posted. I don't see it clearly so just
> wanted to double check.

I'm still considering the options here.

I could leave the kernel patch as-is and add explicit sorting in
dracut for anything in the groups, but then we have to name/version
the firmware in a certain way, another option might be to emit the
group bounds and two records, one old, one new per-fw file, then have
some sort of explicit versioning by the driver over what order to load
them.

Dave.

