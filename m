Return-Path: <SRS0=q1k2=RK=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08E2C43381
	for <linux-modules@archiver.kernel.org>; Thu,  7 Mar 2019 20:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E2320675
	for <linux-modules@archiver.kernel.org>; Thu,  7 Mar 2019 20:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfCGUbk (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:31:40 -0500
Received: from heiko-becker.de ([185.21.103.105]:59386 "EHLO heiko-becker.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfCGUbk (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 7 Mar 2019 15:31:40 -0500
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Mar 2019 15:31:39 EST
Received: from gantenbein.fritz.box (i59F521E1.versanet.de [89.245.33.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by heiko-becker.de (Postfix) with ESMTPSA id 0DF351D5071;
        Thu,  7 Mar 2019 21:26:16 +0100 (CET)
From:   Heiko Becker <heirecka@exherbo.org>
To:     linux-modules@vger.kernel.org
Cc:     Heiko Becker <heirecka@exherbo.org>
Subject: [PATCH] Only use _FILE_OFFSET_BITS with __GLIBC__
Date:   Thu,  7 Mar 2019 21:26:06 +0100
Message-Id: <20190307202606.1488-1-heirecka@exherbo.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: heiko-becker.de;
        auth=pass smtp.auth=postmaster@shruuf.de smtp.mailfrom=heirecka@exherbo.org
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

It's a glibc specific macro. With the musl libc {,l}stat64 are just
a macro defined for compatibility and off_t is always 64bit. The
former's expansion causes a build error though:
"...testsuite/path.c:191:21: error: redefinition of 'stat'".
---
 testsuite/path.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testsuite/path.c b/testsuite/path.c
index fa5fceb..74db898 100644
--- a/testsuite/path.c
+++ b/testsuite/path.c
@@ -187,7 +187,7 @@ WRAP_2ARGS(int, -1, mkdir, mode_t);
 WRAP_2ARGS(int, -1, access, int);
 WRAP_2ARGS(int, -1, stat, struct stat*);
 WRAP_2ARGS(int, -1, lstat, struct stat*);
-#ifndef _FILE_OFFSET_BITS
+#if defined(__GLIBC__) && !defined(_FILE_OFFSET_BITS)
 WRAP_2ARGS(int, -1, stat64, struct stat64*);
 WRAP_2ARGS(int, -1, lstat64, struct stat64*);
 WRAP_OPEN(64);
@@ -198,7 +198,7 @@ WRAP_OPEN();
 #ifdef HAVE___XSTAT
 WRAP_VERSTAT(__x,);
 WRAP_VERSTAT(__lx,);
-#ifndef _FILE_OFFSET_BITS
+#if defined(__GLIBC__) && !defined(_FILE_OFFSET_BITS)
 WRAP_VERSTAT(__x,64);
 WRAP_VERSTAT(__lx,64);
 #endif
-- 
2.21.0

