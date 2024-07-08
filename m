Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F5813AA38
	for <linux-modules@vger.kernel.org>; Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446212; cv=none; b=Fqkq72+VStwZIBM3TsbCROUGK6V3s2s1JExVc3XGls1iYk/cmHJbQ2PV8lMpW65vWf97Fa6rytoDWCJzaW9vBj7csaXT+pv0xHeS1nAyb4rJcnrd/DbX3wqfzQYpwjnVyRA7kXtBOitneYhoND8zWE862UyqsrDQJ0d7cxRajLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446212; c=relaxed/simple;
	bh=XduzH//RVm0Qem4A5CvN7rbWh4gjUHC8IBHq8VtJ6fU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VCzLlN/31wkMpJiBc/DT/9qgbx6+QMgZCjggRJ2K5p569ml8GqPXJWKmFE16DtP3xu2dh6xx0Az1f0SajhCH3tNshcT0A30IH+Rtq9Wos0HFVrp98xXY19GHPAK8fkE+bizHoPgCyl+5Wh1yTGZaFBZCR/BWFe+jzwKu/X2uUQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPVblgKI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPVblgKI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8046DC116B1;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446212;
	bh=XduzH//RVm0Qem4A5CvN7rbWh4gjUHC8IBHq8VtJ6fU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uPVblgKIKa1A0FVzysX5eQYX7XUThM39pZOvAhE14F4mBVWSmlaM/tOAJZ71+IY9+
	 J/f3Uzmf/U7uMXllrLX2AoIk+jDK75fpr3zdrIU4Vfe4iLB7pxVJA4MEZW/H64+qcV
	 VDAOQb7RJ9kztaYGa1Q0B4PppmGJcLaBrE7tbGtnh2abWh9O8QAnmU5+wGzSpgclzz
	 pfxS4Xv+s3AbH4GaWYjeEkNzsQvlkSORurKEth2FOwS3O+RW2Jgv9Jf06hmZvVyIJm
	 ZckvumXPaNp9o0kyCLgZKswhBs5KlkDyuGAThgZ8oPi13NI2vTq+Cq1xPe9BKV0dah
	 TMJPrSLO/MnHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C7AC3DA48;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 08 Jul 2024 14:43:21 +0100
Subject: [PATCH kmod v2 13/17] man: add few mentions about MODPROBE_OPTIONS
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-man-v2-13-a23df6ef871e@gmail.com>
References: <20240708-man-v2-0-a23df6ef871e@gmail.com>
In-Reply-To: <20240708-man-v2-0-a23df6ef871e@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720446209; l=1611;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=jvyZXK6JVrVR8ZmU5jRnoTu3XQfa8Wl/GSRQyRWVWKc=;
 b=BH5eMfDAIX5QiKXKjOZljajYGxup435c1L2gM0lOLXB25S8fEaEL0ipRKjuQl13ahcxFqKBqw
 AulAeksUD4RBjFvg83Afn5KEBrZ2vCsvua0AwEM+1Ncl+IYP2QCn4EN
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

The environment variable may alter config file ordering, so mention it
in the man page.

In addition, highlight that the format is intentionally undocumented
since the use by third parties is discouraged.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
v2: tweak (5) wording, add details to (8)
---
 man/modprobe.8.scd   | 8 ++++++--
 man/modprobe.d.5.scd | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/man/modprobe.8.scd b/man/modprobe.8.scd
index b47908b..321fa59 100644
--- a/man/modprobe.8.scd
+++ b/man/modprobe.8.scd
@@ -192,8 +192,12 @@ database.
 
 # ENVIRONMENT
 
-The MODPROBE_OPTIONS environment variable can also be used to pass arguments to
-*modprobe*.
+The MODPROBE_OPTIONS environment variable can also be used to pass command line
+arguments to *modprobe*. The format is intentionally left undocumented, since
+the use by third-party tools and scripts is discouraged.
+
+The environment variable originates with the implementation of the install
+rules.
 
 # COPYRIGHT
 
diff --git a/man/modprobe.d.5.scd b/man/modprobe.d.5.scd
index 823ba62..b7b1942 100644
--- a/man/modprobe.d.5.scd
+++ b/man/modprobe.d.5.scd
@@ -49,6 +49,9 @@ directory they reside in. Configuration files can either be completely replaced
 priority) or partially replaced (by having a configuration file that is ordered
 later).
 
+NOTE: The configuration directories may be altered via the MODPROBE_OPTIONS
+environment variable. See the ENVIRONMENT section in *modprobe*(8).
+
 # COMMANDS
 
 alias _wildcard_ _modulename_

-- 
2.45.2


