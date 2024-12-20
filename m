Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444A0225A48;
	Fri, 20 Dec 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716865; cv=none; b=Vlg8+QVKIH/bbzAPbCk2s/YHpPDqQwMXf/Iz7f6boC2xPJlOmEdgBufuvJxdsnEu/DTApSM6AVc3gUad3bR13+RKpwYBY0yCjXJZPyElsoM5dv/TxWRPGzexV4xsia0MFRa4QmcvOQRltaNzHHsZkmUmHQDGHq8hPMMDmquRhSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716865; c=relaxed/simple;
	bh=zjSk4OAv6kN5bCYVgE5P6AEooaeh6BxuDm5ltMSVg2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbK1wdIwd+xYnH6d3VSsP+nDXBzjYvL0iW/xRGx9jUpZUf29S+ctB9IkW1tfzFzOUlopyE788ep2BiRuQOl/xZMy84LJWB03x96Np20hKJJ1Y89L2AoGPZs9LMeLM5cu0aPy2gwQqEf9S1bh1v1UJfhVwyjDP909m28oxGYXlJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dQw+qz9x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g2/YPLSP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dQw+qz9x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g2/YPLSP"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9b8RuGxslAGY/6F9yvrmsbza0BlNXvO30wkM+IliBVo=;
	b=dQw+qz9xcV7CFpOTGWvZS3RYh4LxkF44ufyHTzX5pniFVZNoeXEgVSdeAmFkaxZvPxIRt/
	85cadmw7qOUeWOp02x2k7N+o9sXa+gM7yMxNrMHvBgvm54Pe0fQK5C2xZZfzS9I+RZen3G
	Fw6p0Wozd5gKkjM3itETddJ/qkVvhRFsscF8LxNpsMgX7RdAUufEzWMwDK1fea8QSNUh1d
	Bq+Qp9nK9ICgkeVlbSSkyn3XM/ba8R8Z8CSoyNNQ7owjIysHh7UGxCmHNdALvqD32MKThE
	xaGsOYvSAr4K34EOXVyPbILDqKuHFppDSn3xsphXKWROPsZb0tJM1DOz8bruyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9b8RuGxslAGY/6F9yvrmsbza0BlNXvO30wkM+IliBVo=;
	b=g2/YPLSP6q3QM00UsXfCNwnPs8knZTb+9OGcYrxe10px4SNblJlRULh2jvRlyS6MA0XRUQ
	Va7imO9jY86OV9Bw==
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
Subject: [PATCH v2 13/28] module: Use RCU in search_module_extables().
Date: Fri, 20 Dec 2024 18:41:27 +0100
Message-ID: <20241220174731.514432-14-bigeasy@linutronix.de>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

search_module_extables() returns an exception_table_entry belonging to a
module. The lookup via __module_address() can be performed with RCU
protection.
The returned exception_table_entry remains valid because the passed
address usually belongs to a module that is currently executed. So the
module can not be removed because "something else" holds a reference to
it, ensuring that it can not be removed.
Exceptions here are:
- kprobe, acquires a reference on the module beforehand
- MCE, invokes the function from within a timer and the RCU lifetime
  guarantees (of the timer) are sufficient.

Therefore it is safe to return the exception_table_entry outside the RCU
section which provided the module.

Use RCU for the lookup in search_module_extables() and update the
comment.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/module/main.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 686b74c7c17f5..74b9e9ddb4b65 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3621,28 +3621,23 @@ char *module_flags(struct module *mod, char *buf, b=
ool show_state)
 /* Given an address, look for it in the module exception tables. */
 const struct exception_table_entry *search_module_extables(unsigned long a=
ddr)
 {
-	const struct exception_table_entry *e =3D NULL;
 	struct module *mod;
=20
-	preempt_disable();
+	guard(rcu)();
 	mod =3D __module_address(addr);
 	if (!mod)
-		goto out;
+		return NULL;
=20
 	if (!mod->num_exentries)
-		goto out;
-
-	e =3D search_extable(mod->extable,
-			   mod->num_exentries,
-			   addr);
-out:
-	preempt_enable();
-
+		return NULL;
 	/*
-	 * Now, if we found one, we are running inside it now, hence
-	 * we cannot unload the module, hence no refcnt needed.
+	 * The address passed here belongs to a module that is currently
+	 * invoked (we are running inside it). Therefore its module::refcnt
+	 * needs already be >0 to ensure that it is not removed at this stage.
+	 * All other user need to invoke this function within a RCU read
+	 * section.
 	 */
-	return e;
+	return search_extable(mod->extable, mod->num_exentries, addr);
 }
=20
 /**
--=20
2.45.2

