Received: from mta0.migadu.com (out-100.mta0.migadu.com [91.218.175.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F93429CE6
	for <linux-modules@vger.kernel.org>; Tue, 15 Sep 2026 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455558; cv=none; b=NsQvdabMcYG6I9c97slOWzt1Bz/uVR3jzERpOJ0v11L5XteMq2C7q14W94sz4MvQ6xh+isYLYk1VvVhOUFFFx1KqGwqXnJgMJvV9pRZSxdiniGrL+P9CTHDnQe1vDMbPiv7J2+G1jSdK+KZqOWq7Hu6eKbhVn/wb+bDdIKOfmp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455558; c=relaxed/simple;
	bh=1hrOUU2WscT9i12+q2dsMTJyNqNUXrCyPWNHR9ygX74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mLF7hQ+l3Y4oGRTsuLXXgo34FWS6P2Aisc0U+ZMTN/kWPKZvK4q9nB04xMSutlZKgFgNfay6sbPkrT9QuYs/DZTM1h3vKfQWUpVOoC+Pn2zcOyRGCQY6sGveF1mRaM9hXPiCGtO1BI8GvijTMOtH2hwmrWBRWUgf7ji5ud/6i2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dz+c9LRn; arc=none smtp.client-ip=91.218.175.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dz+c9LRn"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1hrOUU2WscT9i12+q2dsMTJyNqNUXrCyPWNHR9ygX74=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789455553; v=1; x=1790060353;
 b=Dz+c9LRn+U4BKwUguORIFZqNQQxieg5o6zVodNBkoC2JEXt8UFf3IAGlY2Ygdn+0XcweaVfN
 RyzXkNvwdBOTnbJydG4u2KGY58++n+UcMBnQKR4CbLBnkhksvsIBdLOWisrIpXrFWhTKTay03rA
 jLB+iD4fMXYWigsmUd+sRAvg=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6a28f1219eb0585b;
	Tue, 15 Sep 2026 06:59:13 +0000
X-Mizu-Trace-ID: 6a28f1219eb0585b
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Hao Ge <hao.ge@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-modules@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v10 1/6] alloc_tag: move release_module_tags() above reserve_module_tags()
Date: Tue, 15 Sep 2026 14:59:56 +0800
Message-Id: <20260915070001.113559-2-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260915070001.113559-1-hao.ge@linux.dev>
References: <20260915070001.113559-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

release_module_tags() is a cleanup helper. reserve_module_tags() can
also fail after storing the reservation in the maple tree, in which
case it should call release_module_tags() to undo it. Move the helper
above reserve_module_tags() so no forward declaration is needed.

No functional change.

Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as needed")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Cc: stable@vger.kernel.org
Acked-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/alloc_tag.c | 92 +++++++++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index b33410310477..2070e682fe10 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -835,6 +835,52 @@ static int vm_module_tags_populate(void)
 	return 0;
 }
 
+static void release_module_tags(struct module *mod, bool used)
+{
+	MA_STATE(mas, &mod_area_mt, module_tags.size, module_tags.size);
+	struct alloc_tag *start_tag;
+	struct alloc_tag *end_tag;
+	struct module *val;
+
+	mas_lock(&mas);
+	mas_for_each_rev(&mas, val, 0)
+		if (val == mod)
+			break;
+
+	if (!val) /* module not found */
+		goto out;
+
+	if (!used)
+		goto release_area;
+
+	start_tag = (struct alloc_tag *)(module_tags.start_addr + mas.index);
+	end_tag = (struct alloc_tag *)(module_tags.start_addr + mas.last);
+	if (!clean_unused_counters(start_tag, end_tag)) {
+		struct alloc_tag *tag;
+
+		for (tag = start_tag; tag <= end_tag; tag++) {
+			struct alloc_tag_counters counter;
+
+			if (!tag->counters)
+				continue;
+
+			counter = alloc_tag_read(tag);
+			pr_info("%s:%u module %s func:%s has %llu allocated at module unload\n",
+				tag->ct.filename, tag->ct.lineno, tag->ct.modname,
+				tag->ct.function, counter.bytes);
+		}
+	} else {
+		used = false;
+	}
+release_area:
+	mas_store(&mas, used ? &unloaded_mod : NULL);
+	val = mas_prev_range(&mas, 0);
+	if (val == &prepend_mod)
+		mas_store(&mas, NULL);
+out:
+	mas_unlock(&mas);
+}
+
 static void *reserve_module_tags(struct module *mod, unsigned long size,
 				 unsigned int prepend, unsigned long align)
 {
@@ -922,52 +968,6 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 	return (struct alloc_tag *)(module_tags.start_addr + offset);
 }
 
-static void release_module_tags(struct module *mod, bool used)
-{
-	MA_STATE(mas, &mod_area_mt, module_tags.size, module_tags.size);
-	struct alloc_tag *start_tag;
-	struct alloc_tag *end_tag;
-	struct module *val;
-
-	mas_lock(&mas);
-	mas_for_each_rev(&mas, val, 0)
-		if (val == mod)
-			break;
-
-	if (!val) /* module not found */
-		goto out;
-
-	if (!used)
-		goto release_area;
-
-	start_tag = (struct alloc_tag *)(module_tags.start_addr + mas.index);
-	end_tag = (struct alloc_tag *)(module_tags.start_addr + mas.last);
-	if (!clean_unused_counters(start_tag, end_tag)) {
-		struct alloc_tag *tag;
-
-		for (tag = start_tag; tag <= end_tag; tag++) {
-			struct alloc_tag_counters counter;
-
-			if (!tag->counters)
-				continue;
-
-			counter = alloc_tag_read(tag);
-			pr_info("%s:%u module %s func:%s has %llu allocated at module unload\n",
-				tag->ct.filename, tag->ct.lineno, tag->ct.modname,
-				tag->ct.function, counter.bytes);
-		}
-	} else {
-		used = false;
-	}
-release_area:
-	mas_store(&mas, used ? &unloaded_mod : NULL);
-	val = mas_prev_range(&mas, 0);
-	if (val == &prepend_mod)
-		mas_store(&mas, NULL);
-out:
-	mas_unlock(&mas);
-}
-
 static int load_module(struct module *mod, struct codetag *start, struct codetag *stop)
 {
 	/* Allocate module alloc_tag percpu counters */
-- 
2.25.1

