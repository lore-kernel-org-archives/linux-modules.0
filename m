Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B42C433ED
	for <linux-modules@archiver.kernel.org>; Tue,  4 May 2021 23:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2C76115B
	for <linux-modules@archiver.kernel.org>; Tue,  4 May 2021 23:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhEDX7v (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 4 May 2021 19:59:51 -0400
Received: from smtp2.axis.com ([195.60.68.18]:30771 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhEDX7v (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 4 May 2021 19:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1620172736;
  x=1651708736;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jfOOcHL+mey+1TF82StxZqewdwk21A1kCM0L21mUzMI=;
  b=VxsMFhLtr0ndmw+7xTSXQEoF0mKSFeOzygnazAky9Q5xP+8Av3cMNqK2
   bL6KiXEhIP3fcpSVNHlwPamzKlHx5AiaFRSk11Io14mcMJMaXhagugPhd
   ccPbPKufH9zz2rqM3cZj8MtbVshhjmJvzH4H7YkH29p4OhFKbsGdiVAwX
   Yk9ifreiNm4rTjzFWPdhhSAZi+BW9egfeDMTiWm0my6MoAv2FPtwtRtFm
   Cp6mTARv7P3Hsmo7nJ2DDQbV6R0iZkNUOUnvEKITbdhpUbaWklMPtK6X1
   AkAZzbc+aEG1W/DlK++1gJxVeZAK94vWa2BVxEFFN5JaGtr8yBwobo9wG
   Q==;
From:   Peter Kjellerstedt <pkj@axis.com>
To:     <linux-modules@vger.kernel.org>
CC:     Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: [PATCH] libkmod: Always search modules.builtin if no alias has been found
Date:   Wed, 5 May 2021 01:58:36 +0200
Message-ID: <20210504235836.24246-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Commit 89443220e broke the lookup for builtin modules. modules.builtin
was no longer searched if kmod_lookup_alias_from_kernel_builtin_file()
returned 0.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

I do not know if this is the correct thing to do, or if the commit
message makes any sense. However, it solves the problem we were seeing.
We use fuse, which installs /etc/modules-load.d/fuse.conf to load the
fuse kernel module. However, we have fuse built-in. Normally, the
following can be seen in the log:

  systemd-modules-load[192]: Module 'fuse' is built in

but after commit 89443220e, we instead got:

  systemd-modules-load[193]: Failed to find module 'fuse'

//Peter

 libkmod/libkmod-module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 76a6dc3..6720930 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -577,7 +577,7 @@ KMOD_EXPORT int kmod_module_new_from_lookup(struct kmod_ctx *ctx,
 
 	DBG(ctx, "lookup modules.builtin.modinfo %s\n", alias);
 	err = kmod_lookup_alias_from_kernel_builtin_file(ctx, alias, list);
-	if (err == -ENOSYS) {
+	if (err == 0 || err == -ENOSYS) {
 		/* Optional index missing, try the old one */
 		DBG(ctx, "lookup modules.builtin %s\n", alias);
 		err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
