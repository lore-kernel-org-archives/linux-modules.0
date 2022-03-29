Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9130BC433FE
	for <linux-modules@archiver.kernel.org>; Tue, 29 Mar 2022 09:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbiC2JH6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 29 Mar 2022 05:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbiC2JHl (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 29 Mar 2022 05:07:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906B4242200
        for <linux-modules@vger.kernel.org>; Tue, 29 Mar 2022 02:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648544759; x=1680080759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pOfuYLD3+WIqgBXyekrwMeTleCTPVI4Hjm+Qr82QKO4=;
  b=bnzTH7/IQL+ZW5caD6BTjHITF5u2IKogyaKaWNpnHvqrXiZb/vLJFfzf
   pPo19q6Jmjv65UiG9vFJKu/15bPi3L9jP7siIVHstmQlsPHPo8g8U4LMh
   73M/WGnMY+9aIuVQmyxmILJDiSJ8yaJzIPbbYgVR3XJJ6mjo5oHq4QZiE
   6FdEeXV48/nF4M4pPsIlFJ2JTPV+BVaXZGsNnHTKsPDpmPetSoy1bfEKK
   O4trdB6acYi6M8+o2S+eQpIhSkserjUFM2oNESnk/ufKn5x+ZOcgoBZ37
   gYN3/jjMDz4FcIsO7KU3itRdcjgmdsO+hfr3W8Jc4e9xkBvu1bM0fI7lE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="239134288"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="239134288"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 02:05:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="585502844"
Received: from mlopezja-mobl.amr.corp.intel.com (HELO ldmartin-desk2.intel.com) ([10.255.231.179])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 02:05:55 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 2/4] modprobe: Fix holders removal
Date:   Tue, 29 Mar 2022 02:05:37 -0700
Message-Id: <20220329090540.38255-4-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329090540.38255-1-lucas.demarchi@intel.com>
References: <20220329090540.38255-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The idea behind --remove-dependencies was to remove other modules that
depend on the current module being removed. It's the reverse
dependency list, not the dependency list of the current module: that
never works since the current module would still hold a ref on it.

Fix it by replacing the call to kmod_module_get_dependencies() with
kmod_module_get_holders() when using that option. Also try to cleanup
the confusion by renaming the option to --remove-holders: "holder" is
the name used in sysfs and by libkmod to refer to a "live" reverse
dependency like what we are interested in.

Before:
	./tools/modprobe -D -r --remove-dependencies video
	rmmod video

After:
	./tools/modprobe -D -r --remove-holders video
	rmmod i915
	rmmod thinkpad_acpi
	rmmod video

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 tools/modprobe.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/modprobe.c b/tools/modprobe.c
index eed951f..ceb4ff6 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -54,7 +54,7 @@ static int use_blacklist = 0;
 static int force = 0;
 static int strip_modversion = 0;
 static int strip_vermagic = 0;
-static int remove_dependencies = 0;
+static int remove_holders = 0;
 static int quiet_inuse = 0;
 
 static const char cmdopts_s[] = "arRibfDcnC:d:S:sqvVh";
@@ -62,6 +62,7 @@ static const struct option cmdopts[] = {
 	{"all", no_argument, 0, 'a'},
 	{"remove", no_argument, 0, 'r'},
 	{"remove-dependencies", no_argument, 0, 5},
+	{"remove-holders", no_argument, 0, 5},
 	{"resolve-alias", no_argument, 0, 'R'},
 	{"first-time", no_argument, 0, 3},
 	{"ignore-install", no_argument, 0, 'i'},
@@ -107,7 +108,8 @@ static void help(void)
 		"\t                            be a module name to be inserted\n"
 		"\t                            or removed (-r)\n"
 		"\t-r, --remove                Remove modules instead of inserting\n"
-		"\t    --remove-dependencies   Also remove modules depending on it\n"
+		"\t    --remove-dependencies   Deprecated: use --remove-holders\n"
+		"\t    --remove-holders        Also remove module holders (use together with -r)\n"
 		"\t-R, --resolve-alias         Only lookup and print alias and exit\n"
 		"\t    --first-time            Fail if module already inserted or removed\n"
 		"\t-i, --ignore-install        Ignore install commands\n"
@@ -353,7 +355,7 @@ static int rmmod_do_remove_module(struct kmod_module *mod)
 	return err;
 }
 
-#define RMMOD_FLAG_DO_DEPENDENCIES	0x1
+#define RMMOD_FLAG_REMOVE_HOLDERS	0x1
 #define RMMOD_FLAG_IGNORE_BUILTIN	0x2
 static int rmmod_do_module(struct kmod_module *mod, int flags);
 
@@ -416,10 +418,10 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
 
 	rmmod_do_modlist(post, false);
 
-	if ((flags & RMMOD_FLAG_DO_DEPENDENCIES) && remove_dependencies) {
-		struct kmod_list *deps = kmod_module_get_dependencies(mod);
+	if ((flags & RMMOD_FLAG_REMOVE_HOLDERS) && remove_holders) {
+		struct kmod_list *holders = kmod_module_get_holders(mod);
 
-		err = rmmod_do_modlist(deps, true);
+		err = rmmod_do_modlist(holders, true);
 		if (err < 0)
 			goto error;
 	}
@@ -469,7 +471,7 @@ static int rmmod(struct kmod_ctx *ctx, const char *alias)
 
 	kmod_list_foreach(l, list) {
 		struct kmod_module *mod = kmod_module_get_module(l);
-		err = rmmod_do_module(mod, RMMOD_FLAG_DO_DEPENDENCIES);
+		err = rmmod_do_module(mod, RMMOD_FLAG_REMOVE_HOLDERS);
 		kmod_module_unref(mod);
 		if (err < 0)
 			break;
@@ -787,7 +789,7 @@ static int do_modprobe(int argc, char **orig_argv)
 			do_remove = 1;
 			break;
 		case 5:
-			remove_dependencies = 1;
+			remove_holders = 1;
 			break;
 		case 'R':
 			lookup_only = 1;
-- 
2.35.1

