Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B10BC433F5
	for <linux-modules@archiver.kernel.org>; Tue, 29 Mar 2022 09:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiC2JH4 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 29 Mar 2022 05:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiC2JHl (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 29 Mar 2022 05:07:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ABD241B7C
        for <linux-modules@vger.kernel.org>; Tue, 29 Mar 2022 02:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648544758; x=1680080758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a7ZF5XjqShb5VZnzS09pEe8sn4Z0kAmNbRW3SbLYsak=;
  b=oFlROxUtLW55FZUIHjLfyzC++LU5cyt4loal1crxg9rCiRizgrmZrqLI
   VSH70KgOP00iHR9X7KuTI7eVXQqO0DLJD3xYvfHxizjey0vTY1a+ObAtQ
   ygxMsgtpTS1E9AaSlEJ8h0+bp7shGVD/1mO57TNwr+T2RHREqEA0jD8HX
   iX39XBV+TmXzWlA6c0c0qdOwot99EB0RjaHCRHGWT/hhg7b8GJ9BTRR9N
   kpeAQTomcpQK59ztd3DA9OAZH0bPsC4huMKP2ns2kup37FV4hKnaLs5f4
   j3XmxMQ9NTcDM9e8H8LKGSCR6Blc0J3qxwD1y++jttsrhXxYFaEEFu9Am
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="239134284"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="239134284"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 02:05:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="585502837"
Received: from mlopezja-mobl.amr.corp.intel.com (HELO ldmartin-desk2.intel.com) ([10.255.231.179])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 02:05:55 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 1/4] modprobe: Rename rmmod_do_deps_list
Date:   Tue, 29 Mar 2022 02:05:35 -0700
Message-Id: <20220329090540.38255-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329090540.38255-1-lucas.demarchi@intel.com>
References: <20220329090540.38255-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

It's used not only for dependencies, but also for pre and post softdep.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 tools/modprobe.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/modprobe.c b/tools/modprobe.c
index 9387537..eed951f 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -357,7 +357,8 @@ static int rmmod_do_remove_module(struct kmod_module *mod)
 #define RMMOD_FLAG_IGNORE_BUILTIN	0x2
 static int rmmod_do_module(struct kmod_module *mod, int flags);
 
-static int rmmod_do_deps_list(struct kmod_list *list, bool stop_on_errors)
+/* Remove modules in reverse order */
+static int rmmod_do_modlist(struct kmod_list *list, bool stop_on_errors)
 {
 	struct kmod_list *l;
 
@@ -413,12 +414,12 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
 		}
 	}
 
-	rmmod_do_deps_list(post, false);
+	rmmod_do_modlist(post, false);
 
 	if ((flags & RMMOD_FLAG_DO_DEPENDENCIES) && remove_dependencies) {
 		struct kmod_list *deps = kmod_module_get_dependencies(mod);
 
-		err = rmmod_do_deps_list(deps, true);
+		err = rmmod_do_modlist(deps, true);
 		if (err < 0)
 			goto error;
 	}
@@ -443,7 +444,7 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
 	if (err < 0)
 		goto error;
 
-	rmmod_do_deps_list(pre, false);
+	rmmod_do_modlist(pre, false);
 
 error:
 	kmod_module_unref_list(pre);
-- 
2.35.1

