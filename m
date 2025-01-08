Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E67C1F8EFA;
	Wed,  8 Jan 2025 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327129; cv=none; b=CtqWBtCrwgO0T4teHcSzsTyCpStCWWxQyVkNZLbCvQgW3nliMW/awqMNECDQK1yCMpwKGXtc7EOMV50gnUZ2i+lTftOZlMk7+GQn/+6Bu2dCG8TJu93T5UNTC4qMMu4ISH/umPjq3RU0dK7IQz8ETBoRdI69tvk1cR2HvzqmM8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327129; c=relaxed/simple;
	bh=iKbdR1j0aT1R0yqWNU9KhIuS/PlEZVL2OGX+RnZA0c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tk2ONIpjdPK4DE4thZnTxbbfJ6QQwZl754nSAq14YNvGw1W25E6/esngjQdMOmyaeZiXaSuWWYchXNhp/u8Mw2ExXuU//y8VD9V/injEOopRASFMuqrMK7HxHTaOmP/xit4Cqix2MkaY0F09UvH8Y6U7089Y6Ja0d4IPjEsrBLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GQWXV0J6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O3OxtACM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQWXV0J6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O3OxtACM"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6DHZsBE2j+R28AiO1hj+mYuIqcl/xch2HSM3caLWC0A=;
	b=GQWXV0J6l05koDcl1JxGmNYe0jpNk5jswVeHUbna3hBBAlLaa+XqPI6KcElYHAnDdnAwEh
	p99l5nYzob3nsAciL/di46L7pJJxzs1akBf5NyK0K+IZOv6Qzb26nSSb1OXXcZAlwXWR0q
	Nabq4gKwgHlzWAoXZamE0RuEIhZgHeE4uU/vU4J6GbGTrVJthvAPqcJDuWdqZ56QQSmVGF
	AUU+78nhkg87W8t0/42UxVVMH644XsJZr8wuQ2BupgtIlpDEJ3deeBM2M3uLLojw40G+PX
	bscUr6ciY7wH3YS+Lk+QWditFk27817EqBFCKZFANo4omYQVYLqre1CNz/H3Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6DHZsBE2j+R28AiO1hj+mYuIqcl/xch2HSM3caLWC0A=;
	b=O3OxtACMlaGcqbdSTLxi90qIr9EB39NUIgOmqjCGHTRioyVg8lJRlhn/rs2FQMpnDDo336
	Osxz7tT8Dor1cjBw==
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
Subject: [PATCH v3 24/28] jump_label: Use RCU in all users of __module_text_address().
Date: Wed,  8 Jan 2025 10:04:53 +0100
Message-ID: <20250108090457.512198-25-bigeasy@linutronix.de>
In-Reply-To: <20250108090457.512198-1-bigeasy@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

__module_text_address() can be invoked within a RCU section, there is no
requirement to have preemption disabled.

Replace the preempt_disable() section around __module_text_address()
with RCU.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/jump_label.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 7fcf4017cb383..7cb19e6014266 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -653,13 +653,12 @@ static int __jump_label_mod_text_reserved(void *start=
, void *end)
 	struct module *mod;
 	int ret;
=20
-	preempt_disable();
-	mod =3D __module_text_address((unsigned long)start);
-	WARN_ON_ONCE(__module_text_address((unsigned long)end) !=3D mod);
-	if (!try_module_get(mod))
-		mod =3D NULL;
-	preempt_enable();
-
+	scoped_guard(rcu) {
+		mod =3D __module_text_address((unsigned long)start);
+		WARN_ON_ONCE(__module_text_address((unsigned long)end) !=3D mod);
+		if (!try_module_get(mod))
+			mod =3D NULL;
+	}
 	if (!mod)
 		return 0;
=20
--=20
2.47.1

