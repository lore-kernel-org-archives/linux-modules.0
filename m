Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EE7C77B75
	for <linux-modules@archiver.kernel.org>; Wed,  3 May 2023 03:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjECDns (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 2 May 2023 23:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjECDnr (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 2 May 2023 23:43:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793C21FEE;
        Tue,  2 May 2023 20:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ZIADMU0Kl928OS/WKfRbeOaDTqGObzNlyLZhin0OEhA=; b=Z6LjI6NPKvxa7F9MQg2+mHEqf6
        BatQJO2ZLt9WUOwD0Ti+q3lhN7BjZHsoBx4dRIe/3xl8XgC80Z1Yo0i7T9gbB6Uzb5tjBfYAfVccU
        3e/bvgfRhNQ89Beg7Y24Y3xyTpChATHEmd+GBHxMmcO0x6/gWY3JnN2i+kodjBfWWUFPE8Y4AKB3a
        HdOCqzoFLE4a1o2xBnN9YqCH+fFKQBfEnyXgJcaABsWQw9XZN9Q5qI/67H4eG9t7S4YZEUJ32FZ8f
        CV/HasI9G/AuAsIC8o++ybW6z1AN3AtfY0BoalPBLMZh5os6sa0NAktiSfgNo+12PN26+vhourEfs
        b7oLqKag==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pu3P7-003FF8-11;
        Wed, 03 May 2023 03:43:45 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     torvalds@linux-foundation.org, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] module: include internal.h in module/dups.c
Date:   Tue,  2 May 2023 20:43:44 -0700
Message-Id: <20230503034344.773568-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
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
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

 kernel/module/dups.c | 2 ++
 1 file changed, 2 insertions(+)

Linus, only one fix so far for modules so might as well send this as a patch.

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

