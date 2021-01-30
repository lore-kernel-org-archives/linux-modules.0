Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78702C433DB
	for <linux-modules@archiver.kernel.org>; Sat, 30 Jan 2021 09:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465F364E02
	for <linux-modules@archiver.kernel.org>; Sat, 30 Jan 2021 09:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhA3Jbz (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:31:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:26722 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233445AbhA3DWD (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 29 Jan 2021 22:22:03 -0500
IronPort-SDR: yPaPfr/jBBhmjVon5WB+6+K6NPEdUYsLlJ7iEkY7osFWQHbuqMSQz4BV5PVvc2B2ttspEQ/qvr
 WpNpCETWWzPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="159676035"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="159676035"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:36:15 -0800
IronPort-SDR: tAOYuEk3J/itaX6LQ02os7QxFOS4TH93PtJ9gvKERqaSWoKeW7VxOOilNDZYg4/BPsGB2kao/g
 yXuXnXfu8ePw==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="389572786"
Received: from ggehle-mobl.amr.corp.intel.com (HELO ldmartin-desk1.intel.com) ([10.213.162.217])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:36:13 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Petr Vorel <petr.vorel@gmail.com>
Subject: [PATCH 2/2] testsuite: also test xz compression
Date:   Fri, 29 Jan 2021 18:36:00 -0800
Message-Id: <20210130023600.24239-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210130023600.24239-1-lucas.demarchi@intel.com>
References: <20210130023600.24239-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

---
 testsuite/populate-modules.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testsuite/populate-modules.sh b/testsuite/populate-modules.sh
index ae43884..099f026 100755
--- a/testsuite/populate-modules.sh
+++ b/testsuite/populate-modules.sh
@@ -72,6 +72,9 @@ map=(
 
 gzip_array=(
     "test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/block/cciss.ko"
+    )
+
+xz_array=(
     "test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/scsi_mod.ko"
     )
 
@@ -112,6 +115,12 @@ if feature_enabled ZLIB; then
 	done
 fi
 
+if feature_enabled XZ; then
+	for m in "${xz_array[@]}"; do
+	    xz "$ROOTFS/$m"
+	done
+fi
+
 if feature_enabled ZSTD; then
 	for m in "${zstd_array[@]}"; do
 	    zstd --rm $ROOTFS/$m
-- 
2.30.0

