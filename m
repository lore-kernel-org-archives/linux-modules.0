Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E18C6379F
	for <linux-modules@archiver.kernel.org>; Tue, 21 Feb 2023 13:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjBUNTg (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 21 Feb 2023 08:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjBUNTf (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 21 Feb 2023 08:19:35 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5B41ADC3
        for <linux-modules@vger.kernel.org>; Tue, 21 Feb 2023 05:19:34 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id iv11-20020a05600c548b00b003dc52fed235so3036435wmb.1
        for <linux-modules@vger.kernel.org>; Tue, 21 Feb 2023 05:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx8bse47PfJtv3OhMIw1BoYoCIVWADStrE71XZeBTMs=;
        b=nRWmGyWCztjAVyPBelo0N08grmwkmjw7A+l0zVuqsN/V1rFafxkp3KlfExBZzQ5zfL
         EMEaVFzo6e015QrGzS/V+3PH46JHfgXHlpNx9lW+OWKFqB5DglU6eFesbIMbb7Fvczl7
         X+SAM7EobP7h0G5g/nmsLbvDQ7/7Zz0hh7Y6R59ApzpeX1oaY3TK3ux919uu1kx1/pmQ
         VaUaj96i22Qe6/1PMSqM2gO8g7T5KjDWILLqpOsPyLuGvUHevf61EBFR2rJH1yskFOXb
         rD1QhEfzrbu2MZXnz7MPioFQdwddMvlfjSyqGK5JMdwjM5p0mnL3NtbB7vQ+uapKEWFK
         Ww6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx8bse47PfJtv3OhMIw1BoYoCIVWADStrE71XZeBTMs=;
        b=oqldtbMs+MIvqAzsgRAF0ujVOZoAkQ6yUiq3PgS1HZNySe51MkCbrN/qyo7oZ0O5y8
         5ru0u0uET46jSHJeeohDz85lUtydkj3AIEHyMp6QrU3NVXa0T6Ky/0pOiFMUhcO5ACEh
         Nh7DSxp7YxEgpppP+DHXOEF6CfYjSwBsoySafDuS0MWfnCf9Zp0bA5G6JCWV6lGM9v1F
         CrE+8J3Vvy181UFh2VXsS/tBcNWb1/jZscMTp1wW7bOefFZ5mkDOxmPCzNhK4yQ6Gw97
         t7FEw6ogJyVxhjgnfX4OA5KR1/4FFBXWUNtP/NuYofpLVXkbli+IEncM4J6E4jN41oke
         5F4A==
X-Gm-Message-State: AO0yUKV1iP7kKkxReZWt9Y5Ifakpqh/v/HAvhF61UgGLOxZUYaPikbZv
        gLvR6NzDdsbAYh2Scjx2Ielgn6KFoJw=
X-Google-Smtp-Source: AK7set+5xeCVxvUt5qu3of79Ix7EUWWe9XObRkhS395G4njqiilo4qyqML6FeqMpbKMbh8WWl3GNxw==
X-Received: by 2002:a05:600c:2ed3:b0:3dc:2137:d67d with SMTP id q19-20020a05600c2ed300b003dc2137d67dmr3498061wmn.16.1676985572371;
        Tue, 21 Feb 2023 05:19:32 -0800 (PST)
Received: from localhost (cpc92308-cmbg19-2-0-cust99.5-4.cable.virginm.net. [82.24.248.100])
        by smtp.gmail.com with UTF8SMTPSA id 20-20020a05600c025400b003e71a6be279sm3064277wmj.37.2023.02.21.05.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 05:19:31 -0800 (PST)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     emil.l.velikov@gmail.com
Subject: [PATCH 1/4] libkmod: remove unused kmod_module_get_builtin
Date:   Tue, 21 Feb 2023 13:19:26 +0000
Message-Id: <20230221131929.106951-2-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221131929.106951-1-emil.l.velikov@gmail.com>
References: <20230221131929.106951-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Emil Velikov <emil.velikov@collabora.com>

The last and only user was removed with commit 0246e06 ("depmod: Stop
opening modules.modinfo once per module")

Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
---
 libkmod/libkmod-internal.h |  1 -
 libkmod/libkmod-module.c   | 43 --------------------------------------
 2 files changed, 44 deletions(-)

diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index c22644a..95c0377 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -148,7 +148,6 @@ void kmod_module_set_visited(struct kmod_module *mod, bool visited) __attribute_
 void kmod_module_set_builtin(struct kmod_module *mod, bool builtin) __attribute__((nonnull((1))));
 void kmod_module_set_required(struct kmod_module *mod, bool required) __attribute__((nonnull(1)));
 bool kmod_module_is_builtin(struct kmod_module *mod) __attribute__((nonnull(1)));
-int kmod_module_get_builtin(struct kmod_ctx *ctx, struct kmod_list **list) __attribute__((nonnull(1, 2)));
 
 /* libkmod-file.c */
 struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx, const char *filename) _must_check_ __attribute__((nonnull(1,2)));
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index c7232e0..1da64b3 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2943,46 +2943,3 @@ KMOD_EXPORT void kmod_module_dependency_symbols_free_list(struct kmod_list *list
 		list = kmod_list_remove(list);
 	}
 }
-
-/**
- * kmod_module_get_builtin:
- * @ctx: kmod library context
- * @list: where to save the builtin module list
- *
- * Returns: 0 on success or < 0 otherwise.
- */
-int kmod_module_get_builtin(struct kmod_ctx *ctx, struct kmod_list **list)
-{
-	struct kmod_builtin_iter *iter;
-	int err = 0;
-
-	iter = kmod_builtin_iter_new(ctx);
-	if (!iter)
-		return -errno;
-
-	while (kmod_builtin_iter_next(iter)) {
-		struct kmod_module *mod = NULL;
-		char modname[PATH_MAX];
-
-		if (!kmod_builtin_iter_get_modname(iter, modname)) {
-			err = -errno;
-			goto fail;
-		}
-
-		err = kmod_module_new_from_name(ctx, modname, &mod);
-		if (err < 0)
-			goto fail;
-
-		kmod_module_set_builtin(mod, true);
-
-		*list = kmod_list_append(*list, mod);
-	}
-
-	kmod_builtin_iter_free(iter);
-	return err;
-fail:
-	kmod_builtin_iter_free(iter);
-	kmod_module_unref_list(*list);
-	*list = NULL;
-	return err;
-}
-- 
2.39.2

