Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1881E9B2B;
	Wed,  8 Jan 2025 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327119; cv=none; b=HbuRrXm7MmwCBo9YE3TuyrerOhe15jJO6rSGcQSXSsuYfC8PQH6fjEgd6rV9fCu51s5Z3FLJBE9vTGkO3JJ+3L806faEsdcDFFWnAOjOzpwuzNGKbXHGfT7n+0M7TSqpzKe29K5iGr2gIEt8WtoBYN/XzrYfxMf2+ND4Yetdw+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327119; c=relaxed/simple;
	bh=GtZm9OUff8mdUA7NEazwjLhkXhghK5GN8Su5E/jEgMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtW94Z0ZmQl/TPprHQ15Dy3p6Od8c+7+nNFVpEK4x0DAmUlviOfCCXsEgALsIZtuxbOZBGH2uKKJ7riDPeINcNYHJWif6Tpdh4qqcxGUEmPW/D2MSy/9OEc06qwCWXFTXauKoAXGq3qESFf1N8VpL/GuFezXvo1tIjZU/Wa1alE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wFeVnlqT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IJ0UJYZW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wFeVnlqT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IJ0UJYZW"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IBep5q6+Gwd0en0hg4Rnt4q4GwKIUucRGk1ABlTBQ0U=;
	b=wFeVnlqTo05QQPNvrygBQPKXhgiiulPS40wZLLtBjFjcXumKkpCL8EjX9TLfXJ5RTjcNe0
	su2eawtw4eYbLrUCOeXDNcgCStTkiLOyO2JtJxjs4oeexQiKyvio5Ou/D+PTZ6A5UkY+cw
	BZ4UdnCLXNoJf1lriy/ks+dx7MTh2eKOqKBAGRVGFrX7PY9brWyPAk0TFSja4U/VaYOb77
	hlZRN1BsQjpFfIg0sCMaJps6/GG4yxmd7AKEukMcFRN4XmjUKmrRENcyG7ciuYX5cLTgmv
	pYOc+FIrCnE/hNYcGmhxPCS59Fac638QWPoLgOJ12NQa/QBVM62Kig7RmDDwoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IBep5q6+Gwd0en0hg4Rnt4q4GwKIUucRGk1ABlTBQ0U=;
	b=IJ0UJYZW7l1EQDyZdhP5XPywBVT1Pf65tlkVmztwkn60W9CWUIP+dPvMiBiuYY+X4uQpv3
	ux1KQlX6a0b1ABAg==
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
Subject: [PATCH v3 04/28] module: Use RCU in find_kallsyms_symbol().
Date: Wed,  8 Jan 2025 10:04:33 +0100
Message-ID: <20250108090457.512198-5-bigeasy@linutronix.de>
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

Use rcu_dereference() to reference the kallsyms pointer in
find_kallsyms_symbol().  Use a RCU section instead of preempt_disable in
callers of find_kallsyms_symbol(). Keep the preempt-disable in
module_address_lookup() due to __module_address().

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/module/kallsyms.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 45846ae4042d1..3f59d04795572 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -257,7 +257,7 @@ static const char *find_kallsyms_symbol(struct module *=
mod,
 {
 	unsigned int i, best =3D 0;
 	unsigned long nextval, bestval;
-	struct mod_kallsyms *kallsyms =3D rcu_dereference_sched(mod->kallsyms);
+	struct mod_kallsyms *kallsyms =3D rcu_dereference(mod->kallsyms);
 	struct module_memory *mod_mem;
=20
 	/* At worse, next value is at end of module */
@@ -329,6 +329,7 @@ int module_address_lookup(unsigned long addr,
 	int ret =3D 0;
 	struct module *mod;
=20
+	guard(rcu)();
 	preempt_disable();
 	mod =3D __module_address(addr);
 	if (mod) {
@@ -356,7 +357,7 @@ int lookup_module_symbol_name(unsigned long addr, char =
*symname)
 {
 	struct module *mod;
=20
-	preempt_disable();
+	guard(rcu)();
 	list_for_each_entry_rcu(mod, &modules, list) {
 		if (mod->state =3D=3D MODULE_STATE_UNFORMED)
 			continue;
@@ -368,12 +369,10 @@ int lookup_module_symbol_name(unsigned long addr, cha=
r *symname)
 				goto out;
=20
 			strscpy(symname, sym, KSYM_NAME_LEN);
-			preempt_enable();
 			return 0;
 		}
 	}
 out:
-	preempt_enable();
 	return -ERANGE;
 }
=20
--=20
2.47.1

