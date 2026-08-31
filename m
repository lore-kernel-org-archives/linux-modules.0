Received: from mta0.migadu.com (out-84.mta0.migadu.com [91.218.175.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEBD3C455F
	for <linux-modules@vger.kernel.org>; Mon, 31 Aug 2026 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160843; cv=none; b=JI4Wd8HJfo9+Kp/nWZxtV3tvrxpaukhndHmhxXVHBkJOPAGLCvCvAWNV4QhCtu3Nu4wAQLjr7ddbEGi40r88Mns3KV5Skce3E4//6NDTdeRvA/RHp65jK6kMi4LWIytmpSPsfpOKB6R2xKBOjYY7In1/0r1842v8uE0wMCzL1OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160843; c=relaxed/simple;
	bh=w3KSkMf6l9toWeai+kZJfAXDdwBcuEHBoU2cjDlYTSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u8ba3QL7oTQE6Icsg/aEHH304ujr/KvsmROxqpzqiP1d9bzmgKt+r81qcjnbacwQo7LUCOz4ZCwWtPoBO5uo2N5OOt/IGFh158wZ06swCyTPcbZz9U/41uJuuOW9e7lczNMuoaTKVwf3Mnp4fX0kSxzgiENKdQHcVJ34xRxHn/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TQmF6qH5; arc=none smtp.client-ip=91.218.175.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TQmF6qH5"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=w3KSkMf6l9toWeai+kZJfAXDdwBcuEHBoU2cjDlYTSs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788160839; v=1; x=1788765639;
 b=TQmF6qH58MHdicFpmCFNqXU6E4EnbNk2KN8MkQKAY7neB2FO8SYlMY5qEyegGiW5a8GOue8Y
 ESgJEfZ/ddDDwx7ojJy2VnG7Mtbt3MwoQ5uco8WeSz0Fpvvbfnx3Q8adMW71PHdgcTGJ/Ao9ard
 wo6UA7srwDW2mjBMOuCt12Ks=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d82006544af2806b;
	Mon, 31 Aug 2026 07:20:39 +0000
X-Mizu-Trace-ID: d82006544af2806b
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <hao.ge@linux.dev>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [RFC PATCH v6 2/2] module: allocate codetag sections before the regular module layout
Date: Mon, 31 Aug 2026 15:21:04 +0800
Message-Id: <20260831072104.120197-3-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260831072104.120197-1-hao.ge@linux.dev>
References: <20260831072104.120197-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whether a codetag section goes to the codetag region is decided by
layout_sections() and asked again in move_module(). A concurrent
load can shut profiling down in between, and move_module() then
copies the section to offset 0 of its regular destination,
overwriting whatever is there.

Decide and allocate in one pass, before the layout. Allocation
errors fail the load. On a tag area overflow profiling is already
disabled, so -EAGAIN makes the section fall back to regular module
data and the module still loads.

The overflow and populate failure paths of reserve_module_tags() now
release their reservation instead of leaking the maple tree entry.
When profiling was toggled off, the overflow check did not run, a
module could load with more tags than the page flags can address,
and re-enabling profiling then silently corrupted /proc/allocinfo.
The check no longer depends on mem_alloc_profiling_enabled().

Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Based-on-a-patch-by: Petr Pavlu <petr.pavlu@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
Changes against Petr's prototype:
- allocate_codetag_sections() returns an error instead of void, and
  only -EAGAIN falls back to a regular section. Any other error now
  fails the load. The prototype fell back on everything, which can
  leave live tags in module memory.
- reserve_module_tags() releases its reservation when populate fails
  too, that path used to leak the maple tree entry.
- codetag_free_module_sections() on the move_module() error path uses
  info->mod, the local mod is assigned only after a successful move.
- The percpu section is marked only when index.pcpu != 0, otherwise
  sechdrs[0] gets marked.
- Dropped the SHF_ALLOC check, .codetag.* sections always have it.
---
 include/linux/module.h   |   2 +
 kernel/module/internal.h |   4 ++
 kernel/module/main.c     | 120 ++++++++++++++++++++-------------------
 mm/alloc_tag.c           |   9 ++-
 4 files changed, 75 insertions(+), 60 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..33548daa31a3 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -325,6 +325,8 @@ enum mod_mem_type {
 	MOD_INIT_RODATA,
 
 	MOD_MEM_NUM_TYPES,
+
+	MOD_STANDALONE = -2,
 	MOD_INVALID = -1,
 };
 
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 061161cc79d9..217bb540e361 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -29,6 +29,10 @@
 #define SH_ENTSIZE_TYPE_MASK	((1UL << SH_ENTSIZE_TYPE_BITS) - 1)
 #define SH_ENTSIZE_OFFSET_MASK	((1UL << (BITS_PER_LONG - SH_ENTSIZE_TYPE_BITS)) - 1)
 
+#define SH_ENTSIZE_STANDALONE					\
+	(((unsigned long)MOD_STANDALONE & SH_ENTSIZE_TYPE_MASK)	\
+	 << SH_ENTSIZE_TYPE_SHIFT)
+
 /* Maximum number of characters written by module_flags() */
 #define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c32f1d370b73..587df9103f0b 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1625,7 +1625,7 @@ static int apply_relocations(struct module *mod, const struct load_info *info)
 		 * ELF template and subsequently copy it to the per-CPU destinations.
 		 */
 		if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC) &&
-		    (!infosec || infosec != info->index.pcpu))
+		    info->sechdrs[infosec].sh_entsize != SH_ENTSIZE_STANDALONE)
 			continue;
 
 		if (info->sechdrs[i].sh_flags & SHF_RELA_LIVEPATCH)
@@ -1723,20 +1723,6 @@ static void __layout_sections(struct module *mod, struct load_info *info, bool i
 			if (WARN_ON_ONCE(type == MOD_INVALID))
 				continue;
 
-			/*
-			 * Do not allocate codetag memory as we load it into
-			 * preallocated contiguous memory.
-			 */
-			if (codetag_needs_module_section(mod, sname, s->sh_size)) {
-				/*
-				 * s->sh_entsize won't be used but populate the
-				 * type field to avoid confusion.
-				 */
-				s->sh_entsize = ((unsigned long)(type) & SH_ENTSIZE_TYPE_MASK)
-						<< SH_ENTSIZE_TYPE_SHIFT;
-				continue;
-			}
-
 			s->sh_entsize = module_get_offset_and_type(mod, type, s, i);
 			pr_debug("\t%s\n", sname);
 		}
@@ -1746,16 +1732,10 @@ static void __layout_sections(struct module *mod, struct load_info *info, bool i
 /*
  * Lay out the SHF_ALLOC sections in a way not dissimilar to how ld
  * might -- code, read-only data, read-write data, small data.  Tally
- * sizes, and place the offsets into sh_entsize fields: high bit means it
- * belongs in init.
+ * sizes, and place the offsets into sh_entsize fields.
  */
 static void layout_sections(struct module *mod, struct load_info *info)
 {
-	unsigned int i;
-
-	for (i = 0; i < info->hdr->e_shnum; i++)
-		info->sechdrs[i].sh_entsize = ~0UL;
-
 	pr_debug("Core section allocation order for %s:\n", mod->name);
 	__layout_sections(mod, info, false);
 
@@ -2789,7 +2769,6 @@ static int move_module(struct module *mod, struct load_info *info)
 {
 	int i, ret;
 	enum mod_mem_type t = MOD_MEM_NUM_TYPES;
-	bool codetag_section_found = false;
 
 	for_each_mod_mem_type(type) {
 		if (!mod->mem[type].size) {
@@ -2807,36 +2786,14 @@ static int move_module(struct module *mod, struct load_info *info)
 	/* Transfer each section which specifies SHF_ALLOC */
 	pr_debug("Final section addresses for %s:\n", mod->name);
 	for (i = 0; i < info->hdr->e_shnum; i++) {
-		void *dest;
 		Elf_Shdr *shdr = &info->sechdrs[i];
-		const char *sname;
+		void *dest;
 
 		if (!(shdr->sh_flags & SHF_ALLOC))
 			continue;
 
-		sname = info->secstrings + shdr->sh_name;
-		/*
-		 * Load codetag sections separately as they might still be used
-		 * after module unload.
-		 */
-		if (codetag_needs_module_section(mod, sname, shdr->sh_size)) {
-			dest = codetag_alloc_module_section(mod, sname, shdr->sh_size,
-					arch_mod_section_prepend(mod, i), shdr->sh_addralign);
-			if (WARN_ON(!dest)) {
-				ret = -EINVAL;
-				goto out_err;
-			}
-			if (IS_ERR(dest)) {
-				ret = PTR_ERR(dest);
-				goto out_err;
-			}
-			codetag_section_found = true;
-		} else {
-			enum mod_mem_type type = shdr->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
-			unsigned long offset = shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK;
-
-			dest = mod->mem[type].base + offset;
-		}
+		dest = mod->mem[shdr->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT].base +
+		       (shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK);
 
 		if (shdr->sh_type != SHT_NOBITS) {
 			/*
@@ -2868,8 +2825,6 @@ static int move_module(struct module *mod, struct load_info *info)
 	module_memory_restore_rox(mod);
 	while (t--)
 		module_memory_free(mod, t);
-	if (codetag_section_found)
-		codetag_free_module_sections(mod);
 
 	return ret;
 }
@@ -2940,9 +2895,48 @@ static bool blacklisted(const char *module_name)
 }
 core_param(module_blacklist, module_blacklist, charp, 0400);
 
+/*
+ * Allocate codetag sections separately. They are loaded into preallocated
+ * contiguous memory because they may still be used after the module is
+ * unloaded.
+ *
+ * If the separate allocation overflows, allocate the section normally
+ * so that the module can still be loaded.
+ */
+static int allocate_codetag_sections(struct load_info *info)
+{
+	for (unsigned int i = 1; i < info->hdr->e_shnum; i++) {
+		Elf_Shdr *shdr = &info->sechdrs[i];
+		const char *sname = info->secstrings + shdr->sh_name;
+		void *dest;
+
+		if (!codetag_needs_module_section(info->mod, sname, shdr->sh_size))
+			continue;
+
+		dest = codetag_alloc_module_section(info->mod, sname, shdr->sh_size,
+				arch_mod_section_prepend(info->mod, i), shdr->sh_addralign);
+		if (WARN_ON(!dest))
+			return -EINVAL;
+		if (dest == ERR_PTR(-EAGAIN))
+			/* Allocate the section as a regular section. */
+			continue;
+		if (IS_ERR(dest))
+			return PTR_ERR(dest);
+
+		if (shdr->sh_type != SHT_NOBITS)
+			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
+		shdr->sh_addr = (unsigned long)dest;
+		shdr->sh_flags &= ~(unsigned long)SHF_ALLOC;
+		shdr->sh_entsize = SH_ENTSIZE_STANDALONE;
+	}
+
+	return 0;
+}
+
 static struct module *layout_and_allocate(struct load_info *info, int flags)
 {
 	struct module *mod;
+	unsigned int i;
 	int err;
 
 	/* Allow arches to frob section contents and sizes.  */
@@ -2956,8 +2950,15 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	if (err < 0)
 		return ERR_PTR(err);
 
+	/* Repurpose sh_entsize to track where each section is allocated. */
+	for (i = 0; i < info->hdr->e_shnum; i++)
+		info->sechdrs[i].sh_entsize = ~0UL;
+
 	/* We will do a special allocation for per-cpu sections later. */
-	info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
+	if (info->index.pcpu) {
+		info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
+		info->sechdrs[info->index.pcpu].sh_entsize = SH_ENTSIZE_STANDALONE;
+	}
 
 	/*
 	 * Mark relevant sections as SHF_RO_AFTER_INIT so layout_sections() can
@@ -2966,18 +2967,23 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	 */
 	module_mark_ro_after_init(info->hdr, info->sechdrs, info->secstrings);
 
-	/*
-	 * Determine total sizes, and put offsets in sh_entsize.  For now
-	 * this is done generically; there doesn't appear to be any
-	 * special cases for the architectures.
-	 */
+	/* Allow codetag sections to be allocated separately first. */
+	err = allocate_codetag_sections(info);
+	if (err) {
+		codetag_free_module_sections(info->mod);
+		return ERR_PTR(err);
+	}
+
+	/* Determine total sizes and put offsets in sh_entsize. */
 	layout_sections(info->mod, info);
 	layout_symtab(info->mod, info);
 
 	/* Allocate and move to the final place */
 	err = move_module(info->mod, info);
-	if (err)
+	if (err) {
+		codetag_free_module_sections(info->mod);
 		return ERR_PTR(err);
+	}
 
 	/* Module has been copied to its final place now: return it. */
 	mod = (void *)info->sechdrs[info->index.mod].sh_addr;
diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index e7a79116ad81..3c25475becbc 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -958,10 +958,12 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 		int grow_res;
 
 		module_tags.size = offset + size;
-		if (mem_alloc_profiling_enabled() && !tags_addressable()) {
+		if (!tags_addressable()) {
 			shutdown_mem_profiling(true);
-			pr_warn("With module %s there are too many tags to fit in %d page flag bits. Memory allocation profiling is disabled!\n",
-				mod->name, NR_UNUSED_PAGEFLAG_BITS);
+			pr_warn_once("With module %s there are too many tags to fit in %d page flag bits. Memory allocation profiling is disabled!\n",
+				     mod->name, NR_UNUSED_PAGEFLAG_BITS);
+			release_module_tags(mod, false);
+			return ERR_PTR(-EAGAIN);
 		}
 
 		grow_res = vm_module_tags_populate();
@@ -969,6 +971,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 			shutdown_mem_profiling(true);
 			pr_err("Failed to allocate memory for allocation tags in the module %s. Memory allocation profiling is disabled!\n",
 			       mod->name);
+			release_module_tags(mod, false);
 			return ERR_PTR(grow_res);
 		}
 	}
-- 
2.25.1

