Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C084C225A23;
	Fri, 20 Dec 2024 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716865; cv=none; b=ullcMJudfBOzphkCZA/UK6XbOz0TTU3XULjFjF5aOXP/jup7G/by0EF3xrXYG/e2bKQTD/xzE0bjhMVjzXv6p8lB0xjLvUK/GxOT8kX5X6f1hbabRmTCF75kEvg9IncXLeksNqz019PfMQtKnK8LWkXu/tR0R0CYvuDVoBnRaG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716865; c=relaxed/simple;
	bh=XeX9Wfr/ate0+cmWN4pQDA5SZgUW3jGRJaYXMkHeWio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zlr5geUMDhONo9XTUYYNqRTIH/aoEqsxA9uAIsITr/TByaUABdacj+qIlsiXGuVfRF7A9hLn02IDBIIwdkYU91CByye+Nu2CkFvuR71hkk/QodBVyaVrqgNIeppftKld+oHRI9LzQq8q/bx88t4AjWFCkcwjyJg5bF3nu8w66Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NDgm5Pz8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dn+69Yco; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NDgm5Pz8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dn+69Yco"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqVQDyEYACd6Buc8karGtHVOgbp3vA8Z1uEZRkvpdV8=;
	b=NDgm5Pz8jcpfVzjsGvRFFOtKI3kmtbLqbOMuszc5W3Q2PErvUqQ/Wh8TICFzD2lP1Uhqqc
	qaTqhxNuIek97XnwB46dBEccInMpJ7GeSJ+7UAjO7dF76niXqnVYVbgP+gNv6WwFF4X5nY
	1LUyQe6KRewZ9D7sEqjlQ47txkWyl7y6DICtQ+8WrRn8xp1nWgd0KtphtiorZPn+pCAmGL
	FFKDOS0hIDV3QPiEDtFX16O/hvSUZ6Y2c3G+Cs82AcwR3r3RzaJLUjrVB6x3wHYirl4Sx9
	fX2ld3vLHq7vDOlcVijYrVV/UrfkT3P1WYIZJAZ/+bDXvsH5pw7kbr7jTEl3eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqVQDyEYACd6Buc8karGtHVOgbp3vA8Z1uEZRkvpdV8=;
	b=Dn+69Yco3oJO/j3hc7IxM2yhf1qEoaCjQl9ydL+nYFwj+9b9H2YgtSVbkIsFS77baZuJVS
	j+Cab1xrBbsDkSAQ==
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
Subject: [PATCH v2 07/28] module: Use RCU in __find_kallsyms_symbol_value().
Date: Fri, 20 Dec 2024 18:41:21 +0100
Message-ID: <20241220174731.514432-8-bigeasy@linutronix.de>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
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
2.45.2

