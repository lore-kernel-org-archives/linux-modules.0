Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAF41F6684;
	Wed,  8 Jan 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327123; cv=none; b=rOooZxtWRmfTfAC8I9WHKQFnajHkrTeymte8HRerwJLBHSClhWDf7vMEHSc7lN0gBFdlL6TY6orv8w5PCNAVWivIfAbYYftVj1URTv8o9iQUsDVuCdx7a40Tizbkx8AgOFZD1KHJPeiaum3ILQeZn27ElWzWFo0F8G1UI3Tc46o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327123; c=relaxed/simple;
	bh=ohNt+IpE9y1EvrRtmwIXXsVBrl//72vKsf1EMenX3SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUXyoCBGyFXAZo0NbZNnCv0pgyNxM8H9pT76N9d3WYOQkPLtpxjSpwXFUPEi99D/8WF05naTLpSH/POjfxdX6G0BByv4P4ibrKHjn/AKeX+fxBs5NEUYvhxNSXzpv/uPuE/BJ+1d0LTZCBoPP02QYYaNsWTAfKrPGS1Vt6EG4NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tn6QcbAV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+ibczjjk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tn6QcbAV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+ibczjjk"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCMK/mF4CB3GzOpmLFR2eFXjQv5molDTvEmw2VyQ6Dc=;
	b=tn6QcbAV6lbve0+ob1buhBc7xxvQ+UILG89+UvzYHUFwnWYo3a/4dfHiReBRg+6gd5jtHF
	OShFzsOeSzYg4FgaV8t3UZrdMF5VMK/D0Sa0cWsY4Fe9t6dMlYXQ+xm0XMmXxIR7MU3Ve7
	w+MyeD/Weri5LV2Jzv2yZ3TNl4wgH3VwHyzPSF3VOhV2fTY5ioIl03ZtCI19NE0crqaCQ7
	YXMuSGt7P7yTp/hXXW548aEP4g2K+i9nRbLYlivI4UyPoZcjxdtCo47ZFHso8h8KvH4Bh7
	WxKsDkLH0n0QW5A+N/JUhh5XAFHtIW0u0/EQDk4wPF3mEytIJGAzNfslAIPYJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCMK/mF4CB3GzOpmLFR2eFXjQv5molDTvEmw2VyQ6Dc=;
	b=+ibczjjkcy4EN3QrXwP1iZ6Hm7kRRdoC2XZXirOv93caaBdZwhdORFKbRK3xxVyodt4qB7
	u9Y2xeft3dtYoSDQ==
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
Subject: [PATCH v3 14/28] module: Use RCU in all users of __module_address().
Date: Wed,  8 Jan 2025 10:04:43 +0100
Message-ID: <20250108090457.512198-15-bigeasy@linutronix.de>
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

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
2.47.1

