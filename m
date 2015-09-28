Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51031 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753930AbbI1WjS (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 28 Sep 2015 18:39:18 -0400
From: Laura Abbott <labbott@fedoraproject.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Laura Abbott <labbott@fedoraproject.org>,
	linux-modules@vger.kernel.org
Subject: [PATCHv2 2/5] modprobe: Update error message when path is missing
Date: Mon, 28 Sep 2015 15:39:11 -0700
Message-Id: <1443479954-31484-2-git-send-email-labbott@fedoraproject.org>
In-Reply-To: <1443479954-31484-1-git-send-email-labbott@fedoraproject.org>
References: <1443479954-31484-1-git-send-email-labbott@fedoraproject.org>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


Currently, modprobe fails with no output by default if the
search paths it tries are missing:

$ modprobe -S notakernel dm-crypt
$
$ modprobe -S notakernel lkjjweiojo
$

This is fairly cryptic and not at all obvious there is a problem
unless the error code is checked or verbose flags are used.
Update the error message to indicate a problem and print out the
directory that failed.
---
 libkmod/libkmod-internal.h | 2 --
 libkmod/libkmod.h          | 1 +
 tools/modprobe.c           | 7 +++----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 3e9839d..4d9db6b 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -85,8 +85,6 @@ struct kmod_list *kmod_list_append_list(struct kmod_list *list1, struct kmod_lis
 		container_of(list_entry->node.prev, struct kmod_list, node)))
 
 /* libkmod.c */
-const char *kmod_get_dirname(const struct kmod_ctx *ctx) __attribute__((nonnull(1)));
-
 int kmod_lookup_alias_from_config(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
 int kmod_lookup_alias_from_symbols_file(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
 int kmod_lookup_alias_from_aliases_file(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
index fe53a59..f9e33c6 100644
--- a/libkmod/libkmod.h
+++ b/libkmod/libkmod.h
@@ -51,6 +51,7 @@ void kmod_set_log_priority(struct kmod_ctx *ctx, int priority);
 void *kmod_get_userdata(const struct kmod_ctx *ctx);
 void kmod_set_userdata(struct kmod_ctx *ctx, const void *userdata);
 
+const char *kmod_get_dirname(const struct kmod_ctx *ctx);
 
 /*
  * Management of libkmod's resources
diff --git a/tools/modprobe.c b/tools/modprobe.c
index 3ba8f52..43605cc 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -489,11 +489,10 @@ static int insmod(struct kmod_ctx *ctx, const char *alias,
 						const char *options) = NULL;
 
 	err = kmod_module_new_from_lookup(ctx, alias, &list);
-	if (err < 0)
-		return err;
 
-	if (list == NULL) {
-		LOG("Module %s not found.\n", alias);
+	if (list == NULL || err < 0) {
+		LOG("Module %s not found in directory %s\n", alias,
+			ctx ? kmod_get_dirname(ctx) : "(missing)");
 		return -ENOENT;
 	}
 
-- 
2.4.3

