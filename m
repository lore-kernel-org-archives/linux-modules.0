Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E101F3D3E;
	Wed,  8 Jan 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327122; cv=none; b=RrRv0d8t/5guUQqyWXWZZHgQDrixnRZiEVG4kxkp8h6/QzBDSH+g4ztqc2952M1Q4XV2O/HZldUyFKnD65cN5NIbDXT/Ab6t3xut45Mh4hvMIbUqLxMMR5VdZbwor4BR2kCBlDkQ22SGAKHWetUr1KsU1To0x5W0OjDQrGOXEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327122; c=relaxed/simple;
	bh=/4aSMjCGaTwkJHHFm5YLWbwzZmQ4wgL8t+6KjrZ2sxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ci4qGH+m5lkMX7LC/4j5HmHT0ZCcH1jJc7auQDbTSBXdKmbBKheaFa/BpfnDK9y/YIC70OHEqjWQSTeg7f/jDiVW/1qKF40XouLhAoj8egUk+DvjOWfHohRIXznFhw6KUGAEOyacsNUOD8n+sn3jI47YZWzAD+BTpSQiEvzGuSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FRRGTIZB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bMuIZux3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FRRGTIZB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bMuIZux3"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLNy3Nm0g98q8kMW8Wxa6YyKbP0OEU3KFHzMhwk5Nkk=;
	b=FRRGTIZBu4vIjG96079PLl1DfqRCE4j3zSwLZmQZuU+PQ2DfX+3178aRJYAfgOjj+EfDV2
	gsc+dlWfEkm6x7Y5/GhMKYbHl7b+CJk1SD+YA9GwDp17aZQU1bEbKcNsZVWp7IAMjLmoYM
	tKrUwOzIvUrS3CjlbUNPhbEPE0OSI8uLEhe6P/kOV6xe37Mejn/npM1zqVHvPPCnd0TXM2
	va6i4aLlVP5TuvtycGVdWlKfFAz7ho1T6Uhh1n9aIdn5H9kUL3dvzrpttsupZDPdNzwCrh
	Alt7k3si3OdxYAMJpkVWn+uPHA9aqkXy5REBEO1RcTlaJUgPUGTprKGS9x00PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLNy3Nm0g98q8kMW8Wxa6YyKbP0OEU3KFHzMhwk5Nkk=;
	b=bMuIZux3nCGrrDuKu4+dG6tITI0R2AQjEetDLBXlzGdvRJVu2K5xPsCisVP9lhLt+kaIyj
	hSwbLLI+Hqo/bvAA==
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
Subject: [PATCH v3 08/28] module: Use RCU in module_kallsyms_on_each_symbol().
Date: Wed,  8 Jan 2025 10:04:37 +0100
Message-ID: <20250108090457.512198-9-bigeasy@linutronix.de>
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
 kernel/module/kallsyms.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index e3c55bc879c11..0e8ec6486d95c 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -476,10 +476,8 @@ int module_kallsyms_on_each_symbol(const char *modname,
 		if (modname && strcmp(modname, mod->name))
 			continue;
=20
-		/* Use rcu_dereference_sched() to remain compliant with the sparse tool =
*/
-		preempt_disable();
-		kallsyms =3D rcu_dereference_sched(mod->kallsyms);
-		preempt_enable();
+		kallsyms =3D rcu_dereference_check(mod->kallsyms,
+						 lockdep_is_held(&module_mutex));
=20
 		for (i =3D 0; i < kallsyms->num_symtab; i++) {
 			const Elf_Sym *sym =3D &kallsyms->symtab[i];
--=20
2.47.1

