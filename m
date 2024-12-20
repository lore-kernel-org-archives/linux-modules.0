Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A59221B8EC;
	Fri, 20 Dec 2024 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716861; cv=none; b=oHFWiNBpo5wY8/qqqsRPZyFwpjauitLanIbE1JxFXj8bg/cB4UuCKZ/fCwD8BCBZtabZHGBQSunOHt4qNdKx6iZo2L0uXSYOcf5zmXFV38Kt92HizILWqVlVyKxAxhSGbbxzuBEkWQitiYWCtU5KXvMBJdNr6E/i+OV8di0xP/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716861; c=relaxed/simple;
	bh=QdGgvi5tGLhqK/dn8eqwWdqKTl7Q/eJpMW6qel5l0U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkWOVzmyV7ZFgVbeyj45PlzxcgZ44YvIMQNu9Lcrs+COe3Xg/cRtcaSTLwE9bdSKP8y15clw4rG0X1fOPCqMnmOEYx5GVJ2V4yzZRlfLK81C94bxU2/MBo/oNmR1l5klQZM/faT9eujyd9tn8/cMuoVwcgLxgm5EcGKz0f3FlAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uzaDzhxy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UCDe4W+R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uzaDzhxy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UCDe4W+R"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZPVA+hMuMw4hY+ZysB1dEUHiJRu5pyZbasptXv2BLE=;
	b=uzaDzhxyXTmQkSAc0K1o4EMvNAGHIaRmJgFnXUDBLpnvTUnNrZF3IxQkXMle9DOIFP09p/
	O7zZLgMPdleFJZIXFqLSZJcrzBvqqKE/kEvGg0zipZGBRgVKz+mhEmDP1287wupJV/gLxF
	ypzJD+OaLRCOvUuBu8NmmmJ0bGMOHWk20iKmmZreszoLH0892mlHLatJ1MtUAyeUv4ESn0
	mNgAaImBa82wn6k4oDam631nNIqzntqcABW1NoiMb5HF/vlwSwLpME4lHkktI92H76Gy+J
	UfFAC79ayMJdVL2FR69lvI1bz3KOtmPS5NJkHKLzEI42zrSvAOfpG9+5Pcdw/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZPVA+hMuMw4hY+ZysB1dEUHiJRu5pyZbasptXv2BLE=;
	b=UCDe4W+R3XaIKdQffGUi5fHZGIwds2AsVpryRDLi64OiuicjkjUwQiZYw0G0az544Oncy+
	VrA1AxFUfEkyrVDw==
To: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 02/28] module: Begin to move from RCU-sched to RCU.
Date: Fri, 20 Dec 2024 18:41:16 +0100
Message-ID: <20241220174731.514432-3-bigeasy@linutronix.de>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The RCU usage in module was introduced in commit d72b37513cdfb ("Remove
stop_machine during module load v2") and it claimed not to be RCU but
similar. Then there was another improvement in commit e91defa26c527
("module: don't use stop_machine on module load"). It become a mix of
RCU and RCU-sched and was eventually fixed 0be964be0d450 ("module:
Sanitize RCU usage and locking"). Later RCU & RCU-sched was merged in
commit cb2f55369d3a9 ("modules: Replace synchronize_sched() and
call_rcu_sched()") so that was aligned.

Looking at it today, there is still leftovers. The preempt_disable() was
used instead rcu_read_lock_sched(). The RCU & RCU-sched merge was not
complete as there is still rcu_dereference_sched() for module::kallsyms.

The RCU-list modules and unloaded_tainted_modules are always accessed
under RCU protection or the module_mutex. The modules list iteration can
always happen safely because the module will not disappear.
Once the module is removed (free_module()) then after removing the
module from the list, there is a synchronize_rcu() which waits until
every RCU reader left the section. That means iterating over the list
within a RCU-read section is enough, there is no need to disable
preemption. module::kallsyms is first assigned in add_kallsyms() before
the module is added to the list. At this point, it points to init data.
This pointer is later updated and before the init code is removed there
is also synchronize_rcu() in do_free_init(). That means A RCU read lock
is enough for protection and rcu_dereference() can be safely used.

Convert module code and its users step by step. Update comments and
convert print_modules() to use RCU.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/module/main.c        | 9 ++++-----
 kernel/module/tree_lookup.c | 8 ++++----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5399c182b3cbe..5cce4a92d7ba3 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -67,7 +67,7 @@
=20
 /*
  * Mutex protects:
- * 1) List of modules (also safely readable with preempt_disable),
+ * 1) List of modules (also safely readable within RCU read section),
  * 2) module_use links,
  * 3) mod_tree.addr_min/mod_tree.addr_max.
  * (delete and add uses RCU list operations).
@@ -1348,7 +1348,7 @@ static void free_module(struct module *mod)
 	mod_tree_remove(mod);
 	/* Remove this module from bug list, this uses list_del_rcu */
 	module_bug_cleanup(mod);
-	/* Wait for RCU-sched synchronizing before releasing mod->list and buglis=
t. */
+	/* Wait for RCU synchronizing before releasing mod->list and buglist. */
 	synchronize_rcu();
 	if (try_add_tainted_module(mod))
 		pr_err("%s: adding tainted module to the unloaded tainted modules list f=
ailed.\n",
@@ -2965,7 +2965,7 @@ static noinline int do_init_module(struct module *mod)
 #endif
 	/*
 	 * We want to free module_init, but be aware that kallsyms may be
-	 * walking this with preempt disabled.  In all the failure paths, we
+	 * walking this within an RCU read section. In all the failure paths, we
 	 * call synchronize_rcu(), but we don't want to slow down the success
 	 * path. execmem_free() cannot be called in an interrupt, so do the
 	 * work and call synchronize_rcu() in a work queue.
@@ -3754,7 +3754,7 @@ void print_modules(void)
=20
 	printk(KERN_DEFAULT "Modules linked in:");
 	/* Most callers should already have preempt disabled, but make sure */
-	preempt_disable();
+	guard(rcu)();
 	list_for_each_entry_rcu(mod, &modules, list) {
 		if (mod->state =3D=3D MODULE_STATE_UNFORMED)
 			continue;
@@ -3762,7 +3762,6 @@ void print_modules(void)
 	}
=20
 	print_unloaded_tainted_modules();
-	preempt_enable();
 	if (last_unloaded_module.name[0])
 		pr_cont(" [last unloaded: %s%s]", last_unloaded_module.name,
 			last_unloaded_module.taints);
diff --git a/kernel/module/tree_lookup.c b/kernel/module/tree_lookup.c
index 277197977d438..d3204c5c74eb7 100644
--- a/kernel/module/tree_lookup.c
+++ b/kernel/module/tree_lookup.c
@@ -12,11 +12,11 @@
=20
 /*
  * Use a latched RB-tree for __module_address(); this allows us to use
- * RCU-sched lookups of the address from any context.
+ * RCU lookups of the address from any context.
  *
- * This is conditional on PERF_EVENTS || TRACING because those can really =
hit
- * __module_address() hard by doing a lot of stack unwinding; potentially =
from
- * NMI context.
+ * This is conditional on PERF_EVENTS || TRACING || CFI_CLANG because thos=
e can
+ * really hit __module_address() hard by doing a lot of stack unwinding;
+ * potentially from NMI context.
  */
=20
 static __always_inline unsigned long __mod_tree_val(struct latch_tree_node=
 *n)
--=20
2.45.2

