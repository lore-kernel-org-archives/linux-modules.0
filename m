Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35026 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbdBOLSL (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 15 Feb 2017 06:18:11 -0500
Received: by mail-wm0-f47.google.com with SMTP id v186so39236148wmd.0
        for <linux-modules@vger.kernel.org>; Wed, 15 Feb 2017 03:18:11 -0800 (PST)
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
To: linux-modules@vger.kernel.org
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] module: fix a memory leak
Date: Wed, 15 Feb 2017 12:18:03 +0100
Message-Id: <1487157483-12848-1-git-send-email-bgolaszewski@baylibre.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

When a module is removed and re-inserted without unrefing, the
kmod_file is unconditionally re-opened. This results in a memory
and file descriptor leak.

Fix it by checking if the file is already open in
kmod_module_insert_module().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 libkmod/libkmod-module.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index bf6a8d6..57da0a2 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -833,10 +833,12 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
 		return -ENOENT;
 	}
 
-	mod->file = kmod_file_open(mod->ctx, path);
-	if (mod->file == NULL) {
-		err = -errno;
-		return err;
+	if (!mod->file) {
+		mod->file = kmod_file_open(mod->ctx, path);
+		if (mod->file == NULL) {
+			err = -errno;
+			return err;
+		}
 	}
 
 	if (kmod_file_get_direct(mod->file)) {
-- 
2.9.3

