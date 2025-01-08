Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E221F37BB;
	Wed,  8 Jan 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327121; cv=none; b=UrKEUqR++bKiR08aXDjg3eKGZPncVlY5WBi06Pz2MFN5t2+k9yu100pcBs/zTJ22FSIsXBo2OV4TniF0qPuaEr4rko30gjEG56x4YnowwFlLBC//kZPxngQDN5WbqO4PGy7t38uNVC2qoBAG+SpHP9ZoqhkuIisL+WnP6oRNBds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327121; c=relaxed/simple;
	bh=+fSSWy+fySzQclNpCT2E1vgWXSq4i07JqpwHIz6/Xtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MN8vx7FWdROGQ0b8nubj66+9fVV/QIwTLzwpmdOj0xjFgTg4fxnpjr/7bJMJi+971aYrZkwvXgswyq+PfGDwOxEIyUHIAReHRVKQRbek0pEbHkpdGuyZ95RDVma1XM5TG+uHwPSKvfSEiwtXTvjdhj+xJ/7x8jlt/OmL/9izhq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dVV40QTc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zAgwkyLH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dVV40QTc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zAgwkyLH"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ilrd0MEGQs/sE+kksjagNa1uRWCb3COiwDhm4RX4LIY=;
	b=dVV40QTcOsjKHL9CKFZkjsE32q4v2jCLXVMANins+8F5indNkSuw1y1OPQK7eBRQpp0d6g
	TlVTTIeP/3vm/qIb5VivGPPu+3NkHPQ0gfDYauNn6S1lilBHflBoTijlNUSwHBsKpChKtj
	eu1QytFdy/rzy2FV7vOdIMwfBLZ7965O4ZDgHumAI9D6GDdfRZAzxcwNx93SbnfMt+l2Wt
	LZXJLO0HktMuaWk3qvjg7MSpJfdBqX4rAlEK/xdobVcXfHdvQEVRJACBfOTQKghxLBhE+X
	Gd5nYT91C/T6zncmG2V55HGRzgtxsPXzylbtkoJKhGnJvcSoDzln7L7lBNWJlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ilrd0MEGQs/sE+kksjagNa1uRWCb3COiwDhm4RX4LIY=;
	b=zAgwkyLHkImLyn3X0LEb6gs9E+0DXC/Kb7pJF6AVP5beEuvDyxXM0+20Bng3sTeeWJWeMv
	zb/Q0b2VQKquAPDA==
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
Subject: [PATCH v3 09/28] module: Remove module_assert_mutex_or_preempt() from try_add_tainted_module().
Date: Wed,  8 Jan 2025 10:04:38 +0100
Message-ID: <20250108090457.512198-10-bigeasy@linutronix.de>
In-Reply-To: <20250108090457.512198-1-bigeasy@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

module_assert_mutex_or_preempt() is not needed in
try_add_tainted_module(). The function checks for RCU-sched or the
module_mutex to be acquired. The list_for_each_entry_rcu() below does
the same check.

Remove module_assert_mutex_or_preempt() from try_add_tainted_module().

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/module/tracking.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index 16742d1c630c6..4fefec5b683c6 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -21,8 +21,6 @@ int try_add_tainted_module(struct module *mod)
 {
 	struct mod_unload_taint *mod_taint;
=20
-	module_assert_mutex_or_preempt();
-
 	if (!mod->taints)
 		goto out;
=20
--=20
2.47.1

