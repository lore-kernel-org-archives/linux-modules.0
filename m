Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361303D388
	for <linux-modules@vger.kernel.org>; Tue, 11 Jun 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118305; cv=none; b=qZrcFUFpIYTh1GoE8vffvDH5wDKDjM8brNaNa/UzVpDoSa7x0nL8BnCCOrCFP864OQNvayWmKaU1R9CbMtNyhgexbMRUiT7hS4ZKN/qCgzMV2InmzaOnpevMbSkSBB3AzSrwVmMQPEtdEZLq53zXL+C9syXTTzWlWRkYKJzs4gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118305; c=relaxed/simple;
	bh=tSg5NWObN/VRrdccnTqW+6WUMORveYOAtAH2G7bxNkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rg9/Hq1XH9n6BLF4+Lb9pq0H48tiEEi4wByNgU/9GkA6zw844LexKGnA8IgJ43JvGAM0FV/KD0WAhWlTmKwgsI/bXP7tEnxa/kSEO8rNNdSOovYA8usp9ZNqDsTHnAuwjgdDcS0B7WLn6SAqeSzdAcaBATlWiv4kLuvWzYI/uoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2yZ5dIN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2yZ5dIN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BE34C4DDEC;
	Tue, 11 Jun 2024 15:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718118305;
	bh=tSg5NWObN/VRrdccnTqW+6WUMORveYOAtAH2G7bxNkE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=K2yZ5dINohE9RaZpx1BANawKIHgzcMhPECYi+zwLvTT625UMJ4R5VWuXBUZIXE2li
	 bSqh7lwoBQeSpB+7GhtJ85AgNbAvxRLc8WS9dekKP23jkIaO8oHloNRh0v+DRHy/ZK
	 FDSlUq2biVBQLB/MNfK/3Dp6QuO4t/kyILZ8wR6iUAe1h8lIyniSL2DjrSa3b0eAVv
	 XaaGjqmu88ogVa4toL0H0yFccV0wAl9MCxB9X2ipMpgSoVyNVz/9q2UlPSliqUuljs
	 2Ik1YDFktbxPXkse3IzX5CASALJm43r5ho83Kj6AH7DhCRh1F03lgipxhWKSpWvNrT
	 bmRp5xarpJp6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39FDC2BA12;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 11 Jun 2024 16:05:18 +0100
Subject: [PATCH kmod 18/20] man: modprobe: remove hard-coded
 /etc/modprobe.d references
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-man-v1-18-bd6864d49639@gmail.com>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
In-Reply-To: <20240611-man-v1-0-bd6864d49639@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718118301; l=1742;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=44XT6FvMPVBapnpGuwguSZLd6W0s8UiXzlVT/+SUTHo=;
 b=pxYCJRcz2FhZxKaQHKPkGqOXYnDpaxyZtS7dXF86jQEGNzjuy31kmjSr2f7QeNJiUJzkKm41E
 qHdtc2GLE7yAdm7hHs0BUcqdc+gKDMnoRQe5g64kYMDFhHITYZtbHoE
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

Point the users to modprobe.d(5) instead.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 man/modprobe.8.scd | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/man/modprobe.8.scd b/man/modprobe.8.scd
index b47908b..8354765 100644
--- a/man/modprobe.8.scd
+++ b/man/modprobe.8.scd
@@ -21,10 +21,9 @@ modprobe - Add and remove modules from the Linux Kernel
 that for convenience, there is no difference between \_ and - in module names
 (automatic underscore conversion is performed). *modprobe* looks in the module
 directory @DISTCONFDIR@/`uname -r` for all the modules and other files, except
-for the optional configuration files in the /etc/modprobe.d directory (see
-*modprobe.d*(5)). *modprobe* will also use module options specified on the
-kernel command line in the form of <module>.<option> and blacklists in the form
-of modprobe.blacklist=<module>.
+for the optional configuration files (see *modprobe.d*(5)). *modprobe* will also
+use module options specified on the kernel command line in the form of
+<module>.<option> and blacklists in the form of modprobe.blacklist=<module>.
 
 Note that unlike in 2.4 series Linux kernels (which are not supported by this
 tool) this version of *modprobe* does not do anything to the module itself: the
@@ -56,8 +55,8 @@ database.
 	by *udev*(7).
 
 *-C* _directory_, *--config* _directory_
-	This option overrides the default configuration directory
-	(/etc/modprobe.d).
+	This option overrides the default configuration directory. See
+	*modprobe.d*(5).
 
 	This option is passed through *install* or *remove* commands to other
 	*modprobe* commands in the MODPROBE_OPTIONS environment variable.

-- 
2.45.0


