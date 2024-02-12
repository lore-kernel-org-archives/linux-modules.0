Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331543D984
	for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758586; cv=none; b=Uvyma6ju3D2ZEGQbnOElNtJKVaMPFohM6OAYMIwQa6gfXBnAdE3jCeP1PCcSzZkKCBYYHnWdFzARDmtE0mywd0PId1jdb9rDelTnaXqOIlNoj/PLzIZF8Xxn5Jt//GIqJzPGXWMEhHi8mBAlbwZmLvC9xb65Ooip8scDdsGJQqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758586; c=relaxed/simple;
	bh=8/AVQ5SXvVfJfMOebZlieCFe0Uwf9pKNuUce6KoTrHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JtJAdM1H2z3sUm95fLmJrrK1SBawJhk1cUCbwasMYWFfxVDzkzlI+r7aQemXfyAEXle1pKnVMJR7b7TMJ2W6zsfnJ/kNgvZxwMznBR5jGnaCC/YSPpPVpOSMXDjDI34emqelnauLyA9tp8b8KGciQaSqUqrHg0bsxRZccHVhn+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYNY1ILl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYNY1ILl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6607C433A6;
	Mon, 12 Feb 2024 17:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707758585;
	bh=8/AVQ5SXvVfJfMOebZlieCFe0Uwf9pKNuUce6KoTrHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IYNY1ILljQlBaNKMCxW7q8fpPH/2t28T6tD0TNMPprwePcRGcqTC9KR4ezQHWpkZE
	 OQPSZ2+paA8HkGBehZ3n8ZarlFh2w+kraTAvYESLD8NmMAhOOAslLvxH3oerCE4u/l
	 0+lEqOzCvIY2JD33I3HVKNGTkx5NqDlk6bXP+AFEQqcOEIBWGrgM43YHgRs70NukB/
	 B1R6zrACe3hYAs58BnCTlWAVUKQkWt7VeIRoblnsHFH5n4P93WEcB90qXo90yUw8XB
	 YaA/fQGekVD3wMc4A9Vzs6o7No3jB1M7lRvNjxWhpYrXMTe6PbiyqfzK8FdmBYH8ye
	 JFJ1jVN4zwyvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52A0C4829E;
	Mon, 12 Feb 2024 17:23:05 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 12 Feb 2024 17:23:04 +0000
Subject: [PATCH kmod 03/13] libkmod: remove kmod_file::{zstd,xz}_used flags
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-decompression-fixes-v1-3-06f92ad07985@gmail.com>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
In-Reply-To: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707758583; l=1540;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=Og0Ag/13F9A4cnAYBK+i+58A4Qix9B4oLZpytfwcabE=;
 b=aqf5N4FQGPUJAkW7v1M065AjQGCZxzI5UInNS0o3k8GazeKKfCR1OKQNJtmvKH6MCNDNBKR6K
 obDFm5x/S3+CxA9y7o9AY+DIA7ZDyuuIVZ9t12G1IGf5Ist8bvXzdWi
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

These are used to protect a free(file->memory), within their respective
unload functions. Where the sole caller of the unload function already
does a NULL check prior.

Even so, free(NULL) is guaranteed to be safe by the standard.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 libkmod/libkmod-file.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index 9a014ea..abd4723 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -48,12 +48,6 @@ struct file_ops {
 };
 
 struct kmod_file {
-#ifdef ENABLE_ZSTD
-	bool zstd_used;
-#endif
-#ifdef ENABLE_XZ
-	bool xz_used;
-#endif
 	int fd;
 	enum kmod_file_compression_type compression;
 	off_t size;
@@ -176,7 +170,6 @@ static int load_zstd(struct kmod_file *file)
 
 	ZSTD_freeDStream(dstr);
 	free((void *)zst_inb.src);
-	file->zstd_used = true;
 	file->memory = zst_outb.dst;
 	file->size = zst_outb.pos;
 	return 0;
@@ -190,8 +183,6 @@ out:
 
 static void unload_zstd(struct kmod_file *file)
 {
-	if (!file->zstd_used)
-		return;
 	free(file->memory);
 }
 
@@ -269,7 +260,6 @@ static int xz_uncompress(lzma_stream *strm, struct kmod_file *file)
 			goto out;
 		}
 	}
-	file->xz_used = true;
 	file->memory = p;
 	file->size = total;
 	return 0;
@@ -299,8 +289,6 @@ static int load_xz(struct kmod_file *file)
 
 static void unload_xz(struct kmod_file *file)
 {
-	if (!file->xz_used)
-		return;
 	free(file->memory);
 }
 

-- 
2.43.0

