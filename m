Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6963E1F4E32;
	Wed,  8 Jan 2025 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327123; cv=none; b=Tda7OLjVTP3xGdbYpM/zICe4WpEVufAmMnebaELDFGD8VJ4mbzCS7FHENODutxdNzIDGqRgBHT46gl8YMx8xJjmLsSaeQ2bla2ui8je5L+ro00ZnUCXqSeiG+lzl8yxvF7qYIYR8fwNuZHlAlYUvehFaMjsQgV9h2rscSI+DJQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327123; c=relaxed/simple;
	bh=j71SAc1feOMUcJOMEOonn0bRXR91q7WidaoHZw+Dzm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyGRunkG6QAG0wSpEkeQMVVEK2HiX+0HCMEGi78O86Rx3qhe81//6G1Yl2ovLyIyzf/FT+dIuL+AzpZeN8Oe42d0BrMVW+DtQoG+1VZZr63f9usW7n5y8IfFbZDORJEPaBkER4kBuJYM8Dat9R8hj+IoXUOhR4qi+ywmJ+zhMzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UXyXn6qs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kB2FQPbP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UXyXn6qs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kB2FQPbP"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MN0x3ummrzZ41bq/tcp8fUaKeaZduci8Y57Jyt5cghg=;
	b=UXyXn6qsDLwFTrdU2IMUOmERGnRfEHW6YwPtqITSqBPCcZZGX+NPxKHsbkKFR2Vt4ppaeK
	bYoUxeTEC5PY1t3iP2XiV73lqK3KTy2wXvswp84IWNyxsMjfRePcDoZiucG3XZacbMMh6p
	8D87l+HQbRGDKG/5whXIVrxvUxihzrplt29Kd3E+m12vkiy66EGbywjiRpyUdivsMranEW
	Px68VC12QVJQQqlBMHHVyxufw3w+WyjnZx2vV5mX5ZRqd/HZRtRp2F1/tbqwuAKbgbAiHj
	bm34EcnFuGAxcTp6XHvfNC1hku9dGuw8Lck72RZopdP1e4FfSmfMKlhP06907Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MN0x3ummrzZ41bq/tcp8fUaKeaZduci8Y57Jyt5cghg=;
	b=kB2FQPbPCXAbQRhuZi0w8hYUgBkHt7xEkZcSssQONfXd5v50yLr8zw4wmDj4Ink8eOuNHW
	QWnjD4HC+8dNugCA==
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
Subject: [PATCH v3 13/28] module: Use RCU in search_module_extables().
Date: Wed,  8 Jan 2025 10:04:42 +0100
Message-ID: <20250108090457.512198-14-bigeasy@linutronix.de>
In-Reply-To: <20250108090457.512198-1-bigeasy@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
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

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
2.47.1

