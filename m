Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CFE3E468
	for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758586; cv=none; b=CKzuXkFEJ5Ahg+tstHPT6uYRehLJ8gR7XdGV+B6oonElda+lTdqts/aU1zkuSSQkbENWGdQcXt72ma9/3qPLYGq8O3yGTE19G/HbqLNSHvbyEqe3CNv5o2ZovZWI0BFNyQF4I5j3DPReau3OcDYzGKGTM8j6Nrdmhwd1PvvaluY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758586; c=relaxed/simple;
	bh=FIw+zvOJlEF+AaA78DfgEGnylDyg5quXI4v7xQ4SsDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eH/Ehc3gUl0rdK+J85H++0PdRBrcjdZnQR6diQx1IqVptw4QX7NLiNPt88gClv9L+2UtFOtR/krYEnuEPh/jeiumHrWqVf5xd/1KxrYvhrX2TqxWNJX5Z60wlnvuWnFlNOrahRYKE5TRDay9R7ipzIwUAeW8SWnJ7Q1nasn5xgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPf2skuC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPf2skuC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3372C43141;
	Mon, 12 Feb 2024 17:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707758585;
	bh=FIw+zvOJlEF+AaA78DfgEGnylDyg5quXI4v7xQ4SsDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gPf2skuCAoLgIkeQYoIyJnprTv6UO2d3nc4miRx4fsiY1rt5dUW4aLiODKzQyoek3
	 Bw7F3Tn2sX93R2+bHkaI2SESTy19jLNKL5b/3/MbKvDKlDSlc4M2XhrGBWzOhfvmjX
	 fT9/S65yvkemrF/vUkykaPxZXwALNxaYjgXr0ieaHYd3+EzVuk/KbllCm7/qXPE0QK
	 l9pLFzpQyp5+NZ4yoIKBK0IW5jt1C5/oudObfG6FHZxaqQHUf/qvM+XanwfD0hlwUB
	 oitsdczwrxc4gy0Bg8wkiZhItjH8a5TXBtttLQ0hm4cPVBIVPuyWDNuAPGkfMZvJmU
	 TgsDTsrsu+Iog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD6FC4829E;
	Mon, 12 Feb 2024 17:23:05 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 12 Feb 2024 17:23:07 +0000
Subject: [PATCH kmod 06/13] libkmod: propagate {zstd,xz,zlib}_load errors
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-decompression-fixes-v1-6-06f92ad07985@gmail.com>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
In-Reply-To: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707758583; l=2916;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=1wTsCflduLgjBjz0zHH+IVD4+idKLEWwqQ0UYa76W0U=;
 b=cnsIcWPK/UmkEpJ9lOwKD/Mksdbx2R0i5LjTEnrqQCYbLm+4LI6DHbRs1PYBCLJ6hOXc3uXxl
 LAxWc/sUpawDHEX1Nkab15N4PqMW0OHelpJt1w8VxDbuDXbv0DX8fxg
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

Propagate any errors during decompression further up the call stack.
Without this we could easily pass NULL as mem to init_module(2).

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 libkmod/libkmod-file.c     | 15 +++++++++++----
 libkmod/libkmod-internal.h |  2 +-
 libkmod/libkmod-module.c   |  4 +++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index 8a0336f..3a79464 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -381,10 +381,17 @@ static int load_reg(struct kmod_file *file)
 
 struct kmod_elf *kmod_file_get_elf(struct kmod_file *file)
 {
+	int err;
+
 	if (file->elf)
 		return file->elf;
 
-	kmod_file_load_contents(file);
+	err = kmod_file_load_contents(file);
+	if (err) {
+		errno = err;
+		return NULL;
+	}
+
 	file->elf = kmod_elf_new(file->memory, file->size);
 	return file->elf;
 }
@@ -460,13 +467,13 @@ error:
 /*
  *  Callers should just check file->memory got updated
  */
-void kmod_file_load_contents(struct kmod_file *file)
+int kmod_file_load_contents(struct kmod_file *file)
 {
 	if (file->memory)
-		return;
+		return 0;
 
 	/*  The load functions already log possible errors. */
-	file->load(file);
+	return file->load(file);
 }
 
 void *kmod_file_get_contents(const struct kmod_file *file)
diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 26a7e28..3bc6e11 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -160,7 +160,7 @@ bool kmod_module_is_builtin(struct kmod_module *mod) __attribute__((nonnull(1)))
 /* libkmod-file.c */
 struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx, const char *filename) _must_check_ __attribute__((nonnull(1,2)));
 struct kmod_elf *kmod_file_get_elf(struct kmod_file *file) __attribute__((nonnull(1)));
-void kmod_file_load_contents(struct kmod_file *file) __attribute__((nonnull(1)));
+int kmod_file_load_contents(struct kmod_file *file) __attribute__((nonnull(1)));
 void *kmod_file_get_contents(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
 off_t kmod_file_get_size(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
 enum kmod_file_compression_type kmod_file_get_compression(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 585da41..1e43482 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -903,7 +903,9 @@ static int do_init_module(struct kmod_module *mod, unsigned int flags,
 	off_t size;
 	int err;
 
-	kmod_file_load_contents(mod->file);
+	err = kmod_file_load_contents(mod->file);
+	if (err)
+		return err;
 
 	if (flags & (KMOD_INSERT_FORCE_VERMAGIC | KMOD_INSERT_FORCE_MODVERSION)) {
 		elf = kmod_file_get_elf(mod->file);

-- 
2.43.0

