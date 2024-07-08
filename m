Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0413BAD7
	for <linux-modules@vger.kernel.org>; Mon,  8 Jul 2024 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446213; cv=none; b=rkMmBUrq9oa7mKDtUvHBfsjzGzu/nuvZKWkyft3zW4+9IU547aTNBUL2Hw+EdAmpWeG7kCXhbxnwb5xluR3rGyDidf3aauiJ87ZOCoCoFl0ohPgs/aZq1H70Tm9UB6srN8kq3mnGWIZy0nffjEfA2JBFyutxgyi+1GVp5zBeGy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446213; c=relaxed/simple;
	bh=FhUuHoYV3Rg6K07mVJxVxbDz61msD5CpsDOtAzTw9P0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TAQn0klwKjpl/2+PjjNCQ/e1Mnn9mR/QFkNGRjrafIRSdwccz7wcpvX7sLtjm1s54Y44SX0rZNGEOd6qQYHXWm+bSLXzlxuDHlRgqFQAw55rtuRonTPj1BDksUZVuiw1th12femQyiuD3kJkvNomzjFKmUr/R8Kh5OMzshaNVC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojsyNkFZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojsyNkFZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EB23C32786;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446213;
	bh=FhUuHoYV3Rg6K07mVJxVxbDz61msD5CpsDOtAzTw9P0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ojsyNkFZsHItId/MAPBPeDIcLZUppf4j5p4jt+C2IQcbsUXStzag+niNOLkqU8ErR
	 XO3Lp+cIpFfp87TgPgjMesEBzHhKIVWk+LTPHdTKeC8TE60npiiaXsy7F640BYcnTA
	 ampXl3R1IJuOdik0Lp+TXEKUej9wmifHszp840kurWE9AA4Qw95WAW/5WcrsnFGBCK
	 pqtYVb849cfVEBiUA1dYMdRQFVenYgaU2K8vYtt2Z0U/JZWknrjBVzn5u/fapNzUnf
	 GeXh6ieFlty9qZRT5kiyrTvh0hd4R9HuBu76N8AS7hRJY3V4GMKZCSSDcXTPzN6uBN
	 2XAkwIQmBN/Zg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559FEC3271E;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 08 Jul 2024 14:43:18 +0100
Subject: [PATCH kmod v2 10/17] man: depmod: remove hard-coded /etc/depmod.d
 references
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-man-v2-10-a23df6ef871e@gmail.com>
References: <20240708-man-v2-0-a23df6ef871e@gmail.com>
In-Reply-To: <20240708-man-v2-0-a23df6ef871e@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720446209; l=753;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=otdwumXn7ZUPlDKiwK3+mO+jr/HiZ1lNqtK6tXl61go=;
 b=KKDGco88/YAybeur/dVau0GEX/Xlr2IgWSZP3wu7xtDJJvZQDrwWTEtee4Zy3AIQaYyoiSsAU
 2IOebVskVsJAWTDTtvq6zQ84vkTEnlYz5ld0pq03VzEMRf0yEK9O9Xd
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
2.45.2


