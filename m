Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42167 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754954AbaCDPv3 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Tue, 4 Mar 2014 10:51:29 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C5A73AC86
	for <linux-modules@vger.kernel.org>; Tue,  4 Mar 2014 15:51:27 +0000 (UTC)
From: Michal Marek <mmarek@suse.cz>
To: linux-modules@vger.kernel.org
Subject: [PATCH] libkmod-config,depmod: Accept special files as configuration files, too
Date: Tue,  4 Mar 2014 16:51:25 +0100
Message-Id: <1393948285-16254-1-git-send-email-mmarek@suse.cz>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

If we can open it and read it, it's good enough for us. Otherwise, we
cannot use -C /dev/null to skip the system configuration for instance:

$ ./tools/modprobe -C /dev/null -c
libkmod: ERROR libkmod/libkmod-config.c:821 conf_files_list: unsupported
file mode /dev/null: 0x21b6
...
---
 libkmod/libkmod-config.c | 6 +-----
 tools/depmod.c           | 5 +----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index 32adb8b..4417871 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -813,13 +813,9 @@ static int conf_files_list(struct kmod_ctx *ctx, struct kmod_list **list,
 
 	*path_stamp = stat_mstamp(&st);
 
-	if (S_ISREG(st.st_mode)) {
+	if (!S_ISDIR(st.st_mode)) {
 		conf_files_insert_sorted(ctx, list, path, NULL);
 		return 0;
-	} else if (!S_ISDIR(st.st_mode)) {
-		ERR(ctx, "unsupported file mode %s: %#x\n",
-							path, st.st_mode);
-		return -EINVAL;
 	}
 
 	d = opendir(path);
diff --git a/tools/depmod.c b/tools/depmod.c
index b1b5874..9f83ee8 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -846,12 +846,9 @@ static int cfg_files_list(struct cfg_file ***p_files, size_t *p_n_files,
 		return err;
 	}
 
-	if (S_ISREG(st.st_mode)) {
+	if (!S_ISDIR(st.st_mode)) {
 		cfg_files_insert_sorted(p_files, p_n_files, path, NULL);
 		return 0;
-	} else if (!S_ISDIR(st.st_mode)) {
-		ERR("unsupported file mode %s: %#x\n", path, st.st_mode);
-		return -EINVAL;
 	}
 
 	d = opendir(path);
-- 
1.8.4.5

