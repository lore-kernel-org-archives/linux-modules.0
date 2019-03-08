Return-Path: <SRS0=VdMu=RL=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F32CC43381
	for <linux-modules@archiver.kernel.org>; Fri,  8 Mar 2019 20:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EFA2081B
	for <linux-modules@archiver.kernel.org>; Fri,  8 Mar 2019 20:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfCHUj2 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:39:28 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44756 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfCHUj2 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 8 Mar 2019 15:39:28 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 5E6BC280736
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     lucas.demarchi@intel.com, linux-modules@vger.kernel.org
Cc:     Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH] tools: Print a message if refcnt attribute is missing
Date:   Fri,  8 Mar 2019 17:39:07 -0300
Message-Id: <20190308203907.17030-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Currently, check_module_inuse returns a wrong user message
if the kernel is built without module unloading support.

Fix it by returning a more specific error, in case 'refcnt'
attribute is missing.
---
 tools/remove.c | 9 ++++++---
 tools/rmmod.c  | 9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/remove.c b/tools/remove.c
index 07e2cc0c83cd..387ef0ed17ce 100644
--- a/tools/remove.c
+++ b/tools/remove.c
@@ -44,7 +44,7 @@ static void help(void)
 
 static int check_module_inuse(struct kmod_module *mod) {
 	struct kmod_list *holders;
-	int state;
+	int state, ret;
 
 	state = kmod_module_get_initstate(mod);
 
@@ -74,12 +74,15 @@ static int check_module_inuse(struct kmod_module *mod) {
 		return -EBUSY;
 	}
 
-	if (kmod_module_get_refcnt(mod) != 0) {
+	ret = kmod_module_get_refcnt(mod);
+	if (ret > 0) {
 		ERR("Module %s is in use\n", kmod_module_get_name(mod));
 		return -EBUSY;
+	} else if (ret == -ENOENT) {
+		ERR("Module unloading is not supported\n");
 	}
 
-	return 0;
+	return ret;
 }
 
 static int do_remove(int argc, char *argv[])
diff --git a/tools/rmmod.c b/tools/rmmod.c
index bcdea4c57262..3942e7b439bd 100644
--- a/tools/rmmod.c
+++ b/tools/rmmod.c
@@ -63,7 +63,7 @@ static void help(void)
 
 static int check_module_inuse(struct kmod_module *mod) {
 	struct kmod_list *holders;
-	int state;
+	int state, ret;
 
 	state = kmod_module_get_initstate(mod);
 
@@ -93,12 +93,15 @@ static int check_module_inuse(struct kmod_module *mod) {
 		return -EBUSY;
 	}
 
-	if (kmod_module_get_refcnt(mod) != 0) {
+	ret = kmod_module_get_refcnt(mod);
+	if (ret > 0) {
 		ERR("Module %s is in use\n", kmod_module_get_name(mod));
 		return -EBUSY;
+	} else if (ret == -ENOENT) {
+		ERR("Module unloading is not supported\n");
 	}
 
-	return 0;
+	return ret;
 }
 
 static int do_rmmod(int argc, char *argv[])
-- 
2.20.1

