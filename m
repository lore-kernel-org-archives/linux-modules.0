Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26253C77B7A
	for <linux-modules@archiver.kernel.org>; Thu,  1 Jun 2023 22:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjFAWkW (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 1 Jun 2023 18:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjFAWkV (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 1 Jun 2023 18:40:21 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9DB12C
        for <linux-modules@vger.kernel.org>; Thu,  1 Jun 2023 15:40:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-973f78329e3so204873866b.3
        for <linux-modules@vger.kernel.org>; Thu, 01 Jun 2023 15:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685659215; x=1688251215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLlr9LTWmO1Di1JRcm2H6urym/NeH+WNeVsxjTLNg78=;
        b=F/Hw8KuWB5O0KDJ5XzZadsGr1LGXTvKpkdaykjNmQzgqQIKhLFmj43lBEexDwYp2vY
         an0QqcQGumGHO2qsXbObViw/2R4KriBRq/IqiennTMNnfTb2OS8ZLmOrvgcqSEHOLSoF
         d16f1YeKkTvB6/7VZxsXhFXM/XFt3xVvLWMbhxkB7YW3fqJo8qwtXp8OhTQrLMof2zWr
         Vn1nRWI9eNOYbpqJI7+kQUIQPT18OWRBSmpJK8nrbjfHqV5QolvrYS9GD6FSJ+SCtjI8
         dKulVIg7bE6pFSWWF8rodpjMt9vLmpep47pjczQ9AhCVkYa/6NzeeSsfiYQOqsLH3YDS
         VATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685659215; x=1688251215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLlr9LTWmO1Di1JRcm2H6urym/NeH+WNeVsxjTLNg78=;
        b=ICso9XFZOBAD8dU22NhMAJwdEO5gVG2E5D7zlBjuQQBUasj6j97rD4vDk+I7pBIKYU
         VpqHKQHegHgRKuru0Rh3oLbktTBNUIa2ZgXvA2OI9gdEtRVi4YKE2ob4qxgPXr9Ga83h
         armbU2W2aJbkR45ST8VpncAf/+tbPhYgAZIAR+EI3VdvymBthr+R6TSyedBeoMuTvCd+
         e0k7SKCRvbABzSlpvnAaB1+RosutsisgzjxcaGyH9Jp/5GXr+u91UDlcIlrXffTg4boh
         pLl1Uy4KGEBb9Tibm60ubzxp4RGcg7RVJgx4JdkivUR75Wq+wjQEiOPADO/MGT+h1J0A
         VJxA==
X-Gm-Message-State: AC+VfDyig5Eog/mcu35WuGuIuafC5qcyFC9XBsj4dJo6cteukz5eYK/9
        fA7o7BmLjhRy8iPbVRapp8ZGpK+6Pjc=
X-Google-Smtp-Source: ACHHUZ60l04wZxKjXHYCE9QTwVX4fQuB4h4YI1DOhvoiPexyocOn04mzYyQ3i9gTzO2aNkM0Yv/4IQ==
X-Received: by 2002:a17:907:a09:b0:974:5480:171e with SMTP id bb9-20020a1709070a0900b009745480171emr1366067ejc.32.1685659215391;
        Thu, 01 Jun 2023 15:40:15 -0700 (PDT)
Received: from ldmartin-desk2.jf.intel.com ([134.134.137.83])
        by smtp.gmail.com with ESMTPSA id se24-20020a170906ce5800b009662b4230cesm11253318ejb.148.2023.06.01.15.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 15:40:14 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 2/5] libkmod: Extract finit_module vs init_module paths
Date:   Thu,  1 Jun 2023 15:39:58 -0700
Message-Id: <20230601224001.23397-3-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601224001.23397-1-lucas.de.marchi@gmail.com>
References: <20230601224001.23397-1-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Extract 2 functions to handle finit_module vs init_modules differences,
with a fallback from the former to the latter.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 libkmod/libkmod-module.c | 120 ++++++++++++++++++++++++---------------
 1 file changed, 73 insertions(+), 47 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index f352fe1..6ed5ad4 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -861,6 +861,73 @@ KMOD_EXPORT int kmod_module_remove_module(struct kmod_module *mod,
 
 extern long init_module(const void *mem, unsigned long len, const char *args);
 
+static int do_finit_module(struct kmod_module *mod, unsigned int flags,
+			   const char *args)
+{
+	unsigned int kernel_flags = 0;
+	int err;
+
+	/*
+	 * Re-use ENOSYS, returned when there is no such syscall, so the
+	 * fallback to init_module applies
+	 */
+	if (!kmod_file_get_direct(mod->file))
+		return -ENOSYS;
+
+	if (flags & KMOD_INSERT_FORCE_VERMAGIC)
+		kernel_flags |= MODULE_INIT_IGNORE_VERMAGIC;
+	if (flags & KMOD_INSERT_FORCE_MODVERSION)
+		kernel_flags |= MODULE_INIT_IGNORE_MODVERSIONS;
+
+	err = finit_module(kmod_file_get_fd(mod->file), args, kernel_flags);
+	if (err < 0)
+		err = -errno;
+
+	return err;
+}
+
+static int do_init_module(struct kmod_module *mod, unsigned int flags,
+			  const char *args)
+{
+	struct kmod_elf *elf;
+	const void *mem;
+	off_t size;
+	int err;
+
+	kmod_file_load_contents(mod->file);
+
+	if (flags & (KMOD_INSERT_FORCE_VERMAGIC | KMOD_INSERT_FORCE_MODVERSION)) {
+		elf = kmod_file_get_elf(mod->file);
+		if (elf == NULL) {
+			err = -errno;
+			return err;
+		}
+
+		if (flags & KMOD_INSERT_FORCE_MODVERSION) {
+			err = kmod_elf_strip_section(elf, "__versions");
+			if (err < 0)
+				INFO(mod->ctx, "Failed to strip modversion: %s\n", strerror(-err));
+		}
+
+		if (flags & KMOD_INSERT_FORCE_VERMAGIC) {
+			err = kmod_elf_strip_vermagic(elf);
+			if (err < 0)
+				INFO(mod->ctx, "Failed to strip vermagic: %s\n", strerror(-err));
+		}
+
+		mem = kmod_elf_get_memory(elf);
+	} else {
+		mem = kmod_file_get_contents(mod->file);
+	}
+	size = kmod_file_get_size(mod->file);
+
+	err = init_module(mem, size, args);
+	if (err < 0)
+		err = -errno;
+
+	return err;
+}
+
 /**
  * kmod_module_insert_module:
  * @mod: kmod module
@@ -881,9 +948,6 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
 							const char *options)
 {
 	int err;
-	const void *mem;
-	off_t size;
-	struct kmod_elf *elf;
 	const char *path;
 	const char *args = options ? options : "";
 
@@ -904,52 +968,14 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
 		}
 	}
 
-	if (kmod_file_get_direct(mod->file)) {
-		unsigned int kernel_flags = 0;
-
-		if (flags & KMOD_INSERT_FORCE_VERMAGIC)
-			kernel_flags |= MODULE_INIT_IGNORE_VERMAGIC;
-		if (flags & KMOD_INSERT_FORCE_MODVERSION)
-			kernel_flags |= MODULE_INIT_IGNORE_MODVERSIONS;
-
-		err = finit_module(kmod_file_get_fd(mod->file), args, kernel_flags);
-		if (err == 0 || errno != ENOSYS)
-			goto init_finished;
-	}
-
-	kmod_file_load_contents(mod->file);
-
-	if (flags & (KMOD_INSERT_FORCE_VERMAGIC | KMOD_INSERT_FORCE_MODVERSION)) {
-		elf = kmod_file_get_elf(mod->file);
-		if (elf == NULL) {
-			err = -errno;
-			return err;
-		}
+	err = do_finit_module(mod, flags, args);
+	if (err == -ENOSYS)
+		err = do_init_module(mod, flags, args);
 
-		if (flags & KMOD_INSERT_FORCE_MODVERSION) {
-			err = kmod_elf_strip_section(elf, "__versions");
-			if (err < 0)
-				INFO(mod->ctx, "Failed to strip modversion: %s\n", strerror(-err));
-		}
-
-		if (flags & KMOD_INSERT_FORCE_VERMAGIC) {
-			err = kmod_elf_strip_vermagic(elf);
-			if (err < 0)
-				INFO(mod->ctx, "Failed to strip vermagic: %s\n", strerror(-err));
-		}
-
-		mem = kmod_elf_get_memory(elf);
-	} else {
-		mem = kmod_file_get_contents(mod->file);
-	}
-	size = kmod_file_get_size(mod->file);
+	if (err < 0)
+		INFO(mod->ctx, "Failed to insert module '%s': %s\n",
+		     path, strerror(-err));
 
-	err = init_module(mem, size, args);
-init_finished:
-	if (err < 0) {
-		err = -errno;
-		INFO(mod->ctx, "Failed to insert module '%s': %m\n", path);
-	}
 	return err;
 }
 
-- 
2.40.1

