Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0D225A22;
	Fri, 20 Dec 2024 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716864; cv=none; b=qp8AKaO/jiEGdhKC9kqjDdwuF5phra6C0zk5PEEInYqXIDZaqLUtYceDLN681Dzk1NRVjdd8y4yfSb1UpQeaRg+96IyQ+vEhudfNXrfZV9y3ZZHGQWQGJDTlbO7BZi/Kxc6HFQkXV+fNAPmQjkmw2FTLpkigMTl9uOly9j/0yV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716864; c=relaxed/simple;
	bh=qeik2/OfYfJZuKgOeRr+DQMcj6bOyAd3+P5c3QdhHuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZMc33Zvhl1LZy7KzFl3FeF+Ofp+YU4VIBD9HU39q56ncB+AWf28iSoZl8O5bk9RdKfnUNtJihu+wputlPdCBkKx2fEENbWrokfQwQNeaUgbgJmexFtrDuGwl+nA+xv2twiGZ7R8nL9m5X4Jel3ufgA0lnMGi7uAXE//2lDPEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hW+aGK/j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sHVSrCpT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hW+aGK/j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sHVSrCpT"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8J/JiS2ZAzuxxgQolNqGisl2jwm8es42jWGQ03W873A=;
	b=hW+aGK/jvnKx7dPIhQwuWNZCJBbmvun8c8t0afkLJM57AAEf7HIHqHKjKBfC/w4HaeaXfC
	BCsLINXQiU6LyZMR17v3hhGUnqHEUGYTZXBPJ6GoJd2PQ6LywLCKx/78R5w2rdUAXpnoH7
	VptiXv3puospzFek8o6PWCQa2B2ChMpVn6+Ljdb5QYr2Z6pOmZ2uEaV+8JJscwx9uDbFoa
	PvywDDwnz8dT8HuDab2C0KPKP48JXGKjYXllj/yv7VIqtRpb2vja3F8oT7xUdrkANkqJOV
	6KAh39juQWFc5Yk+DDz0AM7WwOPnK+miDWDPhVJSKjsH9IxNuvB3/GAIJuQ50A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8J/JiS2ZAzuxxgQolNqGisl2jwm8es42jWGQ03W873A=;
	b=sHVSrCpTDH+jfOhgIHJxb/MRDa6KbtZMi+TygTQz+0jFGsCpyp6uGsGAQlPwRgKFYJ/Mwj
	nmnt29BJU8QNlWCw==
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
Subject: [PATCH v2 10/28] module: Use RCU in find_symbol().
Date: Fri, 20 Dec 2024 18:41:24 +0100
Message-ID: <20241220174731.514432-11-bigeasy@linutronix.de>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

module_assert_mutex_or_preempt() is not needed in find_symbol(). The
function checks for RCU-sched or the module_mutex to be acquired. The
list_for_each_entry_rcu() below does the same check.

Remove module_assert_mutex_or_preempt() from try_add_tainted_module().
Use RCU protection to invoke find_symbol() and update callers.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/module/main.c    | 30 ++++++++++++------------------
 kernel/module/version.c | 14 +++++++-------
 2 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5aa56ec8e203e..71e73deed76c0 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -331,7 +331,7 @@ static bool find_exported_symbol_in_section(const struc=
t symsearch *syms,
=20
 /*
  * Find an exported symbol and return it, along with, (optional) crc and
- * (optional) module which owns it.  Needs preempt disabled or module_mute=
x.
+ * (optional) module which owns it. Needs RCU or module_mutex.
  */
 bool find_symbol(struct find_symbol_arg *fsa)
 {
@@ -345,8 +345,6 @@ bool find_symbol(struct find_symbol_arg *fsa)
 	struct module *mod;
 	unsigned int i;
=20
-	module_assert_mutex_or_preempt();
-
 	for (i =3D 0; i < ARRAY_SIZE(arr); i++)
 		if (find_exported_symbol_in_section(&arr[i], NULL, fsa))
 			return true;
@@ -812,10 +810,9 @@ void __symbol_put(const char *symbol)
 		.gplok	=3D true,
 	};
=20
-	preempt_disable();
+	guard(rcu)();
 	BUG_ON(!find_symbol(&fsa));
 	module_put(fsa.owner);
-	preempt_enable();
 }
 EXPORT_SYMBOL(__symbol_put);
=20
@@ -1369,21 +1366,18 @@ void *__symbol_get(const char *symbol)
 		.warn	=3D true,
 	};
=20
-	preempt_disable();
-	if (!find_symbol(&fsa))
-		goto fail;
-	if (fsa.license !=3D GPL_ONLY) {
-		pr_warn("failing symbol_get of non-GPLONLY symbol %s.\n",
-			symbol);
-		goto fail;
+	scoped_guard(rcu) {
+		if (!find_symbol(&fsa))
+			return NULL;
+		if (fsa.license !=3D GPL_ONLY) {
+			pr_warn("failing symbol_get of non-GPLONLY symbol %s.\n",
+				symbol);
+			return NULL;
+		}
+		if (strong_try_module_get(fsa.owner))
+			return NULL;
 	}
-	if (strong_try_module_get(fsa.owner))
-		goto fail;
-	preempt_enable();
 	return (void *)kernel_symbol_value(fsa.sym);
-fail:
-	preempt_enable();
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
=20
diff --git a/kernel/module/version.c b/kernel/module/version.c
index 53f43ac5a73e9..65ef8f2a821da 100644
--- a/kernel/module/version.c
+++ b/kernel/module/version.c
@@ -62,17 +62,17 @@ int check_modstruct_version(const struct load_info *inf=
o,
 		.name	=3D "module_layout",
 		.gplok	=3D true,
 	};
+	bool have_symbol;
=20
 	/*
 	 * Since this should be found in kernel (which can't be removed), no
-	 * locking is necessary -- use preempt_disable() to placate lockdep.
+	 * locking is necessary. Regardless use a RCU read section to keep
+	 * lockdep happy.
 	 */
-	preempt_disable();
-	if (!find_symbol(&fsa)) {
-		preempt_enable();
-		BUG();
-	}
-	preempt_enable();
+	scoped_guard(rcu)
+		have_symbol =3D find_symbol(&fsa);
+	BUG_ON(!have_symbol);
+
 	return check_version(info, "module_layout", mod, fsa.crc);
 }
=20
--=20
2.45.2

