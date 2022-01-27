Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476F7C433F5
	for <linux-modules@archiver.kernel.org>; Thu, 27 Jan 2022 23:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244501AbiA0Xkd (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 27 Jan 2022 18:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236183AbiA0Xkc (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 27 Jan 2022 18:40:32 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D671C061714
        for <linux-modules@vger.kernel.org>; Thu, 27 Jan 2022 15:40:31 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q3-20020a258203000000b0061931e14fe7so2227453ybk.11
        for <linux-modules@vger.kernel.org>; Thu, 27 Jan 2022 15:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yFBxaeHlXjXrEAjtBVnJS5X3X8ptkwpLlqobGOAO4po=;
        b=Ce6iLPIQWKLfzLwp+KOETyQ6kf0+1rabs3crEUlz8YrBYJC/YY2lyr5R/cbEjJht29
         AtH1VGsPaqYSii/MhAPPvTnQsOGOdyNeimknNvkd8Bb03LIOEPQwXSs5Q5xivgaFxdQD
         1EmFutqCJ49XToIeVA3S8uR6eLQs7c5fuPq/EDK8CZ4eV1A843gRrJh2KGYw7kG65iPw
         BMf6U0fx7b9Zacti2OeGo/zYppnH1a67wPZEZJ5uffjqY4Z5ifPcr3hWwpzarr5xb4LY
         ibDQ8jL1TVoqsV9G8m/6g4oCUKXbp6GR3zxAJZfbxUBV1r7cNRmtCCJ9+pRE25683RrY
         SM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yFBxaeHlXjXrEAjtBVnJS5X3X8ptkwpLlqobGOAO4po=;
        b=eHFtO8JVz4MnV2TxjcYLlSgwBX6mML27MTzhoQWvY31/+pigDGrc2j7llVvFsK9c2i
         pROOV5/sk+54MO9JEAkouWBTxhuTKVZ6qxA+52IgHck2EaKsA12hMr+hBExsg6twEyaW
         oxdiG7JKkbvWrNEoc5o+RfRZL9nk3VX5ww4845YsG0M+QLzBBig25aHjkSRV5zunVXyR
         DDl9+iDsemY7v3oQWgk3jU49gJ1MgL00UZAHwiEF9zFYOfpPdrDlurWYsecUD74k1UsD
         pwcaPEwit3m3e+xK9bJJxxayBW4NRou+jh4ZLiR8aYPlZltotJPHn6Cgw4DqtZ5ImFgc
         5IwA==
X-Gm-Message-State: AOAM531NqBcteqGb+o2dsGdWzZ/6GB5AZbR5qlVgyaHqcvrEtE6UpRGd
        JaBp8Btg9L/jF0d6/eEJ1qTUIZWRRnk8Yw==
X-Google-Smtp-Source: ABdhPJzsntUA4qe3swAu1loe9zf1paZtVP4HeNWmwBLFhpee3x2Coyx0BMWFxGlKRQz/gHpfMjnIul7+NJmSQg==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:11:8e8f:af2f:deb6:adb3])
 (user=ipylypiv job=sendgmr) by 2002:a81:4853:: with SMTP id
 v80mr3ywa.66.1643326830448; Thu, 27 Jan 2022 15:40:30 -0800 (PST)
Date:   Thu, 27 Jan 2022 15:39:53 -0800
Message-Id: <20220127233953.2185045-1-ipylypiv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH] Revert "module, async: async_synchronize_full() on module
 init iff async is used"
From:   Igor Pylypiv <ipylypiv@google.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changyuan Lyu <changyuanl@google.com>,
        Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This reverts commit 774a1221e862b343388347bac9b318767336b20b.

We need to finish all async code before the module init sequence is done.
In the reverted commit the PF_USED_ASYNC flag was added to mark a thread
that called async_schedule(). Then the PF_USED_ASYNC flag was used to
determine whether or not async_synchronize_full() needs to be invoked.
This works when modprobe thread is calling async_schedule(), but it
does not work if module dispatches init code to a worker thread which
then calls async_schedule().

For example, PCI driver probing is invoked from a worker thread based on
a node where device is attached:

	if (cpu < nr_cpu_ids)
		error = work_on_cpu(cpu, local_pci_probe, &ddi);
	else
		error = local_pci_probe(&ddi);

We end up in a situation where a worker thread gets the PF_USED_ASYNC flag
set instead of the modprobe thread. As a result, async_synchronize_full()
is not invoked and modprobe completes without waiting for the async code
to finish.

The issue was discovered while loading the pm80xx driver:
(scsi_mod.scan=async)

modprobe pm80xx                      worker
...
  do_init_module()
  ...
    pci_call_probe()
      work_on_cpu(local_pci_probe)
                                     local_pci_probe()
                                       pm8001_pci_probe()
                                         scsi_scan_host()
                                           async_schedule()
                                           worker->flags |= PF_USED_ASYNC;
                                     ...
      < return from worker >
  ...
  if (current->flags & PF_USED_ASYNC) <--- false
  	async_synchronize_full();

Commit 21c3c5d28007 ("block: don't request module during elevator init")
fixed the deadlock issue which the reverted commit 774a1221e862 ("module,
async: async_synchronize_full() on module init iff async is used") tried
to fix.

Since commit 0fdff3ec6d87 ("async, kmod: warn on synchronous
request_module() from async workers") synchronous module loading
from async is not allowed.

Given that the original deadlock issue is fixed and it is no longer allowed
to call synchronous request_module() from async we can remove PF_USED_ASYNC
flag to make module init consistently invoke async_synchronize_full()
unless async module probe is requested.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Reviewed-by: Changyuan Lyu <changyuanl@google.com>
---
 include/linux/sched.h |  1 -
 kernel/async.c        |  3 ---
 kernel/module.c       | 25 +++++--------------------
 3 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f5b2be39a78c..75ba8aa60248 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1680,7 +1680,6 @@ extern struct pid *cad_pid;
 #define PF_MEMALLOC		0x00000800	/* Allocating memory */
 #define PF_NPROC_EXCEEDED	0x00001000	/* set_user() noticed that RLIMIT_NPROC was exceeded */
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
-#define PF_USED_ASYNC		0x00004000	/* Used async_schedule*(), used by module init */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
 #define PF_FROZEN		0x00010000	/* Frozen for system suspend */
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
diff --git a/kernel/async.c b/kernel/async.c
index b8d7a663497f..b2c4ba5686ee 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -205,9 +205,6 @@ async_cookie_t async_schedule_node_domain(async_func_t func, void *data,
 	atomic_inc(&entry_count);
 	spin_unlock_irqrestore(&async_lock, flags);
 
-	/* mark that this task has queued an async job, used by module init */
-	current->flags |= PF_USED_ASYNC;
-
 	/* schedule for execution */
 	queue_work_node(node, system_unbound_wq, &entry->work);
 
diff --git a/kernel/module.c b/kernel/module.c
index 24dab046e16c..46a5c2ed1928 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3725,12 +3725,6 @@ static noinline int do_init_module(struct module *mod)
 	}
 	freeinit->module_init = mod->init_layout.base;
 
-	/*
-	 * We want to find out whether @mod uses async during init.  Clear
-	 * PF_USED_ASYNC.  async_schedule*() will set it.
-	 */
-	current->flags &= ~PF_USED_ASYNC;
-
 	do_mod_ctors(mod);
 	/* Start the module */
 	if (mod->init != NULL)
@@ -3756,22 +3750,13 @@ static noinline int do_init_module(struct module *mod)
 
 	/*
 	 * We need to finish all async code before the module init sequence
-	 * is done.  This has potential to deadlock.  For example, a newly
-	 * detected block device can trigger request_module() of the
-	 * default iosched from async probing task.  Once userland helper
-	 * reaches here, async_synchronize_full() will wait on the async
-	 * task waiting on request_module() and deadlock.
-	 *
-	 * This deadlock is avoided by perfomring async_synchronize_full()
-	 * iff module init queued any async jobs.  This isn't a full
-	 * solution as it will deadlock the same if module loading from
-	 * async jobs nests more than once; however, due to the various
-	 * constraints, this hack seems to be the best option for now.
-	 * Please refer to the following thread for details.
+	 * is done. This has potential to deadlock if synchronous module
+	 * loading is requested from async (which is not allowed!).
 	 *
-	 * http://thread.gmane.org/gmane.linux.kernel/1420814
+	 * See commit 0fdff3ec6d87 ("async, kmod: warn on synchronous
+	 * request_module() from async workers") for more details.
 	 */
-	if (!mod->async_probe_requested && (current->flags & PF_USED_ASYNC))
+	if (!mod->async_probe_requested)
 		async_synchronize_full();
 
 	ftrace_free_mem(mod, mod->init_layout.base, mod->init_layout.base +
-- 
2.35.0.rc0.227.g00780c9af4-goog

