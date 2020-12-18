Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD0AC3526D
	for <linux-modules@archiver.kernel.org>; Fri, 18 Dec 2020 16:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0428D23B6C
	for <linux-modules@archiver.kernel.org>; Fri, 18 Dec 2020 16:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgLRQDb (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:03:31 -0500
Received: from mga17.intel.com ([192.55.52.151]:59177 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbgLRQDb (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 18 Dec 2020 11:03:31 -0500
IronPort-SDR: ljjcXG0zod81apt4tauW9DX4B8zr8thE7w6bBeFLYOqn4TY3CTlant90UN/Y4iGu8J64B6G6/O
 JNKBajbBzszg==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="155257949"
X-IronPort-AV: E=Sophos;i="5.78,430,1599548400"; 
   d="scan'208";a="155257949"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 08:02:15 -0800
IronPort-SDR: OlyXUo/8i35jXi78+mxFModY5PRRNSYKb8hNKFD7LiCrRUcwDyVWCH/hQlTUMnWOvMMZhxjNVG
 zua1AByt7ptQ==
X-IronPort-AV: E=Sophos;i="5.78,430,1599548400"; 
   d="scan'208";a="388582539"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 08:02:14 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Joe Buehler <aspam@cox.net>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH 0/3] Fix kmod_load_resources without modules.builtin.modinfo
Date:   Fri, 18 Dec 2020 08:02:06 -0800
Message-Id: <20201218160209.4037174-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

When there isn't a modules.builtin.modinfo from the kernel, depmod
should not generate and 0-sized modules.builtin.alias.bin file. It
should rather be an empty index.

Lucas De Marchi (3):
  depmod: unconditionally write builtin.alias.bin
  shared: fix UNIQ definition
  testsuite: add test for empty modules.builtin.aliases.bin

 shared/macro.h                                     |   7 +++++--
 .../lib/modules/5.6.0/modules.alias                |   1 +
 .../lib/modules/5.6.0/modules.alias.bin            | Bin 0 -> 12 bytes
 .../lib/modules/5.6.0/modules.builtin              |   1 +
 .../lib/modules/5.6.0/modules.builtin.alias.bin    | Bin 0 -> 12 bytes
 .../lib/modules/5.6.0/modules.builtin.bin          | Bin 0 -> 39 bytes
 .../lib/modules/5.6.0/modules.dep                  |   0
 .../lib/modules/5.6.0/modules.dep.bin              | Bin 0 -> 12 bytes
 .../lib/modules/5.6.0/modules.devname              |   1 +
 .../lib/modules/5.6.0/modules.softdep              |   1 +
 .../lib/modules/5.6.0/modules.symbols              |   1 +
 .../lib/modules/5.6.0/modules.symbols.bin          | Bin 0 -> 12 bytes
 testsuite/test-init.c                              |   9 ++++++++-
 testsuite/testsuite.h                              |   2 +-
 tools/depmod.c                                     |  10 ++++++----
 15 files changed, 25 insertions(+), 8 deletions(-)
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.builtin
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.builtin.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources-empty-builtin-aliases-bin/lib/modules/5.6.0/modules.symbols.bin

-- 
2.29.2

