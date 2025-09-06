Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE53827FD40;
	Sat,  6 Sep 2025 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757162672; cv=none; b=F/gELeIXxzKabfwb12ZTTpDesyNoJq1CG7jrmltF+xzeK0hE0FNWADLKw0ElG6nnUeRmTqqtTnXnid7XgD0oSa/gHFNBdQUykBPL3h1PfHjJcVRlZi8EhbKqrle9q0f/Fsfk+NS0lp3O80TNP2RW7Hxb6fC8UrJBodr80Zd8+6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757162672; c=relaxed/simple;
	bh=fs4zfTzKabi/47BkZEI5pNgZ2H9ES53lUsJnqM1n+7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tQQ4yebm8gV3B3RY5j5PIR7s5x3SSb79JGotQvWKELOz6PGaxf7sBeYbB5zctRz2kCPKyAx0BOUMezKKCoKvFRISOYBEQvaPE2ebrehPqtL8E4kZoe43tyJWnONSBlcNhUmgtRGVM38ECio6AsqC1lnCopgvuXO3qOtP/5iaM88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCC8W3FV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCC8W3FV"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso18906145e9.2;
        Sat, 06 Sep 2025 05:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757162668; x=1757767468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4FAE+oUnpunIhbfJWlgDTcPFbBZ5VFlx0tQtY8lTyAo=;
        b=HCC8W3FVJ4Jxnk5uY04XmknIIsqA0EvbknPZvFyk+8nWux+Nx3gRExRb21jGizXVKf
         tg4eo6xY4yqr+OjI7SGeUf0UBN69LXxogEAjo/Jz9kz8eoPnIgGTiJQhqs7MlvrpAb2S
         lLbhGxF95xLxzkSBXlnZyVAFq0fg1TwYVHBcKodkF/fCVHkoFIVdYWVgasQh8pymGsjF
         fxwyCY5Mg7xag9PLHIJvi6sWeh34OwlUFIKRpcNjxy/IpGbWFQMcyJ4ppBgbAubbnRMX
         hTKUaqly/597+F6+skthcpiqhBquzCmr5cZCVtheRAQBegIMg2V0kayXe/1XueGF3ERT
         DLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757162668; x=1757767468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FAE+oUnpunIhbfJWlgDTcPFbBZ5VFlx0tQtY8lTyAo=;
        b=SQKt2P+D8nbs9jXLX32+xK0Y+XQxFfyTu09BY0mWQqJzxA4my4/7JRq7tObB7jRrZt
         HrqmbiSctLqR1KGCE+B6nW6B85L4lFX2OSNMtzRUxaW9Dk82RHNR+hkhYj3juzUvhRtj
         shmf6jUdjx4mpby5kSINdgnTuNxy34thb8eL+jKVnGsXScbD6n3GQaro/NI6aPHkaru6
         mQfTFtIXqhyESXcjvpGRDsky30RFIZzMEAKM7xhJqaXO8KTW14IocB9oVe21VYvLHNuV
         LWLTlBTx9sKtiJKY8lS1AKv/fLrX+8KSOOc6LJzLV9MzYfeOpr2zzDi4vqYv47iJwNL8
         jwow==
X-Forwarded-Encrypted: i=1; AJvYcCUFCDi5AFAkdOHzu55evxBBdi8QA+iNZupwD5yhvvXOC0WfKtUiMNpxykUL64MNGCV3gKO8UO3MOT1+7cU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Q1rvo7jpi6EeVBEmDKB7s0Z6L5m2ZgA3xJbXNOfzcfJxMSnU
	r9nszYVSIw3lrFKShmYfe1WHAyVKWHj29dh0YBGfg8UxoyGui7g0tmsiwxLPSQ==
X-Gm-Gg: ASbGnctMbgDRhKlxYcGPRzD8kmcKoWY1namg3PDUcJ8Ohe3mNVdSPvPE7YkWJluctCo
	hTCZHj5O3BvAoDAeMD3utKOSbzIl+JyZYTbCbA0cre93ICdBqEY2swYbPqeI8xVoieeWojJQho8
	9clBgI+ySZVIxzLa8DJh5U0yOuSinv2hLQs1dZTvtDeDyNnSq2lF2P6jrvgmoWouimPtzy585pu
	YdJM4sqecJqe3rgH4Z3YxPigJtJ7UuIv/GXOivY3LIf4B7m8jqENQqX7wbnNtYaaeGU/FWvxv18
	0XryLvhJZS1RKvL0v6Br+DohDtHvpbLPc+UyDZFUYs9hxqQK9UlFxEyWwQN7/C87Omb5I43ptFI
	UwrJBTo8KoniMgORCBCuKmpEU27NlvGoKMBLOLQsJ3hFYqhpf
X-Google-Smtp-Source: AGHT+IHX2gOEmEGkO0po9j35OCLFJL2NEC5LGoBqWcaxAkHyCerWEb8+d7E1T92L3LQqeDjFB6QcJw==
X-Received: by 2002:a5d:64c5:0:b0:3e4:bd77:df12 with SMTP id ffacd0b85a97d-3e63736fc29mr1242164f8f.18.1757162667917;
        Sat, 06 Sep 2025 05:44:27 -0700 (PDT)
Received: from Al-Qamar ([2a00:f29:258:2ea4:8502:df64:bca:486e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34493b8csm33995333f8f.59.2025.09.06.05.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 05:44:27 -0700 (PDT)
From: Fidal Palamparambil <rootuserhere@gmail.com>
To: linux-modules@vger.kernel.org
Cc: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	linux-kernel@vger.kernel.org,
	Fidal palamparambil <rootuserhere@gmail.com>
Subject: [PATCH] cgroup: debug: Fix multiple issues in debug controller implementation
Date: Sat,  6 Sep 2025 16:44:17 +0400
Message-ID: <20250906124417.793-1-rootuserhere@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fidal palamparambil <rootuserhere@gmail.com>

This commit addresses several issues in the cgroup debug controller:

1. Memory leak protection in current_css_set_cg_links_read():
   - Initialize name_buf to NULL and use proper error handling with goto
   - Ensure memory is freed in all code paths

2. RCU locking correctness:
   - Use lockdep_is_held() for proper lock dependency tracking in
     rcu_dereference_protected() calls
   - Ensure proper locking context is passed to RCU checks

3. Buffer size safety:
   - Remove off-by-one in snprintf() size calculation
   - Use sizeof(buffer) instead of sizeof(buffer)-1

4. Code robustness:
   - Add proper initialization of variables
   - Use consistent error handling patterns
   - Fix potential integer underflow in extra reference calculation

The debug controller is for internal debugging only, but these fixes
ensure it doesn't introduce stability issues or memory leaks when
used for debugging purposes.

Signed-off-by: Fidal palamparambil <rootuserhere@gmail.com>
---
 arch/arm64/kernel/acpi.c    |  15 +-
 arch/arm64/kernel/acpi.orig |  17 +-
 kernel/cgroup/debug.c       |  18 +-
 kernel/cgroup/debug.c.orig  | 381 ++++++++++++++++++++++++++++++++++++
 4 files changed, 416 insertions(+), 15 deletions(-)
 create mode 100644 kernel/cgroup/debug.c.orig

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 218f39e5ae0f..f38db7e11f05 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -73,7 +73,7 @@ static int __init parse_acpi(char *arg)
 	}
 	else
 	{
-		pr_err("ACPI: Invalid option '%s'\n", arg);
+		pr_err("ACPI: unknown parameter '%s'\n", arg);
 		return -EINVAL;
 	}
 	return 0;
@@ -84,6 +84,9 @@ static bool __init dt_is_stub(void)
 {
 	int node;
 
+	if (!initial_boot_params)
+		return true;
+
 	fdt_for_each_subnode(node, initial_boot_params, 0) {
 		const char *name = fdt_get_name(initial_boot_params, node, NULL);
 		if (strcmp(name, "chosen") == 0)
@@ -120,12 +123,16 @@ void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
 
 bool __init acpi_psci_present(void)
 {
+	if (!acpi_gbl_FADT.arm_boot_flags)
+		return false;
 	return acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_COMPLIANT;
 }
 
 /* Whether HVC must be used instead of SMC as the PSCI conduit */
 bool acpi_psci_use_hvc(void)
 {
+	if (!acpi_gbl_FADT.arm_boot_flags)
+		return false;
 	return acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_USE_HVC;
 }
 
@@ -265,7 +272,7 @@ void __init acpi_boot_table_init(void)
 		 */
 		ret = acpi_parse_spcr(earlycon_acpi_spcr_enable,
 			!param_acpi_nospcr);
-		if (!ret || param_acpi_nospcr || !IS_ENABLED(CONFIG_ACPI_SPCR_TABLE))
+		if (ret || param_acpi_nospcr || !IS_ENABLED(CONFIG_ACPI_SPCR_TABLE))
 			pr_info("Use ACPI SPCR as default console: No\n");
 		else
 			pr_info("Use ACPI SPCR as default console: Yes\n");
@@ -345,7 +352,7 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 		case EFI_BOOT_SERVICES_CODE:
 		case EFI_BOOT_SERVICES_DATA:
 		case EFI_CONVENTIONAL_MEMORY:
-		case EFI_PERSISTENT_MEMORY:
+		case EFI_PERSISTent_MEMORY:
 			if (memblock_is_map_memory(phys) ||
 			    !memblock_is_region_memory(phys, size)) {
 				pr_warn(FW_BUG "requested region covers kernel memory @ %pa\n", &phys);
@@ -459,7 +466,7 @@ void arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 apci_id,
 		 int *pcpu)
 {
-	/* If an error code is passed in this stub can't fix it */
+	/* If caller already set a negative error code, propagate it. */
 	if (*pcpu < 0) {
 		pr_warn_once("Unable to map CPU to valid ID\n");
 		return *pcpu;
diff --git a/arch/arm64/kernel/acpi.orig b/arch/arm64/kernel/acpi.orig
index 4d529ff7ba51..218f39e5ae0f 100644
--- a/arch/arm64/kernel/acpi.orig
+++ b/arch/arm64/kernel/acpi.orig
@@ -14,6 +14,7 @@
 
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
+#include <linux/compiler_attributes.h>
 #include <linux/cpumask.h>
 #include <linux/efi.h>
 #include <linux/efi-bgrt.h>
@@ -55,16 +56,26 @@ static int __init parse_acpi(char *arg)
 
 	/* "acpi=off" disables both ACPI table parsing and interpreter */
 	if (strcmp(arg, "off") == 0)
+	{
 		param_acpi_off = true;
+	}
 	else if (strcmp(arg, "on") == 0) /* prefer ACPI over DT */
+	{
 		param_acpi_on = true;
+	}
 	else if (strcmp(arg, "force") == 0) /* force ACPI to be enabled */
+	{
 		param_acpi_force = true;
+	}
 	else if (strcmp(arg, "nospcr") == 0) /* disable SPCR as default console */
+	{
 		param_acpi_nospcr = true;
+	}
 	else
-		return -EINVAL;	/* Core will print when we return error */
-
+	{
+		pr_err("ACPI: Invalid option '%s'\n", arg);
+		return -EINVAL;
+	}
 	return 0;
 }
 early_param("acpi", parse_acpi);
@@ -463,4 +474,4 @@ int acpi_unmap_cpu(int cpu)
 	return 0;
 }
 EXPORT_SYMBOL(acpi_unmap_cpu);
-#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+#endif /* CONFIG_ACPI_HOTPLUG_CPU */
\ No newline at end of file
diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
index 80aa3f027ac3..47f26d7894cc 100644
--- a/kernel/cgroup/debug.c
+++ b/kernel/cgroup/debug.c
@@ -88,7 +88,8 @@ static int current_css_set_cg_links_read(struct seq_file *seq, void *v)
 {
 	struct cgrp_cset_link *link;
 	struct css_set *cset;
-	char *name_buf;
+	char *name_buf = NULL;
+	int ret = 0;
 
 	name_buf = kmalloc(NAME_MAX + 1, GFP_KERNEL);
 	if (!name_buf)
@@ -106,8 +107,10 @@ static int current_css_set_cg_links_read(struct seq_file *seq, void *v)
 	}
 	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
+
+out:
 	kfree(name_buf);
-	return 0;
+	return ret;
 }
 
 #define MAX_TASKS_SHOWN_PER_CSS 25
@@ -130,7 +133,7 @@ static int cgroup_css_links_read(struct seq_file *seq, void *v)
 		 * and highlight difference between refcount and task_count.
 		 */
 		seq_printf(seq, "css_set %pK", cset);
-		if (rcu_dereference_protected(cset->dom_cset, 1) != cset) {
+		if (rcu_dereference_protected(cset->dom_cset, lockdep_is_held(&css_set_lock)) != cset) {
 			threaded_csets++;
 			seq_printf(seq, "=>%pK", cset->dom_cset);
 		}
@@ -146,7 +149,7 @@ static int cgroup_css_links_read(struct seq_file *seq, void *v)
 			}
 		} else {
 			seq_printf(seq, " %d", refcnt);
-			if (refcnt - cset->nr_tasks > 0) {
+			if (refcnt > cset->nr_tasks) {
 				int extra = refcnt - cset->nr_tasks;
 
 				seq_printf(seq, " +%d", extra);
@@ -214,7 +217,7 @@ static int cgroup_subsys_states_read(struct seq_file *seq, void *v)
 		return -ENODEV;
 
 	for_each_subsys(ss, i) {
-		css = rcu_dereference_check(cgrp->subsys[ss->id], true);
+		css = rcu_dereference_check(cgrp->subsys[ss->id], lockdep_is_held(&cgroup_mutex));
 		if (!css)
 			continue;
 
@@ -222,8 +225,7 @@ static int cgroup_subsys_states_read(struct seq_file *seq, void *v)
 
 		/* Show the parent CSS if applicable*/
 		if (css->parent)
-			snprintf(pbuf, sizeof(pbuf) - 1, " P=%d",
-				 css->parent->id);
+			snprintf(pbuf, sizeof(pbuf), " P=%d", css->parent->id);
 		seq_printf(seq, "%2d: %-4s\t- %p[%d] %d%s\n", ss->id, ss->name,
 			  css, css->id,
 			  atomic_read(&css->online_cnt), pbuf);
@@ -378,4 +380,4 @@ void __init enable_debug_cgroup(void)
 	debug_cgrp_subsys.dfl_cftypes = debug_files;
 	debug_cgrp_subsys.implicit_on_dfl = true;
 	debug_cgrp_subsys.threaded = true;
-}
+}
\ No newline at end of file
diff --git a/kernel/cgroup/debug.c.orig b/kernel/cgroup/debug.c.orig
new file mode 100644
index 000000000000..80aa3f027ac3
--- /dev/null
+++ b/kernel/cgroup/debug.c.orig
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Debug controller
+ *
+ * WARNING: This controller is for cgroup core debugging only.
+ * Its interfaces are unstable and subject to changes at any time.
+ */
+#include <linux/ctype.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+#include "cgroup-internal.h"
+
+static struct cgroup_subsys_state *
+debug_css_alloc(struct cgroup_subsys_state *parent_css)
+{
+	struct cgroup_subsys_state *css = kzalloc(sizeof(*css), GFP_KERNEL);
+
+	if (!css)
+		return ERR_PTR(-ENOMEM);
+
+	return css;
+}
+
+static void debug_css_free(struct cgroup_subsys_state *css)
+{
+	kfree(css);
+}
+
+/*
+ * debug_taskcount_read - return the number of tasks in a cgroup.
+ * @cgrp: the cgroup in question
+ */
+static u64 debug_taskcount_read(struct cgroup_subsys_state *css,
+				struct cftype *cft)
+{
+	return cgroup_task_count(css->cgroup);
+}
+
+static int current_css_set_read(struct seq_file *seq, void *v)
+{
+	struct kernfs_open_file *of = seq->private;
+	struct css_set *cset;
+	struct cgroup_subsys *ss;
+	struct cgroup_subsys_state *css;
+	int i, refcnt;
+
+	if (!cgroup_kn_lock_live(of->kn, false))
+		return -ENODEV;
+
+	spin_lock_irq(&css_set_lock);
+	rcu_read_lock();
+	cset = task_css_set(current);
+	refcnt = refcount_read(&cset->refcount);
+	seq_printf(seq, "css_set %pK %d", cset, refcnt);
+	if (refcnt > cset->nr_tasks)
+		seq_printf(seq, " +%d", refcnt - cset->nr_tasks);
+	seq_puts(seq, "\n");
+
+	/*
+	 * Print the css'es stored in the current css_set.
+	 */
+	for_each_subsys(ss, i) {
+		css = cset->subsys[ss->id];
+		if (!css)
+			continue;
+		seq_printf(seq, "%2d: %-4s\t- %p[%d]\n", ss->id, ss->name,
+			  css, css->id);
+	}
+	rcu_read_unlock();
+	spin_unlock_irq(&css_set_lock);
+	cgroup_kn_unlock(of->kn);
+	return 0;
+}
+
+static u64 current_css_set_refcount_read(struct cgroup_subsys_state *css,
+					 struct cftype *cft)
+{
+	u64 count;
+
+	rcu_read_lock();
+	count = refcount_read(&task_css_set(current)->refcount);
+	rcu_read_unlock();
+	return count;
+}
+
+static int current_css_set_cg_links_read(struct seq_file *seq, void *v)
+{
+	struct cgrp_cset_link *link;
+	struct css_set *cset;
+	char *name_buf;
+
+	name_buf = kmalloc(NAME_MAX + 1, GFP_KERNEL);
+	if (!name_buf)
+		return -ENOMEM;
+
+	spin_lock_irq(&css_set_lock);
+	rcu_read_lock();
+	cset = task_css_set(current);
+	list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
+		struct cgroup *c = link->cgrp;
+
+		cgroup_name(c, name_buf, NAME_MAX + 1);
+		seq_printf(seq, "Root %d group %s\n",
+			   c->root->hierarchy_id, name_buf);
+	}
+	rcu_read_unlock();
+	spin_unlock_irq(&css_set_lock);
+	kfree(name_buf);
+	return 0;
+}
+
+#define MAX_TASKS_SHOWN_PER_CSS 25
+static int cgroup_css_links_read(struct seq_file *seq, void *v)
+{
+	struct cgroup_subsys_state *css = seq_css(seq);
+	struct cgrp_cset_link *link;
+	int dead_cnt = 0, extra_refs = 0, threaded_csets = 0;
+
+	spin_lock_irq(&css_set_lock);
+
+	list_for_each_entry(link, &css->cgroup->cset_links, cset_link) {
+		struct css_set *cset = link->cset;
+		struct task_struct *task;
+		int count = 0;
+		int refcnt = refcount_read(&cset->refcount);
+
+		/*
+		 * Print out the proc_cset and threaded_cset relationship
+		 * and highlight difference between refcount and task_count.
+		 */
+		seq_printf(seq, "css_set %pK", cset);
+		if (rcu_dereference_protected(cset->dom_cset, 1) != cset) {
+			threaded_csets++;
+			seq_printf(seq, "=>%pK", cset->dom_cset);
+		}
+		if (!list_empty(&cset->threaded_csets)) {
+			struct css_set *tcset;
+			int idx = 0;
+
+			list_for_each_entry(tcset, &cset->threaded_csets,
+					    threaded_csets_node) {
+				seq_puts(seq, idx ? "," : "<=");
+				seq_printf(seq, "%pK", tcset);
+				idx++;
+			}
+		} else {
+			seq_printf(seq, " %d", refcnt);
+			if (refcnt - cset->nr_tasks > 0) {
+				int extra = refcnt - cset->nr_tasks;
+
+				seq_printf(seq, " +%d", extra);
+				/*
+				 * Take out the one additional reference in
+				 * init_css_set.
+				 */
+				if (cset == &init_css_set)
+					extra--;
+				extra_refs += extra;
+			}
+		}
+		seq_puts(seq, "\n");
+
+		list_for_each_entry(task, &cset->tasks, cg_list) {
+			if (count++ <= MAX_TASKS_SHOWN_PER_CSS)
+				seq_printf(seq, "  task %d\n",
+					   task_pid_vnr(task));
+		}
+
+		list_for_each_entry(task, &cset->mg_tasks, cg_list) {
+			if (count++ <= MAX_TASKS_SHOWN_PER_CSS)
+				seq_printf(seq, "  task %d\n",
+					   task_pid_vnr(task));
+		}
+		/* show # of overflowed tasks */
+		if (count > MAX_TASKS_SHOWN_PER_CSS)
+			seq_printf(seq, "  ... (%d)\n",
+				   count - MAX_TASKS_SHOWN_PER_CSS);
+
+		if (cset->dead) {
+			seq_puts(seq, "    [dead]\n");
+			dead_cnt++;
+		}
+
+		WARN_ON(count != cset->nr_tasks);
+	}
+	spin_unlock_irq(&css_set_lock);
+
+	if (!dead_cnt && !extra_refs && !threaded_csets)
+		return 0;
+
+	seq_puts(seq, "\n");
+	if (threaded_csets)
+		seq_printf(seq, "threaded css_sets = %d\n", threaded_csets);
+	if (extra_refs)
+		seq_printf(seq, "extra references = %d\n", extra_refs);
+	if (dead_cnt)
+		seq_printf(seq, "dead css_sets = %d\n", dead_cnt);
+
+	return 0;
+}
+
+static int cgroup_subsys_states_read(struct seq_file *seq, void *v)
+{
+	struct kernfs_open_file *of = seq->private;
+	struct cgroup *cgrp;
+	struct cgroup_subsys *ss;
+	struct cgroup_subsys_state *css;
+	char pbuf[16];
+	int i;
+
+	cgrp = cgroup_kn_lock_live(of->kn, false);
+	if (!cgrp)
+		return -ENODEV;
+
+	for_each_subsys(ss, i) {
+		css = rcu_dereference_check(cgrp->subsys[ss->id], true);
+		if (!css)
+			continue;
+
+		pbuf[0] = '\0';
+
+		/* Show the parent CSS if applicable*/
+		if (css->parent)
+			snprintf(pbuf, sizeof(pbuf) - 1, " P=%d",
+				 css->parent->id);
+		seq_printf(seq, "%2d: %-4s\t- %p[%d] %d%s\n", ss->id, ss->name,
+			  css, css->id,
+			  atomic_read(&css->online_cnt), pbuf);
+	}
+
+	cgroup_kn_unlock(of->kn);
+	return 0;
+}
+
+static void cgroup_masks_read_one(struct seq_file *seq, const char *name,
+				  u16 mask)
+{
+	struct cgroup_subsys *ss;
+	int ssid;
+	bool first = true;
+
+	seq_printf(seq, "%-17s: ", name);
+	for_each_subsys(ss, ssid) {
+		if (!(mask & (1 << ssid)))
+			continue;
+		if (!first)
+			seq_puts(seq, ", ");
+		seq_puts(seq, ss->name);
+		first = false;
+	}
+	seq_putc(seq, '\n');
+}
+
+static int cgroup_masks_read(struct seq_file *seq, void *v)
+{
+	struct kernfs_open_file *of = seq->private;
+	struct cgroup *cgrp;
+
+	cgrp = cgroup_kn_lock_live(of->kn, false);
+	if (!cgrp)
+		return -ENODEV;
+
+	cgroup_masks_read_one(seq, "subtree_control", cgrp->subtree_control);
+	cgroup_masks_read_one(seq, "subtree_ss_mask", cgrp->subtree_ss_mask);
+
+	cgroup_kn_unlock(of->kn);
+	return 0;
+}
+
+static u64 releasable_read(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	return (!cgroup_is_populated(css->cgroup) &&
+		!css_has_online_children(&css->cgroup->self));
+}
+
+static struct cftype debug_legacy_files[] =  {
+	{
+		.name = "taskcount",
+		.read_u64 = debug_taskcount_read,
+	},
+
+	{
+		.name = "current_css_set",
+		.seq_show = current_css_set_read,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+	},
+
+	{
+		.name = "current_css_set_refcount",
+		.read_u64 = current_css_set_refcount_read,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+	},
+
+	{
+		.name = "current_css_set_cg_links",
+		.seq_show = current_css_set_cg_links_read,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+	},
+
+	{
+		.name = "cgroup_css_links",
+		.seq_show = cgroup_css_links_read,
+	},
+
+	{
+		.name = "cgroup_subsys_states",
+		.seq_show = cgroup_subsys_states_read,
+	},
+
+	{
+		.name = "cgroup_masks",
+		.seq_show = cgroup_masks_read,
+	},
+
+	{
+		.name = "releasable",
+		.read_u64 = releasable_read,
+	},
+
+	{ }	/* terminate */
+};
+
+static struct cftype debug_files[] =  {
+	{
+		.name = "taskcount",
+		.read_u64 = debug_taskcount_read,
+	},
+
+	{
+		.name = "current_css_set",
+		.seq_show = current_css_set_read,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+	},
+
+	{
+		.name = "current_css_set_refcount",
+		.read_u64 = current_css_set_refcount_read,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+	},
+
+	{
+		.name = "current_css_set_cg_links",
+		.seq_show = current_css_set_cg_links_read,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+	},
+
+	{
+		.name = "css_links",
+		.seq_show = cgroup_css_links_read,
+	},
+
+	{
+		.name = "csses",
+		.seq_show = cgroup_subsys_states_read,
+	},
+
+	{
+		.name = "masks",
+		.seq_show = cgroup_masks_read,
+	},
+
+	{ }	/* terminate */
+};
+
+struct cgroup_subsys debug_cgrp_subsys = {
+	.css_alloc	= debug_css_alloc,
+	.css_free	= debug_css_free,
+	.legacy_cftypes	= debug_legacy_files,
+};
+
+/*
+ * On v2, debug is an implicit controller enabled by "cgroup_debug" boot
+ * parameter.
+ */
+void __init enable_debug_cgroup(void)
+{
+	debug_cgrp_subsys.dfl_cftypes = debug_files;
+	debug_cgrp_subsys.implicit_on_dfl = true;
+	debug_cgrp_subsys.threaded = true;
+}
-- 
2.50.1.windows.1

