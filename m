Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DBA3E464
	for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758586; cv=none; b=Alv9EuhvE7yebCxk48NiHGrCe75592EHi3G6zCyDT+l0e1IG0qXTV6y73pgvi68iJKLNt0bIDnzp4vQ7ErbEQMI4ptXZm4bxdD/6in99OHyUejqvbKtYk9D4eofL56QZGzVXTtX1HYqC9vUWeemyP/HReJ7Op/sgMyYJetYqA4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758586; c=relaxed/simple;
	bh=F6UiGTpuA/8JbAelVRgUhY745RWrx19JN3E3FsJtnyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=keDlz8NOtnonBSi/h8eOufODyRPk5a7hldMzmH32zmDz1meXNY2muapfwPIUMW/kJczJqAZzTeLUzlc4a12Gt9i7lFJSsXbfpc2Lto7QE7tXtadiiodWNfad9KfmwrqPdLuzS5LpakGifLNFomt0kWCpKbdbI2s1Cej+E3aFK2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+zOFpPW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+zOFpPW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94E6FC3277F;
	Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707758586;
	bh=F6UiGTpuA/8JbAelVRgUhY745RWrx19JN3E3FsJtnyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=K+zOFpPWrkIYfxvRhxpk0NIXVgaS1oJCCqUsxsm5fRGUueAKH1XaEHsaV3wcWlPCB
	 yeOf0EkFjEpKo+EXGtgjB7og2R5QAKbH+SW2l3AyPKNUQkOB3IrBUUIk6S4ym9tOOV
	 2y5bVC+Uv+cFSU4iydHxUPWsweY55rgx+QOjEwNM/uOWG4Ltjh5kGjlrlqdPMdVcjw
	 cL4l+rEpi0bE4VPyns33XcEIwgki9JJNCoDQAhInrvDWzcseaoXiOIAX2WIrmoTIMf
	 X+kNrh8VBrhlb8f5iVF5H78F8xh48RN5rvrcgRqJXzQXx/WF81XNLuEB4o7Z2vxJ2Q
	 lRIwri/e2TKmg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BE7C48BC1;
	Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 12 Feb 2024 17:23:14 +0000
Subject: [PATCH kmod 13/13] libkmod: always fallback to do_init_module()
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-decompression-fixes-v1-13-06f92ad07985@gmail.com>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
In-Reply-To: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707758583; l=1269;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=YLQVRnZVvgDMYMKMKqUNfuI2u4VvagtQrxxbP0HW96w=;
 b=dH9WZxNZmaYSoFEZa/rC5AiBsh5aZi9t5itP654DCBcT+JFdIyGDIzRU6uyQQXm70fARrWTdP
 TWZDCB/oeUFBmTOmWcqP6UJ66tRJgDEAhcXhLZ+SNtKM1HwYwcUfWkM
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

Since the direct loading was introduced a few bugs became obvious that
the compression args used were off - both in-kernel and dkms.

While both of those are fixed already, not all of those have reached all
users. For example: for dkms I'm aiming to do a release just as kmod has
theirs (to align /lib/modules <> /usr/lib/modules support).

Although I am wondering if we can indiscriminatingly callback to the old
do_init_module() in all the cases. This means that we'll catch any
in-kernel decompression issues - invalid args, ENOMEM, other....
Although for others (wrong magic, perm, etc) we will end up doing the
exact kernel work twice.

Overall the trade-off seems worth it, so flip this.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 libkmod/libkmod-module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index d309948..2c0d46d 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -980,7 +980,7 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
 	}
 
 	err = do_finit_module(mod, flags, args);
-	if (err == -ENOSYS)
+	if (err)
 		err = do_init_module(mod, flags, args);
 
 	if (err < 0)

-- 
2.43.0

