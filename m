Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A52D21B182;
	Fri, 20 Dec 2024 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716861; cv=none; b=H9aSzaLDU7t0KWnLFIfde+/u2R7A6cb6LugHkYODYc5uvBbiE1r3p4XJWUb2a3nxWHJmTS84QLj5mwbEtLU/v3f4as5AJuzg7DzZ6Vj4h3BwCJWWvqzPvtyH3eMlp0neDNnjcUdgaTl6jml19V5Ebgcpfhx3pXInkRVvAqKNGc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716861; c=relaxed/simple;
	bh=Ez9a8QqH18hxi3K7lFzriilp7Ti8WL3yb/1TbjOD3jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZktWysRMa9tB/Q5Lp7n8P5OxsSWruOPTi3ELyqD+hST2K5H9Wlo01/P14ZDVTkXOyxUs4B/xDGiqIlO55bxgWfpESle3HMbQ550+2LZyp2PNDyoPoLy7M6vwpgy0kZEfpVqGvAaTsE/JjVuO5SqifDssWNCdj7nM7D95wo4WCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VeWM7rW9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fMKoUaee; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VeWM7rW9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fMKoUaee"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mUoDDG+l47O3+vMUk6eVXEzXq+1GxAnfmkZBqPU3miY=;
	b=VeWM7rW9QXtAMWnHN9WczxUc8haDbC9szTWTTWi1ntBBobpSJCm6AvixLsi5EK9Lb380y8
	DFoFOB2i/diTlb5SXTH0+m1Wlqc9IjtX8EoJS1rBn2USkwu4mu2n8vuE3/jiiJB7cdoduG
	TjWlcB+QEr4ItWUiSJRLYi4VFU0XIT+sqTD3S9y+cXGZsQXoUn00OpnHyu8sar4TZ6fP6M
	j+E+ywk+liYExCeT679qnQyqlvXwtPE+QReVRbAOtglXDepHRwYhlH/v0MGxTlhLugx3CM
	vK/9c7WIDzTJ7RdlYOS1YK0LaRXplkCsVPKsovr6ZYWZOLU5kMGbIJD6Cq4T4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mUoDDG+l47O3+vMUk6eVXEzXq+1GxAnfmkZBqPU3miY=;
	b=fMKoUaee6BrFn2ilOUvKtZTzJ99Gmt55PbVZODBJtohd+3QWbGix3h5CEtsqB532rftSSe
	IAum2v4ago/eu3CA==
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
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 01/28] module: Extend the preempt disabled section in dereference_symbol_descriptor().
Date: Fri, 20 Dec 2024 18:41:15 +0100
Message-ID: <20241220174731.514432-2-bigeasy@linutronix.de>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

dereference_symbol_descriptor() needs to obtain the module pointer
belonging to pointer in order to resolve that pointer.
The returned mod pointer is obtained under RCU-sched/ preempt_disable()
guarantees and needs to be used within this section to ensure that the
module is not removed in the meantime.

Extend the preempt_disable() section to also cover
dereference_module_function_descriptor().

Fixes: 04b8eb7a4ccd9 ("symbol lookup: introduce dereference_symbol_descript=
or()")
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Helge Deller <deller@gmx.de>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/kallsyms.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index c3f075e8f60cb..1c6a6c1704d8d 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -57,10 +57,10 @@ static inline void *dereference_symbol_descriptor(void =
*ptr)
=20
 	preempt_disable();
 	mod =3D __module_address((unsigned long)ptr);
-	preempt_enable();
=20
 	if (mod)
 		ptr =3D dereference_module_function_descriptor(mod, ptr);
+	preempt_enable();
 #endif
 	return ptr;
 }
--=20
2.45.2

