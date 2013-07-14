Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:64284 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab3GNNNr (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Sun, 14 Jul 2013 09:13:47 -0400
Received: by mail-wi0-f172.google.com with SMTP id c10so2032186wiw.5
        for <linux-modules@vger.kernel.org>; Sun, 14 Jul 2013 06:13:46 -0700 (PDT)
From: Tom Gundersen <teg@jklm.no>
To: linux-modules@vger.kernel.org
Cc: Tom Gundersen <teg@jklm.no>
Subject: [PATCHv2 1/2] static-nodes: don't fail if modules.devname not found
Date: Sun, 14 Jul 2013 15:13:33 +0200
Message-Id: <1373807614-17493-1-git-send-email-teg@jklm.no>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

In containers/VM's/initrd one might not have installed any modules and accompanying modules.devname
Don't fail if this is the case, just warn.

When used in systemd this means we don't get a failing unit on booting containers.
---

v2: simplify based on feedback from Dave

 tools/static-nodes.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/static-nodes.c b/tools/static-nodes.c
index 96bb71e..351c02b 100644
--- a/tools/static-nodes.c
+++ b/tools/static-nodes.c
@@ -155,7 +155,8 @@ static int do_static_nodes(int argc, char *argv[])
 {
 	struct utsname kernel;
 	char modules[PATH_MAX];
-	FILE *in = NULL, *out = stdout;
+	const char *output = "/dev/stdout";
+	FILE *in = NULL, *out = NULL;
 	const struct static_nodes_format *format = &static_nodes_format_human;
 	char buf[4096];
 	int ret = EXIT_SUCCESS;
@@ -170,13 +171,7 @@ static int do_static_nodes(int argc, char *argv[])
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
+			output = optarg;
 			break;
 		case 'f':
 			valid = 0;
@@ -217,12 +212,24 @@ static int do_static_nodes(int argc, char *argv[])
 		goto finish;
 	}
 
-	snprintf(modules, sizeof(modules), "/lib/modules/%s/modules.devname",
-		 kernel.release);
+	snprintf(modules, sizeof(modules), "/lib/modules/%s/modules.devname", kernel.release);
 	in = fopen(modules, "re");
 	if (in == NULL) {
-		fprintf(stderr, "Error: could not open /lib/modules/%s/modules.devname - %m\n",
-			kernel.release);
+		if (errno == ENOENT) {
+			fprintf(stderr, "Warning: /lib/modules/%s/modules.devname not found - ignoring\n",
+				kernel.release);
+			ret = EXIT_SUCCESS;
+		} else {
+			fprintf(stderr, "Error: could not open /lib/modules/%s/modules.devname - %m\n",
+				kernel.release);
+			ret = EXIT_FAILURE;
+		}
+		goto finish;
+	}
+
+	out = fopen(output, "we");
+	if (out == NULL) {
+		fprintf(stderr, "Error: could not create %s - %m\n", output);
 		ret = EXIT_FAILURE;
 		goto finish;
 	}
-- 
1.8.3.2

