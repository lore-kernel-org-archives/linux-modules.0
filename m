Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7AF1F76D8;
	Wed,  8 Jan 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327124; cv=none; b=ZQLA9i0hm45B4RQE4rwGn/JKiydALALxVVJb/GFYwhBXLHsfeDQbzDNXRBSJjdMXOr2V2uh2RJs1B4mDnlwAgB9OmMfrAwpjpTGv7Xs0vi7t4Tv6EeLE4Jf8M0UHguPjXpNGVGyghWPSMaLsBe2WcR3rwBH5tSJf+6HnEiITq4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327124; c=relaxed/simple;
	bh=aLRiik+82B5sq3YU4UIJY/BRKKGgXuEBGHtc33FevpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbQbZcMd7B0A7A55hgoAT04pMRHFaykiBxhYlekqBtE0i8i/yAtCRqOsLMdMDU9pK49+rlDGndlEqxNhJQmzj6/nkUwJ+9XsekQHZHhbPXxV7GNtNDI7dNiBCuM27JesSqtAec8wR+WTCUMMRNuGqcT2McvFH5Z2ht8v7g5PW6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aHWOD9Uv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=03lSaS47; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aHWOD9Uv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="03lSaS47"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llMQUR+wwEgcNFKsWw7SwALRhRZ8Hk9MwBUMNVtb2mw=;
	b=aHWOD9UvZeeU8Ir7Qavbls53FEG2Xe8Gv1/qATtpio2CaQM5AhaNUBpylTtnLd4e5z5i3B
	HP/18AHWf0FN5MToKXBVSURD//SomAAqYKHnzWsfYGFSA58Zbo13m+Dk/Z6yezFdRxTBDG
	mNoalLKtcvXr6vKRycAQuaJY5FkU29U4phi4/tqu9jgwSc0aYAN2GOopOPUJT6GbBbceaE
	RL/NRUfSDZtGLNyQUvf3qiE6BGvhaW0wpOE0Xb46rnxRZjtsGbf4V0c2bWQpKZvUjmxR4+
	jBZma0KTgNcHf2OSfxJZEBO606z1g588NXeCsjuL9+duzhcrcuZjowT8eas25Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llMQUR+wwEgcNFKsWw7SwALRhRZ8Hk9MwBUMNVtb2mw=;
	b=03lSaS47ru0spuAwkaF2+tUNIqOm2UkglqnqHkgXkSl+watQnRd0jZv1xntHJBYnM8rGBe
	ckU7+LKwwcQXw9CQ==
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
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 16/28] ARM: module: Use RCU in all users of __module_text_address().
Date: Wed,  8 Jan 2025 10:04:45 +0100
Message-ID: <20250108090457.512198-17-bigeasy@linutronix.de>
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

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/kernel/module-plts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index da2ee8d6ef1a7..354ce16d83cb5 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -285,11 +285,9 @@ bool in_module_plt(unsigned long loc)
 	struct module *mod;
 	bool ret;
=20
-	preempt_disable();
+	guard(rcu)();
 	mod =3D __module_text_address(loc);
 	ret =3D mod && (loc - (u32)mod->arch.core.plt_ent < mod->arch.core.plt_co=
unt * PLT_ENT_SIZE ||
 		      loc - (u32)mod->arch.init.plt_ent < mod->arch.init.plt_count * PLT=
_ENT_SIZE);
-	preempt_enable();
-
 	return ret;
 }
--=20
2.47.1

