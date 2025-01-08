Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8664E1F8ADE;
	Wed,  8 Jan 2025 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327127; cv=none; b=Q0Oya7k58rogaxur9A4jiObrmassvgAjJ8HdyGVSEHmb15KJEe355dEdQRHJ8Wpn01v2Gwxtawa03Aksm5gVLr3VrXmqLixOCoxHEym2Kzp+y2s8x1EBEvWf+8h+qc4zlLPIG5lrj6Bgd7afGKN9PhGTbPW91MAoL7uJtL1smlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327127; c=relaxed/simple;
	bh=P8cpM73cMdV4X9RLYh8MiEJZf1KAJJ/PkpaW8qvgJ5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vq7642nvcqqlcwl2wxKvbnIqtJvNgGBFYZp9kNptYqcrJdrU54fyLEw99PNbUIEQ+Ire0BIpU4J9T0tqf4iK1uZMACIvoqRYwo7ZnqoEQehYL/tfMZwscKEcFDdzEPWJxvKYN+7DEc7BInqjmwhSMa/cY+p93zZPqvY+Uu44OTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Smh3V6vU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TCMkjn4t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Smh3V6vU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TCMkjn4t"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lprawi1Wy0blHcfKhZWeO6Nu25/xNNrs6hneQ3+r2fM=;
	b=Smh3V6vUWgb2Z4rtmOumtw4pf4+Q8qg1bz9YNY0OiT+E18yri12DCO8BBIxHyHnJpE7v+X
	Di+T3/WzvbjkM2l+qI2eAJa9oZIpTKOnvPpJe8lEYBbgR7IdnNHw3sw9W7K/x7tFxcNViz
	dKCfJo1BSccUD7iBuLEimuoyE3tMnJ89rKhKuPQJur5YnS/3vzXT54RZYqc+hkhqz6uO2Z
	82Z0wJxBip8UNC+8UT1+mi3TeE9Jf4TA8SRVK0ksIemdsPMsVBKMeiPWmxPjTWPZlJlZRI
	SmLl4LeV9/nAOU6FQ4EvRU454tl0oTAZa3k4hWVaVZ+ZIDCSa9m8YB7eB+bOnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lprawi1Wy0blHcfKhZWeO6Nu25/xNNrs6hneQ3+r2fM=;
	b=TCMkjn4tKyPMEXkg2pCiQnC3MTbFdMMSSH7u+iWfE3/HoOmxq+yZeEhfMffFdLoGQYQtX1
	sV/EQOg0G+BujpBA==
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
Subject: [PATCH v3 22/28] x86: Use RCU in all users of __module_address().
Date: Wed,  8 Jan 2025 10:04:51 +0100
Message-ID: <20250108090457.512198-23-bigeasy@linutronix.de>
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

Replace the preempt_disable() section around __module_address() with
RCU.

Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/callthunks.c | 3 +--
 arch/x86/kernel/unwind_orc.c | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index f17d166078823..276b5368ff6b0 100644
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
2.47.1

