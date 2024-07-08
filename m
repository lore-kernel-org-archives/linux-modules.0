Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566F61386A7
	for <linux-modules@vger.kernel.org>; Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446212; cv=none; b=AzzjlFmYFCagJygKgQHkOqkeiR6goLCnwQTxjZrUbSX1rwsFYX904K0ByJ86KF81DNjt5r6H0RbFdyr8+zBM4QhmHfMB/eENj7/tt0V3kcoL3K3EpOriyzbrOHiRUOczx0AFkiXOPYgDV1rAPvRhG6FbYpq/LxM17vyPFecMkuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446212; c=relaxed/simple;
	bh=S86tekQ/ZKdI7P4CWCVdzGwNcgoTimDwmigs43X6Gxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C3vktzmrKrhKAK3OuvQM8DWCY/N5pcQmF5q/v6CA7YTryY5UUwhBhHyqqe3aUBzFjS+MRxYOpkjPxkfyMyuNpQd+0hICQ6LfIIijyn9cEwMIEqhi9u/nUEeD8QLloyAk15J0hyyCrc4zzxDm7V7IkExNGG7GEtgkeaLrz6ZOJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZZ3A4O4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZZ3A4O4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AD32C4AF0D;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446212;
	bh=S86tekQ/ZKdI7P4CWCVdzGwNcgoTimDwmigs43X6Gxg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hZZ3A4O44iBMqcbOoQWVa4oGy6VOcfaIxdPTsP0k5L1e4ZiBeoaeARESI8RGEsFZ8
	 FUd44XOEEL/QdHpCyAxmEZZSFuziy6vh3mEGSfn6XriwIBp1k0/CN1h9mtDP/w0sBh
	 nxCrdmzZQITDtYL4XjjNTJ3g7pRN2rpf0cQYW59aiVcTf1vTq09EF9+ovqV2rhAf5T
	 7qtwUH544sN1nAnND0kpzMiTuyaHHUe+qakMZh1+YSKuPzqkTnAnVUOkHhClLNGsYQ
	 cKkVeIxvAXxOKG4oLGT85RRm191ngvDsZpLjTLHIjfeeGKQ0A4R89R++olJD2cBq3R
	 v5SJ0E8lU66hQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089E9C3DA47;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 08 Jul 2024 14:43:11 +0100
Subject: [PATCH kmod v2 03/17] man: misc punctuation fixes
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-man-v2-3-a23df6ef871e@gmail.com>
References: <20240708-man-v2-0-a23df6ef871e@gmail.com>
In-Reply-To: <20240708-man-v2-0-a23df6ef871e@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720446209; l=2203;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=UA0bD0QIi9oJ+WB8CbRTcHtoDuWSq7tnazjxHrKI0fk=;
 b=iClnPpO8X6HOU7b+y9KNBW2gIExHo2njOIa8IXJU1+eQH8USS0kIMrg0BxZDJiQxpvvazUfQH
 mWE0ZZbklufBhuNGaYOOqKpvqX1m/d57JBDjMiGuWThKPA0/Y0slE05
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

Some commas and a full stop was missing ;-)

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 man/depmod.d.5.scd | 2 +-
 man/kmod.8.scd     | 4 ++--
 man/lsmod.8.scd    | 2 +-
 man/modprobe.8.scd | 2 +-
 man/rmmod.8.scd    | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/man/depmod.d.5.scd b/man/depmod.d.5.scd
index 4e05b93..9cf99d5 100644
--- a/man/depmod.d.5.scd
+++ b/man/depmod.d.5.scd
@@ -73,7 +73,7 @@ exclude _excludedir_
 	This specifies the trailing directories that will be excluded during the
 	search for kernel modules.
 
-	The _excludedir_ is the trailing directory to exclude
+	The _excludedir_ is the trailing directory to exclude.
 
 # COPYRIGHT
 
diff --git a/man/kmod.8.scd b/man/kmod.8.scd
index 7bef863..2007a2d 100644
--- a/man/kmod.8.scd
+++ b/man/kmod.8.scd
@@ -15,10 +15,10 @@ Linux Kernel modules. Most users will only run it using its other names.
 
 # OPTIONS
 
-*-V --version*
+*-V*, *--version*
 	Show the program version and exit.
 
-*-h --help*
+*-h*, *--help*
 	Show the help message.
 
 # COMMANDS
diff --git a/man/lsmod.8.scd b/man/lsmod.8.scd
index 7195cba..eb2f2e8 100644
--- a/man/lsmod.8.scd
+++ b/man/lsmod.8.scd
@@ -19,7 +19,7 @@ Maintained by Jon Masters and others.
 
 # SEE ALSO
 
-*insmod*(8), *modprobe*(8), *modinfo*(8) *depmod*(8)
+*insmod*(8), *modprobe*(8), *modinfo*(8), *depmod*(8)
 
 # AUTHORS
 
diff --git a/man/modprobe.8.scd b/man/modprobe.8.scd
index aac3a74..f4ce0be 100644
--- a/man/modprobe.8.scd
+++ b/man/modprobe.8.scd
@@ -202,7 +202,7 @@ Maintained by Jon Masters and others.
 
 # SEE ALSO
 
-*modprobe.d*(5), *insmod*(8), *rmmod*(8), *lsmod*(8), *modinfo*(8) *depmod*(8)
+*modprobe.d*(5), *insmod*(8), *rmmod*(8), *lsmod*(8), *modinfo*(8), *depmod*(8)
 
 # AUTHORS
 
diff --git a/man/rmmod.8.scd b/man/rmmod.8.scd
index 7813448..e1f656f 100644
--- a/man/rmmod.8.scd
+++ b/man/rmmod.8.scd
@@ -39,7 +39,7 @@ Maintained by Jon Masters and others.
 
 # SEE ALSO
 
-*modprobe*(8), *insmod*(8), *lsmod*(8), *modinfo*(8) *depmod*(8)
+*modprobe*(8), *insmod*(8), *lsmod*(8), *modinfo*(8), *depmod*(8)
 
 # AUTHORS
 

-- 
2.45.2


