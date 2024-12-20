Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6C22915F;
	Fri, 20 Dec 2024 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716871; cv=none; b=XeiYB3PRRlC7dnrkma3HhdioXdq+dHug6AlsKugn9gjl6s34kqu5mIUuhDBuWcGc8JQ1hDaWVSYdBOCSPlQ9AKQIJM1zMnMKrehGfxUhxktoOg83RLoW/VOISOci125RwDfTn3yFD4y0EtOTdz9p/a9M1hyQ82cAg4gWINybQko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716871; c=relaxed/simple;
	bh=RXxizPVXirBfVfQbgsJ3kSHvA7FoXQLVDWdkWj59TPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjnJ161IXzGENVd7d77rr99Uxw59rDkk2xIES5s0QWBSM8pcauU+tpOW+fJqcm6nENGa637TFdfBEbd8W8kt8XPz/C2TpGZ2FmyqdqUV5Kp+3d1XfqGtx9W4fwwCMs+itGKtqoef4J691YeD2ZjdQSxao+vJsmUvL0++h/WD/0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E4Tm8ah9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JZvdk6Xk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E4Tm8ah9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JZvdk6Xk"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pRK0w0tqhurswwZaNufUaRKsGvAocCKzSLzr6eB0tBg=;
	b=E4Tm8ah9OC2LBwwBB4oSR/ST/BDvArTaReTdwUxjz+fC82d4enrwL38sZa153iGMwMYm6H
	DtS/hp0x5+nrLycPQn40kqx3KwCmdSZDbGeuDEcaW/+oddxCol70P0JrfhAKbanhnYhVPS
	cTyBxpueATZ5iP85MmcP0uL21XpC9m8ES1MFgJi7+bQP9kZprVXx/aL6lsK9Q8kfUUtqsi
	RoXhdKHc9ncR+VnzlcMhSXNYx+yEisRsXAMNG/wZoi+vp2cy38ZDSFNQpcw35gV7CZPib4
	3WVCh70heYfB5gbUPNdgfpiZtt8Y98FBKk/65SnEaL8FH08gkE00JhHukbzczA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pRK0w0tqhurswwZaNufUaRKsGvAocCKzSLzr6eB0tBg=;
	b=JZvdk6XkJ3G2R3/NWfo3BXLpAVNxdlwod7c9d6PG98RN0SuBqNuwRh9acZfbB92qtF4gqv
	ub0qzWrpnMxjwNAQ==
To: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 27/28] bug: Use RCU instead RCU-sched to protect module_bug_list.
Date: Fri, 20 Dec 2024 18:41:41 +0100
Message-ID: <20241220174731.514432-28-bigeasy@linutronix.de>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The list module_bug_list relies on module_mutex for writer
synchronisation. The list is already RCU style.
The list removal is synchronized with modules' synchronize_rcu() in
free_module().

Use RCU read lock protection instead of RCU-sched.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/bug.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/lib/bug.c b/lib/bug.c
index e0ff219899902..b1f07459c2ee3 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -66,23 +66,19 @@ static LIST_HEAD(module_bug_list);
=20
 static struct bug_entry *module_find_bug(unsigned long bugaddr)
 {
+	struct bug_entry *bug;
 	struct module *mod;
-	struct bug_entry *bug =3D NULL;
=20
-	rcu_read_lock_sched();
+	guard(rcu)();
 	list_for_each_entry_rcu(mod, &module_bug_list, bug_list) {
 		unsigned i;
=20
 		bug =3D mod->bug_table;
 		for (i =3D 0; i < mod->num_bugs; ++i, ++bug)
 			if (bugaddr =3D=3D bug_addr(bug))
-				goto out;
+				return bug;
 	}
-	bug =3D NULL;
-out:
-	rcu_read_unlock_sched();
-
-	return bug;
+	return NULL;
 }
=20
 void module_bug_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
@@ -235,11 +231,11 @@ void generic_bug_clear_once(void)
 #ifdef CONFIG_MODULES
 	struct module *mod;
=20
-	rcu_read_lock_sched();
-	list_for_each_entry_rcu(mod, &module_bug_list, bug_list)
-		clear_once_table(mod->bug_table,
-				 mod->bug_table + mod->num_bugs);
-	rcu_read_unlock_sched();
+	scoped_guard(rcu) {
+		list_for_each_entry_rcu(mod, &module_bug_list, bug_list)
+			clear_once_table(mod->bug_table,
+					 mod->bug_table + mod->num_bugs);
+	}
 #endif
=20
 	clear_once_table(__start___bug_table, __stop___bug_table);
--=20
2.45.2

