Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B60223E8C;
	Fri, 20 Dec 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716863; cv=none; b=KQe0gC9rgBvkB0p3kR9RDGeaZPJCCE4/AJIcoZiAf0ossMjHUW5DLadr66+aAOglbUjMwaga5Gwe7rcBlPjKfDwHl9rxOcceoNYHcjEgJmoWMF3xdYu2ZA2/mKg6tGRgPmvrp237pZvZM5qQfpDthicqmaiHRz3dsGtVqlx6u4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716863; c=relaxed/simple;
	bh=uffhon2stlFtjZNpQSBh5jUuFAMhJe2bHv90BPUz7UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZ3ZIiktdcknsMCM1JR8fEqU3QAyyo2lZFn2jvUhk9ya808CMTqbxA2Q76h272SKzzWM4mMmEWP4KUA83vpbattI2R10jjr7yK6jZXihqnK9VwSf9pSJhlxkqu7/vGfobLmLq6Du5NdrqPrJR6hVDQZSgTIeVtD+V4wzQBSmzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dEu7ODm0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zsz3UG2V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dEu7ODm0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zsz3UG2V"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqxEYbtkExcGhym+IUJ5OSXHEpRmnlTHv1UF2Zfl2oo=;
	b=dEu7ODm0Mx3txgKEZ3uGPQoiHjPsPmEH2gf7cBnx0OtmqPlRJXHGoGmDDyRsJLr1yuZPPA
	+1YykkrOboFGhK8gxUWqWNAZYt1TgE31OC4ia+KCI7d/nCWxTnmrk5QWh2xZRuti0g6jPv
	gku/7x0oBfJbNjrPWCR5o8vVl+BDMs2rXJTBxNWLIPVq3YR845RJvm7EQehhvW6XW4gJlu
	SQWnnCyx3z6MIBaQbBR+3f07azw1kFZiQ2mepEWU2uf62E27dh2u4i7b8gfv+fQTXd0cKk
	HjP/yM8OxNM8AR0V7vxwuzj0B7imP3AKtNOMb10UPKfjFLrckutkJEXAZunZhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqxEYbtkExcGhym+IUJ5OSXHEpRmnlTHv1UF2Zfl2oo=;
	b=zsz3UG2VEpwUikzUEVpPK3PxCHdHUa6RsbjThIv+Y22vrAfTj0rdmIGVBHBtHnQeigM15U
	Fsn9APrdBWGWhKCA==
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
Subject: [PATCH v2 05/28] module: Use RCU in module_get_kallsym().
Date: Fri, 20 Dec 2024 18:41:19 +0100
Message-ID: <20241220174731.514432-6-bigeasy@linutronix.de>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
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
2.45.2

