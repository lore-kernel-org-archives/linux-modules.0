Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86EF1386BF
	for <linux-modules@vger.kernel.org>; Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446212; cv=none; b=VyHLGyaugZwKeWYM56mdFvyAwEheGockTgkXabl5ylkb//4p++aXWENRjnQnsKvl4RcNl6yYzZJnb4VBKf6WmTmEW6GrAeK59vQzXlAEABJuPaMIqkmKoEvd+ktbulxqoV9MIHyfybw0CjiJF92YLw3lEncz2cNdZ23ZAkCHUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446212; c=relaxed/simple;
	bh=ytixmSQoLKTlstIy6Vj6ec4mCC+y87go2ZLTk3iKbqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tT5fE2X7hyKORH870qBaytEsXd3JjcIcLaQ4fBrMydMNILZC67tsOmgio5gcyB2+5EgSC1zhJ5KOSR8qEzpDeNj48XnRLUNNhYdbUneP7PXVzfxW5DyWXLYVRSDK0vBJK3K1aqMh5Lo16uGGZNFxTQWQ/coeTG6TgQ3O4ynj7r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fydPh8Ul; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fydPh8Ul"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77C70C32786;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446212;
	bh=ytixmSQoLKTlstIy6Vj6ec4mCC+y87go2ZLTk3iKbqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fydPh8Ulw88cY4c2klKjFrc7Vkin8u7srk3JwmIyhClttHBD/dsBljMmLoYCySMin
	 X00Ys3cL49G8Lm9YRUwykpSTx+oKl9PheAjLX24azjyIBIsk05c8+bdcbeKG0LVGE6
	 dOUesk6L+5l78EKsXjpeLwULSQRTIYe71N3g+FgPjtWZdsVgkDkWUhKb/qvpoDj9Dy
	 ziJ4IOvpC59d0i/AJX/i7pUNF2X4YcDVdZIn7eEWC1R/FBFDYg9KyQI4KTR39gJPQw
	 LUqcsQVU0WeZhsbCnpfxsR3/k0t3Nok3A6OJsoKRGLJJlHPABDHCE88HKLRqgpfr3x
	 M6tEPZXK1K4rQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D618C3DA47;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 08 Jul 2024 14:43:20 +0100
Subject: [PATCH kmod v2 12/17] man: modprobe.d: factor out a CONFIGURATION
 FORMAT section
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-man-v2-12-a23df6ef871e@gmail.com>
References: <20240708-man-v2-0-a23df6ef871e@gmail.com>
In-Reply-To: <20240708-man-v2-0-a23df6ef871e@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720446209; l=1209;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=NiOhn7IMbJ4OSc6NZUJE+4c+XAAVRQTVxShgJHylHo4=;
 b=9YD5uK+5V72UztVpMETyIgDZY4jL8ArhdBZHxdkdYKcncl1XClzGoQhLWFE0Or6fDuNudfXwI
 R3LuMZ9K2I2AqWGCF9QSzYmzGj6rJWHYz39YCoxhzdEx49FOy7JoIId
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
 man/modprobe.d.5.scd | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/man/modprobe.d.5.scd b/man/modprobe.d.5.scd
index 2a6a789..823ba62 100644
--- a/man/modprobe.d.5.scd
+++ b/man/modprobe.d.5.scd
@@ -29,10 +29,13 @@ Note that module and alias names (like other module names) can have - or \_ in
 them: both are interchangeable throughout all the module commands as underscore
 conversion happens automatically.
 
-The format of files under modprobe.d is simple: one command per line, with blank
-lines and lines starting with '#' ignored (useful for adding comments). A '\\'
-at the end of a line causes it to continue on the next line, which makes the
-file a bit neater.
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


