Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0EDC43217
	for <linux-modules@archiver.kernel.org>; Wed, 16 Feb 2022 07:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiBPH4U (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:56:20 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiBPH4T (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 16 Feb 2022 02:56:19 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D0A13CFB
        for <linux-modules@vger.kernel.org>; Tue, 15 Feb 2022 23:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644998167; x=1676534167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CGE5HdCIu+v+j6sL06U2IS/6E2ezQqZjtR/ZoLUQNn4=;
  b=IT3HkN5F54fwTgXFcLkYY8NWYwAQy54uss2jJixge702qq/tTC7HI5By
   d0KCZ5q6N5ZSmP+8te3I2l0FrA08PIHIbSdjWw+vy1X33PFJ/fDiiVq+P
   ckclXeOnpjtlhbVgM63vtRpmz/QQWmjAjr6OO2MX/Mk0XgdYpoo+D8wpS
   4w9qYRhEQNt+Mt5VN+DCoU4NYR863SZIUjMEK6MmWljySUaX30+Bisfk3
   9IoAalFRRhmtawtGQV0iBG9eJ4Eiv7v00BWGOO7Sh6jvMu9CNPvxaMdbY
   DTgIinqC0tWBUzmum/NMN60aYNem/vlTkfYDdXIXm4+RlLM+3UZgwH0Hx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="311286603"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="311286603"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:56:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="636377643"
Received: from dcanchal-mobl1.ger.corp.intel.com (HELO ldmartin-desk2.intel.com) ([10.212.233.152])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:56:04 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 5/8] libkmod: Update docs about indexes order
Date:   Tue, 15 Feb 2022 23:55:30 -0800
Message-Id: <20220216075533.185693-6-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216075533.185693-1-lucas.demarchi@intel.com>
References: <20220216075533.185693-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

New indexes were created without updating the documentation about the
order in kmod_module_new_from_lookup(). Add them to the documentation.
---
 libkmod/libkmod-module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 7cb6d26..1c6ff24 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -534,7 +534,7 @@ static int __kmod_module_new_from_lookup(struct kmod_ctx *ctx, const lookup_func
  *
  * The search order is: 1. aliases in configuration file; 2. module names in
  * modules.dep index; 3. symbol aliases in modules.symbols index; 4. aliases
- * in modules.alias index.
+ * from install commands; 5. builtin indexes from kernel.
  *
  * The initial refcount is 1, and needs to be decremented to release the
  * resources of the kmod_module. The returned @list must be released by
-- 
2.35.1

