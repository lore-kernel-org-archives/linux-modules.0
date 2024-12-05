Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07FE19E961;
	Thu,  5 Dec 2024 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733427992; cv=none; b=rc3R9ZTIojmtUMdKxbQWU3B5P6rX8eokQUV55AV60WyldkHLS4RM167YPC7JYIs3+xL6T5waEZHJj1o1i4RW1mBtKCyIkMYnbc/9axshic2u6x4vsH7rha+DWhKX63wIOvjJr5DDhn9zw3kpCuVFUyplwRIKt0FzWgqdsitDjBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733427992; c=relaxed/simple;
	bh=6Fm0gx1a6AkZGf3Kqs5LhL/NAVxTyKNyuj72or1ZIYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkwiykCsfi8BPKOWXZuTOQeagFjRDmMEnY+FA2QkewK0Zi10f5DYSmHYDN005O0n0o4e2DPb4H9aOFoHTyybi2jSEfIF7/hWWt+KdPGNmthk+aNE2Ta6BuUs1ThnTI3vDV0XxXCrkHqtcaqqXCZdGIn8lPx0qK8rg40XdTiqLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y44dT0nnHz9svj;
	Thu,  5 Dec 2024 20:46:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZR9QcpiaDyPm; Thu,  5 Dec 2024 20:46:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y44dS6dPvz9svg;
	Thu,  5 Dec 2024 20:46:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CF9BD8B76E;
	Thu,  5 Dec 2024 20:46:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id jt0TSl1Xf3E8; Thu,  5 Dec 2024 20:46:20 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 53F298B770;
	Thu,  5 Dec 2024 20:46:20 +0100 (CET)
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
Subject: [PATCH v1 1/3] module: Split module_enable_rodata_ro()
Date: Thu,  5 Dec 2024 20:46:15 +0100
Message-ID: <e3b6ff0df7eac281c58bb02cecaeb377215daff3.1733427536.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733427536.git.christophe.leroy@csgroup.eu>
References: <cover.1733427536.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733427977; l=3253; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=6Fm0gx1a6AkZGf3Kqs5LhL/NAVxTyKNyuj72or1ZIYY=; b=rX1PuStiWXqDboVJ/ZxLvRqUML1O9fmBQJJWxXgBi+Gebgl5x2ONREaqOmaU0VYrBcmavVlSU nnCK+wQiW6CAJteuuuteOgNMszKvle5cXb/GWuYMQNEGV+iAWLBdTP8
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

module_enable_rodata_ro() is called twice, once before module init
to set rodata sections readonly and once after module init to set
rodata_after_init section readonly.

The second time, only the rodata_after_init section needs to be
set to read-only, no need to re-apply it to already set rodata.

Split module_enable_rodata_ro() in two.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Daniel Gomez <da.gomez@samsung.com>
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
index d2e1b8976c7b..39fe5d81b6a8 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2673,7 +2673,7 @@ static noinline int do_init_module(struct module *mod)
 	/* Switch to core kallsyms now init is done: kallsyms may be walking! */
 	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
 #endif
-	ret = module_enable_rodata_ro(mod, true);
+	ret = module_enable_rodata_ro_after_init(mod);
 	if (ret)
 		goto fail_mutex_unlock;
 	mod_tree_remove_init(mod);
@@ -2843,7 +2843,7 @@ static int complete_formation(struct module *mod, struct load_info *info)
 	module_bug_finalize(info->hdr, info->sechdrs, mod);
 	module_cfi_finalize(info->hdr, info->sechdrs, mod);
 
-	err = module_enable_rodata_ro(mod, false);
+	err = module_enable_rodata_ro(mod);
 	if (err)
 		goto out_strict_rwx;
 	err = module_enable_data_nx(mod);
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index 239e5013359d..74834ba15615 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -47,7 +47,7 @@ int module_enable_text_rox(const struct module *mod)
 	return 0;
 }
 
-int module_enable_rodata_ro(const struct module *mod, bool after_init)
+int module_enable_rodata_ro(const struct module *mod)
 {
 	int ret;
 
@@ -61,12 +61,17 @@ int module_enable_rodata_ro(const struct module *mod, bool after_init)
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
2.47.0

