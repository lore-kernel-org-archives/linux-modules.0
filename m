Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AF5C4332F
	for <linux-modules@archiver.kernel.org>; Wed, 16 Feb 2022 07:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiBPH4T (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:56:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiBPH4T (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 16 Feb 2022 02:56:19 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC70BCB6
        for <linux-modules@vger.kernel.org>; Tue, 15 Feb 2022 23:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644998167; x=1676534167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zNXOJ97iIhQocqwV3tE3GVVne3uJrfQntpqU4dFrLks=;
  b=UiXSnBLcRlwOTQ4/fKozAp44hATJyG9HS4RDCGACrXekH26gp8VuP/Kp
   1HYI+btM9mYntTwiqoYajzKOWSUxQKvn5iisFjZjOJd+WCux1AUUHsji9
   m7Gwic4guTMMBifhbQDeKzbqtBy7SAKp7K85atsYwWQ5w+T3ohqsWb0Rh
   NLeoS3FngfznR6SQtQR2GDJaVNYm6pve34qAbpMP7wSvTnpSTorBw49GY
   D9PqkQRTacyY7UbywwNxs8c1e8+6FbfOuXhzbXskNJNL5PZMwcIgiGra/
   /5XlbyhxLRPApWGn7YdbrbozkKJANT1Gk7Uc4exHipxJeiNNv+XBjLbHz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="311286601"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="311286601"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:56:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="636377637"
Received: from dcanchal-mobl1.ger.corp.intel.com (HELO ldmartin-desk2.intel.com) ([10.212.233.152])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:56:04 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 3/8] gitignore: ignore gtk-doc.make
Date:   Tue, 15 Feb 2022 23:55:28 -0800
Message-Id: <20220216075533.185693-4-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216075533.185693-1-lucas.demarchi@intel.com>
References: <20220216075533.185693-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index f823511..cad86ea 100644
--- a/.gitignore
+++ b/.gitignore
@@ -20,6 +20,7 @@
 /configure
 /cov-int
 /coverage
+/gtk-doc.make
 /kmod-*.tar.*
 /libtool
 /stamp-h1
-- 
2.35.1

