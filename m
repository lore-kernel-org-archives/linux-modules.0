Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F521F76DD;
	Wed,  8 Jan 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327125; cv=none; b=ukCjuAOecWO34y1vMY0wsi9429TUoLUiejnCETfQsm/uPx6SOPolKix2oWn7zWSlCvJUIfxA8BbtaOLwrnUCv9T96ZUKQKOSlFFS2DpAvcgEHmGQmYa6tJEEAP2gdYMwFfKfYHAY1eyMntlVK3Uz0phYhsRJ0TWgzqbZt0dBGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327125; c=relaxed/simple;
	bh=G5X0+l7fLr+Gr8mHaQ0KTZ50NSlxoDTZjLHVdH7IbPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCzU5ifWS/kdpAi4WTxyc0GtSKlIVxvq7bpzXC4o4JJPyqxwO3ah58tBZxSb2+EqaJx1p74ByUhEKCessPykaJLWawGY+LhKB5sETFWaKUgZR+HMP2qBixCBA/USJhtbRGSz3h2epV3gvPZhpcSWLoJ6vSiz1l5e6lLGKqJOvEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YLIfDCbl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OyFhdP9V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YLIfDCbl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OyFhdP9V"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7OHg3jZyf02ebMcCYNUEnflayAq9sYcMtyqzXVGGUlQ=;
	b=YLIfDCbletV3pU0iX98tJQKNzlx+X4ose1G+gNKVvj24SEtro3XGjJyTFaRselJaoZA/fO
	VtmraRUjNG8cgxJo4K71Ck4A0aoI0oeMR7XGJqr4Y5bnMph4HDjH3JLYxkWFmO7AyRvuOS
	qZZownHU37PMX+Xu5ffXuB2nIle8LTTt45sDubSBnJpi2T2pIt4tWkqzHh/SxPRFKeVvYy
	O+jsLLCuHBB7aQXTCO6BGjCf5FX4BEOvC3ByYebdgfIENxl+CM6x7ZVcin1NIi2BcZmVjA
	9JCA9nCUB1xDSXz1FWJVSqXUtq2z61jmeIYZvWTE5+3RDQzZAhPkkBhO37AxGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7OHg3jZyf02ebMcCYNUEnflayAq9sYcMtyqzXVGGUlQ=;
	b=OyFhdP9VaOnPKru4VN6IQKpFbHpWH58pMLlhK1zp71dWnqHZrF9vLu365AZOsLjpXBrMGZ
	6EkUlkgrqqIcxXCw==
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
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev
Subject: [PATCH v3 18/28] LoongArch/orc: Use RCU in all users of __module_address().
Date: Wed,  8 Jan 2025 10:04:47 +0100
Message-ID: <20250108090457.512198-19-bigeasy@linutronix.de>
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

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/loongarch/kernel/unwind_orc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/unw=
ind_orc.c
index b257228763317..d623935a75471 100644
--- a/arch/loongarch/kernel/unwind_orc.c
+++ b/arch/loongarch/kernel/unwind_orc.c
@@ -399,7 +399,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		return false;
=20
 	/* Don't let modules unload while we're reading their ORC data. */
-	preempt_disable();
+	guard(rcu)();
=20
 	if (is_entry_func(state->pc))
 		goto end;
@@ -514,14 +514,12 @@ bool unwind_next_frame(struct unwind_state *state)
 	if (!__kernel_text_address(state->pc))
 		goto err;
=20
-	preempt_enable();
 	return true;
=20
 err:
 	state->error =3D true;
=20
 end:
-	preempt_enable();
 	state->stack_info.type =3D STACK_TYPE_UNKNOWN;
 	return false;
 }
--=20
2.47.1

