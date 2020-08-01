Return-Path: <SRS0=lTjl=BL=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1B8C433E0
	for <linux-modules@archiver.kernel.org>; Sat,  1 Aug 2020 16:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19729207FB
	for <linux-modules@archiver.kernel.org>; Sat,  1 Aug 2020 16:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=devup.no header.i=@devup.no header.b="CYM9Ct94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgHAQCu (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 1 Aug 2020 12:02:50 -0400
Received: from out1.migadu.com ([91.121.223.63]:27706 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgHAQCu (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Sat, 1 Aug 2020 12:02:50 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devup.no; s=default;
        t=1596297768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Ddp9m3oOgNrfXCMtvidZYRUmW1PXkAbWY96WxiYQUo=;
        b=CYM9Ct94oysUgLULEWCz+QLi/IO9PWeDHUndf+LQf51ZtBP1ZVX3Cx3BV8TxkTrgZv+fUi
        +8m1fLCnef7/yP6pOTMzoQhT7JagzZwgnqGyASyTNoQHyy2i4NVetE73di0HhcGtV6a9FR
        tSmcpykHzsnISvlgFSR1GXkU8BIDY9g=
From:   Marius Bakke <marius@devup.no>
To:     linux-modules <linux-modules@vger.kernel.org>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH v2 1/2] testsuite: Add facility to skip tests.
Date:   Sat,  1 Aug 2020 18:02:21 +0200
Message-Id: <20200801160222.7464-1-marius@devup.no>
In-Reply-To: <87k0yipdd7.fsf@gnu.org>
References: <87k0yipdd7.fsf@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The Makefile helpfully warns that some tests will fail when
--sysconfdir != /etc, but there are no provisions to easily disable
those.  This commit provides an escape hatch.
---
 testsuite/testsuite.c | 9 +++++++++
 testsuite/testsuite.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
index e46f3d8..05df553 100644
--- a/testsuite/testsuite.c
+++ b/testsuite/testsuite.c
@@ -37,6 +37,7 @@
 #include "testsuite.h"
 
 static const char *ANSI_HIGHLIGHT_GREEN_ON = "\x1B[1;32m";
+static const char *ANSI_HIGHLIGHT_YELLOW_ON = "\x1B[1;33m";
 static const char *ANSI_HIGHLIGHT_RED_ON =  "\x1B[1;31m";
 static const char *ANSI_HIGHLIGHT_OFF = "\x1B[0m";
 
@@ -948,6 +949,14 @@ static inline int test_run_parent(const struct test *t, int fdout[2],
 	int err;
 	bool matchout, match_modules;
 
+	if (t->skip) {
+		LOG("%sSKIPPED%s: %s\n",
+			ANSI_HIGHLIGHT_YELLOW_ON, ANSI_HIGHLIGHT_OFF,
+			t->name);
+		err = EXIT_SUCCESS;
+		goto exit;
+	}
+
 	/* Close write-fds */
 	if (t->output.out != NULL)
 		close(fdout[1]);
diff --git a/testsuite/testsuite.h b/testsuite/testsuite.h
index 7ed96bf..8029c64 100644
--- a/testsuite/testsuite.h
+++ b/testsuite/testsuite.h
@@ -109,6 +109,7 @@ struct test {
 	const struct keyval *env_vars;
 	bool need_spawn;
 	bool expected_fail;
+	bool skip;
 	bool print_outputs;
 } __attribute__((aligned(8)));
 
-- 
2.28.0

