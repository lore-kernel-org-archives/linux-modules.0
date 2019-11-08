Return-Path: <SRS0=fLgB=ZA=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C6AC5DF60
	for <linux-modules@archiver.kernel.org>; Fri,  8 Nov 2019 17:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDCE207FA
	for <linux-modules@archiver.kernel.org>; Fri,  8 Nov 2019 17:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfKHRZn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:25:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36355 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728714AbfKHRZn (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 8 Nov 2019 12:25:43 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-xXfbT6iUMwiwetJ8Hw6FEw-1; Fri, 08 Nov 2019 12:25:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 529788017E0;
        Fri,  8 Nov 2019 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.43.2.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A77EF1001281;
        Fri,  8 Nov 2019 17:25:37 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH v2 2/4] libkmod: Add function to get list of built-in modules
Date:   Fri,  8 Nov 2019 18:25:21 +0100
Message-Id: <20191108172524.468494-3-gladkov.alexey@gmail.com>
In-Reply-To: <20191108172524.468494-1-gladkov.alexey@gmail.com>
References: <20191108172524.468494-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: xXfbT6iUMwiwetJ8Hw6FEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 libkmod/libkmod-internal.h |  1 +
 libkmod/libkmod-module.c   | 40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index df01df1..ee4b97b 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -145,6 +145,7 @@ void kmod_module_set_visited(struct kmod_module *mod, bool visited) __attribute_
 void kmod_module_set_builtin(struct kmod_module *mod, bool builtin) __attribute__((nonnull((1))));
 void kmod_module_set_required(struct kmod_module *mod, bool required) __attribute__((nonnull(1)));
 bool kmod_module_is_builtin(struct kmod_module *mod) __attribute__((nonnull(1)));
+int kmod_module_get_builtin(struct kmod_ctx *ctx, struct kmod_list **list) __attribute__((nonnull(1, 2)));
 
 /* libkmod-file.c */
 struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx, const char *filename) _must_check_ __attribute__((nonnull(1,2)));
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index bffe715..8fbabd2 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2866,3 +2866,43 @@ KMOD_EXPORT void kmod_module_dependency_symbols_free_list(struct kmod_list *list
 		list = kmod_list_remove(list);
 	}
 }
+
+/**
+ * kmod_module_get_builtin:
+ * @ctx: kmod library context
+ * @list: where to save the builtin module list
+ *
+ * Returns: 0 on success or < 0 otherwise.
+ */
+int kmod_module_get_builtin(struct kmod_ctx *ctx, struct kmod_list **list)
+{
+	struct kmod_builtin_iter *iter;
+	int err = 0;
+
+	iter = kmod_builtin_iter_new(ctx);
+	if (!iter)
+		return -errno;
+
+	while (kmod_builtin_iter_next(iter)) {
+		struct kmod_module *mod = NULL;
+		char modname[PATH_MAX];
+
+		if (!kmod_builtin_iter_get_modname(iter, modname)) {
+			err = -errno;
+			goto fail;
+		}
+
+		kmod_module_new_from_name(ctx, modname, &mod);
+		kmod_module_set_builtin(mod, true);
+
+		*list = kmod_list_append(*list, mod);
+	}
+
+	kmod_builtin_iter_free(iter);
+	return err;
+fail:
+	kmod_builtin_iter_free(iter);
+	kmod_module_unref_list(*list);
+	*list = NULL;
+	return err;
+}
-- 
2.21.0

