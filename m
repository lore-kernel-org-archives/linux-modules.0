Return-Path: <SRS0=Ba8G=OC=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F47C43610
	for <linux-modules@archiver.kernel.org>; Fri, 23 Nov 2018 21:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D37220664
	for <linux-modules@archiver.kernel.org>; Fri, 23 Nov 2018 21:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D37220664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeKXIjY (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 24 Nov 2018 03:39:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeKXIjY (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Sat, 24 Nov 2018 03:39:24 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 85BDA65871;
        Fri, 23 Nov 2018 21:53:24 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-110.ams2.redhat.com [10.36.116.110])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8203E1019639;
        Fri, 23 Nov 2018 21:53:23 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     ykaliuta@redhat.com, Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [RFC PATCH 1/2] libkmod: module: introduce common symbol API.
Date:   Fri, 23 Nov 2018 23:53:21 +0200
Message-Id: <20181123215322.5438-2-yauheni.kaliuta@redhat.com>
In-Reply-To: <20181123215322.5438-1-yauheni.kaliuta@redhat.com>
References: <20181123215322.5438-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 23 Nov 2018 21:53:24 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Introduce one family of functions to replace the duplicated:

   - kmod_module_version_get_symbol()
   - kmod_module_version_get_crc()
   - kmod_module_symbol_get_symbol()
   - kmod_module_symbol_get_crc()
   - kmod_module_dependency_symbol_get_symbol()
   - kmod_module_dependency_symbol_get_crc()
   - kmod_module_versions_free_list()
   - kmod_module_symbols_free_list()
   - kmod_module_dependency_symbols_free_list()

It reuses kmod_module_symbol structure but extends it with the
"bind" field, keeping the API still the same.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 libkmod/libkmod-module.c | 196 ++++++++++++++++++++++++++++++++++++++-
 libkmod/libkmod.h        |  12 +++
 2 files changed, 203 insertions(+), 5 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 889f26479a98..f595f40032e0 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2419,6 +2419,197 @@ KMOD_EXPORT void kmod_module_info_free_list(struct kmod_list *list)
 	}
 }
 
+struct kmod_module_symbol {
+	uint64_t crc;
+	uint8_t bind;
+	char symbol[];
+};
+
+static struct kmod_module_symbol *kmod_module_typed_symbol_new(uint64_t crc, uint8_t bind, const char *symbol)
+{
+	struct kmod_module_symbol *ms;
+	size_t symbollen = strlen(symbol) + 1;
+
+	ms = malloc(sizeof(struct kmod_module_symbol) + symbollen);
+	if (ms == NULL)
+		return NULL;
+
+	ms->crc = crc;
+	ms->bind = bind;
+	memcpy(ms->symbol, symbol, symbollen);
+	return ms;
+}
+
+static void kmod_module_typed_symbol_free(struct kmod_module_symbol *ms)
+{
+	free(ms);
+}
+
+typedef int (*kmod_symbols_getter)(const struct kmod_elf *elf, struct kmod_modversion **array);
+
+static kmod_symbols_getter kmod_module_getter_lookup(const struct kmod_module *mod,
+						     enum kmod_symbol_type type)
+{
+	switch (type) {
+	case KMOD_SYMBOL_VERSIONS:
+		return kmod_elf_get_modversions;
+	case KMOD_SYMBOL_CRC:
+		return kmod_elf_get_symbols;
+	case KMOD_SYMBOL_DEPENDENCY:
+		return kmod_elf_get_dependency_symbols;
+	default:
+		ERR(mod->ctx, "Wrong symbol type requested: %d\n", type);
+	}
+
+	return NULL;
+}
+
+/**
+ * kmod_module_get_typed_symbols:
+ * @mod: kmod module
+ * @type: type of symbols to get:
+ *        KMOD_SYMBOL_VERSIONS
+ *        KMOD_SYMBOL_CRC
+ *        KMDO_SYMBOL_DEPENDENCY
+ * @list: where to return list of module symbols. Use
+ *        kmod_module_typed_symbol_get_symbol(),
+ *        kmod_module_typed_symbol_get_crc() and
+ *        kmod_module_typed_symbol_get_bind() to access the data.
+ *
+ *        After use, free the @list by calling
+ *        kmod_module_typed_symbols_free_list().
+ *
+ * Returns: 0 on success or < 0 otherwise.
+ */
+KMOD_EXPORT int kmod_module_get_typed_symbols(const struct kmod_module *mod, enum kmod_symbol_type type, struct kmod_list **list)
+{
+	struct kmod_elf *elf;
+	struct kmod_modversion *symbols;
+	int i, count, ret = 0;
+	kmod_symbols_getter getter;
+
+	if (mod == NULL || list == NULL)
+		return -ENOENT;
+
+	assert(*list == NULL);
+
+	elf = kmod_module_get_elf(mod);
+	if (elf == NULL)
+		return -errno;
+
+	getter = kmod_module_getter_lookup(mod, type);
+	if (getter == NULL)
+		return -ENOENT;
+
+	count = getter(elf, &symbols);
+	if (count < 0)
+		return count;
+
+	for (i = 0; i < count; i++) {
+		struct kmod_module_symbol *ms;
+		struct kmod_list *n;
+
+		ms = kmod_module_typed_symbol_new(symbols[i].crc,
+						  symbols[i].bind,
+						  symbols[i].symbol);
+		if (ms == NULL) {
+			ret = -errno;
+			kmod_module_typed_symbols_free_list(*list);
+			*list = NULL;
+			goto list_error;
+		}
+
+		n = kmod_list_append(*list, ms);
+		if (n != NULL)
+			*list = n;
+		else {
+			kmod_module_typed_symbol_free(ms);
+			kmod_module_typed_symbols_free_list(*list);
+			*list = NULL;
+			ret = -ENOMEM;
+			goto list_error;
+		}
+	}
+	ret = count;
+
+list_error:
+	free(symbols);
+	return ret;
+}
+
+/**
+ * kmod_module_typed_symbol_get_symbol:
+ * @entry: a list entry representing a kmod module typed symbol
+ *
+ * Get the symbol's name of the entry.
+ *
+ * Returns: the symbol's name of this kmod module symbols on success or NULL
+ * on failure. The string is owned by the list, do not free it.
+ */
+KMOD_EXPORT const char *kmod_module_typed_symbol_get_symbol(const struct kmod_list *entry)
+{
+	struct kmod_module_symbol *ms;
+
+	if (entry == NULL || entry->data == NULL)
+		return NULL;
+
+	ms = entry->data;
+	return ms->symbol;
+}
+
+/**
+ * kmod_module_typed_symbol_get_crc:
+ * @entry: a list entry representing a kmod module symbol
+ *
+ * Get the crc of the symbol.
+ *
+ * Returns: the crc of this kmod module symbol if available, otherwise default to 0.
+ */
+KMOD_EXPORT uint64_t kmod_module_typed_symbol_get_crc(const struct kmod_list *entry)
+{
+	struct kmod_module_symbol *ms;
+
+	if (entry == NULL || entry->data == NULL)
+		return 0;
+
+	ms = entry->data;
+	return ms->crc;
+}
+
+/**
+ * kmod_module_dependency_symbol_get_bind:
+ * @entry: a list entry representing a kmod module symbol
+ *
+ * Get the bind type of the symbol.
+ *
+ * Returns: the bind of this kmod module symbol on success
+ * or < 0 on failure.
+ */
+KMOD_EXPORT int kmod_module_typed_symbol_get_bind(const struct kmod_list *entry)
+{
+	struct kmod_module_symbol *ms;
+
+	if (entry == NULL || entry->data == NULL)
+		return 0;
+
+	ms = entry->data;
+	return ms->bind;
+}
+
+/**
+ * kmod_module_typed_symbols_free_list:
+ * @list: kmod module typed symbols list
+ *
+ * Release the resources taken by @list
+ */
+KMOD_EXPORT void kmod_module_typed_symbols_free_list(struct kmod_list *list)
+{
+	while (list) {
+		kmod_module_typed_symbol_free(list->data);
+		list = kmod_list_remove(list);
+	}
+}
+
 struct kmod_module_version {
 	uint64_t crc;
 	char symbol[];
@@ -2559,11 +2750,6 @@ KMOD_EXPORT void kmod_module_versions_free_list(struct kmod_list *list)
 	}
 }
 
-struct kmod_module_symbol {
-	uint64_t crc;
-	char symbol[];
-};
-
 static struct kmod_module_symbol *kmod_module_symbols_new(uint64_t crc, const char *symbol)
 {
 	struct kmod_module_symbol *mv;
diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
index 352627e5d018..9c10e8a54f54 100644
--- a/libkmod/libkmod.h
+++ b/libkmod/libkmod.h
@@ -258,6 +258,18 @@ int kmod_module_dependency_symbol_get_bind(const struct kmod_list *entry);
 uint64_t kmod_module_dependency_symbol_get_crc(const struct kmod_list *entry);
 void kmod_module_dependency_symbols_free_list(struct kmod_list *list);
 
+enum kmod_symbol_type {
+	KMOD_SYMBOL_VERSIONS = 1,
+	KMOD_SYMBOL_CRC,
+	KMOD_SYMBOL_DEPENDENCY,
+};
+
+int kmod_module_get_typed_symbols(const struct kmod_module *mod, enum kmod_symbol_type type, struct kmod_list **list);
+const char *kmod_module_typed_symbol_get_symbol(const struct kmod_list *entry);
+int kmod_module_typed_symbol_get_bind(const struct kmod_list *entry);
+uint64_t kmod_module_typed_symbol_get_crc(const struct kmod_list *entry);
+void kmod_module_typed_symbols_free_list(struct kmod_list *list);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
-- 
2.19.1

