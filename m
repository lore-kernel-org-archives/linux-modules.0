Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2013EA87
	for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758586; cv=none; b=mX/E2+Hjrh+gmDh12uiTKVuC/6vW34ufEmNmSRJRawwaHIhKJswy72rB6wXwE5LCPMtr4Xj3zScHtdNQlpqbejRCxNegJ7o5WWJKv402WrGDBC+XyrpDJY/kXtV2lVXiez9q/0TQUNsGUv4OeMM3wy/3xtBcC35DGUDd1gLpzIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758586; c=relaxed/simple;
	bh=7PvciUt4dOCJSgji0+k94M2TQWxFMf+kFJtQXAVtMG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t5Qw13UqAXzdtAmZI4S1v7fYhnOEfQU/GiMQohyb01KC7sXr6C4VX/sYi8CaWzFHjE5tL0tK2C60cX5bcF8nAUWBgU+juAYEXPzaxPKsZTu8pc/wDgel3vZsLcdKBw9jqMEDHkHVUfSYUPqVm0uKFXDicK2E8xU4kHl3SdciA9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rB06tPLA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rB06tPLA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D96FC4167D;
	Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707758586;
	bh=7PvciUt4dOCJSgji0+k94M2TQWxFMf+kFJtQXAVtMG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rB06tPLA6iurb7fFhgC41ItDGqc9bgOaOGCTuTo5IYNsEHBGfX3svjLUyA+JNmlo3
	 fmU6cW9M000PXW+S0cMGUnWgID5DSDXtMxxXr6Hb9dfgw0r9SKIoho6Ky2LZruaFG7
	 YvSn6O2pxOX+fHJN1x/hSJlibItmhKvky8R/Vc4e37g65F24iwEZmjm230Y+y/gbom
	 zORFNKJCLsKcRmgid40JS/kt5XF9+NzB5x3ci/sJRzAvOr9D1YKMdJ2DQ8SoZItSs3
	 B1/M2Ly9LdWus2p8oPZzZ9/SW0CKaaVsSgQ34rmqqqFgtMuX0xizko5r+NW5hDWfcn
	 6hW77QrUTEDxA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF5FC48297;
	Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 12 Feb 2024 17:23:13 +0000
Subject: [PATCH kmod 12/13] libkmod: keep
 KMOD_FILE_COMPRESSION_NONE/load_reg in comp_types
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-decompression-fixes-v1-12-06f92ad07985@gmail.com>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
In-Reply-To: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707758583; l=1865;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=eg4QwfmoJWQ60x2hJ543Y3vC1Tb/8riHCGxkXzk+eG8=;
 b=uzOuE6T9A8QFRCFEYa+9kvPc9yobUxetur2RoHCrRNC8K9OaeJaju0woiZkOM7hW5w8BUg4kd
 1IHLkUj3hvGC81pZAKt20+9VMguL3Whp4D1NhFRbuOdi8XGxbVTVz7S
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

It's cleaner to handle all compression types and load functions in the
same style.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 libkmod/libkmod-file.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index db775a6..f162a10 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -385,7 +385,7 @@ static const struct comp_type {
 	{sizeof(magic_zstd),	KMOD_FILE_COMPRESSION_ZSTD, magic_zstd, load_zstd},
 	{sizeof(magic_xz),	KMOD_FILE_COMPRESSION_XZ, magic_xz, load_xz},
 	{sizeof(magic_zlib),	KMOD_FILE_COMPRESSION_ZLIB, magic_zlib, load_zlib},
-	{0,			KMOD_FILE_COMPRESSION_NONE, NULL, NULL}
+	{0,			KMOD_FILE_COMPRESSION_NONE, NULL, load_reg}
 };
 
 struct kmod_elf *kmod_file_get_elf(struct kmod_file *file)
@@ -409,7 +409,6 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
 						const char *filename)
 {
 	struct kmod_file *file = calloc(1, sizeof(struct kmod_file));
-	const struct comp_type *itr;
 	char buf[7];
 	ssize_t sz;
 
@@ -439,19 +438,17 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
 		return NULL;
 	}
 
-	for (itr = comp_types; itr->load != NULL; itr++) {
-		if (memcmp(buf, itr->magic_bytes, itr->magic_size) == 0) {
-			file->load = itr->load;
-			file->compression = itr->compression;
+	for (unsigned int i = 0; i < ARRAY_SIZE(comp_types); i++) {
+		const struct comp_type *itr = &comp_types[i];
+
+		file->load = itr->load;
+		file->compression = itr->compression;
+		if (itr->magic_size &&
+		    memcmp(buf, itr->magic_bytes, itr->magic_size) == 0) {
 			break;
 		}
 	}
 
-	if (file->load == NULL) {
-		file->load = load_reg;
-		file->compression = KMOD_FILE_COMPRESSION_NONE;
-	}
-
 	file->ctx = ctx;
 
 	return file;

-- 
2.43.0

