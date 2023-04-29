Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2AEC77B7C
	for <linux-modules@archiver.kernel.org>; Sat, 29 Apr 2023 20:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjD2UgS (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 29 Apr 2023 16:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjD2UgR (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 29 Apr 2023 16:36:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309A81BFB;
        Sat, 29 Apr 2023 13:36:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF9B86104D;
        Sat, 29 Apr 2023 20:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD17C433EF;
        Sat, 29 Apr 2023 20:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682800576;
        bh=sLExiy79GQPlw72Ktso4BjG7WRmQvPv8FjFLp2TADbo=;
        h=From:To:Cc:Subject:Date:From;
        b=F9+fg30ZoSKA4h3DNgFKnfrEKWWb4thtN+9IHO+qv2vF9lyqmAFDUqOV6gOgLc/Je
         asszhbCu3MyOLTFKBSR5/buoQ/h7nyRhM9hPFEEX2iOKUc9+yuv1PXj3P11uOly6PX
         b5WipRgxh2ZIRovbsmtgeO9ZXQty5YVGk8ylkG/Sgxe+FDYYUUf7+/hJNieoMovWN5
         K7ig7/eonwAWxtPotEiCCPiONlSb2+ZRvBRpvNF1ZTpWpz2mF4AUoAhKQI15GIB7kN
         1O45yKx5ZNzY8V+4XN82VF2d+TCIIkjT2tlqIJAOcBmd67aNAiHop8gMhfvceu3RR5
         Xy2K5m5P7CRaw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] module: include internal.h in module/dups.c
Date:   Sat, 29 Apr 2023 22:36:04 +0200
Message-Id: <20230429203611.623812-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

Two newly introduced functions are declared in a header that is not
included before the definition, causing a warning with sparse or
'make W=1':

kernel/module/dups.c:118:6: error: no previous prototype for 'kmod_dup_request_exists_wait' [-Werror=missing-prototypes]
  118 | bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/module/dups.c:220:6: error: no previous prototype for 'kmod_dup_request_announce' [-Werror=missing-prototypes]
  220 | void kmod_dup_request_announce(char *module_name, int ret)
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~

Add an explicit include to ensure the prototypes match.

Fixes: 8660484ed1cf ("module: add debugging auto-load duplicate module support")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304141440.DYO4NAzp-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/module/dups.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index aa8e1361fdb5..f3d7ea1e96d8 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -32,6 +32,8 @@
 #include <linux/async.h>
 #include <linux/uaccess.h>
 
+#include "internal.h"
+
 #undef MODULE_PARAM_PREFIX
 #define MODULE_PARAM_PREFIX "module."
 static bool enable_dups_trace = IS_ENABLED(CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE);
-- 
2.39.2

