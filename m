Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E2DC7EE29
	for <linux-modules@archiver.kernel.org>; Thu,  1 Jun 2023 22:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjFAWkT (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 1 Jun 2023 18:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFAWkR (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 1 Jun 2023 18:40:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC91136
        for <linux-modules@vger.kernel.org>; Thu,  1 Jun 2023 15:40:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so2092881a12.0
        for <linux-modules@vger.kernel.org>; Thu, 01 Jun 2023 15:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685659213; x=1688251213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnDwmBmVGYJiv8QjZrAsENAi8v+nWukYeqS6LJo5B0Y=;
        b=djAC3hjC2JMZEPYypExL5z1iQGdUysPbxsBt6+AcNIk39cmwaENgD8sdpnX9IrJt8M
         LnufqxaaPLgJfd2PXB13MioQEmyw6yTUm4OCqyKUohTb5u7aQvt7+phXYwrh5/CfibQn
         9LwPN/H7LLP7HnrtgR0hsLZdhRP4wQIW+L5k171DaUzgv6MQI+w0jpr8GXUsnXOHR5aS
         7UvHZ6U9fZfoEd7WEI5ivlOcLDyWCrlMibQjbs4dcg14pOGR1bmGv3GjE9FE70G+ph3M
         e4bzZ6UpyeJZn7QlQitcq9Pl7C3Jv+FhEuOCNZ6YoRFBwNyqwLx9HyF6WTwSU3Wzz57/
         quqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685659213; x=1688251213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnDwmBmVGYJiv8QjZrAsENAi8v+nWukYeqS6LJo5B0Y=;
        b=GW/LLuHxQFw4ugRLROnKNdtyRJIPHT5NrOAg8R9f9eArIDagP4pKJDFAVMqgq4r/yU
         SSt1YaAflo4QrcbixEev9jkrCgHxvU77f2O4KVWB8t0Co7oyTvH1m8NX59D5uCxjxnvT
         o1SUVoOBRoBtyvO5en2XeixFvlOylKohWxGr9XDkHPbqd0KcR0wKln5SyonwnQ0v3H4r
         Yoz5E7pL5pTp/8nC+UpsFbjPVTxEIsmOap6phf1uQFRQgCC5xw5hbGLXKItRQvBDrgrv
         AOOauPZMJnAOt/DK8bGAi1PYxMrq+yySpQ2mnaC1mjOAeAyorwPUct81eD1zAE1of6zw
         /zoQ==
X-Gm-Message-State: AC+VfDxb/PHF0nLs7lv8/6u7hNFCwmdf94y1lIpPOAnkLRCa90fj06CV
        um50CxZu1u9mPv1yQzivfAGccTEgAxA=
X-Google-Smtp-Source: ACHHUZ7k2uiGKmbQOul1olNoNh+bQcDmkV9TvnxlFsW7CDG+bA42eyQLbrQFIk37GptglxM8HpuE7A==
X-Received: by 2002:a17:907:9343:b0:96f:afe9:25c4 with SMTP id bv3-20020a170907934300b0096fafe925c4mr8676255ejc.50.1685659213025;
        Thu, 01 Jun 2023 15:40:13 -0700 (PDT)
Received: from ldmartin-desk2.jf.intel.com ([134.134.137.83])
        by smtp.gmail.com with ESMTPSA id se24-20020a170906ce5800b009662b4230cesm11253318ejb.148.2023.06.01.15.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 15:40:12 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 1/5] libkmod: Do not inititialize file->memory on open
Date:   Thu,  1 Jun 2023 15:39:57 -0700
Message-Id: <20230601224001.23397-2-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601224001.23397-1-lucas.de.marchi@gmail.com>
References: <20230601224001.23397-1-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Add a separate function to load the file contents when it's needed.
When it's not needed on the path of loading modules via finit_module(),
there is no need to mmap the file. This will help support loading
modules with the in-kernel compression support.

This is done differently than the lazy initialization for
kmod_file_get_elf() because on the contents case there is also the
file->size to be updated. It would be a weird API to return the pointer
and have the size changed as a side-effect.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 libkmod/libkmod-elf.c      |  5 +++++
 libkmod/libkmod-file.c     | 17 ++++++++++++++---
 libkmod/libkmod-internal.h |  3 ++-
 libkmod/libkmod-module.c   |  2 ++
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/libkmod/libkmod-elf.c b/libkmod/libkmod-elf.c
index fb2e3d9..933825b 100644
--- a/libkmod/libkmod-elf.c
+++ b/libkmod/libkmod-elf.c
@@ -281,6 +281,11 @@ struct kmod_elf *kmod_elf_new(const void *memory, off_t size)
 	assert_cc(sizeof(uint32_t) == sizeof(Elf32_Word));
 	assert_cc(sizeof(uint32_t) == sizeof(Elf64_Word));
 
+	if (!memory) {
+		errno = -EINVAL;
+		return NULL;
+	}
+
 	class = elf_identify(memory, size);
 	if (class < 0) {
 		errno = -class;
diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index b6a8cc9..1449c41 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -421,6 +421,7 @@ struct kmod_elf *kmod_file_get_elf(struct kmod_file *file)
 	if (file->elf)
 		return file->elf;
 
+	kmod_file_load_contents(file);
 	file->elf = kmod_elf_new(file->memory, file->size);
 	return file->elf;
 }
@@ -431,7 +432,7 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
 	struct kmod_file *file = calloc(1, sizeof(struct kmod_file));
 	const struct comp_type *itr;
 	size_t magic_size_max = 0;
-	int err;
+	int err = 0;
 
 	if (file == NULL)
 		return NULL;
@@ -477,8 +478,8 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
 	if (file->ops == NULL)
 		file->ops = &reg_ops;
 
-	err = file->ops->load(file);
 	file->ctx = ctx;
+
 error:
 	if (err < 0) {
 		if (file->fd >= 0)
@@ -491,6 +492,14 @@ error:
 	return file;
 }
 
+int kmod_file_load_contents(struct kmod_file *file)
+{
+	if (file->memory)
+		return 0;
+
+	return file->ops->load(file);
+}
+
 void *kmod_file_get_contents(const struct kmod_file *file)
 {
 	return file->memory;
@@ -516,7 +525,9 @@ void kmod_file_unref(struct kmod_file *file)
 	if (file->elf)
 		kmod_elf_unref(file->elf);
 
-	file->ops->unload(file);
+	if (file->memory)
+		file->ops->unload(file);
+
 	if (file->fd >= 0)
 		close(file->fd);
 	free(file);
diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 4a4af58..4799ed5 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -152,6 +152,7 @@ bool kmod_module_is_builtin(struct kmod_module *mod) __attribute__((nonnull(1)))
 /* libkmod-file.c */
 struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx, const char *filename) _must_check_ __attribute__((nonnull(1,2)));
 struct kmod_elf *kmod_file_get_elf(struct kmod_file *file) __attribute__((nonnull(1)));
+int kmod_file_load_contents(struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
 void *kmod_file_get_contents(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
 off_t kmod_file_get_size(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
 bool kmod_file_get_direct(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
@@ -166,7 +167,7 @@ struct kmod_modversion {
 	char *symbol;
 };
 
-struct kmod_elf *kmod_elf_new(const void *memory, off_t size) _must_check_ __attribute__((nonnull(1)));
+struct kmod_elf *kmod_elf_new(const void *memory, off_t size) _must_check_;
 void kmod_elf_unref(struct kmod_elf *elf) __attribute__((nonnull(1)));
 const void *kmod_elf_get_memory(const struct kmod_elf *elf) _must_check_ __attribute__((nonnull(1)));
 int kmod_elf_get_strings(const struct kmod_elf *elf, const char *section, char ***array) _must_check_ __attribute__((nonnull(1,2,3)));
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 7736b7e..f352fe1 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -917,6 +917,8 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
 			goto init_finished;
 	}
 
+	kmod_file_load_contents(mod->file);
+
 	if (flags & (KMOD_INSERT_FORCE_VERMAGIC | KMOD_INSERT_FORCE_MODVERSION)) {
 		elf = kmod_file_get_elf(mod->file);
 		if (elf == NULL) {
-- 
2.40.1

