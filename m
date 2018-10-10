Return-Path: <SRS0=uoCS=MW=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB00C43441
	for <linux-modules@archiver.kernel.org>; Wed, 10 Oct 2018 20:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4807320870
	for <linux-modules@archiver.kernel.org>; Wed, 10 Oct 2018 20:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4807320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbeJKEOY (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:14:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:58460 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbeJKEOX (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 11 Oct 2018 00:14:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 13:50:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,365,1534834800"; 
   d="scan'208";a="80184023"
Received: from bsstone-mobl.amr.corp.intel.com (HELO ldmartin-desk.jf.intel.com) ([10.254.68.222])
  by orsmga007.jf.intel.com with ESMTP; 10 Oct 2018 13:50:30 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
Subject: [PATCH] mkosi: allow Clear to use test modules
Date:   Wed, 10 Oct 2018 13:50:16 -0700
Message-Id: <20181010205016.3462-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.19.1.1.g8c3cf03f71
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Now Clear has a bundle for the kernel headers, let's use it.
---
 testsuite/mkosi/mkosi.build | 9 ++-------
 testsuite/mkosi/mkosi.clear | 1 +
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/testsuite/mkosi/mkosi.build b/testsuite/mkosi/mkosi.build
index 8ed54bb..53fc797 100755
--- a/testsuite/mkosi/mkosi.build
+++ b/testsuite/mkosi/mkosi.build
@@ -29,13 +29,8 @@ rm -rf build
 mkdir build
 cd build
 
-if grep clear-linux-os /usr/lib/os-release; then
-    # Clear Linux doesn't have the dependencies for those yet.
-    echo "--disable-test-modules" > ../../.config.args
-else
-    kdir=$(find_kdir)
-    IFS=/ read _ _ _ kver _ <<<"$kdir"
-fi
+kdir=$(find_kdir)
+IFS=/ read _ _ _ kver _ <<<"$kdir"
 
 ../autogen.sh c
 make -j
diff --git a/testsuite/mkosi/mkosi.clear b/testsuite/mkosi/mkosi.clear
index 6d87514..03ba2f0 100644
--- a/testsuite/mkosi/mkosi.clear
+++ b/testsuite/mkosi/mkosi.clear
@@ -10,6 +10,7 @@ Packages=
 	os-core-update
 BuildPackages=
 	os-core-dev
+	linux-dev
 
 [Partitions]
 RootSize = 5G
-- 
2.19.1.1.g8c3cf03f71

