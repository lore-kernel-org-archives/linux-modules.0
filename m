Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B963C466
	for <linux-modules@vger.kernel.org>; Tue, 11 Jun 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118305; cv=none; b=hHjojvdB949hu5gh+DXHP9Vrqk3L6To2La/5sA00jyLots6ymPpj/o2EmF5fn3IH/01JRNz9XsVaio/uFu2nO02XEkN2lZ3mCnave0L+VaGj1vGEQ4527VdowHz6wW0fQQ4ildGaZ0hWnCbW02AyxTx9DLnNLL1l2IVbVlYwckk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118305; c=relaxed/simple;
	bh=nkDPvON34khEvtcrPjEWBgut+yx/v5FdbPotPiK8mjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dJSxYGZ6YdFTkUP2WiW5oyyDN3x4Sr8FXN4p0DAKEQCA/Mn05PcLvZXKn7VerOJHRaZtqyZx8y6Nm+kP8l3W7X1kjNLDsyFBwawUYRvSQ1nfX+vsd/qhJHDAqo7wR2oqrcw6KzXdfH28cSu6OgiUqhEIShUppnplXYDJvoE6En0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpQJfZ6R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpQJfZ6R"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED0F2C4DDE0;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718118305;
	bh=nkDPvON34khEvtcrPjEWBgut+yx/v5FdbPotPiK8mjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UpQJfZ6RGVkzPt9/R5wOPSx1oGzaBhJYK1hg+p8Oofwo9fxOgVQQJJ6MET2RaFuje
	 iUY1NAldFbBUn7EstErAoKdtDIQBRGb3r0Jm9o041r2aR9Fx9ee1OFKJx94rD0rUUF
	 AGgcDXRaOcP/ewkXO0KQCrfNr/KOTtlvhSiTuJgFkpmSpDWrsa3ZTXtikKLvemuijj
	 gl9uU5wmyeidvzic3/ugxGrmeAl3iw2yJ2UslRN0pvmweot07MGvkRWtBFdi1WT1/R
	 1R61gzn8N5xrxJGRF3P/Ye842dvbv3k4eqdRjnL/sUvmLGMuR02pkYX5xN3q6f3JHY
	 scH1cPJQvLSfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7CDC27C7B;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 11 Jun 2024 16:05:16 +0100
Subject: [PATCH kmod 16/20] man: modprobe.d: factor out a CONFIGURATION
 FORMAT section
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-man-v1-16-bd6864d49639@gmail.com>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
In-Reply-To: <20240611-man-v1-0-bd6864d49639@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718118301; l=1209;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=Me0KYLraey3aFtOsNIa38JIJ5S/4jDVQQSmJfBN1X1g=;
 b=mSTO72EstH5/JB0RMmxQBq0YQCLMM/RcY9SCDlyuQ1G+84tNOJmD8QS33VMYHCZI2UpxaNvra
 dQGgObtK8nLCL1BXy+cxO8IGH0oUo2COpWkNoRDEIBVpy5THTnpnOGr
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
index 2f78dd7..b300758 100644
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
2.45.0


