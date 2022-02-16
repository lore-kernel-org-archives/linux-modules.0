Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B4AC433FE
	for <linux-modules@archiver.kernel.org>; Wed, 16 Feb 2022 07:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiBPH4S (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:56:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiBPH4R (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 16 Feb 2022 02:56:17 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE14DF09
        for <linux-modules@vger.kernel.org>; Tue, 15 Feb 2022 23:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644998166; x=1676534166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TovLcQ5sHep+K1MsmFFdxq4MDOrTSnAw/9LOMfo6ENo=;
  b=IMw2XhFK4b7smAL6U/9/9qzY+yGXUBXFIIl0OHqRXEwSyzroaGKAPgD9
   dIpztxejpVyA5Bxag6cNcNF+PF/oEdWvyjCG7qUcXdUc2Wy+ny1OZfDyn
   dVWjguKNk+9uLR8zISc2XTTBD1+aRFphTxzowlOD7v7+B1QBUGbMIy7UU
   /5wmEeEKbRX01WBKh/MYisRWLEBec4WhFdUjZlW4k3FUhMIKfQekEtzAa
   2xB2Qb8yhDVks2jPDSVdrhStOxAWtZLNMVQOiPaW2JsuzxEmq7IfzUM7E
   KidVUj+tPmpldaCWXFv199SfiaET1s8afYXVb69r6PBIduem79cC49RUE
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="311286599"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="311286599"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:56:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="636377630"
Received: from dcanchal-mobl1.ger.corp.intel.com (HELO ldmartin-desk2.intel.com) ([10.212.233.152])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:56:04 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 1/8] test-initstate: Check for negative value on error
Date:   Tue, 15 Feb 2022 23:55:26 -0800
Message-Id: <20220216075533.185693-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216075533.185693-1-lucas.demarchi@intel.com>
References: <20220216075533.185693-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Documentation says kmod_module_new_from_lookup() returns < 0 on error
and 0 otherwise. There are bugs in libkmod however making it return
a positive value in some situations, that need to be fixed. However
it's best to check for the error explicitly like is done in the rest
of the library to avoid this kind of issues.
---
 testsuite/test-initstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/test-initstate.c b/testsuite/test-initstate.c
index da2303a..9332e8f 100644
--- a/testsuite/test-initstate.c
+++ b/testsuite/test-initstate.c
@@ -45,7 +45,7 @@ static noreturn int test_initstate_from_lookup(const struct test *t)
 		exit(EXIT_FAILURE);
 
 	err = kmod_module_new_from_lookup(ctx, "fake-builtin", &list);
-	if (err != 0) {
+	if (err < 0) {
 		ERR("could not create module from lookup: %s\n", strerror(-err));
 		exit(EXIT_FAILURE);
 	}
-- 
2.35.1

