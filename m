Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96E81EB21
	for <linux-modules@vger.kernel.org>; Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118304; cv=none; b=UBNFo4aMsSfoCN1SR900RDOE8znGA9fzBxqUv7RzvKF9T276GG64Zc4yqx9NASE5z0CWFUr60di9WZ4BRIixuCjtBUUo3LlkXNfVl7SUG5/mNg4d79BlHh2G2ngyl09wHQBmiZuPTznQiOGhDn5DjCI3PAb4QVae5Btuc+hKsVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118304; c=relaxed/simple;
	bh=G6pSMDpddWlekCjvTNWoWMRR5TEZgXMxrSqfJ4jZcFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mz0gKLOck9xPbVuHE73czSxcXObm29XoK1Iy1Fu1Fv5W35axH9OAd7A97DyugfZlSqZ8Z6xADYFhiYQjV1FW8uR/ehu1q9qaWF6zkHp1iAuUKgS0gfMdAW5gknMJgeAvbPZr3+fsOOWlE25nQk0umoxEznN5itulvpUr/CZ0C5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmuWlp8E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmuWlp8E"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5E26C2BD10;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718118304;
	bh=G6pSMDpddWlekCjvTNWoWMRR5TEZgXMxrSqfJ4jZcFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cmuWlp8EAb55ERPh51ZArc/W0SYuLHZPkwChHKhbSGH9afbcCtrm5zuev0DkwniyI
	 fu20I+vYgPpOXus8e7MZtpAOnt72EZJ03aW8OxYClNi0ntA1ZDjTh/K5yissgZ4oSu
	 gp9wJ13oiVoYmtA6wQ/tNVsyNjhgAOdGBOwa8tvktM0RUoEwp0qtQZzhTWJUnaOW0H
	 iPXEmLp/rKRZ92glg4Qj2/DdwhygszaAPmtrFsEi3jVRzhyAnJyfYl3dxbfipi6/P0
	 7u9MOP5ofTJZCH80HUe33tQ+UzvruZi6wiIJ7Pqryt24+CaSNPAf0SC+fRzKQRWGE3
	 /lPybVHA/P2AQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB9AC27C77;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 11 Jun 2024 16:05:11 +0100
Subject: [PATCH kmod 11/20] man: depmod.d: document the config file order
 handling
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-man-v1-11-bd6864d49639@gmail.com>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
In-Reply-To: <20240611-man-v1-0-bd6864d49639@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718118301; l=2376;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=ddft5epJfJ7Syzl58yhh/w8V7UnnoNgSvHNj/DUisJQ=;
 b=2dLX7d3FGKruy7BchZS8mjaY+lunw72uun71hvwSaKKPWSwhajtTZ2eZSFuBdbc2k7WAF3EDn
 7qO58RkwByfA0Qcim5G5MOx5n+78FTx2Eg4fpmZecalWVjCCKUZy6VG
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

The depmod.d configuration order/handling aligns with existing tools
such as sysctl.d, even though there is no mention in the manual.

Reorder the list in SYNOPSIS and add a bit of verbiage describing things.

Section is copied^Winspired by sysctl.d(5) ;-)

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 man/Makefile.am    |  1 +
 man/depmod.d.5.scd | 22 ++++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/man/Makefile.am b/man/Makefile.am
index 25135e9..181f619 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -15,6 +15,7 @@ CLEANFILES = $(dist_man_MANS)
 
 define generate_manpage
 	$(AM_V_SCDOC)cat $< | \
+	sed -e 's|@SYSCONFDIR@|$(sysconfdir)|g' | \
 	sed -e 's|@DISTCONFDIR@|$(distconfdir)|g' | \
 	sed -e 's|@MODULE_DIRECTORY@|$(module_directory)|g' | \
 	$(SCDOC) > $@
diff --git a/man/depmod.d.5.scd b/man/depmod.d.5.scd
index 9cf99d5..9ee35e8 100644
--- a/man/depmod.d.5.scd
+++ b/man/depmod.d.5.scd
@@ -6,15 +6,15 @@ depmod.d - Configuration directory for depmod
 
 # SYNOPSIS
 
-/lib/depmod.d/\*.conf
+@SYSCONFDIR@/depmod.d/\*.conf
 
-@DISTCONFDIR@/depmod.d/\*.conf
+/run/depmod.d/\*.conf
 
 /usr/local/lib/depmod.d/\*.conf
 
-/run/depmod.d/\*.conf
+@DISTCONFDIR@/depmod.d/\*.conf
 
-/etc/depmod.d/\*.conf
+/lib/depmod.d/\*.conf
 
 # DESCRIPTION
 
@@ -29,6 +29,20 @@ lines and lines starting with '#' ignored (useful for adding comments). A '\\'
 at the end of a line causes it to continue on the next line, which makes the
 files a bit neater.
 
+# CONFIGURATION DIRECTORIES AND PRECEDENCE
+
+Configuration files are read from directories in @SYSCONFDIR@/, /run/,
+/usr/local/lib/, @DISTCONFDIR@/, and /lib/ in order of precedence, as listed in
+the SYNOPSIS section above. Files must have the ".conf" extension. Files in
+@SYSCONFDIR@/ override files with the same name in /run/, /usr/local/lib/,
+@DISTCONFDIR@/, and /lib/. Files in /run/ override files with the same name
+under /usr/, @DISTCONFDIR@/ and /lib/.
+
+All configuration files are sorted by their filename in lexicographic order,
+regardless of which of the directories they reside in. If multiple files specify
+the same option, the entry in the file with the lexicographically latest name
+will take precedence.
+
 # COMMANDS
 
 search _subdirectory..._

-- 
2.45.0


