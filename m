Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC751EB9ED;
	Wed,  8 Jan 2025 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327118; cv=none; b=Joqge7SvmnPkIoQ9SFoZBZcjBGzOBKo83CQsvwy670t6veJE895xgxfLgpm1IoNEJik1yQ6kSbX5DULhdYTzZY+Ger/VHfiIaT3hs09gWcw1BrZfYG2BtjBZBay4GI8JGSWwjL2uFLXBkSGudbi/0fl89UlL5v2nJLrfiS6njhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327118; c=relaxed/simple;
	bh=HkaERP1XClK8uXSeXDwlQH7sFdeU3xriW1MEHDK4iSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyuRjp5M42vIP+1EGgQtJntZs43jPfUpZoUW1/di1RFdLGE/ZNwzcJH0IZeuLVzj87xtvIfg9GaY6DP+MiALKYkra4li5ZGVYpqN+GoyY5TzJZIYrLfOtvdRc2J7pE1NnBIzZxbb3edaOV2iI87TD3D8o6QRLB9r6jO5AcQcUNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qx2dCkoF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cbc3JwIn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qx2dCkoF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cbc3JwIn"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHaIm+dVbfH2vg9ZsyIqluwaG6MflVMse3Qcc2GJuB8=;
	b=Qx2dCkoF1ICu2M6YRLp1omVn683yLzzXw81T+gcLfVFyaw9Wwsgz0bt/UpzNLl7aq8EAKr
	ec4z+gyqGHJokOODpE7FWnY6o72EHcaryZ1eNOb4wTLP0128cJqDd/J8A6hHypCR/c86DS
	bHZDF2yQ1iBBiljAj0WSZECFjrnocU9IHMX4q5qzZBOjHKU3FII0No4TPCZKXcJi/e8gXr
	abzMLkzTnbIRZeqY1KgWUamIsU3deUU/rKf9CFVedAabVJ+B0XujmPMRL0Q67heFHB/G3B
	/YzqhFPAfcGGOJZM5jiqUHe0IoUTccM+o4+LYcspT8sxmk+RFkie+938Ir1OqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHaIm+dVbfH2vg9ZsyIqluwaG6MflVMse3Qcc2GJuB8=;
	b=Cbc3JwInX4nieV2P/nXjeFkwcBsDUlEkhhb+cPbcr9NghAC6YKk0Mi72bMLoTHf5EPcIxL
	ox4UETCPAQd7qSDQ==
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
Subject: [PATCH v3 05/28] module: Use RCU in module_get_kallsym().
Date: Wed,  8 Jan 2025 10:04:34 +0100
Message-ID: <20250108090457.512198-6-bigeasy@linutronix.de>
In-Reply-To: <20250108090457.512198-1-bigeasy@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The modules list and module::kallsyms can be accessed under RCU
assumption.

Iterate the modules with RCU protection, use rcu_dereference() to access
the kallsyms pointer.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/module/kallsyms.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 3f59d04795572..4eef518204eb5 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -381,13 +381,13 @@ int module_get_kallsym(unsigned int symnum, unsigned =
long *value, char *type,
 {
 	struct module *mod;
=20
-	preempt_disable();
+	guard(rcu)();
 	list_for_each_entry_rcu(mod, &modules, list) {
 		struct mod_kallsyms *kallsyms;
=20
 		if (mod->state =3D=3D MODULE_STATE_UNFORMED)
 			continue;
-		kallsyms =3D rcu_dereference_sched(mod->kallsyms);
+		kallsyms =3D rcu_dereference(mod->kallsyms);
 		if (symnum < kallsyms->num_symtab) {
 			const Elf_Sym *sym =3D &kallsyms->symtab[symnum];
=20
@@ -396,12 +396,10 @@ int module_get_kallsym(unsigned int symnum, unsigned =
long *value, char *type,
 			strscpy(name, kallsyms_symbol_name(kallsyms, symnum), KSYM_NAME_LEN);
 			strscpy(module_name, mod->name, MODULE_NAME_LEN);
 			*exported =3D is_exported(name, *value, mod);
-			preempt_enable();
 			return 0;
 		}
 		symnum -=3D kallsyms->num_symtab;
 	}
-	preempt_enable();
 	return -ERANGE;
 }
=20
--=20
2.47.1

