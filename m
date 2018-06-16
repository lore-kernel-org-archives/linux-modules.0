Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from a3.inai.de ([88.198.85.195]:58092 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753907AbeFPGxA (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Sat, 16 Jun 2018 02:53:00 -0400
From: Jan Engelhardt <jengelh@inai.de>
To: lucas.demarchi@intel.com
Cc: jengelh@inai.de, linux-modules@vger.kernel.org
Subject: [PATCH] kmod: build: cure compiler warnings showing up externally
Date: Sat, 16 Jun 2018 08:45:20 +0200
Message-Id: <20180616064520.6426-1-jengelh@inai.de>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

When building a C source file with gcc-7 -Wshift-overflow=2, this warning
springs up:

libkmod.h: warning: result of "1 << 31" requires 33 bits to
represent, but "int" only has 32 bits [-Wshift-overflow=]

Change the two _KMOD_* identifiers to fit into 32 bits.
---
 libkmod/libkmod.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
index f9e33c6..352627e 100644
--- a/libkmod/libkmod.h
+++ b/libkmod/libkmod.h
@@ -72,7 +72,7 @@ enum kmod_index {
 	KMOD_INDEX_MODULES_SYMBOL,
 	KMOD_INDEX_MODULES_BUILTIN,
 	/* Padding to make sure enum is not mapped to char */
-	_KMOD_INDEX_PAD = (1 << 31),
+	_KMOD_INDEX_PAD = 1U << 31,
 };
 int kmod_dump_index(struct kmod_ctx *ctx, enum kmod_index type, int fd);
 
@@ -211,7 +211,7 @@ enum kmod_module_initstate {
 	KMOD_MODULE_COMING,
 	KMOD_MODULE_GOING,
 	/* Padding to make sure enum is not mapped to char */
-	_KMOD_MODULE_PAD = (1 << 31),
+	_KMOD_MODULE_PAD = 1U << 31,
 };
 const char *kmod_module_initstate_str(enum kmod_module_initstate state);
 int kmod_module_get_initstate(const struct kmod_module *mod);
-- 
2.17.1

