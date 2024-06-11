Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA5B36AE0
	for <linux-modules@vger.kernel.org>; Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118304; cv=none; b=XALcAY4t0UjyjlK8UTvU40lO5d2DTLXo8sc2Hawg16SJbEnkBZTydk2Rqr3Avqxj5FDZTXl3nc2f6xmDyIo7xnVTCTPQ/mZ6uqTGWpmQltQ9C1JS5aTc++esNe6h7dW/YTjYGahDtIbCsWZbuc73B1sFziYCTa6XCqEaBuEDo3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118304; c=relaxed/simple;
	bh=SF1aw7VsfOusOiwrmaSxpn2Ua9AgXhzy8Sp7Br1+0qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zqm1yq17cGnVV7qRqcNeaPcNgL+H/NwMR8T2oujCvRkyz3a23TdyWfTRuC4Y1E3DItYJxRcukAJvRXHvDU0gun3fnoUgC1UT6WWq8i2xFA3/veKm+FQlxQ6S4BrCnT6S1DHtCJE6O5q2fxbsFcICz9K6qzY067vHSVIN4pBUxr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhRH+0pA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhRH+0pA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E0F3C4AF60;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718118304;
	bh=SF1aw7VsfOusOiwrmaSxpn2Ua9AgXhzy8Sp7Br1+0qs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FhRH+0pAYq0+hhbUnAasXogSu+bsjH3k52letl7dZF62D5VOiB1D4R/PYT3jygKnq
	 nCua6wLkH5pwuQR7jxmOJcOggciLj+q7n0GGX4UnpHi30ZD+Wr0QGH67pz8yuB7EVT
	 yR6FXIkC6sQY7maI8r03do25OeIU5SFcr8aR7rFXs/h40Px+AUydPuE/u4ENZ5o309
	 KEIeB+Mok2IF7ztoFEsvC2x7Wvfcm5ljYVn4QzvdyTWAfiF/i+BEzCwEcurLIGas8t
	 R5grCJp7beMDOk6XnxYHl9l2QszT0fX7/H8CjNgU0c5p1VhcAkmJS6NNXP9BvHsmsv
	 yO7juhqQtjVug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E3BC27C7B;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 11 Jun 2024 16:05:09 +0100
Subject: [PATCH kmod 09/20] man: couple of grammar/language fixes
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-man-v1-9-bd6864d49639@gmail.com>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
In-Reply-To: <20240611-man-v1-0-bd6864d49639@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718118301; l=1047;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=i/S1VKUvrWzewIKxOnrx/yc1sFJXe+b7jnwP8i5BgJg=;
 b=hYjAjjydFSVKF9alkxRx4+pYhTYi7Wg9rj7wT3CgEh6ygQQoUTRfH406ViqcSDzdKuAQBzyNv
 avLOCPtY/a2ANeTqO0wV3ZuBse/XK9258dxdv5/m+4X29o3tTmdLetr
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 man/modprobe.8.scd | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man/modprobe.8.scd b/man/modprobe.8.scd
index 9594798..b47908b 100644
--- a/man/modprobe.8.scd
+++ b/man/modprobe.8.scd
@@ -101,7 +101,7 @@ database.
 	Naturally, this check is there for your protection, so using this option
 	is dangerous unless you know what you're doing.
 
-	This applies any modules inserted: both the module (or alias) on the
+	This applies to any modules inserted: both the module (or alias) on the
 	command line and any modules on which it depends.
 
 *-f*, *--force*
@@ -112,7 +112,7 @@ database.
 	know what you are doing.
 
 	This applies to any modules inserted: both the module (or alias) on the
-	command line and any modules it on which it depends.
+	command line and any modules on which it depends.
 
 *-i*, *--ignore-install*, *--ignore-remove*
 	This option causes *modprobe* to ignore *install* and *remove* commands

-- 
2.45.0


