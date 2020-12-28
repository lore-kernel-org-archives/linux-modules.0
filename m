Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FC9C433E6
	for <linux-modules@archiver.kernel.org>; Mon, 28 Dec 2020 01:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DAF8229C4
	for <linux-modules@archiver.kernel.org>; Mon, 28 Dec 2020 01:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgL1BE7 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 27 Dec 2020 20:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgL1BE7 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 27 Dec 2020 20:04:59 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA329C061794
        for <linux-modules@vger.kernel.org>; Sun, 27 Dec 2020 17:04:18 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id o19so20767763lfo.1
        for <linux-modules@vger.kernel.org>; Sun, 27 Dec 2020 17:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4MSyDQzIv+fvp41u55hhvVBT4Tt2c72a8bQSSNwk/0=;
        b=efcSAAAcK6SuroQYFVTLNc0GxNBEQNflTSVmzBah9kICbgudxNRDw9p9qQC3hwFl69
         km1Gha2Y/L5Ss1rSdl7yugXLDAWDKWYj3H8an62OYtoidz1lR2TVhq29WIfDoiU/E9et
         f0zBLCoEwqbnLDy/CvpT8zd0QMVG70E9mKGfZUjGx5MJdVDrfjfh1hYKis27Pp2Fnsu7
         /ibR6xvUoOdG/7tUMDiMEqD2t7WAooG++ljjSQz5DnzW5BerLKVXn4ONkxQ+uFwt7Sl3
         A8UgV3JZg7z16QZmUgeL497GcYtLo80xtZC2ARXZBihbBRq83mLqeffR0qxN37ddKbS+
         BJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4MSyDQzIv+fvp41u55hhvVBT4Tt2c72a8bQSSNwk/0=;
        b=cNw4T+Rjrew0SvoRk6Ehyuidngp7ju1Y+cRSEqKBGDtTq+XcA1ycDKNp60EmQ/ltZc
         wvVCCjvIXXl59l2PrddNfjE9JQQVK2AeR+oAfIpQkaIkm2lnK4uXd3LjjVw6y3xISvh0
         ITEAQraxJxhEctOc9vCiIZUHKM/2JLKDCTWVe8iv5544mRxU++3XTNjvWfhZhwcTMcex
         ywNnvBct48zBEKfWqT9sy+/OWXMpmAjqMycpCheMp1NZ++V1nMMUHqdL7xIbMcz15cx+
         DCOfgxf/wCmpAkQOs8LBFCJsnP2Sw55C/aJ2TlaN6xdBBehfglj4sAs7RGALKwkkesu4
         KL1A==
X-Gm-Message-State: AOAM531aZkqxKaVzQr6UmZZLxYhK1LHtm98ohkn2jfMb1ZovRFKIrpKE
        dnoXYBOt7WN9re6SMDp4BSbLS5z2llny1wipH3I=
X-Google-Smtp-Source: ABdhPJzWYj9iSAFJfPiB0QtHjEF17DfpFNx77w5imzGW7zD78/XgxtwilxVUaXWY6HSAJLu6VKlWkJO1fyLv80gGnb4=
X-Received: by 2002:a2e:918a:: with SMTP id f10mr19509250ljg.302.1609117457354;
 Sun, 27 Dec 2020 17:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20201218160209.4037174-1-lucas.demarchi@intel.com>
In-Reply-To: <20201218160209.4037174-1-lucas.demarchi@intel.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Sun, 27 Dec 2020 17:04:04 -0800
Message-ID: <CAKi4VAK1vPR2mVpOXo1o-2po4Sn6JR8t-Mego6bY4BNk75SC_w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix kmod_load_resources without modules.builtin.modinfo
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Joe Buehler <aspam@cox.net>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Applied

Lucas De Marchi

On Fri, Dec 18, 2020 at 8:08 AM Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
>
> When there isn't a modules.builtin.modinfo from the kernel, depmod
> should not generate and 0-sized modules.builtin.alias.bin file. It
> should rather be an empty index.
>
> Lucas De Marchi (3):
>   depmod: unconditionally write builtin.alias.bin
>   shared: fix UNIQ definition
>   testsuite: add test for empty modules.builtin.aliases.bin
>
>  shared/macro.h                                     |   7 +++++--
>  .../lib/modules/5.6.0/modules.alias                |   1 +
>  .../lib/modules/5.6.0/modules.alias.bin            | Bin 0 -> 12 bytes
>  .../lib/modules/5.6.0/modules.builtin              |   1 +
>  .../lib/modules/5.6.0/modules.builtin.alias.bin    | Bin 0 -> 12 bytes
>  .../lib/modules/5.6.0/modules.builtin.bin          | Bin 0 -> 39 bytes
>  .../lib/modules/5.6.0/modules.dep                  |   0
>  .../lib/modules/5.6.0/modules.dep.bin              | Bin 0 -> 12 bytes
>  .../lib/modules/5.6.0/modules.devname              |   1 +
>  .../lib/modules/5.6.0/modules.softdep              |   1 +
>  .../lib/modules/5.6.0/modules.symbols              |   1 +
>  .../lib/modules/5.6.0/modules.symbols.bin          | Bin 0 -> 12 bytes
>  testsuite/test-init.c                              |   9 ++++++++-
>  testsuite/testsuite.h                              |   2 +-
>  tools/depmod.c                                     |  10 ++++++----
>  15 files changed, 25 insertions(+), 8 deletions(-)
>  create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.alias
>  create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.alias.bin
>  create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.builtin
>  create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.builtin.alias.bin
>  create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.builtin.bin
>  create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.dep
>  create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.dep.bin
>  create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.devname
>  create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.softdep
>  create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.symbols
>  create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.symbols.bin
>
> --
> 2.29.2
>
