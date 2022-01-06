Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D863C433EF
	for <linux-modules@archiver.kernel.org>; Thu,  6 Jan 2022 23:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245644AbiAFXnY (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 6 Jan 2022 18:43:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245626AbiAFXnX (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 6 Jan 2022 18:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641512603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zrSEVqbuwB224LNTaEpLTrbe7fqxzrVcpAcECOOMUH4=;
        b=BSsWNKHGLrm31y0sKWux/LXo5ydi6G2y+2B3xkKfboc0xC8HJZme+WrBMR6LGMdPUzD34F
        5Gv/rQpfwzAjF5UbF6Eo82qj25zyV2JQAM8Mj9nfSkYq0ZoQkxid+TKjWhxtqgwWuscKfE
        B9CA7dPje4PVXZL74CfsbJgco8ZNpf8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-mHnH_fMkONqnd3LXUjvmIg-1; Thu, 06 Jan 2022 18:43:22 -0500
X-MC-Unique: mHnH_fMkONqnd3LXUjvmIg-1
Received: by mail-wm1-f69.google.com with SMTP id p18-20020a05600c1d9200b00346da4a9e26so2345112wms.1
        for <linux-modules@vger.kernel.org>; Thu, 06 Jan 2022 15:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zrSEVqbuwB224LNTaEpLTrbe7fqxzrVcpAcECOOMUH4=;
        b=B36Ydd7bQrcG28TWVkkCbnET7ZxN/hn+flDjGl6+QV4k6rpEvF4lh1Z6FBFSyhopLs
         Ow6PW2Ubnh6LDiL8/+VawDkH+g5KaSADrTdHNEDRO+1eZ47G63S/JZO6zvQeWE/537c1
         2q97jAgOJhJbe+rfryhCcPBrpiFHvKyHXFhTSfvUxkr/dZefFD5Shk4fpr/YGCYo9YNn
         Nx0Jko9jrai1MxmY9ezIvXBQJwmv3p+1Yc7HLufI1SXCQWc1D0GCGsAQyX6yQLZEqIZA
         OxGZWYzkOTcxa4Es3vEANExgRAodsQWU5jyCv3olufLzeuDAM/mlIR5GA1NlI3WZd9n7
         64nQ==
X-Gm-Message-State: AOAM533CaaPY/apjA0n1n4x1kUEdCujhr5cx0wMyiQgQf7QFS0usnT95
        0s0jBCzd2ecyby1srW27mGaPfRKKVyz9aph5dfT5EoMMb9QgKOg7R4F/KRrRr6aR7AXXj10MovG
        K3T5FGFXOA5XpQ5w4XgSK9t+5
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr50303318wrj.688.1641512600856;
        Thu, 06 Jan 2022 15:43:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRdGC6HSiAXHCJ3PH755CZuns/3bohmjBLq2aJpvQsD9hmLkI21O6AqLwtdy1S4MB2Ky1TIA==
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr50303313wrj.688.1641512600706;
        Thu, 06 Jan 2022 15:43:20 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l2sm3389354wrz.8.2022.01.06.15.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:43:20 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v2 00/13] module: core code clean up
Date:   Thu,  6 Jan 2022 23:43:06 +0000
Message-Id: <20220106234319.2067842-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi Luis,

As per your suggestion [1], this is an attempt to refactor and split
optional code out of core module support code into separate components.
Unfortunately, nothing has been thoroughly tested yet. Please let me know
your thoughts.

Changes since v1 [2]:

  - Moved module version support code into a new file

[1]: https://lore.kernel.org/lkml/YbEZ4HgSYQEPuRmS@bombadil.infradead.org/
[2]: https://lore.kernel.org/lkml/20211228213041.1356334-1-atomlin@redhat.com/

Aaron Tomlin (13):
  module: Move all into module/
  module: Simple refactor in preparation for split
  module: Move livepatch support to a separate file
  module: Move latched RB-tree support to a separate file
  module: Move arch strict rwx support to a separate file
  module: Move strict rwx support to a separate file
  module: Move extra signature support out of core code
  module: Move kmemleak support to a separate file
  module: Move kallsyms support into a separate file
  module: Move procfs support into a separate file
  module: Move sysfs support into a separate file
  module: Move kdb_modules list out of core code
  module: Move version support into a separate file

 include/linux/module.h                        |   76 +-
 kernel/Makefile                               |    4 +-
 kernel/debug/kdb/kdb_main.c                   |    5 +
 kernel/module-internal.h                      |   31 -
 kernel/module/Makefile                        |   17 +
 kernel/module/arch_strict_rwx.c               |   44 +
 kernel/module/debug_kmemleak.c                |   30 +
 kernel/module/internal.h                      |  169 ++
 kernel/module/kallsyms.c                      |  506 +++++
 kernel/module/livepatch.c                     |   75 +
 kernel/{module.c => module/main.c}            | 1872 +----------------
 kernel/module/procfs.c                        |  111 +
 .../signature.c}                              |    0
 kernel/module/signing.c                       |  120 ++
 kernel/module/strict_rwx.c                    |   83 +
 kernel/module/sysfs.c                         |  426 ++++
 kernel/module/tree_lookup.c                   |  108 +
 kernel/module/version.c                       |  113 +
 kernel/module_signing.c                       |   45 -
 19 files changed, 1968 insertions(+), 1867 deletions(-)
 delete mode 100644 kernel/module-internal.h
 create mode 100644 kernel/module/Makefile
 create mode 100644 kernel/module/arch_strict_rwx.c
 create mode 100644 kernel/module/debug_kmemleak.c
 create mode 100644 kernel/module/internal.h
 create mode 100644 kernel/module/kallsyms.c
 create mode 100644 kernel/module/livepatch.c
 rename kernel/{module.c => module/main.c} (63%)
 create mode 100644 kernel/module/procfs.c
 rename kernel/{module_signature.c => module/signature.c} (100%)
 create mode 100644 kernel/module/signing.c
 create mode 100644 kernel/module/strict_rwx.c
 create mode 100644 kernel/module/sysfs.c
 create mode 100644 kernel/module/tree_lookup.c
 create mode 100644 kernel/module/version.c
 delete mode 100644 kernel/module_signing.c

-- 
2.31.1

