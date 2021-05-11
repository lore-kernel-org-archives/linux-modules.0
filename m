Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BC0C433B4
	for <linux-modules@archiver.kernel.org>; Tue, 11 May 2021 18:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC83061625
	for <linux-modules@archiver.kernel.org>; Tue, 11 May 2021 18:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhEKSHl (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 11 May 2021 14:07:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:17395 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231551AbhEKSHl (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 11 May 2021 14:07:41 -0400
IronPort-SDR: BlNTZ/I2mEDT+0UZfZ6qSwR309Fnpk//AnR0FNxX69yE1qgTjzEAPcM7NBVTTe24PgkKPz/sL8
 0eKjiMvear2A==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="199562595"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="199562595"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 11:06:33 -0700
IronPort-SDR: RwTEmXnl7md6fnURO3YDja7TDCqj8FAlwcTUJd1pKF30plu7cp24SRL7tSWNzjdw/M2h7oLwvY
 FkzvZyPcEHlA==
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="609588620"
Received: from yueqiaor-mobl.amr.corp.intel.com (HELO ldmartin-desk2.intel.com) ([10.254.1.104])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 11:06:33 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: [PATCH 1/3] Fix return value doc for kmod_module_get_info()
Date:   Tue, 11 May 2021 11:06:13 -0700
Message-Id: <20210511180615.400191-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511180615.400191-1-lucas.demarchi@intel.com>
References: <20210511180615.400191-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

We don't return 0 on success, we return the number of elements we added
to the list.
---
 libkmod/libkmod-module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 76a6dc3..b6320cc 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2277,7 +2277,7 @@ list_error:
  *
  * After use, free the @list by calling kmod_module_info_free_list().
  *
- * Returns: 0 on success or < 0 otherwise.
+ * Returns: number of entries in @list on success or < 0 otherwise.
  */
 KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_list **list)
 {
-- 
2.31.1

