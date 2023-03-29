Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AA3C74A5B
	for <linux-modules@archiver.kernel.org>; Wed, 29 Mar 2023 13:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjC2NwB (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 29 Mar 2023 09:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjC2NwA (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 29 Mar 2023 09:52:00 -0400
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9150BC2
        for <linux-modules@vger.kernel.org>; Wed, 29 Mar 2023 06:51:55 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Wed, 29 Mar 2023 15:51:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1680097911; bh=m1MzdyuxEEf5u0uRqJS2MGr2R18vAxupmz7GpC9+JfQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=phJE+alrEtGRVQxRq/WRUsaIJjvi9MhfAT4HbCtqTXAt3gmiSqexitmcmPUcBx2S0
         jK8F3Pl9RcgrD6BcGUD91N9XAU1Dsx08VsBfGp6xcOPNrowj8YbU71Rg1qP/XtYKTR
         JUYEHD3MwiUQ6vHEGi/LEjMivfXPnqrY17Wt15ng=
Received: from island.ads.avm.de (unknown [172.17.88.185])
        by mail-auth.avm.de (Postfix) with ESMTPA id 6E2F281ECE;
        Wed, 29 Mar 2023 15:51:51 +0200 (CEST)
Received: from island.fjasle.eu (localhost [IPv6:::1])
        by island.ads.avm.de (Postfix) with ESMTP id 6652D520580;
        Wed, 29 Mar 2023 15:51:51 +0200 (CEST)
From:   Nicolas Schier <n.schier@avm.de>
Date:   Wed, 29 Mar 2023 15:51:35 +0200
Subject: [PATCH v2 1/3] kmod: modprobe: Remove holders recursively
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230309-remove-holders-recursively-v2-1-8a8120269cc1@avm.de>
References: <20230309-remove-holders-recursively-v2-0-8a8120269cc1@avm.de>
In-Reply-To: <20230309-remove-holders-recursively-v2-0-8a8120269cc1@avm.de>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Nicolas Schier <nicolas@fjasle.eu>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4780; i=n.schier@avm.de;
 h=from:subject:message-id; bh=m1MzdyuxEEf5u0uRqJS2MGr2R18vAxupmz7GpC9+JfQ=;
 b=owEBbQKS/ZANAwAIAYjGvJyImm24AcsmYgBkJEJ25ZwpCZ+E5fZ0jAcJUsvuOG9fWJCNnFwrX
 1NO6mpPGfmJAjMEAAEIAB0WIQQO/4WJ63TpgecLpGmIxryciJptuAUCZCRCdgAKCRCIxryciJpt
 uNKrD/97F9FrYFXufoXsP1MbJgYYYRl/ysaC03oYemOZIZlYSIiCJBcoZLL72uA/M6EHqsOmYiY
 6inWy5jya/FOz770X0GwEKMR8qkgpywXfdZpU3jV40UTJMUTHte6CpWTAiq183oGkyYpH3nZT1D
 RKro6iwk5nxXfAug2fWODDAWj9igKfGTlQ+1jXi/VZAaxma7Cf9NFPp3k1NsvdbDSSQnhbcnDHA
 ELGzxEB0Fm1h+KiQix4Er80KYj6EMFgWyeaY+S0jPPmyl5NrJ9rINdKTxdAUziYGI4g3Je6T/8p
 oZTpLV5GcelAC+hbsFGmcAIJOZZKQQlzFgV6oNom8YZ7yOzFhwpMEa0zC0S/cMhUGN2t2a4vOyy
 6rhDfaOXD+dFlf7lvEMGEuNqN8IXj0OtS5K+2gnq8i4q+mLScIw6Y4v3rJSKoMldlG70ZZU5hbS
 r6LpWJCiorri473oh744xjzs157wmdCVhnFLw30DWh0v83woH1RWgcF7fCGLZt5SATjM4yIHRS3
 2XYU49YEdBAlvswvNP95Arp1nNZ9vxtXszliU6PJ9ikgwVO8+ZUZvoFuZC57qdQKWShlJYhxhV1
 ujaCOu8dzIE+6P2/QtyiIJCOLQE3Z8Zih7ARgUb3Io736e1UaoPVmPfTxp6xniSv4hoFxR69BB+
 kpYlOuOY8Tl4mDQ==
X-Developer-Key: i=n.schier@avm.de; a=openpgp;
 fpr=7CF67EF8868721AFE53D73FDBDE3A6CC4E333CC8
X-purgate-ID: 149429::1680097910-56FF3D8F-8E3F6613/0/0
X-purgate-type: clean
X-purgate-size: 4782
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

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
remove all three modules from the example above, as after removal of
module3, module2 does not have any holders and the same holds for
module1 after removal of module2:

  $ modprobe -r module3 --verbose
  rmmod module3
  rmmod module2
  rmmod module1

Without recursive evaluation of holders, modprobe leaves module1 loaded.

Unfortunately, '--dry-run --remove-holders' breaks with indirect
dependencies.

Signed-off-by: Nicolas Schier <n.schier@avm.de>
---
I am a bit unhappy about the introduction of the 'recursive' parameter
to rmmod_do_modlist() as it always holds the same value as
stop_on_errors; is re-using (and renaming) possibly a better option?

modprobe --remove --remove-holders --dry-run now ignores current
refcounts of loaded modules when simulating removal of holders.

Changes in v2:
  * Handle modules that have just been removed, gently
  * Fix --dry-run by ignoring module refcounts (_only_ for --dry-run)
  * Add missing kmod_module_unref_list() calls
---
 tools/modprobe.c | 44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/tools/modprobe.c b/tools/modprobe.c
index 3b7897c..a705f88 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -390,13 +390,27 @@ static int rmmod_do_remove_module(struct kmod_module *mod)
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
+		if (recursive && kmod_module_get_initstate(m) >= 0) {
+			struct kmod_list *holders = kmod_module_get_holders(m);
+
+			r = rmmod_do_modlist(holders, stop_on_errors,
+					     recursive);
+
+			kmod_module_unref_list(holders);
+		}
+
+		if (!r)
+			r = rmmod_do_module(m, RMMOD_FLAG_IGNORE_BUILTIN);
+
 		kmod_module_unref(m);
 
 		if (r < 0 && stop_on_errors)
@@ -448,15 +462,17 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
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
+
+		kmod_module_unref_list(holders);
 	}
 
 	/* 3. @mod itself, but check for refcnt first */
@@ -472,9 +488,16 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
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
@@ -488,14 +511,14 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
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
@@ -975,6 +998,9 @@ static int do_modprobe(int argc, char **orig_argv)
 	     fstat(fileno(stderr), &stat_buf)))
 		use_syslog = 1;
 
+	if (remove_holders && dry_run)
+		ignore_loaded = 1;
+
 	log_open(use_syslog);
 
 	if (!do_show_config) {

-- 
2.40.0

