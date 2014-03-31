Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48416 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbaCaNTE (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 31 Mar 2014 09:19:04 -0400
From: Michal Marek <mmarek@suse.cz>
To: linux-modules@vger.kernel.org
Cc: Tom Gundersen <teg@jklm.no>
Subject: [PATCH 2/2] config: also parse softdeps from modules
Date: Mon, 31 Mar 2014 15:18:51 +0200
Message-Id: <1396271931-7431-2-git-send-email-mmarek@suse.cz>
In-Reply-To: <1396271931-7431-1-git-send-email-mmarek@suse.cz>
References: <1396271931-7431-1-git-send-email-mmarek@suse.cz>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Tom Gundersen <teg@jklm.no>

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
index 9905d5e..0953924 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -848,6 +848,8 @@ int kmod_config_new(struct kmod_ctx *ctx, struct kmod_config **p_config,
 	struct kmod_list *path_list = NULL;
 	size_t i;
 
+	conf_files_insert_sorted(ctx, &list, kmod_get_dirname(ctx), "modules.softdep");
+
 	for (i = 0; config_paths[i] != NULL; i++) {
 		const char *path = config_paths[i];
 		unsigned long long path_stamp = 0;
diff --git a/tools/depmod.c b/tools/depmod.c
index 37e6afd..1aedaaf 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1952,8 +1952,6 @@ static int output_softdeps(struct depmod *depmod, FILE *out)
 	size_t i;
 
 	fputs("# Soft dependencies extracted from modules themselves.\n", out);
-	fputs("# Copy, with a .conf extension, to /etc/modprobe.d to use "
-	      "it with modprobe.\n", out);
 
 	for (i = 0; i < depmod->modules.count; i++) {
 		const struct mod *mod = depmod->modules.array[i];
-- 
1.8.4.5

