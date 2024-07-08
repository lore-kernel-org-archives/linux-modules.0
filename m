Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51928138490
	for <linux-modules@vger.kernel.org>; Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446212; cv=none; b=lV0CPO7A1E8LEwu4yvJtsKDxjXKnVFHvtyVVMhN1DfbksLbpqjfV0u7iEbrYIA4eOfPTeFlgVDvSS2mQ5FgFkBIthZMyTeyFbxI1qAw1l+5DuhOvLthTl8E+PSO0FDq1xqL08IIO/OpCWbGjZcWq27GWYzDWgXz62zON+hCVU4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446212; c=relaxed/simple;
	bh=Dcx2+Qk2wKMUUYbY/Sf26bruZ8ltBKwvtqILvDzkEcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V2l1AH4iMCBaeTDx1SNZMpYW6OL28lEf65CqcGEFscNJwk52zJWetDMPWyDow99eQbMrLAYgi+ts8ri5wLQQZ1N/gVonhIMgpcq+wGez47hfjGIXX/COrbzfjZyckawbkuboAyqd0jfQX4PkCALSNfoIlgpPANayZsYplEcQ+L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYUcINXo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYUcINXo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C01AC32786;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446212;
	bh=Dcx2+Qk2wKMUUYbY/Sf26bruZ8ltBKwvtqILvDzkEcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mYUcINXocvXHIh8ccLK+v+4sX+Tk0Rul1jvfEbKzTtjYwoASqw3DSfYu/314Qda7e
	 oFu4aHYUlhieAdXLiV+t7VzAMTMEyJZwapRDLXoMEerBFj59KA1fdkhGRslSE/84Yr
	 JfbHjDKlbHsoUoLBiV93zMEQSJx02C7wIl/QLfFcSBTC89gDCLgNAHpnp39zzroqLR
	 0k0i/KFHxgpYIyLj6lC5cAZQt8oTftYK81wzZFS8zcjq8F9FKN2ML2/TSaP56fJR8W
	 JeiuMw2rogYrhy2tfXseE1aJ6+CkwPEzgUMKD/21WJcJ0TzrZr8sSA3jUfy0OZrrmn
	 G8S0l2NGdWwXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F4FC3271E;
	Mon,  8 Jul 2024 13:43:31 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 08 Jul 2024 14:43:10 +0100
Subject: [PATCH kmod v2 02/17] man: white space fixes
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240708-man-v2-2-a23df6ef871e@gmail.com>
References: <20240708-man-v2-0-a23df6ef871e@gmail.com>
In-Reply-To: <20240708-man-v2-0-a23df6ef871e@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720446209; l=4925;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=FIuRVlV349zm6qJg/6cU04JoJxGlyJsKYzKRe2M51/A=;
 b=djL+v17757sgOhLq0cewdBxqCgEBSWgfo3VBXNS3uEORfeDNfiYCUUtK5aQ3woTPXS69yVDlW
 UGfifsF0cHdB61RkY/DL7YOqXZ0rQGUsL9W6UNX5NrqA9UGOi23n/BA
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

These were present in the original xml files and I opted to keep them
separate fix to make the transition/comparison easier.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
v2: drop unrelated bold annotation - move to previous patch
---
 man/depmod.8.scd     | 2 +-
 man/depmod.d.5.scd   | 2 +-
 man/modprobe.8.scd   | 8 ++++----
 man/modprobe.d.5.scd | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/man/depmod.8.scd b/man/depmod.8.scd
index 34c1313..80cc48d 100644
--- a/man/depmod.8.scd
+++ b/man/depmod.8.scd
@@ -55,7 +55,7 @@ rather than the current kernel version (as returned by *uname -r*).
 
 *-o* _outdir_, *--outdir* _outdir_
 	Set the output directory where *depmod* will store any generated file.
-	_ outdir_ serves as a root to that location, similar to how _basedir_ is
+	_outdir_ serves as a root to that location, similar to how _basedir_ is
 	used. Also this setting takes precedence and if used together with
 	_basedir_ it will result in the input being that directory, but the output
 	being the one set by _outdir_.
diff --git a/man/depmod.d.5.scd b/man/depmod.d.5.scd
index 9c42478..4e05b93 100644
--- a/man/depmod.d.5.scd
+++ b/man/depmod.d.5.scd
@@ -50,7 +50,7 @@ override _modulename_ _kernelversion_ _modulesubdirectory_
 	This command allows you to override which version of a specific module
 	will be used when more than one module sharing the same name is
 	processed by the *depmod* command. It is possible to specify one kernel
-	or all kernels using the \* wildcard. _ modulesubdirectory_ is the name
+	or all kernels using the \* wildcard. _modulesubdirectory_ is the name
 	of the subdirectory under @MODULE_DIRECTORY@ (or other module location)
 	where the target module is installed.
 
diff --git a/man/modprobe.8.scd b/man/modprobe.8.scd
index 653fbd9..aac3a74 100644
--- a/man/modprobe.8.scd
+++ b/man/modprobe.8.scd
@@ -6,7 +6,7 @@ modprobe - Add and remove modules from the Linux Kernel
 
 # SYNOPSIS
 
-*modprobe* [*-v*] [*-V*] [*-C *_config-file_] [*-n*] [*-i*] [*-q*] [*-b*] [_modulename_]
+*modprobe* [*-v*] [*-V*] [*-C* _config-file_] [*-n*] [*-i*] [*-q*] [*-b*] [_modulename_]
 \ \ \ \ \ \ \ \ \ \[_module parameters_...]
 
 *modprobe* [*-r*] [*-v*] [*-n*] [*-i*] [_modulename_...]
@@ -19,10 +19,10 @@ modprobe - Add and remove modules from the Linux Kernel
 
 *modprobe* intelligently adds or removes a module from the Linux kernel: note
 that for convenience, there is no difference between \_ and - in module names
-(automatic underscore conversion is performed). * modprobe* looks in the module
+(automatic underscore conversion is performed). *modprobe* looks in the module
 directory @DISTCONFDIR@/`uname -r` for all the modules and other files, except
 for the optional configuration files in the /etc/modprobe.d directory (see
-*modprobe.d*(5)). * modprobe* will also use module options specified on the
+*modprobe.d*(5)). *modprobe* will also use module options specified on the
 kernel command line in the form of <module>.<option> and blacklists in the form
 of modprobe.blacklist=<module>.
 
@@ -167,7 +167,7 @@ database.
 	itself. This produces a (possibly empty) set of module filenames, one
 	per line, each starting with "insmod" and is typically used by
 	distributions to determine which modules to include when generating
-	initrd/initramfs images. * Install* commands which apply are shown
+	initrd/initramfs images. *Install* commands which apply are shown
 	prefixed by "install". It does not run any of the install commands. Note
 	that *modinfo*(8) can be used to extract dependencies of a module from the
 	module itself, but knows nothing of aliases or install commands.
diff --git a/man/modprobe.d.5.scd b/man/modprobe.d.5.scd
index 93b9522..2907175 100644
--- a/man/modprobe.d.5.scd
+++ b/man/modprobe.d.5.scd
@@ -94,7 +94,7 @@ install _modulename_ _command..._
 options _modulename_ _option..._
 	This command allows you to add options to the module _modulename_ (which
 	might be an alias) every time it is inserted into the kernel: whether
-	directly (using *modprobe* _ modulename_) or because the module being
+	directly (using *modprobe* _modulename_) or because the module being
 	inserted depends on this module.
 
 	All options are added together: they can come from an *option* for the
@@ -106,7 +106,7 @@ remove _modulename_ _command..._
 
 softdep _modulename_ pre: _modules..._ post: _modules..._
 	The *softdep* command allows you to specify soft, or optional, module
-	dependencies. _ modulename_ can be used without these optional modules
+	dependencies. _modulename_ can be used without these optional modules
 	installed, but usually with some features missing. For example, a driver
 	for a storage HBA might require another module be loaded in order to use
 	management features.

-- 
2.45.2


