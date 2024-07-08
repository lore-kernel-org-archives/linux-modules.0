Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A9D13AD13
	for <linux-modules@vger.kernel.org>; Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446212; cv=none; b=ck2RhAw36cvhTNqxcDx1dcutUtQoBv+/RUZu5ZSkBjaowzOAaNnSh7ZUy0oO8VB+yUyBghR9qXID39fLtoL/cbmS18cAr9Afyv88wVZ6lCvNNvq+XBx8Bx7fOAxW7xQKWxVASzWYkgav833L4fFlRyFrKBJjnykw9rzRPV+PkLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446212; c=relaxed/simple;
	bh=LegAMxAgZELtlXqy+NE+bYXjOkGaB5hbQ3luuzu5jhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vt5N43fh5GZS8IyIiGFK1LTXobxNSlGDMLYnwx5Uqcoy9JkkCg2mIqAYjnQ8MNp0d33NwlU1yJky6Blu1wr3ajBkjwA5wBY7GumHTghPltqj4QZBgA4C6NjLcqNaH7yywE+d2iaOinX1AdEcS6nW/FiFZgFUcNeTy55+kG4uvtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuPrBNXl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuPrBNXl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BF6CC4AF16;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446212;
	bh=LegAMxAgZELtlXqy+NE+bYXjOkGaB5hbQ3luuzu5jhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CuPrBNXl6L0rs5So9UqjIqG5Zk4mqHdjuhK9FOY29nNwtVkw77P5DTfVnwdj//0z+
	 D43UbU2xweaVO4wg8k5FxssBZQXUl0yJV/4qdWyEXMytwmIRINZILCFuQMQNdUUbDB
	 15R7H2T+Fwr72KE7gd4h7Z2iHnVrOhCRZ0vj8RLw8GUHzaYjyj3l8EFfDTnVNb/CC+
	 Z1IqszB+kMiP7U+1eexC4NQ+wxXByrROl2l7fZwCHq4YqcEH0Q7ypaGi4LvjvDC3np
	 aK7FIv26yFNnyA1xFT+NewneD+3Go43h7/WORP0g7xLbdCzrRauWqYsA2nivN1p95/
	 BQPFdgLGmi/Pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D8BC3DA47;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 08 Jul 2024 14:43:23 +0100
Subject: [PATCH kmod v2 15/17] man: remove the "Maintained by" references
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-man-v2-15-a23df6ef871e@gmail.com>
References: <20240708-man-v2-0-a23df6ef871e@gmail.com>
In-Reply-To: <20240708-man-v2-0-a23df6ef871e@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720446209; l=3766;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=oazsCu1x5cpTjLe811bZRP1oyu3WkDozVetIymM8AT0=;
 b=ThGjE1GWa8Iw/bD5WDDOlIsR5iHEjAp5Nz93qqh1qzn3n/9GOR80t2QkldWaB4fVlezYm3SKO
 9KuqrYaX+9HC7dtFabdVUKH4J8+MBDb+vX8aunSVCRF98F83bLv0Dmn
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

At a glance through my system, around 2% of the man pages include such
statement.

Looking through git log, Jon has been active in a while and presumably
have moved on.

Most importantly the Copyright section isn't the best place to reference
the maintainer/contact person.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
Instead we can add a note in the authors section, pointing people to the
ML/kernel.org/Github repo for when seeking contact.

Also should probably s/Developer/Maintainer/ for Lucas, who's been
keeping the project afloat the last few decades ;-)

Lucas, what do you think?
---
 man/insmod.8.scd      | 1 -
 man/kmod.8.scd        | 3 +--
 man/lsmod.8.scd       | 1 -
 man/modinfo.8.scd     | 1 -
 man/modprobe.8.scd    | 1 -
 man/modprobe.d.5.scd  | 1 -
 man/modules.dep.5.scd | 1 -
 man/rmmod.8.scd       | 1 -
 8 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/man/insmod.8.scd b/man/insmod.8.scd
index b6f8654..27d4409 100644
--- a/man/insmod.8.scd
+++ b/man/insmod.8.scd
@@ -21,7 +21,6 @@ information about errors.
 # COPYRIGHT
 
 This manual page originally Copyright 2002, Rusty Russell, IBM Corporation.
-Maintained by Jon Masters and others.
 
 # SEE ALSO
 
diff --git a/man/kmod.8.scd b/man/kmod.8.scd
index 2007a2d..6bd9432 100644
--- a/man/kmod.8.scd
+++ b/man/kmod.8.scd
@@ -35,8 +35,7 @@ Linux Kernel modules. Most users will only run it using its other names.
 
 # COPYRIGHT
 
-This manual page originally Copyright 2014, Marco d'Itri. Maintained by Lucas De
-Marchi and others.
+This manual page originally Copyright 2014, Marco d'Itri.
 
 # SEE ALSO
 
diff --git a/man/lsmod.8.scd b/man/lsmod.8.scd
index eb2f2e8..ded619e 100644
--- a/man/lsmod.8.scd
+++ b/man/lsmod.8.scd
@@ -15,7 +15,6 @@ lsmod - Show the status of modules in the Linux Kernel
 # COPYRIGHT
 
 This manual page originally Copyright 2002, Rusty Russell, IBM Corporation.
-Maintained by Jon Masters and others.
 
 # SEE ALSO
 
diff --git a/man/modinfo.8.scd b/man/modinfo.8.scd
index 9545257..d088c7e 100644
--- a/man/modinfo.8.scd
+++ b/man/modinfo.8.scd
@@ -63,7 +63,6 @@ architecture.
 # COPYRIGHT
 
 This manual page originally Copyright 2003, Rusty Russell, IBM Corporation.
-Maintained by Jon Masters and others.
 
 # SEE ALSO
 
diff --git a/man/modprobe.8.scd b/man/modprobe.8.scd
index 30ccc21..67cbb1a 100644
--- a/man/modprobe.8.scd
+++ b/man/modprobe.8.scd
@@ -201,7 +201,6 @@ rules.
 # COPYRIGHT
 
 This manual page originally Copyright 2002, Rusty Russell, IBM Corporation.
-Maintained by Jon Masters and others.
 
 # SEE ALSO
 
diff --git a/man/modprobe.d.5.scd b/man/modprobe.d.5.scd
index b7b1942..246457b 100644
--- a/man/modprobe.d.5.scd
+++ b/man/modprobe.d.5.scd
@@ -167,7 +167,6 @@ directly within the modules.
 # COPYRIGHT
 
 This manual page originally Copyright 2004, Rusty Russell, IBM Corporation.
-Maintained by Jon Masters and others.
 
 # SEE ALSO
 
diff --git a/man/modules.dep.5.scd b/man/modules.dep.5.scd
index c4e7653..7723a16 100644
--- a/man/modules.dep.5.scd
+++ b/man/modules.dep.5.scd
@@ -29,7 +29,6 @@ fashion rather than touching these files.
 # COPYRIGHT
 
 This manual page originally Copyright 2002, Rusty Russell, IBM Corporation.
-Maintained by Jon Masters and others.
 
 # SEE ALSO
 
diff --git a/man/rmmod.8.scd b/man/rmmod.8.scd
index e1f656f..c4dcc3e 100644
--- a/man/rmmod.8.scd
+++ b/man/rmmod.8.scd
@@ -35,7 +35,6 @@ is provided) from the kernel. Most users will want to use *modprobe*(8) with the
 # COPYRIGHT
 
 This manual page originally Copyright 2002, Rusty Russell, IBM Corporation.
-Maintained by Jon Masters and others.
 
 # SEE ALSO
 

-- 
2.45.2


