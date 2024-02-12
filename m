Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D83C3E499
	for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758586; cv=none; b=dvZI/cD9dxgZSWTOEAhOWaINNXPiT3EghcOZrSdpS2QezvKyCVekHo1QvRq2Ibom/339re8qsPIGNR5DmqQ79GJnWxeSNXObv0/MFsC1tlqatxid+CGRomWRjJabpLQkLVugyeQgBakOBk2tt9PM5bGSYUj6slb08OC42yty/zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758586; c=relaxed/simple;
	bh=ldEDUCkPI5C/bJm7mVquDR47uX8LHbZYUjpQ8z+9/jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BioKR73YloIRjXmQEUfaUEz5HcZ5MsM4kRX01rHRj+aLYmE9cUAbbS13IAlZKMS7GDPDC1rz21rIkRNjMyD/b+B2q7Sd+1pwGBpdf3HVcaEjblswFcyK2fTeWFtaN7zcByhJ1uayW12JQSJrbdR4jeLLzJ0m1KMLHIfkr48pyoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir6JuLn9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir6JuLn9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14C25C43143;
	Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707758586;
	bh=ldEDUCkPI5C/bJm7mVquDR47uX8LHbZYUjpQ8z+9/jo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ir6JuLn9aBDAZ981Y4c6ZSacTI4hc84UCU2fTdvR7+i1maM3zGMQ8OX3nL4b3lNIC
	 Pg4XQJaFFWO3s0Kr4LFTQaSf4qZowQuua84RVjtNbemsmZquxMuilNWepJqabRwt5P
	 9va+x+PJlTnydJl2yfHGHI6/ZQzYaGxwAkVzRPiMS7w9GXFZ1Pk5jWuqT3D8t6NoZE
	 E7NnMYN/uj2PykL63xOH0xXLC42W3QlsyzMxxfdltMrsD928XxFH8Zpw8svvMQYNrI
	 lXRSKCAkhcA7PGE0XStBUyAbm1KzePgqOTxjH+QKjGUMQRxmnVVSnhnroX2TETmBPI
	 z0ToCpMKIix6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048CEC48BC3;
	Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 12 Feb 2024 17:23:09 +0000
Subject: [PATCH kmod 08/13] libkmod: always detect the module compression
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-decompression-fixes-v1-8-06f92ad07985@gmail.com>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
In-Reply-To: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707758583; l=2385;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=vnwce2nmhp+gEWObCw0gKQhrZ2WjtAclB1+9aE/85S8=;
 b=N2d9JcCxy/n8uPTm3GLc3XE68bos/hi+cNfNg3vQfzE38+bxAugKCSQKaJI5QyXq15WsecDsU
 +uv2gnZoD+ED061sNEYeRuEr2BJRmPdokQvyo8WMkv37KdX0KHC+e2N
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

Currently, when built w/o given compression we'll incorrectly report a
"compression_none".

As we reach do_finit_module(), we'll naively assume that the kernel can
handle the compressed module, yet omit the MODULE_INIT_COMPRESSED_FILE
flag.

As result the kernel will barf at us, do_finit_module will fail with non
-ENOSYS and we won't end in the do_init_module codepath (which will also
fail).

In other words: with this change, you can build kmod without zstd, xz
and zlib support and the kernel will load the modules, assuming it
supports the format \o/

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 libkmod/libkmod-file.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index 3a79464..b69f1ef 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -174,9 +174,14 @@ out:
 	free((void *)zst_outb.dst);
 	return ret;
 }
+#else
+static int load_zstd(struct kmod_file *file)
+{
+	return -ENOSYS;
+}
+#endif
 
 static const char magic_zstd[] = {0x28, 0xB5, 0x2F, 0xFD};
-#endif
 
 #ifdef ENABLE_XZ
 static void xz_uncompress_belch(struct kmod_file *file, lzma_ret ret)
@@ -275,9 +280,14 @@ static int load_xz(struct kmod_file *file)
 	lzma_end(&strm);
 	return ret;
 }
+#else
+static int load_xz(struct kmod_file *file)
+{
+	return -ENOSYS;
+}
+#endif
 
 static const char magic_xz[] = {0xfd, '7', 'z', 'X', 'Z', 0};
-#endif
 
 #ifdef ENABLE_ZLIB
 #define READ_STEP (4 * 1024 * 1024)
@@ -339,9 +349,14 @@ error:
 	gzclose(gzf); /* closes the gzfd */
 	return err;
 }
+#else
+static int load_zlib(struct kmod_file *file)
+{
+	return -ENOSYS;
+}
+#endif
 
 static const char magic_zlib[] = {0x1f, 0x8b};
-#endif
 
 static const struct comp_type {
 	size_t magic_size;
@@ -349,15 +364,9 @@ static const struct comp_type {
 	const char *magic_bytes;
 	int (*load)(struct kmod_file *file);
 } comp_types[] = {
-#ifdef ENABLE_ZSTD
 	{sizeof(magic_zstd),	KMOD_FILE_COMPRESSION_ZSTD, magic_zstd, load_zstd},
-#endif
-#ifdef ENABLE_XZ
 	{sizeof(magic_xz),	KMOD_FILE_COMPRESSION_XZ, magic_xz, load_xz},
-#endif
-#ifdef ENABLE_ZLIB
 	{sizeof(magic_zlib),	KMOD_FILE_COMPRESSION_ZLIB, magic_zlib, load_zlib},
-#endif
 	{0,			KMOD_FILE_COMPRESSION_NONE, NULL, NULL}
 };
 

-- 
2.43.0

