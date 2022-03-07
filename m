Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC16DC433F5
	for <linux-modules@archiver.kernel.org>; Mon,  7 Mar 2022 17:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbiCGRqL (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbiCGRqK (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 7 Mar 2022 12:46:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4207F71ED6
        for <linux-modules@vger.kernel.org>; Mon,  7 Mar 2022 09:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646675113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3QyULgURZo+6uEZj2m/mi84m4nCBBCarmgAZ6OebBIM=;
        b=JxpNk7I+73Iy8TVyGcD/LZ3FOythXAgEXtTmHxBUxy4RKDsrwkvo3tKzqZ70gkdL9wFLRH
        3EYJhvsx/kLz/Xev+29MLWQTeGX7fNNVDr2Xozm8IOIPrep0M2japG6TS+c7iXYJ4U4/CF
        BrGPjy40xgv0VHT+Khc4+JpfiK4hb/I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166--Q8apQB4NQqlSqNlCw1xCg-1; Mon, 07 Mar 2022 12:45:12 -0500
X-MC-Unique: -Q8apQB4NQqlSqNlCw1xCg-1
Received: by mail-wr1-f71.google.com with SMTP id b9-20020a05600003c900b00203647caa11so44772wrg.5
        for <linux-modules@vger.kernel.org>; Mon, 07 Mar 2022 09:45:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3QyULgURZo+6uEZj2m/mi84m4nCBBCarmgAZ6OebBIM=;
        b=Hp2VCXRdev5o0jZhNvF6Y9rpeLOExW8cy1FohCIiU1kTr0M6w/5hijpjXf54uYvv0+
         ujZmCgNbHn0riLf80lENO7VU1T1sO/0W3VGXCU9LdrLlMloPOoqVs7E0hl1jirGsglWz
         G2rxZwtlUKvjBUM1vjs9E7Znb1vIk/g36SBZD55FRdcWhI8B2WGorLp5UhNzxn0QeIg0
         utuvjaBNpZKq8Earh940lG92TaRue9KG04u2Vdm1j0jdKzEDA4ceLcjrThmHyfgLaRtu
         yQ6WipoYolTj0ntM6LXJukXqtqSf3/v/lUqoKycNGHHvf6wVDuGZ6X9nW0dKNJ5+35cx
         eQhw==
X-Gm-Message-State: AOAM532TGwvRROuC+OjzlGnmFP+PWj/0lbukA3ApKNhXCGYq2kwbRZ/K
        +Xeq1luoMuA/1YSgwjZAZ6Hxa6bPKaUbfq685Dd4z1Efwpc4Fs1CUbKRYppNsoh0n5SG3EtcxYj
        YP4sT4pK8jCuuYzKPgvr5jqMW
X-Received: by 2002:a5d:5241:0:b0:1f0:1842:efbd with SMTP id k1-20020a5d5241000000b001f01842efbdmr8741887wrc.320.1646675111183;
        Mon, 07 Mar 2022 09:45:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDR95/fNMNESfjqx7vSuy2h3B7Ap5W/NP7ggsrHKd6aLbcDlsSNLx/Dv1SqpmAb2F3S8yI+A==
X-Received: by 2002:a5d:5241:0:b0:1f0:1842:efbd with SMTP id k1-20020a5d5241000000b001f01842efbdmr8741868wrc.320.1646675110964;
        Mon, 07 Mar 2022 09:45:10 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l5-20020a5d6745000000b001f1e4e40e42sm6067482wrw.77.2022.03.07.09.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 09:45:10 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        hch@infradead.org, pmladek@suse.com
Subject: [PATCH v10 00/14] module: core code clean up
Date:   Mon,  7 Mar 2022 17:44:55 +0000
Message-Id: <20220307174509.2887714-1-atomlin@redhat.com>
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

Changes since v9 [2]
 - Updated MAINTAINERS to include kernel/module/livepatch.c
   and kernel/module/kdb.c, respectively
 - Moved kdb module related code i.e. support for the 'lsmod',
   out of core/or main kdb code into its own file under
   kernel/module
 - Ensured is_module_sig_enforced(), as a stub, is available
   when Kconfig CONFIG_MODULE_SIG is not enabled/or selected
   (Christophe Leroy)

Changes since v8 [3]

 - Resolved the reported lockdep warnings in kernel/module/kallsyms.c
   (Petr Mladek)

Changes since v7 [4]

 - Removed redundant ifdef CONFIG_MODULES and endif pairing from
   kernel/module/Makefile

Changes since v6 [5]

 - Moved KCOV_INSTRUMENT_module.o out of kernel/Makefile into
   kernel/module/Makefile (Christophe Leroy)
 - Moved kernel/module/signature.c back into kernel/
   (Christophe Leroy)
 - Fixed Oops in add_kallsyms() due to an invalid pointer assignment
   (Christophe Leroy)

Changes since v5 [6]:

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

Changes since v4 [7]:

 - Moved is_livepatch_module() and set_livepatch_module() to
   kernel/module/livepatch.c
 - Addressed minor compiler warning concerning
   kernel/module/internal.h (0-day)
 - Resolved style violations reported by scripts/checkpatch.pl
 - Dropped patch 5 [8] so external patch [9] can be applied at
   a later date post merge into module-next (Christophe Leroy)

Changes since v3 [10]:

 - Refactored both is_livepatch_module() and set_livepatch_module(),
   respectively, to use IS_ENABLED(CONFIG_LIVEPATCH) (Joe Perches)
 - Addressed various compiler warnings e.g., no previous prototype (0-day)

Changes since v2 [11]:

 - Moved module decompress support to a separate file
 - Made check_modinfo_livepatch() generic (Petr Mladek)
 - Removed filename from each newly created file (Luis Chamberlain)
 - Addressed some (i.e. --ignore=ASSIGN_IN_IF,AVOID_BUG was used)
   minor scripts/checkpatch.pl concerns e.g., use strscpy over
   strlcpy and missing a blank line after declarations (Allen)

Changes since v1 [12]:

  - Moved module version support code into a new file

[1]: https://lore.kernel.org/lkml/YbEZ4HgSYQEPuRmS@bombadil.infradead.org/
[2]: https://lore.kernel.org/lkml/20220228234322.2073104-1-atomlin@redhat.com/
[3]: https://lore.kernel.org/all/20220222141303.1392190-2-atomlin@redhat.com/
[4]: https://lore.kernel.org/lkml/20220222130911.1348513-1-atomlin@redhat.com/
[5]: https://lore.kernel.org/lkml/20220218212511.887059-1-atomlin@redhat.com/
[6]: https://lore.kernel.org/lkml/20220209170358.3266629-1-atomlin@redhat.com/
[7]: https://lore.kernel.org/lkml/20220130213214.1042497-1-atomlin@redhat.com/
[8]: https://lore.kernel.org/lkml/20220130213214.1042497-6-atomlin@redhat.com/
[9]: https://lore.kernel.org/lkml/203348805c9ac9851d8939d15cb9802ef047b5e2.1643919758.git.christophe.leroy@csgroup.eu/
[10]: https://lore.kernel.org/lkml/20220128203934.600247-1-atomlin@redhat.com/
[11]: https://lore.kernel.org/lkml/20220106234319.2067842-1-atomlin@redhat.com/
[12]: https://lore.kernel.org/lkml/20211228213041.1356334-1-atomlin@redhat.com/


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
  module: Move kdb module related code out of main kdb code
  module: Move version support into a separate file

 MAINTAINERS                                   |    4 +-
 include/linux/kdb.h                           |    1 +
 include/linux/module.h                        |   21 +-
 kernel/Makefile                               |    5 +-
 kernel/debug/kdb/kdb_main.c                   |   49 -
 kernel/module-internal.h                      |   50 -
 kernel/module/Makefile                        |   21 +
 kernel/module/debug_kmemleak.c                |   30 +
 .../decompress.c}                             |    5 +-
 kernel/module/internal.h                      |  275 +++
 kernel/module/kallsyms.c                      |  512 +++++
 kernel/module/kdb.c                           |   55 +
 kernel/module/livepatch.c                     |   74 +
 kernel/{module.c => module/main.c}            | 1856 +----------------
 kernel/module/procfs.c                        |  142 ++
 kernel/module/signing.c                       |  122 ++
 kernel/module/strict_rwx.c                    |   85 +
 kernel/module/sysfs.c                         |  436 ++++
 kernel/module/tree_lookup.c                   |  109 +
 kernel/module/version.c                       |  109 +
 kernel/module_signing.c                       |   45 -
 21 files changed, 2074 insertions(+), 1932 deletions(-)
 delete mode 100644 kernel/module-internal.h
 create mode 100644 kernel/module/Makefile
 create mode 100644 kernel/module/debug_kmemleak.c
 rename kernel/{module_decompress.c => module/decompress.c} (99%)
 create mode 100644 kernel/module/internal.h
 create mode 100644 kernel/module/kallsyms.c
 create mode 100644 kernel/module/kdb.c
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

