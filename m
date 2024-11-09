Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12E7233D73;
	Sat,  9 Nov 2024 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731148550; cv=none; b=J1YmbheClnNePbDTDrHaKyR8k7cL3U2RobXqM69qjHvghJaoAyNWEbSag8fMhwWJIeVXshZCuVdeCqTdtRXLI16kdWyrAc7F+dsS/LGNopIqP6ZmN7SpS6YxDvRvRfxmO1svsFLXfBz651lYIhJQzXca5vSa1Ck8xFY2eZz0/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731148550; c=relaxed/simple;
	bh=gXKRqLxxXBjIVDR5cFoLFoTIx1e73ApAKBiFehUXKEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iLimqsHZgmvW2qkA4Qd+j79sKdeoch247JK3US3Lc8ULlCgT00t1YywkNwzK8M4dnmjCdvvEDVFXo5m8uHI6zzzYKfy92g/oSYWF32J7VgWjWzlKTrBhcpeylrF1sLMYqvbvgfKu3DbTHX18Q+UOBJqdVWCsEnHDrL2IKk7UAsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XlsfB72XKz9sSL;
	Sat,  9 Nov 2024 11:35:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P7nDHsmj9Vh6; Sat,  9 Nov 2024 11:35:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XlsfB5zkXz9sSK;
	Sat,  9 Nov 2024 11:35:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B68828B766;
	Sat,  9 Nov 2024 11:35:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id IdWHeTbrwF2J; Sat,  9 Nov 2024 11:35:46 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.57])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3A7228B764;
	Sat,  9 Nov 2024 11:35:46 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Kees Cook <kees@kernel.org>,
	linux-modules@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 1/3] module: Split module_enable_rodata_ro()
Date: Sat,  9 Nov 2024 11:35:35 +0100
Message-ID: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731148536; l=3205; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=gXKRqLxxXBjIVDR5cFoLFoTIx1e73ApAKBiFehUXKEY=; b=uC3i/uZ9IPjgOa/m6rtFw0nMPbk6QyKHcwM5C6gHY/Q4NS8hSeUheJ4GO+ATsqX+qqO0bv3no 6y/eq2Xl1neD7jHbFzWLuTw8qWQa3yyvn+A+WtL9dL4FIvx6tTH3bjg
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

module_enable_rodata_ro() is called twice, once before module init
to set rodata sections readonly and once after module init to set
rodata_after_init section readonly.

The second time, only the rodata_after_init section needs to be
set to read-only, no need to re-apply it to already set rodata.

Split module_enable_rodata_ro() in two.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/internal.h   |  3 ++-
 kernel/module/main.c       |  4 ++--
 kernel/module/strict_rwx.c | 13 +++++++++----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 2ebece8a789f..994f35a779dc 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -322,7 +322,8 @@ static inline struct module *mod_find(unsigned long addr, struct mod_tree_root *
 }
 #endif /* CONFIG_MODULES_TREE_LOOKUP */
 
-int module_enable_rodata_ro(const struct module *mod, bool after_init);
+int module_enable_rodata_ro(const struct module *mod);
+int module_enable_rodata_ro_after_init(const struct module *mod);
 int module_enable_data_nx(const struct module *mod);
 int module_enable_text_rox(const struct module *mod);
 int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 49b9bca9de12..2de4ad7af335 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2581,7 +2581,7 @@ static noinline int do_init_module(struct module *mod)
 	/* Switch to core kallsyms now init is done: kallsyms may be walking! */
 	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
 #endif
-	ret = module_enable_rodata_ro(mod, true);
+	ret = module_enable_rodata_ro_after_init(mod);
 	if (ret)
 		goto fail_mutex_unlock;
 	mod_tree_remove_init(mod);
@@ -2751,7 +2751,7 @@ static int complete_formation(struct module *mod, struct load_info *info)
 	module_bug_finalize(info->hdr, info->sechdrs, mod);
 	module_cfi_finalize(info->hdr, info->sechdrs, mod);
 
-	err = module_enable_rodata_ro(mod, false);
+	err = module_enable_rodata_ro(mod);
 	if (err)
 		goto out_strict_rwx;
 	err = module_enable_data_nx(mod);
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index c45caa4690e5..f68c59974ae2 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -44,7 +44,7 @@ int module_enable_text_rox(const struct module *mod)
 	return 0;
 }
 
-int module_enable_rodata_ro(const struct module *mod, bool after_init)
+int module_enable_rodata_ro(const struct module *mod)
 {
 	int ret;
 
@@ -58,12 +58,17 @@ int module_enable_rodata_ro(const struct module *mod, bool after_init)
 	if (ret)
 		return ret;
 
-	if (after_init)
-		return module_set_memory(mod, MOD_RO_AFTER_INIT, set_memory_ro);
-
 	return 0;
 }
 
+int module_enable_rodata_ro_after_init(const struct module *mod)
+{
+	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX) || !rodata_enabled)
+		return 0;
+
+	return module_set_memory(mod, MOD_RO_AFTER_INIT, set_memory_ro);
+}
+
 int module_enable_data_nx(const struct module *mod)
 {
 	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
-- 
2.44.0

