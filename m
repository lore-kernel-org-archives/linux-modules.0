Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4644F225A49;
	Fri, 20 Dec 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716865; cv=none; b=CiKhJcpx2D5Wi0dR/OYIVU8k3eHtnyi74T7PaglfgqhAe9Wb83TNwg1nu2h4AVEvuVGzz/flpFoYmzid9U/WgecEWyfcK/qNgVVk2xitfmwh26ObGIH323ept8QIBrnBT7KBCmCtvE5qqfbguphD9Cb6RrZ5FUATMPnLHnQlqh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716865; c=relaxed/simple;
	bh=VdI5h+LUrY15pCOe9PvBPANJxeKtXWjDJLIoPFNZvc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHwbkbsvQhmdOCJ6eRP8taDkyGJRLef+K+/zllo76Dc5GlCk24n04d5+X6vCQlxhMAhODYdSbBMTA4O+UuuroNmwKUO/SdX7WPKRa4FxfTrCDaCiBrrLcmh3Rmhfy9uwshBn9Py9UwQ2NNkfEYgsVt7LsCrEcnsl0jKlIBeBLq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IGUMNEDb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oygx32kJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IGUMNEDb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oygx32kJ"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3RpndSc/R2r+/8h7P3FIFwE0RAdhRhdzrnR4zSM1ig=;
	b=IGUMNEDbNoyyp3UgaroxfQ4g96xPTUzfUR2Z+DUheCst/3cKrhZ+4MYRsqAbCbF8jHov5M
	/WPHI56DrlJZ+XjrqvgUQyS8E5zx7a+IHfrodSfOLteF5lSSYF91TRD8yonhic1Yg092FE
	ZhivyWuR4dNFSz/A//pclipK68hu6CIrSBvNik8rSz6ggE5WW2XpvuSUTSikJ4BHo1hqQq
	nmdIZYDCn1diGKW92qSJ5dCYdr2i3YmrTiAwKSY0CP4PjOXREGeDh1pfkqdeJU7dKIrq4c
	WzRBOIaCF/T0kGA1UJd/q7Gjz/3niEzuVXmiQAcOWmU8exTSHGMg4Khwt4eFLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3RpndSc/R2r+/8h7P3FIFwE0RAdhRhdzrnR4zSM1ig=;
	b=Oygx32kJ8ZxkNrsoYVpFGbhc9XOk4lQxp5Vl1nYCAya/wYAxjrWY7rUZSt8jysjtucjJQ+
	ikTssShzU2V3q4AQ==
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
Subject: [PATCH v2 14/28] module: Use RCU in all users of __module_address().
Date: Fri, 20 Dec 2024 18:41:28 +0100
Message-ID: <20241220174731.514432-15-bigeasy@linutronix.de>
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

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/kallsyms.h | 3 +--
 kernel/module/kallsyms.c | 5 +----
 kernel/module/main.c     | 9 ++-------
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 1c6a6c1704d8d..d5dd54c53ace6 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -55,12 +55,11 @@ static inline void *dereference_symbol_descriptor(void =
*ptr)
 	if (is_ksym_addr((unsigned long)ptr))
 		return ptr;
=20
-	preempt_disable();
+	guard(rcu)();
 	mod =3D __module_address((unsigned long)ptr);
=20
 	if (mod)
 		ptr =3D dereference_module_function_descriptor(mod, ptr);
-	preempt_enable();
 #endif
 	return ptr;
 }
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 0e8ec6486d95c..00a60796327c0 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -316,7 +316,7 @@ void * __weak dereference_module_function_descriptor(st=
ruct module *mod,
=20
 /*
  * For kallsyms to ask for address resolution.  NULL means not found.  Car=
eful
- * not to lock to avoid deadlock on oopses, simply disable preemption.
+ * not to lock to avoid deadlock on oopses, RCU is enough.
  */
 int module_address_lookup(unsigned long addr,
 			  unsigned long *size,
@@ -330,7 +330,6 @@ int module_address_lookup(unsigned long addr,
 	struct module *mod;
=20
 	guard(rcu)();
-	preempt_disable();
 	mod =3D __module_address(addr);
 	if (mod) {
 		if (modname)
@@ -348,8 +347,6 @@ int module_address_lookup(unsigned long addr,
 		if (sym)
 			ret =3D strscpy(namebuf, sym, KSYM_NAME_LEN);
 	}
-	preempt_enable();
-
 	return ret;
 }
=20
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 74b9e9ddb4b65..80877741ac7e5 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3649,13 +3649,8 @@ const struct exception_table_entry *search_module_ex=
tables(unsigned long addr)
  */
 bool is_module_address(unsigned long addr)
 {
-	bool ret;
-
-	preempt_disable();
-	ret =3D __module_address(addr) !=3D NULL;
-	preempt_enable();
-
-	return ret;
+	guard(rcu)();
+	return __module_address(addr) !=3D NULL;
 }
=20
 /**
--=20
2.45.2

