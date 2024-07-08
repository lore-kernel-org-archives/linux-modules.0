Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A667113AA42
	for <linux-modules@vger.kernel.org>; Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446212; cv=none; b=fYEUDJkAWY5sNyqPNp36qnvHxOaE0ai9saBP5YyBmULZjqDcG3eE5MfCCiz9xLbOgXkvU3JjEVPazgNCw5jiNpC/YMh0RRr/WYUDXQ5/JLuSZ9NQu4RiUMpP2K1q5JA6/3nMoWfg+8EoCcP4akYsLLMksNixXq6oBseuj04MmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446212; c=relaxed/simple;
	bh=8So/3VS/s6h0cxvqPjDay7RpzVJjW48vaFlZ3KHoFX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ldlngTlJaWCT8gLC30kJfNq8oOJ5bUKTn/6J1sQiuAF9Shx6D9Bd37zRzP7iFn8v0Y5NVnvFbOtHRvnDp5JV6ZpJN5ca+UWq/1KHpku3JJi1kMTBN9vE2aZajitYUypV9cAbdSmEvRp0BgSvCeQG7qxDQNk2uig2Bp6WLg8OYIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sc0NW4oX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sc0NW4oX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C4C0C4AF0A;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446212;
	bh=8So/3VS/s6h0cxvqPjDay7RpzVJjW48vaFlZ3KHoFX8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sc0NW4oX72x/IltlZmIp+8igqCuxoqoVo1gcrlA/BzjPEC5fpiR6TQ5sogg8HuBrX
	 S3AzDVQ/fYTKaOx39JKhMEP6EHQBCA6YoPE5BdtzgS8NQ9COfJDNu+jZfMT4s6G43S
	 grfZr695V68+ozZLQNF91z+YPi2gF9Bu8rdoGmc57xgelE1U4ZG2bKBDdobdLskL98
	 yG91rOU3fixBLAr41V+eI8DHmMD7aqzHyDbcqPpxoMEWbhlc2yASnOjXxe10NCqCAK
	 2DNH80RQf/4nYzEt370ZTMJaFStH9fr+MjiBisJuVSaY5RO0fYT2PIuEiH9Z+Ycgrr
	 m/xgFKQeneE0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BA6C3DA42;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 08 Jul 2024 14:43:22 +0100
Subject: [PATCH kmod v2 14/17] man: modprobe: remove hard-coded
 /etc/modprobe.d references
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-man-v2-14-a23df6ef871e@gmail.com>
References: <20240708-man-v2-0-a23df6ef871e@gmail.com>
In-Reply-To: <20240708-man-v2-0-a23df6ef871e@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720446209; l=1742;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=4Ot9HoVqNcls9UI9Ao/pslii9zendemKxXz6i/+PB4w=;
 b=WdqfTupU3zFd1QfOy+k8MrAzeoAjPG82PP7zhOiAxzlBJiO8iZJzrRuIqNAehC+0YOEYKRVQD
 mlqpO+x+d7nBWhyXsgY4M1iyTiDbEkDQaAxaJCP4pTcDRqc3Bvy1BwF
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

Point the users to modprobe.d(5) instead.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 man/modprobe.8.scd | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/man/modprobe.8.scd b/man/modprobe.8.scd
index 321fa59..30ccc21 100644
--- a/man/modprobe.8.scd
+++ b/man/modprobe.8.scd
@@ -21,10 +21,9 @@ modprobe - Add and remove modules from the Linux Kernel
 that for convenience, there is no difference between \_ and - in module names
 (automatic underscore conversion is performed). *modprobe* looks in the module
 directory @DISTCONFDIR@/`uname -r` for all the modules and other files, except
-for the optional configuration files in the /etc/modprobe.d directory (see
-*modprobe.d*(5)). *modprobe* will also use module options specified on the
-kernel command line in the form of <module>.<option> and blacklists in the form
-of modprobe.blacklist=<module>.
+for the optional configuration files (see *modprobe.d*(5)). *modprobe* will also
+use module options specified on the kernel command line in the form of
+<module>.<option> and blacklists in the form of modprobe.blacklist=<module>.
 
 Note that unlike in 2.4 series Linux kernels (which are not supported by this
 tool) this version of *modprobe* does not do anything to the module itself: the
@@ -56,8 +55,8 @@ database.
 	by *udev*(7).
 
 *-C* _directory_, *--config* _directory_
-	This option overrides the default configuration directory
-	(/etc/modprobe.d).
+	This option overrides the default configuration directory. See
+	*modprobe.d*(5).
 
 	This option is passed through *install* or *remove* commands to other
 	*modprobe* commands in the MODPROBE_OPTIONS environment variable.

-- 
2.45.2


