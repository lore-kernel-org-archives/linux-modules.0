Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:42124 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756140AbbBIXPc (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 9 Feb 2015 18:15:32 -0500
From: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
To: <linux-modules@vger.kernel.org>
Subject: [PATCH 1/2] tools: normalize usage messages
Date: Mon, 9 Feb 2015 21:15:12 -0200
Message-ID: <1423523713-3595-1-git-send-email-caio.oliveira@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>

Normalize to use program_invocation_short_name. Also make the
usage command correct for 'kmod list'.
---
 tools/kmod.c  | 11 ++++++++---
 tools/kmod.h  |  2 ++
 tools/lsmod.c |  3 ++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/kmod.c b/tools/kmod.c
index 8ae1d86..521c2b9 100644
--- a/tools/kmod.c
+++ b/tools/kmod.c
@@ -63,7 +63,7 @@ static int kmod_help(int argc, char *argv[])
 			"Options:\n"
 			"\t-V, --version     show version\n"
 			"\t-h, --help        show this help\n\n"
-			"Commands:\n", basename(argv[0]));
+			"Commands:\n", program_invocation_short_name);
 
 	for (i = 0; i < ARRAY_SIZE(kmod_cmds); i++) {
 		if (kmod_cmds[i]->help != NULL) {
@@ -150,7 +150,7 @@ static int handle_kmod_compat_commands(int argc, char *argv[])
 	const char *cmd;
 	size_t i;
 
-	cmd = basename(argv[0]);
+	cmd = program_invocation_short_name;
 
 	for (i = 0; i < ARRAY_SIZE(kmod_compat_cmds); i++) {
 		if (streq(kmod_compat_cmds[i]->name, cmd))
@@ -160,11 +160,16 @@ static int handle_kmod_compat_commands(int argc, char *argv[])
 	return -ENOENT;
 }
 
+bool is_kmod_cmd(void)
+{
+	return streq(program_invocation_short_name, "kmod");
+}
+
 int main(int argc, char *argv[])
 {
 	int err;
 
-	if (streq(program_invocation_short_name, "kmod"))
+	if (is_kmod_cmd())
 		err = handle_kmod_commands(argc, argv);
 	else
 		err = handle_kmod_compat_commands(argc, argv);
diff --git a/tools/kmod.h b/tools/kmod.h
index 50adda4..71bc0c1 100644
--- a/tools/kmod.h
+++ b/tools/kmod.h
@@ -27,6 +27,8 @@ struct kmod_cmd {
 	const char *help;
 };
 
+bool is_kmod_cmd(void);
+
 extern const struct kmod_cmd kmod_cmd_compat_lsmod;
 extern const struct kmod_cmd kmod_cmd_compat_rmmod;
 extern const struct kmod_cmd kmod_cmd_compat_insmod;
diff --git a/tools/lsmod.c b/tools/lsmod.c
index e953c7e..5eb6f25 100644
--- a/tools/lsmod.c
+++ b/tools/lsmod.c
@@ -36,7 +36,8 @@ static int do_lsmod(int argc, char *argv[])
 	int err;
 
 	if (argc != 1) {
-		fprintf(stderr, "Usage: %s\n", argv[0]);
+		fprintf(stderr, "Usage: %s%s\n", program_invocation_short_name,
+			is_kmod_cmd() ? " list" : "");
 		return EXIT_FAILURE;
 	}
 
-- 
2.2.2

