Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17313EB64D7
	for <linux-modules@archiver.kernel.org>; Fri, 16 Jun 2023 05:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjFPFA6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 16 Jun 2023 01:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjFPFA5 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 16 Jun 2023 01:00:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936F7269E
        for <linux-modules@vger.kernel.org>; Thu, 15 Jun 2023 22:00:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-985fd30ef48so37316466b.2
        for <linux-modules@vger.kernel.org>; Thu, 15 Jun 2023 22:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686891653; x=1689483653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=66BSL47igSv/IkKHYpP/ijg+JNanI4XVHW+EPNMIuYo=;
        b=YfvOFqJuAeW1Srn9ngJqKjxYeKBcVvEFc3QN0gAFROLPk+fpfhykCnuYIeYHQZ2fJ8
         H9IiNokT8BqDiyPkiBTvttSNkEXdQWrM3XvoCZ/+wXJlhTMY7wECwfQRGC0mKiTSP5e+
         aHwNCmFFswgj8j/a0XNRvYFCwL6paNMCB4OntTxGEzggKYYzA9t97R6lavfjcb+ENyFo
         3LgD5gQat19r6RpdE4/txpy1y12TMX0iW/A2sDvrvujIjGOaws2nH45LZ45n15A15WeW
         OAf/6wopmzwWwj3kfea53CiO+o83M9xB/N35DhA0il9Bgp/lUGa2yGnlvEgR91CcmtJn
         rNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686891653; x=1689483653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66BSL47igSv/IkKHYpP/ijg+JNanI4XVHW+EPNMIuYo=;
        b=SWGmpStpr9SSoinXi2WETvmobTUxwfbxttgNOe2NhQ9WxuZTRj3B/DL1Dwt8AxR/gV
         zEQCzebkFuIpmTsZWfUm2DM+rT1OsET36SHAqI2bv6Jc6BcG1LzTELKL3w84jRK72MqA
         Qb4MqjCmLSmdbJpE2fT4JDQUmTtKwnv9Lkqq8g5SmIwidKZahx+pmq4cb7o/yume4rM4
         FWx3A7t/tWp7w/nZmo8e2BtUjpkUwL+kgy+qtDSmI6kqbjyTHMa4YbyF6/9y+H3jAWK7
         jeI7jQ5OfeFGdSNYGgAnr9WrTk1rn5/UiXDfUQ1PVyOqHYKfZG2KSINdhFAvhA1fT9dr
         JMPQ==
X-Gm-Message-State: AC+VfDznjGPRcNmrpYI79xgmGNqCVZQWOmQ6RJp/UZevU1sUnkxSWb7y
        yfJRABsUckFmZsmaZQYDcvFZEYA5UEE=
X-Google-Smtp-Source: ACHHUZ4TqUaBMrY71WoPyr2Z9igi570MsBjTXYZgteNViY1va2yjAcdgoPLuvIP512kc0zHFKkSOaA==
X-Received: by 2002:a17:907:3d8e:b0:982:3ee4:7062 with SMTP id he14-20020a1709073d8e00b009823ee47062mr881772ejc.57.1686891652914;
        Thu, 15 Jun 2023 22:00:52 -0700 (PDT)
Received: from ldmartin-desk2.lan ([134.134.137.82])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906494d00b0097461fecc91sm10159337ejt.81.2023.06.15.22.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 22:00:51 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH v2] libkmod: Do not inititialize file->memory on open
Date:   Thu, 15 Jun 2023 22:00:41 -0700
Message-Id: <20230616050041.99712-1-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.40.1
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

v2: change kmod_file_load_contents() to void since the return is
    actually checked on the file struct

 libkmod/libkmod-elf.c      |  5 +++++
 libkmod/libkmod-file.c     | 21 ++++++++++++++++++---
 libkmod/libkmod-internal.h |  3 ++-
 libkmod/libkmod-module.c   |  2 ++
 4 files changed, 27 insertions(+), 4 deletions(-)

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
index b6a8cc9..08adea9 100644
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
@@ -491,6 +492,18 @@ error:
 	return file;
 }
 
+/*
+ *  Callers should just check file->memory got updated
+ */
+void kmod_file_load_contents(struct kmod_file *file)
+{
+	if (file->memory)
+		return;
+
+	/*  The load functions already log possible errors. */
+	file->ops->load(file);
+}
+
 void *kmod_file_get_contents(const struct kmod_file *file)
 {
 	return file->memory;
@@ -516,7 +529,9 @@ void kmod_file_unref(struct kmod_file *file)
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
index 4a4af58..3275bc5 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -152,6 +152,7 @@ bool kmod_module_is_builtin(struct kmod_module *mod) __attribute__((nonnull(1)))
 /* libkmod-file.c */
 struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx, const char *filename) _must_check_ __attribute__((nonnull(1,2)));
 struct kmod_elf *kmod_file_get_elf(struct kmod_file *file) __attribute__((nonnull(1)));
+void kmod_file_load_contents(struct kmod_file *file) __attribute__((nonnull(1)));
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

