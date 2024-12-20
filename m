Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F4522913D;
	Fri, 20 Dec 2024 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716870; cv=none; b=d81Co2yGlKqo3ApZYJ//u0uh12riZ6m6qJSkzwcJt3vIu6jvLBRj37V4reSbd+OvDTnwIvuFgBOOsojpj+ZS7i0CAsY1BXUA7NdEUqnmuxSAN2/YSYTjf69wLkD++412J3274lRpu56hdZynMFw5EBmTfSH2M/lh1ViZXu+V8Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716870; c=relaxed/simple;
	bh=szZNjdiDOEbAPd7FllNALlPuBiIF6DYqyTi5RLt33+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaObGH9NHRwhYGmLUJGzOENtBk7PnIjs+gR8vCd6gCjHIifvOg8Em1eZDcGI2WaSCVIg8PcEYAnHPc3q08ThIMfVLH7uPGEl7CZdrZjR0BTEJb1XwGQrkEWovzKEfESYcKOgGQSc9b6p/7IXxgH9SKHMbhMc/uYEk1r5QCXJC9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L3KpbHi1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WgdOINiI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L3KpbHi1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WgdOINiI"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbrqJ09qm4S44mrWUWsD4EMkSiLFUJiV1ZfIl3x0Psc=;
	b=L3KpbHi1MSob3yXJdwsUs3J9glYVEaJwI77qPch7dyC3dNvwgxkEbJJmSPnoTzHELfUcyi
	LitspVMYt2bew92nRpbBFiOEm6BZ931FJ+wj7bOm4HxHyrKxc8/sbx7OJI6GL3F6kiEuVU
	WsPiIBJctMxcQT14lXLm5gPj6bnhEBC8+u9BP6mMKHn7Dslke0aOtGCg9GnDRY7mwOGi/m
	uKe8GcL/Wgg8U9dEGFfHNbotIyl2qAKOhOx5b33d2pNjTF6I7hv2JLcT0Rr6IVKFPc2hCH
	4osXuTh/VvRW3ZDbPhhf2/vz06ndcRUvwU+F5TRgYREtTmXhsNiA8/USS47LfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbrqJ09qm4S44mrWUWsD4EMkSiLFUJiV1ZfIl3x0Psc=;
	b=WgdOINiIuSgdwN+o+2EqLai5hSMpj5PCm6svRJWhnTPJLBAV4AxUjncgM0oXQ+7BIddkWA
	sBCCUccuDBJVEKBQ==
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
Subject: [PATCH v2 26/28] static_call: Use RCU in all users of __module_text_address().
Date: Fri, 20 Dec 2024 18:41:40 +0100
Message-ID: <20241220174731.514432-27-bigeasy@linutronix.de>
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

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/static_call_inline.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index 5259cda486d05..06b14d8362b9b 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -325,13 +325,12 @@ static int __static_call_mod_text_reserved(void *star=
t, void *end)
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

