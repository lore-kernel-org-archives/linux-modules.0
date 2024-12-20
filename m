Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A421CA00;
	Fri, 20 Dec 2024 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716861; cv=none; b=ksZdic3SIl5Q7a1kw/Erx4Ug1nu0t+1c3mGnWWyNHLh9uRH84YLmw6QGbtwY2hHSUGdMX2IRe/iN6P78TblRpSqbqnitqjTA91YoO6HaOhQPEI7qEZdD+9buDOFGgaRCw1mqpz3+wu2Zreo/EhcU3akbXTLmgUvN88vQWxKE2u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716861; c=relaxed/simple;
	bh=+tMmuDHymxm4vFnd5USrEbmUauXQHlCNL/qrRG/E+z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TU57FbGQbGr3xwggUoQmIEU17prK1Tm4MIqORFs6QrpWnN39c2ij30zeXyf2Wj51FJWTX12cgzDOpRvCGbBMmm7t1zerqXtmcmv4BQaxXeYakEGlVWmF6G+w5Kk87806BZCpOzrZOrdT0pwSoad3P/vLFCtUsD1OqQbSc8H9zpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zJHZQy7a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cRWwGbMS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zJHZQy7a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cRWwGbMS"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBQkgNJsnyD1dMyjjHJldsklJJimcQF6KjLARswWJz4=;
	b=zJHZQy7a2uxj6v/PogTSedLmCA9KIMQaNtY/vslFIBa+tVxuLKZH/7rlUpUJ/TtCxXy9of
	vt7ThkYxZ/ot7OZGorEGdIMf3pqlqEHw/0HxTsGNehIcZ9gk/XUjEGWBmEU0L/2C03VHII
	QtLEsocJcf87pjKOhjp1PG2bAkDailB57EkAlhW/Ppo4VpOfcwzkzUW7qM7XPqYAgIZkAT
	lWeaqGKGd3gnMciQMPtc/FaTsVixpxkLxR/caFeO2OZmhIlm0qLVqdXC2rdB2KsGq2rb3j
	12M1vfB9P8jQq05H86jOIMxT1mkvGllb0Ht8prdCydFAv/0I/3DmQSShP80Evg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBQkgNJsnyD1dMyjjHJldsklJJimcQF6KjLARswWJz4=;
	b=cRWwGbMS9RG2bIk6NZ/gAcSUj4/H+CPt62mvwZUUuvTEdBZKQM1W8LTeDPSZnI/OWcjDGU
	04Vrc824M86AH1Dg==
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
Subject: [PATCH v2 04/28] module: Use RCU in find_kallsyms_symbol().
Date: Fri, 20 Dec 2024 18:41:18 +0100
Message-ID: <20241220174731.514432-5-bigeasy@linutronix.de>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The modules list and module::kallsyms can be accessed under RCU
assumption.

Use rcu_dereference() to reference the kallsyms pointer in
find_kallsyms_symbol().  Use a RCU section instead of preempt_disable in
callers of find_kallsyms_symbol(). Keep the preempt-disable in
module_address_lookup() due to __module_address().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/module/kallsyms.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 45846ae4042d1..3f59d04795572 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -257,7 +257,7 @@ static const char *find_kallsyms_symbol(struct module *=
mod,
 {
 	unsigned int i, best =3D 0;
 	unsigned long nextval, bestval;
-	struct mod_kallsyms *kallsyms =3D rcu_dereference_sched(mod->kallsyms);
+	struct mod_kallsyms *kallsyms =3D rcu_dereference(mod->kallsyms);
 	struct module_memory *mod_mem;
=20
 	/* At worse, next value is at end of module */
@@ -329,6 +329,7 @@ int module_address_lookup(unsigned long addr,
 	int ret =3D 0;
 	struct module *mod;
=20
+	guard(rcu)();
 	preempt_disable();
 	mod =3D __module_address(addr);
 	if (mod) {
@@ -356,7 +357,7 @@ int lookup_module_symbol_name(unsigned long addr, char =
*symname)
 {
 	struct module *mod;
=20
-	preempt_disable();
+	guard(rcu)();
 	list_for_each_entry_rcu(mod, &modules, list) {
 		if (mod->state =3D=3D MODULE_STATE_UNFORMED)
 			continue;
@@ -368,12 +369,10 @@ int lookup_module_symbol_name(unsigned long addr, cha=
r *symname)
 				goto out;
=20
 			strscpy(symname, sym, KSYM_NAME_LEN);
-			preempt_enable();
 			return 0;
 		}
 	}
 out:
-	preempt_enable();
 	return -ERANGE;
 }
=20
--=20
2.45.2

