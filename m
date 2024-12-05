Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2401AD9F9
	for <linux-modules@vger.kernel.org>; Thu,  5 Dec 2024 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733435469; cv=none; b=hXySY2L2cDGjpmVgz7qgiCCU13XZaLbOEcoQBOiJi6MEPFUt2z+bC9cSj/8MIJtp1WS2rI9wpMnEnRMbJnuetjEwD0izRt7yeG0ALcAyDPjlHX2qAPwLGdzYwU8V/jAfeOhLYwUIQglGSj/2GyE19FrZ+U8L4oyaV9l5T4Lz6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733435469; c=relaxed/simple;
	bh=VB9N9q77J5BOdd68IilQOQSiVF/oqZZQaOOD92H7k/w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iu4OBxo6nvxurY6ZgBS2tmUgcvXVJ0TT0RFHg4S5NzWpPqNxxNzc5Qp2aju0NK2HB+BMwJls/FYbsVKW6WPJX6BVqK/+/RCAPSE7YNutDJgt0/KN93XBv2/NZdL58AC6rc3JgMPeXICwelCqNk6xpagGa8PB+Jv9D2I2+9knGw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BquSgeqD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E+YxWRuh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BquSgeqD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E+YxWRuh"
Date: Thu, 5 Dec 2024 22:51:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733435464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=K8veU2bn/WSzKYzI0uQfkif7qeF3lByRhXDDopyF/+M=;
	b=BquSgeqDI17/4/Kph2yIJkM2Dt6LlQqOXgEKxbKI1GPFoD/R0kIo8xk+iNaHt1kmsL1+Kc
	TK9o9OjdkvR52WXlBbawKJchvkMB2jdanPDzjuilFlzJoSiRjARO+R6UjoXb42ddkaq83P
	1DItm5rG5F8F5j63ayowy5zIYcXnoy9YM7aKLDXmhL2WLG71Xpq0/eX7Flqqisam4o+txT
	lZ3ApvGCOsEAveI6STP3BRaILH62p+KmLHHJSUiUaFtmViVrqxu0LHO7vbrvN2T9Y9Ag9k
	YAE8aw3WwzIakW0JBBxGokjZYSh1h6jr0Y+pXMAqDlR+33TxU1RU+Y7Hy46rxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733435464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=K8veU2bn/WSzKYzI0uQfkif7qeF3lByRhXDDopyF/+M=;
	b=E+YxWRuhYExgOBBopn5CIUxuoez1b6DfMUgriNR9Qp30hLY2HLSs0Oz6n26JXiSCwsy8nP
	kxGP36YnGGBkUgBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-modules@vger.kernel.org
Cc: Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] module: Use complete RCU protection instead a mix of RCU and
 RCU-sched.
Message-ID: <20241205215102.hRywUW2A@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

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

Replace preempt-disable sections with RCU-read sections. Replace
rcu_dereference_sched() with rcu_dereference(). Remove
module_assert_mutex_or_preempt(), its goal is covered by the following
RCU usage.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/module/internal.h | 11 -------
 kernel/module/kallsyms.c | 45 +++++++++-------------------
 kernel/module/main.c     | 64 ++++++++++++----------------------------
 kernel/module/tracking.c |  2 --
 kernel/module/version.c  | 11 ++++---
 5 files changed, 38 insertions(+), 95 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index daef2be839022..030d2ed175fa8 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -122,17 +122,6 @@ char *module_next_tag_pair(char *string, unsigned long *secsize);
 #define for_each_modinfo_entry(entry, info, name) \
 	for (entry = get_modinfo(info, name); entry; entry = get_next_modinfo(info, name, entry))
 
-static inline void module_assert_mutex_or_preempt(void)
-{
-#ifdef CONFIG_LOCKDEP
-	if (unlikely(!debug_locks))
-		return;
-
-	WARN_ON_ONCE(!rcu_read_lock_sched_held() &&
-		     !lockdep_is_held(&module_mutex));
-#endif
-}
-
 static inline unsigned long kernel_symbol_value(const struct kernel_symbol *sym)
 {
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index bf65e0c3c86fc..d8e0a51ff9968 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -179,8 +179,7 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	void *init_data_base = mod->mem[MOD_INIT_DATA].base;
 
 	/* Set up to point into init section. */
-	mod->kallsyms = (void __rcu *)init_data_base +
-		info->mod_kallsyms_init_off;
+	rcu_assign_pointer(mod->kallsyms, init_data_base + info->mod_kallsyms_init_off);
 
 	rcu_read_lock();
 	/* The following is safe since this pointer cannot change */
@@ -260,7 +259,7 @@ static const char *find_kallsyms_symbol(struct module *mod,
 {
 	unsigned int i, best = 0;
 	unsigned long nextval, bestval;
-	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
+	struct mod_kallsyms *kallsyms = rcu_dereference(mod->kallsyms);
 	struct module_memory *mod_mem;
 
 	/* At worse, next value is at end of module */
@@ -319,7 +318,7 @@ void * __weak dereference_module_function_descriptor(struct module *mod,
 
 /*
  * For kallsyms to ask for address resolution.  NULL means not found.  Careful
- * not to lock to avoid deadlock on oopses, simply disable preemption.
+ * not to lock to avoid deadlock on oopses, RCU is enough.
  */
 int module_address_lookup(unsigned long addr,
 			  unsigned long *size,
@@ -332,7 +331,7 @@ int module_address_lookup(unsigned long addr,
 	int ret = 0;
 	struct module *mod;
 
-	preempt_disable();
+	guard(rcu)();
 	mod = __module_address(addr);
 	if (mod) {
 		if (modname)
@@ -350,7 +349,6 @@ int module_address_lookup(unsigned long addr,
 		if (sym)
 			ret = strscpy(namebuf, sym, KSYM_NAME_LEN);
 	}
-	preempt_enable();
 
 	return ret;
 }
@@ -359,7 +357,7 @@ int lookup_module_symbol_name(unsigned long addr, char *symname)
 {
 	struct module *mod;
 
-	preempt_disable();
+	guard(rcu)();
 	list_for_each_entry_rcu(mod, &modules, list) {
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
@@ -371,12 +369,10 @@ int lookup_module_symbol_name(unsigned long addr, char *symname)
 				goto out;
 
 			strscpy(symname, sym, KSYM_NAME_LEN);
-			preempt_enable();
 			return 0;
 		}
 	}
 out:
-	preempt_enable();
 	return -ERANGE;
 }
 
@@ -385,13 +381,13 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 {
 	struct module *mod;
 
-	preempt_disable();
+	guard(rcu)();
 	list_for_each_entry_rcu(mod, &modules, list) {
 		struct mod_kallsyms *kallsyms;
 
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
-		kallsyms = rcu_dereference_sched(mod->kallsyms);
+		kallsyms = rcu_dereference(mod->kallsyms);
 		if (symnum < kallsyms->num_symtab) {
 			const Elf_Sym *sym = &kallsyms->symtab[symnum];
 
@@ -400,12 +396,10 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 			strscpy(name, kallsyms_symbol_name(kallsyms, symnum), KSYM_NAME_LEN);
 			strscpy(module_name, mod->name, MODULE_NAME_LEN);
 			*exported = is_exported(name, *value, mod);
-			preempt_enable();
 			return 0;
 		}
 		symnum -= kallsyms->num_symtab;
 	}
-	preempt_enable();
 	return -ERANGE;
 }
 
@@ -413,7 +407,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 static unsigned long __find_kallsyms_symbol_value(struct module *mod, const char *name)
 {
 	unsigned int i;
-	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
+	struct mod_kallsyms *kallsyms = rcu_dereference(mod->kallsyms);
 
 	for (i = 0; i < kallsyms->num_symtab; i++) {
 		const Elf_Sym *sym = &kallsyms->symtab[i];
@@ -453,23 +447,15 @@ static unsigned long __module_kallsyms_lookup_name(const char *name)
 /* Look for this name: can be of form module:name. */
 unsigned long module_kallsyms_lookup_name(const char *name)
 {
-	unsigned long ret;
-
 	/* Don't lock: we're in enough trouble already. */
-	preempt_disable();
-	ret = __module_kallsyms_lookup_name(name);
-	preempt_enable();
-	return ret;
+	guard(rcu)();
+	return __module_kallsyms_lookup_name(name);
 }
 
 unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
 {
-	unsigned long ret;
-
-	preempt_disable();
-	ret = __find_kallsyms_symbol_value(mod, name);
-	preempt_enable();
-	return ret;
+	guard(rcu)();
+	return __find_kallsyms_symbol_value(mod, name);
 }
 
 int module_kallsyms_on_each_symbol(const char *modname,
@@ -490,11 +476,8 @@ int module_kallsyms_on_each_symbol(const char *modname,
 		if (modname && strcmp(modname, mod->name))
 			continue;
 
-		/* Use rcu_dereference_sched() to remain compliant with the sparse tool */
-		preempt_disable();
-		kallsyms = rcu_dereference_sched(mod->kallsyms);
-		preempt_enable();
-
+		kallsyms = rcu_dereference_check(mod->kallsyms,
+						 lockdep_is_held(&module_mutex));
 		for (i = 0; i < kallsyms->num_symtab; i++) {
 			const Elf_Sym *sym = &kallsyms->symtab[i];
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5399c182b3cbe..073a8d57884d8 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -67,7 +67,7 @@
 
 /*
  * Mutex protects:
- * 1) List of modules (also safely readable with preempt_disable),
+ * 1) List of modules (also safely readable within RCU read section),
  * 2) module_use links,
  * 3) mod_tree.addr_min/mod_tree.addr_max.
  * (delete and add uses RCU list operations).
@@ -331,7 +331,7 @@ static bool find_exported_symbol_in_section(const struct symsearch *syms,
 
 /*
  * Find an exported symbol and return it, along with, (optional) crc and
- * (optional) module which owns it.  Needs preempt disabled or module_mutex.
+ * (optional) module which owns it.  Needs RCU or module_mutex.
  */
 bool find_symbol(struct find_symbol_arg *fsa)
 {
@@ -345,8 +345,6 @@ bool find_symbol(struct find_symbol_arg *fsa)
 	struct module *mod;
 	unsigned int i;
 
-	module_assert_mutex_or_preempt();
-
 	for (i = 0; i < ARRAY_SIZE(arr); i++)
 		if (find_exported_symbol_in_section(&arr[i], NULL, fsa))
 			return true;
@@ -374,16 +372,14 @@ bool find_symbol(struct find_symbol_arg *fsa)
 }
 
 /*
- * Search for module by name: must hold module_mutex (or preempt disabled
- * for read-only access).
+ * Search for module by name: must hold module_mutex (or RCU for read-only
+ * access).
  */
 struct module *find_module_all(const char *name, size_t len,
 			       bool even_unformed)
 {
 	struct module *mod;
 
-	module_assert_mutex_or_preempt();
-
 	list_for_each_entry_rcu(mod, &modules, list,
 				lockdep_is_held(&module_mutex)) {
 		if (!even_unformed && mod->state == MODULE_STATE_UNFORMED)
@@ -454,8 +450,7 @@ bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
 	struct module *mod;
 	unsigned int cpu;
 
-	preempt_disable();
-
+	guard(rcu)();
 	list_for_each_entry_rcu(mod, &modules, list) {
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
@@ -472,13 +467,10 @@ bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
 						per_cpu_ptr(mod->percpu,
 							    get_boot_cpu_id());
 				}
-				preempt_enable();
 				return true;
 			}
 		}
 	}
-
-	preempt_enable();
 	return false;
 }
 
@@ -814,10 +806,9 @@ void __symbol_put(const char *symbol)
 		.gplok	= true,
 	};
 
-	preempt_disable();
+	guard(rcu)();
 	BUG_ON(!find_symbol(&fsa));
 	module_put(fsa.owner);
-	preempt_enable();
 }
 EXPORT_SYMBOL(__symbol_put);
 
@@ -830,15 +821,10 @@ void symbol_put_addr(void *addr)
 	if (core_kernel_text(a))
 		return;
 
-	/*
-	 * Even though we hold a reference on the module; we still need to
-	 * disable preemption in order to safely traverse the data structure.
-	 */
-	preempt_disable();
+	guard(rcu)();
 	modaddr = __module_text_address(a);
 	BUG_ON(!modaddr);
 	module_put(modaddr);
-	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(symbol_put_addr);
 
@@ -1348,7 +1334,7 @@ static void free_module(struct module *mod)
 	mod_tree_remove(mod);
 	/* Remove this module from bug list, this uses list_del_rcu */
 	module_bug_cleanup(mod);
-	/* Wait for RCU-sched synchronizing before releasing mod->list and buglist. */
+	/* Wait for RCU synchronizing before releasing mod->list and buglist. */
 	synchronize_rcu();
 	if (try_add_tainted_module(mod))
 		pr_err("%s: adding tainted module to the unloaded tainted modules list failed.\n",
@@ -1371,21 +1357,17 @@ void *__symbol_get(const char *symbol)
 		.warn	= true,
 	};
 
-	preempt_disable();
+	guard(rcu)();
 	if (!find_symbol(&fsa))
-		goto fail;
+		return NULL;
 	if (fsa.license != GPL_ONLY) {
 		pr_warn("failing symbol_get of non-GPLONLY symbol %s.\n",
 			symbol);
-		goto fail;
+		return NULL;
 	}
 	if (strong_try_module_get(fsa.owner))
-		goto fail;
-	preempt_enable();
+		return NULL;
 	return (void *)kernel_symbol_value(fsa.sym);
-fail:
-	preempt_enable();
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
 
@@ -2965,7 +2947,7 @@ static noinline int do_init_module(struct module *mod)
 #endif
 	/*
 	 * We want to free module_init, but be aware that kallsyms may be
-	 * walking this with preempt disabled.  In all the failure paths, we
+	 * walking this within an RCU read section. In all the failure paths, we
 	 * call synchronize_rcu(), but we don't want to slow down the success
 	 * path. execmem_free() cannot be called in an interrupt, so do the
 	 * work and call synchronize_rcu() in a work queue.
@@ -3636,7 +3618,7 @@ const struct exception_table_entry *search_module_extables(unsigned long addr)
 	const struct exception_table_entry *e = NULL;
 	struct module *mod;
 
-	preempt_disable();
+	guard(rcu)();
 	mod = __module_address(addr);
 	if (!mod)
 		goto out;
@@ -3648,8 +3630,6 @@ const struct exception_table_entry *search_module_extables(unsigned long addr)
 			   mod->num_exentries,
 			   addr);
 out:
-	preempt_enable();
-
 	/*
 	 * Now, if we found one, we are running inside it now, hence
 	 * we cannot unload the module, hence no refcnt needed.
@@ -3668,9 +3648,8 @@ bool is_module_address(unsigned long addr)
 {
 	bool ret;
 
-	preempt_disable();
+	guard(rcu)();
 	ret = __module_address(addr) != NULL;
-	preempt_enable();
 
 	return ret;
 }
@@ -3679,7 +3658,7 @@ bool is_module_address(unsigned long addr)
  * __module_address() - get the module which contains an address.
  * @addr: the address.
  *
- * Must be called with preempt disabled or module mutex held so that
+ * Must be called within RCU read section or module mutex held so that
  * module doesn't get freed during this.
  */
 struct module *__module_address(unsigned long addr)
@@ -3697,8 +3676,6 @@ struct module *__module_address(unsigned long addr)
 	return NULL;
 
 lookup:
-	module_assert_mutex_or_preempt();
-
 	mod = mod_find(addr, &mod_tree);
 	if (mod) {
 		BUG_ON(!within_module(addr, mod));
@@ -3720,9 +3697,8 @@ bool is_module_text_address(unsigned long addr)
 {
 	bool ret;
 
-	preempt_disable();
+	guard(rcu)();
 	ret = __module_text_address(addr) != NULL;
-	preempt_enable();
 
 	return ret;
 }
@@ -3731,7 +3707,7 @@ bool is_module_text_address(unsigned long addr)
  * __module_text_address() - get the module whose code contains an address.
  * @addr: the address.
  *
- * Must be called with preempt disabled or module mutex held so that
+ * Must be called within RCU read section or module mutex held so that
  * module doesn't get freed during this.
  */
 struct module *__module_text_address(unsigned long addr)
@@ -3753,8 +3729,7 @@ void print_modules(void)
 	char buf[MODULE_FLAGS_BUF_SIZE];
 
 	printk(KERN_DEFAULT "Modules linked in:");
-	/* Most callers should already have preempt disabled, but make sure */
-	preempt_disable();
+	guard(rcu)();
 	list_for_each_entry_rcu(mod, &modules, list) {
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
@@ -3762,7 +3737,6 @@ void print_modules(void)
 	}
 
 	print_unloaded_tainted_modules();
-	preempt_enable();
 	if (last_unloaded_module.name[0])
 		pr_cont(" [last unloaded: %s%s]", last_unloaded_module.name,
 			last_unloaded_module.taints);
diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index 16742d1c630c6..4fefec5b683c6 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -21,8 +21,6 @@ int try_add_tainted_module(struct module *mod)
 {
 	struct mod_unload_taint *mod_taint;
 
-	module_assert_mutex_or_preempt();
-
 	if (!mod->taints)
 		goto out;
 
diff --git a/kernel/module/version.c b/kernel/module/version.c
index 53f43ac5a73e9..0437eea1d209f 100644
--- a/kernel/module/version.c
+++ b/kernel/module/version.c
@@ -65,14 +65,13 @@ int check_modstruct_version(const struct load_info *info,
 
 	/*
 	 * Since this should be found in kernel (which can't be removed), no
-	 * locking is necessary -- use preempt_disable() to placate lockdep.
+	 * locking is necessary. Regardless use a RCU read section to keep
+	 * lockdep happy.
 	 */
-	preempt_disable();
-	if (!find_symbol(&fsa)) {
-		preempt_enable();
-		BUG();
+	scoped_guard(rcu) {
+		if (!find_symbol(&fsa))
+			BUG();
 	}
-	preempt_enable();
 	return check_version(info, "module_layout", mod, fsa.crc);
 }
 
-- 
2.45.2

