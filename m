Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:34471 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721AbaFSAvf (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 18 Jun 2014 20:51:35 -0400
Received: by mail-qa0-f45.google.com with SMTP id v10so1390619qac.32
        for <linux-modules@vger.kernel.org>; Wed, 18 Jun 2014 17:51:34 -0700 (PDT)
From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
To: linux-modules@vger.kernel.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Subject: [PATCH] RESEND: add missing O_CLOEXEC in kmod_module_get_size()
Date: Wed, 18 Jun 2014 20:51:00 -0400
Message-Id: <1403139060-147474-1-git-send-email-crrodriguez@opensuse.org>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

---
 libkmod/libkmod-module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 1d90f34..8046262 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -1781,7 +1781,7 @@ KMOD_EXPORT long kmod_module_get_size(const struct kmod_module *mod)
 	 * loaded.
 	 */
 	snprintf(line, sizeof(line), "/sys/module/%s", mod->name);
-	dfd = open(line, O_RDONLY);
+	dfd = open(line, O_RDONLY|O_CLOEXEC);
 	if (dfd < 0)
 		return -errno;
 
-- 
1.8.4.5

