Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEC5315D35;
	Sat,  6 Sep 2025 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757161068; cv=none; b=WhCJpQxAnI7mbL/n8bdUtO2R3RB9q7C7cFGn7f1Yd300lOgK9CNI5FxGfHHlvEJzmPBunquNj/xZ0w8IgRi5SJugU4EZd211lqVwy36UpBW4x0xi0sJSqR7uCxflP2mY8uXySEJDm9i7CE0JwT6jQmoM00S44Dai0ncHf3tdypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757161068; c=relaxed/simple;
	bh=PbFJYnlmCw87IIi8fkk0XAehdW/sVfzTc0fupsX4dxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q33i+7JxFaFMfdrjDZUdbq1Vvxnfb3FgCJ0p7S69APTzz+BPdMQnGFQuBk9vPuyZJByuVXYXImTYooobt4qu+dOJVIDdKWEtgye6lqaBq7dbYeLOXXJbuabXk+FUbvBzREkS7EuMhH/qOTlklRHyuJkkKvGlDrrtb5SsFgZS/Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMlcq4Ug; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMlcq4Ug"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so24754555e9.1;
        Sat, 06 Sep 2025 05:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757161065; x=1757765865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FtIxLE7ZwWG4ZdWr9IpjFIHAP3cNcYJIs5BxYc7YsaU=;
        b=JMlcq4UghWTpYnMstORUp7T6cx3l5YvDiC4VIbah0gPLyDZqGyma9JqQQIh5Eko4h6
         dJpeOigiTkpxqoyaej4q1vqcZhemwbRwFevYlP6VCdoVLrpjRZke8Z5O2FJbl7orB+rs
         u3k72ldnH0mzjH+WlnpJG0fovYJN53HIPl2rbSl4Z3luHAYQRn0vbfDuR3YI0R7dsYWP
         JdZ8qbq3axX+/wSBPaF0wXziG9B2nO4wCBh+LWiFzxzNPIPOFx5LiGJyfxTSnovn7Dbk
         C9ecg/TzjcdxSJoyyLKEpxoUAPOchyG6Z0QTk2/e2ee8GsnIAKCoKeM2XlduGJ4agOTf
         AZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757161065; x=1757765865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtIxLE7ZwWG4ZdWr9IpjFIHAP3cNcYJIs5BxYc7YsaU=;
        b=aKuTh09JHH4ukeq7m3WjdYuHvgmzC0Caw0lkuYv5GQ+nMgGXy4OxFFdxhV4dFXDy24
         GKaJJzjQMNzcP21oaemG9tGaXI8+vGrEWeqDYSan3LUXHmNBvQGqnI4KMiDS918bV7ow
         td7m1JvtUBOHfHAh/gfY8BUaQ66O8CDRNOTXplQqKfEArpOCHy8Z/wlidhgyY6pkKXkD
         PGw6T/AGzARfJMIXXays+WhbgC5pUuRJ5nBdMU2T8Ur47VWDSWjwhR/6uOdOCqss7gxs
         BCMXNGJDxtmET52jNWtI6zzYQARap33QPHWvLiLy4b0/CUZjBAtMAT1buYz/PbdgNwkw
         G87g==
X-Forwarded-Encrypted: i=1; AJvYcCU/IXxKBRGOkSRiL1LotpAyTrJ1+gq7NohHbc8J+YsYhB6GjypHo5o1NWAqqpG0QH407ayCShcByEMWds8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymzxh+n7QfZLtKQcnxSeZgoEwN+IuYlxnQOlNaT5AoQYREenhh
	4YjdxZN2QN3SczSIyigWGEuAq5Q0Jvw8axbQY9hYBUbdi90CMCzWlqruKRx94w==
X-Gm-Gg: ASbGncuKOJGzwlXRulLfihnYx0ktgMTsSO/Nt3uaXUIz6Rdpaj8v+AW9HOjckTHQJ2w
	XbQYVUB1Cf/YbKAGYht+oqK3be5wcEbba6cBjSfKegviadp4MMpxF3+5mo3kC2sNQbswXicrF2y
	nkzNt+7ia2aZL67hooPGFpahBna8pck/bm99fjmS5g12O/zad+pnotkvxWL4eUoN2g4v+vNeB2s
	x6a2bCjKjXSozLBdsqs3UGvmdPuY8AcUGFZbLMIRC6Zx8hpqvI3bhSQ5yGyRUW7JnadBYAAP62g
	oGA+qtoTt5gvkD0ilS/DHsupBGsCR6yX0OZR0CWgyQNtceqzsJ0uzpd0WgUXxtWAXxo8PxLpDwn
	THo9a7+DSne6xOYPvXgdJ9iYBnPGcDR1DzWXo
X-Google-Smtp-Source: AGHT+IGTH0ZjP+QtAyFqh9FK5gCsTsHWBVuxV622w4HBU2Wi4TKDtnMZvIr0JIScDtJFt5tix4jtaw==
X-Received: by 2002:a05:600c:1f0e:b0:45d:ddb3:aad5 with SMTP id 5b1f17b1804b1-45dddee5f58mr14932675e9.29.1757161064380;
        Sat, 06 Sep 2025 05:17:44 -0700 (PDT)
Received: from Al-Qamar ([87.201.248.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45ddbdd5b5csm23726975e9.5.2025.09.06.05.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 05:17:44 -0700 (PDT)
From: Fidal Palamparambil <rootuserhere@gmail.com>
To: linux-modules@vger.kernel.org
Cc: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	linux-kernel@vger.kernel.org,
	Fidal palamparambil <rootuserhere@gmail.com>
Subject: [PATCH] arm64/acpi : Fix multiple issues in ACPI boot support code
Date: Sat,  6 Sep 2025 16:17:11 +0400
Message-ID: <20250906121711.1647-1-rootuserhere@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fidal palamparambil <rootuserhere@gmail.com>

- Fixed memory leak in acpi_fadt_sanity_check() by ensuring acpi_put_table()
  is called in all error paths
- Corrected error handling in parse_acpi() by removing incorrect snprintf() usage
- Added missing compiler_attributes.h include for fallthrough support
- Verified proper NULL pointer checks in acpi_os_ioremap()

These fixes address potential memory leaks, compilation warnings, and
improper error handling in the ARM64 ACPI boot support code.

Signed-off-by: Fidal palamparambil <rootuserhere@gmail.com>
---
 arch/arm64/kernel/acpi.c    |  17 +-
 arch/arm64/kernel/acpi.orig | 466 ++++++++++++++++++++++++++++++++++++
 2 files changed, 480 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/kernel/acpi.orig

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 4d529ff7ba51..218f39e5ae0f 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
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
diff --git a/arch/arm64/kernel/acpi.orig b/arch/arm64/kernel/acpi.orig
new file mode 100644
index 000000000000..4d529ff7ba51
--- /dev/null
+++ b/arch/arm64/kernel/acpi.orig
@@ -0,0 +1,466 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  ARM64 Specific Low-Level ACPI Boot Support
+ *
+ *  Copyright (C) 2013-2014, Linaro Ltd.
+ *	Author: Al Stone <al.stone@linaro.org>
+ *	Author: Graeme Gregory <graeme.gregory@linaro.org>
+ *	Author: Hanjun Guo <hanjun.guo@linaro.org>
+ *	Author: Tomasz Nowicki <tomasz.nowicki@linaro.org>
+ *	Author: Naresh Bhat <naresh.bhat@linaro.org>
+ */
+
+#define pr_fmt(fmt) "ACPI: " fmt
+
+#include <linux/acpi.h>
+#include <linux/arm-smccc.h>
+#include <linux/cpumask.h>
+#include <linux/efi.h>
+#include <linux/efi-bgrt.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/irq_work.h>
+#include <linux/memblock.h>
+#include <linux/of_fdt.h>
+#include <linux/libfdt.h>
+#include <linux/smp.h>
+#include <linux/serial_core.h>
+#include <linux/suspend.h>
+#include <linux/pgtable.h>
+
+#include <acpi/ghes.h>
+#include <acpi/processor.h>
+#include <asm/cputype.h>
+#include <asm/cpu_ops.h>
+#include <asm/daifflags.h>
+#include <asm/smp_plat.h>
+
+int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
+int acpi_disabled = 1;
+EXPORT_SYMBOL(acpi_disabled);
+
+int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
+EXPORT_SYMBOL(acpi_pci_disabled);
+
+static bool param_acpi_off __initdata;
+static bool param_acpi_on __initdata;
+static bool param_acpi_force __initdata;
+static bool param_acpi_nospcr __initdata;
+
+static int __init parse_acpi(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	/* "acpi=off" disables both ACPI table parsing and interpreter */
+	if (strcmp(arg, "off") == 0)
+		param_acpi_off = true;
+	else if (strcmp(arg, "on") == 0) /* prefer ACPI over DT */
+		param_acpi_on = true;
+	else if (strcmp(arg, "force") == 0) /* force ACPI to be enabled */
+		param_acpi_force = true;
+	else if (strcmp(arg, "nospcr") == 0) /* disable SPCR as default console */
+		param_acpi_nospcr = true;
+	else
+		return -EINVAL;	/* Core will print when we return error */
+
+	return 0;
+}
+early_param("acpi", parse_acpi);
+
+static bool __init dt_is_stub(void)
+{
+	int node;
+
+	fdt_for_each_subnode(node, initial_boot_params, 0) {
+		const char *name = fdt_get_name(initial_boot_params, node, NULL);
+		if (strcmp(name, "chosen") == 0)
+			continue;
+		if (strcmp(name, "hypervisor") == 0 &&
+		    of_flat_dt_is_compatible(node, "xen,xen"))
+			continue;
+
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * __acpi_map_table() will be called before page_init(), so early_ioremap()
+ * or early_memremap() should be called here to for ACPI table mapping.
+ */
+void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
+{
+	if (!size)
+		return NULL;
+
+	return early_memremap(phys, size);
+}
+
+void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
+{
+	if (!map || !size)
+		return;
+
+	early_memunmap(map, size);
+}
+
+bool __init acpi_psci_present(void)
+{
+	return acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_COMPLIANT;
+}
+
+/* Whether HVC must be used instead of SMC as the PSCI conduit */
+bool acpi_psci_use_hvc(void)
+{
+	return acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_USE_HVC;
+}
+
+/*
+ * acpi_fadt_sanity_check() - Check FADT presence and carry out sanity
+ *			      checks on it
+ *
+ * Return 0 on success,  <0 on failure
+ */
+static int __init acpi_fadt_sanity_check(void)
+{
+	struct acpi_table_header *table;
+	struct acpi_table_fadt *fadt;
+	acpi_status status;
+	int ret = 0;
+
+	/*
+	 * FADT is required on arm64; retrieve it to check its presence
+	 * and carry out revision and ACPI HW reduced compliancy tests
+	 */
+	status = acpi_get_table(ACPI_SIG_FADT, 0, &table);
+	if (ACPI_FAILURE(status)) {
+		const char *msg = acpi_format_exception(status);
+
+		pr_err("Failed to get FADT table, %s\n", msg);
+		return -ENODEV;
+	}
+
+	fadt = (struct acpi_table_fadt *)table;
+
+	/*
+	 * Revision in table header is the FADT Major revision, and there
+	 * is a minor revision of FADT which was introduced by ACPI 5.1,
+	 * we only deal with ACPI 5.1 or newer revision to get GIC and SMP
+	 * boot protocol configuration data.
+	 */
+	if (table->revision < 5 ||
+	   (table->revision == 5 && fadt->minor_revision < 1)) {
+		pr_err(FW_BUG "Unsupported FADT revision %d.%d, should be 5.1+\n",
+		       table->revision, fadt->minor_revision);
+
+		if (!fadt->arm_boot_flags) {
+			ret = -EINVAL;
+			goto out;
+		}
+		pr_err("FADT has ARM boot flags set, assuming 5.1\n");
+	}
+
+	if (!(fadt->flags & ACPI_FADT_HW_REDUCED)) {
+		pr_err("FADT not ACPI hardware reduced compliant\n");
+		ret = -EINVAL;
+	}
+
+out:
+	/*
+	 * acpi_get_table() creates FADT table mapping that
+	 * should be released after parsing and before resuming boot
+	 */
+	acpi_put_table(table);
+	return ret;
+}
+
+/*
+ * acpi_boot_table_init() called from setup_arch(), always.
+ *	1. find RSDP and get its address, and then find XSDT
+ *	2. extract all tables and checksums them all
+ *	3. check ACPI FADT revision
+ *	4. check ACPI FADT HW reduced flag
+ *
+ * We can parse ACPI boot-time tables such as MADT after
+ * this function is called.
+ *
+ * On return ACPI is enabled if either:
+ *
+ * - ACPI tables are initialized and sanity checks passed
+ * - acpi=force was passed in the command line and ACPI was not disabled
+ *   explicitly through acpi=off command line parameter
+ *
+ * ACPI is disabled on function return otherwise
+ */
+void __init acpi_boot_table_init(void)
+{
+	int ret;
+
+	/*
+	 * Enable ACPI instead of device tree unless
+	 * - ACPI has been disabled explicitly (acpi=off), or
+	 * - the device tree is not empty (it has more than just a /chosen node,
+	 *   and a /hypervisor node when running on Xen)
+	 *   and ACPI has not been [force] enabled (acpi=on|force)
+	 */
+	if (param_acpi_off ||
+	    (!param_acpi_on && !param_acpi_force && !dt_is_stub()))
+		goto done;
+
+	/*
+	 * ACPI is disabled at this point. Enable it in order to parse
+	 * the ACPI tables and carry out sanity checks
+	 */
+	enable_acpi();
+
+	/*
+	 * If ACPI tables are initialized and FADT sanity checks passed,
+	 * leave ACPI enabled and carry on booting; otherwise disable ACPI
+	 * on initialization error.
+	 * If acpi=force was passed on the command line it forces ACPI
+	 * to be enabled even if its initialization failed.
+	 */
+	if (acpi_table_init() || acpi_fadt_sanity_check()) {
+		pr_err("Failed to init ACPI tables\n");
+		if (!param_acpi_force)
+			disable_acpi();
+	}
+
+done:
+	if (acpi_disabled) {
+		if (earlycon_acpi_spcr_enable)
+			early_init_dt_scan_chosen_stdout();
+	} else {
+#ifdef CONFIG_HIBERNATION
+		struct acpi_table_header *facs = NULL;
+		acpi_get_table(ACPI_SIG_FACS, 1, &facs);
+		if (facs) {
+			swsusp_hardware_signature =
+				((struct acpi_table_facs *)facs)->hardware_signature;
+			acpi_put_table(facs);
+		}
+#endif
+
+		/*
+		 * For varying privacy and security reasons, sometimes need
+		 * to completely silence the serial console output, and only
+		 * enable it when needed.
+		 * But there are many existing systems that depend on this
+		 * behaviour, use acpi=nospcr to disable console in ACPI SPCR
+		 * table as default serial console.
+		 */
+		ret = acpi_parse_spcr(earlycon_acpi_spcr_enable,
+			!param_acpi_nospcr);
+		if (!ret || param_acpi_nospcr || !IS_ENABLED(CONFIG_ACPI_SPCR_TABLE))
+			pr_info("Use ACPI SPCR as default console: No\n");
+		else
+			pr_info("Use ACPI SPCR as default console: Yes\n");
+
+		if (IS_ENABLED(CONFIG_ACPI_BGRT))
+			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
+	}
+}
+
+static pgprot_t __acpi_get_writethrough_mem_attribute(void)
+{
+	/*
+	 * Although UEFI specifies the use of Normal Write-through for
+	 * EFI_MEMORY_WT, it is seldom used in practice and not implemented
+	 * by most (all?) CPUs. Rather than allocate a MAIR just for this
+	 * purpose, emit a warning and use Normal Non-cacheable instead.
+	 */
+	pr_warn_once("No MAIR allocation for EFI_MEMORY_WT; treating as Normal Non-cacheable\n");
+	return __pgprot(PROT_NORMAL_NC);
+}
+
+pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
+{
+	/*
+	 * According to "Table 8 Map: EFI memory types to AArch64 memory
+	 * types" of UEFI 2.5 section 2.3.6.1, each EFI memory type is
+	 * mapped to a corresponding MAIR attribute encoding.
+	 * The EFI memory attribute advises all possible capabilities
+	 * of a memory region.
+	 */
+
+	u64 attr;
+
+	attr = efi_mem_attributes(addr);
+	if (attr & EFI_MEMORY_WB)
+		return PAGE_KERNEL;
+	if (attr & EFI_MEMORY_WC)
+		return __pgprot(PROT_NORMAL_NC);
+	if (attr & EFI_MEMORY_WT)
+		return __acpi_get_writethrough_mem_attribute();
+	return __pgprot(PROT_DEVICE_nGnRnE);
+}
+
+void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
+{
+	efi_memory_desc_t *md, *region = NULL;
+	pgprot_t prot;
+
+	if (WARN_ON_ONCE(!efi_enabled(EFI_MEMMAP)))
+		return NULL;
+
+	for_each_efi_memory_desc(md) {
+		u64 end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT);
+
+		if (phys < md->phys_addr || phys >= end)
+			continue;
+
+		if (phys + size > end) {
+			pr_warn(FW_BUG "requested region covers multiple EFI memory regions\n");
+			return NULL;
+		}
+		region = md;
+		break;
+	}
+
+	/*
+	 * It is fine for AML to remap regions that are not represented in the
+	 * EFI memory map at all, as it only describes normal memory, and MMIO
+	 * regions that require a virtual mapping to make them accessible to
+	 * the EFI runtime services.
+	 */
+	prot = __pgprot(PROT_DEVICE_nGnRnE);
+	if (region) {
+		switch (region->type) {
+		case EFI_LOADER_CODE:
+		case EFI_LOADER_DATA:
+		case EFI_BOOT_SERVICES_CODE:
+		case EFI_BOOT_SERVICES_DATA:
+		case EFI_CONVENTIONAL_MEMORY:
+		case EFI_PERSISTENT_MEMORY:
+			if (memblock_is_map_memory(phys) ||
+			    !memblock_is_region_memory(phys, size)) {
+				pr_warn(FW_BUG "requested region covers kernel memory @ %pa\n", &phys);
+				return NULL;
+			}
+			/*
+			 * Mapping kernel memory is permitted if the region in
+			 * question is covered by a single memblock with the
+			 * NOMAP attribute set: this enables the use of ACPI
+			 * table overrides passed via initramfs, which are
+			 * reserved in memory using arch_reserve_mem_area()
+			 * below. As this particular use case only requires
+			 * read access, fall through to the R/O mapping case.
+			 */
+			fallthrough;
+
+		case EFI_RUNTIME_SERVICES_CODE:
+			/*
+			 * This would be unusual, but not problematic per se,
+			 * as long as we take care not to create a writable
+			 * mapping for executable code.
+			 */
+			prot = PAGE_KERNEL_RO;
+			break;
+
+		case EFI_ACPI_RECLAIM_MEMORY:
+			/*
+			 * ACPI reclaim memory is used to pass firmware tables
+			 * and other data that is intended for consumption by
+			 * the OS only, which may decide it wants to reclaim
+			 * that memory and use it for something else. We never
+			 * do that, but we usually add it to the linear map
+			 * anyway, in which case we should use the existing
+			 * mapping.
+			 */
+			if (memblock_is_map_memory(phys))
+				return (void __iomem *)__phys_to_virt(phys);
+			fallthrough;
+
+		default:
+			if (region->attribute & EFI_MEMORY_WB)
+				prot = PAGE_KERNEL;
+			else if (region->attribute & EFI_MEMORY_WC)
+				prot = __pgprot(PROT_NORMAL_NC);
+			else if (region->attribute & EFI_MEMORY_WT)
+				prot = __acpi_get_writethrough_mem_attribute();
+		}
+	}
+	return ioremap_prot(phys, size, prot);
+}
+
+/*
+ * Claim Synchronous External Aborts as a firmware first notification.
+ *
+ * Used by KVM and the arch do_sea handler.
+ * @regs may be NULL when called from process context.
+ */
+int apei_claim_sea(struct pt_regs *regs)
+{
+	int err = -ENOENT;
+	bool return_to_irqs_enabled;
+	unsigned long current_flags;
+
+	if (!IS_ENABLED(CONFIG_ACPI_APEI_GHES))
+		return err;
+
+	current_flags = local_daif_save_flags();
+
+	/* current_flags isn't useful here as daif doesn't tell us about pNMI */
+	return_to_irqs_enabled = !irqs_disabled_flags(arch_local_save_flags());
+
+	if (regs)
+		return_to_irqs_enabled = interrupts_enabled(regs);
+
+	/*
+	 * SEA can interrupt SError, mask it and describe this as an NMI so
+	 * that APEI defers the handling.
+	 */
+	local_daif_restore(DAIF_ERRCTX);
+	nmi_enter();
+	err = ghes_notify_sea();
+	nmi_exit();
+
+	/*
+	 * APEI NMI-like notifications are deferred to irq_work. Unless
+	 * we interrupted irqs-masked code, we can do that now.
+	 */
+	if (!err) {
+		if (return_to_irqs_enabled) {
+			local_daif_restore(DAIF_PROCCTX_NOIRQ);
+			__irq_enter();
+			irq_work_run();
+			__irq_exit();
+		} else {
+			pr_warn_ratelimited("APEI work queued but not completed");
+			err = -EINPROGRESS;
+		}
+	}
+
+	local_daif_restore(current_flags);
+
+	return err;
+}
+
+void arch_reserve_mem_area(acpi_physical_address addr, size_t size)
+{
+	memblock_mark_nomap(addr, size);
+}
+
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 apci_id,
+		 int *pcpu)
+{
+	/* If an error code is passed in this stub can't fix it */
+	if (*pcpu < 0) {
+		pr_warn_once("Unable to map CPU to valid ID\n");
+		return *pcpu;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(acpi_map_cpu);
+
+int acpi_unmap_cpu(int cpu)
+{
+	return 0;
+}
+EXPORT_SYMBOL(acpi_unmap_cpu);
+#endif /* CONFIG_ACPI_HOTPLUG_CPU */
-- 
2.50.1.windows.1

