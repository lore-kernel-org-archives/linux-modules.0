Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29C91F426E;
	Wed,  8 Jan 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327121; cv=none; b=FRn3nqEijM1Wt3aygc3hNy8wNxHw1cJKXNhV/KWni1Fhj7VNqKbWbNghSF3cviRm+HQRwiQAhUcxNvc6Qq0azkCMD/kZxKfmKHdYcDbl0O22UfkFhEdKu1Ry+iv0LYctqLaG6+jO2eV+AYpZfllJ1bX787OATjKBBOp6d6+bxac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327121; c=relaxed/simple;
	bh=axvyxnWooo75BTWGLQAmaIhNJhO70bD+tkHMIyPTibk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHVFRbaq6rW5Wsey6RpwTR9FujWJHpf4gn2kLAdz1/wqjgj8/5QIflywCJhCgOktm/TYWl7exr9poS3gQQ+KxfSCusOVEC1uQvXpf/e8Oj3l605uTn4Y9Gt5eL2z6ynL8eKapDshcjW0MUse8DlHbLwQRTgfyWZslTcRRk+PDcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l6Vstg6w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jIGs/Hd3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l6Vstg6w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jIGs/Hd3"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71h+qS2tty8Z0drmH+HaOoie0zIG/EW33SGidtl3NOY=;
	b=l6Vstg6wTnoul4HLT4y0awP4b0tbXsHV+yWypjiAlreQ/QNUjbS+Pxuff7eam5HTXr9UG+
	yv9HGOD2UNaSaT8DPcG30gdXM9roaKq8AXVVOso/A5/lsBKDZw0HyuJYo444Qbm8n3JqNf
	nxd5QssopBV/Egvimusx/zYOswEHL4bq9m4msKre6/rOiDQL4G+63VxTnFtDMPSLZh1KQA
	ucJv1l1/5klwBOmvP81Utr4+ypyKHpEYw33vNSc7Bk3uXYCHqFubgzYGEIQCCUka4bPTTg
	AOlX9vpaTmiJCqVi6k/6+1eNvtuloOD6E4HZ9rNU7Kes2XLbWRr+L4yRcSIksg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71h+qS2tty8Z0drmH+HaOoie0zIG/EW33SGidtl3NOY=;
	b=jIGs/Hd3yi8VlbPOb0ijPhLNJNFP8QFisXKRp7RidRarCiy2ykn1jovqfH2ZfK8xnt/4ng
	57elPqhDvvFT55BA==
To: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 12/28] module: Allow __module_address() to be called from RCU section.
Date: Wed,  8 Jan 2025 10:04:41 +0100
Message-ID: <20250108090457.512198-13-bigeasy@linutronix.de>
In-Reply-To: <20250108090457.512198-1-bigeasy@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mod_find() uses either the modules list to find a module or a tree
lookup (CONFIG_MODULES_TREE_LOOKUP). The list and the tree can both be
iterated under RCU assumption (as well as RCU-sched).

Remove module_assert_mutex_or_preempt() from __module_address() and
entirely since __module_address() is the last user.
Update comments.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/module/internal.h | 11 -----------
 kernel/module/main.c     |  4 +---
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index daef2be839022..030d2ed175fa8 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -122,17 +122,6 @@ char *module_next_tag_pair(char *string, unsigned long=
 *secsize);
 #define for_each_modinfo_entry(entry, info, name) \
 	for (entry =3D get_modinfo(info, name); entry; entry =3D get_next_modinfo=
(info, name, entry))
=20
-static inline void module_assert_mutex_or_preempt(void)
-{
-#ifdef CONFIG_LOCKDEP
-	if (unlikely(!debug_locks))
-		return;
-
-	WARN_ON_ONCE(!rcu_read_lock_sched_held() &&
-		     !lockdep_is_held(&module_mutex));
-#endif
-}
-
 static inline unsigned long kernel_symbol_value(const struct kernel_symbol=
 *sym)
 {
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 126f7f05dedf8..686b74c7c17f5 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3667,7 +3667,7 @@ bool is_module_address(unsigned long addr)
  * __module_address() - get the module which contains an address.
  * @addr: the address.
  *
- * Must be called with preempt disabled or module mutex held so that
+ * Must be called within RCU read section or module mutex held so that
  * module doesn't get freed during this.
  */
 struct module *__module_address(unsigned long addr)
@@ -3685,8 +3685,6 @@ struct module *__module_address(unsigned long addr)
 	return NULL;
=20
 lookup:
-	module_assert_mutex_or_preempt();
-
 	mod =3D mod_find(addr, &mod_tree);
 	if (mod) {
 		BUG_ON(!within_module(addr, mod));
--=20
2.47.1

