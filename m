Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DFA225A36;
	Fri, 20 Dec 2024 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716864; cv=none; b=tQb3NtOhKmXlgsRU4GLbv6yFkZ2tnWnj3/0MAPI/b5reTi5sBQ8NNOpNwuVBnxqguX4tjlcRKi6Ib+lTen7QewGSLVkuEWdVK7TyXDL9iVlkXVSuZfgpzbxkweiMXjEH3oleojnpFhQ9X9I7FQdBMsLpg1/jKe00BrGYre+AGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716864; c=relaxed/simple;
	bh=VpIIPt2CV4LrZsknKLmqtKCrrarrj5IxRTnAIqBP4/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb9WsgS4UOquv7NcHAcZWEx5NeBSYoBA5smNoKnvJJAWasmxbNFmsagbWSatiBbtjM6wrSVv+qnYo3WQ05x3mYqHpy/axOJev8PtUHeNoY67z8DIaCu+VTiTqeOcOLXmfi5bGjcxmMXeT9X9tPpqNknd9JPEs1PsQRbM7HmU8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t+NIZr1J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6plwZ2Ya; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t+NIZr1J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6plwZ2Ya"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AnLbUlJTtBlesn5+tJwa7V6G+8fL1YHPmCXigSuptPg=;
	b=t+NIZr1J5VzthNHQlHyQrK/fXgtFzUyavo9uKi8POl0ajC3O857YW9mtQ+9ptInJng9pHW
	CcLQWJKb9GeBCs4tbd4ZTDhPF1xfIo3VH5C6yk2CSLqc/GHqqAlJGz4SZpYBHsvC9cc4IE
	VvSE56PM+YcjfdnrVqL7VYDZ7MmR3c+1yQY7jVNx/thwb7ihUWKBqwg4jZrTigStIcCI8F
	bLCerTXnkSl4xcCXSwoK6Y6vJXaAgw/0aCjxPUWM06RHdNKSoG1CiLLTguKbVeOgMKafFV
	Atj6EVcXc8YMWK6utafZry1u4W3oFDri4Jr/puDQS3D3Ws5sy1XN3ywlQ4EiYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AnLbUlJTtBlesn5+tJwa7V6G+8fL1YHPmCXigSuptPg=;
	b=6plwZ2YasoSBrfLC9HnHyj9HMiALSdt01g0emA0tJCicggl6kEmSbR7tqnzk5I8iRnalPV
	dF3bX9RsO3C1YdAA==
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
Subject: [PATCH v2 11/28] module: Use RCU in __is_module_percpu_address().
Date: Fri, 20 Dec 2024 18:41:25 +0100
Message-ID: <20241220174731.514432-12-bigeasy@linutronix.de>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The modules list can be accessed under RCU assumption.

Use RCU protection instead preempt_disable().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/module/main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 71e73deed76c0..126f7f05dedf8 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -450,8 +450,7 @@ bool __is_module_percpu_address(unsigned long addr, uns=
igned long *can_addr)
 	struct module *mod;
 	unsigned int cpu;
=20
-	preempt_disable();
-
+	guard(rcu)();
 	list_for_each_entry_rcu(mod, &modules, list) {
 		if (mod->state =3D=3D MODULE_STATE_UNFORMED)
 			continue;
@@ -468,13 +467,10 @@ bool __is_module_percpu_address(unsigned long addr, u=
nsigned long *can_addr)
 						per_cpu_ptr(mod->percpu,
 							    get_boot_cpu_id());
 				}
-				preempt_enable();
 				return true;
 			}
 		}
 	}
-
-	preempt_enable();
 	return false;
 }
=20
--=20
2.45.2

