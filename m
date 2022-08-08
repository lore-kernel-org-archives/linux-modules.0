Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A89FC00140
	for <linux-modules@archiver.kernel.org>; Mon,  8 Aug 2022 15:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243283AbiHHPxW (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 8 Aug 2022 11:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiHHPxV (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 8 Aug 2022 11:53:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2CED8F
        for <linux-modules@vger.kernel.org>; Mon,  8 Aug 2022 08:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fGgS4I4JEMlEpFDKLmo/A9VwbeOnF7UjtRxOWjqb5J4=; b=D71J2nR1FFLesgghtj9J9koz9b
        NNd3lQ9T0tYalZABzfLwQc3EUPqUeeY+vbRPaev97zNXay7nCoIzjIZqjzc2lp/8f9xvr9cLqxxpP
        pRNY31PoA45QzX90mNY6PFmR57zGmcR/BvR7LVtypLGHaO9a3QDR+UAZFAiJV4sPremNDO7q9bT/d
        ZPhuRd6RgzMrgQ5JsyuKn9N+v9HjPWic+uPbFLnG7aKHPkNWBGJjR4MJe82p7KEEwHETPP2ZWvkw6
        hZElvPYVvQdp+caMidtgXoU58doRW6lRGEew/OygOO/ibA92g/fkfvbQ+yxOsu/MzjW/qRbdK+ozx
        Ail33cFQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oL53x-00EmlQ-So; Mon, 08 Aug 2022 15:53:05 +0000
Date:   Mon, 8 Aug 2022 08:53:05 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        fmdefrancesco@gmail.com, deller@gmx.de, yangyingliang@huawei.com,
        saravanak@google.com, mcgrof@kernel.org,
        linux-modules@vger.kernel.org
Subject: [GIT PULL] Modules updates for v6.0-rc1
Message-ID: <YvExYYWJY4HRi/NS@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The following changes since commit 1a0e93df1e107dc766fdf86ae88076efd9f376e6:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2022-06-30 10:03:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.0-rc1

for you to fetch changes up to 554694ba120b87e39cf732ed632e6a0c52fafb7c:

  module: Replace kmap() with kmap_local_page() (2022-07-20 14:27:46 -0700)

----------------------------------------------------------------
Modules updates for 6.0

For the 6.0 merge window the modules code shifts to cleanup and minor fixes
effort. This is becomes much easier to do and review now due to the code
split to its own directory from effort on the last kernel release. I expect
to see more of this with time and as we expand on test coverage in the future.
The cleanups and fixes come from usual suspects such as Christophe Leroy and
Aaron Tomlin but there are also some other contributors.

One particular minor fix worth mentioning is from Helge Deller, where he spotted
a *forever* incorrect natural alignment on both ELF section header tables:

  * .altinstructions
  * __bug_table sections

A lot of back and forth went on in trying to determine the ill effects of this
misalignment being present for years and it has been determined there should
be no real ill effects unless you have a buggy exception handler. Helge actually
hit one of these buggy exception handlers on parisc which is how he ended up
spotting this issue. When implemented correctly these paths with incorrect
misalignment would just mean a performance penalty, but given that we are
dealing with alternatives on modules and with the __bug_table (where info
regardign BUG()/WARN() file/line information associated with it is stored)
this really shouldn't be a big deal.

The only other change with mentioning is the kmap() with kmap_local_page()
and my only concern with that was on what is done after preemption, but the
virtual addresses are restored after preemption. This is only used on module
decompression.

This all has sit on linux-next for a while except the kmap stuff which has
been there for 3 weeks.

----------------------------------------------------------------
Aaron Tomlin (4):
      module: kallsyms: Ensure preemption in add_kallsyms() with PREEMPT_RT
      module: Modify module_flags() to accept show_state argument
      module: Use strscpy() for last_unloaded_module
      module: Show the last unloaded module's taint flag(s)

Adrian Hunter (1):
      modules: Fix corruption of /proc/kallsyms

Christophe Leroy (5):
      module: Fix selfAssignment cppcheck warning
      module: Fix "warning: variable 'exit' set but not used"
      module: Fix ERRORs reported by checkpatch.pl
      module: Increase readability of module_kallsyms_lookup_name()
      module: Move module's Kconfig items in kernel/module/

Fabio M. De Francesco (1):
      module: Replace kmap() with kmap_local_page()

Helge Deller (2):
      modules: Ensure natural alignment for .altinstructions and __bug_table sections
      MAINTAINERS: Update file list for module maintainers

Masahiro Yamada (1):
      doc: module: update file references

Saravana Kannan (1):
      module: Add support for default value for module async_probe

Yang Yingliang (1):
      module: Use vzalloc() instead of vmalloc()/memset(0)

 Documentation/admin-guide/kernel-parameters.txt    |  17 +-
 Documentation/core-api/kernel-api.rst              |   2 +-
 Documentation/core-api/symbol-namespaces.rst       |   4 +-
 Documentation/livepatch/module-elf-format.rst      |  10 +-
 .../it_IT/core-api/symbol-namespaces.rst           |   6 +-
 .../translations/zh_CN/core-api/kernel-api.rst     |   2 +-
 .../zh_CN/core-api/symbol-namespaces.rst           |   2 +-
 MAINTAINERS                                        |   1 +
 init/Kconfig                                       | 293 +--------------------
 kernel/module/Kconfig                              | 293 +++++++++++++++++++++
 kernel/module/decompress.c                         |   8 +-
 kernel/module/internal.h                           |  15 +-
 kernel/module/kallsyms.c                           |  76 ++++--
 kernel/module/main.c                               |  52 ++--
 kernel/module/procfs.c                             |   2 +-
 scripts/module.lds.S                               |   2 +
 16 files changed, 423 insertions(+), 362 deletions(-)
 create mode 100644 kernel/module/Kconfig
