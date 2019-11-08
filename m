Return-Path: <SRS0=fLgB=ZA=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C7FFC6195
	for <linux-modules@archiver.kernel.org>; Fri,  8 Nov 2019 17:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDD3207FA
	for <linux-modules@archiver.kernel.org>; Fri,  8 Nov 2019 17:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfKHRZq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:25:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23947 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728769AbfKHRZq (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 8 Nov 2019 12:25:46 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-jD6sSU1TOqK9EHjXQNjYmA-1; Fri, 08 Nov 2019 12:25:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3509B2A3;
        Fri,  8 Nov 2019 17:25:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.43.2.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AC6C1001281;
        Fri,  8 Nov 2019 17:25:39 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH v2 4/4] modinfo: Show information about built-in modules
Date:   Fri,  8 Nov 2019 18:25:23 +0100
Message-Id: <20191108172524.468494-5-gladkov.alexey@gmail.com>
In-Reply-To: <20191108172524.468494-1-gladkov.alexey@gmail.com>
References: <20191108172524.468494-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: jD6sSU1TOqK9EHjXQNjYmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 libkmod/libkmod-builtin.c |  2 +-
 libkmod/libkmod-module.c  | 23 ++++++++++++++++-------
 tools/modinfo.c           | 39 +++++++++++++++++++++------------------
 3 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/libkmod/libkmod-builtin.c b/libkmod/libkmod-builtin.c
index c7b888a..6b4651c 100644
--- a/libkmod/libkmod-builtin.c
+++ b/libkmod/libkmod-builtin.c
@@ -275,7 +275,7 @@ ssize_t kmod_builtin_get_modinfo(struct kmod_ctx *ctx, const char *modname,
 	struct kmod_builtin_iter *iter = kmod_builtin_iter_new(ctx);
 
 	if (!iter)
-		return -1;
+		return -errno;
 
 	while (!name && kmod_builtin_iter_next(iter)) {
 		if (!kmod_builtin_iter_get_modname(iter, buf)) {
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index ee7e6bd..8044a8f 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2286,13 +2286,22 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
 
 	assert(*list == NULL);
 
-	elf = kmod_module_get_elf(mod);
-	if (elf == NULL)
-		return -errno;
+	/* remove const: this can only change internal state */
+	if (kmod_module_is_builtin((struct kmod_module *)mod)) {
+		count = kmod_builtin_get_modinfo(mod->ctx,
+						kmod_module_get_name(mod),
+						&strings);
+		if (count < 0)
+			return count;
+	} else {
+		elf = kmod_module_get_elf(mod);
+		if (elf == NULL)
+			return -errno;
 
-	count = kmod_elf_get_strings(elf, ".modinfo", &strings);
-	if (count < 0)
-		return count;
+		count = kmod_elf_get_strings(elf, ".modinfo", &strings);
+		if (count < 0)
+			return count;
+	}
 
 	for (i = 0; i < count; i++) {
 		struct kmod_list *n;
@@ -2316,7 +2325,7 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
 			goto list_error;
 	}
 
-	if (kmod_module_signature_info(mod->file, &sig_info)) {
+	if (mod->file && kmod_module_signature_info(mod->file, &sig_info)) {
 		struct kmod_list *n;
 
 		n = kmod_module_info_append(list, "sig_id", strlen("sig_id"),
diff --git a/tools/modinfo.c b/tools/modinfo.c
index 86ac04b..0231bb0 100644
--- a/tools/modinfo.c
+++ b/tools/modinfo.c
@@ -172,18 +172,33 @@ static int modinfo_do(struct kmod_module *mod)
 {
 	struct kmod_list *l, *list = NULL;
 	struct param *params = NULL;
-	int err;
+	int err, is_builtin;
+	const char *filename = kmod_module_get_path(mod);
+
+	is_builtin = (filename == NULL);
+
+	if (is_builtin) {
+		printf("%-16s%s%c", "name:", kmod_module_get_name(mod), separator);
+		filename = "(builtin)";
+	}
 
 	if (field != NULL && streq(field, "filename")) {
-		printf("%s%c", kmod_module_get_path(mod), separator);
+		printf("%s%c", filename, separator);
 		return 0;
 	} else if (field == NULL) {
 		printf("%-16s%s%c", "filename:",
-		       kmod_module_get_path(mod), separator);
+		       filename, separator);
 	}
 
 	err = kmod_module_get_info(mod, &list);
 	if (err < 0) {
+		if (is_builtin && err == -ENOENT) {
+			/*
+			 * This is an old kernel that does not have a file
+			 * with information about built-in modules.
+			 */
+			return 0;
+		}
 		ERR("could not get modinfo from '%s': %s\n",
 			kmod_module_get_name(mod), strerror(-err));
 		return err;
@@ -276,7 +291,7 @@ static int modinfo_path_do(struct kmod_ctx *ctx, const char *path)
 
 static int modinfo_alias_do(struct kmod_ctx *ctx, const char *alias)
 {
-	struct kmod_list *l, *filtered, *list = NULL;
+	struct kmod_list *l, *list = NULL;
 	int err = kmod_module_new_from_lookup(ctx, alias, &list);
 	if (err < 0) {
 		ERR("Module alias %s not found.\n", alias);
@@ -288,26 +303,14 @@ static int modinfo_alias_do(struct kmod_ctx *ctx, const char *alias)
 		return -ENOENT;
 	}
 
-	err = kmod_module_apply_filter(ctx, KMOD_FILTER_BUILTIN, list, &filtered);
-	kmod_module_unref_list(list);
-	if (err < 0) {
-		ERR("Failed to filter list: %m\n");
-		return err;
-	}
-
-	if (filtered == NULL) {
-		ERR("Module %s not found.\n", alias);
-		return -ENOENT;
-	}
-
-	kmod_list_foreach(l, filtered) {
+	kmod_list_foreach(l, list) {
 		struct kmod_module *mod = kmod_module_get_module(l);
 		int r = modinfo_do(mod);
 		kmod_module_unref(mod);
 		if (r < 0)
 			err = r;
 	}
-	kmod_module_unref_list(filtered);
+	kmod_module_unref_list(list);
 	return err;
 }
 
-- 
2.21.0

