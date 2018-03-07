Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from aibo.runbox.com ([91.220.196.211]:48132 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbeCGLTy (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 7 Mar 2018 06:19:54 -0500
Received: from [10.9.9.212] (helo=mailfront12.runbox.com)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <lucab@debian.org>)
        id 1etWfS-0003bd-Dc
        for linux-modules@vger.kernel.org; Wed, 07 Mar 2018 11:51:30 +0100
Received: from cable-89-16-153-196.cust.telecolumbus.net ([89.16.153.196] helo=localhost)
        by mailfront12.runbox.com with esmtpsa  (uid:899704 )  (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        id 1etWfK-0001BE-8G
        for linux-modules@vger.kernel.org; Wed, 07 Mar 2018 11:51:22 +0100
From: Luca Bruno <luca.bruno@coreos.com>
To: linux-modules@vger.kernel.org
Subject: [PATCH] libkmod-module: check for NULL before accessing pointers
Date: Wed,  7 Mar 2018 10:51:21 +0000
Message-Id: <20180307105121.18634-1-luca.bruno@coreos.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

This introduces a few missing NULL-checks in public functions, and
align their docstrings with real behavior by getting rid of copy-paste
mistakes.

Signed-off-by: Luca Bruno <luca.bruno@coreos.com>
---
 TODO                     |  5 +++++
 libkmod/libkmod-module.c | 23 ++++++++++-------------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/TODO b/TODO
index 537e7e1..3fe06eb 100644
--- a/TODO
+++ b/TODO
@@ -35,6 +35,11 @@ and libkmod
    - kmod_module_symbols_free_list()
    - kmod_module_dependency_symbols_free_list()
 
+* libkmod API breaking changes:
+   - dedicated error value for all kmod_*_get_crc() functions. Currently there
+     is no way for callers to distinguish between a valid CRC=0 and the error
+     code 0.
+
 * index: drop the "open(), seek(), read()" implementation and use another one
   with mmap(). When lookup() is called and the file is not mmaped, mmap it.
   Another possibility is to drop the mmap implementation relying on VFS to have
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 0a3ef11..ee420f4 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2519,7 +2519,7 @@ KMOD_EXPORT const char *kmod_module_version_get_symbol(const struct kmod_list *e
 {
 	struct kmod_module_version *version;
 
-	if (entry == NULL)
+	if (entry == NULL || entry->data == NULL)
 		return NULL;
 
 	version = entry->data;
@@ -2532,14 +2532,13 @@ KMOD_EXPORT const char *kmod_module_version_get_symbol(const struct kmod_list *e
  *
  * Get the crc of a kmod module version.
  *
- * Returns: the crc of this kmod module version on success or NULL on
- * failure. The string is owned by the version, do not free it.
+ * Returns: the crc of this kmod module version if available, otherwise default to 0.
  */
 KMOD_EXPORT uint64_t kmod_module_version_get_crc(const struct kmod_list *entry)
 {
 	struct kmod_module_version *version;
 
-	if (entry == NULL)
+	if (entry == NULL || entry->data == NULL)
 		return 0;
 
 	version = entry->data;
@@ -2660,7 +2659,7 @@ KMOD_EXPORT const char *kmod_module_symbol_get_symbol(const struct kmod_list *en
 {
 	struct kmod_module_symbol *symbol;
 
-	if (entry == NULL)
+	if (entry == NULL || entry->data == NULL)
 		return NULL;
 
 	symbol = entry->data;
@@ -2673,14 +2672,13 @@ KMOD_EXPORT const char *kmod_module_symbol_get_symbol(const struct kmod_list *en
  *
  * Get the crc of a kmod module symbol.
  *
- * Returns: the crc of this kmod module symbol on success or NULL on
- * failure. The string is owned by the symbol, do not free it.
+ * Returns: the crc of this kmod module symbol if available, otherwise default to 0.
  */
 KMOD_EXPORT uint64_t kmod_module_symbol_get_crc(const struct kmod_list *entry)
 {
 	struct kmod_module_symbol *symbol;
 
-	if (entry == NULL)
+	if (entry == NULL || entry->data == NULL)
 		return 0;
 
 	symbol = entry->data;
@@ -2806,7 +2804,7 @@ KMOD_EXPORT const char *kmod_module_dependency_symbol_get_symbol(const struct km
 {
 	struct kmod_module_dependency_symbol *dependency_symbol;
 
-	if (entry == NULL)
+	if (entry == NULL || entry->data == NULL)
 		return NULL;
 
 	dependency_symbol = entry->data;
@@ -2819,14 +2817,13 @@ KMOD_EXPORT const char *kmod_module_dependency_symbol_get_symbol(const struct km
  *
  * Get the crc of a kmod module dependency_symbol.
  *
- * Returns: the crc of this kmod module dependency_symbol on success or NULL on
- * failure. The string is owned by the dependency_symbol, do not free it.
+ * Returns: the crc of this kmod module dependency_symbol if available, otherwise default to 0.
  */
 KMOD_EXPORT uint64_t kmod_module_dependency_symbol_get_crc(const struct kmod_list *entry)
 {
 	struct kmod_module_dependency_symbol *dependency_symbol;
 
-	if (entry == NULL)
+	if (entry == NULL || entry->data == NULL)
 		return 0;
 
 	dependency_symbol = entry->data;
@@ -2846,7 +2843,7 @@ KMOD_EXPORT int kmod_module_dependency_symbol_get_bind(const struct kmod_list *e
 {
 	struct kmod_module_dependency_symbol *dependency_symbol;
 
-	if (entry == NULL)
+	if (entry == NULL || entry->data == NULL)
 		return 0;
 
 	dependency_symbol = entry->data;
-- 
2.16.1

