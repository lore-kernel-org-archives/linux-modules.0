Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063693EA83
	for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758586; cv=none; b=URD4G09FDrYmZ1qE5JVvVl2E/pw8VwqhQ8vs2wmugsbAc0IH0InsJR+DmgVwfWKA1tb93V+GQjo9TjnX0M5okTlYfe1jixY0WEfVSfoQfaALkArN/pyPNyBHZDd7DoenbYjqIiDg+jFoeWwAn9IcaiWenq03oV0eEmeG3uqBXR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758586; c=relaxed/simple;
	bh=Y4L/om0NPArWtsOGcRdMiUyMpIqcXqeEZjnUGy6q+70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tcTCGE4Pd+TpPEcaBCZVK8geK1I7QpgdGdtcY7MuDxu8Vylwv5rsx70x5DBeU2/I8ZRMvq055LizkUa1H3fU47Uido7UrtEF4ncXd2ZvT7OKfPsmwwZqf+kPjhL26amidyE+WAWFg9ll9F+LbFGNL0EdtPXn+0fp4JP3htfaATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvfsOAFj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvfsOAFj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E3A1C43399;
	Mon, 12 Feb 2024 17:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707758585;
	bh=Y4L/om0NPArWtsOGcRdMiUyMpIqcXqeEZjnUGy6q+70=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rvfsOAFj8Y8cccWw5Z6ndXyci1JrBln6Idd5RWCVvc+TRQLmqlrEia0h07CjCQPK0
	 4LmPsfVukYuKfBz5SHdlNZfYdEfYfoABPblLNTV6+gxNGjWnQQc/l0tm8cq2ngHwBH
	 VL0tcVMY9fuCPd5OZjBFryFOe65xOsAkSsQBulrUs/NDrxKSaUWINBdB9K1C11Iijl
	 fAHEykBvLRTpH+p2Qil7NyUpp2i94B2dh+C0anahyCKEqSvlH4jV5poLaXjEZUGtoD
	 UfzdDmxr1ssW5UYjIxl1AM9eS5cGwUY3p/fMeoDdePGkLkkG7d4CeZiwwefGp3kzWw
	 iIVv69RefUrKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F90C48BC0;
	Mon, 12 Feb 2024 17:23:05 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 12 Feb 2024 17:23:02 +0000
Subject: [PATCH kmod 01/13] libkmod: use a dup()'d fd for zlib
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-decompression-fixes-v1-1-06f92ad07985@gmail.com>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
In-Reply-To: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707758583; l=1845;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=snuU8CYNYYFir4PHCqEikR5PrKmafS0jh0cCrGpEUuM=;
 b=A/1wI8pVP1bQlACvosmS2wNa1xBBVLNlKwBUCiOpgOtLSjrsJz8Nr6LUXy8LzXPKGfyCybfd1
 8iki4PVtcToDyhlELSQlynjr6lOEQoDlR47N2zPai316QqMjLV25iXJ
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

The gzdopen() API used, takes ownership of the fd. To make that more
explicit we clear it (-1) as applicable.

Yet again, kmod has explicit API to return the fd to the user - which
currently is used solely when uncompressed, so we're safe.

Regardless - simply duplicate the fd locally and use that with zlib.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 libkmod/libkmod-file.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index b138e7e..b97062b 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -317,12 +317,18 @@ static int load_zlib(struct kmod_file *file)
 	int err = 0;
 	off_t did = 0, total = 0;
 	_cleanup_free_ unsigned char *p = NULL;
+	int gzfd;
 
 	errno = 0;
-	file->gzf = gzdopen(file->fd, "rb");
-	if (file->gzf == NULL)
+	gzfd = fcntl(file->fd, F_DUPFD_CLOEXEC, 3);
+	if (gzfd < 0)
+		return -errno;
+
+	file->gzf = gzdopen(gzfd, "rb"); /* takes ownership of the fd */
+	if (file->gzf == NULL) {
+		close(gzfd);
 		return -errno;
-	file->fd = -1; /* now owned by gzf due gzdopen() */
+	}
 
 	for (;;) {
 		int r;
@@ -359,7 +365,7 @@ static int load_zlib(struct kmod_file *file)
 	return 0;
 
 error:
-	gzclose(file->gzf);
+	gzclose(file->gzf); /* closes the gzfd */
 	return err;
 }
 
@@ -368,7 +374,7 @@ static void unload_zlib(struct kmod_file *file)
 	if (file->gzf == NULL)
 		return;
 	free(file->memory);
-	gzclose(file->gzf); /* closes file->fd */
+	gzclose(file->gzf);
 }
 
 static const char magic_zlib[] = {0x1f, 0x8b};
@@ -535,7 +541,6 @@ void kmod_file_unref(struct kmod_file *file)
 	if (file->memory)
 		file->ops->unload(file);
 
-	if (file->fd >= 0)
-		close(file->fd);
+	close(file->fd);
 	free(file);
 }

-- 
2.43.0

