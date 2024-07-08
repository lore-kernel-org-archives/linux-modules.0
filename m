Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86941386A7
	for <linux-modules@vger.kernel.org>; Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446212; cv=none; b=ubbRpfUCqU4O136v4sO46Nie1Mxo+UDelMHFgC3vI5xYiBOi69SqricxcAxub3NN4zu7bDP8+GKcjy5YYt9kBh++VvllFA2PXHA1cit8QGXtWtTytU3uyTwybNQl5DmWGWiOQOp+uSoI/jmal/GjPXkxQ96Hm8VEURn5v7WomLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446212; c=relaxed/simple;
	bh=qA+xrWzdXmexhgbqdl39T3PvOLtTamKAIdT4Tuq4pBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AZTHl+sR0aaZNj2glXKxhCB/NqCR9I8v9vOSSeGQopJ7ou0yhtVhOpGCPdqugGtY5/JW6U3DvGhOrf291WmQXJuqjPxFPI6Y/9VARn2gCaGlN6VuEh7KSW337nW0S2psR4v+KeV/6nBufnnVg9osojW4HoFUNW0V3j8y7gXuZu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8GdP697; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8GdP697"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A8EBC4AF14;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446212;
	bh=qA+xrWzdXmexhgbqdl39T3PvOLtTamKAIdT4Tuq4pBg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=u8GdP697eCwziA80qoGZEWkF6lui1jlENaMs9m0YGipPTzO4q0GDMb8Ry2Y1xjVck
	 vQlUCGFFYjn+1gPabUAeWgt3alJ2Z1dJ+blNqu79IKL6AekLfvLF8JzVsuoh4BY0P3
	 hdr7Ur97w8CGJmCq9VWBZ4bFhgycINHD/UkFg/BlD/84kLussWuyHTNN6gt8t05sp4
	 mRGk6WahgyuBrYmGHCgrWtzt1SE1F1Y2uYMboPEmdGnUs/vnzC9/v/jbJDH28QgScF
	 7nXYlpVHAvvUOx6uZ5wEvfkGX64A90hIykFA2B/zM3pNzE6uP7YyaRkXCS0/DS1rIX
	 LP2re5E3gxE5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6226EC3DA42;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 08 Jul 2024 14:43:19 +0100
Subject: [PATCH kmod v2 11/17] man: modprobe.d: document the config file
 order handling
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-man-v2-11-a23df6ef871e@gmail.com>
References: <20240708-man-v2-0-a23df6ef871e@gmail.com>
In-Reply-To: <20240708-man-v2-0-a23df6ef871e@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720446209; l=2855;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=sHnxPSEDp+jGz2aoQmjrQ0qwAhdHkK+ahhBrcRC6veE=;
 b=JSrSnWWN4TSL2Gkcoyv+qGiihcr0kvtScdrOpyS2VpmNqdkvMTVwaB2QZ7RuJBOmaVrzhYJFZ
 nvOPXvKJT7TBjYdykQ6Uf9IbMxHd4nT8gaXbQAllLmaMkvdDNCv2oZU
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

Section is inspired by sysctl.d(5) and sysctl(8).

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
v2: Reword as per Lucas' suggestion.
---
 man/modprobe.d.5.scd | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/man/modprobe.d.5.scd b/man/modprobe.d.5.scd
index 2907175..2a6a789 100644
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
@@ -35,6 +34,18 @@ lines and lines starting with '#' ignored (useful for adding comments). A '\\'
 at the end of a line causes it to continue on the next line, which makes the
 file a bit neater.
 
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
 
 alias _wildcard_ _modulename_

-- 
2.45.2


