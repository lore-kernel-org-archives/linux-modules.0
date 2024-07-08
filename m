Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A6613A405
	for <linux-modules@vger.kernel.org>; Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446212; cv=none; b=UnEBKy0cbzZhI+SJeqSVUThs9DPElUlCVdEcKg3jrSaLblSJMb9DQFcBQgqyi+oJWLGx4c4BmLcx7uYCUkjkeOjqUNUMeTOaTfDaQe2xwvhJL4vNUAf2fZjbwqh49/44f7++7BDU1f7/mHToJJk0ZrvMHx5y855dAf2i7NwnH48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446212; c=relaxed/simple;
	bh=vN8aMynDo9oMB4Na5YFX+R3h7UUtJkF92o5TyWM7hbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JP8GZqnBD9ygLW3HpToNUA1fKn4+7e7oqxUMPcl8v0hPL8eR8BSacTGZq/flmGqhgbTd+AtIIR8tEtQiSDLDbBT9BKxLzzH9LnuW5Qkinv1AJNMaM8WaXF4AckiHWduHOXKCfNP/byJPqSQvrTmKEXr0ORJur8q7+sBWR5Pch+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwJelx70; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwJelx70"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51AB2C4AF13;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446212;
	bh=vN8aMynDo9oMB4Na5YFX+R3h7UUtJkF92o5TyWM7hbg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kwJelx70UJ7FKAy4qgnDwyLTyzBRHgCk9GnkpR1BqKoNENuQmBfp5XzyGPitM3+AH
	 m9ipIbP1o6hX2OKe9wdYx7crcoaPiaa9MAezKVS7XVNDl6LzNL5kvvqodAcIKt6Q8G
	 jtw+F4vf5mMZJp+e2TAVWX9LsCghHimh59OgUYXVN3IEo3NXXxydhI3GNo3RBPQoI6
	 aQ9RH5uZOWuPckDt9Qiu9se49QMVhPgGyMQox1IJs2WLMpPWXOIhxMDj8osyaLV52H
	 EhhbLvm2Md1mc0tvaaOsdFmcXnkIhfJV4nftHEMI9E89/8lDhQ6IqyiXAFC/hjF7M+
	 GgPqgIKGXW3Lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A71BC3DA46;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 08 Jul 2024 14:43:17 +0100
Subject: [PATCH kmod v2 09/17] man: depmod.d: rework the opening
 description sentence
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-man-v2-9-a23df6ef871e@gmail.com>
References: <20240708-man-v2-0-a23df6ef871e@gmail.com>
In-Reply-To: <20240708-man-v2-0-a23df6ef871e@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720446209; l=1496;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=83pOnT6yg/gw40nxC3Dd7S2ZNLn9m8aBas3g3i5wP+M=;
 b=461tCIdPUfs2zMojecEeXOvyCxRf+k8ix2HQ5qblwYjlVlY3KOW3WPHgs35BViLJ3A+XVqGef
 qZw17VsyCCdBPNPX6xtFdqa+YOS4PGpSUpLxWHjGEJzwCIiWg1Qt7v0
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

Use a slightly longer, more gradual introduction.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
Lucas, I'm reading the first sentence and struggling a bit. What does
the "global or per-module" refer to?

Thanks in advance o/
---
 man/depmod.d.5.scd | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/man/depmod.d.5.scd b/man/depmod.d.5.scd
index ddb1340..dc13ec7 100644
--- a/man/depmod.d.5.scd
+++ b/man/depmod.d.5.scd
@@ -18,11 +18,14 @@ depmod.d - Configuration directory for depmod
 
 # DESCRIPTION
 
-The order in which modules are processed by the *depmod* command can be altered
-on a global or per-module basis. This is typically useful in cases where
-built-in kernel modules are complemented by custom built versions of the same
-and the user wishes to affect the priority of processing in order to override
-the module version supplied by the kernel.
+On execution *depmod* reads the configuration files from the above location and
+based on that it processes the available modules and their dependencies. For
+example: one can change the search order, exclude folders, override specific
+module's location and more.
+
+This is typically useful in cases where built-in kernel modules are complemented
+by custom built versions of the same and the user wishes to affect the priority
+of processing in order to override the module version supplied by the kernel.
 
 # CONFIGURATION FORMAT
 

-- 
2.45.2


