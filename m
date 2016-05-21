Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:46524 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbcEULlv (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Sat, 21 May 2016 07:41:51 -0400
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.84_2)
	(envelope-from <peter@lekensteyn.nl>)
	id 1b44si-00044w-7D
	for linux-modules@vger.kernel.org; Sat, 21 May 2016 13:16:30 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: linux-modules@vger.kernel.org
Subject: [PATCH] kmod_module_get_refcnt: fix documentation
Date: Sat, 21 May 2016 13:15:19 +0200
Message-Id: <1463829319-1668-1-git-send-email-peter@lekensteyn.nl>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

---
 libkmod/libkmod-module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 50b2ff9..1460c67 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -1863,7 +1863,7 @@ done:
  * Get the ref count of this @mod, as returned by Linux Kernel, by reading
  * /sys filesystem.
  *
- * Returns: 0 on success or < 0 on failure.
+ * Returns: the reference count on success or < 0 on failure.
  */
 KMOD_EXPORT int kmod_module_get_refcnt(const struct kmod_module *mod)
 {
-- 
2.8.2

