Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FC2225798;
	Fri, 20 Dec 2024 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716864; cv=none; b=FefHXyAObHIdPCzlw4IBpBh5d1rh2+wvEok1VnVuJkXMNNc9Ji2sIHSVFpAgg6nqU0BWhF7qyu/9eAaLbYsBfxT3z6mAn6oikCIqsLjQxZNfLOL7FNKWSDAAn8sEJBGcf/Nu6oD6tssd1Ta9Sg4MjHqNQVjZ5lOsMcBDuXKGO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716864; c=relaxed/simple;
	bh=k1ONQSZNQOOKbcdH+TMsaEXVr8iuBZjgNMkNEsJKXVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLqulg5HZNAtPUuWHDecWLlKZltJbZ0wl0zgwNm6ZzasvuQutRd24T9prahUgZn/LPqrsVdYvaFPRclfwgFIVTPNsxylU73bDSU8jvpxb/OVpkddFPQbDUvROGEughY2r4NrBLmkf883cF30sVBXwarQB4ZVRID4pKhNLw0Yg2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=suSwIAkE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=85eG/JOl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="suSwIAkE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="85eG/JOl"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLIPxdv+rgZYNiaIzIjicHG2numdAPy4IIa5FKVKOP4=;
	b=suSwIAkECQLbtC95Gz5w2S2NnFmH9K8BEodyekRWKACAhj1aexIz8040VTCy4dQC8+5ZMZ
	ZXoPb4Fcsk8EDWuhS3YE+wlXmxeoTqS2FyxLHUECrZnqEjAvUNyE9Y4KFw7aVSOMnl5VRt
	xYdypXv5pI7h1pl3sDMrq6LY+lPIaqNjqun90WiHQuaQWt/minuuPES1VVSzHOCOvjldeL
	sCrNGnozb5nuQE44SnfD7fWzqcZ1ummOjg/lzwdxgfRN15fqmouf0cImiXQBEGPc3uM/my
	JnLYMC2K5wDWAx0S3b335P2kWd9bJOr1tFsCzrU7Hpw9HA8u+n5WTXRH7f23Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLIPxdv+rgZYNiaIzIjicHG2numdAPy4IIa5FKVKOP4=;
	b=85eG/JOlus3ZgkIPpRPGgqV3M4y7soc7OMRJq2TQrop6ixfSTta7e6G75RxcwguoAfe2Hc
	M9HzVMzBXujMBFBg==
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
Subject: [PATCH v2 08/28] module: Use RCU in module_kallsyms_on_each_symbol().
Date: Fri, 20 Dec 2024 18:41:22 +0100
Message-ID: <20241220174731.514432-9-bigeasy@linutronix.de>
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
2.45.2

