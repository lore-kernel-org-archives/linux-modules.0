Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9A227574;
	Fri, 20 Dec 2024 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716867; cv=none; b=c+WtC/Q+JTRIuxuiGaEzQloUfXhlK/HiJ2cTzrUxfsc/rcAikUalaXA9LtvzV5tdjmCltTQc7vwMeiDYL8x20s7dyNaSNIETHEotXdqMWraeaYtiB4176Uq3UwC9OSNSVG3fBqJlwEEagS2Rvwe1Z5qxF725U/X1iq5V7G3p5b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716867; c=relaxed/simple;
	bh=9tX8FkO6CJFLnOxZNgzkW2mst4BbpND+XHbfRLQzNLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbagMSKRxSDn1zVb4XDp/tv/swK4H4CtRrmGMHGt0I0wyP3V2ePcIs0DZEiqq4FCikLU4/qHbQy275KmAkz7Emaz8Xf/r8GnwaSEugrzXw/prKtj1FMj7UanwTixg4u9gZdIk8FFr9xTboX8Nn/FrLHMnNxHMuzlqKWBtx/SJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DrPhO5Nh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YrIKQoNw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DrPhO5Nh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YrIKQoNw"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=160WDRdmuV++cCvmQlZL+oeRlLa+Yt8ROZGJz/QxIhE=;
	b=DrPhO5NhbGJrkb5rxgXdnAlYIc4lgjuIy/847/urrFn2AVI9MSqEUmqdoqVifpaWkni7v2
	XE3SxVDJVZWjr+UCqX41t+yoyBXF0Pbfmzuz5c8UqqliYDK0hxlPo1QnBeFO28uUwa/0m4
	PVppOHoSTAYqG/R7KZuCCK2dAzWmS5KFJccRJmhhf4rlam1QffYMsk92+TkvwTPuhkS35n
	DOOx4r5LStTMNwdGJ8mkELZVtkhI08BSUhY+7szKYARjYmsZkUQ23zb+UEeNgcmoGq0F0Q
	C76TOL3gfXktVw8qJMcj81lel2KZhDmKJH9AhvDZ1lt1lhlehq545ENw+/Ythg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=160WDRdmuV++cCvmQlZL+oeRlLa+Yt8ROZGJz/QxIhE=;
	b=YrIKQoNwcQnV5IHMrdPzqw7tHIYnJIDA6GC5ANTGCw+daftB9bqDVWKXXmmxb83/5upU/3
	ws0WYQ/ezbgxq1CA==
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
Subject: [PATCH v2 15/28] module: Use RCU in all users of __module_text_address().
Date: Fri, 20 Dec 2024 18:41:29 +0100
Message-ID: <20241220174731.514432-16-bigeasy@linutronix.de>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

__module_text_address() can be invoked within a RCU section, there is no
requirement to have preemption disabled.

Replace the preempt_disable() section around __module_text_address()
with RCU.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/module/main.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 80877741ac7e5..6a99076146cbc 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -823,13 +823,12 @@ void symbol_put_addr(void *addr)
=20
 	/*
 	 * Even though we hold a reference on the module; we still need to
-	 * disable preemption in order to safely traverse the data structure.
+	 * RCU read section in order to safely traverse the data structure.
 	 */
-	preempt_disable();
+	guard(rcu)();
 	modaddr =3D __module_text_address(a);
 	BUG_ON(!modaddr);
 	module_put(modaddr);
-	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(symbol_put_addr);
=20
@@ -3694,20 +3693,15 @@ struct module *__module_address(unsigned long addr)
  */
 bool is_module_text_address(unsigned long addr)
 {
-	bool ret;
-
-	preempt_disable();
-	ret =3D __module_text_address(addr) !=3D NULL;
-	preempt_enable();
-
-	return ret;
+	guard(rcu)();
+	return __module_text_address(addr) !=3D NULL;
 }
=20
 /**
  * __module_text_address() - get the module whose code contains an address.
  * @addr: the address.
  *
- * Must be called with preempt disabled or module mutex held so that
+ * Must be called within RCU read section or module mutex held so that
  * module doesn't get freed during this.
  */
 struct module *__module_text_address(unsigned long addr)
--=20
2.45.2

