Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E762C433DB
	for <linux-modules@archiver.kernel.org>; Fri, 12 Feb 2021 09:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA23B60241
	for <linux-modules@archiver.kernel.org>; Fri, 12 Feb 2021 09:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhBLJqq (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 12 Feb 2021 04:46:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:64846 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBLJqm (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 12 Feb 2021 04:46:42 -0500
IronPort-SDR: zKHwKHEfXD32G1M6ecg3K5gW1LYisMYlxYqxhEmB8MX/sk972sgRE6tP9NvjgNmkBXSFS1nPbf
 oKuDlG6lauJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="182458953"
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="182458953"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 01:46:00 -0800
IronPort-SDR: VK1XWYuWz/RSvWJKt4rtTqGXJ82VKH5OhHmHuIwh9wqyEFC0/EE+QFflExeknadXoTPRz+sRGE
 ihZM/UF23UYg==
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="381387359"
Received: from aaramire-mobl2.amr.corp.intel.com (HELO ldmartin-desk1.intel.com) ([10.212.210.126])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 01:45:59 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 1/4] libkmod-config: revamp kcmdline parsing into a state machine
Date:   Fri, 12 Feb 2021 01:45:21 -0800
Message-Id: <20210212094524.170861-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The handling of spaces and quotes is becoming hard to maintain. Convert
the parser into a state machine so we can check all the states. This
should make it easier to fix a corner case we have right now:
The kernel also accepts a quote before the module name instead of the
value. But this additional is left for later. This is purely an
algorithm change with no behavior change.
---
 libkmod/libkmod-config.c | 86 ++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 34 deletions(-)

diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index 971f20b..d3cd10d 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -499,7 +499,14 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
 	char buf[KCMD_LINE_SIZE];
 	int fd, err;
 	char *p, *modname,  *param = NULL, *value = NULL;
-	bool is_quoted = false, is_module = true;
+	bool is_quoted = false, iter = true;
+	enum state {
+		STATE_IGNORE,
+		STATE_MODNAME,
+		STATE_PARAM,
+		STATE_VALUE,
+		STATE_COMPLETE,
+	} state;
 
 	fd = open("/proc/cmdline", O_RDONLY|O_CLOEXEC);
 	if (fd < 0) {
@@ -516,54 +523,65 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
 		return err;
 	}
 
-	for (p = buf, modname = buf; *p != '\0' && *p != '\n'; p++) {
-		if (*p == '"') {
+	state = STATE_MODNAME;
+	for (p = buf, modname = buf; iter; p++) {
+		switch (*p) {
+		case '"':
 			is_quoted = !is_quoted;
-
-			if (is_quoted) {
-				/* don't consider a module until closing quotes */
-				is_module = false;
-			} else if (param != NULL && value != NULL) {
+			break;
+		case '\0':
+		case '\n':
+			/* Stop iterating on new chars */
+			iter = false;
+			/* fall-through */
+		case ' ':
+			if (is_quoted && state == STATE_VALUE) {
+				/* no state change*/;
+			} else if (is_quoted) {
+				/* spaces are only allowed in the value part */
+				state = STATE_IGNORE;
+			} else if (state == STATE_VALUE || state == STATE_PARAM) {
+				*p = '\0';
+				state = STATE_COMPLETE;
+			} else {
 				/*
-				 * If we are indeed expecting a value and
-				 * closing quotes, then this can be considered
-				 * a valid option for a module
+				 * go to next option, ignoring any possible
+				 * partial match we have
 				 */
-				is_module = true;
+				modname = p + 1;
+				state = STATE_MODNAME;
 			}
-
-			continue;
-		}
-		if (is_quoted)
-			continue;
-
-		switch (*p) {
-		case ' ':
-			*p = '\0';
-			if (is_module)
-				kcmdline_parse_result(config, modname, param, value);
-			param = value = NULL;
-			modname = p + 1;
-			is_module = true;
 			break;
 		case '.':
-			if (param == NULL) {
+			if (state == STATE_MODNAME) {
 				*p = '\0';
 				param = p + 1;
+				state = STATE_PARAM;
+			} else if (state == STATE_PARAM) {
+				state = STATE_IGNORE;
 			}
 			break;
 		case '=':
-			if (param != NULL)
+			if (state == STATE_PARAM) {
+				/*
+				 * Don't set *p to '\0': the value var shadows
+				 * param
+				 */
 				value = p + 1;
-			else
-				is_module = false;
+				state = STATE_VALUE;
+			} else if (state == STATE_MODNAME) {
+				state = STATE_IGNORE;
+			}
 			break;
 		}
-	}
 
-	*p = '\0';
-	if (is_module)
-		kcmdline_parse_result(config, modname, param, value);
+		if (state == STATE_COMPLETE) {
+			kcmdline_parse_result(config, modname, param, value);
+			/* start over on next iteration */
+			modname = p + 1;
+			state = STATE_MODNAME;
+		}
+	}
 
 	return 0;
 }
-- 
2.30.0

