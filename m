Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828FAC7EE23
	for <linux-modules@archiver.kernel.org>; Thu,  1 Jun 2023 21:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjFAVmY (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 1 Jun 2023 17:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjFAVmY (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 1 Jun 2023 17:42:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F687184
        for <linux-modules@vger.kernel.org>; Thu,  1 Jun 2023 14:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=DqUkLCv6bMf9vWIRJfpsSPqgemVjNKqxtMuRW4MP28g=; b=pEN2QhA41jkCQ+jz1yKJxfX+KG
        6NlO52/x9NLcQ+q9phPEMSmWymkjMc/UumNTnS0buxg4eOgMspheX/pwNCd1If66d1gQbtGzcnvC5
        SstOIwVrnSEIx08wopqKqOqGy8wk1qtyoAXJc8WxlkSKYljzemhSl3bFIojA+tvbV8T757JLDLbIk
        9anQOlDnnc5BuLPvHt4HE8PE2W64Gmx3z2a0NRkWmiAYEy5xW3sEu6R45JjzmjNcUyqQYQ0BMBXM9
        wRooDJJ1EMr4u0IJToPPqY7dkfoOIk9T6JV/KfzVGybhAwKU1NdxdiuuN6qZ2627bxkiZLokXQbRe
        b7gQ2wQA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q4q3r-00523S-1D;
        Thu, 01 Jun 2023 21:42:23 +0000
Date:   Thu, 1 Jun 2023 14:42:23 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-modules@vger.kernel.org,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>, mcgrof@kernel.org
Subject: [GIT PULL] Modules fixes for v6.4-rc5 second pull request
Message-ID: <ZHkQvyEdTqJRC3G/@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The following changes since commit db3e33dd8bd956f165436afdbdbf1c653fb3c8e6:

  module: fix module load for ia64 (2023-05-30 09:29:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.4-rc5-second-pull

for you to fetch changes up to fadb74f9f2f609238070c7ca1b04933dc9400e4a:

  module/decompress: Fix error checking on zstd decompression (2023-06-01 14:36:46 -0700)

----------------------------------------------------------------
modules-6.4-rc5-second-pull

A zstd fix by lucas as he tested zstd decompression support

----------------------------------------------------------------
Lucas De Marchi (1):
      module/decompress: Fix error checking on zstd decompression

 kernel/module/decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
