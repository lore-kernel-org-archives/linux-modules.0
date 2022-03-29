Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBD2C43219
	for <linux-modules@archiver.kernel.org>; Tue, 29 Mar 2022 09:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbiC2JIB (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 29 Mar 2022 05:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiC2JHm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 29 Mar 2022 05:07:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4F2241B7A
        for <linux-modules@vger.kernel.org>; Tue, 29 Mar 2022 02:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648544760; x=1680080760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rNkYydc8uQlz0RjN4RZ/kbh1OjvRCz/lyzzKXzruYRk=;
  b=HcojgQi+aI4Ru1n4Awfy1sItomgLfBsKUZg84D06Bou7SGhfmlm9zJRS
   rAwwA4/UodY/1UUkFj5hkdT2ogwZp887kz6uUOYzTrJ2596lpJ2+VuTzs
   vbB83skNNbwx0ccZJOL+uWy2m7PyRhaYY2oMLv3CjSIV/cbYAIvQrsKCL
   wxYNy/c8KJLjRf74CkTPhTSlYuqNmlUBBkD5wKhcgFXdjSvjbZb4zF8H3
   FRRpO+eA9+5ek8kX4IU4wPZteoo7V7ejA9AURATzqV4qLK7f0Ug8l0Lju
   bA4dJcGRhNY7tVA+lpwpx8NoK/QsJpcyZbxLuOIBowiT9q8HJjEZCgpZI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="239134294"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="239134294"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 02:05:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="585502853"
Received: from mlopezja-mobl.amr.corp.intel.com (HELO ldmartin-desk2.intel.com) ([10.255.231.179])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 02:05:56 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 4/4] modprobe: Make rmmod_do_module() contain all the removal sequence
Date:   Tue, 29 Mar 2022 02:05:40 -0700
Message-Id: <20220329090540.38255-7-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329090540.38255-1-lucas.demarchi@intel.com>
References: <20220329090540.38255-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Move the remaining part of the removal sequence dangling in
rmmod_do_remove_module() to rmmod_do_module() so we can consider this
function is the one controlling all the module removals.

While at it, add some comments about the removal order and normalize
coding style in this function.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 tools/modprobe.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/tools/modprobe.c b/tools/modprobe.c
index 0d9b805..34ef8da 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -322,7 +322,6 @@ end:
 static int rmmod_do_remove_module(struct kmod_module *mod)
 {
 	const char *modname = kmod_module_get_name(mod);
-	struct kmod_list *deps, *itr;
 	int flags = 0, err;
 
 	SHOW("rmmod %s\n", kmod_module_get_name(mod));
@@ -341,17 +340,6 @@ static int rmmod_do_remove_module(struct kmod_module *mod)
 			LOG("Module %s is not in kernel.\n", modname);
 	}
 
-	deps = kmod_module_get_dependencies(mod);
-	if (deps != NULL) {
-		kmod_list_foreach(itr, deps) {
-			struct kmod_module *dep = kmod_module_get_module(itr);
-			if (kmod_module_get_refcnt(dep) == 0)
-				rmmod_do_remove_module(dep);
-			kmod_module_unref(dep);
-		}
-		kmod_module_unref_list(deps);
-	}
-
 	return err;
 }
 
@@ -394,7 +382,8 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
 		cmd = kmod_module_get_remove_commands(mod);
 	}
 
-	if (cmd == NULL && !ignore_loaded) {
+	/* Quick check if module is loaded, otherwise there's nothing to do */
+	if (!cmd && !ignore_loaded) {
 		int state = kmod_module_get_initstate(mod);
 
 		if (state < 0) {
@@ -416,8 +405,10 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
 		}
 	}
 
+	/* 1. @mod's post-softdeps in reverse order */
 	rmmod_do_modlist(post, false);
 
+	/* 2. Other modules holding @mod */
 	if (flags & RMMOD_FLAG_REMOVE_HOLDERS) {
 		struct kmod_list *holders = kmod_module_get_holders(mod);
 
@@ -426,7 +417,8 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
 			goto error;
 	}
 
-	if (!ignore_loaded && !cmd) {
+	/* 3. @mod itself, but check for refcnt first */
+	if (!cmd && !ignore_loaded) {
 		int usage = kmod_module_get_refcnt(mod);
 
 		if (usage > 0) {
@@ -438,7 +430,7 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
 		}
 	}
 
-	if (cmd == NULL)
+	if (!cmd)
 		err = rmmod_do_remove_module(mod);
 	else
 		err = command_do(mod, "remove", cmd, NULL);
@@ -446,6 +438,21 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
 	if (err < 0)
 		goto error;
 
+	/* 4. Other modules that became unused: errors are non-fatal */
+	if (!cmd) {
+		struct kmod_list *deps, *itr;
+
+		deps = kmod_module_get_dependencies(mod);
+		kmod_list_foreach(itr, deps) {
+			struct kmod_module *dep = kmod_module_get_module(itr);
+			if (kmod_module_get_refcnt(dep) == 0)
+				rmmod_do_remove_module(dep);
+			kmod_module_unref(dep);
+		}
+		kmod_module_unref_list(deps);
+	}
+
+	/* 5. @mod's pre-softdeps in reverse order: errors are non-fatal */
 	rmmod_do_modlist(pre, false);
 
 error:
-- 
2.35.1

