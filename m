Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-gg0-f170.google.com ([209.85.161.170]:55462 "EHLO
	mail-gg0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab3GOFMz (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 15 Jul 2013 01:12:55 -0400
Received: by mail-gg0-f170.google.com with SMTP id s5so3819259ggc.15
        for <linux-modules@vger.kernel.org>; Sun, 14 Jul 2013 22:12:55 -0700 (PDT)
Received: from localhost.localdomain ([201.53.216.53])
        by mx.google.com with ESMTPSA id s29sm81191597yhf.6.2013.07.14.22.12.53
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 22:12:54 -0700 (PDT)
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-modules@vger.kernel.org
Subject: [PATCH 3/6] static-nodes: don't fail if modules.devname not found
Date: Mon, 15 Jul 2013 02:12:56 -0300
Message-Id: <1373865179-18366-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1373865179-18366-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1373865179-18366-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Tom Gundersen <teg@jklm.no>

In containers/VM's/initrd one might not have installed any modules and
accompanying modules.devname Don't fail if this is the case, just warn.

When used in systemd this means we don't get a failing unit on booting
containers.
---
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

