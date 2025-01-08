Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA301F6667;
	Wed,  8 Jan 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327123; cv=none; b=huERPS9EMFnwsg5u9FfCMqFDNZbv6uwun1B7iKcreVGFcTbaNI84kHtK7Yab2qUSFbrGM1e/n1OUwOnfjNW43yDvs0pwglNbgcuD+xaWjNps/TW1ib3/ciu4TLvza8IxLyaVRals5eWsna6xIDHzHduNcZ3C/rZSYFWzKuZVUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327123; c=relaxed/simple;
	bh=4YfCwpsDNu10d16uLvt2ftKgzSjz5rZGc0e3lZY1kSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxtdZTiJDHweTQ2ZL3fz6WyfJlfiEY4HJ/uYRwZbW/EYkKepFcK1KiTNIjybVVa9RQi8xR7BpRUiOXfaH/ON4lE3V+SUtec7aaCR1D1qavDcm94HzVnPFLWwdAOvoP7eWfIjLpI3rkCvaxCk/c5iRm80WtQ0kXxwvkhVv7B9Fro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0sVR6cTe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/2agCRE4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0sVR6cTe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/2agCRE4"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o25ZzV5RH6ZFftfvyXoFK8KiOkIRV6q0g+c/tnCIM0M=;
	b=0sVR6cTev+LkI7Ca+JfYPKISZNzOMrBcWcY6BXH0ztCcWJJLGWAYNDDpfrQWWzyq53T3v+
	X0BRM3OIIo2JzkFf0gn0pjTNTqh6nz2Hna4KqcvQRwJyxLGZMK6R51ig/WBCtf3xBGxgRs
	d6B5xZzP76egaAloN3i4UMBRC9oilL2NF4t4Xxg2LySNxEPJUBYOzgCbyx23LWtTpFoWiC
	yDhIt813TgAoAwWY9QwF589K1UeUz+wWyc0QCJe7j++pvtCZoxdNJQcjWwwJMpI49NaRI3
	p1PeWwqC0y+OniC5DqP5QVcPGhBap5a3smrPKoZk6Wkg6cCAjEJAGNevaAzfJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o25ZzV5RH6ZFftfvyXoFK8KiOkIRV6q0g+c/tnCIM0M=;
	b=/2agCRE4MSuFSBvHxRUEYPTiwIdCGZbd8InWlbPPJ/33PZsCcg1r7pbNGbuTeFGx2Rx4DY
	vMgZvT71aOnyCFCQ==
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
Subject: [PATCH v3 15/28] module: Use RCU in all users of __module_text_address().
Date: Wed,  8 Jan 2025 10:04:44 +0100
Message-ID: <20250108090457.512198-16-bigeasy@linutronix.de>
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

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/module/main.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 80877741ac7e5..6a99076146cbc 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -823,13 +823,12 @@ void symbol_put_addr(void *addr)
=20
 	/*
 	 * Even though we hold a reference on the module; we still need to
-	 * disable preemption in order to safely traverse the data structure.
+	 * RCU read section in order to safely traverse the data structure.
 	 */
-	preempt_disable();
+	guard(rcu)();
 	modaddr =3D __module_text_address(a);
 	BUG_ON(!modaddr);
 	module_put(modaddr);
-	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(symbol_put_addr);
=20
@@ -3694,20 +3693,15 @@ struct module *__module_address(unsigned long addr)
  */
 bool is_module_text_address(unsigned long addr)
 {
-	bool ret;
-
-	preempt_disable();
-	ret =3D __module_text_address(addr) !=3D NULL;
-	preempt_enable();
-
-	return ret;
+	guard(rcu)();
+	return __module_text_address(addr) !=3D NULL;
 }
=20
 /**
  * __module_text_address() - get the module whose code contains an address.
  * @addr: the address.
  *
- * Must be called with preempt disabled or module mutex held so that
+ * Must be called within RCU read section or module mutex held so that
  * module doesn't get freed during this.
  */
 struct module *__module_text_address(unsigned long addr)
--=20
2.47.1

