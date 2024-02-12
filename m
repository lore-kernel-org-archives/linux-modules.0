Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A6F3E476
	for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758586; cv=none; b=fwyLgVVwJkMVLTkQ7yFbf25E8dmx6PuIm+Nifbjdt609DVRWh3l3FH1Z6tRClO9ck0qTBABbB2+Wi0wre0WyXqR4YMmbPkHqHy0gZ8bTQWGNSrmq9MBwP1sdZWjfs1UvLPPw8L4xlvuqsNeUs1RZaCO5rNJKs2lxSFAAFLLPNY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758586; c=relaxed/simple;
	bh=722WuASjlqY/S4jd8A11LRaTnRtRjDFwZUt9oHhXLdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cYDE/0llvgNwNq6mT6exxUCRWnAx5HbCE4AX06xOvQTJJUAuFUMvbgAVt3FBmaFCc9X0NEIsyHssILbqzw6YsYRVcg/7rWzCKTO95XpapsZU/Rbdh/gIggKa+KEjn7XleJdWTxHPAiWy9mx8VmX6nUKqZKh14NtYs6SxJP1vYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEH0KQ7S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEH0KQ7S"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 262A0C43609;
	Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707758586;
	bh=722WuASjlqY/S4jd8A11LRaTnRtRjDFwZUt9oHhXLdg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LEH0KQ7SV6lSDxAROav5XYdlhnlJfw1+EQpBPmlwkCQ5jRnRTDavvVC2CZAhU5VPL
	 VTw0g9lHU1AWXHdknSuBHTG/OOVWnTcIzmwZ53cB2RRqf9rR5mOes/Jh1LpzB1PajP
	 Yq4IF/qlhZgmvmbBfkhDc0SPKhnQwhnFl2GlaooZRBoESc+1R509xfMWsRviRPdSvI
	 fEXdvPSDhUjuJntXTy+ErRFA6Gk0UEIRS7XGlOPgrZRAo9b58YgpIfamsLXnHwREOL
	 hV8vLK+INvgXQ/jpM5fRQ0PYgYLXljFsMrMHz42wfWL/odgDGcHx3PjSS2fZ+w6mS7
	 sUeIGnqkFnE3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158CBC48BC1;
	Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 12 Feb 2024 17:23:10 +0000
Subject: [PATCH kmod 09/13] libkmod: swap alloca usage for a few assert_cc
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-decompression-fixes-v1-9-06f92ad07985@gmail.com>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
In-Reply-To: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707758583; l=1663;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=XPT/ZixMYN/E3QF0xKFi5IKVYm1O2Fs0Z8DdyQGwNPg=;
 b=jsdW4IsoknHmKJGjSqwIeZ974sfzKlQNxyU7QbZXEyfleS0NmbphAOBRNIdyI3Ei+fDPUlAqC
 5aq88pNxiVgBZdSpX/5gupR9OzyIV2Y3Bv5ZvegpecqO7ZKMR8UPC4g
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

Since all the compression magic is always available now, we don't need
to loop at runtime nor use alloca - latter of which comes with a handful
of caveats.

Simply throw in a few assert_cc(), which will trigger at build-time.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 libkmod/libkmod-file.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index b69f1ef..5b88d6c 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -410,7 +410,6 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
 {
 	struct kmod_file *file = calloc(1, sizeof(struct kmod_file));
 	const struct comp_type *itr;
-	size_t magic_size_max = 0;
 	int err = 0;
 
 	if (file == NULL)
@@ -422,22 +421,17 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
 		goto error;
 	}
 
-	for (itr = comp_types; itr->load != NULL; itr++) {
-		if (magic_size_max < itr->magic_size)
-			magic_size_max = itr->magic_size;
-	}
-
-	if (magic_size_max > 0) {
-		char *buf = alloca(magic_size_max + 1);
+	{
+		char buf[7];
 		ssize_t sz;
 
-		if (buf == NULL) {
-			err = -errno;
-			goto error;
-		}
-		sz = read_str_safe(file->fd, buf, magic_size_max + 1);
+		assert_cc(sizeof(magic_zstd) < sizeof(buf));
+		assert_cc(sizeof(magic_xz) < sizeof(buf));
+		assert_cc(sizeof(magic_zlib) < sizeof(buf));
+
+		sz = read_str_safe(file->fd, buf, sizeof(buf));
 		lseek(file->fd, 0, SEEK_SET);
-		if (sz != (ssize_t)magic_size_max) {
+		if (sz != (sizeof(buf) - 1)) {
 			if (sz < 0)
 				err = sz;
 			else

-- 
2.43.0

