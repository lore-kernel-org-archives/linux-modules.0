Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44770 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753385AbcFQOIk (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Fri, 17 Jun 2016 10:08:40 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 360CBAC9D
	for <linux-modules@vger.kernel.org>; Fri, 17 Jun 2016 14:08:34 +0000 (UTC)
From: Michal Marek <mmarek@suse.com>
To: linux-modules@vger.kernel.org
Cc: Michal Marek <mmarek@suse.cz>
Subject: [PATCH] libkmod: Handle long lines in /proc/modules
Date: Fri, 17 Jun 2016 16:04:15 +0200
Message-Id: <1466172255-20955-1-git-send-email-mmarek@suse.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Michal Marek <mmarek@suse.cz>

kmod_module_new_from_loaded() calls fgets with a 4k buffer. When a
module such as usbcore is used by too many modules, the rest of the line
is considered a beginning of another lines and we eventually get errors
like these from lsmod:

libkmod: kmod_module_get_holders: could not open '/sys/module/100,/holders': No such file or directory

together with bogus entries in the output. In kmod_module_get_size, the
problem does not affect functionality, but the line numbers in error
messages will be wrong.

Signed-off-by: Michal Marek <mmarek@suse.com>
---

I wrote a test case for this as well, but it is failing because the
testsuite itself has problems with output larger than 4k. I'll send
something later.

Also, the buffer could be shrinked now, so that we do not use that much
space on stack. Not sure if this is of interest or not. I left it as is.

Michal


---
 libkmod/libkmod-module.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 1460c6746cc4..25dcda7667b7 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -1660,13 +1660,14 @@ KMOD_EXPORT int kmod_module_new_from_loaded(struct kmod_ctx *ctx,
 		struct kmod_module *m;
 		struct kmod_list *node;
 		int err;
+		size_t len = strlen(line);
 		char *saveptr, *name = strtok_r(line, " \t", &saveptr);
 
 		err = kmod_module_new_from_name(ctx, name, &m);
 		if (err < 0) {
 			ERR(ctx, "could not get module from name '%s': %s\n",
 				name, strerror(-err));
-			continue;
+			goto eat_line;
 		}
 
 		node = kmod_list_append(l, m);
@@ -1676,6 +1677,9 @@ KMOD_EXPORT int kmod_module_new_from_loaded(struct kmod_ctx *ctx,
 			ERR(ctx, "out of memory\n");
 			kmod_module_unref(m);
 		}
+eat_line:
+		while (line[len - 1] != '\n' && fgets(line, sizeof(line), fp))
+			len = strlen(line);
 	}
 
 	fclose(fp);
@@ -1825,12 +1829,13 @@ KMOD_EXPORT long kmod_module_get_size(const struct kmod_module *mod)
 	}
 
 	while (fgets(line, sizeof(line), fp)) {
+		size_t len = strlen(line);
 		char *saveptr, *endptr, *tok = strtok_r(line, " \t", &saveptr);
 		long value;
 
 		lineno++;
 		if (tok == NULL || !streq(tok, mod->name))
-			continue;
+			goto eat_line;
 
 		tok = strtok_r(NULL, " \t", &saveptr);
 		if (tok == NULL) {
@@ -1848,6 +1853,9 @@ KMOD_EXPORT long kmod_module_get_size(const struct kmod_module *mod)
 
 		size = value;
 		break;
+eat_line:
+		while (line[len - 1] != '\n' && fgets(line, sizeof(line), fp))
+			len = strlen(line);
 	}
 	fclose(fp);
 
-- 
2.6.2

