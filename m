Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C787013B285
	for <linux-modules@vger.kernel.org>; Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446212; cv=none; b=SuJcKs8ExXjlSUikEzSmnJONrmJJiwPvyV0HQLAQTVqzfpWT1FJ5+rRchakTFCEjZ/QXtmmUIMHTIduNH+CueLjsMgFArzA1QUBObj1tcVPjYQWsTA+JRXWv7NFiVjzKsMdEKOxb10X6Cq+CJdfsEJfmqKyjHb4O82ihCszVSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446212; c=relaxed/simple;
	bh=quS8bANhyitWHIC44AAk6WJ/2HrclnmFVJoKvyE2VsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZFJOSDq9uDURfjzEo3xZdk7JozqZ1lB2iwv1NtpwP14Lu78c12zyz9iDvM1ppWP05GeuiIG6zqUD3e8kEqZRtYrqBWvAfEqe61f9DIJU+SrV9QM5EwLXDkh2USPOHRoj7xgxLbE14OuIy+4RYWv4ugy00/i61b4k7l5Ym9oZXF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxkZDquc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxkZDquc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC6C1C4AF15;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446212;
	bh=quS8bANhyitWHIC44AAk6WJ/2HrclnmFVJoKvyE2VsI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bxkZDquc+cotx1o+cPHPCJru+QfcS0J/OIX/+c/HsZh0/gEHirtzXZlyLvd5l+rH1
	 +23z2QWTQGNQ2ZlYHjZWIzCp9S5xM0eurLUVz6qgK5R8hh5kx7GSyAKN0qyIBQkFS9
	 SN+zdrewQSuC8Yr2UkpMjYg9Es/mw8qwrnpbgpVE/BfVa7ZeBDaWwbwM6R6igVeA8X
	 ei0b2l5kReVe5iES+loNXi4KjWuokc9lJCpr/oovH+Gcs3qeJQfwvTLVMDPRd9b9Ak
	 Hj9EYUSAYvsCwpQ9E2Cg8JNosI5oyjSjSvU1DHBSccpxQ35Cfl7g56vkaog4J9kJ8u
	 GcL2B2eHFMZng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E42C3DA42;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 08 Jul 2024 14:43:24 +0100
Subject: [PATCH kmod v2 16/17] man: rework AUTHORS section
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-man-v2-16-a23df6ef871e@gmail.com>
References: <20240708-man-v2-0-a23df6ef871e@gmail.com>
In-Reply-To: <20240708-man-v2-0-a23df6ef871e@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720446209; l=8323;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=ie6KjBcte87GHOjasXb7TRphJJLk34KDZ1vef6yDI/s=;
 b=dOZNmH8IhXHjjc0rfLqzN080F+FQzWVwA0Ez207C42ePMAX92dzGaTI1VBtHxpASrjXOBCcC1
 RoGF320Rla0BkyMFMx7hhjdAsXJNhYWirxRuijGjBDqXOH3DrMZjSTd
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

Replace the partial listing with suggestion to check through git
shortlog and git blame.

Explicitly spell out the current maintainer, alongside giving Jon
attribution for the original project.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 man/depmod.8.scd      | 13 ++++++-------
 man/depmod.d.5.scd    | 13 ++++++-------
 man/insmod.8.scd      | 10 ++++++----
 man/kmod.8.scd        | 13 +++++++++++--
 man/lsmod.8.scd       | 10 ++++++----
 man/modinfo.8.scd     | 10 ++++++----
 man/modprobe.8.scd    | 13 ++++++-------
 man/modprobe.d.5.scd  | 13 ++++++-------
 man/modules.dep.5.scd | 10 ++++++----
 man/rmmod.8.scd       | 10 ++++++----
 10 files changed, 65 insertions(+), 50 deletions(-)

diff --git a/man/depmod.8.scd b/man/depmod.8.scd
index 0252a72..76d4fa8 100644
--- a/man/depmod.8.scd
+++ b/man/depmod.8.scd
@@ -116,11 +116,10 @@ Portions Copyright Jon Masters, and others.
 
 # AUTHORS
 
-*Jon Masters* <jcm@jonmasters.org>
-	Developer
+Numerous contributions have come from the linux-modules mailing list
+<linux-modules@vger.kernel.org> and Github. If you have a clone of kmod.git
+itself, the output of *git-shortlog*(1) and *git-blame*(1) can show you the
+authors for specific parts of the project.
 
-*Robby Workman* <rworkman@slackware.com>
-	Developer
-
-*Lucas De Marchi* <lucas.de.marchi@gmail.com>
-	Developer
+*Lucas De Marchi* <lucas.de.marchi@gmail.com> is the current maintainer of the
+project.
diff --git a/man/depmod.d.5.scd b/man/depmod.d.5.scd
index dc13ec7..ec1b032 100644
--- a/man/depmod.d.5.scd
+++ b/man/depmod.d.5.scd
@@ -103,11 +103,10 @@ This manual page Copyright 2006-2010, Jon Masters, Red Hat, Inc.
 
 # AUTHORS
 
-*Jon Masters* <jcm@jonmasters.org>
-	Developer
+Numerous contributions have come from the linux-modules mailing list
+<linux-modules@vger.kernel.org> and Github. If you have a clone of kmod.git
+itself, the output of *git-shortlog*(1) and *git-blame*(1) can show you the
+authors for specific parts of the project.
 
-*Robby Workman* <rworkman@slackware.com>
-	Developer
-
-*Lucas De Marchi* <lucas.de.marchi@gmail.com>
-	Developer
+*Lucas De Marchi* <lucas.de.marchi@gmail.com> is the current maintainer of the
+project.
diff --git a/man/insmod.8.scd b/man/insmod.8.scd
index 27d4409..137830f 100644
--- a/man/insmod.8.scd
+++ b/man/insmod.8.scd
@@ -28,8 +28,10 @@ This manual page originally Copyright 2002, Rusty Russell, IBM Corporation.
 
 # AUTHORS
 
-*Jon Masters* <jcm@jonmasters.org>
-	Developer
+Numerous contributions have come from the linux-modules mailing list
+<linux-modules@vger.kernel.org> and Github. If you have a clone of kmod.git
+itself, the output of *git-shortlog*(1) and *git-blame*(1) can show you the
+authors for specific parts of the project.
 
-*Lucas De Marchi* <lucas.de.marchi@gmail.com>
-	Developer
+*Lucas De Marchi* <lucas.de.marchi@gmail.com> is the current maintainer of the
+project.
diff --git a/man/kmod.8.scd b/man/kmod.8.scd
index 6bd9432..2294591 100644
--- a/man/kmod.8.scd
+++ b/man/kmod.8.scd
@@ -43,5 +43,14 @@ This manual page originally Copyright 2014, Marco d'Itri.
 
 # AUTHOR
 
-*Lucas De Marchi* <lucas.de.marchi@gmail.com>
-	Developer
+*kmod* project was started by Lucas De Marchi as a drop-in replacement to
+module-init-tools that was maintained by Jon Masters, adding a library (libkmod)
+and additional features.
+
+Numerous contributions have come from the linux-modules mailing list
+<linux-modules@vger.kernel.org> and Github. If you have a clone of kmod.git
+itself, the output of *git-shortlog*(1) and *git-blame*(1) can show you the
+authors for specific parts of the project.
+
+*Lucas De Marchi* <lucas.de.marchi@gmail.com> is the current maintainer of the
+project.
diff --git a/man/lsmod.8.scd b/man/lsmod.8.scd
index ded619e..d81cce2 100644
--- a/man/lsmod.8.scd
+++ b/man/lsmod.8.scd
@@ -22,8 +22,10 @@ This manual page originally Copyright 2002, Rusty Russell, IBM Corporation.
 
 # AUTHORS
 
-*Jon Masters* <jcm@jonmasters.org>
-	Developer
+Numerous contributions have come from the linux-modules mailing list
+<linux-modules@vger.kernel.org> and Github. If you have a clone of kmod.git
+itself, the output of *git-shortlog*(1) and *git-blame*(1) can show you the
+authors for specific parts of the project.
 
-*Lucas De Marchi* <lucas.de.marchi@gmail.com>
-	Developer
+*Lucas De Marchi* <lucas.de.marchi@gmail.com> is the current maintainer of the
+project.
diff --git a/man/modinfo.8.scd b/man/modinfo.8.scd
index d088c7e..7511798 100644
--- a/man/modinfo.8.scd
+++ b/man/modinfo.8.scd
@@ -70,8 +70,10 @@ This manual page originally Copyright 2003, Rusty Russell, IBM Corporation.
 
 # AUTHORS
 
-*Jon Masters* <jcm@jonmasters.org>
-	Developer
+Numerous contributions have come from the linux-modules mailing list
+<linux-modules@vger.kernel.org> and Github. If you have a clone of kmod.git
+itself, the output of *git-shortlog*(1) and *git-blame*(1) can show you the
+authors for specific parts of the project.
 
-*Lucas De Marchi* <lucas.de.marchi@gmail.com>
-	Developer
+*Lucas De Marchi* <lucas.de.marchi@gmail.com> is the current maintainer of the
+project.
diff --git a/man/modprobe.8.scd b/man/modprobe.8.scd
index 67cbb1a..85d47fa 100644
--- a/man/modprobe.8.scd
+++ b/man/modprobe.8.scd
@@ -208,11 +208,10 @@ This manual page originally Copyright 2002, Rusty Russell, IBM Corporation.
 
 # AUTHORS
 
-*Jon Masters* <jcm@jonmasters.org>
-	Developer
+Numerous contributions have come from the linux-modules mailing list
+<linux-modules@vger.kernel.org> and Github. If you have a clone of kmod.git
+itself, the output of *git-shortlog*(1) and *git-blame*(1) can show you the
+authors for specific parts of the project.
 
-*Robby Workman* <rworkman@slackware.com>
-	Developer
-
-*Lucas De Marchi* <lucas.de.marchi@gmail.com>
-	Developer
+*Lucas De Marchi* <lucas.de.marchi@gmail.com> is the current maintainer of the
+project.
diff --git a/man/modprobe.d.5.scd b/man/modprobe.d.5.scd
index 246457b..e6e9c51 100644
--- a/man/modprobe.d.5.scd
+++ b/man/modprobe.d.5.scd
@@ -174,11 +174,10 @@ This manual page originally Copyright 2004, Rusty Russell, IBM Corporation.
 
 # AUTHORS
 
-*Jon Masters* <jcm@jonmasters.org>
-	Developer
+Numerous contributions have come from the linux-modules mailing list
+<linux-modules@vger.kernel.org> and Github. If you have a clone of kmod.git
+itself, the output of *git-shortlog*(1) and *git-blame*(1) can show you the
+authors for specific parts of the project.
 
-*Robby Workman* <rworkman@slackware.com>
-	Developer
-
-*Lucas De Marchi* <lucas.de.marchi@gmail.com>
-	Developer
+*Lucas De Marchi* <lucas.de.marchi@gmail.com> is the current maintainer of the
+project.
diff --git a/man/modules.dep.5.scd b/man/modules.dep.5.scd
index 7723a16..7c68ab9 100644
--- a/man/modules.dep.5.scd
+++ b/man/modules.dep.5.scd
@@ -36,8 +36,10 @@ This manual page originally Copyright 2002, Rusty Russell, IBM Corporation.
 
 # AUTHORS
 
-*Jon Masters* <jcm@jonmasters.org>
-	Developer
+Numerous contributions have come from the linux-modules mailing list
+<linux-modules@vger.kernel.org> and Github. If you have a clone of kmod.git
+itself, the output of *git-shortlog*(1) and *git-blame*(1) can show you the
+authors for specific parts of the project.
 
-*Lucas De Marchi* <lucas.de.marchi@gmail.com>
-	Developer
+*Lucas De Marchi* <lucas.de.marchi@gmail.com> is the current maintainer of the
+project.
diff --git a/man/rmmod.8.scd b/man/rmmod.8.scd
index c4dcc3e..cf55478 100644
--- a/man/rmmod.8.scd
+++ b/man/rmmod.8.scd
@@ -42,8 +42,10 @@ This manual page originally Copyright 2002, Rusty Russell, IBM Corporation.
 
 # AUTHORS
 
-*Jon Masters* <jcm@jonmasters.org>
-	Developer
+Numerous contributions have come from the linux-modules mailing list
+<linux-modules@vger.kernel.org> and Github. If you have a clone of kmod.git
+itself, the output of *git-shortlog*(1) and *git-blame*(1) can show you the
+authors for specific parts of the project.
 
-*Lucas De Marchi* <lucas.de.marchi@gmail.com>
-	Developer
+*Lucas De Marchi* <lucas.de.marchi@gmail.com> is the current maintainer of the
+project.

-- 
2.45.2


