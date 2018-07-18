Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from a3.inai.de ([88.198.85.195]:49038 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbeGRJUb (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 18 Jul 2018 05:20:31 -0400
From: Jan Engelhardt <jengelh@inai.de>
To: lucas.demarchi@intel.com
Cc: linux-modules@vger.kernel.org, jengelh@inai.de
Subject: [PATCH] libkmod: drop _PAD enum constants
Date: Wed, 18 Jul 2018 10:43:40 +0200
Message-Id: <20180718084340.4305-1-jengelh@inai.de>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

When are enums ever mapped to something smaller than int, other than
willful packing into a bitfield?
---
 libkmod/libkmod.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
index 352627e..4fb5ba8 100644
--- a/libkmod/libkmod.h
+++ b/libkmod/libkmod.h
@@ -71,8 +71,6 @@ enum kmod_index {
 	KMOD_INDEX_MODULES_ALIAS,
 	KMOD_INDEX_MODULES_SYMBOL,
 	KMOD_INDEX_MODULES_BUILTIN,
-	/* Padding to make sure enum is not mapped to char */
-	_KMOD_INDEX_PAD = 1U << 31,
 };
 int kmod_dump_index(struct kmod_ctx *ctx, enum kmod_index type, int fd);
 
@@ -210,8 +208,6 @@ enum kmod_module_initstate {
 	KMOD_MODULE_LIVE,
 	KMOD_MODULE_COMING,
 	KMOD_MODULE_GOING,
-	/* Padding to make sure enum is not mapped to char */
-	_KMOD_MODULE_PAD = 1U << 31,
 };
 const char *kmod_module_initstate_str(enum kmod_module_initstate state);
 int kmod_module_get_initstate(const struct kmod_module *mod);
-- 
2.18.0

