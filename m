Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092892288D1;
	Fri, 20 Dec 2024 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716869; cv=none; b=s60FIrnDmb5L4bmCw/AGE9WgP12WTwBPbcU1DG+1Ar1WJO8uGs7gnAv7H+g7faLGzEdnMgOrxjfB9bXnG6h0kXX3XF/nV2lJ3zN9nPjliXa+nLs48pzFoH4DXSXgF3ucT51xMnsHxiZnPr6TknV9maBHB+63piX7/d0gxRZOyxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716869; c=relaxed/simple;
	bh=6uJlA4reOfjymoCzgxYse8O4N1MM5NG+OXL3Be9LAqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLHHLM+8EhOaGJMbIIvWZkqv7KXFe8ljLIj8xm2LbvWteBTXouBT2FigdXs73QRRx5sCgmwRjosimCy0Al/Z66wwfUbwI0jYsT5jPZp3gLsXpNFDDONHy/+4WO7fEz05DyRazPptpkr/jc0V3E54tpuyCohZfoD4BWsrvsU1zlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vpKAtvfB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VnjFHEUC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vpKAtvfB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VnjFHEUC"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W07uvuPp3idmgtEJy1Zr7/RQ/o7cQBRopmcRQ6ih8IY=;
	b=vpKAtvfBYhoPO4pRMabTHrfqdiFg84pjuM1VXrGLoeWZOUroKKYgNOOWEuhP1O+KDxuUUj
	RqwLV+F4F6q+pv0Y9EyAObvppZHUKPu37k1l5c6KoquR+7ddn7qCRstAd+sbrP/uAIcL5l
	X/xuDjdeDcMtNcpzKMkGUIW6GIrWYIYbPWW1F0o6RHDgWgZ6ARjsny4NOUIsYE+bZJZ3sj
	mwUYpND9XUfQmNv2FXCJnIwGjZW1ZdhGPW+G54dmf98ymb6UirZB1UXrIRPSSPOsvYo96w
	2d2rbCpN8T6ypg+z19eQ1bjysVH0vBr9ImoEfY11hdZ4z23a/ByYBOSeXlvG+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W07uvuPp3idmgtEJy1Zr7/RQ/o7cQBRopmcRQ6ih8IY=;
	b=VnjFHEUCkGYpQf1hIX7SWktleDybCH3z+Jmbfhl6zcgciIkhrQZzgK9hqMLk4/PjLAcuIK
	EoHCdpCFyHUVcJBQ==
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
Subject: [PATCH v2 23/28] jump_label: Use RCU in all users of __module_text_address().
Date: Fri, 20 Dec 2024 18:41:37 +0100
Message-ID: <20241220174731.514432-24-bigeasy@linutronix.de>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
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
2.45.2

