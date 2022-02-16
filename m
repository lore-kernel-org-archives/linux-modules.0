Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C744C433F5
	for <linux-modules@archiver.kernel.org>; Wed, 16 Feb 2022 07:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiBPH4S (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:56:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiBPH4R (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 16 Feb 2022 02:56:17 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BC2DFE6
        for <linux-modules@vger.kernel.org>; Tue, 15 Feb 2022 23:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644998166; x=1676534166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3wbGdP9GcGDcL1gxfM5c8iAP9ikS6y7Yit4yACtCuuM=;
  b=L2zNn7MJsRNp2UzivAKRk1WKgl0vfOqGGCHPZ5JeFd5u/QKzOFN3pzwf
   MhhNJQXI+GCIwpMQsTi/iKznSsQBmyISIODDVXb6LaryoljCXceYD8N+p
   KcpMI50qL7LMEiAwMIGyocjjaQvFghNX0MYjnj3y/dzRO1t41w+TmzOGf
   HWm+6OUcBqi661JSSLhbl6jTsDWSlIJpJUeeUjgmBTUmbtTZbcLFWZNrM
   ITdkOMwEumgp2sna5cWkc8NlQXaLd3+OalcqpJwVO1fQ4ZxeI6DbbJx2u
   8hkk1MsmF74CxOOI2XR+SLD2zy0yYiGaj4V3C2d/KvltmbMTVbUqxHcO6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="311286600"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="311286600"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:56:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="636377634"
Received: from dcanchal-mobl1.ger.corp.intel.com (HELO ldmartin-desk2.intel.com) ([10.212.233.152])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:56:04 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 2/8] libkmod-module: Fix return code for kmod_module_new_from_lookup()
Date:   Tue, 15 Feb 2022 23:55:27 -0800
Message-Id: <20220216075533.185693-3-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216075533.185693-1-lucas.demarchi@intel.com>
References: <20220216075533.185693-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

When kmod_module_new_from_lookup() resolves to an alias, `err` will be
set to a positive value from the lookup function. Do not return a
positive value to follow the behavior when it matches a module name
and the documentation.
---
 libkmod/libkmod-module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 6423339..1b59c3c 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -589,8 +589,8 @@ KMOD_EXPORT int kmod_module_new_from_lookup(struct kmod_ctx *ctx,
 
 
 finish:
-	DBG(ctx, "lookup %s=%d, list=%p\n", alias, err, *list);
-	return err;
+	DBG(ctx, "lookup %s matches=%d, list=%p\n", alias, err, *list);
+	return err > 0 ? 0 : err;
 fail:
 	DBG(ctx, "Failed to lookup %s\n", alias);
 	kmod_module_unref_list(*list);
-- 
2.35.1

