Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B67C77B61
	for <linux-modules@archiver.kernel.org>; Mon, 24 Apr 2023 05:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjDXFoh (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 24 Apr 2023 01:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjDXFog (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 24 Apr 2023 01:44:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD3AE58
        for <linux-modules@vger.kernel.org>; Sun, 23 Apr 2023 22:44:32 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94f3cd32799so721501666b.0
        for <linux-modules@vger.kernel.org>; Sun, 23 Apr 2023 22:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682315071; x=1684907071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XuBLmH9wIVGljuXNxlXx2kx1aQjm7l2qZRs0CCmzFU0=;
        b=BkQpLJxPVZbt8K/usXRUG9BTVGVJttaIn+sysrwihymnlnPXrl10vWvaoS2g3qOJbP
         xdodjtOiXIJSmZp9srXNy50zlJejBqNa5Z31PDlVLG/lN0adkvTnvgYubHe36r0oRg+j
         aGOibcmLzgp0X6UhuzCz6J93We95yUpRphvrMyGJtngCroEcJ5bUoTzVr/Jafp6g0WNE
         JyCN3/ddRrzVfkCp7jUKIQwHSLwCphme8Ziwr8swOqSdY2h45QUg9I++YcnYOd3kdeAz
         HzcPcLK2EGmwy+9M8Y1kEssp9CACtbsSzgaSICSniar8PUnT8THug3YBOo9aLTTEFF0t
         0aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682315071; x=1684907071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XuBLmH9wIVGljuXNxlXx2kx1aQjm7l2qZRs0CCmzFU0=;
        b=hp2hpogDkw51JgogZSVnOGfwPIoUYc88sQ/D/puW20J2WAb6MuvAzn4qVTNfDLdIOY
         8bjqsuuISmFeN612a25n0HZPbw6jZF39OkRw59nUD9Mly8VchmG1BlmAcWsYBsDaFBEf
         I9DDxXgJQYgz5jHB4evV8thnBEFg0/J9l6p4jS7lBk4bC3U+ceulipMrq9sbkh23f1Aq
         r+OTcrk/cc0fSiexWGL+7i/g2ldRy8azZEvMtlzEcsfry/uvUPgZMz9lcjogrh+iRzgO
         yY+9XBgp71o0CRpGny+oGBJl7ReWM2pyu8TAtLmVFKL9V9EfVkL/PisYgc+4bTN/LLbN
         gbsA==
X-Gm-Message-State: AAQBX9fvtuUCxmsgCU9cZqtlklNfzEAHrRAmsmUlhuEPqksx59PlbkWU
        pAU772ezliTOSgK+n4DDyyczDXPdpikYjvTTKoo=
X-Google-Smtp-Source: AKy350aMRrBUUkTWn4LBYHNN1r9vxHhQQVm8fy9SBS4lGtMSXBj8TbAdYOE8x462sM1w0uChnaVM1xGGZrWMobWfUAo=
X-Received: by 2002:a17:906:2646:b0:94f:31da:8c37 with SMTP id
 i6-20020a170906264600b0094f31da8c37mr9064847ejc.52.1682315070450; Sun, 23 Apr
 2023 22:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230419043652.1773413-1-airlied@gmail.com> <ck2dzxvllhhh74oa3vjlacutc7rdmgl7cfrfq7vgx4w3jcufrz@7jbgxcat42yn>
In-Reply-To: <ck2dzxvllhhh74oa3vjlacutc7rdmgl7cfrfq7vgx4w3jcufrz@7jbgxcat42yn>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 24 Apr 2023 15:44:18 +1000
Message-ID: <CAPM=9tw0Y2A4DvuTHT_yd58Eit+tUmo63pbEOHwRJ66LeqznEQ@mail.gmail.com>
Subject: Re: [PATCH] modules/firmware: add a new option to denote a firmware
 group to choose one.
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, 21 Apr 2023 at 05:09, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> On Wed, Apr 19, 2023 at 02:36:52PM +1000, Dave Airlie wrote:
> >From: Dave Airlie <airlied@redhat.com>
> >
> >This adds a tag that will go into the module info, only one firmware from
> >the group given needs to be available for this driver to work. This allows
> >dracut to avoid adding in firmware that aren't needed.
> >
> >This just brackets a module list in the modinfo, the modules in the list
> >will get entries in reversed order so the last module in the list is the
> >preferred one.
> >
> >The corresponding dracut code it at:
> >https://github.com/dracutdevs/dracut/pull/2309
>
> it would be good to have the example usage in the commit message here so
> it can be easily checked as reference for other drivers.

Good point.

>
> I don't think we ever had any ordering in modinfo being relevant for
> other things. Considering the use case and that we could also use a
> similar thing for i915 / xe modules wrt to the major version,
> couldn't we do something like below?
>
>         MODULE_FIRMWARE_GROUP("nvidia/ga106/gsp/gsp");
>         MODULE_FIRMWARE("nvidia/ga106/gsp/gsp-5258902.bin");
>         MODULE_FIRMWARE("nvidia/ga106/gsp/gsp-5303002.bin");
>
> so the group is created by startswith() rather than by the order the
> modinfo appears in the elf section. In i915 we'd have:

The way userspace parses these is reverse order, and it doesn't see
the GROUP until after the FIRMWARE, so this can't work, as it already
will have included all the ones below, hence why I bracketed top and
bottom with a group.

>
> MODULE_FIRMWARE_GROUP("i915/tgl_guc")
>
> There is still an order the kernel would probably like: latest version.
> But then it's an order only among things with the same key.

Dave.
