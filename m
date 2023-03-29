Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E51C74A5B
	for <linux-modules@archiver.kernel.org>; Wed, 29 Mar 2023 13:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjC2NwE (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 29 Mar 2023 09:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjC2NwE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 29 Mar 2023 09:52:04 -0400
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FC41BF6
        for <linux-modules@vger.kernel.org>; Wed, 29 Mar 2023 06:51:57 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Wed, 29 Mar 2023 15:51:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1680097912; bh=KPXGwTg8jX9qX0oH0D+aA47k6PjscoqHEsZ6SeQLuIc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=YPGttJJTJ3j8e0ObLAL4wiBpZAdUPbAhhCm3oKK+kx41VVnqtZ+85M/KCn+KmCSn+
         I+09rBJDvoY07W1hjbf2NnzQi/YAoh4DmOq7d+f7LAoEQo9rWBqwscl3dJWBXRS21s
         10Kd/QwCOVpGDAv536fbPoOShdIvhwKxar8ZwsyA=
Received: from island.ads.avm.de (unknown [172.17.88.185])
        by mail-auth.avm.de (Postfix) with ESMTPA id 758FD81ED2;
        Wed, 29 Mar 2023 15:51:51 +0200 (CEST)
Received: from island.fjasle.eu (localhost [IPv6:::1])
        by island.ads.avm.de (Postfix) with ESMTP id 67A56521A08;
        Wed, 29 Mar 2023 15:51:51 +0200 (CEST)
From:   Nicolas Schier <n.schier@avm.de>
Date:   Wed, 29 Mar 2023 15:51:36 +0200
Subject: [PATCH v2 2/3] testsuite: delete_module: Roughly implement
 fake-removal in sysfs tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230309-remove-holders-recursively-v2-2-8a8120269cc1@avm.de>
References: <20230309-remove-holders-recursively-v2-0-8a8120269cc1@avm.de>
In-Reply-To: <20230309-remove-holders-recursively-v2-0-8a8120269cc1@avm.de>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Nicolas Schier <nicolas@fjasle.eu>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7999; i=n.schier@avm.de;
 h=from:subject:message-id; bh=KPXGwTg8jX9qX0oH0D+aA47k6PjscoqHEsZ6SeQLuIc=;
 b=owEBbQKS/ZANAwAIAYjGvJyImm24AcsmYgBkJEJ2q8rKDMeOlTX0cg0CAIu+QvKUz+KuO4vIc
 42FvHa2ATOJAjMEAAEIAB0WIQQO/4WJ63TpgecLpGmIxryciJptuAUCZCRCdgAKCRCIxryciJpt
 uGjWD/9qgcHPzuxV2605BKSSoHvq+k8rd35vrKMyY0j297ElnvEybjUGctf5QXheTfITe2HNREL
 aBpziUD1DBclBlneNoayjzJVF5+DgMS4ytM+iE1iMz3yZ/L4Cv7XvMEBnfFJZAW39MEGgrGMQjJ
 nHsFAryr3X9bxGlZGBrgpTUB6GsctPhTWeL+HvAaDxn/6ovNV9OmDKK45ZRMhVH8mW+eDyzXt6i
 rE05us/782oiHPyJUlfwp++qSQOa6PbfHlV9UWCs6jpfkQENuMcVXq3ppgw5FHwYH/Hnv08SaBN
 rKnFDF8umvgjzSEq52650airfZJOk04Xz5BdIJgtNp01QQPRCZknMTAfIV1wXRqpW4dfPyOp6cP
 4ANLbXrVi1qK21t7MnWOZzukg/aLT37SOPoRBzHRbaX0LBNgWBxpl9tbS1V/Q1FEq+6R/24MHAf
 uUwBXK6TzWQOsd1Amukx2mLGhc+I8aCzhKFYlF54OSVQocN/1awlSul1aAeTCXbl+BhtW8zaCsc
 Ni2AOB9OCDMo7XMpbptczQVnHQn/5QuBPJrSbcuKydXfMshTv5itSYU+HXGI+Ir0F81+WGumE/e
 TUjIVqTYFOrma4s0uOmk3LOJPqUPUkhzZWVWI8pYPo0kOJkqVGOaOToiJyoGtoT42E5y3QR4Vy/
 BLQlVOqixaAJulg==
X-Developer-Key: i=n.schier@avm.de; a=openpgp;
 fpr=7CF67EF8868721AFE53D73FDBDE3A6CC4E333CC8
X-purgate-ID: 149429::1680097911-D334E29D-14B79B8D/0/0
X-purgate-type: clean
X-purgate-size: 8001
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Extend delete_module() to simulate module removal in the testsuite's
sysfs representation.  During fake-removal, decrement refcnts on all
modules that have the to-be-removed module as holder, and unlink the
sysfs sub tree of the module itself.

Signed-off-by: Nicolas Schier <n.schier@avm.de>
---
Changes in v2:
  * new patch
---
 Makefile.am               |   1 +
 testsuite/delete_module.c | 262 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 261 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 8ba85c9..9a87824 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -293,6 +293,7 @@ testsuite_path_la_CPPFLAGS = $(AM_CPPFLAGS) \
 testsuite_path_la_LDFLAGS = $(TESTSUITE_OVERRIDE_LIBS_LDFLAGS)
 
 testsuite_delete_module_la_LDFLAGS = $(TESTSUITE_OVERRIDE_LIBS_LDFLAGS)
+testsuite_delete_module_la_LIBADD = libkmod/libkmod-internal.la
 testsuite_init_module_la_LDFLAGS = $(TESTSUITE_OVERRIDE_LIBS_LDFLAGS)
 testsuite_init_module_la_SOURCES = testsuite/init_module.c \
 				   testsuite/stripped-module.h
diff --git a/testsuite/delete_module.c b/testsuite/delete_module.c
index f3ae20b..73fc71a 100644
--- a/testsuite/delete_module.c
+++ b/testsuite/delete_module.c
@@ -31,6 +31,7 @@
 #include <unistd.h>
 
 #include <shared/util.h>
+#include <libkmod/libkmod.h>
 
 #include "testsuite.h"
 
@@ -135,11 +136,252 @@ static void init_retcodes(void)
 	}
 }
 
+static bool lstat_is_dir(const char *dir)
+{
+	struct stat st;
+
+	if (!lstat(dir, &st))
+		return S_ISDIR(st.st_mode);
+
+	ERR("TRAP delete_module(): %s: lstat: %s\n", dir, strerror(errno));
+	return false;
+}
+
+static int unlink_tree(const char *dir)
+{
+	struct dirent *dent;
+	char *new_path;
+	bool is_dir;
+	DIR *dirp;
+	int ret;
+
+	dirp = opendir(dir);
+	if (!dirp) {
+		ERR("TRAP delete_module(): %s: opendir: %s\n", dir,
+		    strerror(errno));
+		return errno;
+	}
+
+	errno = ret = 0;
+	while (!ret && (dent = readdir(dirp))) {
+		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
+			continue;
+
+		if (asprintf(&new_path, "%s/%s", dir, dent->d_name) < 0) {
+			ERR("TRAP delete_module(): unlink_tree: out-of-memory\n");
+			return ENOMEM;
+		}
+
+		if (dent->d_type == DT_UNKNOWN)
+			is_dir = lstat_is_dir(new_path);
+		else
+			is_dir = dent->d_type == DT_DIR;
+
+		if (is_dir)
+			ret = unlink_tree(new_path);
+		else {
+			if (unlink(new_path)) {
+				ret = errno;
+				ERR("TRAP delete_module(): %s: unlink: %s\n", new_path, strerror(errno));
+			}
+		}
+
+		free(new_path);
+	}
+
+	if (errno) {
+		if (!ret)
+			ret = errno;
+		ERR("TRAP delete_module(): %s: readdir: %s\n", dir, strerror(errno));
+	}
+
+	if (closedir(dirp)) {
+		if (!ret)
+			ret = errno;
+		ERR("TRAP delete_module(): %s: closedir: %s\n", dir, strerror(errno));
+	}
+
+	if (rmdir(dir)) {
+		if (ret)
+			ret = errno;
+		ERR("TRAP delete_module(): %s: rmdir: %s\n", dir, strerror(errno));
+	}
+
+	return ret;
+}
+
+static const char *rootfs_path(void)
+{
+	char *rootfs;
+
+	rootfs = getenv(S_TC_ROOTFS);
+	if (rootfs)
+		return rootfs;
+
+	ERR("TRAP delete_module(): missing export %s?\n",
+	    S_TC_ROOTFS);
+	return NULL;
+}
+
+static char *sysfs_module_path_get(const char *module, const char *subpath)
+{
+	const char *rootfs = rootfs_path();
+	char *sysfs_path;
+	int ret;
+
+	if (!rootfs)
+		return NULL;
+
+	ret = asprintf(&sysfs_path, "%s/sys/module/%s%s",
+		       rootfs, module, subpath ? subpath : "");
+	if (ret >= 0)
+		return sysfs_path;
+
+	ERR("TRAP delete_module(): %s: out-of-memory\n", subpath);
+	return NULL;
+}
+
+static int unlink_sysfs_module_tree(struct mod *mod)
+{
+	char *sysfs_path;
+	int ret;
+
+	if (!(sysfs_path = sysfs_module_path_get(mod->name, NULL)))
+		return EFAULT;
+
+	ret = unlink_tree(sysfs_path);
+	free(sysfs_path);
+
+	return ret;
+}
+
+static int sysfs_kmod_remove_holder(const struct kmod_module *kmod,
+				    const char *holder)
+{
+	const char *name = kmod_module_get_name(kmod);
+	char *sysfs_mod_holders;
+	char *sysfs_mod_refcnt;
+	char refcnt_str[34];
+	char *sysfs_mod;
+	int holders_fd;
+	int refcnt;
+	int ret;
+	int fd;
+
+	if (!(sysfs_mod = sysfs_module_path_get(name, NULL)) ||
+	    !(sysfs_mod_refcnt = sysfs_module_path_get(name, "/refcnt")) ||
+	    !(sysfs_mod_holders = sysfs_module_path_get(name, "/holders"))) {
+		ERR("TRAP delete_module(): %s: out-of-memory\n", name);
+		return ENOMEM;
+	}
+
+	holders_fd = open(sysfs_mod_holders, O_RDONLY|O_CLOEXEC);
+	if (holders_fd < 0) {
+		ret = errno;
+		ERR("TRAP delete_module(): %s: open: %s\n", sysfs_mod_holders,
+		    strerror(errno));
+		goto fail_free_pathnames;
+	}
+
+	if (unlinkat(holders_fd, holder, 0)) {
+		ret = errno;
+		ERR("TRAP delete_module(): %s/%s: unlink: %s\n",
+		    sysfs_mod_holders, holder, strerror(ret));
+		goto fail_close_holders_fd;
+	}
+
+	refcnt = kmod_module_get_refcnt(kmod);
+	if (refcnt < 0) {
+		ret = errno;
+		ERR("TRAP delete_module(): %s: Invalid refcnt or error: %d\n",
+		    name, refcnt);
+		return ret;
+	}
+
+	if (refcnt == 0) {
+		ERR("TRAP delete_module(): %s: refcnt already dropped to 0, refusing decrement\n",
+		    name);
+		return EINVAL;
+	}
+
+	refcnt--;
+	snprintf(refcnt_str, sizeof(refcnt_str), "%d\n", refcnt);
+
+	fd = open(sysfs_mod_refcnt, O_WRONLY|O_TRUNC|O_CLOEXEC);
+	if (fd < 0) {
+		ret = errno;
+		ERR("TRAP delete_module(): %s: open: %s\n", sysfs_mod_refcnt,
+		    strerror(ret));
+		goto fail_free_pathnames;
+	}
+
+	ret = write(fd, refcnt_str, strlen(refcnt_str));
+	if (ret <= 0) {
+		ret = errno;
+		ERR("TRAP delete_module(): %s: write: %s\n", sysfs_mod_refcnt,
+		    strerror(ret));
+	}
+
+	close(fd);
+
+fail_close_holders_fd:
+	close(holders_fd);
+
+fail_free_pathnames:
+	free(sysfs_mod_holders);
+	free(sysfs_mod_refcnt);
+	free(sysfs_mod);
+
+	return ret;
+}
+
+static int decrement_holders_refcnt(struct mod *removed_mod)
+{
+	struct kmod_list *list, *itr;
+	struct kmod_ctx *ctx;
+	int err;
+
+	ctx = kmod_new(NULL, NULL);
+	if (ctx == NULL) {
+		ERR("TRAP delete_module(): Unable to get kmod ctx\n");
+		return EFAULT;
+	}
+
+	err = kmod_module_new_from_loaded(ctx, &list);
+	if (err < 0) {
+		ERR("TRAP delete_module(): Unable to get list of loaded modules: %s\n",
+		    strerror(-err));
+		goto fail_free_ctx;
+	}
+
+	kmod_list_foreach(itr, list) {
+		struct kmod_module *kmod = kmod_module_get_module(itr);
+		struct kmod_list *holders, *hitr;
+
+		holders = kmod_module_get_holders(kmod);
+		kmod_list_foreach(hitr, holders) {
+			struct kmod_module *hm = kmod_module_get_module(hitr);
+			const char *holder_name = kmod_module_get_name(hm);
+
+			if (!strcmp(holder_name, removed_mod->name))
+				sysfs_kmod_remove_holder(kmod, holder_name);
+
+			kmod_module_unref(hm);
+		}
+		kmod_module_unref_list(holders);
+		kmod_module_unref(kmod);
+	}
+	kmod_module_unref_list(list);
+
+fail_free_ctx:
+	kmod_unref(ctx);
+
+	return -err;
+}
+
 TS_EXPORT long delete_module(const char *name, unsigned int flags);
 
 /*
- * FIXME: change /sys/module/<modname> to fake-remove a module
- *
  * Default behavior is to exit successfully. If this is not the intended
  * behavior, set TESTSUITE_DELETE_MODULE_RETCODES env var.
  */
@@ -152,6 +394,22 @@ long delete_module(const char *modname, unsigned int flags)
 	if (mod == NULL)
 		return 0;
 
+	if (!mod->ret) {
+		/* Adjust sysfs tree after successful removal */
+
+		errno = decrement_holders_refcnt(mod);
+		if (errno) {
+			ERR("TRAP delete_module(): unable to decrement sysfs holders\n");
+			return EFAULT;
+		}
+
+		errno = unlink_sysfs_module_tree(mod);
+		if (errno) {
+			ERR("TRAP delete_module(): unable to adjust sysfs tree\n");
+			return EFAULT;
+		}
+	}
+
 	errno = mod->errcode;
 	return mod->ret;
 }

-- 
2.40.0

