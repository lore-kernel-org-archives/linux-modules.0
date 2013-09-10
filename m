Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:65172 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab3IJOUe (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Tue, 10 Sep 2013 10:20:34 -0400
Received: by mail-ee0-f42.google.com with SMTP id b45so4010590eek.1
        for <linux-modules@vger.kernel.org>; Tue, 10 Sep 2013 07:20:33 -0700 (PDT)
From: Tom Gundersen <teg@jklm.no>
To: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Tom Gundersen <teg@jklm.no>
Subject: [PATCH] config: also parse softdeps from modules
Date: Tue, 10 Sep 2013 16:21:45 +0200
Message-Id: <1378822905-27687-1-git-send-email-teg@jklm.no>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

This information can be found in /lib/modules/`uname -r`/modules.softdep, and
has only recently been exported by the kernel.

Also remove the advice about copying modules.softdep to /lib/modules as it is
not clear how to do this correctly with several kernels installed with
potentially conflicting soft dependencies.
---
 libkmod/libkmod-config.c | 2 ++
 tools/depmod.c           | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index 24978c1..809815a 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -879,6 +879,8 @@ int kmod_config_new(struct kmod_ctx *ctx, struct kmod_config **p_config,
 	struct kmod_list *path_list = NULL;
 	size_t i;
 
+	conf_files_insert_sorted(ctx, &list, kmod_get_dirname(ctx), "modules.softdep");
+
 	for (i = 0; config_paths[i] != NULL; i++) {
 		const char *path = config_paths[i];
 		unsigned long long path_stamp = 0;
diff --git a/tools/depmod.c b/tools/depmod.c
index 5855b2a..3d45c83 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1963,8 +1963,6 @@ static int output_softdeps(struct depmod *depmod, FILE *out)
 	size_t i;
 
 	fputs("# Soft dependencies extracted from modules themselves.\n", out);
-	fputs("# Copy, with a .conf extension, to /etc/modprobe.d to use "
-	      "it with modprobe.\n", out);
 
 	for (i = 0; i < depmod->modules.count; i++) {
 		const struct mod *mod = depmod->modules.array[i];
-- 
1.8.4

