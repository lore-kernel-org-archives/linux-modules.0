Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from fmap.me ([91.92.66.84]:33942 "EHLO smtp.fmap.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409AbcHPA6O (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 15 Aug 2016 20:58:14 -0400
From: Nikolay Amiantov <ab@fmap.me>
To: linux-modules@vger.kernel.org
Cc: Shea Levy <shea@shealevy.com>, Nikolay Amiantov <ab@fmap.me>
Subject: [PATCH 3/4] static-nodes: use kmod to get modules directory
Date: Tue, 16 Aug 2016 03:50:31 +0300
Message-Id: <20160816005032.28881-4-ab@fmap.me>
In-Reply-To: <20160816005032.28881-1-ab@fmap.me>
References: <20160816005032.28881-1-ab@fmap.me>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

static-nodes has just used /lib/modules/`uname -r` before with no way to
specify another directory. Instead, make it get the path via kmod, which has a
more sophisticated algorithm for searching the modules directory.

As a side effect, cleanup error messages printing a little.
---
 tools/static-nodes.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/static-nodes.c b/tools/static-nodes.c
index 8d2356d..2ed306d 100644
--- a/tools/static-nodes.c
+++ b/tools/static-nodes.c
@@ -29,10 +29,11 @@
 #include <unistd.h>
 #include <sys/stat.h>
 #include <sys/types.h>
-#include <sys/utsname.h>
 
 #include <shared/util.h>
 
+#include <libkmod/libkmod.h>
+
 #include "kmod.h"
 
 struct static_nodes_format {
@@ -154,8 +155,8 @@ static void help(void)
 
 static int do_static_nodes(int argc, char *argv[])
 {
-	struct utsname kernel;
 	char modules[PATH_MAX], buf[4096];
+	struct kmod_ctx *ctx;
 	const char *output = "/dev/stdout";
 	FILE *in = NULL, *out = NULL;
 	const struct static_nodes_format *format = &static_nodes_format_human;
@@ -206,22 +207,25 @@ static int do_static_nodes(int argc, char *argv[])
 		}
 	}
 
-	if (uname(&kernel) < 0) {
-		fputs("Error: uname failed!\n", stderr);
+	ctx = kmod_new(NULL, NULL);
+	if (ctx == NULL) {
+		fprintf(stderr, "Error: failed to create kmod context\n");
 		ret = EXIT_FAILURE;
 		goto finish;
 	}
-
-	snprintf(modules, sizeof(modules), "/lib/modules/%s/modules.devname", kernel.release);
+	if (snprintf(modules, sizeof(modules), "%s/modules.devname", kmod_get_dirname(ctx)) < 0) {
+		fprintf(stderr, "Error: path to modules.devname is too long\n");
+		ret = EXIT_FAILURE;
+		goto finish;
+	}
+	kmod_unref(ctx);
 	in = fopen(modules, "re");
 	if (in == NULL) {
 		if (errno == ENOENT) {
-			fprintf(stderr, "Warning: /lib/modules/%s/modules.devname not found - ignoring\n",
-				kernel.release);
+			fprintf(stderr, "Warning: %s not found - ignoring\n", modules);
 			ret = EXIT_SUCCESS;
 		} else {
-			fprintf(stderr, "Error: could not open /lib/modules/%s/modules.devname - %m\n",
-				kernel.release);
+			fprintf(stderr, "Error: could not open %s - %m\n", modules);
 			ret = EXIT_FAILURE;
 		}
 		goto finish;
-- 
2.9.2

