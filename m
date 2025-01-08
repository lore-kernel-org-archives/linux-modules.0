Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598701F2C50;
	Wed,  8 Jan 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327121; cv=none; b=BvJhrfLnQoYtYYd73gGLOe+G3wHOoXA7v8ydk6a4Mle90xG3lLtMw2oHRBsEYXlzaISBlSUAj/cUB6T+rBKPQ2tUEMLbOYNE622IOg2fEKs6ndKS6QXZKbBdZUD7WDOv73zWJEL2jwJj/YHger4meUHGsSxt64X/Q80m//VAFFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327121; c=relaxed/simple;
	bh=Y8KO8AjL4Wlp00NcVyzY4VrfkvuRnK0pthhJzJeBi5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObXVnZUc7smiWu8bDNbqc9GJaB6/Y4XvxfwTY/4cOJKcJ4Q2NAnzXi9w+PIH0u0qcBxukKykJuICeKtW3jJlUbU/0zTGkutQxJ+LvK1XeGOYblsepI9lf532wxjZM1tMmBFeKNY5C7G2h5qeZAAZox2zc6Yhtgas4mgQhrG10Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dQw546Fe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yELo2Ron; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dQw546Fe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yELo2Ron"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/i2pw6yEUIHHaqk5xMWOKQ4ktctxeUDzPoI+9p2J9E=;
	b=dQw546FemZWA5DZl3GgQ9Z9y7QJ95YI3DW+C5DaF34P0fbpmOq/II42Mf+3LhKCDkHfhFz
	JLmdwpWpZPz9vV76LNDsCf4h6Pv98KZqd9VJ79ALyjqEXoMRDVpL89UvzIj5xR0D6MNPwD
	kInzP969+40qAXeBZC5K1XCDZYEolhxgyXY+EpxZAgB1l0PbdPQBxXd8OQmjdL4faDh0E2
	75Uw/s/X+HXqCaRu3OtRJ7Ju7d7qdnF6ChfjgTCdscziqwAqlDIDi33M+t64cmh81OX4oF
	OBhJxPcPXCwvMLXp9pFQ2QSWAH75nnRSgjoZj+vCHl/QoC79bHoGHndnTRyTCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/i2pw6yEUIHHaqk5xMWOKQ4ktctxeUDzPoI+9p2J9E=;
	b=yELo2RonuTymhIA3uhM5pDJgXzKStGcLZB9ULHCytAJLeu/4p3x50qFT/CNFGNNHTHXpmj
	DyWmRALNfWx+cGAw==
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
Subject: [PATCH v3 07/28] module: Use RCU in __find_kallsyms_symbol_value().
Date: Wed,  8 Jan 2025 10:04:36 +0100
Message-ID: <20250108090457.512198-8-bigeasy@linutronix.de>
In-Reply-To: <20250108090457.512198-1-bigeasy@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

module::kallsyms can be accessed under RCU assumption.

Use rcu_dereference() to access module::kallsyms.
Update callers.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/module/kallsyms.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 3cba9f933b24f..e3c55bc879c11 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -407,7 +407,7 @@ int module_get_kallsym(unsigned int symnum, unsigned lo=
ng *value, char *type,
 static unsigned long __find_kallsyms_symbol_value(struct module *mod, cons=
t char *name)
 {
 	unsigned int i;
-	struct mod_kallsyms *kallsyms =3D rcu_dereference_sched(mod->kallsyms);
+	struct mod_kallsyms *kallsyms =3D rcu_dereference(mod->kallsyms);
=20
 	for (i =3D 0; i < kallsyms->num_symtab; i++) {
 		const Elf_Sym *sym =3D &kallsyms->symtab[i];
@@ -447,24 +447,15 @@ static unsigned long __module_kallsyms_lookup_name(co=
nst char *name)
 /* Look for this name: can be of form module:name. */
 unsigned long module_kallsyms_lookup_name(const char *name)
 {
-	unsigned long ret;
-
 	/* Don't lock: we're in enough trouble already. */
 	guard(rcu)();
-	preempt_disable();
-	ret =3D __module_kallsyms_lookup_name(name);
-	preempt_enable();
-	return ret;
+	return __module_kallsyms_lookup_name(name);
 }
=20
 unsigned long find_kallsyms_symbol_value(struct module *mod, const char *n=
ame)
 {
-	unsigned long ret;
-
-	preempt_disable();
-	ret =3D __find_kallsyms_symbol_value(mod, name);
-	preempt_enable();
-	return ret;
+	guard(rcu)();
+	return __find_kallsyms_symbol_value(mod, name);
 }
=20
 int module_kallsyms_on_each_symbol(const char *modname,
--=20
2.47.1

