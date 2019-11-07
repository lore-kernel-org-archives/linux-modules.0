Return-Path: <SRS0=6exi=Y7=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0669C5DF60
	for <linux-modules@archiver.kernel.org>; Thu,  7 Nov 2019 07:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC8B21D79
	for <linux-modules@archiver.kernel.org>; Thu,  7 Nov 2019 07:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfKGHjH (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:39:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:5376 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbfKGHjH (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 7 Nov 2019 02:39:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 23:39:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,277,1569308400"; 
   d="scan'208";a="201333703"
Received: from grosner-mobl2.amr.corp.intel.com (HELO ldmartin-desk1.intel.com) ([10.254.108.231])
  by fmsmga007.fm.intel.com with ESMTP; 06 Nov 2019 23:39:05 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH] modprobe: use flags rather than bool args
Date:   Wed,  6 Nov 2019 23:38:57 -0800
Message-Id: <20191107073857.29596-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

It's easier to know what the caller is doing when we pass a named
flag rather than a list of bools.
---
 tools/modprobe.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/modprobe.c b/tools/modprobe.c
index 44cd15c..9387537 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -353,8 +353,9 @@ static int rmmod_do_remove_module(struct kmod_module *mod)
 	return err;
 }
 
-static int rmmod_do_module(struct kmod_module *mod, bool do_dependencies,
-			   bool ignore_builtin);
+#define RMMOD_FLAG_DO_DEPENDENCIES	0x1
+#define RMMOD_FLAG_IGNORE_BUILTIN	0x2
+static int rmmod_do_module(struct kmod_module *mod, int flags);
 
 static int rmmod_do_deps_list(struct kmod_list *list, bool stop_on_errors)
 {
@@ -362,7 +363,7 @@ static int rmmod_do_deps_list(struct kmod_list *list, bool stop_on_errors)
 
 	kmod_list_foreach_reverse(l, list) {
 		struct kmod_module *m = kmod_module_get_module(l);
-		int r = rmmod_do_module(m, false, true);
+		int r = rmmod_do_module(m, RMMOD_FLAG_IGNORE_BUILTIN);
 		kmod_module_unref(m);
 
 		if (r < 0 && stop_on_errors)
@@ -372,8 +373,7 @@ static int rmmod_do_deps_list(struct kmod_list *list, bool stop_on_errors)
 	return 0;
 }
 
-static int rmmod_do_module(struct kmod_module *mod, bool do_dependencies,
-			   bool ignore_builtin)
+static int rmmod_do_module(struct kmod_module *mod, int flags)
 {
 	const char *modname = kmod_module_get_name(mod);
 	struct kmod_list *pre = NULL, *post = NULL;
@@ -403,7 +403,7 @@ static int rmmod_do_module(struct kmod_module *mod, bool do_dependencies,
 			}
 			goto error;
 		} else if (state == KMOD_MODULE_BUILTIN) {
-			if (ignore_builtin) {
+			if (flags & RMMOD_FLAG_IGNORE_BUILTIN) {
 				err = 0;
 			} else {
 				LOG("Module %s is builtin.\n", modname);
@@ -415,7 +415,7 @@ static int rmmod_do_module(struct kmod_module *mod, bool do_dependencies,
 
 	rmmod_do_deps_list(post, false);
 
-	if (do_dependencies && remove_dependencies) {
+	if ((flags & RMMOD_FLAG_DO_DEPENDENCIES) && remove_dependencies) {
 		struct kmod_list *deps = kmod_module_get_dependencies(mod);
 
 		err = rmmod_do_deps_list(deps, true);
@@ -468,7 +468,7 @@ static int rmmod(struct kmod_ctx *ctx, const char *alias)
 
 	kmod_list_foreach(l, list) {
 		struct kmod_module *mod = kmod_module_get_module(l);
-		err = rmmod_do_module(mod, true, false);
+		err = rmmod_do_module(mod, RMMOD_FLAG_DO_DEPENDENCIES);
 		kmod_module_unref(mod);
 		if (err < 0)
 			break;
-- 
2.24.0

