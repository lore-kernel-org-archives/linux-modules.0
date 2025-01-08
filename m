Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38B01F427A;
	Wed,  8 Jan 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327122; cv=none; b=hmsMiHAa6uXmpd85JCIgHJhrnN0xR13fDoThOsoYpICFtpfkH9SJnGdvhPmF+Zvw+iZo5Qjj/WobHOA+k8ckFFtqX2dYUz5KYo8ImkimrURY2ONHT+oeJVbkdYmgPQ1kndghEu9O4Tu6sO4PgUcaVCV9d3Gcsy9qC2g6pStrpCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327122; c=relaxed/simple;
	bh=4qjk4ZgYgYdcxmkh6VNIf6ytI19yT8vGBa1ibzSe1MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BidQGwwNNWQ6D2L2DAPPz//qtRf2QsYqw/DWVvg8e0QnM8WViRhOWvrdghlNiNMRGtQnaO8KFSLrKRK9A2tdGvtxp7HqISPUEyfJxxYz6Xmyluy22BCCfUVJmTP1T5dQWa0DopgjRv+6FDMIbtM9vc68uLcWQCklX93o9257KD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c2P2D9eS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7o7UMwa2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c2P2D9eS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7o7UMwa2"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeRBwot1ZOna4cw61E4j7JYR+wcb0jWq9QvmlD1DT/0=;
	b=c2P2D9eSh4XHo2/Blrmx/hYuzX2oqNMwhAse4kcS895ethl2GkmDlBGqOCU4Tibyb+94oC
	cS0EZOvclEU832SmZR0w00BVA4IFLqmnQia47ZsjYPa+Bya97m8b+NCpoAN/b8LghduC5V
	/aGK4ict8yPZ+xe0lLPH23HxbIenAtafWiuguOJpw143QWK//BOgqVXUmfRZLx3Pp6Dyl4
	ru8UuXp26Ae06H6z0ENF/ITy3m5C0BcX3Risa2XPJSdfnpPnu5KZgSElfHIMpKoFPaRFOR
	Dw/X19vjyf7O84n1ODSXUJhMc70bUToLZxhE39cYuLkPTQCIxUKQg9wlbBZw8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeRBwot1ZOna4cw61E4j7JYR+wcb0jWq9QvmlD1DT/0=;
	b=7o7UMwa2KRtBbBqfWNQiapLOAixcH6GT8QOILrmP52Dm1bFGOU6/Fgo5AZwrmOfIbIBwoa
	ikm+YjGPUrlTyFDA==
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
Subject: [PATCH v3 10/28] module: Use RCU in find_symbol().
Date: Wed,  8 Jan 2025 10:04:39 +0100
Message-ID: <20250108090457.512198-11-bigeasy@linutronix.de>
In-Reply-To: <20250108090457.512198-1-bigeasy@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
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

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
2.47.1

