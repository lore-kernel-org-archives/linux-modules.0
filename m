Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371F5C7EE29
	for <linux-modules@archiver.kernel.org>; Thu,  1 Jun 2023 22:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjFAWkX (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 1 Jun 2023 18:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjFAWkW (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 1 Jun 2023 18:40:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EF2133
        for <linux-modules@vger.kernel.org>; Thu,  1 Jun 2023 15:40:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51491b87565so2100166a12.1
        for <linux-modules@vger.kernel.org>; Thu, 01 Jun 2023 15:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685659219; x=1688251219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuIY6m6T2GoGWX1CRKzLylKddebbN2NyDB0hQA927hc=;
        b=MNHTw0J7L8YY8smAjK5Lc956UXVgAXdusEiUc35PZrjfV+9T8UnZ8Er9er2JX+6qx3
         LiqZpBddmOfCeAORfj984mGAxZTbM7QWUI2uiewQFUqDizPOTGRJxZ9MmZW5LH+sX7tm
         AmqEmHYUS3Hb83QVd7ZKy6u0JxgPrXgwWnGrBvTzJPLeN7Y9f4ceyRB3MHD31G7BhMnN
         DGDwuGSJ1c6thWXu9tR08U87TYbujTpfReKmjMhx2X748SvrJqB8yZxKozk5JHdnd4o2
         5LV9UYkJuYKuT2e81X4GGNxG3mH6NUkuoPJHvLiF8Alj0GnD0M7jmoxsS7SmB/ChIqlj
         ln1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685659219; x=1688251219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuIY6m6T2GoGWX1CRKzLylKddebbN2NyDB0hQA927hc=;
        b=j4Jik5VEOTqE43sCvB7WWsWvWoebYMNQ/dUSrRh2aFMcK6Awx1Ih6MDs1OR7D4I6zD
         QjD5l3d7vcaNouvuJvqa5Z7dASOjV7F4jIHtGKXnXhijRxvmE11smadpO1u80bqbsIMv
         UV1+4Opsr9ssG2PUjhspkmBLd8gf3IxgM3T49ibey9VwCFponTkd6MZyq4ApFWjPkRiC
         C4OWLgQkZI65mzY5bIsoUK9IU/bbjH1kZUm35Q55IT6QQYczUny2w2l0246zQq2iaMhF
         Kl0e0/mNvH5bZeHn4wRw/h/UclNXwrPkux1CxfByGzC+D5gGcP4lA4V0ytnutlvqzV1V
         BB0Q==
X-Gm-Message-State: AC+VfDw89iSVSCaOE8pnBALRbVfJOIfFX+E73wujQsuTShqpVB71yNOE
        wUqhhRCgdVvvkEbtqyeP3kO0TFEOFzs=
X-Google-Smtp-Source: ACHHUZ7j90zM1/Cyv0X5ljCbojaSD2kfvh67Q/nAX8pGW13so4lezJsEBrvmhPZ4zqBZxTrAJujVmg==
X-Received: by 2002:a17:907:7fa7:b0:94f:59aa:8a7c with SMTP id qk39-20020a1709077fa700b0094f59aa8a7cmr10784894ejc.20.1685659219497;
        Thu, 01 Jun 2023 15:40:19 -0700 (PDT)
Received: from ldmartin-desk2.jf.intel.com ([134.134.137.83])
        by smtp.gmail.com with ESMTPSA id se24-20020a170906ce5800b009662b4230cesm11253318ejb.148.2023.06.01.15.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 15:40:18 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 4/5] libkmod: Keep track of in-kernel compression support
Date:   Thu,  1 Jun 2023 15:40:00 -0700
Message-Id: <20230601224001.23397-5-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601224001.23397-1-lucas.de.marchi@gmail.com>
References: <20230601224001.23397-1-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

When creating the context, read /sys/kernel/compression to check what's
the compression type supported by the kernel. This will later be used
when loading modules to check if the decompression step has to happen in
userspace or if it can be delegated to the kernel.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 libkmod/libkmod.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 2670f9a..103469e 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -83,6 +83,7 @@ struct kmod_ctx {
 	void *log_data;
 	const void *userdata;
 	char *dirname;
+	enum kmod_file_compression_type kernel_compression;
 	struct kmod_config *config;
 	struct hash *modules_by_name;
 	struct index_mm *indexes[_KMOD_INDEX_MODULES_SIZE];
@@ -227,6 +228,40 @@ static char *get_kernel_release(const char *dirname)
 	return p;
 }
 
+static enum kmod_file_compression_type get_kernel_compression(struct kmod_ctx *ctx)
+{
+	const char *path = "/sys/module/compression";
+	char buf[16];
+	int fd;
+	int err;
+
+	fd = open(path, O_RDONLY|O_CLOEXEC);
+	if (fd < 0) {
+		/* Not having the file is not an error: kernel may be too old */
+		DBG(ctx, "could not open '%s' for reading: %m\n", path);
+		return KMOD_FILE_COMPRESSION_NONE;
+	}
+
+	err = read_str_safe(fd, buf, sizeof(buf));
+	close(fd);
+	if (err < 0) {
+		ERR(ctx, "could not read from '%s': %s\n",
+		    path, strerror(-err));
+		return KMOD_FILE_COMPRESSION_NONE;
+	}
+
+	if (streq(buf, "zstd\n"))
+		return KMOD_FILE_COMPRESSION_ZSTD;
+	else if (streq(buf, "xz\n"))
+		return KMOD_FILE_COMPRESSION_XZ;
+	else if (streq(buf, "gzip\n"))
+		return KMOD_FILE_COMPRESSION_ZLIB;
+
+	ERR(ctx, "unknown kernel compression %s", buf);
+
+	return KMOD_FILE_COMPRESSION_NONE;
+}
+
 /**
  * kmod_new:
  * @dirname: what to consider as linux module's directory, if NULL
@@ -272,6 +307,8 @@ KMOD_EXPORT struct kmod_ctx *kmod_new(const char *dirname,
 	if (env != NULL)
 		kmod_set_log_priority(ctx, log_priority(env));
 
+	ctx->kernel_compression = get_kernel_compression(ctx);
+
 	if (config_paths == NULL)
 		config_paths = default_config_paths;
 	err = kmod_config_new(ctx, &ctx->config, config_paths);
-- 
2.40.1

