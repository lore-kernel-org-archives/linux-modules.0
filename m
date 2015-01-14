Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31049 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753206AbbANOJ1 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Wed, 14 Jan 2015 09:09:27 -0500
From: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
To: <linux-modules@vger.kernel.org>
Subject: [PATCH] tools: kmod: break iteration once a command is executed
Date: Wed, 14 Jan 2015 12:02:16 -0200
Message-ID: <1421244136-14606-1-git-send-email-caio.oliveira@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

---
 tools/kmod.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/kmod.c b/tools/kmod.c
index abb1707..a8534cd 100644
--- a/tools/kmod.c
+++ b/tools/kmod.c
@@ -124,10 +124,10 @@ static int handle_kmod_commands(int argc, char *argv[])
 	cmd = argv[optind];
 
 	for (i = 0, err = -EINVAL; i < ARRAY_SIZE(kmod_cmds); i++) {
-		if (strcmp(kmod_cmds[i]->name, cmd) != 0)
-			continue;
-
-		err = kmod_cmds[i]->cmd(--argc, ++argv);
+		if (strcmp(kmod_cmds[i]->name, cmd) == 0) {
+			err = kmod_cmds[i]->cmd(--argc, ++argv);
+			break;
+		}
 	}
 
 	if (err < 0) {
-- 
2.2.1

