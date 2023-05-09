Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60175C77B7C
	for <linux-modules@archiver.kernel.org>; Tue,  9 May 2023 13:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjEINtP (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 9 May 2023 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjEINtO (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 9 May 2023 09:49:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E1F3C1E
        for <linux-modules@vger.kernel.org>; Tue,  9 May 2023 06:49:04 -0700 (PDT)
Date:   Tue, 9 May 2023 15:49:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683640143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=v+DX89zs3pzr9ifTHXskaWPil2fnzXteDPpVzvXKgCM=;
        b=N/lipH4JgEJohAlsG5QC0B8ZRyM4f0IViacniM8heeGIaNMtU1n3tpGhecncQSocR2W9IN
        3SoW/gPmvyd8CsPN8t786KVCdWszaNP2R/1s3mMiZHE3cLBhQ7ICIY3CZ14lHOrTGhzurn
        me9Chh71Gie+R5OK5rpuJw98BtMC76/PIqfPU5JeOwPe2VPP4rX2bcMNEn1z7YjxLTyYJB
        ujyyr2vGwLM7K24MnMy4LFIfG06QVuhlwASYQB5HjxcG4E3rMbo26kaXoBdyCTqPbtztb7
        GcijxGvpBfsCv23MmDASnT0a7EcJLHoNHkWMWAyKjhOgBJT3JXAUiKRxcV4gCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683640143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=v+DX89zs3pzr9ifTHXskaWPil2fnzXteDPpVzvXKgCM=;
        b=QPEeMNqmJZPkgj/pDukO6Dbr8hySwtUV4nWfKrxT07RVzhXbvoh7K3oA2hTfvKGYoerjHm
        Q659cSnyVQcvrTCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-modules@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] module: Remove preempt_disable() from module reference
 counting.
Message-ID: <20230509134902.yQ-EWRpI@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The preempt_disable() section in module_put() was added in commit
   e1783a240f491 ("module: Use this_cpu_xx to dynamically allocate counters")

while the per-CPU counter were switched to another API. The API requires
that during the RMW operation the CPU remained the same.

This counting API was later replaced with atomic_t in commit
   2f35c41f58a97 ("module: Replace module_ref with atomic_t refcnt")

Since this atomic_t replacement there is no need to keep preemption
disabled while the reference counter is modified.

Remove preempt_disable() from module_put(), __module_get() and
try_module_get().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/module/main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 044aa2c9e3cb0..ea7d0c7f3e60d 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -820,10 +820,8 @@ static struct module_attribute modinfo_refcnt =
 void __module_get(struct module *module)
 {
 	if (module) {
-		preempt_disable();
 		atomic_inc(&module->refcnt);
 		trace_module_get(module, _RET_IP_);
-		preempt_enable();
 	}
 }
 EXPORT_SYMBOL(__module_get);
@@ -833,15 +831,12 @@ bool try_module_get(struct module *module)
 	bool ret = true;
 
 	if (module) {
-		preempt_disable();
 		/* Note: here, we can fail to get a reference */
 		if (likely(module_is_live(module) &&
 			   atomic_inc_not_zero(&module->refcnt) != 0))
 			trace_module_get(module, _RET_IP_);
 		else
 			ret = false;
-
-		preempt_enable();
 	}
 	return ret;
 }
@@ -852,11 +847,9 @@ void module_put(struct module *module)
 	int ret;
 
 	if (module) {
-		preempt_disable();
 		ret = atomic_dec_if_positive(&module->refcnt);
 		WARN_ON(ret < 0);	/* Failed to put refcount */
 		trace_module_put(module, _RET_IP_);
-		preempt_enable();
 	}
 }
 EXPORT_SYMBOL(module_put);
-- 
2.40.1

