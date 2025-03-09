Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C640849
	for <linux-modules@vger.kernel.org>; Sun,  9 Mar 2025 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741524649; cv=none; b=bVBOXvBwv6AblJDZHK1uBrPKB3qIc7spO6eotaSJavjoXPN4HDZY3pgZgsKIJKkfdFlHNIPHHeZT9qgzR+4vdVBIGqiGIurj2w/LRia3i7rI8gJVNWwhigGwBIWdemPklxdFNScJT+VLgGCbwws2Rts+ol3J0bz8/HbMTn6HPOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741524649; c=relaxed/simple;
	bh=blKk/KSWFB4rl72tKoW/sZYmx+Lfvs13aWcJDCcxEuo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WLfbJLNsKX1MRJ4z4SuqrY2M3pkrb44QpFvHGu3MoWlF40KVTI6kme7O7UbU4y7bH1R7CsqhiLW1dhyB0+7YXp/P1NJ+GkYGssvewg/mWqSJCfoUL18CsKcdK1Yf+r4o2gSrpCE28fqWJoesvsxXRNhNZlOxUHtap0s3zD7uF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <sebastian@breakpoint.cc>)
	id 1trFcg-0003gd-E0; Sun, 09 Mar 2025 13:19:14 +0100
Date: Sun, 9 Mar 2025 13:19:14 +0100
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linux-modules@vger.kernel.org
Cc: Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH] module: Use rcuref_t for module::refcnt.
Message-ID: <20250309121914.pN6eBMvI@breakpoint.cc>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

By using rcuref_t the atomic_inc_not_zero() and atomic_dec_if_positive()
can disappear. By design rcuref_t does not allow decrementing past the
"0" reference and increment once it has been released. It will spill
warnings if there are more puts than initial gets.
This also makes the put/ get attempt in try_release_module_ref() a
little simpler. Should the get in try_release_module_ref() fail then
there should be another warning originating from module_put() which is
the only race I can imagine.

Use rcuref_t for module::refcnt.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 include/linux/module.h        |  2 +-
 include/trace/events/module.h |  2 +-
 kernel/module/main.c          | 51 ++++++++++++++++++-----------------
 3 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index d9a5183a9fe71..b473a329f1927 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -581,7 +581,7 @@ struct module {
 	/* Destruction function. */
 	void (*exit)(void);
 
-	atomic_t refcnt;
+	rcuref_t refcnt;
 #endif
 
 #ifdef CONFIG_CONSTRUCTORS
diff --git a/include/trace/events/module.h b/include/trace/events/module.h
index e5a006be9dc66..cdb88bb4bc24a 100644
--- a/include/trace/events/module.h
+++ b/include/trace/events/module.h
@@ -81,7 +81,7 @@ DECLARE_EVENT_CLASS(module_refcnt,
 
 	TP_fast_assign(
 		__entry->ip	= ip;
-		__entry->refcnt	= atomic_read(&mod->refcnt);
+		__entry->refcnt	= rcuref_read(&mod->refcnt);
 		__assign_str(name);
 	),
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 3dbe230984336..15b26e1431f59 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -570,17 +570,15 @@ EXPORT_TRACEPOINT_SYMBOL(module_get);
 /* Init the unload section of the module. */
 static int module_unload_init(struct module *mod)
 {
-	/*
-	 * Initialize reference counter to MODULE_REF_BASE.
-	 * refcnt == 0 means module is going.
-	 */
-	atomic_set(&mod->refcnt, MODULE_REF_BASE);
-
 	INIT_LIST_HEAD(&mod->source_list);
 	INIT_LIST_HEAD(&mod->target_list);
 
-	/* Hold reference count during initialization. */
-	atomic_inc(&mod->refcnt);
+	/*
+	 * Initialize reference counter to MODULE_REF_BASE.
+	 * refcnt == 0 means module is going.
+	 * Hold reference count during initialization.
+	 */
+	rcuref_init(&mod->refcnt, MODULE_REF_BASE + 1);
 
 	return 0;
 }
@@ -674,25 +672,33 @@ static inline int try_force_unload(unsigned int flags)
 }
 #endif /* CONFIG_MODULE_FORCE_UNLOAD */
 
-/* Try to release refcount of module, 0 means success. */
-static int try_release_module_ref(struct module *mod)
+/* Try to release the initial reference of module, true means success. */
+static bool try_release_module_ref(struct module *mod)
 {
-	int ret;
+	bool ret;
 
 	/* Try to decrement refcnt which we set at loading */
-	ret = atomic_sub_return(MODULE_REF_BASE, &mod->refcnt);
-	BUG_ON(ret < 0);
+	ret = rcuref_put(&mod->refcnt);
 	if (ret)
-		/* Someone can put this right now, recover with checking */
-		ret = atomic_add_unless(&mod->refcnt, MODULE_REF_BASE, 0);
+		/* Last reference put, module can go */
+		return true;
 
-	return ret;
+	ret = rcuref_get(&mod->refcnt);
+	if (!ret)
+		/*
+		 * Last put failed but can't acquire a reference. This means
+		 * the previous owner has put the reference.
+		 */
+		return true;
+
+	/* There is still a reference on the module */
+	return false;
 }
 
 static int try_stop_module(struct module *mod, int flags, int *forced)
 {
 	/* If it's not unused, quit unless we're forcing. */
-	if (try_release_module_ref(mod) != 0) {
+	if (try_release_module_ref(mod) != true) {
 		*forced = try_force_unload(flags);
 		if (!(*forced))
 			return -EWOULDBLOCK;
@@ -714,7 +720,7 @@ static int try_stop_module(struct module *mod, int flags, int *forced)
  */
 int module_refcount(struct module *mod)
 {
-	return atomic_read(&mod->refcnt) - MODULE_REF_BASE;
+	return rcuref_read(&mod->refcnt) - MODULE_REF_BASE;
 }
 EXPORT_SYMBOL(module_refcount);
 
@@ -844,7 +850,7 @@ static const struct module_attribute modinfo_refcnt =
 void __module_get(struct module *module)
 {
 	if (module) {
-		atomic_inc(&module->refcnt);
+		WARN_ON(!rcuref_get(&module->refcnt));
 		trace_module_get(module, _RET_IP_);
 	}
 }
@@ -857,7 +863,7 @@ bool try_module_get(struct module *module)
 	if (module) {
 		/* Note: here, we can fail to get a reference */
 		if (likely(module_is_live(module) &&
-			   atomic_inc_not_zero(&module->refcnt) != 0))
+			   rcuref_get(&module->refcnt)))
 			trace_module_get(module, _RET_IP_);
 		else
 			ret = false;
@@ -868,11 +874,8 @@ EXPORT_SYMBOL(try_module_get);
 
 void module_put(struct module *module)
 {
-	int ret;
-
 	if (module) {
-		ret = atomic_dec_if_positive(&module->refcnt);
-		WARN_ON(ret < 0);	/* Failed to put refcount */
+		WARN_ON(rcuref_put(&module->refcnt));
 		trace_module_put(module, _RET_IP_);
 	}
 }
-- 
2.47.2

