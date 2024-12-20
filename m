Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C174F225A28;
	Fri, 20 Dec 2024 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716865; cv=none; b=SRrGR+TIRZnq69Sl2NE9qjRgMdknYWHB2fCJYx4uCz19h0ENdinlHftzCYaNUVpVxWRho6V3eoKTdjIRHNo5Nw8FbUUdLYZ0OV6/1eHc4GzwOlgCR6WULZyT6P9LwaNrEhZgYoGO58Tig+Zzok/2alUMz0rwb3cCvUwsUa5NNvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716865; c=relaxed/simple;
	bh=PsTa+u2CgL96hyiRYTqffjxvlq2SDc8+rediGZAjvkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izegIxm7f5T+e7jTNNpVFkBJth3aT43EdZ8G7spldS0iCAxzEbqHHeMsEDUVA1h+5wqf/ozcQM6LrH2wdnwZZpt93AJ6FW3qjQsUkOIUXVpwT4NbIthYniZWsqEuH8bcl4iIEFBAWbZEjqMrsl6nGbT8g+Vim/tOVRRVaIaGnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f4QPmeDY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v6ETjZvi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f4QPmeDY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v6ETjZvi"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3aBio7NzcJmfogdbfJFBCrfW8ZRBESMCA8R5ZDYz5YA=;
	b=f4QPmeDYIxjr3LPVvmFN+RPQjzP/w2l/kBL5tXPY45V0nU6CuS7VPJeYi5bUKa0D6CqpCx
	nTz0TltZfC8Ub9HfLy6G691fpzJTSequTkFc6vQW6ar/dIqieH8U4fvHM0k8zQh7n92mHq
	g+3olW2FxvhOMtWABqdvC6MvT+vvvOaf5tjEou6oM58RJOFgoVYT4Ac0pQfTO4+9K3BVWh
	Ig5IYoEFHpA89RQAsiTIHzfU3N0iIg/y/XpAHAVSqEpd5/NsEB7ACsWBKWuJ3lVosRcCct
	R7TOz9ClT9P3QLrOHMzTB3EpWTJs1uvxRgqfZ567tvNo/rpXA7V6fYT/49FVfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3aBio7NzcJmfogdbfJFBCrfW8ZRBESMCA8R5ZDYz5YA=;
	b=v6ETjZvidzOI+b8ivUJdCuypKonQSYhJMDvggZ1X0G+Q4TX6Fyl4daqEgwCRj4ulBY6ic0
	6LHsFHeAdVNimDAQ==
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
Subject: [PATCH v2 09/28] module: Remove module_assert_mutex_or_preempt() from try_add_tainted_module().
Date: Fri, 20 Dec 2024 18:41:23 +0100
Message-ID: <20241220174731.514432-10-bigeasy@linutronix.de>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
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
2.45.2

