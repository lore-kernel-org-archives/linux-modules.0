Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E38113A400
	for <linux-modules@vger.kernel.org>; Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446212; cv=none; b=k5nWyma8pRnI9STWvYnHNE0zvi2XqJM8dXG/Dp2EllJH4qJzwc/n1/iGfBa8mLuk9SWfTVcSws771N8a7Z9tUHjnyQbbC5vB3eLCsLfJv0oqZJMo2KaZ0uzIXFYUf3rzXF04dcmdrIGDwJM8C5j0QRhOnxeQzFJcRSK/nounzoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446212; c=relaxed/simple;
	bh=y3+NZRwaUPZF8YaPFzGwELLAENnbVzi0rdP022MaUN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P/HAeVVTBjF6zyGrGSFntleebFgKg4V6GTzX8popdXljUogV4CCtPLiZK4vgDHfEpcU8vZ8c1EZaa2GSZSAojJxw2cO3FdBJUTXA2nv8NCAjfrYvHE21SUR7y6xos5PL+xi/xY4Z87gH+hmOBKqVOqedVqJxVrWD/B7j9RbA2xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gq/gG6Br; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq/gG6Br"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 478A8C4AF12;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446212;
	bh=y3+NZRwaUPZF8YaPFzGwELLAENnbVzi0rdP022MaUN4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gq/gG6Br0o5pfnziTKuuzygD70xJetR9JWX8q2gqx/SZpbIlfAFNuXcYwvy40w0vi
	 lB6I7N5QrLHlX783B5PVu4J5rK4nJODIR6jI4n5NcIOp/S+vg9r+1F4QlU2FGF5GXH
	 v2+5f5SeNaUKZbRycQIO+ZtVhUxn3QVWojIG08l/vXJyi5dV1GxUyyW8jyjQ4ApyOO
	 Vb3YANySOm1GeThkTzK8xmLaU640ZvMh66ipo8herJ2iBGc1wQOz+1Fp6YWOGZ0Zf2
	 9qhC+V+VjrDLhPOAdgIKfenO+d3xUatONLQ6twEFifHXiXyWdF5t9BEnSJzt/gpyeW
	 hmmjwaVq5gsgA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBABC3DA42;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 08 Jul 2024 14:43:16 +0100
Subject: [PATCH kmod v2 08/17] man: depmod.d: factor out a CONFIGURATION
 FORMAT section
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-man-v2-8-a23df6ef871e@gmail.com>
References: <20240708-man-v2-0-a23df6ef871e@gmail.com>
In-Reply-To: <20240708-man-v2-0-a23df6ef871e@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720446209; l=1204;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=NGLEGqLj8zLLn0n+27HERI05e1IHWmUXZnANQrZWQOE=;
 b=IVNxbAgX5n0nvSj6eh8bHSulI/3BRG22u9QhNj6aScWr7T1g+8r0TDYpt99TTdOGD9aJQ5S9n
 GtXS8qVkCixBoKUdqb+CckoODbpxIK/UwYw462htCOYdxpl5flGULzU
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

Keep the description neat and tidy.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 man/depmod.d.5.scd | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/man/depmod.d.5.scd b/man/depmod.d.5.scd
index bd1291b..ddb1340 100644
--- a/man/depmod.d.5.scd
+++ b/man/depmod.d.5.scd
@@ -24,10 +24,13 @@ built-in kernel modules are complemented by custom built versions of the same
 and the user wishes to affect the priority of processing in order to override
 the module version supplied by the kernel.
 
-The format of files under depmod.d is simple: one command per line, with blank
-lines and lines starting with '#' ignored (useful for adding comments). A '\\'
-at the end of a line causes it to continue on the next line, which makes the
-files a bit neater.
+# CONFIGURATION FORMAT
+
+The configuration files contain one command per line, with blank lines and lines
+starting with '#' ignored (useful for adding comments). A '\\' at the end of a
+line causes it to continue on the next line, which makes the files a bit neater.
+
+See the COMMANDS section below for more.
 
 # CONFIGURATION DIRECTORIES AND PRECEDENCE
 

-- 
2.45.2


