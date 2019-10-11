Return-Path: <SRS0=2Kvf=YE=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B597C47404
	for <linux-modules@archiver.kernel.org>; Fri, 11 Oct 2019 08:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB8B21D7D
	for <linux-modules@archiver.kernel.org>; Fri, 11 Oct 2019 08:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfJKIUJ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:20:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbfJKIUJ (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 11 Oct 2019 04:20:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE3D4302C076;
        Fri, 11 Oct 2019 08:20:08 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.43.2.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4918460623;
        Fri, 11 Oct 2019 08:20:08 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH v1 2/4] libkmod: Add function to get list of built-in modules
Date:   Fri, 11 Oct 2019 10:19:54 +0200
Message-Id: <20191011081956.4127892-3-gladkov.alexey@gmail.com>
In-Reply-To: <20191011081956.4127892-1-gladkov.alexey@gmail.com>
References: <20191011081956.4127892-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 11 Oct 2019 08:20:09 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 libkmod/libkmod-internal.h |  1 +
 libkmod/libkmod-module.c   | 43 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 17ae541..d2000fe 100644
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
index bffe715..82b9fbe 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2866,3 +2866,46 @@ KMOD_EXPORT void kmod_module_dependency_symbols_free_list(struct kmod_list *list
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
+		const char *strings;
+		int count;
+
+		count = kmod_builtin_iter_get_strings(iter, &strings);
+
+		if (count < 1) {
+			err = -errno;
+			goto fail;
+		}
+
+		kmod_module_new_from_name(ctx, strings, &mod);
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

