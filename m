Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21CB225A37;
	Fri, 20 Dec 2024 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716865; cv=none; b=TsdBOVGsDKTwOuySRnwcQRjE/UUUyJ+zgKG7Yhdos0j/4byj8c43Pb+/q17BFA77NNEGg0CrY49oQf/z0ZhnTqFOIYY+uaN1KXvnJKzJCXaihHmDQJC1ifpldLknVwzacPQglLq2RpxWgnEhNwDci4kW1mKuipGZL/K9jIK1958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716865; c=relaxed/simple;
	bh=p46Zi8HZh7rK2wim6LSHAw0u6ln86cdHlUXQPiayMx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhDOBu1QAJNNA8RZ5l3Rzqek7so2Yz7WihyPc76PHvigghuCF9mMBJlHB/GydMl58akl5VG/0xYkwQgDp5JWA022INRHgCmB5U/8qNLEBYGeiEM12UBY2hC8L2sisgleR5gLSoI23kWqSygKgwYxQlyElSGjYlXLHl5T//qsaNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o+ROmk5T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5NvTcBPK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o+ROmk5T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5NvTcBPK"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l93Mh1PZlJhbIRISSNiIm8u+tlwexgZoP5TCMyYdWPA=;
	b=o+ROmk5TAuaTgso64Q/7cJgKj0hOCyVciBTWw621y6APXIBVDQpM5bQdoWFMch5XX+y2Qa
	RjN3m1IIWRAvo0Fk730d4hxW+e0FmSnsW+SnYu9zqR34GNUOe6mTkZOJPMH98k/vlQyl53
	eCVKFqm+yr3T0ypGjaxJctv/amiZpmX86OuuYlz+p1L9u6UI1czjnUZD4Q0N6vJbV7L/AS
	SIKHMG5DNBz9E5Yi2A1f+eqwqledI5c3H1oO9TYF4AGf2GOwJRrRI+QY1rVmAiBNWIYvsM
	zZn+/gBEYP2Ql7GYS31LioCHqa7hdURTE3d0eyVjPKkGYr9OQbHlcFVUh2z0Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l93Mh1PZlJhbIRISSNiIm8u+tlwexgZoP5TCMyYdWPA=;
	b=5NvTcBPK+/978UnkmArQeLjGyEbLTqxCdAZPw1+NAuxqfMKRx9Wai6XyAalE26mULikd1X
	AOxnw3HapkjS+aAg==
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
Subject: [PATCH v2 12/28] module: Allow __module_address() to be called from RCU section.
Date: Fri, 20 Dec 2024 18:41:26 +0100
Message-ID: <20241220174731.514432-13-bigeasy@linutronix.de>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
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
2.45.2

