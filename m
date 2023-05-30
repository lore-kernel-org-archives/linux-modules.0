Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C793DC7EE2E
	for <linux-modules@archiver.kernel.org>; Tue, 30 May 2023 16:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjE3QfS (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 30 May 2023 12:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjE3Qey (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 30 May 2023 12:34:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981EF114;
        Tue, 30 May 2023 09:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qsovGTTFK/8LiG8psb8IGP4uqZZdlpbFPDsdd6IVv2s=; b=EI66e8KsihmdCtMF7QwzXzdwSR
        ZCtEtnjLBmIesSOeGCL7DCb5qjVkYcPSzSG9lzx18nPfjffnT2e6lKtq/z5vfLQyMPjrCvQSR6VFV
        aXzaTQYmryt2hIJ86KYbKSFAHQSksI8j+w9pPdOm2/2G2NsUpk0znjZ6MxZIBBDcDa5hUBbTrnYpd
        wjoT/FA2QavVTNs3RD1RVtvpBMX3zxR8/GpA4P0J5UoJ8Wu5Ts/TqBQzRxyqZION4+IcWRN2Txdil
        BjlDHkWt4/uO0hPUM3kjfTlXpzvKbgkf/QEwE53hsWGElJ9b17Gx5C2U9seKVO9VjBZz6lnTisxL5
        5jZVj5/g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q42Ih-00EaSX-0a;
        Tue, 30 May 2023 16:34:24 +0000
Date:   Tue, 30 May 2023 09:34:23 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-modules@vger.kernel.org, linux-ia64@vger.kernel.org,
        debian-ia64@lists.debian.org, glaubitz@physik.fu-berlin.de,
        Frank Scheiner <frank.scheiner@web.de>,
        Song Liu <song@kernel.org>, mcgrof@kernel.org
Subject: [GIT PULL] Modules changes for v6.4-rc5
Message-ID: <ZHYlj7jks1GIxNSn@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The following changes since commit d36f6efbe0cb422fe1e4475717d75f3737088832:

  module: Fix use-after-free bug in read_file_mod_stats() (2023-05-22 14:13:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.4-rc5

for you to fetch changes up to db3e33dd8bd956f165436afdbdbf1c653fb3c8e6:

  module: fix module load for ia64 (2023-05-30 09:29:40 -0700)

----------------------------------------------------------------
modules-6.4-rc5

A fix is provided for ia64. Even though ia64 is on life support it helps
to fix issues if we can. Thanks to Linus for doing tons of the ia64
debugging.

----------------------------------------------------------------
Song Liu (1):
      module: fix module load for ia64

 kernel/module/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
