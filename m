Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3EFC64EC4
	for <linux-modules@archiver.kernel.org>; Tue, 21 Feb 2023 13:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjBUNTh (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 21 Feb 2023 08:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjBUNTg (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 21 Feb 2023 08:19:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43314690
        for <linux-modules@vger.kernel.org>; Tue, 21 Feb 2023 05:19:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l2-20020a05600c1d0200b003e1f6dff952so3511772wms.1
        for <linux-modules@vger.kernel.org>; Tue, 21 Feb 2023 05:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckoGnYi/g9fzY1+nZePCJNaLc7j6vS+121w8xKnkYZ0=;
        b=Sv2IZm1JwLnk4PJT5FB5nBThj++2o37H5ZqAeRYtQcRmyzONQqm/nPQrPr26lgbedp
         B3o/YTmebfH7Gy9tQH2e8N2Ex1pCu/jvrzuFCN1ZzON49Y/YKYL18JWPxqB65Ky9wc9B
         2xkE+lk5ea4dU0MfRUgWFxRNW0Go54g/wgpocCoWEj/djUf4dbG0llgOawgNiSQUAPiN
         h6lRkMqjeThPgSxui0XVzTq+O2B2a2eIhGyG1kRytuS6JlglyKLxTWpBPwxDdUT0ofbx
         zsAMpWiPANhcmYIQvaXLeTywoeYkBna1QTPDvnRQ21QSvgpfPMdl+zIuAoFOaQZXaniS
         DSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckoGnYi/g9fzY1+nZePCJNaLc7j6vS+121w8xKnkYZ0=;
        b=gb3hs2Bl7jaQDWXQYd+oofpjDv9t9VD/xBD7M7d58zDrXiRhGiWnJt8SDiqvhPFVZV
         qkeZPuRg/1Afmmgq/GC4PP4UqsIBz4XuT96/ibZ9HSl5yoG7tLMmX74v56XBherfSSu1
         uzj4A/jxmFBU3ZEed9ANWAVUwZZftle7vMnFR4oP1iPDdoLPlzDg7x/kBuzVuEgYKRTa
         ouwS4DPsD4wdCgnraY8hRiCt32bfEuVxN6RDemKiewwDjrib8UNH0npLlNUCYPTEoWFx
         4lK3abZZBcMLx49f6LPVbKmkyyDZ9S2cvOnaciAXEtujI4dO86cEsP/GS+yc7l13K6SD
         L84A==
X-Gm-Message-State: AO0yUKU4oIfQZ+jxZodC0VT4eMrvCdQTHuWjbwslwCHtXi7qoo2pVpN2
        XGPJDoMe6q+Bv2XbBTlmAEEJm7ftiDY=
X-Google-Smtp-Source: AK7set/vVTl7IrdVVNyd9no9gUytwxUMVo4fIc7Us1lxxa1iR79FldzXF6Ih1F8IWKXTa16aeiaN9g==
X-Received: by 2002:a05:600c:331b:b0:3dc:4318:d00d with SMTP id q27-20020a05600c331b00b003dc4318d00dmr3086528wmp.11.1676985573834;
        Tue, 21 Feb 2023 05:19:33 -0800 (PST)
Received: from localhost (cpc92308-cmbg19-2-0-cust99.5-4.cable.virginm.net. [82.24.248.100])
        by smtp.gmail.com with UTF8SMTPSA id o17-20020a05600c379100b003e70a7c1b73sm3015097wmr.16.2023.02.21.05.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 05:19:33 -0800 (PST)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     emil.l.velikov@gmail.com
Subject: [PATCH 2/4] libkmod: annotate kmod_builtin_iter API as static
Date:   Tue, 21 Feb 2023 13:19:27 +0000
Message-Id: <20230221131929.106951-3-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221131929.106951-1-emil.l.velikov@gmail.com>
References: <20230221131929.106951-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Emil Velikov <emil.velikov@collabora.com>

It's no longer used outside the compilation unit, as of last commit.

Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
---
 libkmod/libkmod-builtin.c  | 8 ++++----
 libkmod/libkmod-internal.h | 5 -----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/libkmod/libkmod-builtin.c b/libkmod/libkmod-builtin.c
index a002cb5..65334a8 100644
--- a/libkmod/libkmod-builtin.c
+++ b/libkmod/libkmod-builtin.c
@@ -54,7 +54,7 @@ struct kmod_builtin_iter {
 	char *buf;
 };
 
-struct kmod_builtin_iter *kmod_builtin_iter_new(struct kmod_ctx *ctx)
+static struct kmod_builtin_iter *kmod_builtin_iter_new(struct kmod_ctx *ctx)
 {
 	char path[PATH_MAX];
 	int file, sv_errno;
@@ -108,7 +108,7 @@ fail:
 	return iter;
 }
 
-void kmod_builtin_iter_free(struct kmod_builtin_iter *iter)
+static void kmod_builtin_iter_free(struct kmod_builtin_iter *iter)
 {
 	close(iter->file);
 	free(iter->buf);
@@ -165,7 +165,7 @@ fail:
 	return -1;
 }
 
-bool kmod_builtin_iter_next(struct kmod_builtin_iter *iter)
+static bool kmod_builtin_iter_next(struct kmod_builtin_iter *iter)
 {
 	char *line,  *modname;
 	size_t linesz;
@@ -216,7 +216,7 @@ bool kmod_builtin_iter_next(struct kmod_builtin_iter *iter)
 	return (iter->pos < iter->size);
 }
 
-bool kmod_builtin_iter_get_modname(struct kmod_builtin_iter *iter,
+static bool kmod_builtin_iter_get_modname(struct kmod_builtin_iter *iter,
 				char modname[static PATH_MAX])
 {
 	int sv_errno;
diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 95c0377..4a4af58 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -198,9 +198,4 @@ bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signat
 void kmod_module_signature_info_free(struct kmod_signature_info *sig_info) __attribute__((nonnull));
 
 /* libkmod-builtin.c */
-struct kmod_builtin_iter;
-struct kmod_builtin_iter *kmod_builtin_iter_new(struct kmod_ctx *ctx) __attribute__((nonnull(1)));
-void kmod_builtin_iter_free(struct kmod_builtin_iter *iter) __attribute__((nonnull(1)));
-bool kmod_builtin_iter_next(struct kmod_builtin_iter *iter) __attribute__((nonnull(1)));
-bool kmod_builtin_iter_get_modname(struct kmod_builtin_iter *iter, char modname[static PATH_MAX]) __attribute__((nonnull(1, 2)));
 ssize_t kmod_builtin_get_modinfo(struct kmod_ctx *ctx, const char *modname, char ***modinfo) __attribute__((nonnull(1, 2, 3)));
-- 
2.39.2

