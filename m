Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:51949 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab3GNL4j (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Sun, 14 Jul 2013 07:56:39 -0400
Received: by mail-we0-f177.google.com with SMTP id m19so8969604wev.8
        for <linux-modules@vger.kernel.org>; Sun, 14 Jul 2013 04:56:38 -0700 (PDT)
From: Tom Gundersen <teg@jklm.no>
To: linux-modules@vger.kernel.org
Cc: Tom Gundersen <teg@jklm.no>
Subject: [PATCH 1/2] static-nodes: don't fail if modules.devname not found
Date: Sun, 14 Jul 2013 13:56:17 +0200
Message-Id: <1373802978-12456-1-git-send-email-teg@jklm.no>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

In containers/VM's/initrd one might not have installed any modules and accompanying modules.devname
Don't fail if this is the case, just warn.

When used in systemd this means we don't get a failing unit on booting containers.
---
 tools/static-nodes.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/tools/static-nodes.c b/tools/static-nodes.c
index 96bb71e..b4a3c08 100644
--- a/tools/static-nodes.c
+++ b/tools/static-nodes.c
@@ -155,6 +155,7 @@ static int do_static_nodes(int argc, char *argv[])
 {
 	struct utsname kernel;
 	char modules[PATH_MAX];
+	char output[PATH_MAX];
 	FILE *in = NULL, *out = stdout;
 	const struct static_nodes_format *format = &static_nodes_format_human;
 	char buf[4096];
@@ -170,13 +171,8 @@ static int do_static_nodes(int argc, char *argv[])
 		}
 		switch (c) {
 		case 'o':
-			out = fopen(optarg, "we");
-			if (out == NULL) {
-				fprintf(stderr, "Error: could not create %s!\n",
-					optarg);
-				ret = EXIT_FAILURE;
-				goto finish;
-			}
+			strncpy(output, optarg, PATH_MAX);
+			out = NULL;
 			break;
 		case 'f':
 			valid = 0;
@@ -221,12 +217,28 @@ static int do_static_nodes(int argc, char *argv[])
 		 kernel.release);
 	in = fopen(modules, "re");
 	if (in == NULL) {
-		fprintf(stderr, "Error: could not open /lib/modules/%s/modules.devname - %m\n",
-			kernel.release);
-		ret = EXIT_FAILURE;
+		if (errno == ENOENT) {
+			fprintf(stderr, "Warning: /lib/modules/%s/modules.devname not found - ignoring\n",
+				kernel.release);
+			ret = EXIT_SUCCESS;
+		} else {
+			fprintf(stderr, "Error: could not open /lib/modules/%s/modules.devname - %m\n",
+				kernel.release);
+			ret = EXIT_FAILURE;
+		}
 		goto finish;
 	}
 
+	if (out == NULL) {
+		out = fopen(output, "we");
+		if (out == NULL) {
+			fprintf(stderr, "Error: could not create %s!\n",
+				output);
+			ret = EXIT_FAILURE;
+			goto finish;
+		}
+	}
+
 	while (fgets(buf, sizeof(buf), in) != NULL) {
 		char modname[PATH_MAX];
 		char devname[PATH_MAX];
-- 
1.8.3.2

