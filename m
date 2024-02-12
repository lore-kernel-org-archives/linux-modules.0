Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663773E477
	for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758586; cv=none; b=dM0XkG6Tc1rx4GtGXnAfA8hrgLPXTe0Wh5MZShfx2KuR4PeTQRgqBTCraUS3uVwwQOBAZupuzco0ATIqCfj4UFE+VZhjvbjinbGZm0qoIFvVHZ/RyRXtlRwrZZMWeeFMAhNCov0HVCwBGiUPhcR65z1BQxq0lFzntpT8dUmtDnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758586; c=relaxed/simple;
	bh=TZBNiHOLDF13i5bmBVUDnvfTXoZyU6dW90MffHP8vIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dsDhVd4zKfO5DJ7jm4OFkWE3aG3Z/c+Fr+L4WJZuds+9Q2zADYtboPx/o6HDdCg95TU25TdirRhnqn8dU5PUTwwC7namkODgxjyoYJ5Q3kRLvc/MA8fruTohDGbe60E+cttKrzU3mZqgJ51P8o+WC2Jl+gqmi5KqUML1+0vqwNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DI27nuEj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DI27nuEj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45DF1C4166B;
	Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707758586;
	bh=TZBNiHOLDF13i5bmBVUDnvfTXoZyU6dW90MffHP8vIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DI27nuEjZNCMGuPKduVxzt+WVt87sziLUT3rGMx40mFiNYtaZZuBQouBcED2w5hcY
	 uI11Di1xmV6O0d4jWlmVjlguzRMlgsmGgYoxeT/9jHZLTbJp5p9wgq9Y1iWIuAqSJb
	 ZJbXd3wsC+bQV5OCo4F2LjdMS+tZ9//ugQa5KoN6D6waW2IrZwjmM/F/SKv9iBtC5m
	 3ND9zFdgY5+b6Cb76w8AQiRBG8QqJ7vavuRBQBEj1Nap5VT5yCbVnzn9JN+gm5z5CA
	 eqzXHez8Jy89/aEkiJH1UNhVQDrHJaF4r7zT/kL3Jsmk1mZ5NKJvvkLzrtQ4AdsSij
	 ACs6wFvtJvSSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BB9C4829E;
	Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 12 Feb 2024 17:23:11 +0000
Subject: [PATCH kmod 10/13] libkmod: tidy-up kmod_file_open()
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-decompression-fixes-v1-10-06f92ad07985@gmail.com>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
In-Reply-To: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707758583; l=2378;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=UfzSecSP8vIYsHmd21SFJIic/SxgSObW4SMoY5ZZ5mI=;
 b=Gh/abScOoWeSs/fl6sH1LlQ+em0F5Pa5ZcmJMSceZ/nUmxJtEHe2B0HizqB1/Uh2wukLUt2Lh
 x7AwKrpVhUKBFQ/7P/bBNO25hPnZDM58kXESBA3oGaNMEHo3UCyWLkq
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

This commit cleans up the indentation and the error path of the
function. It bears no functional changes.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 libkmod/libkmod-file.c | 60 +++++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 35 deletions(-)

diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index 5b88d6c..c4893fd 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -410,41 +410,40 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
 {
 	struct kmod_file *file = calloc(1, sizeof(struct kmod_file));
 	const struct comp_type *itr;
-	int err = 0;
+	char buf[7];
+	ssize_t sz;
 
 	if (file == NULL)
 		return NULL;
 
 	file->fd = open(filename, O_RDONLY|O_CLOEXEC);
 	if (file->fd < 0) {
-		err = -errno;
-		goto error;
+		free(file);
+		return NULL;
 	}
 
-	{
-		char buf[7];
-		ssize_t sz;
-
-		assert_cc(sizeof(magic_zstd) < sizeof(buf));
-		assert_cc(sizeof(magic_xz) < sizeof(buf));
-		assert_cc(sizeof(magic_zlib) < sizeof(buf));
-
-		sz = read_str_safe(file->fd, buf, sizeof(buf));
-		lseek(file->fd, 0, SEEK_SET);
-		if (sz != (sizeof(buf) - 1)) {
-			if (sz < 0)
-				err = sz;
-			else
-				err = -EINVAL;
-			goto error;
-		}
+	assert_cc(sizeof(magic_zstd) < sizeof(buf));
+	assert_cc(sizeof(magic_xz) < sizeof(buf));
+	assert_cc(sizeof(magic_zlib) < sizeof(buf));
 
-		for (itr = comp_types; itr->load != NULL; itr++) {
-			if (memcmp(buf, itr->magic_bytes, itr->magic_size) == 0) {
-				file->load = itr->load;
-				file->compression = itr->compression;
-				break;
-			}
+	sz = read_str_safe(file->fd, buf, sizeof(buf));
+	lseek(file->fd, 0, SEEK_SET);
+	if (sz != (sizeof(buf) - 1)) {
+		if (sz < 0)
+			errno = -sz;
+		else
+			errno = EINVAL;
+
+		close(file->fd);
+		free(file);
+		return NULL;
+	}
+
+	for (itr = comp_types; itr->load != NULL; itr++) {
+		if (memcmp(buf, itr->magic_bytes, itr->magic_size) == 0) {
+			file->load = itr->load;
+			file->compression = itr->compression;
+			break;
 		}
 	}
 
@@ -455,15 +454,6 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
 
 	file->ctx = ctx;
 
-error:
-	if (err < 0) {
-		if (file->fd >= 0)
-			close(file->fd);
-		free(file);
-		errno = -err;
-		return NULL;
-	}
-
 	return file;
 }
 

-- 
2.43.0

