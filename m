Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E2AEB64DC
	for <linux-modules@archiver.kernel.org>; Tue, 18 Jul 2023 00:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjGRAxl (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 17 Jul 2023 20:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGRAxk (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 17 Jul 2023 20:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C847E4F
        for <linux-modules@vger.kernel.org>; Mon, 17 Jul 2023 17:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689641581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DFSrEgmWLZm6bu1iSfsXtoqGsJ5ryBMo2E5K6xSRRW4=;
        b=VEDxCn6D5m2X8crWIArHYLSJ0nKeLdh+TPPQUANuY17ZCkUu65TZRw5LO8qW7EkfDVb1CL
        lQj/4TpA3XojRhu7tG99hBfKZZ03Gy+TrFm7CT7dOzHyhV3jLaxipbeD8BDA2I3zS0FJv1
        yRea+hyn1Rypt54lf2PuMP5YciZSBOw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-rChgz4oUONmf005FZ0hBuw-1; Mon, 17 Jul 2023 20:52:59 -0400
X-MC-Unique: rChgz4oUONmf005FZ0hBuw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-403c1294d95so55166881cf.0
        for <linux-modules@vger.kernel.org>; Mon, 17 Jul 2023 17:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689641579; x=1692233579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFSrEgmWLZm6bu1iSfsXtoqGsJ5ryBMo2E5K6xSRRW4=;
        b=H6cCzwCRuJYG/0DpmzW6aVEsW+Qza084u8QXlmbKGzRTcCADXaCav29628lWmQhrgi
         5s5qsXg9PGxv9kcTcywIFeMfYTMhrB8l4O+VxAx4q50n1fWRaC308NntFwqblbiDR1J2
         prQPysxiZH7/xL0WbR7ScdYBFkIawrKh+B/QU9O2I2iRuMvQvJrRyA4hbiZD5uThuyzs
         Y1tovtC9LSFgQH83V+hsORhqzwxvMxUFDrmbNDw7wxmIOGunp59RC86LacbM2tnaPy9Y
         SduCemgp0FloSdIdClRoA1t7iy2Q9vGZof5UEgd2D3cVoP5mAddbTD2+ONyo9R/otfBO
         Tylg==
X-Gm-Message-State: ABy/qLYVfSPXZhMRAT0RI8LfRfcqFALE07oc4zGcn90pONfjZELnBQ0T
        awN2JQRuk6SiLh0ArXuoYJy2qU5HkUcSfHUl/E/SU1aoEm/BzZuljykK6CkyW0wRhOvmhtvcZbI
        fDOuzURgQXZfH7iUfLx3/dfJbp7+BYOBmVIsweaR0MQ==
X-Received: by 2002:a05:622a:15c5:b0:403:b236:9efa with SMTP id d5-20020a05622a15c500b00403b2369efamr17747369qty.31.1689641579108;
        Mon, 17 Jul 2023 17:52:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFgDp6w2uPjyDYej6SHTVr3hzmMFzjXwEz9LBEPBhFG828AadjWpGU21+dHcfKofrbnXFrjee1+3m4fBTnE2lE=
X-Received: by 2002:a05:622a:15c5:b0:403:b236:9efa with SMTP id
 d5-20020a05622a15c500b00403b2369efamr17747361qty.31.1689641578911; Mon, 17
 Jul 2023 17:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230704025322.2623556-1-airlied@gmail.com> <20230704025322.2623556-3-airlied@gmail.com>
 <ZKhcbBHqkEmGtU6I@bombadil.infradead.org> <ls3fmucy6vgh2ifyqy5grxymynwhaceieacfpsiklkvscyzxdz@j4gpugiwfxuj>
In-Reply-To: <ls3fmucy6vgh2ifyqy5grxymynwhaceieacfpsiklkvscyzxdz@j4gpugiwfxuj>
From:   David Airlie <airlied@redhat.com>
Date:   Tue, 18 Jul 2023 10:52:47 +1000
Message-ID: <CAMwc25qSx_O8Gah5-yeE-kFQVzqwWux35LxggMwa-WZN=OQmMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] modules/firmware: add a new option to denote a
 firmware group to choose one.
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jul 18, 2023 at 5:41=E2=80=AFAM Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
>
> On Fri, Jul 07, 2023 at 11:41:48AM -0700, Luis Chamberlain wrote:
> >On Tue, Jul 04, 2023 at 12:50:50PM +1000, Dave Airlie wrote:
> >> From: Dave Airlie <airlied@redhat.com>
> >>
> >> This adds two tags that will go into the module info.
> >>
> >> The first denotes a group of firmwares, when that tag is present all
> >> MODULE_FIRMWARE lines between the tags will be ignored by new versions=
 of
> >> dracut.
> >>
> >> The second makes an explicitly ordered group of firmwares to search fo=
r
> >> inside a group setting. New dracut will pick the first available firmw=
are
> >> from this to put in the initramfs.
> >>
> >> Old dracut will just ignore these tags and fallback to installing all
> >> the firmwares.
> >>
> >> The corresponding dracut code it at:
> >> https://github.com/dracutdevs/dracut/pull/2309
> >>
> >> Cc: Luis Chamberlain <mcgrof@kernel.org>
> >> Cc: linux-modules@vger.kernel.org
> >> Cc: dri-devel@lists.freedesktop.org
> >> Signed-off-by: Dave Airlie <airlied@redhat.com>
> >
> >Lucas, did this end up working for you as well?
>
> I didn't try this yet, no. My opinion is similar to the first version of
> this series:  this is the first case in which we are making the order of
> 2 different keys to be relevant and it doesn't look so pretty. It may
> also be hard to adapt some of the drivers like i915 to intertwine the 2
> modinfo keys.

This doesn't have as much reliance on order, it just relies on the
group tags not being reordered outside the modinfos between them.

>
> However, the alternative I provided also has some flaws, so I said I'd
> be ok continuing in this direction. Humn... how about merging part of my
> suggestion to mitigate the duplication we have now?
>
>         - Document that when using a fw group, it's expected userspace
>           will consider higher versions within a group to have higher
>           prio and add only one of them. Thinking on a distro packaging,
>           it could be extended to packaging fewer blobs too.
>
> If we agree on "firmware files within a group are version-sorted", then
> we don't need the extra MODULE_FIRMWARE_GROUP_LIST, do we?

But what is the versioning to be used, I have to be very careful to
have this be backwards compat, and not suddenly stop pulling in some
versions of a fw because they happen to have used a version scheme
that this tramples.

If you are saying, we need to define a firmware versioning rule, then
that's a big task and would involve changing a bunch of things in the
fw and drivers.

i915:
adlp_dmc_ver2_14.bin.xz
dg2_guc_70.1.2.bin.xz
mtl_guc_70.bin.xz

amdgpu:
polaris11_mec.bin.xz
polaris11_mec2.bin.xz
polaris11_mec_2.bin.xz
polaris11_mec2_2.bin.xz

I don't see what is a version field I can sort on reliably here. Now
maybe I could introduce a new field

Do you think we should just add explicit ordering to each module group?,

so we create a

MODULE_FIRMWARE_GROUP_VERSIONED("nvidia/ga106/gsp/gsp-5258902.bin", 1);
MODULE_FIRMWARE_GROUP_VERSIONED("nvidia/ga106/gsp/gsp-5303002.bin", 2);

and I just output group brackets + that? and fix dracut to deal with it?

Dave.

