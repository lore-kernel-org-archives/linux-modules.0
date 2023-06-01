Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E61C77B7A
	for <linux-modules@archiver.kernel.org>; Thu,  1 Jun 2023 22:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjFAWk1 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 1 Jun 2023 18:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjFAWk0 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 1 Jun 2023 18:40:26 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8504712C
        for <linux-modules@vger.kernel.org>; Thu,  1 Jun 2023 15:40:24 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b1a6a8e851so12853341fa.2
        for <linux-modules@vger.kernel.org>; Thu, 01 Jun 2023 15:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685659222; x=1688251222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBkV9oYQPFu7USkDL/ITikjBCLxq5r+G6YZDTAlhVT8=;
        b=Bg4Gnw+kQbHtCTcaxAuNG/+ek6ULfWBV/ClnH3srOBd8BpEewrwJpuGC5I9m8zEXl8
         R725RSkr9ip+pZ6ja/LYABZECdqOML8CGJhd7LeMo88O/TEcl1kqLjAcBIgWfbdFA38X
         1FlsvzV4iiRWXTx7sQDQrMnfTCtNFMzilS9lKRk9ut+sRogRwA1GzF+w8Hm7zzkYCgft
         COSJswxh4Xxtss2eS776AGvDSzA2zMqEfC6FqCZRMJLnzTmofFAXu69ZPJFRu6e+5C/m
         QU0DGLpa/Gyxq6HNk97Kr9eg5bvjXi9H8wllT75RACgbTsJHXP7esCTlmGiyslvwp4Vi
         fRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685659222; x=1688251222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBkV9oYQPFu7USkDL/ITikjBCLxq5r+G6YZDTAlhVT8=;
        b=EqP/Cax+1QiOXvHqVBI3uX1dZSu85bgFmDOKJTu0ESnrNeHSGxgMfpEaxbizUr1PPK
         D5CfLtCtoyZNWiHmLNmEgjYDY8mTiO2UkJGlv35kGrz3yY+JEIA4r2NwQUJ2/zjUU+4y
         L2nLPhlYZaRpYKcu3IEOFMh1rnQrTCorZKV/fjJ883pYSjmxsVBFXfuQWBfqd8/Izkz8
         yp2xq/bVbtOSOsJ+2CYX5MzVqjwvOG/NP7FAGMN79XsqfafFYd2GLSYRMEvgTAgUFgiZ
         sUACLAch0tZ3VudkSPY6EVHRMtaeYtuw+2Ml2PJjalRJB0ibuGVGa4ID8iDDwlhGHJ78
         8KEg==
X-Gm-Message-State: AC+VfDwfNccsvK3NObQjX4qyemqAs8dd+AmJnuxNd+6Xe7cbOKF/pBzy
        RIi1zglw2NGcEwS19j8YQ54cJWhtpns=
X-Google-Smtp-Source: ACHHUZ42clg0PX/wg5XsVCyhnnRJdeEPVVfMu912kcjAE4zF9wqcmXEeO51Xosh3iN2aGe76tLPYQw==
X-Received: by 2002:a2e:9c8b:0:b0:2ad:90c8:7fa3 with SMTP id x11-20020a2e9c8b000000b002ad90c87fa3mr540251lji.29.1685659221698;
        Thu, 01 Jun 2023 15:40:21 -0700 (PDT)
Received: from ldmartin-desk2.jf.intel.com ([134.134.137.83])
        by smtp.gmail.com with ESMTPSA id se24-20020a170906ce5800b009662b4230cesm11253318ejb.148.2023.06.01.15.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 15:40:20 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 5/5] libkmod: Use kernel decompression when available
Date:   Thu,  1 Jun 2023 15:40:01 -0700
Message-Id: <20230601224001.23397-6-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601224001.23397-1-lucas.de.marchi@gmail.com>
References: <20230601224001.23397-1-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

With the recent changes to bypass loading the file it's possible to
reduce the work in userspace and delegating it to the kernel. Without
any compression to illustrate:

Before:
	read(3, "\177ELF\2\1", 6)               = 6
	lseek(3, 0, SEEK_SET)                   = 0
	newfstatat(3, "", {st_mode=S_IFREG|0644, st_size=238592, ...}, AT_EMPTY_PATH) = 0
	mmap(NULL, 238592, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fd85cbd1000
	finit_module(3, "", 0)                  = 0
	munmap(0x7fd85cbd1000, 238592)          = 0
	close(3)                                = 0

After:
	read(3, "\177ELF\2\1", 6)               = 6
	lseek(3, 0, SEEK_SET)                   = 0
	finit_module(3, "", 0)                  = 0
	close(3)                                = 0

When using kernel compression now it's also possible to direct libkmod
to take the finit_module() path, avoiding the decompression in userspace
and just delegating it to the kernel.

Before:
	read(3, "(\265/\375\244\0", 6)          = 6
	lseek(3, 0, SEEK_SET)                   = 0
	read(3, "(\265/\375\244", 5)            = 5
	mmap(NULL, 135168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f3fa431e000
	read(3, "\0\244\3\0\\y\6", 7)           = 7
	mmap(NULL, 372736, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f3fa414f000
	brk(0x55944c6a1000)                     = 0x55944c6a1000
	read(3, "\356|\6G\27U\20 \312\260s\211\335\333\263\326\330\336\273O\211\356\306K\360Z\341\374U6\342\221"..., 53038) = 53038
	mremap(0x7f3fa431e000, 135168, 266240, MREMAP_MAYMOVE) = 0x7f3fa410e000
	read(3, ",;\3\nqf\311\362\325\211\7\341\375A\355\221\371L\\\5\7\375 \32\246<(\258=K\304"..., 20851) = 20851
	mremap(0x7f3fa410e000, 266240, 397312, MREMAP_MAYMOVE) = 0x7f3fa40ad000
	read(3, ")\36\250\213", 4)              = 4
	read(3, "", 4)                          = 0
	munmap(0x7f3fa414f000, 372736)          = 0
	init_module(0x7f3fa40ad010, 238592, "") = 0
	munmap(0x7f3fa40ad000, 397312)          = 0
	close(3)                                = 0

After:
	read(3, "(\265/\375\244P", 6)           = 6
	lseek(3, 0, SEEK_SET)                   = 0
	finit_module(3, "", 0x4 /* MODULE_INIT_??? */) = 0
	close(3)                                = 0

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 libkmod/libkmod-file.c     |  4 ++--
 libkmod/libkmod-internal.h |  3 ++-
 libkmod/libkmod-module.c   | 17 +++++++++++++----
 libkmod/libkmod.c          |  5 +++++
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index 705770a..ffdda92 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -513,9 +513,9 @@ off_t kmod_file_get_size(const struct kmod_file *file)
 	return file->size;
 }
 
-bool kmod_file_get_direct(const struct kmod_file *file)
+enum kmod_file_compression_type kmod_file_get_compression(const struct kmod_file *file)
 {
-	return file->compression == KMOD_FILE_COMPRESSION_NONE;
+	return file->compression;
 }
 
 int kmod_file_get_fd(const struct kmod_file *file)
diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 7b8a158..edb4eac 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -112,6 +112,7 @@ void kmod_pool_add_module(struct kmod_ctx *ctx, struct kmod_module *mod, const c
 void kmod_pool_del_module(struct kmod_ctx *ctx, struct kmod_module *mod, const char *key) __attribute__((nonnull(1, 2, 3)));
 
 const struct kmod_config *kmod_get_config(const struct kmod_ctx *ctx) __attribute__((nonnull(1)));
+enum kmod_file_compression_type kmod_get_kernel_compression(const struct kmod_ctx *ctx) __attribute__((nonnull(1)));
 
 /* libkmod-config.c */
 struct kmod_config_path {
@@ -162,7 +163,7 @@ struct kmod_elf *kmod_file_get_elf(struct kmod_file *file) __attribute__((nonnul
 int kmod_file_load_contents(struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
 void *kmod_file_get_contents(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
 off_t kmod_file_get_size(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
-bool kmod_file_get_direct(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
+enum kmod_file_compression_type kmod_file_get_compression(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
 int kmod_file_get_fd(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
 void kmod_file_unref(struct kmod_file *file) __attribute__((nonnull(1)));
 
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 6ed5ad4..a9e1be8 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -864,15 +864,24 @@ extern long init_module(const void *mem, unsigned long len, const char *args);
 static int do_finit_module(struct kmod_module *mod, unsigned int flags,
 			   const char *args)
 {
+	enum kmod_file_compression_type compression, kernel_compression;
 	unsigned int kernel_flags = 0;
 	int err;
 
 	/*
-	 * Re-use ENOSYS, returned when there is no such syscall, so the
-	 * fallback to init_module applies
+	 * When module is not compressed or its compression type matches the
+	 * one in use by the kernel, there is no need to read the file
+	 * in userspace. Otherwise, re-use ENOSYS to trigger the same fallback
+	 * as when finit_module() is not supported.
 	 */
-	if (!kmod_file_get_direct(mod->file))
-		return -ENOSYS;
+	compression = kmod_file_get_compression(mod->file);
+	kernel_compression = kmod_get_kernel_compression(mod->ctx);
+	if (!(compression == KMOD_FILE_COMPRESSION_NONE ||
+	      compression == kernel_compression))
+		return ENOSYS;
+
+	if (compression != KMOD_FILE_COMPRESSION_NONE)
+		kernel_flags |= MODULE_INIT_COMPRESSED_FILE;
 
 	if (flags & KMOD_INSERT_FORCE_VERMAGIC)
 		kernel_flags |= MODULE_INIT_IGNORE_VERMAGIC;
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 103469e..1b8773c 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -1016,3 +1016,8 @@ const struct kmod_config *kmod_get_config(const struct kmod_ctx *ctx)
 {
 	return ctx->config;
 }
+
+enum kmod_file_compression_type kmod_get_kernel_compression(const struct kmod_ctx *ctx)
+{
+	return ctx->kernel_compression;
+}
-- 
2.40.1

