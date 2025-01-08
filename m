Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E461F9F4B;
	Wed,  8 Jan 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327128; cv=none; b=in7H8NqhYWQRFO1VsM7PVbFAD5ao7fs0Lq4a6r95eIt8UwbttxiUqscFMgP8Ub6PMgujkxeeP9UxS7vqF4QlvMzHny/lSUo99TDFrVfyE2DTB/gVemVOD+b5mI+w0qcYn69hH7kgLPL/WsKP11K2nP4aQEGUPQsmFKfSyyeFUeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327128; c=relaxed/simple;
	bh=SWUj/yhWok0jltP13k4QR36kJUgakop4QNztiZCnCiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XO2UBkqQI/sDlOHegamRghSwI8wr53uEBnlX/ecvDJTwoo/EwIoeiD4tB6wN0o3OWXfVZJV8zud5opXd72Jqgqsin7ge51E6Pt32R3Y/Dxo78z+1oy23UQ5UCS0snASeXN1XZN0DpvkCoE7fZkyE00JFkAoxgr+1MJ8CVz61PGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l6Xaa3Zk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EH4h1WB8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l6Xaa3Zk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EH4h1WB8"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sk+WapeZw3AyhQlyz/y1GT+qnQ8et4haJZXe3SpiSPM=;
	b=l6Xaa3ZkuhLoLRb3L6QHEEtslE0cbJtrTLx++mukG7hdl/wlrUasaWxUbqZRljO/bEkIk5
	7E44spQtMQ7BO8CzrWoqNY7R8LFlA/eLrFVt/3ExR1wz/dnF8ypsZRaiSDy5ppKflGeK+f
	dM3O2ocYj3/0lvoNC2bFfPRa/X37RVFGyn9JR/aejP+YCSAE8vIp8zmpDbpUoggR88OsBa
	ZG5/2zfFPMQL9IqBggckIU8tDzEigNP7khCkJ3k3K7O5O3/pZ/O0uw0XGDbAHp6WnDbHb0
	hcFHw3NP2Xf/DGjO60ymRk4ptJ/LaiK3aemUk+SWzmtuVvyvZ4mKuKC5eI4M6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sk+WapeZw3AyhQlyz/y1GT+qnQ8et4haJZXe3SpiSPM=;
	b=EH4h1WB8+5vUrKERLEa4IhKQK955bSJDwtWd0t1bpuUqaDt4xU7l+k19U0ExI84Kgc5KPX
	zl5TqptJCoav67DQ==
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
Subject: [PATCH v3 27/28] static_call: Use RCU in all users of __module_text_address().
Date: Wed,  8 Jan 2025 10:04:56 +0100
Message-ID: <20250108090457.512198-28-bigeasy@linutronix.de>
In-Reply-To: <20250108090457.512198-1-bigeasy@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
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

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/static_call_inline.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index bb7d066a7c397..c2c59e6ef35d0 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -325,13 +325,12 @@ static int __static_call_mod_text_reserved(void *star=
t, void *end)
 	struct module *mod;
 	int ret;
=20
-	preempt_disable();
-	mod =3D __module_text_address((unsigned long)start);
-	WARN_ON_ONCE(__module_text_address((unsigned long)end) !=3D mod);
-	if (!try_module_get(mod))
-		mod =3D NULL;
-	preempt_enable();
-
+	scoped_guard(rcu) {
+		mod =3D __module_text_address((unsigned long)start);
+		WARN_ON_ONCE(__module_text_address((unsigned long)end) !=3D mod);
+		if (!try_module_get(mod))
+			mod =3D NULL;
+	}
 	if (!mod)
 		return 0;
=20
--=20
2.47.1

