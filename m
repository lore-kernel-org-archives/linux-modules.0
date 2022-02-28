Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39ACC433F5
	for <linux-modules@archiver.kernel.org>; Mon, 28 Feb 2022 23:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiB1XoK (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 28 Feb 2022 18:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiB1XoJ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 28 Feb 2022 18:44:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18A633EAA4
        for <linux-modules@vger.kernel.org>; Mon, 28 Feb 2022 15:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646091807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZsO5SHy1I6b3tB1bQC/KAIGXiQjK/513nyyjen0vjSM=;
        b=XORK++K6tSZ4u8Xr87DYD8pxoliT8CxseS7x3d0Fv/XN4sJfQY/ZETDWhcZlwc0GoNbrRk
        aZhMcgPRGzl+2ndRCMpyCnpET8pOUGlFmXbDzIMCsI2EWNKbGc/nUTMfU0TYqySRhNJ+QI
        Hio/f+NKwaAF+CUmqHYP7CXtFFEoBg4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-sLWJD5DPNEyQTyhjyqcU4Q-1; Mon, 28 Feb 2022 18:43:25 -0500
X-MC-Unique: sLWJD5DPNEyQTyhjyqcU4Q-1
Received: by mail-wm1-f71.google.com with SMTP id i131-20020a1c3b89000000b0037bb9f6feeeso320571wma.5
        for <linux-modules@vger.kernel.org>; Mon, 28 Feb 2022 15:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZsO5SHy1I6b3tB1bQC/KAIGXiQjK/513nyyjen0vjSM=;
        b=Drz/oEIEFKEmgT6XIqdU17lEyzts9pGieCfBqoqpHQVZK3gDYSxSKAzd20b7qDD7F7
         zRUiq1itfBcRAShqewOwz/zHFOFwJC73lhaByq1u4E0B4NRMEdPmOEVJxirD/1Q1B3Wg
         49818g1St1e7sqSCGA8cavwtziLVQqOmyU2oXAlrcmarQ6egKbHoeOuxzKagmJJ6hpzm
         TfDMAYQFwBKJI/JTcmQM67f1r7r5oHhz5hDVUZehtQbN+nim2JpCwbV0nuZ6Wtx7lN98
         YQot8czG7CCchn4mZLViV8g4zaOESRgnBoUoEW/6M9iIW1U3I02MSb1HB6/JqYKHT5mM
         fiMQ==
X-Gm-Message-State: AOAM531GJIJTX0geY81BP5RVWPNiGxve5+gW0jb4ccn+3Ny8sxzBgy1o
        gfyzqyjXpnG3nZ8BgwQIh0bmyxHwwtbGBOZnVu+bo0Y6Hy+QWwoQ7Mg/YkfBouxxx49Z+mRAtaX
        zoY3p8OK0NHv+WRt1CYn8G75F
X-Received: by 2002:adf:d1e8:0:b0:1ef:f9a5:b114 with SMTP id g8-20020adfd1e8000000b001eff9a5b114mr2439714wrd.537.1646091804519;
        Mon, 28 Feb 2022 15:43:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTsVJqE3C8HPuDzAECv2PXacc2nnmBw8TXmYZQASk8rOqjI2TxGaUw4M6jgOq6cQKp9W6w6w==
X-Received: by 2002:adf:d1e8:0:b0:1ef:f9a5:b114 with SMTP id g8-20020adfd1e8000000b001eff9a5b114mr2439688wrd.537.1646091804298;
        Mon, 28 Feb 2022 15:43:24 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f17-20020adffcd1000000b001edbf438d83sm11866792wrs.32.2022.02.28.15.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:43:23 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, pmladek@suse.com
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org
Subject: [PATCH v9 00/14] module: core code clean up
Date:   Mon, 28 Feb 2022 23:43:08 +0000
Message-Id: <20220228234322.2073104-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi Luis,

As per your suggestion [1], this is an attempt to refactor and split
optional code out of core module support code into separate components.
This version is based on Linus' commit 7993e65fdd0f ("Merge tag
'mtd/fixes-for-5.17-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux").

Petr,

I decided to use preempt_disable() instead to remain consistent with the
rest of the file. Unfortunately, I did not make time to boot test etc.

Changes since v8 [2]

 - Resolved the reported lockdep warnings in kernel/module/kallsyms.c
   (Petr Mladek)

Changes since v7 [3]

 - Removed redundant ifdef CONFIG_MODULES and endif pairing from
   kernel/module/Makefile

Changes since v6 [4]

 - Moved KCOV_INSTRUMENT_module.o out of kernel/Makefile into
   kernel/module/Makefile (Christophe Leroy)
 - Moved kernel/module/signature.c back into kernel/
   (Christophe Leroy)
 - Fixed Oops in add_kallsyms() due to an invalid pointer assignment
   (Christophe Leroy)

Changes since v5 [5]:

 - Updated MAINTAINERS to include the entire kernel/module/ directory
   (Christophe Leroy)
 - Reintroduce commit a97ac8cb24a3 ("module: fix signature check failures
   when using in-kernel decompression") (Michal Suchánek)
 - Refactored code to address some (i.e.
   --ignore=MULTIPLE_ASSIGNMENTS,ASSIGN_IN_IF was used) style violations
   e.g. "Alignment should match open parenthesis", reported by
   scripts/checkpatch.pl --strict (Christophe Leroy)
 - Used PAGE_ALIGN() and PAGE_ALIGNED() instead (Christophe Leroy)
 - Removed sig_enforce from include/linux/module.h as it is only
   used in kernel/module/signing.c (Christophe Leroy)
 - Added static keyword for anything not used outside a source file
   (Christophe Leroy)
 - Moved mod_sysfs_teardown() to kernel/module/sysfs.c (Christophe Leroy)
 - Removed kdb_modules from kernel/debug/kdb/kdb_private.h
   (Christophe Leroy)

Changes since v4 [6]:

 - Moved is_livepatch_module() and set_livepatch_module() to
   kernel/module/livepatch.c
 - Addressed minor compiler warning concerning
   kernel/module/internal.h (0-day)
 - Resolved style violations reported by scripts/checkpatch.pl
 - Dropped patch 5 [7] so external patch [8] can be applied at
   a later date post merge into module-next (Christophe Leroy)

Changes since v3 [9]:

 - Refactored both is_livepatch_module() and set_livepatch_module(),
   respectively, to use IS_ENABLED(CONFIG_LIVEPATCH) (Joe Perches)
 - Addressed various compiler warnings e.g., no previous prototype (0-day)

Changes since v2 [10]:

 - Moved module decompress support to a separate file
 - Made check_modinfo_livepatch() generic (Petr Mladek)
 - Removed filename from each newly created file (Luis Chamberlain)
 - Addressed some (i.e. --ignore=ASSIGN_IN_IF,AVOID_BUG was used)
   minor scripts/checkpatch.pl concerns e.g., use strscpy over
   strlcpy and missing a blank line after declarations (Allen)

Changes since v1 [11]:

  - Moved module version support code into a new file

[1]: https://lore.kernel.org/lkml/YbEZ4HgSYQEPuRmS@bombadil.infradead.org/
[2]: https://lore.kernel.org/all/20220222141303.1392190-2-atomlin@redhat.com/
[3]: https://lore.kernel.org/lkml/20220222130911.1348513-1-atomlin@redhat.com/
[4]: https://lore.kernel.org/lkml/20220218212511.887059-1-atomlin@redhat.com/
[5]: https://lore.kernel.org/lkml/20220209170358.3266629-1-atomlin@redhat.com/
[6]: https://lore.kernel.org/lkml/20220130213214.1042497-1-atomlin@redhat.com/
[7]: https://lore.kernel.org/lkml/20220130213214.1042497-6-atomlin@redhat.com/
[8]: https://lore.kernel.org/lkml/203348805c9ac9851d8939d15cb9802ef047b5e2.1643919758.git.christophe.leroy@csgroup.eu/
[9]: https://lore.kernel.org/lkml/20220128203934.600247-1-atomlin@redhat.com/
[10]: https://lore.kernel.org/lkml/20220106234319.2067842-1-atomlin@redhat.com/
[11]: https://lore.kernel.org/lkml/20211228213041.1356334-1-atomlin@redhat.com/


Aaron Tomlin (14):
  module: Move all into module/
  module: Simple refactor in preparation for split
  module: Make internal.h and decompress.c more compliant
  module: Move livepatch support to a separate file
  module: Move latched RB-tree support to a separate file
  module: Move strict rwx support to a separate file
  module: Move extra signature support out of core code
  module: Move kmemleak support to a separate file
  module: Move kallsyms support into a separate file
  module: kallsyms: Fix suspicious rcu usage
  module: Move procfs support into a separate file
  module: Move sysfs support into a separate file
  module: Move kdb_modules list out of core code
  module: Move version support into a separate file

 MAINTAINERS                                   |    2 +-
 include/linux/module.h                        |    9 +-
 kernel/Makefile                               |    5 +-
 kernel/debug/kdb/kdb_main.c                   |    5 +
 kernel/debug/kdb/kdb_private.h                |    4 -
 kernel/module-internal.h                      |   50 -
 kernel/module/Makefile                        |   20 +
 kernel/module/debug_kmemleak.c                |   30 +
 .../decompress.c}                             |    5 +-
 kernel/module/internal.h                      |  275 +++
 kernel/module/kallsyms.c                      |  512 +++++
 kernel/module/livepatch.c                     |   74 +
 kernel/{module.c => module/main.c}            | 1856 +----------------
 kernel/module/procfs.c                        |  142 ++
 kernel/module/signing.c                       |  122 ++
 kernel/module/strict_rwx.c                    |   85 +
 kernel/module/sysfs.c                         |  436 ++++
 kernel/module/tree_lookup.c                   |  109 +
 kernel/module/version.c                       |  109 +
 kernel/module_signing.c                       |   45 -
 20 files changed, 2013 insertions(+), 1882 deletions(-)
 delete mode 100644 kernel/module-internal.h
 create mode 100644 kernel/module/Makefile
 create mode 100644 kernel/module/debug_kmemleak.c
 rename kernel/{module_decompress.c => module/decompress.c} (99%)
 create mode 100644 kernel/module/internal.h
 create mode 100644 kernel/module/kallsyms.c
 create mode 100644 kernel/module/livepatch.c
 rename kernel/{module.c => module/main.c} (64%)
 create mode 100644 kernel/module/procfs.c
 create mode 100644 kernel/module/signing.c
 create mode 100644 kernel/module/strict_rwx.c
 create mode 100644 kernel/module/sysfs.c
 create mode 100644 kernel/module/tree_lookup.c
 create mode 100644 kernel/module/version.c
 delete mode 100644 kernel/module_signing.c


base-commit: 7993e65fdd0fe07beb9f36f998f9bbef2c0ee391
-- 
2.34.1

