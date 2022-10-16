Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652F3C433FE
	for <linux-modules@archiver.kernel.org>; Sun, 16 Oct 2022 12:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJPMbR (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 16 Oct 2022 08:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJPMbR (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 16 Oct 2022 08:31:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4855931DC2;
        Sun, 16 Oct 2022 05:31:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EFD8933A41;
        Sun, 16 Oct 2022 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665923473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=cmSrk5ohlKDQGsqQAPHO6K6HuIiAnaadRCI43kFH8yI=;
        b=sLxV0XqaYkIuigPQf6GzDk6mQwSfUGFB6pJU9XIPGF1UVlu8cqh9bauGtXs/y4e+IJEIxC
        q6P0xRECXcjQxMIuYNuIb6EYkLdI3i2Aq/PbcWHzuBFEl2uGoJJFdOpbMBXQYMqt6j4YNT
        p3WrpMRVsMbf3NS/ePb8TWzAJZvn09c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C942313A36;
        Sun, 16 Oct 2022 12:31:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BUrqL5H5S2MyMAAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Sun, 16 Oct 2022 12:31:13 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     mcgrof@kernel.org
Cc:     pmladek@suse.com, david@redhat.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v3 0/4] module: Merge same-name module load requests
Date:   Sun, 16 Oct 2022 14:30:27 +0200
Message-Id: <20221016123031.3963-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Changes since v2 [1]:
- Add kselftests to verify the expected behavior.
- Split a clean-up change to the module_mutex comment into a separate patch.
- Clarify a description of the main patch and mention that it fixes also
  a recently reported problem with module vmap space allocation errors.
- Improve some code comments.

Changes since v1 [2]:
- Change the error returned by a duplicate load when the main insert
  fails from -ENODEV to -EBUSY.
- Change the error returned by a duplicate load when a same-name module
  is going from -EAGAIN to -EBUSY.
- Use a per-shared_load_info completion object to inform waiting loads
  when the main one is done.
- Add a patch to correct wake up of module_wq.

[1] https://lore.kernel.org/linux-modules/20220919123233.8538-1-petr.pavlu@suse.com/
[2] https://lore.kernel.org/linux-modules/20220905084131.14567-1-petr.pavlu@suse.com/

Petr Pavlu (4):
  module: Correct wake up of module_wq
  module: Update a comment describing what is protected by module_mutex
  module: Merge same-name module load requests
  selftests: kmod: Add tests for merging same-name module load requests

 kernel/module/main.c                          | 222 +++++++++++++-----
 tools/testing/selftests/kmod/.gitignore       |   1 +
 tools/testing/selftests/kmod/Makefile         |  17 +-
 tools/testing/selftests/kmod/init_module.c    |  49 ++++
 tools/testing/selftests/kmod/kmod.sh          | 139 +++++++++++
 .../selftests/kmod/kmod_test_0014/Makefile    |  14 ++
 .../kmod/kmod_test_0014/kmod_test_0014.c      |  29 +++
 7 files changed, 402 insertions(+), 69 deletions(-)
 create mode 100644 tools/testing/selftests/kmod/.gitignore
 create mode 100644 tools/testing/selftests/kmod/init_module.c
 create mode 100644 tools/testing/selftests/kmod/kmod_test_0014/Makefile
 create mode 100644 tools/testing/selftests/kmod/kmod_test_0014/kmod_test_0014.c

-- 
2.35.3

