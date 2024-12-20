Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EFE227575;
	Fri, 20 Dec 2024 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716867; cv=none; b=J/qxoAJvRzx3qng5uvOtdCtODqlpMOus2PsnW07Mk141YmcPSmFhkD6PJdBxYqJjIhT8bdK3JPtP3uJlC9OkKdZvUIWZ8pkpcRwAHkCqBvEEqjv4PK4F8MiV6Ioz8vxi0E+B4kcBFoIv1B42BQRs8v1BGeFefUbUGjU6rSyD2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716867; c=relaxed/simple;
	bh=v4NO/FjLD7R+3JjvcSQW4GHXMTeRHN6qezJyxaWSwTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iimdPqJLuYOcjgaJMd46gJR34PAOGP+3r0sUFxw8MZ241m1BAupXneuFogRs9fVkX0QdiKznH1pi73oVFJS/Alw6+n3ivo3oJVYac+zwhVQyfdcD5EWa8bp+vQ7F2CVr17pUT15iuBhJBldzrvbmg2xpZEgfo1n3CXJ/M4gVMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uwZHwo6e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n2Rwu/VT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uwZHwo6e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n2Rwu/VT"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hGYN4ff5lKOeQEcqe/g4bGLpQfsoz5UlJMjakVJzeFk=;
	b=uwZHwo6eNmwA7kya9O3GI4iA8IAlCQOOukqHJWYAa6K+3KfgKuyLtLRUdLGbgYLGanUzaG
	aiphp82LdodS2mLsk2Qd9S8NkKkNc7zYbJQWSAoDC79FCQ2TVVIRV5OIttrftP1FBeqZDa
	6IUXwn4Hb6xFgFf/8go5mtCepamkeQx9TkDntwXDQgKAulbhkUkQj3PXHkwwmZ9Hf0u67Z
	0g/xa6CTwr9llsRQB6nMxgDy1/HIdMpza0zROTWUw/FMPRUVc2tXhUr3RJwqFESFfyylVI
	5HgNyGrnKikqy/1+dKob9mxnWUMaNYGcI3Jh5VIV5If1VteNtKXQEs4KOjZG0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hGYN4ff5lKOeQEcqe/g4bGLpQfsoz5UlJMjakVJzeFk=;
	b=n2Rwu/VTOnU8F7k6F/wKH79A9noqoGu1s3Du9ttx9cs1WIJBbPRrLJWHfLUsFdg8QywFjQ
	nb1x3jg1ZWpWT5Ag==
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
Subject: [PATCH v2 16/28] ARM: module: Use RCU in all users of __module_text_address().
Date: Fri, 20 Dec 2024 18:41:30 +0100
Message-ID: <20241220174731.514432-17-bigeasy@linutronix.de>
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

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
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
2.45.2

