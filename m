Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481CE227B83;
	Fri, 20 Dec 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716867; cv=none; b=gFV4LUK1/3wXWE1N87QZmqOl3Rjc273rXsX1ZxLQV88EOFSnAMLPd+3nhRT9pweD+yh8IXNO9c6i/jdR6T2H4F+NTODKumfMekszoxH6f9SxhC3OBL9pRrIDwRYEVZG0o/1IUExXg8wwFXUI7gGIZGY23w+YbyAK0pEmLfoN7/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716867; c=relaxed/simple;
	bh=8GhjdGyZlhSd+u5XuDcl+fATkvBHdZQ8G05mszSHBn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lq+J2nHsn65dInultHuiBxX1ggzyzb26DBcaUgvRJBbVQkXjBI7DSoQaZCG6vmfiDpdoPYNfA0Ftgb5GGIo5MY/zhUQXRiG7DWrxzsFZddwmmj0I8jNNwZmpQKeu1PDbq3wyOfYurBxN5XT62IguuW76pX5TyOjquBIKGrJeKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cpVzP0oh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MdH6HyVg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cpVzP0oh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MdH6HyVg"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ljs2jZrg2BL9VEhLxJX9ekollT4zmDGIk7v5ipaXh/Y=;
	b=cpVzP0ohHAm5pZrQASOuHlpsjdo/i7DReDawcu+bn52+UjOf4l9PoAZUK/61GQDpWt0CZT
	Yh0QCx39Lnsd7vdBy3r/k+TY+SErCWkdDX7p7Ao25TyMXf0LqXciBWJ1qywiESj4qfFXUo
	Dsde0rfiS3MagZwRZxULEnmkhSQtr+wSEfm9Mso3E+tnADf32S5yJb5kYUqABDZyS2LKx0
	yVVwKGHYaKlpyC2GrmuBd7BVg1uoY0wMIGx1OOqWfAe0o68vbRvG/tpqYXjI3pwqnZmWOM
	huZxMVqPiSckp9LuWI7uVBVM3XiZHJ2aLpGKXoF2PxMQ2ruBvEerLOwVYNi2LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ljs2jZrg2BL9VEhLxJX9ekollT4zmDGIk7v5ipaXh/Y=;
	b=MdH6HyVg39qtamm+1xIfFxU5cTC7T3KWszaXdykLG8E8Ga/1WONP84nlrNeJ3YGGT9TA1r
	b2ATouRkr6VpNFAA==
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
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev
Subject: [PATCH v2 18/28] LoongArch/orc: Use RCU in all users of __module_address().
Date: Fri, 20 Dec 2024 18:41:32 +0100
Message-ID: <20241220174731.514432-19-bigeasy@linutronix.de>
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

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/loongarch/kernel/unwind_orc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/unw=
ind_orc.c
index b257228763317..d623935a75471 100644
--- a/arch/loongarch/kernel/unwind_orc.c
+++ b/arch/loongarch/kernel/unwind_orc.c
@@ -399,7 +399,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		return false;
=20
 	/* Don't let modules unload while we're reading their ORC data. */
-	preempt_disable();
+	guard(rcu)();
=20
 	if (is_entry_func(state->pc))
 		goto end;
@@ -514,14 +514,12 @@ bool unwind_next_frame(struct unwind_state *state)
 	if (!__kernel_text_address(state->pc))
 		goto err;
=20
-	preempt_enable();
 	return true;
=20
 err:
 	state->error =3D true;
=20
 end:
-	preempt_enable();
 	state->stack_info.type =3D STACK_TYPE_UNKNOWN;
 	return false;
 }
--=20
2.45.2

