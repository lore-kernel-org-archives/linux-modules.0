Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598AEC76195
	for <linux-modules@archiver.kernel.org>; Sun, 19 Mar 2023 21:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCSV1z (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 19 Mar 2023 17:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjCSV1x (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 19 Mar 2023 17:27:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D061B2DE;
        Sun, 19 Mar 2023 14:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=7+6ZTjnVMoSxpFh78XaqXokhkEXqNDoP1QvzzNxosuw=; b=yeSemKCs0QC+83yQNr36o7wqkr
        8jvLVxF2hHsCKLwOg85AHPjKKkVrVlfwPVWsvFIIREkkRiWyEF3vCter9fcrSn/mM7smtog8bk25l
        f6zPkxOAuhJfZabEOdkhBFrJfRxfgI5MhTuk+cE2/z22C0viGYgUdETw217y9Z746Rsj5kz02guWt
        sonHqzwIu9AikD3va+PTvNyBKckXMzQJtxIROZKXBk8U7h7pl8IJMbZYxSx1SIs4Z9rdlmIAU8L9T
        KbXeSBaJzz3y2k0ZZsrSx3TZo+ZZ1SqcA/xrL8i0eQQH1baXxhWg8n0iWiJw1CdMleaFrvWCrUbxa
        CpohGslA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0Z9-007Tqx-24;
        Sun, 19 Mar 2023 21:27:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 00/12] module: cleanup and call taints after is inserted
Date:   Sun, 19 Mar 2023 14:27:34 -0700
Message-Id: <20230319212746.1783033-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

After posting my first RFC for "module: avoid userspace pressure on unwanted
allocations" [0] I ended up doing much more cleanup on the module loading path.
One of the things that became evident while ensuring we do *less* work before
kmalloc all the things we need for the final module is we are doing a lot of
work before we even add a module onto our linked list, once its accepted for
loading and running init. We even *taint* the kernel even before we accept
a module. We also do some tainting after kernel loading.

This converges both to one point -- right as soon as we accept module
into our linked list. That is, the module is valid as per our kernel
config and we're ready to go. Most of this is just tidying code up. The
biggest functional changes is under the patch "converge taint work together".

I'll post the other functional changes in two other patch sets. This is
mostly cleanup, the next one is the new ELF checks / sanity / cleanup,
and I'm waiting to hear back from David Hildenbrand on the worthiness of
some clutches for allocation. That last part would go in the last patch
series.

In this series I've dropped completely the idea of using aliasing since
different modules can share the same alias, so using that to check if
a module is already loaded turns out not to be useful in any way.

[0] https://lkml.kernel.org/r/20230311051712.4095040-1-mcgrof@kernel.org

Luis Chamberlain (12):
  module: move get_modinfo() helpers all above
  module: rename next_string() to module_next_tag_pair()
  module: add a for_each_modinfo_entry()
  module: move early sanity checks into a helper
  module: move check_modinfo() early to early_mod_check()
  module: rename set_license() to module_license_taint_check()
  module: split taint work out of check_modinfo_livepatch()
  module: split taint adding with info checking
  module: move tainting until after a module hits our linked list
  module: move signature taint to module_augment_kernel_taints()
  module: converge taint work together
  module: rename check_module_license_and_versions() to
    check_export_symbol_versions()

 kernel/module/internal.h |   5 +
 kernel/module/main.c     | 292 ++++++++++++++++++++-------------------
 2 files changed, 158 insertions(+), 139 deletions(-)

-- 
2.39.1

