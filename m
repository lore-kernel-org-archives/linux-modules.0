Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B553C092
	for <linux-modules@vger.kernel.org>; Tue, 11 Jun 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118305; cv=none; b=TEQbrqm+huIx8ga+udNrRdMwzk5k82oN3AmpijcftHO3QoJyS0HYsBEAOqeZL/CgHgppJo4jtz3S0aRjDIpkWOP4fOPRwifCCQFHqJeXTlPpHMcw2VpoUMD/ss2z7zAjD558G18iw/lKByXJYYWuT1XuOblQp4iaZvELfG+HsDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118305; c=relaxed/simple;
	bh=lnEJ1R0sgvvQTjdaEXl46bCeJT+d77b3WPvY8GLsQ9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Turb++rqqR2I/UWdI9Cu/sjsz/Uc1+9QpenULymXCn6c8xKFFowIAynkgIBRwUhivIL8rxWFOH4rmSd1K9LRM7KtIRYrOhvsMz4IIHbZwNgYYaQlN0SjYZR2Cwlf+qXOxWUX4E9fich0fprBUgUomos7dxtM5soPfhlGKnow+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKyUHEsz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKyUHEsz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7A7AC4AF63;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718118304;
	bh=lnEJ1R0sgvvQTjdaEXl46bCeJT+d77b3WPvY8GLsQ9A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BKyUHEszD/b4WDxtYornDJOGt1ojEqHkkTA9RW+tmB5uQMD24jB5fO9u1rGR+kbrl
	 YNEjO6lnCDnwggs/go9WS8SfrgbAnLluAY7LGYHuP4U9Jt6WQI0ESMtmvEsameD5fE
	 RiE/Jqu+u++8uID/OoyjUQVDcEyfKHwpoJzT7g3P0pMN50S24gQNTsSC3i/PiNR9YC
	 NnkdqU8Traafui1sO8AkkrjF/xnZy34gojR04PsoL1u6PWsNp8SwLSJs7Yy+MT2XNJ
	 tQ/dhWMv2e+08KIYPqs4GZaRPxt6KUWpwWZFeiVbxLQAhsG3I6bhufBypTDqV9T5ka
	 aasgiTN1hZvuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DE8C27C79;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 11 Jun 2024 16:05:15 +0100
Subject: [PATCH kmod 15/20] man: modprobe.d: document the config file order
 handling
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-man-v1-15-bd6864d49639@gmail.com>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
In-Reply-To: <20240611-man-v1-0-bd6864d49639@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718118301; l=3167;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=XFaN2I0qhiijgB9eQQCG3OztiO1Rtxam4YIAmEXjq3A=;
 b=upsYJL2THvIlGkkZf02/JrNlyuuNBMWLAOjYhRstRFs9ijc4yAjRIQ81MLJTomqzpCCVaU5y5
 GoEk2/KlcHhA3wSZQ5rdmzI2WyGnTBe260h0PMTkc8YnkJx6LjFnx3t
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

The modprobe.d configuration order/handling aligns with existing tools
such as sysctl.d, even though there is no mention in the manual.

Reorder the list in SYNOPSIS and add a bit of verbiage describing things.

Section is copied^Winspired by sysctl.d(5) ;-)

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
The documentation says ".conf", yet the code in libkmod-config.c also
permits for .alias files. I haven't dug through history - is that
intentional? Should we document why - in-code or manual page?
---
 man/modprobe.d.5.scd | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/man/modprobe.d.5.scd b/man/modprobe.d.5.scd
index 2907175..2f78dd7 100644
--- a/man/modprobe.d.5.scd
+++ b/man/modprobe.d.5.scd
@@ -6,25 +6,24 @@ modprobe.d - Configuration directory for modprobe
 
 # SYNOPSIS
 
-/lib/modprobe.d/\*.conf
+@SYSCONFDIR@/modprobe.d/\*.conf
 
-@DISTCONFDIR@/modprobe.d/\*.conf
+/run/modprobe.d/\*.conf
 
 /usr/local/lib/modprobe.d/\*.conf
 
-/run/modprobe.d/\*.conf
+@DISTCONFDIR@/modprobe.d/\*.conf
 
-/etc/modprobe.d/\*.conf
+/lib/modprobe.d/\*.conf
 
 # DESCRIPTION
 
 Because the *modprobe* command can add or remove more than one module, due to
 modules having dependencies, we need a method of specifying what options are to
-be used with those modules. All files underneath the /etc/modprobe.d directory
-which end with the .conf extension specify those options as required. They can
-also be used to create convenient aliases: alternate names for a module, or they
-can override the normal *modprobe* behavior altogether for those with special
-requirements (such as inserting more than one module).
+be used with those modules. One can also use them to create convenient aliases:
+alternate names for a module, or they can override the normal *modprobe*
+behavior altogether for those with special requirements (such as inserting more
+than one module).
 
 Note that module and alias names (like other module names) can have - or \_ in
 them: both are interchangeable throughout all the module commands as underscore
@@ -35,6 +34,20 @@ lines and lines starting with '#' ignored (useful for adding comments). A '\\'
 at the end of a line causes it to continue on the next line, which makes the
 file a bit neater.
 
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
 
 alias _wildcard_ _modulename_

-- 
2.45.0


