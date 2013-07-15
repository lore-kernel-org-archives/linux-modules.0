Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-yh0-f46.google.com ([209.85.213.46]:63898 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab3GOFM7 (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 15 Jul 2013 01:12:59 -0400
Received: by mail-yh0-f46.google.com with SMTP id i57so4424243yha.33
        for <linux-modules@vger.kernel.org>; Sun, 14 Jul 2013 22:12:58 -0700 (PDT)
Received: from localhost.localdomain ([201.53.216.53])
        by mx.google.com with ESMTPSA id s29sm81191597yhf.6.2013.07.14.22.12.57
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 22:12:58 -0700 (PDT)
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-modules@vger.kernel.org
Subject: [PATCH 6/6] static-nodes: create parent directories of output file
Date: Mon, 15 Jul 2013 02:12:59 -0300
Message-Id: <1373865179-18366-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1373865179-18366-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1373865179-18366-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Tom Gundersen <teg@jklm.no>

Allows us to drop call to "mkdir -p" from the systemd service file.
---
 tools/static-nodes.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/static-nodes.c b/tools/static-nodes.c
index 351c02b..0195390 100644
--- a/tools/static-nodes.c
+++ b/tools/static-nodes.c
@@ -154,12 +154,11 @@ static void help(void)
 static int do_static_nodes(int argc, char *argv[])
 {
 	struct utsname kernel;
-	char modules[PATH_MAX];
+	char modules[PATH_MAX], buf[4096];
 	const char *output = "/dev/stdout";
 	FILE *in = NULL, *out = NULL;
 	const struct static_nodes_format *format = &static_nodes_format_human;
-	char buf[4096];
-	int ret = EXIT_SUCCESS;
+	int r, ret = EXIT_SUCCESS;
 
 	for (;;) {
 		int c, idx = 0, valid;
@@ -227,6 +226,13 @@ static int do_static_nodes(int argc, char *argv[])
 		goto finish;
 	}
 
+	r = mkdir_parents(output, 0755);
+	if (r < 0) {
+		fprintf(stderr, "Error: could not create parent directory for %s - %m.\n", output);
+		ret = EXIT_FAILURE;
+		goto finish;
+	}
+
 	out = fopen(output, "we");
 	if (out == NULL) {
 		fprintf(stderr, "Error: could not create %s - %m\n", output);
-- 
1.8.3.2

