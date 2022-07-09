Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74711CCA47F
	for <linux-modules@archiver.kernel.org>; Sat,  9 Jul 2022 03:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiGIDUK (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 8 Jul 2022 23:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGIDUJ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 8 Jul 2022 23:20:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DA866B97
        for <linux-modules@vger.kernel.org>; Fri,  8 Jul 2022 20:20:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u15-20020a25ab0f000000b0066e49f6c461so376297ybi.2
        for <linux-modules@vger.kernel.org>; Fri, 08 Jul 2022 20:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+6mxQwenuketJNKTw2AgKFfZAqlF6au6yl4FTcttxec=;
        b=msMkA6mMPXw2DPMUq74vBSihilJyTAYJuh/S0rF3IC0cPUdu0AeobvaBuBjtiEaNII
         NOmrLvdaC1siW8gfkU3VdyX8XWubTcJ7N8ejX2AMWIS5YBFys+TvqXBYHaVHSNltPLp6
         CM75KN3k6KbthTszveXONoTcH1G34XiQSURviEVH+ZIXVpH3TnRoS7XDEp/Qr0A2GlZA
         HkmtaJ6ydDOGq7aPzND/i9cUqwLgaFgrR2XFBj59P6jnvpTM44S4ioqga7l/HAa/G62h
         9QLhIfp9lXOjBKlQtkjDngTTNxcgLxNwQGMEnAZiyi+8f0Xv4XD9xt1Y25zBorh7w2vw
         qFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+6mxQwenuketJNKTw2AgKFfZAqlF6au6yl4FTcttxec=;
        b=U7kL7fmOXWe5oxWZphG6a3eo3Zy0YvOChmtzJxxnX4o+Uz5p4XPvHISeiqtxyd4dUo
         QzoobrMQ77fhNgP4B2loyP1GPxKkCDlUixYJSm7T53BGcn5FcxSsqXkcrgEpHABJ+mIw
         6yPBDbcQ/X4mJDaYXAsCYVPmpKyhODAsnLCcwQ3NdrbfybeIaXd7XfaZUxBeNFaFmfbK
         3eym+Fl5fpthVXhCJCH+0gUxc6ppSm4vohfVKNA8H/z2+t38UJblIlXGt1EwuOiJLTiX
         L1AT8Hg5/bvvU5ObX4LA+ix33bocnyexTPpRo+URjYGWi3LemxgzsAVyD9s09TSf5Rty
         yG/w==
X-Gm-Message-State: AJIora9fa3VJeJ5Wi7Zr/C5b+ggClJoVnr/2juva68W34YhyMrBbPW9C
        dUnl5HyEw2m/R6XLd3zw3cENVy4S/LF/ZA==
X-Google-Smtp-Source: AGRyM1tgsnBX7aPla1Mr0qumw/V3OTEIp6cC1PNLFxa8hu9gpm9EJthrRffSNiaj4BlnO6ehELCNCbFGypYSnw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:13c6:0:b0:669:33b:97cb with SMTP id
 189-20020a2513c6000000b00669033b97cbmr6543203ybt.583.1657336806987; Fri, 08
 Jul 2022 20:20:06 -0700 (PDT)
Date:   Sat,  9 Jul 2022 11:19:56 +0800
Message-Id: <20220709032001.819487-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 0/5] Rework KUnit test execution in modules
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Ma=C3=ADra=20Canal?=" <maira.canal@usp.br>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This patch series makes two changes to how KUnit test suites are stored
and executed:
- The .kunit_test_suites section is now used for tests in modules (in
  lieu of a module_init funciton), as well as for built-in tests. The
  module loader will now trigger test execution. This frees up the
  module_init function for other uses.
- Instead of storing an array of arrays of suites, have the
  kunit_test_suite() and kunit_test_suites() macros append to one global
  (or per-module) list of test suites. This removes a needless layer of
  indirection, and removes the need to NULL-terminate suite_sets.

The upshot of this is that it should now be possible to use the
kunit_test_suite() and kunit_test_suites() macros to register test
suites even from within modules which otherwise had module_init
functions. This was proving to be quite a common issue, resulting in
several modules calling into KUnit's private suite execution functions
to run their tests (often introducing incompatibilities with the KUnit
tooling).

This series also fixes the thunderbolt, nitro_enclaves, and
sdhci-of-aspeed tests to use kunit_test_suite() now that it works. This
is required, as otherwise the first two patches may break these tests
entirely.

Huge thanks to Jeremy Kerr, who designed and implemented the module
loader changes, and to Daniel Latypov for pushing the simplification of
the nested arrays in .kunit_test_suites.

I've tested this series both with builtin tests on a number of
architectures, and with modules on x86_64, and it seems good-to-go to
me. More testing (particularly of modules) with more interesting setups
never hurts, though!

Cheers,
-- David

Changes since v3:
https://lore.kernel.org/linux-kselftest/20220625050838.1618469-1-davidgow@google.com/
- Rebase on top of the TAINT_TEST patch series. This should now apply
  cleanly on top of the kunit branch:
  https://lore.kernel.org/linux-kselftest/20220708044847.531566-1-davidgow@google.com/T/#u
- Add Brendan's Reviewed/Acked-by tags.

Daniel Latypov (1):
  kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites

David Gow (3):
  thunderbolt: test: Use kunit_test_suite() macro
  nitro_enclaves: test: Use kunit_test_suite() macro
  mmc: sdhci-of-aspeed: test: Use kunit_test_suite() macro

Jeremy Kerr (1):
  kunit: unify module and builtin suite definitions

 drivers/mmc/host/Kconfig                      |   5 +-
 drivers/mmc/host/sdhci-of-aspeed-test.c       |   8 +-
 drivers/mmc/host/sdhci-of-aspeed.c            |  34 +----
 drivers/thunderbolt/Kconfig                   |   6 +-
 drivers/thunderbolt/domain.c                  |   3 -
 drivers/thunderbolt/tb.h                      |   8 -
 drivers/thunderbolt/test.c                    |  12 +-
 drivers/virt/nitro_enclaves/Kconfig           |   5 +-
 drivers/virt/nitro_enclaves/ne_misc_dev.c     |  27 ----
 .../virt/nitro_enclaves/ne_misc_dev_test.c    |   5 +-
 include/kunit/test.h                          |  62 ++------
 include/linux/module.h                        |   5 +
 kernel/module/main.c                          |   6 +
 lib/kunit/executor.c                          | 115 ++++----------
 lib/kunit/executor_test.c                     | 144 +++++-------------
 lib/kunit/test.c                              |  54 ++++++-
 16 files changed, 155 insertions(+), 344 deletions(-)

-- 
2.37.0.rc0.161.g10f37bed90-goog

