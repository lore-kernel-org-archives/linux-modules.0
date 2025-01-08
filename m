Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922CE1FA8E0;
	Wed,  8 Jan 2025 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327132; cv=none; b=ESAOr4E5eudUptLafAIY0a4pZDK9fFG0KdthqS+xIWxdY1IXWLQRj4LwSu39hRnx1T15WOUX5teRHHi50OYE/IGcd2+i1O6MnEvbibwGdIB6Vbg/NYbJdZAodW9q/CSESt4Y87EX7mwXxYFPi5J6Y8q9N1ecLb/MU/azFfv8Z44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327132; c=relaxed/simple;
	bh=yb3mAfmVt1ym08Th8qD0bMdwyMmjhVwma+uBB5OZTMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6UYkUFmVBXmb1Vpx9dXgCFUvvUE6VRfDIybQ7ueHzQFkOBi1Z/KeOFwebZAt71cSF8SaBUYCBi5HPfbn/JX+e1L0a7G+KoxikZxvR3dV0Twc4dBrGPyZ68GO3FYL7iU6mFVdXssoa9RK0ObjYuwzHr+PtIEs9vZF+/UsozfZlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EWuPgHkE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LwlX8T/q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EWuPgHkE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LwlX8T/q"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a9XnkkLLzmldxKAiZSOAAcLDr6gIVFvwHETvbCBha7k=;
	b=EWuPgHkE/wfR/74Pgd6Psf84g+9QOJANh7FieE9X6rdnxnILCuA3/4FJqDT9XZserXTDEW
	x/i7x8vabyoJv3szBlm8qqI1TUIuV5G4qtlcpnRk5Hft3x2O0zBZDshHZOSgV5E5TfHVfA
	FjJ/yIDSHwUf2e9rD/nMEeIRpVtlvqZYyAgQBWYQKKZntaWrSkVKty3tHnj2cIsnPr2GIH
	PT5INk63a34LNMVvXbNSLgqAqqD6o/LOPuFqqSMpO6JMj5ktb/Hp94QeAJddVmIXAmv7ez
	kvQeZX0CaRmKHnJ5fmhROnJbKRyhhGzIAJpyaDhDSD+ASqZbYYGUIYw/S8bQyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a9XnkkLLzmldxKAiZSOAAcLDr6gIVFvwHETvbCBha7k=;
	b=LwlX8T/qNESEGTPLAofvaGNYw0U5DyLl9ErT9p48z8cobSLz20N47NKD/oBsguoiB0A7r1
	pu6dPNdShJBQbvBw==
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
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 28/28] bug: Use RCU instead RCU-sched to protect module_bug_list.
Date: Wed,  8 Jan 2025 10:04:57 +0100
Message-ID: <20250108090457.512198-29-bigeasy@linutronix.de>
In-Reply-To: <20250108090457.512198-1-bigeasy@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The list module_bug_list relies on module_mutex for writer
synchronisation. The list is already RCU style.
The list removal is synchronized with modules' synchronize_rcu() in
free_module().

Use RCU read lock protection instead of RCU-sched.

Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/bug.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/lib/bug.c b/lib/bug.c
index e0ff219899902..b1f07459c2ee3 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -66,23 +66,19 @@ static LIST_HEAD(module_bug_list);
=20
 static struct bug_entry *module_find_bug(unsigned long bugaddr)
 {
+	struct bug_entry *bug;
 	struct module *mod;
-	struct bug_entry *bug =3D NULL;
=20
-	rcu_read_lock_sched();
+	guard(rcu)();
 	list_for_each_entry_rcu(mod, &module_bug_list, bug_list) {
 		unsigned i;
=20
 		bug =3D mod->bug_table;
 		for (i =3D 0; i < mod->num_bugs; ++i, ++bug)
 			if (bugaddr =3D=3D bug_addr(bug))
-				goto out;
+				return bug;
 	}
-	bug =3D NULL;
-out:
-	rcu_read_unlock_sched();
-
-	return bug;
+	return NULL;
 }
=20
 void module_bug_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
@@ -235,11 +231,11 @@ void generic_bug_clear_once(void)
 #ifdef CONFIG_MODULES
 	struct module *mod;
=20
-	rcu_read_lock_sched();
-	list_for_each_entry_rcu(mod, &module_bug_list, bug_list)
-		clear_once_table(mod->bug_table,
-				 mod->bug_table + mod->num_bugs);
-	rcu_read_unlock_sched();
+	scoped_guard(rcu) {
+		list_for_each_entry_rcu(mod, &module_bug_list, bug_list)
+			clear_once_table(mod->bug_table,
+					 mod->bug_table + mod->num_bugs);
+	}
 #endif
=20
 	clear_once_table(__start___bug_table, __stop___bug_table);
--=20
2.47.1

