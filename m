Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Michal Marek <mmarek@suse.cz>
To: Jon Masters <jcm@redhat.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] depmod: Handle X.Y kernel versions
Date: Mon, 30 May 2011 15:58:43 +0200
Message-Id: <1306763923-11892-1-git-send-email-mmarek@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

What a stupid check.

Signed-off-by: Michal Marek <mmarek@suse.cz>
---

Jon, could you please apply this patch and release a new
module-init-tools?  Depmod otherwise fails when building a kernel with
version 3.0 (without the third number).

Linus, I'm affraid this ruins the plan for Linux 3.0. Except if you want
to force users to upgrade module-init-tools, with the excuse that 3.0
is a huge step forward and breakage has to be expected ;-).

Michal
---
 depmod.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/depmod.c b/depmod.c
index abfb11e..98a5efa 100644
--- a/depmod.c
+++ b/depmod.c
@@ -247,7 +247,7 @@ static int is_version_number(const char *version)
 {
 	unsigned int dummy;
 
-	return (sscanf(version, "%u.%u.%u", &dummy, &dummy, &dummy) == 3);
+	return (sscanf(version, "%u.%u", &dummy, &dummy) == 2);
 }
 
 static int old_module_version(const char *version)
-- 
1.7.4.1

