Return-Path: <SRS0=c/4a=O4=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FAEC43444
	for <linux-modules@archiver.kernel.org>; Wed, 19 Dec 2018 00:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32BA218AE
	for <linux-modules@archiver.kernel.org>; Wed, 19 Dec 2018 00:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeLSADJ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 18 Dec 2018 19:03:09 -0500
Received: from mga01.intel.com ([192.55.52.88]:8278 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbeLSADJ (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 18 Dec 2018 19:03:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 16:03:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="284784593"
Received: from ldmartin-desk.jf.intel.com ([10.7.200.65])
  by orsmga005.jf.intel.com with ESMTP; 18 Dec 2018 16:03:05 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH 3/3] testsuite: move --show-exports test to use regex
Date:   Tue, 18 Dec 2018 16:02:29 -0800
Message-Id: <20181219000229.10793-3-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181219000229.10793-1-lucas.demarchi@intel.com>
References: <20181219000229.10793-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This allows it to pass if the kernel is configured with
CONFIG_MODVERSIONS.
---
 .../rootfs-pristine/test-modprobe/show-exports/correct.txt      | 2 +-
 testsuite/test-modprobe.c                                       | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/testsuite/rootfs-pristine/test-modprobe/show-exports/correct.txt b/testsuite/rootfs-pristine/test-modprobe/show-exports/correct.txt
index bc2d045..0d659ef 100644
--- a/testsuite/rootfs-pristine/test-modprobe/show-exports/correct.txt
+++ b/testsuite/rootfs-pristine/test-modprobe/show-exports/correct.txt
@@ -1 +1 @@
-0x00000000	printA
+0x[0-9a-fA-F]+	printA
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index 52a6621..1cace82 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -114,6 +114,7 @@ DEFINE_TEST(modprobe_show_exports,
 	},
 	.output = {
 		.out = TESTSUITE_ROOTFS "test-modprobe/show-exports/correct.txt",
+		.regex = true,
 	});
 
 
-- 
2.20.0

