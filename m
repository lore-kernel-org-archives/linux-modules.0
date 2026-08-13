Received: from mta1.migadu.com (out-82.mta1.migadu.com [95.215.58.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5B7368D47
	for <linux-modules@vger.kernel.org>; Thu, 13 Aug 2026 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613647; cv=none; b=kdWNMt/xGoBLc+rVbicOQVHc3asJRrMHuT6VHq5srqQQTpKmwFiXH5CcBRA+9cii2dxlyUtxGibb7n6y+tYa1KxztTlQxKjrN3OcUqw7MhfVzrCotrmRbrt9Ev3HDCy13ssLRiOEaFbq5/Y+SOgBvt+YQ11p8fOhmomuYmOeUhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613647; c=relaxed/simple;
	bh=tn8UuuKtkL7oFhh/U1B37Ptewe1hVf6VZJL600BRXaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vkmdw+R1LSgxRppv56LL3tfYqeoMPyQ+bVbpRJy2O49HjPbhk84o4vpWTCUqcOEAGs1XW23E5MATio5dEFjG+Envzx79cFCMukJVJTxyHWY/Z7xCYF8AP1d+ERDiezd3aieLCnaIvH8IX3SV8zhoZ74R46kk9mS4U1wHZS9Xy5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R+s3hV0h; arc=none smtp.client-ip=95.215.58.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R+s3hV0h"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tn8UuuKtkL7oFhh/U1B37Ptewe1hVf6VZJL600BRXaI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786613642; v=1; x=1787218442;
 b=R+s3hV0hwNWw2YqRK61gyGZSWsi0NzlxZ41cEH91H2VdK3rR6R8dLF+kZNmGEL0RffvySZwA
 oOBND4ErRTI/1GsygxOHzTJN1o3Js95zoiKlcVuPeitJ0T/NTzqLqnYfIMjzCPqamL92lxoBj+E
 +vUnciOaqLMc6Wi/s+pjDUvw=
X-Envelope-To: linux-modules@vger.kernel.org
Received: from localhost.localdomain (116.128.244.169)
	by smtp.migadu.com with ESMTPS id 7cdc111fd4b862bb;
	Thu, 13 Aug 2026 09:34:02 +0000
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
Subject: [RFC PATCH 1/3] alloc_tag: skip percpu counter allocation when profiling is disabled
Date: Thu, 13 Aug 2026 17:34:19 +0800
Message-Id: <20260813093421.135230-2-hao.ge@linux.dev>
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

After shutdown_mem_profiling() clears mem_profiling_support,
needs_section_mem() returns false, so later modules have their codetag
section placed as regular data and never enter the alloc_tag maple tree.
codetag_load_module() still called load_module(), which allocated a percpu
counter for every tag; release_module_tags() could not find these modules
on unload, so the counters leaked.

Return CODETAG_MODULE_EXCLUDED from load_module() when profiling is off:
codetag_module_init() drops the module's cmod and no counters are
allocated. codetag_unload_module() now always calls free_section_mem(),
since an excluded module may still hold a reserved section.

Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 include/linux/codetag.h | 4 ++++
 lib/codetag.c           | 8 +++++---
 mm/alloc_tag.c          | 8 ++++++--
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index a25a085c2df1..88081c618673 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -52,6 +52,10 @@ struct codetag_type_desc {
 #endif
 };
 
+/* module_load() return values */
+#define CODETAG_MODULE_LOAD	0	/* module loads with its tags */
+#define CODETAG_MODULE_EXCLUDED	1	/* module loads without its tags */
+
 struct codetag_iterator {
 	struct codetag_type *cttype;
 	struct codetag_module *cmod;
diff --git a/lib/codetag.c b/lib/codetag.c
index a9cda4c962a3..8506ecab9ea7 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -238,9 +238,10 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 	}
 	up_write(&cttype->mod_lock);
 
-	if (err < 0) {
+	if (err) {
+		/* Error or excluded: cmod is dropped, free it. */
 		kfree(cmod);
-		return err;
+		return err < 0 ? err : 0;
 	}
 
 	return 0;
@@ -388,7 +389,8 @@ void codetag_unload_module(struct module *mod)
 			++cttype->content_id;
 		}
 		up_write(&cttype->mod_lock);
-		if (found && cttype->desc.free_section_mem)
+		/* an excluded module may still hold section memory */
+		if (cttype->desc.free_section_mem)
 			cttype->desc.free_section_mem(mod, true);
 	}
 	mutex_unlock(&codetag_lock);
diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index 0a7b657fe2de..461fa87fbb0b 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -977,9 +977,13 @@ static int load_module(struct module *mod, struct codetag *start, struct codetag
 	struct alloc_tag *stop_tag;
 	struct alloc_tag *tag;
 
+	/* Profiling disabled: load the module but exclude its tags. */
+	if (!mem_profiling_support)
+		return CODETAG_MODULE_EXCLUDED;
+
 	/* percpu counters for core allocations are already statically allocated */
 	if (!mod)
-		return 0;
+		return CODETAG_MODULE_LOAD;
 
 	start_tag = ct_to_alloc_tag(start);
 	stop_tag = ct_to_alloc_tag(stop);
@@ -1002,7 +1006,7 @@ static int load_module(struct module *mod, struct codetag *start, struct codetag
 		 */
 		kmemleak_ignore_percpu(tag->counters);
 	}
-	return 0;
+	return CODETAG_MODULE_LOAD;
 }
 
 static void replace_module(struct module *mod, struct module *new_mod)
-- 
2.25.1

