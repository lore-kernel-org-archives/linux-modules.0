Return-Path: <SRS0=0JHF=66=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECF2C433DF
	for <linux-modules@archiver.kernel.org>; Sat, 16 May 2020 13:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D618206D8
	for <linux-modules@archiver.kernel.org>; Sat, 16 May 2020 13:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=devup.no header.i=@devup.no header.b="EMMceMDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgEPNEP (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 16 May 2020 09:04:15 -0400
Received: from out0.migadu.com ([94.23.1.103]:36912 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgEPNEP (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Sat, 16 May 2020 09:04:15 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 May 2020 09:04:15 EDT
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devup.no; s=default;
        t=1589633654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9RTJOm8yC34a4M4YT4OvySh+BcXgzFx0aNaBMoBNocw=;
        b=EMMceMDWzs42ajri5j6CRZ9O98O/KHmYA8Z/xOhqRf4z+7QhYzi2GqXkFgCcnj9q6xuWOR
        TtE4KPS0zxWmCD1uFkDYuMkPZJ2A7xs9kVaT0bYog1GFhwT0OzfsScOvEcVCmiI9OH3ZZG
        W6phsUmKRfzw2wMnE0qRvlWOVItZpvU=
From:   Marius Bakke <marius@devup.no>
To:     linux-modules@vger.kernel.org
Subject: [PATCH] testsuite: Add facility to skip tests.
Date:   Sat, 16 May 2020 14:54:12 +0200
Message-Id: <20200516125412.12366-1-marius@devup.no>
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
index e46f3d8..ff41057 100644
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
 
+	if (t->skip == true) {
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
2.26.2

