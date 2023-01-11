Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACD1C46467
	for <linux-modules@archiver.kernel.org>; Wed, 11 Jan 2023 15:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjAKPaC (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbjAKP3w (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 11 Jan 2023 10:29:52 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFD118E34
        for <linux-modules@vger.kernel.org>; Wed, 11 Jan 2023 07:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673450991; x=1704986991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=93msDzqfKHp8dWrIqQnasrK0bPBCm2BMHywSdcfZ+hw=;
  b=c8+zR2xDEp5BPyP0zTo88uarXLiIJHaMGv6HiNSheviuOKjqIZAk8Qgb
   194LPNkwPV9uyXuHhq1Jj5dr/VMpBfGXntcQUBSPcLC9dE23U9+hDpbH0
   lSFqDIW0hc1lHHCRKa96q312HIxNRWmSZRquMTeyR5ldUGY44MPFHfkMd
   j25wd+qedm/hjAE+SMIbO5DX7MA79/Wlxxag8akbcOJkHnNDgWxvbBn7t
   5+IQz7+Bf9Z5sLDgfPNgpB9tVhp/E0Lr8zQWdk2mKk5kBeEXxrOBJF2DW
   V7cYCQQmzttDIsGqz4xsWU/AOU8YdnNm/aYnJGwVelNYG+rQlwL4b6AHI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="409684975"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="409684975"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 07:29:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="720758702"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="720758702"
Received: from dhuo-mobl2.amr.corp.intel.com (HELO gjsousa-mobl2.intel.com) ([10.212.66.3])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 07:29:49 -0800
From:   Gustavo Sousa <gustavo.sousa@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Gustavo Sverzut Barbieri <barbieri@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>
Subject: [PATCH 0/2] Allow passing module files to modprobe
Date:   Wed, 11 Jan 2023 12:29:34 -0300
Message-Id: <20230111152936.101040-1-gustavo.sousa@intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This patch series allows modprobe to be called with a direct path to a
module object. This is specially useful for testing just compiled modules when
they have dependencies, which are loaded with insmod.

Gustavo Sousa (2):
  modprobe: Move insertion block into separate function
  modprobe: Allow passing path to module

 man/modprobe.xml                              |   5 +
 testsuite/populate-modules.sh                 |   1 +
 .../lib/modules/4.4.4/modules.alias           |   1 +
 .../lib/modules/4.4.4/modules.alias.bin       | Bin 0 -> 12 bytes
 .../lib/modules/4.4.4/modules.builtin.bin     |   0
 .../lib/modules/4.4.4/modules.dep             |   1 +
 .../lib/modules/4.4.4/modules.dep.bin         | Bin 0 -> 73 bytes
 .../lib/modules/4.4.4/modules.devname         |   0
 .../lib/modules/4.4.4/modules.softdep         |   1 +
 .../lib/modules/4.4.4/modules.symbols         |   1 +
 .../lib/modules/4.4.4/modules.symbols.bin     | Bin 0 -> 12 bytes
 .../module-from-path/proc/modules             |   0
 testsuite/test-modprobe.c                     |  22 ++++
 tools/modprobe.c                              | 111 +++++++++++-------
 14 files changed, 98 insertions(+), 45 deletions(-)
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.symbols.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/proc/modules

-- 
2.39.0

