Received: from mta1.migadu.com (out-88.mta1.migadu.com [95.215.58.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4512227F017
	for <linux-modules@vger.kernel.org>; Thu, 13 Aug 2026 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613657; cv=none; b=e9a88Whk4hPf1+NWD9qTGJD5I51k0FfmVWLhDOvjUkz7lyMDQoBGXq5XDA7OQcQoGKG/7KuEUnMf+HVpnVcDCR5YRD+l7BNynjrZI9ZUDCUGAW/1GkKFUx0zJ3EODxCZINCSfayvEsz8BMtvOJPhPIQhVP1HIzOAVSLHHtTcURc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613657; c=relaxed/simple;
	bh=p4TFMUd9q6GnbcN5ey2myrD4Zw8jApQ5r7UvSVGLQQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GBfXxI1iKNuPCopcLP4rNeWzfSVLh51rTJP82bN3iH5aW0cuyuaOQf1dHkLC4tL3dUw5+MoVyhkpU84EHLiIzixwHs5M083ExOMnei1zL+ygcx+h96I7xMThAvI03aKbIieHZyeh6NTAxC3r1lA//EAz7N+9DhKU0xu0ORTxSck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZxW9+DB6; arc=none smtp.client-ip=95.215.58.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZxW9+DB6"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=p4TFMUd9q6GnbcN5ey2myrD4Zw8jApQ5r7UvSVGLQQM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786613651; v=1; x=1787218451;
 b=ZxW9+DB6bwXRqzZq8to0yNNVzyfWCIMwxMxlc5JgvV4rHQ3KWecsC7XHr0G4Xeh/h48qWaS2
 qhMBoC3VqyRvFWWskbpQ4+TzVE/tiN2FlUJkrm8zTkkI6Vb7gX65e7MM9s7C2+TSjmfuYNBgg2X
 HP2JVkv+W56xc2ybPj/dKZDU=
X-Envelope-To: linux-modules@vger.kernel.org
Received: from localhost.localdomain (116.128.244.169)
	by smtp.migadu.com with ESMTPS id f70264e86958a884;
	Thu, 13 Aug 2026 09:34:11 +0000
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Hao Ge <hao.ge@linux.dev>
Subject: [RFC PATCH 2/3] module: move codetag section placement decision to layout_sections()
Date: Thu, 13 Aug 2026 17:34:20 +0800
Message-Id: <20260813093421.135230-3-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813093421.135230-1-hao.ge@linux.dev>
References: <20260813093421.135230-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codetag_needs_module_section() is called twice per codetag section, once
in layout_sections() and once in move_module(), and both depend on
mem_profiling_support, which changes without a lock. If profiling is
disabled between the two calls, layout excludes the section (offset 0)
while move copies it as normal memory to offset 0:

  CPU0 (insmod A)                    CPU1 (insmod B)
  ----------------                   ----------------
  layout_sections()
    needs_section_mem() == true
    sh_entsize: type, offset = 0
                                     reserve_module_tags() overflows
                                       shutdown_mem_profiling()
                                       mem_profiling_support = false
  move_module()
    needs_section_mem() == false
    offset = sh_entsize & MASK = 0
    memcpy(mod->mem[type].base + 0, ...)
       -> overwrites the first section there

Record the decision in layout_sections() in sh_entsize using a
MOD_MEM_CODETAG type, and have move_module() use that instead of asking
again.

reserve_module_tags() returns -EAGAIN if profiling was disabled after
layout, so the loader retries and places the section as normal memory.

Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 include/linux/module.h | 11 +++++++++++
 kernel/module/main.c   | 17 ++++++-----------
 mm/alloc_tag.c         |  8 ++++++++
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..a02016528e1d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -328,6 +328,17 @@ enum mod_mem_type {
 	MOD_INVALID = -1,
 };
 
+/*
+ * If CONFIG_CODE_TAGGING is on, modules get a .codetag section.
+ * codetag_needs_module_section() says where it goes: the usual
+ * mod->mem[], or off to the codetag region.
+ *
+ * Mark the codetag-region ones with MOD_MEM_NUM_TYPES.
+ * It's just past the real types, so it doesn't index into mod->mem[]
+ * and for_each_mod_mem_type() skips it.
+ */
+#define MOD_MEM_CODETAG	MOD_MEM_NUM_TYPES
+
 #define mod_mem_type_is_init(type)	\
 	((type) == MOD_INIT_TEXT ||	\
 	 (type) == MOD_INIT_DATA ||	\
diff --git a/kernel/module/main.c b/kernel/module/main.c
index ed26f167be84..2337bf604f58 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1728,11 +1728,8 @@ static void __layout_sections(struct module *mod, struct load_info *info, bool i
 			 * preallocated contiguous memory.
 			 */
 			if (codetag_needs_module_section(mod, sname, s->sh_size)) {
-				/*
-				 * s->sh_entsize won't be used but populate the
-				 * type field to avoid confusion.
-				 */
-				s->sh_entsize = ((unsigned long)(type) & SH_ENTSIZE_TYPE_MASK)
+				s->sh_entsize = ((unsigned long)MOD_MEM_CODETAG
+						 & SH_ENTSIZE_TYPE_MASK)
 						<< SH_ENTSIZE_TYPE_SHIFT;
 				continue;
 			}
@@ -2815,11 +2812,10 @@ static int move_module(struct module *mod, struct load_info *info)
 			continue;
 
 		sname = info->secstrings + shdr->sh_name;
-		/*
-		 * Load codetag sections separately as they might still be used
-		 * after module unload.
-		 */
-		if (codetag_needs_module_section(mod, sname, shdr->sh_size)) {
+
+		enum mod_mem_type type = shdr->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
+
+		if (type == MOD_MEM_CODETAG) {
 			dest = codetag_alloc_module_section(mod, sname, shdr->sh_size,
 					arch_mod_section_prepend(mod, i), shdr->sh_addralign);
 			if (WARN_ON(!dest)) {
@@ -2832,7 +2828,6 @@ static int move_module(struct module *mod, struct load_info *info)
 			}
 			codetag_section_found = true;
 		} else {
-			enum mod_mem_type type = shdr->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
 			unsigned long offset = shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK;
 
 			dest = mod->mem[type].base + offset;
diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index 461fa87fbb0b..7481180dadd2 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -893,6 +893,14 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 	if (size < sizeof(struct alloc_tag))
 		return ERR_PTR(-EINVAL);
 
+	/*
+	 * Profiling may have been disabled by a concurrent module load.
+	 * Return -EAGAIN so the loader retries with profiling off, laying
+	 * the section out as ordinary module memory.
+	 */
+	if (!mem_profiling_support)
+		return ERR_PTR(-EAGAIN);
+
 	/*
 	 * align is always power of 2, so we can use IS_ALIGNED and ALIGN.
 	 * align 0 or 1 means no alignment, to simplify set to 1.
-- 
2.25.1

