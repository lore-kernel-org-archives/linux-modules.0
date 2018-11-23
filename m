Return-Path: <SRS0=Ba8G=OC=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A9AC43441
	for <linux-modules@archiver.kernel.org>; Fri, 23 Nov 2018 21:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00CD20664
	for <linux-modules@archiver.kernel.org>; Fri, 23 Nov 2018 21:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00CD20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeKXIjZ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 24 Nov 2018 03:39:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbeKXIjZ (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Sat, 24 Nov 2018 03:39:25 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4C5D76528;
        Fri, 23 Nov 2018 21:53:25 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-110.ams2.redhat.com [10.36.116.110])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CCDFF1019639;
        Fri, 23 Nov 2018 21:53:24 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     ykaliuta@redhat.com, Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [RFC PATCH 2/2] libkmod: module: make old symbol access API as wrapper to the new
Date:   Fri, 23 Nov 2018 23:53:22 +0200
Message-Id: <20181123215322.5438-3-yauheni.kaliuta@redhat.com>
In-Reply-To: <20181123215322.5438-1-yauheni.kaliuta@redhat.com>
References: <20181123215322.5438-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 23 Nov 2018 21:53:25 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Take in use the unified symbol access API but for compatibility keep
the old functions as wrappers to the new ones.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 libkmod/libkmod-module.c | 281 ++-------------------------------------
 1 file changed, 13 insertions(+), 268 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index f595f40032e0..e21a69bf2fd5 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2610,30 +2610,6 @@ KMOD_EXPORT void kmod_module_typed_symbols_free_list(struct kmod_list *list)
 	}
 }
 
-struct kmod_module_version {
-	uint64_t crc;
-	char symbol[];
-};
-
-static struct kmod_module_version *kmod_module_versions_new(uint64_t crc, const char *symbol)
-{
-	struct kmod_module_version *mv;
-	size_t symbollen = strlen(symbol) + 1;
-
-	mv = malloc(sizeof(struct kmod_module_version) + symbollen);
-	if (mv == NULL)
-		return NULL;
-
-	mv->crc = crc;
-	memcpy(mv->symbol, symbol, symbollen);
-	return mv;
-}
-
-static void kmod_module_version_free(struct kmod_module_version *version)
-{
-	free(version);
-}
-
 /**
  * kmod_module_get_versions:
  * @mod: kmod module
@@ -2650,53 +2626,8 @@ static void kmod_module_version_free(struct kmod_module_version *version)
  */
 KMOD_EXPORT int kmod_module_get_versions(const struct kmod_module *mod, struct kmod_list **list)
 {
-	struct kmod_elf *elf;
-	struct kmod_modversion *versions;
-	int i, count, ret = 0;
-
-	if (mod == NULL || list == NULL)
-		return -ENOENT;
-
-	assert(*list == NULL);
-
-	elf = kmod_module_get_elf(mod);
-	if (elf == NULL)
-		return -errno;
-
-	count = kmod_elf_get_modversions(elf, &versions);
-	if (count < 0)
-		return count;
-
-	for (i = 0; i < count; i++) {
-		struct kmod_module_version *mv;
-		struct kmod_list *n;
-
-		mv = kmod_module_versions_new(versions[i].crc, versions[i].symbol);
-		if (mv == NULL) {
-			ret = -errno;
-			kmod_module_versions_free_list(*list);
-			*list = NULL;
-			goto list_error;
-		}
-
-		n = kmod_list_append(*list, mv);
-		if (n != NULL)
-			*list = n;
-		else {
-			kmod_module_version_free(mv);
-			kmod_module_versions_free_list(*list);
-			*list = NULL;
-			ret = -ENOMEM;
-			goto list_error;
-		}
-	}
-	ret = count;
-
-list_error:
-	free(versions);
-	return ret;
+	return kmod_module_get_typed_symbols(mod, KMOD_SYMBOL_VERSIONS, list);
 }
-
 /**
  * kmod_module_version_get_symbol:
  * @entry: a list entry representing a kmod module versions
@@ -2708,13 +2639,7 @@ list_error:
  */
 KMOD_EXPORT const char *kmod_module_version_get_symbol(const struct kmod_list *entry)
 {
-	struct kmod_module_version *version;
-
-	if (entry == NULL || entry->data == NULL)
-		return NULL;
-
-	version = entry->data;
-	return version->symbol;
+	return kmod_module_typed_symbol_get_symbol(entry);
 }
 
 /**
@@ -2727,13 +2652,7 @@ KMOD_EXPORT const char *kmod_module_version_get_symbol(const struct kmod_list *e
  */
 KMOD_EXPORT uint64_t kmod_module_version_get_crc(const struct kmod_list *entry)
 {
-	struct kmod_module_version *version;
-
-	if (entry == NULL || entry->data == NULL)
-		return 0;
-
-	version = entry->data;
-	return version->crc;
+	return kmod_module_typed_symbol_get_crc(entry);
 }
 
 /**
@@ -2744,29 +2663,7 @@ KMOD_EXPORT uint64_t kmod_module_version_get_crc(const struct kmod_list *entry)
  */
 KMOD_EXPORT void kmod_module_versions_free_list(struct kmod_list *list)
 {
-	while (list) {
-		kmod_module_version_free(list->data);
-		list = kmod_list_remove(list);
-	}
-}
-
-static struct kmod_module_symbol *kmod_module_symbols_new(uint64_t crc, const char *symbol)
-{
-	struct kmod_module_symbol *mv;
-	size_t symbollen = strlen(symbol) + 1;
-
-	mv = malloc(sizeof(struct kmod_module_symbol) + symbollen);
-	if (mv == NULL)
-		return NULL;
-
-	mv->crc = crc;
-	memcpy(mv->symbol, symbol, symbollen);
-	return mv;
-}
-
-static void kmod_module_symbol_free(struct kmod_module_symbol *symbol)
-{
-	free(symbol);
+	kmod_module_typed_symbols_free_list(list);
 }
 
 /**
@@ -2785,51 +2682,7 @@ static void kmod_module_symbol_free(struct kmod_module_symbol *symbol)
  */
 KMOD_EXPORT int kmod_module_get_symbols(const struct kmod_module *mod, struct kmod_list **list)
 {
-	struct kmod_elf *elf;
-	struct kmod_modversion *symbols;
-	int i, count, ret = 0;
-
-	if (mod == NULL || list == NULL)
-		return -ENOENT;
-
-	assert(*list == NULL);
-
-	elf = kmod_module_get_elf(mod);
-	if (elf == NULL)
-		return -errno;
-
-	count = kmod_elf_get_symbols(elf, &symbols);
-	if (count < 0)
-		return count;
-
-	for (i = 0; i < count; i++) {
-		struct kmod_module_symbol *mv;
-		struct kmod_list *n;
-
-		mv = kmod_module_symbols_new(symbols[i].crc, symbols[i].symbol);
-		if (mv == NULL) {
-			ret = -errno;
-			kmod_module_symbols_free_list(*list);
-			*list = NULL;
-			goto list_error;
-		}
-
-		n = kmod_list_append(*list, mv);
-		if (n != NULL)
-			*list = n;
-		else {
-			kmod_module_symbol_free(mv);
-			kmod_module_symbols_free_list(*list);
-			*list = NULL;
-			ret = -ENOMEM;
-			goto list_error;
-		}
-	}
-	ret = count;
-
-list_error:
-	free(symbols);
-	return ret;
+	return kmod_module_get_typed_symbols(mod, KMOD_SYMBOL_CRC, list);
 }
 
 /**
@@ -2843,13 +2696,7 @@ list_error:
  */
 KMOD_EXPORT const char *kmod_module_symbol_get_symbol(const struct kmod_list *entry)
 {
-	struct kmod_module_symbol *symbol;
-
-	if (entry == NULL || entry->data == NULL)
-		return NULL;
-
-	symbol = entry->data;
-	return symbol->symbol;
+	return kmod_module_typed_symbol_get_symbol(entry);
 }
 
 /**
@@ -2862,13 +2709,7 @@ KMOD_EXPORT const char *kmod_module_symbol_get_symbol(const struct kmod_list *en
  */
 KMOD_EXPORT uint64_t kmod_module_symbol_get_crc(const struct kmod_list *entry)
 {
-	struct kmod_module_symbol *symbol;
-
-	if (entry == NULL || entry->data == NULL)
-		return 0;
-
-	symbol = entry->data;
-	return symbol->crc;
+	return kmod_module_typed_symbol_get_crc(entry);
 }
 
 /**
@@ -2879,36 +2720,7 @@ KMOD_EXPORT uint64_t kmod_module_symbol_get_crc(const struct kmod_list *entry)
  */
 KMOD_EXPORT void kmod_module_symbols_free_list(struct kmod_list *list)
 {
-	while (list) {
-		kmod_module_symbol_free(list->data);
-		list = kmod_list_remove(list);
-	}
-}
-
-struct kmod_module_dependency_symbol {
-	uint64_t crc;
-	uint8_t bind;
-	char symbol[];
-};
-
-static struct kmod_module_dependency_symbol *kmod_module_dependency_symbols_new(uint64_t crc, uint8_t bind, const char *symbol)
-{
-	struct kmod_module_dependency_symbol *mv;
-	size_t symbollen = strlen(symbol) + 1;
-
-	mv = malloc(sizeof(struct kmod_module_dependency_symbol) + symbollen);
-	if (mv == NULL)
-		return NULL;
-
-	mv->crc = crc;
-	mv->bind = bind;
-	memcpy(mv->symbol, symbol, symbollen);
-	return mv;
-}
-
-static void kmod_module_dependency_symbol_free(struct kmod_module_dependency_symbol *dependency_symbol)
-{
-	free(dependency_symbol);
+	kmod_module_typed_symbols_free_list(list);
 }
 
 /**
@@ -2928,53 +2740,7 @@ static void kmod_module_dependency_symbol_free(struct kmod_module_dependency_sym
  */
 KMOD_EXPORT int kmod_module_get_dependency_symbols(const struct kmod_module *mod, struct kmod_list **list)
 {
-	struct kmod_elf *elf;
-	struct kmod_modversion *symbols;
-	int i, count, ret = 0;
-
-	if (mod == NULL || list == NULL)
-		return -ENOENT;
-
-	assert(*list == NULL);
-
-	elf = kmod_module_get_elf(mod);
-	if (elf == NULL)
-		return -errno;
-
-	count = kmod_elf_get_dependency_symbols(elf, &symbols);
-	if (count < 0)
-		return count;
-
-	for (i = 0; i < count; i++) {
-		struct kmod_module_dependency_symbol *mv;
-		struct kmod_list *n;
-
-		mv = kmod_module_dependency_symbols_new(symbols[i].crc,
-							symbols[i].bind,
-							symbols[i].symbol);
-		if (mv == NULL) {
-			ret = -errno;
-			kmod_module_dependency_symbols_free_list(*list);
-			*list = NULL;
-			goto list_error;
-		}
-
-		n = kmod_list_append(*list, mv);
-		if (n != NULL)
-			*list = n;
-		else {
-			kmod_module_dependency_symbol_free(mv);
-			kmod_module_dependency_symbols_free_list(*list);
-			*list = NULL;
-			ret = -ENOMEM;
-			goto list_error;
-		}
-	}
-	ret = count;
-
-list_error:
-	free(symbols);
-	return ret;
+	return kmod_module_get_typed_symbols(mod, KMOD_SYMBOL_DEPENDENCY, list);
 }
 
 /**
@@ -2988,13 +2754,7 @@ list_error:
  */
 KMOD_EXPORT const char *kmod_module_dependency_symbol_get_symbol(const struct kmod_list *entry)
 {
-	struct kmod_module_dependency_symbol *dependency_symbol;
-
-	if (entry == NULL || entry->data == NULL)
-		return NULL;
-
-	dependency_symbol = entry->data;
-	return dependency_symbol->symbol;
+	return kmod_module_typed_symbol_get_symbol(entry);
 }
 
 /**
@@ -3007,13 +2767,7 @@ KMOD_EXPORT const char *kmod_module_dependency_symbol_get_symbol(const struct km
  */
 KMOD_EXPORT uint64_t kmod_module_dependency_symbol_get_crc(const struct kmod_list *entry)
 {
-	struct kmod_module_dependency_symbol *dependency_symbol;
-
-	if (entry == NULL || entry->data == NULL)
-		return 0;
-
-	dependency_symbol = entry->data;
-	return dependency_symbol->crc;
+	return kmod_module_typed_symbol_get_crc(entry);
 }
 
 /**
@@ -3027,13 +2781,7 @@ KMOD_EXPORT uint64_t kmod_module_dependency_symbol_get_crc(const struct kmod_lis
  */
 KMOD_EXPORT int kmod_module_dependency_symbol_get_bind(const struct kmod_list *entry)
 {
-	struct kmod_module_dependency_symbol *dependency_symbol;
-
-	if (entry == NULL || entry->data == NULL)
-		return 0;
-
-	dependency_symbol = entry->data;
-	return dependency_symbol->bind;
+	return kmod_module_typed_symbol_get_bind(entry);
 }
 
 /**
@@ -3044,8 +2792,5 @@ KMOD_EXPORT int kmod_module_dependency_symbol_get_bind(const struct kmod_list *e
  */
 KMOD_EXPORT void kmod_module_dependency_symbols_free_list(struct kmod_list *list)
 {
-	while (list) {
-		kmod_module_dependency_symbol_free(list->data);
-		list = kmod_list_remove(list);
-	}
+	kmod_module_typed_symbols_free_list(list);
 }
-- 
2.19.1

