Return-Path: <SRS0=Ow/D=43=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB3BC18E5C
	for <linux-modules@archiver.kernel.org>; Tue, 10 Mar 2020 05:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481DF2467C
	for <linux-modules@archiver.kernel.org>; Tue, 10 Mar 2020 05:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgCJFBm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 10 Mar 2020 01:01:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:16457 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgCJFBl (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 10 Mar 2020 01:01:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 22:01:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="353525580"
Received: from ldmartin1-desk.jf.intel.com ([10.165.21.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2020 22:01:40 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Yanko Kaneti <yaneti@declera.com>, gladkov.alexey@gmail.com,
        auke-jan.h.kok@intel.com,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 4/6] libkmod: fix return error when opening index
Date:   Mon,  9 Mar 2020 22:00:27 -0700
Message-Id: <20200310050029.27678-5-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310050029.27678-1-lucas.demarchi@intel.com>
References: <20200310050029.27678-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

When calling kmod_load_resources() we could end up getting a bogus
return value -ENOMEM due to several other reasons, like the index not
existing. Change index_mm_open() to propagate the failure reason so we
can take actions on it or return to the caller.
---
 libkmod/libkmod-index.c | 31 +++++++++++++++++++------------
 libkmod/libkmod-index.h |  4 ++--
 libkmod/libkmod.c       | 16 ++++++++--------
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/libkmod/libkmod-index.c b/libkmod/libkmod-index.c
index 1f3351a..6a34c8d 100644
--- a/libkmod/libkmod-index.c
+++ b/libkmod/libkmod-index.c
@@ -611,7 +611,7 @@ struct index_value *index_searchwild(struct index_file *in, const char *key)
 static const char _idx_empty_str[] = "";
 
 struct index_mm {
-	struct kmod_ctx *ctx;
+	const struct kmod_ctx *ctx;
 	void *mm;
 	uint32_t root_offset;
 	size_t size;
@@ -739,10 +739,10 @@ static void index_mm_free_node(struct index_mm_node *node)
 	free(node);
 }
 
-struct index_mm *index_mm_open(struct kmod_ctx *ctx, const char *filename,
-						unsigned long long *stamp)
+int index_mm_open(const struct kmod_ctx *ctx, const char *filename,
+		  unsigned long long *stamp, struct index_mm **pidx)
 {
-	int fd;
+	int fd, err;
 	struct stat st;
 	struct index_mm *idx;
 	struct {
@@ -752,28 +752,32 @@ struct index_mm *index_mm_open(struct kmod_ctx *ctx, const char *filename,
 	} hdr;
 	void *p;
 
+	assert(pidx != NULL);
+
 	DBG(ctx, "file=%s\n", filename);
 
 	idx = malloc(sizeof(*idx));
 	if (idx == NULL) {
 		ERR(ctx, "malloc: %m\n");
-		return NULL;
+		return -ENOMEM;
 	}
 
 	if ((fd = open(filename, O_RDONLY|O_CLOEXEC)) < 0) {
 		DBG(ctx, "open(%s, O_RDONLY|O_CLOEXEC): %m\n", filename);
+		err = -errno;
 		goto fail_open;
 	}
 
-	if (fstat(fd, &st) < 0)
-		goto fail_nommap;
-	if ((size_t) st.st_size < sizeof(hdr))
+	if (fstat(fd, &st) < 0 || (size_t) st.st_size < sizeof(hdr)) {
+		err = -EINVAL;
 		goto fail_nommap;
+	}
 
-	if ((idx->mm = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0))
-							== MAP_FAILED) {
+	idx->mm = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (idx->mm == MAP_FAILED) {
 		ERR(ctx, "mmap(NULL, %"PRIu64", PROT_READ, %d, MAP_PRIVATE, 0): %m\n",
 							st.st_size, fd);
+		err = -errno;
 		goto fail_nommap;
 	}
 
@@ -785,12 +789,14 @@ struct index_mm *index_mm_open(struct kmod_ctx *ctx, const char *filename,
 	if (hdr.magic != INDEX_MAGIC) {
 		ERR(ctx, "magic check fail: %x instead of %x\n", hdr.magic,
 								INDEX_MAGIC);
+		err = -EINVAL;
 		goto fail;
 	}
 
 	if (hdr.version >> 16 != INDEX_VERSION_MAJOR) {
 		ERR(ctx, "major version check fail: %u instead of %u\n",
 					hdr.version >> 16, INDEX_VERSION_MAJOR);
+		err = -EINVAL;
 		goto fail;
 	}
 
@@ -800,8 +806,9 @@ struct index_mm *index_mm_open(struct kmod_ctx *ctx, const char *filename,
 	close(fd);
 
 	*stamp = stat_mstamp(&st);
+	*pidx = idx;
 
-	return idx;
+	return 0;
 
 fail:
 	munmap(idx->mm, st.st_size);
@@ -809,7 +816,7 @@ fail_nommap:
 	close(fd);
 fail_open:
 	free(idx);
-	return NULL;
+	return err;
 }
 
 void index_mm_close(struct index_mm *idx)
diff --git a/libkmod/libkmod-index.h b/libkmod/libkmod-index.h
index 52aebac..db671b0 100644
--- a/libkmod/libkmod-index.h
+++ b/libkmod/libkmod-index.h
@@ -40,8 +40,8 @@ void index_values_free(struct index_value *values);
 
 /* Implementation using mmap */
 struct index_mm;
-struct index_mm *index_mm_open(struct kmod_ctx *ctx, const char *filename,
-						unsigned long long *stamp);
+int index_mm_open(const struct kmod_ctx *ctx, const char *filename,
+		  unsigned long long *stamp, struct index_mm **pidx);
 void index_mm_close(struct index_mm *index);
 char *index_mm_search(struct index_mm *idx, const char *key);
 struct index_value *index_mm_searchwild(struct index_mm *idx, const char *key);
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 39f58d9..ab5c1e8 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -856,6 +856,7 @@ KMOD_EXPORT int kmod_validate_resources(struct kmod_ctx *ctx)
 KMOD_EXPORT int kmod_load_resources(struct kmod_ctx *ctx)
 {
 	size_t i;
+	int ret;
 
 	if (ctx == NULL)
 		return -ENOENT;
@@ -871,17 +872,16 @@ KMOD_EXPORT int kmod_load_resources(struct kmod_ctx *ctx)
 
 		snprintf(path, sizeof(path), "%s/%s.bin", ctx->dirname,
 							index_files[i].fn);
-		ctx->indexes[i] = index_mm_open(ctx, path,
-						&ctx->indexes_stamp[i]);
-		if (ctx->indexes[i] == NULL)
-			goto fail;
+		ret = index_mm_open(ctx, path, &ctx->indexes_stamp[i],
+				    &ctx->indexes[i]);
+		if (ret)
+			break;
 	}
 
-	return 0;
+	if (ret)
+		kmod_unload_resources(ctx);
 
-fail:
-	kmod_unload_resources(ctx);
-	return -ENOMEM;
+	return ret;
 }
 
 /**
-- 
2.25.1

