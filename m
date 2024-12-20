Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D56922837A;
	Fri, 20 Dec 2024 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716868; cv=none; b=h05GDhc0XqL4FFcGcHjeaWesb1azSInzq9i72QEJqgpIGx4KrjbsZxWiRUNultm23BTOjVU3ALi4EhdyCm7F4drKHZjNmjk5Jq9IgXhKYuBuN0BxOpXeqFkYAEzSCgDEClKwEp0STvUxUw+hYrmp37xd5761862/nRN2h3VZTnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716868; c=relaxed/simple;
	bh=uy+vf7E+WfZsLxge9FFBznnF2wQaw/y3udEfK0Dg6s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d17mwF41eeOpAYPh5aDeAxphREzf0hVuV5qfC5G/Cuqx6m5AoDxiQ1mbl1Y3EHPyB8rvQ2++SOZ0CgiigiNWcLzuqjUSEbYK0+AC8K3HsncZizkn+BPA3sIPNMleKXwXk/Lt5iVlSivRNev4fQaHBUu+MRA7otI2uO143NFlTzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dYH09CJf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YdJZcQT5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dYH09CJf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YdJZcQT5"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zadty3eQK5ahsxvh3g//PrCMcOyHeT1X/IulzEQzgzA=;
	b=dYH09CJf8Wms0bX922U37fQ2/ndExBQQmr95yw73FUz7nJSJBjmiUN9CjhyYwqiACxpH/C
	3KHck505E9GWMy6YdXyeRlJ3SSo4UCHI891csitkxagHKvzcMjg2BG8JnTiUWj37n8CBhy
	WjslPXyoNXrlMP7P2ByIGmEVDA+nLmWAqshB5obtS/rpaqidX6DGV/ZGdMUPIgUSWf8got
	hDaCU/F12J5Dc3SY/tc/PGbUPzU5WbNG6udUa/7DtSFe+Xxa2OWd2TFnFwfhM7opOFHXMd
	AOTe08cW0HxFB0hI2VXQOxATbZPJDWjpwfHXrr9N79lVDPb/5WokqZie8PCZOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zadty3eQK5ahsxvh3g//PrCMcOyHeT1X/IulzEQzgzA=;
	b=YdJZcQT5FY/R32LX8UPyCRGuevjhYrBTHTEPgSzKIItAMMBgQnytGaDQxG8ZT2V0+Lq56C
	MYFoOyI18DuckzBg==
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
	"H. Peter Anvin" <hpa@zytor.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	x86@kernel.org
Subject: [PATCH v2 21/28] x86: Use RCU in all users of __module_address().
Date: Fri, 20 Dec 2024 18:41:35 +0100
Message-ID: <20241220174731.514432-22-bigeasy@linutronix.de>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

__module_address() can be invoked within a RCU section, there is no
requirement to have preemption disabled.

Replace the preempt_disable() section around __module_address() with
RCU.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/callthunks.c | 3 +--
 arch/x86/kernel/unwind_orc.c | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 4656474567533..15bcec780881f 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -98,11 +98,10 @@ static inline bool within_module_coretext(void *addr)
 #ifdef CONFIG_MODULES
 	struct module *mod;
=20
-	preempt_disable();
+	guard(rcu)();
 	mod =3D __module_address((unsigned long)addr);
 	if (mod && within_module_core((unsigned long)addr, mod))
 		ret =3D true;
-	preempt_enable();
 #endif
 	return ret;
 }
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index d4705a348a804..977ee75e047c8 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -476,7 +476,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		return false;
=20
 	/* Don't let modules unload while we're reading their ORC data. */
-	preempt_disable();
+	guard(rcu)();
=20
 	/* End-of-stack check for user tasks: */
 	if (state->regs && user_mode(state->regs))
@@ -669,14 +669,12 @@ bool unwind_next_frame(struct unwind_state *state)
 		goto err;
 	}
=20
-	preempt_enable();
 	return true;
=20
 err:
 	state->error =3D true;
=20
 the_end:
-	preempt_enable();
 	state->stack_info.type =3D STACK_TYPE_UNKNOWN;
 	return false;
 }
--=20
2.45.2

