Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66633BBC1
	for <linux-modules@vger.kernel.org>; Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118305; cv=none; b=h7iPzpl6QuWhbp2sAl+Xax2rOEZ+cptz/sCAygw/aPcR39joi17gPyHd2m6dfyGrK5FMAKZWiFwiG6588ELahDppHSCHHkH5EeA91ZnUjn9XN+zeB8nwE6vWQfKyrRBsAb7HnOmaiW4m0p5D5Q332qVEy2gU/Gk9xayQ76rSlpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118305; c=relaxed/simple;
	bh=bWRjP4c0bDPZm7bwioxcztCS8z6/0oYoXsYEB75UVzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCt+ApAOmEu8nPMvldInIcErOBzGUtpSi/I5KXCk2B5g4cXAabdumDhokCj6COHLPvsiNSirNepT+0RBFoCQoDHvKo8/XjrAB1cj1qTyhen64PiHBnA7Wpo5uzJwjjO7X3jZ3T44s+YBkcqrWnxR6+KfUVQCDm3XWpTX3tkeBos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyCkbmXB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyCkbmXB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C414AC4AF62;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718118304;
	bh=bWRjP4c0bDPZm7bwioxcztCS8z6/0oYoXsYEB75UVzc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oyCkbmXB4JY0BAtvqHOZ7mixCHTj6MOMBiHhkwmSc1A/IFIdtDVJyveKN/Aq6FmhJ
	 U/Y7FDP9I2V0Yfekp22NNv+7UI/uxuYU+ZpbKEjeFwlLfEMrMqwxEWIVb8YrEPRag9
	 wsCwx1emTTP6TQa7aHb/XOf7hADBmrp0StUMJjJTHWch96NnVNrNfSGyq50CUb3MED
	 BvXdXwgzwjTJdjuEJ/tWXhaeFadS04/gPVh0R4AKi3PXXoJ9MoLY5NtWJepVHhG9mi
	 dHeWLQ2Xx6cB35uS7jam7+OhKdecdg/fdOy2U0key8IAYLMfBq9vMSpS+oAE8Xf2Hi
	 fOrES7B4IOucg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77CAC27C7B;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 11 Jun 2024 16:05:12 +0100
Subject: [PATCH kmod 12/20] man: depmod.d: factor out a CONFIGURATION
 FORMAT section
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-man-v1-12-bd6864d49639@gmail.com>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
In-Reply-To: <20240611-man-v1-0-bd6864d49639@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718118301; l=1204;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=MBZ9u1YsdBWLrsS6IKXPuouEtLSbXg3krfB43+8XHQ4=;
 b=QJ/gnXbBCy8GK71vHXtdApLHBLnvLQfJ5TSP0TpGfLaP0nO2eS9ZY/EcS9HPPXdCq4AGuqqTA
 wSfi4WKaoa/DwyG8B86ASfpCfbvQfcwaq6WxlQ1iM6bBui9/oJydFac
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
index 9ee35e8..ef57aac 100644
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
2.45.0


