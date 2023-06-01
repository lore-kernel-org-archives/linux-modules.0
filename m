Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC7DC7EE23
	for <linux-modules@archiver.kernel.org>; Thu,  1 Jun 2023 22:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjFAWkW (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 1 Jun 2023 18:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFAWkV (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 1 Jun 2023 18:40:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91B8133
        for <linux-modules@vger.kernel.org>; Thu,  1 Jun 2023 15:40:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96f5d651170so576998566b.1
        for <linux-modules@vger.kernel.org>; Thu, 01 Jun 2023 15:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685659217; x=1688251217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUIr4zbU6vKwT8OnP+vGUDlU9LfEpC4TuQOUZ+IBSH4=;
        b=kNLxUsKsG01eA4VF1b8/ytsZouB3bCAT0DrXu4ttx7uTKtC7uBygJ6jnOXJycJHs01
         81Zd/0S/fDl4Ix2w1oRKbuVPKWq6LGyr8ATLZ2DdKt0G+ih1e9r9Dlh6A6w+yHNoQIcN
         WGvS4g6WaXL0eWv9AQGpONsLoZ8Ph6Wh6vZ5bBHz498m69AFDTFPu/LoLoF9IQt/9Bc5
         lkYoFvcTnV/WDdTVSVjE2SPGkqcb59Rw/2zm8pGf85Hs1oOl+fdr6aAycFw4BEFzlS3c
         Hx0hWskVtpzXfx2CptzFJU9Mpgv2oulSREacj/F+LLvNJCVkzfajP7Ens5qCYYZj3+VH
         qLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685659217; x=1688251217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUIr4zbU6vKwT8OnP+vGUDlU9LfEpC4TuQOUZ+IBSH4=;
        b=H8fBd6WJjOWWwKzxxxnDvOE0QnJa6ZIx21e3D3YU2/CdEK4FwANwQyHKTuO5Jj7E0a
         z9bcgBkky9ScJ2PQe9rYvKFUZDw89rXkuzm44YdKCdVrU9+bUW80JIH2UXQqsWEr9WFt
         0eCixUrWU5PDzBGNuQtBn6x20l8hRg5w0jgw1w6zBfW6qjfLs1z+y2THkpWHQu31lh7Z
         8T6dloS6+foPByPuc4kpTxKsd33DFUGaUesTxIHNH/6vkqntHfq1jaJESNeMuXg1fdBJ
         inMTOxCP9+tspCxmtTO0tm8qBByWc+MqtmXg4AFVlUFRlkD532GU8XNXyNjBCnWmvdWw
         Z2mg==
X-Gm-Message-State: AC+VfDyhSQMSOmJalonfX3EatanTPu4/HBQFpXqc5EOGKkL4zvps1R4x
        ATywjVXKLcRNIXKA7GL5eO1sGa04H+4=
X-Google-Smtp-Source: ACHHUZ50Rxlp86BkqwZ968gPQx4cUM2JK894O1wRH/cOxTyAAPmYASfbiVAIVRtDTW4YhBXBfINGrA==
X-Received: by 2002:a17:907:e87:b0:974:5e8b:fc28 with SMTP id ho7-20020a1709070e8700b009745e8bfc28mr484888ejc.9.1685659217437;
        Thu, 01 Jun 2023 15:40:17 -0700 (PDT)
Received: from ldmartin-desk2.jf.intel.com ([134.134.137.83])
        by smtp.gmail.com with ESMTPSA id se24-20020a170906ce5800b009662b4230cesm11253318ejb.148.2023.06.01.15.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 15:40:16 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 3/5] libkmod: Keep track of compression type
Date:   Thu,  1 Jun 2023 15:39:59 -0700
Message-Id: <20230601224001.23397-4-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601224001.23397-1-lucas.de.marchi@gmail.com>
References: <20230601224001.23397-1-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Do not only set the type as direct, but also keep track of the
compression being used. This will allow using the in-kernel compression
in future.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 libkmod/libkmod-file.c     | 27 +++++++++++++++------------
 libkmod/libkmod-internal.h |  7 +++++++
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index 1449c41..705770a 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -58,7 +58,7 @@ struct kmod_file {
 	gzFile gzf;
 #endif
 	int fd;
-	bool direct;
+	enum kmod_file_compression_type compression;
 	off_t size;
 	void *memory;
 	const struct file_ops *ops;
@@ -376,19 +376,20 @@ static const char magic_zlib[] = {0x1f, 0x8b};
 
 static const struct comp_type {
 	size_t magic_size;
+	enum kmod_file_compression_type compression;
 	const char *magic_bytes;
 	const struct file_ops ops;
 } comp_types[] = {
 #ifdef ENABLE_ZSTD
-	{sizeof(magic_zstd), magic_zstd, {load_zstd, unload_zstd}},
+	{sizeof(magic_zstd),	KMOD_FILE_COMPRESSION_ZSTD, magic_zstd, {load_zstd, unload_zstd}},
 #endif
 #ifdef ENABLE_XZ
-	{sizeof(magic_xz), magic_xz, {load_xz, unload_xz}},
+	{sizeof(magic_xz),	KMOD_FILE_COMPRESSION_XZ, magic_xz, {load_xz, unload_xz}},
 #endif
 #ifdef ENABLE_ZLIB
-	{sizeof(magic_zlib), magic_zlib, {load_zlib, unload_zlib}},
+	{sizeof(magic_zlib),	KMOD_FILE_COMPRESSION_ZLIB, magic_zlib, {load_zlib, unload_zlib}},
 #endif
-	{0, NULL, {NULL, NULL}}
+	{0,			KMOD_FILE_COMPRESSION_NONE, NULL, {NULL, NULL}}
 };
 
 static int load_reg(struct kmod_file *file)
@@ -403,7 +404,7 @@ static int load_reg(struct kmod_file *file)
 			    file->fd, 0);
 	if (file->memory == MAP_FAILED)
 		return -errno;
-	file->direct = true;
+
 	return 0;
 }
 
@@ -448,7 +449,6 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
 			magic_size_max = itr->magic_size;
 	}
 
-	file->direct = false;
 	if (magic_size_max > 0) {
 		char *buf = alloca(magic_size_max + 1);
 		ssize_t sz;
@@ -468,15 +468,18 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
 		}
 
 		for (itr = comp_types; itr->ops.load != NULL; itr++) {
-			if (memcmp(buf, itr->magic_bytes, itr->magic_size) == 0)
+			if (memcmp(buf, itr->magic_bytes, itr->magic_size) == 0) {
+				file->ops = &itr->ops;
+				file->compression = itr->compression;
 				break;
+			}
 		}
-		if (itr->ops.load != NULL)
-			file->ops = &itr->ops;
 	}
 
-	if (file->ops == NULL)
+	if (file->ops == NULL) {
 		file->ops = &reg_ops;
+		file->compression = KMOD_FILE_COMPRESSION_NONE;
+	}
 
 	file->ctx = ctx;
 
@@ -512,7 +515,7 @@ off_t kmod_file_get_size(const struct kmod_file *file)
 
 bool kmod_file_get_direct(const struct kmod_file *file)
 {
-	return file->direct;
+	return file->compression == KMOD_FILE_COMPRESSION_NONE;
 }
 
 int kmod_file_get_fd(const struct kmod_file *file)
diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 4799ed5..7b8a158 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -61,6 +61,13 @@ struct kmod_list {
 	void *data;
 };
 
+enum kmod_file_compression_type {
+	KMOD_FILE_COMPRESSION_NONE = 0,
+	KMOD_FILE_COMPRESSION_ZSTD,
+	KMOD_FILE_COMPRESSION_XZ,
+	KMOD_FILE_COMPRESSION_ZLIB,
+};
+
 struct kmod_list *kmod_list_append(struct kmod_list *list, const void *data) _must_check_ __attribute__((nonnull(2)));
 struct kmod_list *kmod_list_prepend(struct kmod_list *list, const void *data) _must_check_ __attribute__((nonnull(2)));
 struct kmod_list *kmod_list_remove(struct kmod_list *list) _must_check_;
-- 
2.40.1

