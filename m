Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482E28C009
	for <linux-modules@vger.kernel.org>; Wed, 24 Dec 2025 04:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766550732; cv=none; b=cHULC0KuqmGM+E9oDK9ZqAynxuFz7Z1L/Hpnh4omG838K89sRM5QRLlK+xXLB7GlAZK5hS7KRfzqDAjTwwiOoXa6QBfFzi0ahuw3B0035LuAeReh/bpwWm2kl2yjWXzfD/LDQy4uOPS1xXP138N6vLgsZ/LO1Y85r+8AYWKu8Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766550732; c=relaxed/simple;
	bh=5hCqqnMuX901tu2ICqgwO+v8/gncXU+eR+poRyeGdhE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ojjLRnGgvbO/yQZMCrzrfGY5uNb5iVQkygdafDpqrzLqVzAnaRFUvANDaF4E1TlP14DRpqWT0xd6Vr9s1gxIR+tNQKg2Aem6+fnQz3DKHQQ4ULrEnl6UF0im98JnjvjBtLvYg+WgKC3d/DHTXBsc52WXLWG5iZSraZgoqCOjLAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KcFQuvpr; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KcFQuvpr"
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251224043159epoutp02bc3eca4b5c9f73d22a36cea35c2e1fbd~EDIUX-2yH1167011670epoutp02b
	for <linux-modules@vger.kernel.org>; Wed, 24 Dec 2025 04:31:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251224043159epoutp02bc3eca4b5c9f73d22a36cea35c2e1fbd~EDIUX-2yH1167011670epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766550719;
	bh=YXO066pxNrwE8u/0uOTahD5Dqr7uT2f/RtFKzM9d2wM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=KcFQuvprpBZcEJTUP1iwq7jKeCjP1BBbfZf8qdeub3bas04Un6yMxqALKcSvaVFMZ
	 NpYlC23WzPFs+EdJyQl7KI35W8bmlK7rFSVWIt1K6W15AKe1aiGigQ2DZKrg4N9O1j
	 ZrWiEvNW8dkkQ2Z/i2HQdqwBaRFZfP+vb1Ovw83k=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20251224043159epcas2p2bec422ba6a2026ec0596fcfdba517134~EDIUIrhio0447704477epcas2p25;
	Wed, 24 Dec 2025 04:31:59 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.210]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4dbf9B6kllz6B9m5; Wed, 24 Dec
	2025 04:31:58 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20251224043158epcas2p217889374e0ea4b1722371ca143741d85~EDITQtNh33231632316epcas2p2c;
	Wed, 24 Dec 2025 04:31:58 +0000 (GMT)
Received: from KORCO166536.samsungds.net (unknown [12.80.211.123]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251224043158epsmtip1adab85e65ea1c837451facb7a8f6c346~EDITNzRPo0800208002epsmtip12;
	Wed, 24 Dec 2025 04:31:58 +0000 (GMT)
From: Yunjin Kim <yunzhen.kim@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>
Cc: Yunjin Kim <yunzhen.kim@samsung.com>, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: [PATCH] ANDROID: gki: kallsyms: add
 kallsyms_lookup_address_and_size.
Date: Wed, 24 Dec 2025 13:31:57 +0900
Message-Id: <20251224043157.59289-1-yunzhen.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251224043158epcas2p217889374e0ea4b1722371ca143741d85
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251224043158epcas2p217889374e0ea4b1722371ca143741d85
References: <CGME20251224043158epcas2p217889374e0ea4b1722371ca143741d85@epcas2p2.samsung.com>

This methods are used by AKKstub-ARM Kernel Kstub.

We need to implement an automatic kernel-method mock that streamlines the
mocking process during kernel-method testing and enables fully automated
operations. This mechanism must traverse the binary instructions of the
target function in memory, locate the appropriate instruction, and replace
it. To perform the traversal, it must know the function’s entry address and
the size of its instruction range.

Bug:
Change-Id: I5a318f762d4412e70b0c8dcf2dfed326312bdc65
Signed-off-by: Yunjin Kim <yunzhen.kim@samsung.com>
---
 include/linux/kallsyms.h |  2 ++
 include/linux/module.h   |  2 ++
 kernel/kallsyms.c        | 38 ++++++++++++++++++++++++++
 kernel/module/kallsyms.c | 58 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 1c6a6c1704d8..ec59f25259f2 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -78,6 +78,8 @@ int kallsyms_on_each_match_symbol(int (*fn)(void *, unsigned long),
 /* Lookup the address for a symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name);

+unsigned long kallsyms_lookup_address_and_size(const char *name, unsigned long *address, unsigned long * size);
+
 extern int kallsyms_lookup_size_offset(unsigned long addr,
				  unsigned long *symbolsize,
				  unsigned long *offset);
diff --git a/include/linux/module.h b/include/linux/module.h
index 5beb39d56197..47fb46bd1b92 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -976,6 +976,8 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 /* Look for this name: can be of form module:name. */
 unsigned long module_kallsyms_lookup_name(const char *name);

+unsigned long module_kallsyms_lookup_address_and_size(const char *name, unsigned long *address, unsigned long *size);
+
 unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name);

 #else	/* CONFIG_MODULES && CONFIG_KALLSYMS */
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index a9a0ca605d4a..5533816794da 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -160,6 +160,22 @@ unsigned long kallsyms_sym_address(int idx)
	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
 }

+unsigned long kallsyms_sym_address_and_size(int idx, unsigned long *size)
+{
+	/* values are unsigned offsets if --absolute-percpu is not in effect */
+	*size = kallsyms_offsets[idx+1] - kallsyms_offsets[idx];
+
+	if (!IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU))
+		return kallsyms_relative_base + (u32)kallsyms_offsets[idx];
+
+	/* ...otherwise, positive offsets are absolute values */
+	if (kallsyms_offsets[idx] >= 0)
+		return kallsyms_offsets[idx];
+
+	/* ...and negative offsets are relative to kallsyms_relative_base - 1 */
+	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
+}
+
 static unsigned int get_symbol_seq(int index)
 {
	unsigned int i, seq = 0;
@@ -242,6 +258,27 @@ unsigned long kallsyms_lookup_name(const char *name)

	return module_kallsyms_lookup_name(name);
 }
+EXPORT_SYMBOL(kallsyms_lookup_name);
+
+unsigned long kallsyms_lookup_address_and_size(const char *name, unsigned long *address, unsigned long * size)
+{
+	int ret;
+	unsigned int i;
+
+	/* Skip the search for empty string. */
+	if (!*name)
+		return 0;
+
+	ret = kallsyms_lookup_names(name, &i, NULL);
+	if (!ret){
+		*address = kallsyms_sym_address_and_size(get_symbol_seq(i), size);
+		return *address;
+	}
+
+	//return module_kallsyms_lookup_name(name);
+	return module_kallsyms_lookup_address_and_size(name, address, size);
+}
+EXPORT_SYMBOL(kallsyms_lookup_address_and_size);

 /*
  * Iterate over all symbols in vmlinux.  For symbols from modules use
@@ -430,6 +467,7 @@ int lookup_symbol_name(unsigned long addr, char *symname)
	/* See if it's in a module. */
	return lookup_module_symbol_name(addr, symname);
 }
+EXPORT_SYMBOL(lookup_symbol_name);

 /* Look up a kernel symbol and return it in a text buffer. */
 static int __sprint_symbol(char *buffer, unsigned long address,
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index bf65e0c3c86f..e8552f5e64c8 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -462,6 +462,64 @@ unsigned long module_kallsyms_lookup_name(const char *name)
	return ret;
 }

+static unsigned long __find_kallsyms_symbol_address_and_size_value(struct module *mod, const char *name, unsigned long *address, unsigned long* size)
+{
+	unsigned int i;
+	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
+	unsigned long ret = 0;
+
+	for (i = 0; i < kallsyms->num_symtab; i++) {
+		const Elf_Sym *sym = &kallsyms->symtab[i];
+
+		if (strcmp(name, kallsyms_symbol_name(kallsyms, i)) == 0 &&
+		    sym->st_shndx != SHN_UNDEF){
+			ret = kallsyms_symbol_value(sym);
+			*address = ret;
+			*size = sym->st_size;
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static unsigned long __module_kallsyms_lookup_address_and_size(const char *name, unsigned long *address, unsigned long *size)
+{
+	struct module *mod;
+	char *colon;
+
+	colon = strnchr(name, MODULE_NAME_LEN, ':');
+	if (colon) {
+		mod = find_module_all(name, colon - name, false);
+		if (mod)
+			return __find_kallsyms_symbol_address_and_size_value(mod, colon + 1, address, size);
+		return 0;
+	}
+
+	list_for_each_entry_rcu(mod, &modules, list) {
+		unsigned long ret;
+
+		if (mod->state == MODULE_STATE_UNFORMED)
+			continue;
+		ret = __find_kallsyms_symbol_address_and_size_value(mod, name, address, size);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+/* Look for this name: can be of form module:name. */
+unsigned long module_kallsyms_lookup_address_and_size(const char *name, unsigned long *address, unsigned long *size)
+{
+	unsigned long ret;
+
+	/* Don't lock: we're in enough trouble already. */
+	preempt_disable();
+	ret = __module_kallsyms_lookup_address_and_size(name, address, size);
+	preempt_enable();
+	return ret;
+}
+
+
 unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
 {
	unsigned long ret;
--
2.34.1
