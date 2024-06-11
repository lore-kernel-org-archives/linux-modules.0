Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E661A3BBC0
	for <linux-modules@vger.kernel.org>; Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118305; cv=none; b=KjBGDE/CgeB9aJ+zzOgSxP4T2p6OpL9KyCowpXa2xYBtiytacfFmCJBCwy5z0p46KXkzVw2Pv+58QwgH1yFWPXvuQFjhEb1FLjophFcIAvVpKEUGWv8kRyysujVzMewctCIViUhTiF28FfNpEF9KrJHStG+IQ3E11i+LHnMAZYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118305; c=relaxed/simple;
	bh=iJZzq9xnF7uLl3q4PtecIxRNT21kCYBanhMLJLH2puI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QaxpUm4/DBuNsAOTJCzaZ2n/DGxaqcIhfBbmnqmfoJYkEK1ca0AxFX7a/YhoJUwHp6JutbhnCBqpg5VFLwaJ95AyoynTUtedIRrOEyIoRjnqhTHX09eROscDVr/I7vFkhv2uCXUao+Zn/kgLHklLILEn1n4k8Iq8lRc8ffebd4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzu+T0HO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzu+T0HO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAFEFC4AF4D;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718118304;
	bh=iJZzq9xnF7uLl3q4PtecIxRNT21kCYBanhMLJLH2puI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bzu+T0HOUPG7t/cFYnhvyf5cTDMC1BrJzKezgomUV7ukQ5ejtVHniRLCQmlJlkg9d
	 qk+I5BTj9twqm0c1HJHJggHQSmlDSC+NmifgDflbLGIV+6cX1AT9oiH4ZvgngX+2i7
	 CnjVbBvBp6KBqrr+JW3aPFfYhnwCXGPNrC1H/66kM7hBI6f7uMKeDnu3CpMc9tDle/
	 4EnPJIwcTrE+LXA+j/wbjieZLYADhXXOUkOlIIYbXBTsQ5tFFUkS2jg5H7+FTgxyLR
	 2aEY9jdU0jI7yvwIcEMx9/j8McrCB9p1Ja4cHu+ScDdNRdIQUJX3XeiHmwfjsxhzrh
	 O6mHfKNzCAjBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27C1C27C75;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 11 Jun 2024 16:05:13 +0100
Subject: [PATCH kmod 13/20] man: depmod.d: rework the opening description
 sentence
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-man-v1-13-bd6864d49639@gmail.com>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
In-Reply-To: <20240611-man-v1-0-bd6864d49639@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718118301; l=1496;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=CC3VtFG0ohs9KqbnH8/8wWXFS/IpcTQJ8DAdXpdS4kQ=;
 b=3vA7bfld4m7uJads9bdnBFDqH9rT+A8d+d+DvtqLgZoTKs+f9auUcLgx5tdQF8a+QQeYJUxjz
 uCHmD3zTcHODcMODfktJqxsAPpz83Fd7GSpIrhFrmHmpm8Lun86vFjF
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
index ef57aac..0950790 100644
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
2.45.0


