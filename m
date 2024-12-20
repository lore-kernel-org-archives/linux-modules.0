Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E133E229666;
	Fri, 20 Dec 2024 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716871; cv=none; b=WaOw6IiMYutrEX1BY8egUj8god1oCaZfVBiyQ/L/MAzk6QTAB316ZRMKdSd+FCjMLNs7BAS9yPs1yP7B60MdV3H4bdzuetgZOFyEfSFpCeYDVSkg4tVd0gizU06TSldijEgA+FRiqsV5vJfg8O4pdohcYTHw3pOsfzPWpvrBww8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716871; c=relaxed/simple;
	bh=qCVZ6MXEQCZKbpVFTGMRYGzHJ160bIV49ZUWguKAVVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEQqYIBnzBNL0zqhm5UiaJ5PNNDZBJGax8SvoGQzGb66Ibj+WQ8DQ3+W107fXGwBYRAW+YJ6328qWxYTKSu00qnfyFqTPpRT3qXG6cfk5g2uF3xKGu1C/WCszB73lf/afd3pIYzmaYijyKVTSHlUIcHvF8xRHOGBWvWU40SGFv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zWIUN96C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cgHM558s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zWIUN96C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cgHM558s"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEtU1/INZZG1AUWOp9SKyBC5+mBME4Va/ulzQZtpooU=;
	b=zWIUN96CcPeolG0ZYxkjsK3EL720Iqhm6WEVV1bZMz2m4KEpGzQNCtPBIctID3jC7krnh2
	xp4eneV0EHTCOCfMrcwJJ7ttjjE3gAurfXNEdf7Bf0jz9aw0ThN5LeaipKMGir80vqDGnO
	tAE09a7+LBcENXf4yYTxynf7DvCXawjNkJEo6WpEEH+x0jrUeHqMR97a8wj5P2dXnKhV7x
	sFu1ebBkibO/F+qGCOdbyiYUSdsxoFUn+SSabS4clejR5Oy5oZ+yBZEM2xVvtqGD3rfNV2
	Og6D0qp/Nu2m1bk1jg8QqRR2MWOmo3bu4ZCgk80gcdg3uff/TQyiIz2zWUzWMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEtU1/INZZG1AUWOp9SKyBC5+mBME4Va/ulzQZtpooU=;
	b=cgHM558sw+JBKQVTWQKLskEmlEA2lnQiirxPbv5hwgQVEUyuvQ7N4KKVtC98bVutse8xND
	h295X/l0fNAHkBBw==
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
	Elliot Berman <quic_eberman@quicinc.com>,
	Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	llvm@lists.linux.dev
Subject: [PATCH v2 28/28] cfi: Use RCU while invoking __module_address().
Date: Fri, 20 Dec 2024 18:41:42 +0100
Message-ID: <20241220174731.514432-29-bigeasy@linutronix.de>
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

I'm not sure if using rcu_read_lock() will introduce the regression that
has been fixed in commit 14c4c8e41511a ("cfi: Use
rcu_read_{un}lock_sched_notrace").

Cc: Elliot Berman <quic_eberman@quicinc.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: llvm@lists.linux.dev
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/cfi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/cfi.c b/kernel/cfi.c
index 08caad7767176..c8f2b5a51b2e6 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -71,6 +71,10 @@ static bool is_module_cfi_trap(unsigned long addr)
 	struct module *mod;
 	bool found =3D false;
=20
+	/*
+	 * XXX this could be RCU protected but would it introcude the regression
+	 * fixed in 14c4c8e41511a ("cfi: Use rcu_read_{un}lock_sched_notrace")
+	 */
 	rcu_read_lock_sched_notrace();
=20
 	mod =3D __module_address(addr);
--=20
2.45.2

