Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848FEC433EF
	for <linux-modules@archiver.kernel.org>; Fri,  3 Jun 2022 21:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiFCVvJ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbiFCVvI (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 3 Jun 2022 17:51:08 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D24580E1
        for <linux-modules@vger.kernel.org>; Fri,  3 Jun 2022 14:51:07 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h192so1403881pgc.4
        for <linux-modules@vger.kernel.org>; Fri, 03 Jun 2022 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GEi6HF25E4K+yeZC0zp706ITxxpOPud+fd27MQ3mjL4=;
        b=GAO/Y5UC/fA9HIgxeyx1fXZp1xOAexqQYuqrrYrn3P5RzZGquJN7x3LkM4CGw3Y6Br
         Aymg2CrxSQPvrVuDKfFZh0oE7tgcQKh4cI2VGM+X1WBsVU9YFWugUuWdY2A3WIaFfIin
         jasXF5B4sMYAkfGw0ZvonAvf6HIRhNuHWj4ZHF+bL8YWYOQ3wqTbE/QzK1+mQ+wTQz02
         txlu0kKFvFC9ydIZxOeItTTbj7sLgAMsZDpEPktaR3/rlIS87N1jv5SP4+YJXyPBPTL/
         ZdqNrv1xw7ieTvCNYOXfVQfIBpgRRAH1aezMWnse7OfORDMmUFNPoQ3Vc2tIzY8AN/Kb
         Errw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GEi6HF25E4K+yeZC0zp706ITxxpOPud+fd27MQ3mjL4=;
        b=MJzvVD9DKDle4vTsxK8m8vgbiZuJd3t4wEb403rsyHRuo8+xhCibKitLkC9wHY4HBa
         b1E/oflLLvPz9eIR7KRBgfe4jAx9RKFBXQYxmIXdQIa2E5EJQrKttnAilpXg6IQBr02J
         tp3gCWIZvnMf6Fr+kxnzk+SXBrMv5OFg61aDV2CDixb6zSp5Ld1OZUTR0e8gRpvRok+I
         ZlaBTPMl82CtCTHX/2s3smaNIqJuS6h1kWAZ1/4HS6+ccFgcTrSJXP3rgXvVmmTeTdr8
         iBPeLyvGaaNFKBIo5ESl0XifVMswoMwhGPAcVvd8aW+59XU76b1dkJKRENMW2vyxF11Y
         dJJg==
X-Gm-Message-State: AOAM531HeI6dUDp/fuEWjobaaapSPlMY5eGXG6rTqXbkYgnhkUGDm//U
        5Chs+uTt0TBHiG+5MdX4GG07MCBggcQ=
X-Google-Smtp-Source: ABdhPJyrazVaHRZwsWqMg3uDfXyTbx8xdgR6I8ihDxCdsZtg9Y/ZBIZL0B1RuNFXtW5lmgRLmh7Ynw==
X-Received: by 2002:a63:1153:0:b0:3fb:10da:6277 with SMTP id 19-20020a631153000000b003fb10da6277mr10632388pgr.345.1654293066686;
        Fri, 03 Jun 2022 14:51:06 -0700 (PDT)
Received: from ldmartin-desk2.. ([50.45.187.67])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b00163ffe73300sm6032866plg.137.2022.06.03.14.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 14:51:05 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 3/8] module-playground: Add debugfs entry in mod-simple
Date:   Fri,  3 Jun 2022 14:50:42 -0700
Message-Id: <20220603215047.9607-4-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
References: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Add a debugfs file in mod-simple for manual tests: insert the module and
open the file to have its refcount increased.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 testsuite/module-playground/mod-simple.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/testsuite/module-playground/mod-simple.c b/testsuite/module-playground/mod-simple.c
index cb38580..503e4d8 100644
--- a/testsuite/module-playground/mod-simple.c
+++ b/testsuite/module-playground/mod-simple.c
@@ -1,16 +1,32 @@
+#include <linux/debugfs.h>
 #include <linux/init.h>
 #include <linux/module.h>
 
+static struct dentry *debugfs_dir;
+
+static int test_show(struct seq_file *s, void *data)
+{
+	seq_puts(s, "test");
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(test);
+
 static int __init test_module_init(void)
 {
+	debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	debugfs_create_file("test", 0444, debugfs_dir, NULL, &test_fops);
+
 	return 0;
 }
 
 static void test_module_exit(void)
 {
+	debugfs_remove_recursive(debugfs_dir);
 }
+
 module_init(test_module_init);
 module_exit(test_module_exit);
 
 MODULE_AUTHOR("Lucas De Marchi <lucas.demarchi@intel.com>");
-MODULE_LICENSE("LGPL");
+MODULE_LICENSE("GPL");
-- 
2.36.1

