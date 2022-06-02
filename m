Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A89C433EF
	for <linux-modules@archiver.kernel.org>; Thu,  2 Jun 2022 03:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiFBD5A (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 1 Jun 2022 23:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiFBD47 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 1 Jun 2022 23:56:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0D665FC
        for <linux-modules@vger.kernel.org>; Wed,  1 Jun 2022 20:56:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i17-20020a259d11000000b0064cd3084085so3136234ybp.9
        for <linux-modules@vger.kernel.org>; Wed, 01 Jun 2022 20:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=LuUhsyPypQZGU3jrXJoAWrZRXReGqGn6qLSIaznozAI=;
        b=E4IWPG7NT1UNf7GgQZe5LzAC8VRVYnRLzg5OUu2SgHPIm1/RvPYznhXRfW7f/mLixq
         qv9VNC/sWKPyFMPOfc+CTVdC6tc5MuIdmS5C/UoaNmYLr7K1pNTub+L9xw/QT09YZaC+
         f2XZcEbtFREwvM1WK1LwmNTj/lTfmObEgLlZ1wXIv8ZOJFosqJ6gfsu75H58qx1h+Gzj
         ZTFiVMPMzXH0VjoW3I7ayX7JX6iRP28ZPk/8sUptlfDI8CVh2EQ4Fez6yyH3yT+K3/Gf
         i2gVz5aJ2jpi+RwW6HucKlndxXRGrZUeAWNp14c5b6EA/SWp0ziIm7uO1p0FmZRbrE20
         3PkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=LuUhsyPypQZGU3jrXJoAWrZRXReGqGn6qLSIaznozAI=;
        b=6PpmLnNwoyRjZe7bn2BnmGztci9Du1wDZSvbzPFnc2lRBY5xx2HmNnxsJyTR0D+kKY
         rRty3oRw69bCarUEH6iieYY+vyoJu0sgPMw7W2WeW0PUe8EkPzn75y2Qlhy5Lki3Quos
         f5zO4wBhiEDJrHMnXBtCHV2udQMmvjo9mcodzpeQn1fsQMN1UQCAW1mgUOTlJlkYrSdc
         VTgR2GqmKqAPr9e1zCE/R924YjMUjpwX2Dpt2M3rBWRecuWrv7++8pIDM/bdQ60grENY
         5NCp4uOYRJLY0U8vX9WRbQFBgp3IamWdJ9adorGGkCJbB42IxW94ViIbobXcrx9JhoYy
         R6Lg==
X-Gm-Message-State: AOAM532JXfY/WZUo6vwsDFpQ23BI56RURqgkSepKQHgJRAQsEhMEE9X1
        P4gjDonzL1eg3NsACPnWRrEZho1fFhxv1Jk=
X-Google-Smtp-Source: ABdhPJwn00Xm5TeG8g1UhL2QZig3oGqw407L7c6XxVwg/P5zA9iQtgMe4kID06ml4/12GqzzsZIaI5vyC4db/fk=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f3aa:cafe:c20a:e136])
 (user=saravanak job=sendgmr) by 2002:a25:2e46:0:b0:65c:d35b:2441 with SMTP id
 b6-20020a252e46000000b0065cd35b2441mr3211894ybn.249.1654142217260; Wed, 01
 Jun 2022 20:56:57 -0700 (PDT)
Date:   Wed,  1 Jun 2022 20:56:52 -0700
In-Reply-To: <20220322140344.556474-2-atomlin@redhat.com>
Message-Id: <20220602035653.4167316-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v1] module: Fix prefix for module.sig_enforce module param
From:   Saravana Kannan <saravanak@google.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Aaron Tomlin <atomlin@redhat.com>
Cc:     Saravana Kannan <saravanak@google.com>, cl@linux.com,
        mbenes@suse.cz, akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Commit cfc1d277891e ("module: Move all into module/") changed the prefix
of the module param by moving/renaming files. A later commit also moves
the module_param() into a different file, thereby changing the prefix
yet again.

This would break kernel cmdline compatibility and also userspace
compatibility at /sys/module/module/parameters/sig_enforce.

So, set the prefix back to "module.".

Cc: Aaron Tomlin <atomlin@redhat.com>
Cc: mcgrof@kernel.org
Cc: christophe.leroy@csgroup.eu
Cc: cl@linux.com
Cc: mbenes@suse.cz
Cc: akpm@linux-foundation.org
Cc: jeyu@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-modules@vger.kernel.org
Cc: void@manifault.com
Cc: atomlin@atomlin.com
Cc: allen.lkml@gmail.com
Cc: joe@perches.com
Cc: msuchanek@suse.de
Cc: oleksandr@natalenko.name
Cc: jason.wessel@windriver.com
Cc: pmladek@suse.com
Cc: daniel.thompson@linaro.org
Cc: hch@infradead.org
Fixes: cfc1d277891e ("module: Move all into module/")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Sending this patch in case my analysis in [1] was right.

[1] - https://lore.kernel.org/lkml/20220602034111.4163292-1-saravanak@google.com/

-Saravana

 kernel/module/signing.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index 85c8999dfecf..6b0672e4417b 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -16,6 +16,11 @@
 #include <uapi/linux/module.h>
 #include "internal.h"
 
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "module."
+
 static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
 module_param(sig_enforce, bool_enable_only, 0644);
 
-- 
2.36.1.255.ge46751e96f-goog

