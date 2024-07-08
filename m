Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2F113A3F6
	for <linux-modules@vger.kernel.org>; Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446212; cv=none; b=FtlM4q1zgQPth4VCvi3frjewHy7U9KEmhj0K26vNc5TrfRShF0PopGosCjbMJcCydsRiWtYrM7K1qmoTAfAqHvw9fHlI0XKf1UJrYJnn2LKoKBtDRJmeKJ7RNz1PnoD+Qe6gdL3ZpjmJofivahQAb4YWQukKBrO5VbwnjJ0kIAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446212; c=relaxed/simple;
	bh=qLVsjUXyswkYxa2heevGHqnUzTjsaOF/+H6aS/6J/jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oh4gwQqW0nv2hS7KVncAxcXDu4jdURqrav7AK58PG/dtEUHioDgtA+KQf6Qo4RrfqZpgA++wNUER3sYXV9R6IWnJCt5tlSQL4NVPKxgsysDEzSyufAEQX5ZzhOYmUWIvsUBm8stcVZ6wmoD8AVxsFsfog1yIQyBURWhaYCb/sbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBKtTx8S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBKtTx8S"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C631C4AF10;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446212;
	bh=qLVsjUXyswkYxa2heevGHqnUzTjsaOF/+H6aS/6J/jo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BBKtTx8SN/yw6ai2QbLY62udbhDc2CrZprKhMlbn+Yjs2qcFXjBpMrst2WtljnHGm
	 8pGfpcwXMwVcKcWqYs0JnpwR86IMeNIoi1iQf40V3G0Mfx8S/UbDDbGyIS93qwByXQ
	 1lwLH9mraD7dN480KPofs69P2pOBF+7HPS/jCTuUzxUmFI6qXeIHI2n9/xQWFCBoXV
	 E8+BjDjpEJytkZI/bf77Zyj4r1xR96yqCnlXufCNg3kJp6odaFUj9YCgnQVy+5J8GA
	 ByQFYEeu3MQgqFW3/4hRtCctFPovwtGEzc7wMAVgDQGefEbnoHZmrhYx4ZcKeVfda5
	 J9iNHekI7vRPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32824C3271E;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 08 Jul 2024 14:43:15 +0100
Subject: [PATCH kmod v2 07/17] man: depmod.d: document the config file
 order handling
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-man-v2-7-a23df6ef871e@gmail.com>
References: <20240708-man-v2-0-a23df6ef871e@gmail.com>
In-Reply-To: <20240708-man-v2-0-a23df6ef871e@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720446209; l=2297;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=PAvjWYoZgIb8yJI4fuG/sOZcmrnJqbKRc4WY3D6CsBc=;
 b=lchggi4LFvuHfqfR6Aj4s+QV7DRKbs1on1OAfBuelfteWZdhTlk0EPEBYO3waO2D/tZHeCgqI
 jiyso6P6YmHDamT8tj7pVnbjz8vO4EfhkwRsSo3odeWqE1WSTk8IU81
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

Section is inspired by sysctl.d(5) and sysctl(8).

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
v2: Reword as per Lucas' suggestion.
---
 man/Makefile.am    |  1 +
 man/depmod.d.5.scd | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/man/Makefile.am b/man/Makefile.am
index 39a0015..6356d87 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -15,6 +15,7 @@ CLEANFILES = $(filter-out $(MAN_STUB), $(dist_man_MANS))
 
 define generate_manpage
 	$(AM_V_SCDOC)cat $< | \
+	sed -e 's|@SYSCONFDIR@|$(sysconfdir)|g' | \
 	sed -e 's|@DISTCONFDIR@|$(distconfdir)|g' | \
 	sed -e 's|@MODULE_DIRECTORY@|$(module_directory)|g' | \
 	$(SCDOC) > $@
diff --git a/man/depmod.d.5.scd b/man/depmod.d.5.scd
index 9cf99d5..bd1291b 100644
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
 
@@ -29,6 +29,18 @@ lines and lines starting with '#' ignored (useful for adding comments). A '\\'
 at the end of a line causes it to continue on the next line, which makes the
 files a bit neater.
 
+# CONFIGURATION DIRECTORIES AND PRECEDENCE
+
+Configuration files are read from directories in listed in SYNOPSYS in that
+order of precedence. Once a file of a given filename is loaded, any file of the
+same name in subsequent directories is ignored.
+
+All configuration files are sorted in lexicographic order, regardless of the
+directory they reside in. Configuration files can either be completely replaced
+(by having a new configuration file with the same name in a directory of higher
+priority) or partially replaced (by having a configuration file that is ordered
+later).
+
 # COMMANDS
 
 search _subdirectory..._

-- 
2.45.2


