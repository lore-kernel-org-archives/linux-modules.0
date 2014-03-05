Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58781 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844AbaCEM20 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Wed, 5 Mar 2014 07:28:26 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 75BE6ACC8
	for <linux-modules@vger.kernel.org>; Wed,  5 Mar 2014 12:28:25 +0000 (UTC)
From: Michal Marek <mmarek@suse.cz>
To: linux-modules@vger.kernel.org
Subject: [PATCH] libkmod-config: Only match dot before '=' in /proc/cmdline
Date: Wed,  5 Mar 2014 13:27:41 +0100
Message-Id: <1394022461-1657-1-git-send-email-mmarek@suse.cz>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Otherwise, we also parse strings like

  BOOT_IMAGE=/boot/vmlinuz-3.12.12-57.g5f654cf-default

In practice, this is not a problem, because there is no module named
BOOT_IMAGE=/boot/vmlinuz-3. It just disturbs in modprobe -c output.
---
 libkmod/libkmod-config.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index 4417871..9905d5e 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -523,7 +523,7 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
 {
 	char buf[KCMD_LINE_SIZE];
 	int fd, err;
-	char *p, *modname,  *param = NULL, *value = NULL;
+	char *p, *modname,  *param = NULL, *value = NULL, is_module = 1;
 
 	fd = open("/proc/cmdline", O_RDONLY|O_CLOEXEC);
 	if (fd < 0) {
@@ -544,9 +544,11 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
 		switch (*p) {
 		case ' ':
 			*p = '\0';
-			kcmdline_parse_result(config, modname, param, value);
+			if (is_module)
+				kcmdline_parse_result(config, modname, param, value);
 			param = value = NULL;
 			modname = p + 1;
+			is_module = 1;
 			break;
 		case '.':
 			if (param == NULL) {
@@ -557,12 +559,15 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
 		case '=':
 			if (param != NULL)
 				value = p + 1;
+			else
+				is_module = 0;
 			break;
 		}
 	}
 
 	*p = '\0';
-	kcmdline_parse_result(config, modname, param, value);
+	if (is_module)
+		kcmdline_parse_result(config, modname, param, value);
 
 	return 0;
 }
-- 
1.8.4.5

