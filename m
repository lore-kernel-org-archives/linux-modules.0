Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820793E49C
	for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758586; cv=none; b=Eoon+Le+Z0V4y6YILI8t5YQbphEoccc7hGfNRzRNXeumsJtbmCa4g/6caAbiv7dTNK7iGCKLdphtRd8PW0VuQpTCD5AalxDqqEaUPgA9sp617vfEsjKF13u+tDhvkDOolZsLalUp2GwsZqjaiNZwaAqEJC+cE7ISY+EQO156mUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758586; c=relaxed/simple;
	bh=3BGP/vZWVd6Fz4QD1oM4T5+MZqwiZCwqPX677URBqrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o7GNq9rwqnibo67Y64F5rOXUvRvJo8d8izW/PrxPjwaxzvE3EJ1FtznQz2OmaUn0FszlktAk6nUCUbBHBj0HvmVC6PZaFQH14Rf/gV0rIACmRiu4h76PK2N8CnPl7Alp0Y3/uEuaPPDaQlDjuKOBae2+hU2ALWXeEyjDOmtQHG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bv2B8aJ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bv2B8aJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63C85C41674;
	Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707758586;
	bh=3BGP/vZWVd6Fz4QD1oM4T5+MZqwiZCwqPX677URBqrs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bv2B8aJ7sBqvjCCuZ5QTeaVTn5xNOILPMh0Cl65GtclYSynZ5nyUsZLDMFRB3NFif
	 lzUJfBb5AbKrWLuSuBq5DQ2qg+uUTi0Rr/V5Fq+71qnGXJDdhL8ubgZGL1jghKEbJt
	 psbEzCDMcaTCJGwossDiCqbaFeq5C3CeDxRLh7327B8n3Ju1AejiLzaYXFDQ7brSxi
	 0xsVksoFAPBM7EvBSDOYK5+eOErhKPtcmh9qsfTTUQSts9k3zhNmCuKlZwZ9mB7jAs
	 W+/YvvK2k2AxXxsYFA31JPSvDR//feOsio60MSRiCMpU+LBZN/8PObAOe5kSqG08wh
	 xe1SQ7rMBMTjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D502C48BC1;
	Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 12 Feb 2024 17:23:12 +0000
Subject: [PATCH kmod 11/13] libkmod: move load_reg() further up
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-decompression-fixes-v1-11-06f92ad07985@gmail.com>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
In-Reply-To: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707758583; l=1695;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=s7DGIk3v5vJZUPUJq4qUIG5k2dwH6qeNbl7Ccp04tdM=;
 b=r+xUgnwpNFv2pLM9zfu/g+v/Ncb451QKQmLwLfooiRmjkaiKwgrO8YpIpoo1nNwAZGpC8KHlN
 3Ax90X3qGebDHBMoyGar0BjA3ntxKXFtVlwhzoSzZWsQQJKuY4R32ze
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

We're about to reference it in comp_types with next commit.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 libkmod/libkmod-file.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index c4893fd..db775a6 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -358,18 +358,6 @@ static int load_zlib(struct kmod_file *file)
 
 static const char magic_zlib[] = {0x1f, 0x8b};
 
-static const struct comp_type {
-	size_t magic_size;
-	enum kmod_file_compression_type compression;
-	const char *magic_bytes;
-	int (*load)(struct kmod_file *file);
-} comp_types[] = {
-	{sizeof(magic_zstd),	KMOD_FILE_COMPRESSION_ZSTD, magic_zstd, load_zstd},
-	{sizeof(magic_xz),	KMOD_FILE_COMPRESSION_XZ, magic_xz, load_xz},
-	{sizeof(magic_zlib),	KMOD_FILE_COMPRESSION_ZLIB, magic_zlib, load_zlib},
-	{0,			KMOD_FILE_COMPRESSION_NONE, NULL, NULL}
-};
-
 static int load_reg(struct kmod_file *file)
 {
 	struct stat st;
@@ -388,6 +376,18 @@ static int load_reg(struct kmod_file *file)
 	return 0;
 }
 
+static const struct comp_type {
+	size_t magic_size;
+	enum kmod_file_compression_type compression;
+	const char *magic_bytes;
+	int (*load)(struct kmod_file *file);
+} comp_types[] = {
+	{sizeof(magic_zstd),	KMOD_FILE_COMPRESSION_ZSTD, magic_zstd, load_zstd},
+	{sizeof(magic_xz),	KMOD_FILE_COMPRESSION_XZ, magic_xz, load_xz},
+	{sizeof(magic_zlib),	KMOD_FILE_COMPRESSION_ZLIB, magic_zlib, load_zlib},
+	{0,			KMOD_FILE_COMPRESSION_NONE, NULL, NULL}
+};
+
 struct kmod_elf *kmod_file_get_elf(struct kmod_file *file)
 {
 	int err;

-- 
2.43.0

