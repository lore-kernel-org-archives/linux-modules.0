Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C35713A3FF
	for <linux-modules@vger.kernel.org>; Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446212; cv=none; b=u03rfALIGEOJQWCCkpSqKO5vs+VBppjYZvI656TcLM1sGexbmbWpRXsagGamOVwh23YTzhyBkdmjyfDU/eXbsJyEE2sR9ucizxJC8tfzshrQEWDpL+YHwL+NB57DOmQDVpuRj+zbntQT+8Ltk68CDXbPHyAx9gkv5lFTYEjDP5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446212; c=relaxed/simple;
	bh=reX775AdHtgwryW4rzmIxVLlWJDaQLw3RSOwGwr/TBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QZMKV7q9+tHJ5l3LZPgckm2IwjspZZwv3lModYiMCqWYUfySAumJGFsZFm/3vbY8qk5eeXy1Q4Yt3F3KJ2/0vyMDN4+bWGM+/UV594dFLTutILFbRJBYTk91m0e+pqoEORX74mIUUvLKt8LzdXRN30nid5WkWVE7ahBNCHUrLR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCLHi6Lq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCLHi6Lq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 261AFC4AF0F;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446212;
	bh=reX775AdHtgwryW4rzmIxVLlWJDaQLw3RSOwGwr/TBk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WCLHi6LqHUPlBfxs6wFg54L4bj7imvVu3HMDys/Hh0Twzbp+jC0BC2kgVOkABjLdd
	 j/HZi/Q7hBC7d2J86sOxNpoCjTm6WnSTFwY3rJHyurl/9tQ/X2SD1k1vMxWbi8oP/e
	 HL7inwecPIlI9QPNrn4abY4oYW9if3ypbLNbo+hlZjyDUutvP4LevYv7XB5qGS2pkC
	 8zZQ3aaDeZ9u6+ivECbMPfEFVnYWIsgcAcU+A2MRVh3EuKFjkyArBSbL9hx47bUJdY
	 wh/rglselhZAhjc4znesFKzJKAo1TMczPPG8v9nwMwlQeiOnLAxkhbEcCsvd9GTGbp
	 fAO3wXjqB2fDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E24EC3DA44;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 08 Jul 2024 14:43:13 +0100
Subject: [PATCH kmod v2 05/17] man: couple of grammar/language fixes
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-man-v2-5-a23df6ef871e@gmail.com>
References: <20240708-man-v2-0-a23df6ef871e@gmail.com>
In-Reply-To: <20240708-man-v2-0-a23df6ef871e@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720446209; l=1047;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=ghp1yuMPaFDIfrK29UeBaDCxUNFTVzebnE9Fx50cEnI=;
 b=qlJHCkU+ErMxwUATAGB/1X+4BZ4gPuqH4eNb5lxRFjeJIMRTzfA7gzeywbUJ+W6mjq5iV5zYl
 5ReFlqC1vYxDXQ0HElS+bqXkBZ8N4p+KtYG/asIufqq5bwUBXXCzpJe
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
2.45.2


