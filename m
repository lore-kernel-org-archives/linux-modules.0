Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:55558 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751201AbdATXQN (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 20 Jan 2017 18:16:13 -0500
Received: from us-aus-exhub2.ni.corp.natinst.com (us-aus-exhub2.ni.corp.natinst.com [130.164.68.32])
        by us-aus-skprod3.natinst.com (8.15.0.59/8.15.0.59) with ESMTPS id v0KNG7k6027483
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-modules@vger.kernel.org>; Fri, 20 Jan 2017 17:16:07 -0600
From: James Minor <james.minor@ni.com>
To: <linux-modules@vger.kernel.org>
CC: <julia.cartwright@ni.com>, <zach.brown@ni.com>, <ken.sharp@ni.com>,
        James Minor <james.minor@ni.com>
Subject: [RFC v1] libkmod: Fix handling of quotes in kernel command line
Date: Fri, 20 Jan 2017 17:15:50 -0600
Message-ID: <1484954150-12831-1-git-send-email-james.minor@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

If a module parameter on the command line contains quotes, any
spaces inside those quotes should be included as part of the
parameter.

Signed-off-by: James Minor <james.minor@ni.com>
---
 libkmod/libkmod-config.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index 19f56a7..0596025 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -497,6 +497,7 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
 	char buf[KCMD_LINE_SIZE];
 	int fd, err;
 	char *p, *modname,  *param = NULL, *value = NULL, is_module = 1;
+	bool is_quoted = false;
 
 	fd = open("/proc/cmdline", O_RDONLY|O_CLOEXEC);
 	if (fd < 0) {
@@ -514,6 +515,12 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
 	}
 
 	for (p = buf, modname = buf; *p != '\0' && *p != '\n'; p++) {
+		if (*p == '"') {
+			is_quoted = !is_quoted;
+			continue;
+		}
+		if (is_quoted)
+			continue;
 		switch (*p) {
 		case ' ':
 			*p = '\0';
-- 
1.9.1

