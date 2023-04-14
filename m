Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A9CC77B71
	for <linux-modules@archiver.kernel.org>; Fri, 14 Apr 2023 05:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDNFIv (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 14 Apr 2023 01:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjDNFIu (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 14 Apr 2023 01:08:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3427A4ECE;
        Thu, 13 Apr 2023 22:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=jhQgpcdU6gyeXMobM0XSItVG4AvZoQZZ5MixvI3m4K8=; b=HpNHcEsQXfVvSFJkEJm8E3PUH+
        kNmfgiNbIGwx5rIrHDAkIKGVBZlEn4AOltbU3ugrKNKKkFjMHm+Z36h56aM84Eqxi/ZOcD6elNgKW
        MSj8OpTEki2t+XXAGuR0XOtpf7oDXRW3O3nO2zqCFTxasw+9HbF45Wq7kubF+jOmyEvv/rPuelMgg
        FnHG1jGNse9yhUaRetIbIapaNZQEwlJIfkjXNAhjycsYOMhD19YkxeGd1+ZqmGlVySlFMATDbAn2V
        XmlAnRZajDT4FPi2fZsJXCoaW7mT6inrtz+CZs5BC0591Z1PBmbuGQuI84SqxJnsPeODsYP7XfslU
        BTtRi4SQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnBfp-008KKF-16;
        Fri, 14 Apr 2023 05:08:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, mcgrof@kernel.org
Subject: [PATCH v3 0/4] module: avoid userspace pressure on unwanted allocations
Date:   Thu, 13 Apr 2023 22:08:32 -0700
Message-Id: <20230414050836.1984746-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This v3 series follows up on the second iteration of these patches [0]. This
and other pending changes are avaiable on 20230413-module-alloc-opts
branch [1] which is based on modules-next.

Changes on this v3:

  o Catalin Marinas suggested we just use kmemleak_not_leak() for both
    ELF allocations even if its init stuff.
  o Considerable amount of effort went into trying to see if there's
    relationship with CPU count and wasted virtual memory allocations.
    The new module debugfs counters helped with creating this evaluation.
    The result of that put me on a path to then add even more debugging
    facilities to rule out and identify the culprits. In the end I have
    patches now which can get this down to 0 bytes wasted. The patch
    in this series which helps reduce the allocations has a graph
    showing the findings of the relationship between wasted virtual
    memory allocations and CPU count all during boot. It is insanity
    that the graph has to go into gigabytes of wasted virtual memory all
    at boot.
  o To help folks compare apples to apples I've put the stats debug
    patch *prior* to the one that helps with allocations. This way folks
    can see for themselves what the results look like.
  o Enhanced the statistics a bit more and added an example with 255 CPUs.
  o Went with atomic_long and casting for the debugs big counters.
  o Rolled in the patch that moved a helper as David suggested.
  o Minor fixes reported by 0-day
  o Added tags for Reviews, etc.

[0] https://lkml.kernel.org/r/20230405022702.753323-1-mcgrof@kernel.org
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230413-module-alloc-opts

Luis Chamberlain (4):
  module: fix kmemleak annotations for non init ELF sections
  module: extract patient module check into helper
  module: add debug stats to help identify memory pressure
  module: avoid allocation if module is already present and ready

 Documentation/core-api/kernel-api.rst |  22 +-
 kernel/module/Kconfig                 |  37 +++
 kernel/module/Makefile                |   1 +
 kernel/module/decompress.c            |   4 +
 kernel/module/internal.h              |  74 +++++
 kernel/module/main.c                  | 194 ++++++++----
 kernel/module/stats.c                 | 432 ++++++++++++++++++++++++++
 kernel/module/tracking.c              |   7 +-
 8 files changed, 703 insertions(+), 68 deletions(-)
 create mode 100644 kernel/module/stats.c

-- 
2.39.2

