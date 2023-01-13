Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2CBC6379F
	for <linux-modules@archiver.kernel.org>; Fri, 13 Jan 2023 21:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjAMViF (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 13 Jan 2023 16:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjAMViA (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 13 Jan 2023 16:38:00 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0211FB851
        for <linux-modules@vger.kernel.org>; Fri, 13 Jan 2023 13:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673645878; x=1705181878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6tsLqmwl01JJJ3hT41Jhq8T7YHrlYl1AG8LnLTR/ESg=;
  b=gJiMkLpzyCkYPlLXqM+5P+qUBCb3pWHzPV/53rq0Aqed7JRoYpxeA61f
   kKjD0F6Y4ZU6jvX/z4rbTR3eAtu9qS1nTRdSiWGl0TM4/IgaSY3XWJmJn
   sPQh1QlRiRNakFpUGgZx2gSbNJODUM8YOeuPwfF71e5z1nzffUCIHiml/
   IxE2Gbqcug4oFT7S7g3YLoZKFS2+1orn0t1pDXvvH785JsZZu+YWKW+zS
   8moXDyirCfFBy+gPumQhE38Jc2gkLTxiBuyDDCZUycr36mHL99e7ELHi3
   S4nPznCZvCM9mnEqXqq1iVy6kyT6RWpmCynJAlHD8zwfqjbEUc6MaWYyn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="307661042"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="307661042"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:37:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="800725244"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="800725244"
Received: from kcknighx-mobl.amr.corp.intel.com (HELO gjsousa-mobl2.intel.com) ([10.212.91.228])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:37:53 -0800
From:   Gustavo Sousa <gustavo.sousa@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>
Subject: [PATCH v2 0/3] Allow passing module files to modprobe
Date:   Fri, 13 Jan 2023 18:37:42 -0300
Message-Id: <20230113213745.227703-1-gustavo.sousa@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111152936.101040-1-gustavo.sousa@intel.com>
References: <20230111152936.101040-1-gustavo.sousa@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This patch series allows modprobe to be called with a direct path to a
module object.

v2:
  - Add a patch to wrap chdir().
  - Add test for relative path as well. (Lucas)
  - Add note warning about modules with dependencies not matching the
    installed depmod database. (Lucas)

Gustavo Sousa (3):
  testsuite: Wrap chdir()
  modprobe: Move insertion block into separate function
  modprobe: Allow passing path to module

 man/modprobe.xml                              |   7 ++
 testsuite/path.c                              |   1 +
 testsuite/populate-modules.sh                 |   2 +
 .../lib/modules/4.4.4/modules.alias           |   1 +
 .../lib/modules/4.4.4/modules.alias.bin       | Bin 0 -> 12 bytes
 .../lib/modules/4.4.4/modules.builtin.bin     |   0
 .../lib/modules/4.4.4/modules.dep             |   1 +
 .../lib/modules/4.4.4/modules.dep.bin         | Bin 0 -> 73 bytes
 .../lib/modules/4.4.4/modules.devname         |   0
 .../lib/modules/4.4.4/modules.softdep         |   1 +
 .../lib/modules/4.4.4/modules.symbols         |   1 +
 .../lib/modules/4.4.4/modules.symbols.bin     | Bin 0 -> 12 bytes
 .../module-from-abspath/proc/modules          |   0
 .../lib/modules/4.4.4/modules.alias           |   1 +
 .../lib/modules/4.4.4/modules.alias.bin       | Bin 0 -> 12 bytes
 .../lib/modules/4.4.4/modules.builtin.bin     |   0
 .../lib/modules/4.4.4/modules.dep             |   1 +
 .../lib/modules/4.4.4/modules.dep.bin         | Bin 0 -> 73 bytes
 .../lib/modules/4.4.4/modules.devname         |   0
 .../lib/modules/4.4.4/modules.softdep         |   1 +
 .../lib/modules/4.4.4/modules.symbols         |   1 +
 .../lib/modules/4.4.4/modules.symbols.bin     | Bin 0 -> 12 bytes
 .../module-from-relpath/proc/modules          |   0
 testsuite/test-modprobe.c                     |  50 ++++++++
 tools/modprobe.c                              | 111 +++++++++++-------
 25 files changed, 134 insertions(+), 45 deletions(-)
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/lib/modules/4.4.4/modules.symbols.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-abspath/proc/modules
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/lib/modules/4.4.4/modules.symbols.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-relpath/proc/modules

-- 
2.39.0

