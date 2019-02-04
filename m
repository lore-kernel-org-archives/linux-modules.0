Return-Path: <SRS0=bBDI=QL=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59C4C282C4
	for <linux-modules@archiver.kernel.org>; Mon,  4 Feb 2019 22:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3AE2081B
	for <linux-modules@archiver.kernel.org>; Mon,  4 Feb 2019 22:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfBDWc4 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:32:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:13773 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfBDWc4 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 4 Feb 2019 17:32:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 14:32:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="297254668"
Received: from ldmartin-desk.jf.intel.com ([10.7.200.78])
  by orsmga005.jf.intel.com with ESMTP; 04 Feb 2019 14:32:55 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH 2/2] build: enable openssl by default
Date:   Mon,  4 Feb 2019 14:32:49 -0800
Message-Id: <20190204223249.27531-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190204223249.27531-1-lucas.demarchi@intel.com>
References: <20190204223249.27531-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Like with other features, let's enable it for developers.
---
 autogen.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autogen.sh b/autogen.sh
index e003f78..67b119f 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -32,7 +32,7 @@ fi
 
 cd $oldpwd
 
-hackargs="--enable-debug --enable-python --with-xz --with-zlib"
+hackargs="--enable-debug --enable-python --with-xz --with-zlib --with-openssl"
 
 if [ "x$1" = "xc" ]; then
         shift
-- 
2.20.0

