Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52D2C76196
	for <linux-modules@archiver.kernel.org>; Thu,  6 Apr 2023 19:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240108AbjDFTBD (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 6 Apr 2023 15:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbjDFTBB (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 6 Apr 2023 15:01:01 -0400
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF37586AE
        for <linux-modules@vger.kernel.org>; Thu,  6 Apr 2023 12:00:58 -0700 (PDT)
Received: by mail-io1-xd4a.google.com with SMTP id b3-20020a056602274300b007603d89cdc9so2636904ioe.2
        for <linux-modules@vger.kernel.org>; Thu, 06 Apr 2023 12:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680807658;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSA3/1CdFh9tu9Hpp9PWm4akde9aLttLgSqXrwXokdk=;
        b=OSvpGYy4yGiVdwycb5ysh+iFXTvtWtx8upWKkoCrsKl/cdHIYt20pDqU/zNjC6An+l
         CutaPev7Hwl3wN3xcmqzvXTmi3UYlf0cvnRY5/EBf8A3LqIKPMUpoNzbV4M6L5U3guvS
         1dB94T/2NzLtwPLmBAixZvjGzAFBYreZztlTzruBw8lwDtQpVRJg9HDjhIe+N5yEbtim
         m6Cvz69tp7Z2qYNDnHuGJhq6ww//pIddpTBqj+HemVBibg4JBNDOto3Ro7EdxA4eWcis
         or6oiARvXQGC6NseMfIS/HYevuZRzPTI0yEpybtjQ1osoGo7M/oTxdXHM6e8IMg2Uz9P
         LH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807658;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSA3/1CdFh9tu9Hpp9PWm4akde9aLttLgSqXrwXokdk=;
        b=lTa8aywUx7x5V63tK+6eTvbaPCgqXmoldLtmVMABeepl3QwbRmOyBhL1Xi1u4Sg81N
         Vx0B0o+N9312EuOLMul1VJRF9Vh+BzeKHyZ7CfHSNnrN3r049I3j+JhH1QJmrNuA/EZ2
         6K+DEcDtwJFbdAsQjPPKN1p2wxbAXQ58hsOnzWvcDUOqzhqZtvoCNmW+afPbhlcAVl5e
         apIOiq5Hf16sACs06lzRrtM2zxMYhIo/eduhOudmVl/5LVn1RrdL3ymfGQi9VW1E+596
         fMH3VOyTaYCz8wROKcohUCFSAc8L+c53XkAOMUdMqbHgWpYI4TEC8A6mFsQDiyhOYYMf
         INFg==
X-Gm-Message-State: AAQBX9cD+2qyph7HkKUdXlv6fAnj5P9wqKsgLAhrRrqR1ILUktucJ4JU
        BLsb77pmVG8/CQTU3TYpkZ1OtP/GjOKCQtB3MNBadetEysOIbnmwN+Zvn0lqIi0yI22cSLD3K04
        s9Av63s7qfYg287mEkvnM1hLzs0F0d1Bi24HLIzamFmPT8oNm2SucEldTFM/jfZtiZNAZPuYxqy
        FbhuA=
X-Google-Smtp-Source: AKy350Zb3KiU0VTyZNkzMslxks92DdL9kS/QwpXsNpZZe8AvnVVrfQ9VwU8xYCdMiKywM1hpLUQ3ziWRcqOhTd8=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:6e02:12ea:b0:310:9d77:6063 with SMTP
 id l10-20020a056e0212ea00b003109d776063mr6868825iln.5.1680807658032; Thu, 06
 Apr 2023 12:00:58 -0700 (PDT)
Date:   Thu,  6 Apr 2023 14:00:19 -0500
In-Reply-To: <20221219204619.2205248-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219204619.2205248-1-allenwebb@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406190030.968972-1-allenwebb@google.com>
Subject: [PATCH v10 00/11] Generate modules.builtin.alias from match ids
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     gregkh@linuxfoundation.org, mcgrof@kernel.org,
        christophe.leroy@csgroup.eu, nick.alcock@oracle.com,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Generate modules.builtin.alias from match ids

This patch series (v10) generates `modules.builtin.alias` during modpost.
The goal is for tools like USBGuard to leverage not only modules.aliases
but also `modules.builtin.aliases` to associate devices with the modules
that may be bound before deciding to authorize a device or not. This is
particularly useful in cases when new devices of a particular type
shouldn't be allowed part of the time like for lock screens.

Also included in this series are added documentation, style fixes and
fixes for build breakages for built-in modules that relied on
MODULE_DEVICE_TABLE being a no-op. Some of these were typos in
device table name that do not need aliases and one ifdef-ed out the
device table.

---

Generate modules.builtin.alias from match ids
=============================================

This series (v10) removes the `cc:stable` commit tags since the fixes
only are needed going forward. It also includes documentation updates
and unifies the MODULE_DEVICE_TABLE macro for both the builtin and
module case.

Additionally, rather than fixing the typo-ed device table names the
commits were updated to drop the broken MODULE_DEVICE_TABLE
invocations, since they belong to device types that would not benefit
from the intended purpose of `modules.builtin.alias`.

Note, cover letters were first added in v5.

  RFC (broken patch): https://lore.kernel.org/lkml/CAJzde042-M4UbpNYKw0eDVg4JqYmwmPYSsmgK+kCMTqsi+-2Yw@mail.gmail.com/
  v1 (missing v1 label): https://lore.kernel.org/lkml/20221111152852.2837363-1-allenwebb@google.com/
  v2 (missing v2 label): https://lore.kernel.org/lkml/20221128201332.3482092-1-allenwebb@google.com/
  v3: https://lore.kernel.org/lkml/20221129224313.455862-1-allenwebb@google.com/
  v4: https://lore.kernel.org/lkml/20221130221447.1202206-1-allenwebb@google.com/
  v5: https://lore.kernel.org/lkml/20221201211630.101541-1-allenwebb@google.com/
  v6: https://lore.kernel.org/lkml/20221202224540.1446952-1-allenwebb@google.com/
  v7: https://lore.kernel.org/lkml/20221216221703.294683-1-allenwebb@google.com/
  v8: https://lore.kernel.org/lkml/20221219191855.2010466-1-allenwebb@google.com/
  v9: https://lore.kernel.org/lkml/20221219204619.2205248-1-allenwebb@google.com/
  v10: This version

Patch series status
-------------------

This series should be close to ready.

Acknowledgements
----------------

Thanks to Greg Kroah-Hartman, Christophe Leroy, Luis Chamberlain and the
other Linux maintainers for being patient with me as I have worked
through learning the kernel workflow to get this series into a more
presentable state.

Thanks to Luis Chamberlain for raising the alternative of using kmod to
address the primary motivation of the patch series.

Thanks to Dmitry Torokhov and Benson Leung for feedback on the
USB authorization documentation for the driver API.

Also, thanks to Intel's kernel test robot <lkp@intel.com> for catching
issues that showed up with different kernel configurations.

Allen Webb (11):
  rockchip-mailbox: Remove unneeded MODULE_DEVICE_TABLE
  scsi/BusLogic: Always include device id table
  stmpe-spi: Fix MODULE_DEVICE_TABLE entries
  module.h: MODULE_DEVICE_TABLE for built-in modules
  modpost: Track module name for built-in modules
  modpost: Add -b option for emitting built-in aliases
  file2alias.c: Implement builtin.alias generation
  build: Add modules.builtin.alias
  Documentation: Include modules.builtin.alias
  Documentation: Update writing_usb_driver for built-in modules
  Documentation: add USB authorization document to driver-api

 .gitignore                                    |  1 +
 .../driver-api/usb/authorization.rst          | 71 ++++++++++++++
 Documentation/driver-api/usb/index.rst        |  1 +
 .../driver-api/usb/writing_usb_driver.rst     |  3 +
 Documentation/kbuild/kbuild.rst               |  7 ++
 Makefile                                      |  1 +
 drivers/mailbox/rockchip-mailbox.c            |  1 -
 drivers/mfd/stmpe-spi.c                       |  1 -
 drivers/scsi/BusLogic.c                       |  2 -
 include/linux/module.h                        | 36 ++++++--
 scripts/Makefile.modpost                      | 15 +++
 scripts/mod/file2alias.c                      | 92 ++++++++++++++-----
 scripts/mod/modpost.c                         | 30 +++++-
 scripts/mod/modpost.h                         |  2 +
 14 files changed, 229 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/driver-api/usb/authorization.rst

-- 
2.39.2

