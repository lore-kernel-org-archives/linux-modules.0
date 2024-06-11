Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075732E3E0
	for <linux-modules@vger.kernel.org>; Tue, 11 Jun 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118305; cv=none; b=LnXgmc4xMcuFN44nLKEUu4fscUi1hsJO8bFIapXw+kzVto24O/IWmLfMgMpSecTjcuj1l1X3LsdFQP1KR4olMBNK0jq0m9oBjJqzwSpjQlb4DGdtm8Egl64kTYULxC75ipJR9oFgiT2RuJNuA6xMGz5aU5b0cZaicLE5exakqKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118305; c=relaxed/simple;
	bh=V3+HLQZNt5lfey3VC/jUl9oIGGFyldryPMbstKan6Hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ebj1/DIOkkz+8AmXH18KJqRCsCgfggw+r1ajtRtyEMRI3HG9//kM/t/cMOa2/ySC6CsajwVst1qt1fPyCI2rdqh/b4IfXVqv/sH1zY8Fw6SfetSU8PLb4iaq6sWp4UAmnFT2nHitnuRULvQNCuRr0OmMDRuhNsUE8srGOKjSits=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gB4yei3f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gB4yei3f"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6144C4AF65;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718118304;
	bh=V3+HLQZNt5lfey3VC/jUl9oIGGFyldryPMbstKan6Hc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gB4yei3fkCWhFhYF+TxUfbPZAOZYi6wCXKK4733xqW0R0hFihMHe9/9QI6FHZ1H+G
	 z/U4bSHDRJa0OvYGO0DuRPqlzCstCjGBzrbRZr0ijR7F51I+p/skme45UeW50qYWqd
	 vNpBSFWH8bCzDSpED3JYw5+6xhI0fikzhK2uHDpgO+oSYGlbRspNEnkTOZ7QyrcM24
	 z8c87dwOM4As/gIAjKtayN20Li2GG0tBdRbrQBBusHNyufaBipluiu3e/KGstvSiD8
	 z3VXWtC/G040kvK8T7XOc8SxPahf/na/irK1TvDKRh9tjXP1qhQey/r4q+V22Xnbek
	 W+0RvrssphEiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC26EC2BA12;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 11 Jun 2024 16:05:14 +0100
Subject: [PATCH kmod 14/20] man: depmod: remove hard-coded /etc/depmod.d
 references
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-man-v1-14-bd6864d49639@gmail.com>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
In-Reply-To: <20240611-man-v1-0-bd6864d49639@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718118301; l=753;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=svS1mKkzatb4KboeBAby/QJhwwhwtB4yaO8xQj7c6fc=;
 b=Du1CxaCDg3vwYItOFdLRho4j3zFJqneHFy05JLFecogJmEj4whra41k/EyQlna7RUmEmOK7nv
 VBea2Q+mYxbD1KLqiW5g6SwBlf18JW2p1femsDxxGrL6dNN4c4vuwrR
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

Point the users to depmod.d(5) instead.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 man/depmod.8.scd | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man/depmod.8.scd b/man/depmod.8.scd
index 7a2e84b..0252a72 100644
--- a/man/depmod.8.scd
+++ b/man/depmod.8.scd
@@ -61,8 +61,8 @@ rather than the current kernel version (as returned by *uname -r*).
 	being the one set by _outdir_.
 
 *-C*, *--config* _file_ _or_ _directory_
-	This option overrides the default configuration directory at
-	/etc/depmod.d/.
+	This option overrides the default configuration files. See
+	*depmod.d*(5).
 
 *-e*, *--errsyms*
 	When combined with the *-F* option, this reports any symbols which a

-- 
2.45.0


