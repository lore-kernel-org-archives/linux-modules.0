Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718F1C433F5
	for <linux-modules@archiver.kernel.org>; Fri, 10 Dec 2021 05:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhLJFqy (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 10 Dec 2021 00:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhLJFqx (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 10 Dec 2021 00:46:53 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FDFC061746
        for <linux-modules@vger.kernel.org>; Thu,  9 Dec 2021 21:43:19 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u17so5543404plg.9
        for <linux-modules@vger.kernel.org>; Thu, 09 Dec 2021 21:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ip4yb2a7jW8J2+ncn/GoeHa7yECpYrU+u7C3oc55Chg=;
        b=Zk5tNsP4USy7fPQLGTOJHs5llFEvZysci57JgfYLXLebl+sdFQ25W0aKtQz7YW8jhV
         8ySWMGSatD8krAXnOa92KvnnnK0k/c9naXKz2/vBhJlFvao5MUtooDBNNvviXXeOWEfI
         jrYtmkij//e2452LOjnmogIrgwoKoKTvdrZI/M+W/F8BnLZc01noA3gH2ABXbx2GGr6C
         g4oGDGUvJk/wqqICP67A5gF5nFalBtzUoqenOZ50LGsW9G5aVFZGF8/CfZvwwigSs43a
         tbhiz/Pu7NhrQcKh2ZJeSRd7w90vxiKyF5yltvdg6ReyTssKB0Nf67ttGdaazYq9BnhG
         RvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ip4yb2a7jW8J2+ncn/GoeHa7yECpYrU+u7C3oc55Chg=;
        b=f15EfKgy9N/5ZOthfBzYfzKuYx32xbiM6PEtBqPPdH4HBa7PZKZ7R/UL32ZxQ53sSO
         FnvP6dTGA894wqOrotgT1ZwnyY2MkOtkaICif/NLv0cVm/YKMl07sJgLNtTF8qQSHs9o
         EH96R0NK5d8sJNiQwVR4FwIitofNBIbHATTHKsPa50Kr0lV+hbGU30CqE4UByZrh45Us
         mW2WaEIbUFHFEbUiiwoSPT9h03njx9UumGrzqNYZ8cDqLwTlwy8BYTAo8PmhHaDvU3pb
         EFBAQTIijCz3vCl/2guYNA/lqoVjEvcPxBYoVufTCTFd1kRjEXWaSGyKlVUuIYjc0OHw
         XBQg==
X-Gm-Message-State: AOAM530HudJUHf3LawYoH/uWuESrQ3+iePcf5zWbV1FM16S4MUWx5v1V
        d7T91voKYFJwXav1yqcntLZJ7GSLZIg=
X-Google-Smtp-Source: ABdhPJxYTsumb/UNdI9Q3Nem/5W/eEphgs9LG6qlHvE8nZLb43G50mrMRvD3ITBQjSbmxY8zQi2Dpw==
X-Received: by 2002:a17:90a:4a06:: with SMTP id e6mr21523146pjh.228.1639114998691;
        Thu, 09 Dec 2021 21:43:18 -0800 (PST)
Received: from google.com ([2620:15c:202:201:8a3d:b2f2:42a0:335a])
        by smtp.gmail.com with ESMTPSA id gv23sm10813514pjb.17.2021.12.09.21.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 21:43:17 -0800 (PST)
Date:   Thu, 9 Dec 2021 21:43:15 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>
Cc:     linux-modules@vger.kernel.org
Subject: [PATCH] kmod: add support for passing compressed modules directly
 into kernel
Message-ID: <YbLo8wjBWDxwICf1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Kernel's load pinning facilities interfere with loading compressed
modules, because if decompression happens in userspace and module is
instantiated via init_module() call there is no way for kernel to
ascertain that module data is coming from a trusted source. To solve
this issue module decompression support was added to the kernel.

Let's use the new kernel facility, and if kernel indicates (via
/sys/module/compression) that that it can handle certain compression
scheme, then use finit_module() and pass a file descriptor to the
compressed module instead of init_module() with decompressed data.
---

Note: this is a companion piece to the kernel patch that can be found
at https://lore.kernel.org/lkml/YbLnAeaKW4HdtRWL@google.com/

 libkmod/libkmod-file.c     | 41 +++++++++++++++++++-------------------
 libkmod/libkmod-internal.h |  9 ++++++++-
 libkmod/libkmod-module.c   | 41 +++++++++++++++++++++++++++++++++++++-
 shared/missing.h           |  4 ++++
 4 files changed, 73 insertions(+), 22 deletions(-)

diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index b6a8cc9..9f1b99e 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -48,17 +48,11 @@ struct file_ops {
 };
 
 struct kmod_file {
-#ifdef ENABLE_ZSTD
-	bool zstd_used;
-#endif
-#ifdef ENABLE_XZ
-	bool xz_used;
-#endif
+	enum kmod_compression compression;
 #ifdef ENABLE_ZLIB
 	gzFile gzf;
 #endif
 	int fd;
-	bool direct;
 	off_t size;
 	void *memory;
 	const struct file_ops *ops;
@@ -179,7 +173,7 @@ static int load_zstd(struct kmod_file *file)
 
 	ZSTD_freeDStream(dstr);
 	free((void *)zst_inb.src);
-	file->zstd_used = true;
+	file->compression = KMOD_COMPRESSION_ZSTD;
 	file->memory = zst_outb.dst;
 	file->size = zst_outb.pos;
 	return 0;
@@ -193,7 +187,7 @@ out:
 
 static void unload_zstd(struct kmod_file *file)
 {
-	if (!file->zstd_used)
+	if (file->compression != KMOD_COMPRESSION_ZSTD)
 		return;
 	free(file->memory);
 }
@@ -272,7 +266,7 @@ static int xz_uncompress(lzma_stream *strm, struct kmod_file *file)
 			goto out;
 		}
 	}
-	file->xz_used = true;
+	file->compression = KMOD_COMPRESSION_XZ;
 	file->memory = p;
 	file->size = total;
 	return 0;
@@ -302,7 +296,7 @@ static int load_xz(struct kmod_file *file)
 
 static void unload_xz(struct kmod_file *file)
 {
-	if (!file->xz_used)
+	if (file->compression != KMOD_COMPRESSION_XZ)
 		return;
 	free(file->memory);
 }
@@ -314,15 +308,20 @@ static const char magic_xz[] = {0xfd, '7', 'z', 'X', 'Z', 0};
 #define READ_STEP (4 * 1024 * 1024)
 static int load_zlib(struct kmod_file *file)
 {
+	int gzf_fd;
 	int err = 0;
 	off_t did = 0, total = 0;
 	_cleanup_free_ unsigned char *p = NULL;
 
 	errno = 0;
-	file->gzf = gzdopen(file->fd, "rb");
+
+	gzf_fd = dup(file->fd);
+	if (gzf_fd < 0)
+		return -errno;
+
+	file->gzf = gzdopen(gzf_fd, "rb");
 	if (file->gzf == NULL)
 		return -errno;
-	file->fd = -1; /* now owned by gzf due gzdopen() */
 
 	for (;;) {
 		int r;
@@ -353,22 +352,24 @@ static int load_zlib(struct kmod_file *file)
 		did += r;
 	}
 
+	file->compression = KMOD_COMPRESSION_GZIP;
 	file->memory = p;
 	file->size = did;
 	p = NULL;
 	return 0;
 
 error:
-	gzclose(file->gzf);
+	if (file->gzf)
+		gzclose(file->gzf);
 	return err;
 }
 
 static void unload_zlib(struct kmod_file *file)
 {
-	if (file->gzf == NULL)
+	if (file->compression != KMOD_COMPRESSION_GZIP)
 		return;
 	free(file->memory);
-	gzclose(file->gzf); /* closes file->fd */
+	gzclose(file->gzf);
 }
 
 static const char magic_zlib[] = {0x1f, 0x8b};
@@ -403,7 +404,8 @@ static int load_reg(struct kmod_file *file)
 			    file->fd, 0);
 	if (file->memory == MAP_FAILED)
 		return -errno;
-	file->direct = true;
+
+	file->compression = KMOD_COMPRESSION_NONE;
 	return 0;
 }
 
@@ -447,7 +449,6 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
 			magic_size_max = itr->magic_size;
 	}
 
-	file->direct = false;
 	if (magic_size_max > 0) {
 		char *buf = alloca(magic_size_max + 1);
 		ssize_t sz;
@@ -501,9 +502,9 @@ off_t kmod_file_get_size(const struct kmod_file *file)
 	return file->size;
 }
 
-bool kmod_file_get_direct(const struct kmod_file *file)
+enum kmod_compression kmod_file_get_compression(const struct kmod_file *file)
 {
-	return file->direct;
+	return file->compression;
 }
 
 int kmod_file_get_fd(const struct kmod_file *file)
diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index c22644a..a8405b3 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -48,6 +48,13 @@ static _always_inline_ _printf_format_(2, 3) void
 #  endif
 #endif
 
+enum kmod_compression {
+	KMOD_COMPRESSION_NONE,
+	KMOD_COMPRESSION_GZIP,
+	KMOD_COMPRESSION_XZ,
+	KMOD_COMPRESSION_ZSTD,
+};
+
 void kmod_log(const struct kmod_ctx *ctx,
 		int priority, const char *file, int line, const char *fn,
 		const char *format, ...) __attribute__((format(printf, 6, 7))) __attribute__((nonnull(1, 3, 5)));
@@ -155,7 +162,7 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx, const char *filenam
 struct kmod_elf *kmod_file_get_elf(struct kmod_file *file) __attribute__((nonnull(1)));
 void *kmod_file_get_contents(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
 off_t kmod_file_get_size(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
-bool kmod_file_get_direct(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
+enum kmod_compression kmod_file_get_compression(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
 int kmod_file_get_fd(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
 void kmod_file_unref(struct kmod_file *file) __attribute__((nonnull(1)));
 
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 6e0ff1a..34cb7f0 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -802,6 +802,39 @@ KMOD_EXPORT int kmod_module_remove_module(struct kmod_module *mod,
 	return err;
 }
 
+static enum kmod_compression kmod_get_supported_compression(struct kmod_module *mod)
+{
+	static const char path[] = "/sys/module/compression";
+	char buf[16];
+	int err;
+	int fd;
+
+	fd = open(path, O_RDONLY|O_CLOEXEC);
+	if (fd < 0) {
+		DBG(mod->ctx, "could not open '%s': %s\n",
+			path, strerror(errno));
+		goto fail;
+	}
+
+	err = read_str_safe(fd, buf, sizeof(buf));
+	close(fd);
+	if (err < 0) {
+		ERR(mod->ctx, "could not read from '%s': %s\n",
+			path, strerror(-err));
+		goto fail;
+	}
+
+	if (streq(buf, "gzip\n"))
+		return KMOD_COMPRESSION_GZIP;
+	else if (streq(buf, "xz\n"))
+		return KMOD_COMPRESSION_XZ;
+	else if (streq(buf, "zstd\n"))
+		return KMOD_COMPRESSION_ZSTD;
+
+fail:
+	return KMOD_COMPRESSION_NONE;
+}
+
 extern long init_module(const void *mem, unsigned long len, const char *args);
 
 /**
@@ -829,6 +862,7 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
 	struct kmod_elf *elf;
 	const char *path;
 	const char *args = options ? options : "";
+	enum kmod_compression compression;
 
 	if (mod == NULL)
 		return -ENOENT;
@@ -847,7 +881,9 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
 		}
 	}
 
-	if (kmod_file_get_direct(mod->file)) {
+	compression = kmod_file_get_compression(mod->file);
+	if (compression == KMOD_COMPRESSION_NONE ||
+	    compression == kmod_get_supported_compression(mod)) {
 		unsigned int kernel_flags = 0;
 
 		if (flags & KMOD_INSERT_FORCE_VERMAGIC)
@@ -855,6 +891,9 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
 		if (flags & KMOD_INSERT_FORCE_MODVERSION)
 			kernel_flags |= MODULE_INIT_IGNORE_MODVERSIONS;
 
+		if (compression != KMOD_COMPRESSION_NONE)
+			kernel_flags |= MODULE_INIT_COMPRESSED_FILE;
+
 		err = finit_module(kmod_file_get_fd(mod->file), args, kernel_flags);
 		if (err == 0 || errno != ENOSYS)
 			goto init_finished;
diff --git a/shared/missing.h b/shared/missing.h
index 4c0d136..2629444 100644
--- a/shared/missing.h
+++ b/shared/missing.h
@@ -15,6 +15,10 @@
 # define MODULE_INIT_IGNORE_VERMAGIC 2
 #endif
 
+#ifndef MODULE_INIT_COMPRESSED_FILE
+# define MODULE_INIT_COMPRESSED_FILE 4
+#endif
+
 #ifndef __NR_finit_module
 # define __NR_finit_module -1
 #endif
-- 
2.34.1.173.g76aa8bc2d0-goog


-- 
Dmitry
