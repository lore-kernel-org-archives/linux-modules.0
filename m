Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79FBCCA47D
	for <linux-modules@archiver.kernel.org>; Fri,  3 Jun 2022 21:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbiFCVvK (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238101AbiFCVvI (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 3 Jun 2022 17:51:08 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E45F580C3
        for <linux-modules@vger.kernel.org>; Fri,  3 Jun 2022 14:51:05 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id x12so8183228pgj.7
        for <linux-modules@vger.kernel.org>; Fri, 03 Jun 2022 14:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7QuyeCFnNY8LvTl11n4OqSbdGHZK+0Oj+W9UnqLXuro=;
        b=iFI7HVlyQM2CR9QsM8fIzwWxxMeA623g2Dx1X98BVm6GbjbMnTnBpCXRYWRrxe6gnl
         f2l6KtVNBGHbglON5ZENz1aGl+AVagRT8T2yhzxTIIK0ivuAEOxCV+8LHjO1E+QY9Q5f
         c5+WW8029ZXl4u6pdoMwrLPhkf43dHyOSnOsJUxk4wPCSIAYS2HSJ65T3yFH5Efcr6S7
         5iNJFxPLIsRuu/3dV7OLk4EAhN6NGxmMZIl3RO03cGuy0+JNGbtrE9T3BSBzmrgtP9oq
         Io2r8Nvb5LpJjHBrtjRWoTPLhXBLdFYCsfeWfMIvlgHjqHYGo6j+cU2XnT4mm3ETlrNl
         O7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7QuyeCFnNY8LvTl11n4OqSbdGHZK+0Oj+W9UnqLXuro=;
        b=EvqIerfnPssftQjXgbYCDyNzLXtoMbuh/1awQ/yfd8d5adZJd48Zd43utr7tbU7tQz
         dgWWDxemiGluLtVWlu8QxPjOWBNC0zcJyhvMpzXUnKoEIOum0BxgSur88MZOYIotBrY/
         tQTHk0ksICASb6Yj0wWPhHik17xZY+lK3FSWKiJ4i+0XPaeyo5B35cOOyxIGDMXc/85k
         E4A1mKmyfMl1GbVroomzS5N6mdYEJ/m15L866qVnVlDZHefRxv1HL/uI+N6IEVw4H2v9
         9l609qN5vK3ftT2a7MjqoSIJ072pUXVbSZb30geA4gwd/pj3m7xAFTjQAdLAoNjpAOJk
         G1uA==
X-Gm-Message-State: AOAM531stuUAVM6PyIIG6Ba0eZdf90uQPN5LXAfZmLTmy2NEKtixbsvl
        bgQKbxyHGvGIP521moTKmlUJGSsDTDw=
X-Google-Smtp-Source: ABdhPJzLr8lm9cUwhZK9yNUzuCQXCy99l8HmXvfPFrINWbh6DKV539DxIV8gd1XtOzdIxVIfQ9370g==
X-Received: by 2002:a63:8642:0:b0:3fc:9abf:b6db with SMTP id x63-20020a638642000000b003fc9abfb6dbmr10647944pgd.51.1654293063665;
        Fri, 03 Jun 2022 14:51:03 -0700 (PDT)
Received: from ldmartin-desk2.. ([50.45.187.67])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b00163ffe73300sm6032866plg.137.2022.06.03.14.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 14:51:02 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 2/8] libkmod: Allow to ignore log message on module removal
Date:   Fri,  3 Jun 2022 14:50:41 -0700
Message-Id: <20220603215047.9607-3-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
References: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Caller may want to handle retries, in which case the log message is not
appropriate.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 libkmod/libkmod-module.c | 13 +++++++++----
 libkmod/libkmod.h        |  2 ++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index efdd679..12d8ed1 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -823,11 +823,13 @@ extern long delete_module(const char *name, unsigned int flags);
 /**
  * kmod_module_remove_module:
  * @mod: kmod module
- * @flags: flags to pass to Linux kernel when removing the module. The only valid flag is
+ * @flags: flags used when removing the module.
  * KMOD_REMOVE_FORCE: force remove module regardless if it's still in
- * use by a kernel subsystem or other process;
- * KMOD_REMOVE_NOWAIT is always enforced, causing us to pass O_NONBLOCK to
+ * use by a kernel subsystem or other process; passed directly to Linux kernel
+ * KMOD_REMOVE_NOWAIT: is always enforced, causing us to pass O_NONBLOCK to
  * delete_module(2).
+ * KMOD_REMOVE_NOLOG: when module removal fails, do not log anything as the
+ * caller may want to handle retries and log when appropriate.
  *
  * Remove a module from Linux kernel.
  *
@@ -836,6 +838,8 @@ extern long delete_module(const char *name, unsigned int flags);
 KMOD_EXPORT int kmod_module_remove_module(struct kmod_module *mod,
 							unsigned int flags)
 {
+	unsigned int libkmod_flags = flags & 0xff;
+
 	int err;
 
 	if (mod == NULL)
@@ -848,7 +852,8 @@ KMOD_EXPORT int kmod_module_remove_module(struct kmod_module *mod,
 	err = delete_module(mod->name, flags);
 	if (err != 0) {
 		err = -errno;
-		ERR(mod->ctx, "could not remove '%s': %m\n", mod->name);
+		if (!(libkmod_flags & KMOD_REMOVE_NOLOG))
+			ERR(mod->ctx, "could not remove '%s': %m\n", mod->name);
 	}
 
 	return err;
diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
index fed216b..7251aa7 100644
--- a/libkmod/libkmod.h
+++ b/libkmod/libkmod.h
@@ -145,6 +145,8 @@ struct kmod_module *kmod_module_get_module(const struct kmod_list *entry);
 enum kmod_remove {
 	KMOD_REMOVE_FORCE = O_TRUNC,
 	KMOD_REMOVE_NOWAIT = O_NONBLOCK, /* always set */
+	/* libkmod-only defines, not passed to kernel */
+	KMOD_REMOVE_NOLOG = 1,
 };
 
 /* Insertion flags */
-- 
2.36.1

