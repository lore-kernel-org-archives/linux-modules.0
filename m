Return-Path: <SRS0=Ow/D=43=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378A9C10DCE
	for <linux-modules@archiver.kernel.org>; Tue, 10 Mar 2020 05:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C2F2467D
	for <linux-modules@archiver.kernel.org>; Tue, 10 Mar 2020 05:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgCJFBk (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 10 Mar 2020 01:01:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:16457 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgCJFBk (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 10 Mar 2020 01:01:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 22:01:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="353525567"
Received: from ldmartin1-desk.jf.intel.com ([10.165.21.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2020 22:01:39 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Yanko Kaneti <yaneti@declera.com>, gladkov.alexey@gmail.com,
        auke-jan.h.kok@intel.com,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 0/6] Fix modules.builtin.alias handling
Date:   Mon,  9 Mar 2020 22:00:23 -0700
Message-Id: <20200310050029.27678-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This should fix 2 bugs reported last week:

- `depmod -n` failing. Like for other binary indexes we just
  skip now

- programs like lspci failing since they don't ignore errors from
  kmod_load_resources() - the new modules.builtin.alias.bin may not
  exist if depmod from kmod 27 wasn't executed for that kernel version.
  Also modules.builtin.modinfo (from where the former is extracted) is
  only available on recent kernel versions. So make this index optional
  for kmod_load_resources() - other parts of the code already assume
  it's optional

Lucas De Marchi (6):
  gitignore: ignore .cache.mk when building modules
  depmod: do not output .bin to stdout
  libkmod: simplify lookup when builtin.modinfo.bin file is missing
  libkmod: fix return error when opening index
  libkmod: allow modules.alias.builtin to be optional
  testsuite: add check for kmod_load_resources

 libkmod/libkmod-index.c                       |  31 ++++++-----
 libkmod/libkmod-index.h                       |   4 +-
 libkmod/libkmod-module.c                      |   8 +--
 libkmod/libkmod.c                             |  50 ++++++++++--------
 testsuite/module-playground/.gitignore        |   1 +
 .../lib/modules/5.6.0/modules.alias           |   1 +
 .../lib/modules/5.6.0/modules.alias.bin       | Bin 0 -> 12 bytes
 .../lib/modules/5.6.0/modules.builtin         |   1 +
 .../lib/modules/5.6.0/modules.builtin.bin     | Bin 0 -> 39 bytes
 .../lib/modules/5.6.0/modules.dep             |   0
 .../lib/modules/5.6.0/modules.dep.bin         | Bin 0 -> 12 bytes
 .../lib/modules/5.6.0/modules.devname         |   1 +
 .../lib/modules/5.6.0/modules.softdep         |   1 +
 .../lib/modules/5.6.0/modules.symbols         |   1 +
 .../lib/modules/5.6.0/modules.symbols.bin     | Bin 0 -> 12 bytes
 testsuite/test-init.c                         |  31 +++++++++++
 tools/depmod.c                                |   6 ++-
 17 files changed, 95 insertions(+), 41 deletions(-)
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.builtin
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.symbols.bin

-- 
2.25.1

