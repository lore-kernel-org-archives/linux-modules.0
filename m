Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C51F8AE6;
	Wed,  8 Jan 2025 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327127; cv=none; b=temFjwtBaO9qA9Bh3KCguEi3E0OAQ67l3Kw98ERaBT8RhJhmyXbxQirBCai+MSnVjfA3AAud8rL1yGC4+grETbEzlPaYFI5AEPW802nFru1f8ip8x1ALFAJNENdKSNEcjJ+PWesYtHUrlrl5KbhTNDAfTbEk3F9YpXo+5ipJ1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327127; c=relaxed/simple;
	bh=dnHZYtRQRqUncQkV4yyJr8LboGs1uhLkzkoM41kcf0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbsMDfLwtaxqmL9YBc9s2OAnYaYqTDGzoOiGmj7vwNqmCAoN22TmA1R7u95q8Rzl+MTaDI+vavBsZWc5lBJEg/ycjQFDmu1WThrCPh58M7A2Uh4Vtr8C1rejTaLJ3Kgui9iuzyEQ3m321qaiQ1cBrI0QPwQM0mw2BCgnsmwGtrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KEX+o1uS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kNF4ExyG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KEX+o1uS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kNF4ExyG"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hfagbwpj3df9q7ePOIyVBofNwKk4yX9AX2H1Tk2ZCkc=;
	b=KEX+o1uSt4ezKkiXlbcixjyMcaXTOpYuLKGxDN98o0SAs1N+ARvBDeILqSXQUEKvwExik/
	/KCrHsVYKJV3GmxhPrduLM0WBFY54PNWPzCGD8Fp+0BHO3Cmkp+jFLvqi0vfzu8qvXj6it
	Ju4cnNC/Iim0sGfzVJOy/U8DaD2ryM/KiKwWOKdHY4hHGO9BcT7PWXiQF05RxLTt8UNeMc
	uPfXdCKiZukWbi0Y3DqytAlzE8SsMLldTOcvuybJyYJnWpZgDV062bwE2/aDM2PpAAaA64
	mGqQ63F2hzit/ejryZ6h8mkvp13xpvwuoezi8fkgNAc6ve5HjVcig9i+cnhhUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hfagbwpj3df9q7ePOIyVBofNwKk4yX9AX2H1Tk2ZCkc=;
	b=kNF4ExyGCnG/OhL7DX/Q6MpdEqr370zPqck+Xth++7nVaGZ+I9vRJrZDYPGIP8jcHhYdRH
	a1YNiqpuT4uzzZBw==
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
	Ard Biesheuvel <ardb@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v3 23/28] jump_label: Use RCU in all users of __module_address().
Date: Wed,  8 Jan 2025 10:04:52 +0100
Message-ID: <20250108090457.512198-24-bigeasy@linutronix.de>
In-Reply-To: <20250108090457.512198-1-bigeasy@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

__module_address() can be invoked within a RCU section, there is no
requirement to have preemption disabled.

Replace the preempt_disable() section around __module_address() with RCU.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/jump_label.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 93a822d3c468c..7fcf4017cb383 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -746,9 +746,9 @@ static int jump_label_add_module(struct module *mod)
 				kfree(jlm);
 				return -ENOMEM;
 			}
-			preempt_disable();
-			jlm2->mod =3D __module_address((unsigned long)key);
-			preempt_enable();
+			scoped_guard(rcu)
+				jlm2->mod =3D __module_address((unsigned long)key);
+
 			jlm2->entries =3D static_key_entries(key);
 			jlm2->next =3D NULL;
 			static_key_set_mod(key, jlm2);
@@ -906,13 +906,13 @@ static void jump_label_update(struct static_key *key)
 		return;
 	}
=20
-	preempt_disable();
-	mod =3D __module_address((unsigned long)key);
-	if (mod) {
-		stop =3D mod->jump_entries + mod->num_jump_entries;
-		init =3D mod->state =3D=3D MODULE_STATE_COMING;
+	scoped_guard(rcu) {
+		mod =3D __module_address((unsigned long)key);
+		if (mod) {
+			stop =3D mod->jump_entries + mod->num_jump_entries;
+			init =3D mod->state =3D=3D MODULE_STATE_COMING;
+		}
 	}
-	preempt_enable();
 #endif
 	entry =3D static_key_entries(key);
 	/* if there are no users, entry can be NULL */
--=20
2.47.1

