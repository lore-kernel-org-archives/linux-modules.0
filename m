Return-Path: <SRS0=Vjph=OJ=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E353C64EB4
	for <linux-modules@archiver.kernel.org>; Fri, 30 Nov 2018 20:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCD22080A
	for <linux-modules@archiver.kernel.org>; Fri, 30 Nov 2018 20:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCD22080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeLAHwj (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:52:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:32027 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbeLAHwj (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Sat, 1 Dec 2018 02:52:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 12:39:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,299,1539673200"; 
   d="scan'208";a="100693568"
Received: from ldmartin-desk.jf.intel.com ([10.24.10.139])
  by fmsmga008.fm.intel.com with ESMTP; 30 Nov 2018 12:39:07 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Subject: [PATCH] README: Add link to mailing list archive
Date:   Fri, 30 Nov 2018 12:39:05 -0800
Message-Id: <20181130203905.13208-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.19.1.1.g56c4683e68
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

We now have a proper archive for the mailing list.
---
 README | 1 +
 1 file changed, 1 insertion(+)

diff --git a/README b/README
index fa215af..04f06ce 100644
--- a/README
+++ b/README
@@ -8,6 +8,7 @@ Build status:
 
 Mailing list:
 	linux-modules@vger.kernel.org (no subscription needed)
+	https://lore.kernel.org/linux-modules/
 
 Patchwork:
 	https://patchwork.kernel.org/project/linux-modules/
-- 
2.19.1.1.g56c4683e68

