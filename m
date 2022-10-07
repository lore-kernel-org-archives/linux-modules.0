Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4407C433FE
	for <linux-modules@archiver.kernel.org>; Fri,  7 Oct 2022 00:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiJGALY (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 6 Oct 2022 20:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiJGALX (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 6 Oct 2022 20:11:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC4DC2C84
        for <linux-modules@vger.kernel.org>; Thu,  6 Oct 2022 17:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zv3Bs/f97akjpHKHZqSglgDx3YvTvB3RBQDo7mLCjyw=; b=oLLFLUeOzMqlBHfzSDBRwGFHUm
        EsqPT0T7jKMz8fi7YWtaIV6tpGxODJ10FfceOXaopak0dSQUCoSnG5UhJKcbkrt/54eb03BYz02qs
        ftNfIy8evFymdRSWgBtXpd5qZ0mRIN69EB96zVFXLRR4p9rO+veGCiHD8P1AJP0w92ovzlGMXHrL3
        KEw8yzwMXRFsYvODosnSGqLGcQgclku7/gGb/AL88aIPJP/c2a03S4sO/IPDZ0vyH4SrSnvYoVAL4
        fRl3Ey6wVrb6KioZYccWKoLtp9C8bUpYHJ89fUfmC0inbIqcRuzkZ/bymniAHQH1eNJv8oucwB/WJ
        eHmcARuA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogaxS-0069v7-JE; Fri, 07 Oct 2022 00:11:18 +0000
Date:   Thu, 6 Oct 2022 17:11:18 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ddiss@suse.de, Aaron Tomlin <atomlin@redhat.com>,
        Song Liu <song@kernel.org>, linux-modules@vger.kernel.org,
        mcgrof@kernel.org
Subject: [GIT PULL] Modules updates for v6.1-rc1
Message-ID: <Yz9upiun+Y4FUMbV@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:

  Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.1-rc1

for you to fetch changes up to 77d6354bd422c8a451ef7d2235322dbf33e7427b:

  module/decompress: generate sysfs string at compile time (2022-09-08 17:00:43 -0700)

----------------------------------------------------------------
Modules changes for v6.1-rc1

There's only two pathes queued up for v6.1 for modules, these have
been grinding on linux-next for at least 4 weeks now:

  * David Disseldorp's minor enhancement for sysfs compression string
  * Aaron Tomlin's debugfs interface to view unloaded tainted modules

But there are other changes queued up for testing for the next merge
window already. One change being still discussed, and *not* yet even close
to testing on linux-next, but worth mentioning to put on your radar is
the generalization of the bpf prog_pack thing. The idea with that is to
generalize the iTLB gains seen with using huge pages on eBPF to other text
uses on the kernel (modules, ftrace, kprobes). Song Liu is doing a good job
following up on that difficult task as the semantics for the special
permissions are crap, and it really hasn't been easy to put all this
together. The latest effort can be read on his vmalloc_exec() patch
series [0].

Aaron will have a fix posted soon for the debugfs interface for unloaded
modules, when that comes I'll just bounce that to you as it should be
merged.

[0] https://lkml.kernel.org/r/20220818224218.2399791-1-song@kernel.org

----------------------------------------------------------------
Aaron Tomlin (1):
      module: Add debugfs interface to view unloaded tainted modules

David Disseldorp (1):
      module/decompress: generate sysfs string at compile time

 kernel/module/decompress.c |  2 +-
 kernel/module/tracking.c   | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)
