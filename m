Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D51C4167B
	for <linux-modules@archiver.kernel.org>; Mon, 19 Dec 2022 19:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiLSTTI (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Dec 2022 14:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiLSTTA (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Dec 2022 14:19:00 -0500
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C18911C08
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 11:18:59 -0800 (PST)
Received: by mail-oi1-x249.google.com with SMTP id r32-20020a056808212000b0035e98193903so2777503oiw.21
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 11:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eiMsBFbuAwwWsYZNb0dq7gOOooiEFAWwdKh7AXEOnMI=;
        b=tG6Uh3Z9k4jSwxOaxcN6OQxf4A6DyUPQN+PXW+hziPymUkCM9V6sWgKzGQFEjiPvnk
         l8ZiG6ScI3h7Tl6DLWNhreYHLKlhzuA/bfH+IxOgrZm5Mi4KyMF1Olu8Kx1u7+8Q8pjV
         P3/oBaT5dSxMpVqWFG7Y1189wi+y+sXb4JGAfQ+CQHQsSifhGYIs2uQDuEs8FmzWWCoK
         u27LXxUyHmVi5cHa63muTYGy7nmuM93PjZuja1+fYw62O0XgCTfIoGOhUXkqe/u1gBFV
         f0eOEmnLPcn3+X0bEuk4CIGrgqTspj058qgQhdu2GxJEpA8iTcYsnW8eO99RYiq+ofX4
         +NpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiMsBFbuAwwWsYZNb0dq7gOOooiEFAWwdKh7AXEOnMI=;
        b=S8pVTeMk2rBbH68c8yMGPNVirMTy84sXfzPbi6z4ujXHQltxmg4QBiZr7xBTWBfC9W
         Eh3V9Qzq1Bk/xkkoeYwJ+pmUCBwpejlDW0n4APyzPiWeDFAQuFAC2ZUy5lRGPzk5aGKL
         LYv8JzdpoxaZnBH22cuL/NXjr+QhZAR57jjNh8kkWIrupF4o+pAcEMup1XZGh8hwsacS
         /0s36LQwxLuEacpEvXvdd2sqs3/MXzmSMmeBmvD2gSTGUn1g0UFr1XFQUcai4fffz9LZ
         p8rV4pjlzb3zhG/7X/lMVJiHG5/AQ7m8AEW8oFzSirb+KCUsohsQSSj+LRIKDmV46Sqq
         n2gA==
X-Gm-Message-State: ANoB5pky1wBdnrRSsKzZFzFn/82BiWRBhOaYKSUHFaQNhUDPShNbDdB6
        I9XLLfNEoS1U+GPpud4U7JIi0vC7NQzRI2RA5gTI8MVhqUSrYUk9ERuFwklOYIRC63Lz3ukdlVq
        lE3ZOaiA6B0ztXC4rvtbIFpyaplU924NpMniUKJwfBMdI5u/8fADzSjKqYB9lgATTqOOEK8un5T
        29ldI=
X-Google-Smtp-Source: AA0mqf4DLi2UOpHwa3pj3dhe8A3SizukPo6ORwrd7gzGfGnSsu4F9JCgksQuy24CWtDMyQ4r53h73DKvZRm/mwM=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:6830:6408:b0:66e:6b6b:f7a5 with SMTP
 id cj8-20020a056830640800b0066e6b6bf7a5mr20681030otb.153.1671477538946; Mon,
 19 Dec 2022 11:18:58 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:18:46 -0600
In-Reply-To: <20221216221703.294683-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221216221703.294683-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219191855.2010466-1-allenwebb@google.com>
Subject: [PATCH v8 0/9] Generate modules.builtin.alias from match ids
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Generate modules.builtin.alias from match ids

This patch series (v8) generates `modules.builtin.alias` during modpost.
The goal is for tools like USBGuard to leverage not only modules.aliases
but also `modules.builtin.aliases` to associate devices with the modules
that may be bound before deciding to authorize a device or not. This is
particularly useful in cases when new devices of a particular type
shouldn't be allowed part of the time like for lock screens.

Also included in this series are style fixes and fixes for build
breakages for built-in modules that relied on MODULE_DEVICE_TABLE being
a no-op. Some of these were typos in the device table name and one
ifdef-ed out the device table.

--

# Generate modules.builtin.alias from match ids

This series (v7) has incremental improvements over the previous series.
One big positive of this patch series is it makes it harder for bugs
in kernel modules related to MODULE_DEVICE_TABLE to hide when a module
is only ever tested as a built-in module. This is demonstrated by all
the required fixes at the beginning of the series.

Note, cover letters were first added in v5.

  RFC (broken patch): https://lore.kernel.org/lkml/CAJzde042-M4UbpNYKw0eDVg4JqYmwmPYSsmgK+kCMTqsi+-2Yw@mail.gmail.com/
  v1 (missing v1 label): https://lore.kernel.org/lkml/20221111152852.2837363-1-allenwebb@google.com/
  v2 (missing v2 label): https://lore.kernel.org/lkml/20221128201332.3482092-1-allenwebb@google.com/
  v3: https://lore.kernel.org/lkml/20221129224313.455862-1-allenwebb@google.com/
  v4: https://lore.kernel.org/lkml/20221130221447.1202206-1-allenwebb@google.com/
  v5: https://lore.kernel.org/lkml/20221201211630.101541-1-allenwebb@google.com/
  v6: https://lore.kernel.org/lkml/20221202224540.1446952-1-allenwebb@google.com/
  v7: https://lore.kernel.org/lkml/20221216221703.294683-1-allenwebb@google.com/
  v8: This version

## Patch series status
123456789012345678901234567890123456789012345678901234567890123456789012
This series is still going through revisions in response to comments.

I believe there is potential to improve the Makefile part of the patch
series as well as an open question of whether modpost should generate
`modules.built.alias` directly or create a vmlinuz.mod.c containing the
missing module info for the match-id based aliases for built-in modules.

## Acknowledgements

Thanks to Greg Kroah-Hartman, Christophe Leroy, and the Linux
maintainers for being patient with me as I have worked through learning
the kernel workflow to get this series into a more presentable state.

Thanks to Luis Chamberlain for raising the alternative of using kmod to
address the primary motivation of the patch series.

Also, thanks to Intel's kernel test robot <lkp@intel.com> for catching
issues that showed up on different kernel configurations.


Allen Webb (9):
  imx: Fix typo
  rockchip-mailbox: Fix typo
  scsi/BusLogic: Always include device id table
  stmpe-spi: Fix typo
  module.h: MODULE_DEVICE_TABLE for built-in modules
  modpost: Track module name for built-in modules
  modpost: Add -b option for emitting built-in aliases
  file2alias.c: Implement builtin.alias generation
  build: Add modules.builtin.alias

 .gitignore                         |  1 +
 Makefile                           |  1 +
 drivers/mailbox/rockchip-mailbox.c |  2 +-
 drivers/mfd/stmpe-spi.c            |  2 +-
 drivers/scsi/BusLogic.c            |  2 -
 drivers/soc/imx/imx8mp-blk-ctrl.c  |  2 +-
 include/linux/module.h             | 15 ++++-
 scripts/Makefile.modpost           | 17 +++++-
 scripts/mod/file2alias.c           | 94 +++++++++++++++++++++++-------
 scripts/mod/modpost.c              | 23 +++++++-
 scripts/mod/modpost.h              |  2 +
 11 files changed, 131 insertions(+), 30 deletions(-)

-- 
2.37.3

