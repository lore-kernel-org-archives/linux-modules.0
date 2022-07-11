Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2D5C43334
	for <linux-modules@archiver.kernel.org>; Mon, 11 Jul 2022 17:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiGKR6F (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 11 Jul 2022 13:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiGKR6E (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 11 Jul 2022 13:58:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EFD7D1CD
        for <linux-modules@vger.kernel.org>; Mon, 11 Jul 2022 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+lulOm1zizunDwtXlUR10U7lyWn/ql7nPxzSa1eZg88=; b=gnOog/bhxJNNUZfo23PaUrIhLM
        Fw2RtiVEgW9oSch3+PUSRkKrN1C2RZ+UtNaH3UktC6qunyqShnv6zh+xQp8qtwQOeiuMJgZV654w2
        YNjPuIUWR8ZwFGDPiEGkNCy+WZ233cSMh9UICsulrLxxFG7Ij2EveoOQEfAHMbtMf9BbY8FHfqgqJ
        xsKaymAtNrd79of+OgADkzI0yjvSr5xyaQ6aIO2/iQry1MnfekVm+TYoA4i7dgFoHYxIyM4Oz0lGT
        hwnN2eOpwx2mab+E7jM362KHuk6eEifNr4Q24PWjO4K1NgBgU04sTAnecE8p5SHkUYBMFl3zs9P1S
        EdLmVvJA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAxfQ-003gFu-89; Mon, 11 Jul 2022 17:57:56 +0000
Date:   Mon, 11 Jul 2022 10:57:56 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-modules@vger.kernel.org
Subject: [GIT PULL] Modules fixes for v5.19-rc7
Message-ID: <YsxkpIjGs7YwdIai@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Linus,

here are some fixes for v5.17-rc7 which I've queued up since July 1st. Two
two critical fixes are the buffer overflow Fixed by Adrian Hunter due to a
possible incorrect length used, and a regression fix by Aaron Tomlin on
PREEMPT_RT=y as reported by Steven Rostedt since we're now starting to treat
PREEMPT_RT=y as a first class citizen.

Adrian Hunter's patch landed on my inbox July 1st on Friday right before
the long 4th of July holiday and the PREEMPT_RT=y fix just took some love
(until today to settle) on the commit log and hence the delay on these. I
don't foresee more fixes coming from the modules code move that was done
on v5.19-rc1.

In the future, for code moving around, we will want to ignore checkpatch
complaints as that may obfuscate code regressions, such as what happened
with the request to move from strlcpy() to using strscpy().

Other than Aaron's PREEMPT_RT=y, the rest of the code had gotten tested
through 0-day since July 2nd, but I only got to push all this to
linux-next today as I was waiting for Aaron's commit log adjustments
which finally settled today.

  Luis

The following changes since commit 1a0e93df1e107dc766fdf86ae88076efd9f376e6:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2022-06-30 10:03:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-5.19-rc7

for you to fetch changes up to e69a66147d49506062cd837f3b230ee3e98102ab:

  module: kallsyms: Ensure preemption in add_kallsyms() with PREEMPT_RT (2022-07-11 10:19:09 -0700)

----------------------------------------------------------------
modules-5.19-rc7

Although most of the move of code in in v5.19-rc1 should have not
introduced a regression patch review on one of the file changes captured
a checkpatch warning which advised to use strscpy() and it caused a
buffer overflow when an incorrect length is passed.

Another change which checkpatch complained about was an odd RCU usage,
but that was properly addressed in a separate patch to the move by Aaron.
That caused a regression with PREEMPT_RT=y due to an unbounded latency.

This series fixes both and adjusts documentation which we forgot to do
for the move.

----------------------------------------------------------------
Aaron Tomlin (1):
      module: kallsyms: Ensure preemption in add_kallsyms() with PREEMPT_RT

Adrian Hunter (1):
      modules: Fix corruption of /proc/kallsyms

Christophe Leroy (2):
      module: Fix selfAssignment cppcheck warning
      module: Fix "warning: variable 'exit' set but not used"

Masahiro Yamada (1):
      doc: module: update file references

 Documentation/core-api/kernel-api.rst              |  2 +-
 Documentation/core-api/symbol-namespaces.rst       |  4 +--
 Documentation/livepatch/module-elf-format.rst      | 10 +++----
 .../it_IT/core-api/symbol-namespaces.rst           |  6 ++--
 .../translations/zh_CN/core-api/kernel-api.rst     |  2 +-
 .../zh_CN/core-api/symbol-namespaces.rst           |  2 +-
 kernel/module/internal.h                           | 13 ++++----
 kernel/module/kallsyms.c                           | 35 ++++++++++++++--------
 kernel/module/main.c                               |  9 +++---
 9 files changed, 48 insertions(+), 35 deletions(-)

