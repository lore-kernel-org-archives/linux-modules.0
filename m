Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3859C61DA4
	for <linux-modules@archiver.kernel.org>; Wed, 15 Mar 2023 13:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjCONze (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 15 Mar 2023 09:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjCONzZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 15 Mar 2023 09:55:25 -0400
X-Greylist: delayed 406 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Mar 2023 06:55:20 PDT
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C17CA06
        for <linux-modules@vger.kernel.org>; Wed, 15 Mar 2023 06:55:19 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Wed, 15 Mar 2023 14:48:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1678888108; bh=SHZgYSYyEpfoS4k1RwAmcpWd4VhASHB3Z1a/z0dZ5fw=;
        h=From:Date:Subject:To:Cc:From;
        b=FYzMQ8nii1wd45Hl62iesOd+5SZCgBUOK42sYTpVEtrJbrLQVf5F8zhQYqjmZQ4Ne
         QPHTgkg6i8+o6gthPvhwR2LmS6kEdvnvRwRelvxIylDd4nl/W9ppIyR8nt8HsVO4iE
         W2/CDzNrPA/uDNhDMq4ye/OHafSqpCDmMKStH734=
From:   Nicolas Schier <nschier-oss@avm.de>
Date:   Wed, 15 Mar 2023 14:48:16 +0100
Subject: [PATCH] kmod: modprobe: Remove holders recursively
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230309-remove-holders-recursively-v1-1-c27cdba1edbf@avm.de>
X-B4-Tracking: v=1; b=H4sIAJ/MEWQC/xXMQQrDIBAF0KuEWXfAKiS0tzH6UwcShZlWKCF3r
 12+zTvJoAKj53SSootJqwP320SpxPoCSx4m73xwwT1YcbQOLm3PUBtMHzXp2L+8zfOyBQ8fl0w
 jWKOBV401lX9xRHtD6bp+m5wZBnUAAAA=
To:     linux-modules@vger.kernel.org
Cc:     Nicolas Schier <n.schier@avm.de>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4767; i=n.schier@avm.de;
 h=from:subject:message-id; bh=2SXHWU9ZymUduQ87zzHbuyS6m44mKj7cgeOalyYOuzg=;
 b=owEBbQKS/ZANAwAIAYjGvJyImm24AcsmYgBkEcyr2qvtRgIOb3h6mwBWUakLp4HBX0tDgTUS0
 zZsN03DtVSJAjMEAAEIAB0WIQQO/4WJ63TpgecLpGmIxryciJptuAUCZBHMqwAKCRCIxryciJpt
 uKSKD/9HYBcc555TYjEK/EHIVrQ4r0ferTRESKbAzx66BVHTg57zMpXA4mIHspp6uCU+mQk3Oqa
 s5VTyuZYc6ctDG0rUWcQHgBCK9HBBxaXUaaMBQ4KfBKG1L2MlC2rgglurncjbbgt9xoQLNixKlu
 H/aRpdupLhzEZidbA3sJGVXfSFfwpjoQ3V7QQ8BJE94NMtSZi/iSuPmajQcY9HdQYCTFOjTaJib
 EAelrJiCgu6u3l4W3oY5dix9NuX5MFBWC8Ga67Fd8mCDvi8xaqY/FCAXF/Ff6uFIG+LJ6HwQNkt
 cK/E9G7j12xsG5dDocma3DknvyfLG6EHvO+/bMyBWVCKFIfIBTKTbdpdi6oalHXkK1YZD+ZSLIV
 JQs8PCT/73isD4QJGus+8psegg005xgLiMo46IbUBydQ9yULYJZ1XpZ0uzJ3Cc37B1xAzRJW++w
 As+790DkidBhXxaVrtHYCDacrViIfSipiQS01nYl7ASPtjswvAkyG6Hf3wFqJ8cHHjir0LLd7cF
 RkpIAWRZXUp6jQF9sQ0yzcmgCgL6Y6a+gGYqfv1h5e2NY5+tNZ+UojtvGCp8ds3lO6wAZr+/TrS
 NtxaxeXLsgnXpc7HGVMj27e58h/pu0C+zwKmwod+XX31zKXGMS/Y3zMM8RenCwFLu/ScZL0SdSE
 7zmubN+KjthUlMg==
X-Developer-Key: i=n.schier@avm.de; a=openpgp;
 fpr=7CF67EF8868721AFE53D73FDBDE3A6CC4E333CC8
X-purgate-ID: 149429::1678888107-C5DCF088-8485FE09/0/0
X-purgate-type: clean
X-purgate-size: 4811
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Nicolas Schier <n.schier@avm.de>

Remove holders recursively when removal of module holders is requested.

Extend commit 42b32d30c38e ("modprobe: Fix holders removal") by removing
also indirect holders if --remove-holders is set.  For a simple module
dependency chain like

  module3 depends on module2
  module2 depends on module1

'modprobe -r --remove-holders module1' will remove module3, module2 and
module1 in correct order:

  $ modprobe -r --remove-holders module1 --verbose
  rmmod module3
  rmmod module2
  rmmod module1

(Actually, it will do the same when specifying module2 or module3 for
removal instead of module1.)

As a side-effect, 'modprobe -r module3' (w/o --remove-holders) will also
remove all three modules, as after removal of module3, module2 does not
have any holders and the same holds for module1 after removal of
module2:

  $ modprobe -r module3 --verbose
  rmmod module3
  rmmod module2
  rmmod module1

Without recursive evaluation of holders, modprobe leaves module1 loaded.

Unfortunately, '--dry-run --remove-holders' breaks with indirect
dependencies.

Signed-off-by: Nicolas Schier <n.schier@avm.de>
---
While commit 42b32d30c38e ("modprobe: Fix holders removal", 2022-03-29) already
implements removing first-level holders, indirect holders were not evaluated.
In a simple module dependency chain like

      module3 depends on module2
      module2 depends on module1

'modprobe -r --remove-holders module1' was only considering module2 and module1
and thus had to fail as module3 was still loaded and blocking removal of
module2.

By doing recursive depth-first removal this can be fixed for such simple
dependency.
---
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
I am a bit unhappy about the introduction of the 'recursive' parameter
to rmmod_do_modlist() as it always holds the same value as
stop_on_errors; is re-using (and renaming) possibly a better option?
---
 tools/modprobe.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/tools/modprobe.c b/tools/modprobe.c
index 3b7897c..9cbb236 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -390,13 +390,25 @@ static int rmmod_do_remove_module(struct kmod_module *mod)
 static int rmmod_do_module(struct kmod_module *mod, int flags);
 
 /* Remove modules in reverse order */
-static int rmmod_do_modlist(struct kmod_list *list, bool stop_on_errors)
+static int rmmod_do_modlist(struct kmod_list *list, bool stop_on_errors,
+			    bool recursive)
 {
 	struct kmod_list *l;
 
 	kmod_list_foreach_reverse(l, list) {
 		struct kmod_module *m = kmod_module_get_module(l);
-		int r = rmmod_do_module(m, RMMOD_FLAG_IGNORE_BUILTIN);
+		int r = 0;
+
+		if (recursive) {
+			struct kmod_list *holders = kmod_module_get_holders(m);
+
+			r = rmmod_do_modlist(holders, stop_on_errors,
+					     recursive);
+		}
+
+		if (!r)
+			r = rmmod_do_module(m, RMMOD_FLAG_IGNORE_BUILTIN);
+
 		kmod_module_unref(m);
 
 		if (r < 0 && stop_on_errors)
@@ -448,13 +460,13 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
 	}
 
 	/* 1. @mod's post-softdeps in reverse order */
-	rmmod_do_modlist(post, false);
+	rmmod_do_modlist(post, false, false);
 
 	/* 2. Other modules holding @mod */
 	if (flags & RMMOD_FLAG_REMOVE_HOLDERS) {
 		struct kmod_list *holders = kmod_module_get_holders(mod);
 
-		err = rmmod_do_modlist(holders, true);
+		err = rmmod_do_modlist(holders, true, true);
 		if (err < 0)
 			goto error;
 	}
@@ -472,9 +484,16 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
 		}
 	}
 
-	if (!cmd)
-		err = rmmod_do_remove_module(mod);
-	else
+	if (!cmd) {
+		int state = kmod_module_get_initstate(mod);
+
+		if (state < 0) {
+			/* Module was removed during recursive holder removal */
+			err = 0;
+		} else {
+			err = rmmod_do_remove_module(mod);
+		}
+	} else
 		err = command_do(mod, "remove", cmd, NULL);
 
 	if (err < 0)
@@ -488,14 +507,14 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
 		kmod_list_foreach(itr, deps) {
 			struct kmod_module *dep = kmod_module_get_module(itr);
 			if (kmod_module_get_refcnt(dep) == 0)
-				rmmod_do_remove_module(dep);
+				rmmod_do_module(dep, flags);
 			kmod_module_unref(dep);
 		}
 		kmod_module_unref_list(deps);
 	}
 
 	/* 5. @mod's pre-softdeps in reverse order: errors are non-fatal */
-	rmmod_do_modlist(pre, false);
+	rmmod_do_modlist(pre, false, false);
 
 error:
 	kmod_module_unref_list(pre);

---
base-commit: 3d1bd339ab942ea47e60f053f4b11b0c47ff082b
change-id: 20230309-remove-holders-recursively-f667f32e2a7d

Best regards,
-- 
Nicolas Schier

