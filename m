Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5674B1386BF
	for <linux-modules@vger.kernel.org>; Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446212; cv=none; b=eDot9c7imeFx3P7IAgdcJ0qNIOKkIqdWPV7sS9Q++DiN4vhLuh95S/na/owM32b0cdedaDzHKhCPT/Jve95CCpa45lFKw5KQXBXlxOMKMusdJonO4ot4M+BowlfdsSGskrdTwZAjURreNvo9OWzkyRHQzdwIlHl7k//bFZ5mTfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446212; c=relaxed/simple;
	bh=Xa1Kg8+8T35bZndd2R9xxn8nZwRZ3Sry+KmDXBNXD68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O+laEQ1jZGcpibP1eflW7NWosEComJ8IVOhKZGOeZB1EGBAk6T9xeNH2/Ce5/q3OaeVDn+GJi+A319VLKhbPp66kvZw1tPCrlH7P0v132+XItB7WeyiA0Ady216BHsMVvQIri7tNRBi7W/LAkP59ys9A2RI3GhVeSw8TQtR2a28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7pCvbYR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7pCvbYR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18268C4AF0C;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446212;
	bh=Xa1Kg8+8T35bZndd2R9xxn8nZwRZ3Sry+KmDXBNXD68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=U7pCvbYRIWYYnfKkq97e+7JOE0V3V7R+fj0MZXdFN4eWvln4p5CsOi9bpbQw9ImVM
	 PTkH0YdX2LtmMllguVJC5QwXjOpmb8kxcx8kDS+9TZlZnLKG8bTUEIXeNi+4nUYdNM
	 mguLvnJUNQJn42E7fJzXJ5ZDMyV3q4oW3s1CA7ZLqycMKxZf3wh0lc9srqYZ70SNpN
	 KVtn2hGk9lfs0GFmOE22/aWIhOGe8YLqrH5OekO3TSijZ7+kQjFOXivWzwOX7LGUVq
	 ufIDQBujqpa2fAtUtwr4DmnvgYirczyLY8gN+m6FrhWIvXRPAYmVpcGa4DjwgxsK6m
	 C/3R8ohBX+Tcw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12849C3DA42;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 08 Jul 2024 14:43:12 +0100
Subject: [PATCH kmod v2 04/17] man: some options take an argument, mention
 that
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-man-v2-4-a23df6ef871e@gmail.com>
References: <20240708-man-v2-0-a23df6ef871e@gmail.com>
In-Reply-To: <20240708-man-v2-0-a23df6ef871e@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720446209; l=3010;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=4nifnH+aFZgDG/0iYx0jvMq7OJ9mzuQHKrnYYQU00gI=;
 b=gdwivDCnk3BmhDSRsr8LGrCcGF0bTox0fmG7ry8Nm4a3RBQhpWPQELzeKTueUq9k8lnkpcclF
 VWfzuX4hgQSBICz+syn4E+ox/uHT7JTOBvtvm/o1h7iuQER60BgBfG0
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

For example modinfo -F requires the field name, although the
documentation was missing the "field".

Similarly modprobe has omissions, so let's fix those as well.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
There are two different styles across the man pages:
 -s, --short foo
 -s foo, --short foo

A proposal to resolve these comes with a later patch in this series.
---
 man/depmod.8.scd   | 2 +-
 man/modinfo.8.scd  | 4 ++--
 man/modprobe.8.scd | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/man/depmod.8.scd b/man/depmod.8.scd
index 80cc48d..7a2e84b 100644
--- a/man/depmod.8.scd
+++ b/man/depmod.8.scd
@@ -72,7 +72,7 @@ rather than the current kernel version (as returned by *uname -r*).
 	assumption can break especially when additionally updated third party
 	drivers are not correctly installed or were built incorrectly.
 
-*-E*, *--symvers*
+*-E*, *--symvers* _Module.symvers_
 	When combined with the *-e* option, this reports any symbol versions
 	supplied by modules that do not match with the symbol versions provided
 	by the kernel in its _Module.symvers_. This option is mutually
diff --git a/man/modinfo.8.scd b/man/modinfo.8.scd
index 75267bc..9545257 100644
--- a/man/modinfo.8.scd
+++ b/man/modinfo.8.scd
@@ -31,8 +31,8 @@ architecture.
 *-V*, *--version*
 	Print the *modinfo* version.
 
-*-F*, *--field*
-	Only print this field value, one per line. This is most useful for
+*-F* _field_, *--field* _field_
+	Only print this _field_ value, one per line. This is most useful for
 	scripts. Field names are case-insensitive. Common fields (which may not
 	be in every module) include author, description, license, parm, depends,
 	and alias. There are often multiple parm, alias and depends fields. The
diff --git a/man/modprobe.8.scd b/man/modprobe.8.scd
index f4ce0be..9594798 100644
--- a/man/modprobe.8.scd
+++ b/man/modprobe.8.scd
@@ -55,7 +55,7 @@ database.
 	configuration files (if any) to module names as well. It is usually used
 	by *udev*(7).
 
-*-C*, *--config*
+*-C* _directory_, *--config* _directory_
 	This option overrides the default configuration directory
 	(/etc/modprobe.d).
 
@@ -151,14 +151,14 @@ database.
 	require it. Your distribution kernel may not have been built to support
 	removal of modules at all.
 
-*-w*, *--wait=*TIMEOUT_MSEC
+*-w* _TIMEOUT_MSEC_, *--wait* _TIMEOUT_MSEC_
 	This option causes *modprobe -r *to continue trying to remove a module
 	if it fails due to the module being busy, i.e. its refcount is not 0 at
 	the time the call is made. Modprobe tries to remove the module with an
 	incremental sleep time between each tentative up until the maximum wait
 	time in milliseconds passed in this option.
 
-*-S*, *--set-version*
+*-S* _version_, *--set-version* _version_
 	Set the kernel version, rather than using *uname*(2) to decide on the
 	kernel version (which dictates where to find the modules).
 

-- 
2.45.2


