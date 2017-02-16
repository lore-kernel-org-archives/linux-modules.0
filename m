Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:32024 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932769AbdBPR2c (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 16 Feb 2017 12:28:32 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-modules@vger.kernel.org
Cc: James Minor <james.minor@ni.com>, julia.cartwright@ni.com,
        zach.brown@ni.com, ken.sharp@ni.com
Subject: [PATCH 1/2] libkmod-config: replace 0/1 with bool
Date: Thu, 16 Feb 2017 09:28:30 -0800
Message-Id: <20170216172831.3019-1-lucas.demarchi@intel.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

---
 libkmod/libkmod-config.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index 0596025..18f300a 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -496,8 +496,8 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
 {
 	char buf[KCMD_LINE_SIZE];
 	int fd, err;
-	char *p, *modname,  *param = NULL, *value = NULL, is_module = 1;
-	bool is_quoted = false;
+	char *p, *modname,  *param = NULL, *value = NULL;
+	bool is_quoted = false, is_module = true;
 
 	fd = open("/proc/cmdline", O_RDONLY|O_CLOEXEC);
 	if (fd < 0) {
@@ -528,7 +528,7 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
 				kcmdline_parse_result(config, modname, param, value);
 			param = value = NULL;
 			modname = p + 1;
-			is_module = 1;
+			is_module = true;
 			break;
 		case '.':
 			if (param == NULL) {
@@ -540,7 +540,7 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
 			if (param != NULL)
 				value = p + 1;
 			else
-				is_module = 0;
+				is_module = false;
 			break;
 		}
 	}
-- 
2.9.3

