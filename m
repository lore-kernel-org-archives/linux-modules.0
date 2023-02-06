Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D427C05027
	for <linux-modules@archiver.kernel.org>; Mon,  6 Feb 2023 14:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjBFOH5 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 6 Feb 2023 09:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjBFOHi (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 6 Feb 2023 09:07:38 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30F32B2B1
        for <linux-modules@vger.kernel.org>; Mon,  6 Feb 2023 06:05:05 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j25so6930771wrc.4
        for <linux-modules@vger.kernel.org>; Mon, 06 Feb 2023 06:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nu84mv2UzpzemmM3+muhbU8ewzk4iji/02mcrPeSCG4=;
        b=PPzPu/6r0yAOehAdRlVTp/UcIPzzuTttrdL6mMImNJjW7a8TLJW0AvzjjEmU3pdFek
         4/PKCAhXTvLqaT6jYPv02EojPZnPgaAyzFTJuHKoj1Ao9AScGlFEPzLmGIuSR9jthtUm
         VprSNGUNhhuOiHySCqDmaX/k3dGEA7UDuptocYzRVdgZV3lLu7UaV0B3bqSoQiR3Lmy7
         0DMwHBNNK/atDsuWUQ4Uwn+wprHYMNlrZDDUMDQlqnJ7GRiAmVZkpx9TBIN7cxRfeY06
         bhZ03Z57pvroqratJcZkGdWegOCiQh3GNWJ4HtH8ai36hxr9o4mrGBdczCpSN+nyGxWE
         m5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nu84mv2UzpzemmM3+muhbU8ewzk4iji/02mcrPeSCG4=;
        b=mtPBc78VF0lfcoUPcruisOsHXBC2epw0HqRrSvfjxwgMEKhd+khmkFQJTi1h9G6t5D
         t7EsYExsXVCeyrV8/BFScA8y/y29h1Ok6ybrA/obqcZlN9waz77k9GgvkxHbX1llBmAa
         EM48zCNXM+qe4tVBYrsgfKOXzmHCLdSkWs2gre77Y0PUnz5Xgi8BtU+IFlt4ZZj/sOyT
         iROhnTzR8pCXq/MP/dt/zcviZjzQPVmcmUTbScCTZSGp/ho5ti0CvWfX+Dd3zj2AzE9n
         wZ+/lUlwW9dSl72Ebs0UWJqPY1HJq3BXvwgNYmR4tygSr/B8QmaC609pHLlaonMKaBYA
         t7IQ==
X-Gm-Message-State: AO0yUKVqnlMeJfV/l97KpX/xozlQ0w+ItRCt81EvZyy1ivVW5moPkeN7
        pNoVjGI8ZSINn7Ol03YE9XtvBBeYtaI=
X-Google-Smtp-Source: AK7set9rIPD7IjfeOzE+fMCjfW+4/eKS15SKoW8jqCCsU9h+BlLOB/lpSbnX8z5RctnWlskN0CVLNw==
X-Received: by 2002:adf:e78d:0:b0:2c3:ef74:602d with SMTP id n13-20020adfe78d000000b002c3ef74602dmr1351464wrm.25.1675692290711;
        Mon, 06 Feb 2023 06:04:50 -0800 (PST)
Received: from localhost ([2a00:5f00:102:0:9503:21c4:e16b:65c3])
        by smtp.gmail.com with UTF8SMTPSA id l13-20020adffe8d000000b002bfbda53b98sm5974605wrr.35.2023.02.06.06.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 06:04:50 -0800 (PST)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     emil.l.velikov@gmail.com
Subject: [PATCH 0/4] kmod: Various papercuts
Date:   Mon,  6 Feb 2023 14:04:45 +0000
Message-Id: <20230206140449.574631-1-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hello team,

Here's a small series with various papercuts, while I was looking through the
code base. Note that the last two patches depend on outdir patch [1] earlier.

The patches are trivial enough as-is, so feel free to pick whichever pieces
you find suitable.

If you have any comments - be that respin against master or otherwise, do let me
know.

Thanks
Emil

[1] https://lore.kernel.org/linux-modules/20230206131834.559229-1-emil.l.velikov@gmail.com/T/#u

Emil Velikov (4):
  treewide: add some static const notations
  testsuite: add function declarations for __xstat family
  testsuite: fixup KMOD_SYSCONFDIR_NOT_ETC tests
  testsuite/depmod: use defines for the rootfs/lib_modules

 libkmod/libkmod-module.c    |  4 +--
 libkmod/libkmod.c           |  4 +--
 testsuite/path.c            |  9 ++++-
 testsuite/test-blacklist.c  |  2 +-
 testsuite/test-depmod.c     | 72 +++++++++++++++++++------------------
 testsuite/test-modprobe.c   |  7 ++--
 testsuite/test-new-module.c | 11 +++---
 testsuite/test-util.c       |  4 +--
 testsuite/testsuite.c       |  2 +-
 tools/depmod.c              |  2 +-
 10 files changed, 67 insertions(+), 50 deletions(-)

-- 
2.39.1

