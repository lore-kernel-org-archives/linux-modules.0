Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3FC1E131B;
	Wed,  8 Jan 2025 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327118; cv=none; b=HxbUf0WS6VFTR6K51VgvCcu7rpESz/C9L6NanJOevvTkb23IEU/Z3OK+b5ZbvK6ZZzQ19vFMTVkIVYpya07+f/6Otbx3RcjjVl7OYrj/SNd6Yj5yftvnCDfheGGO6HBwNU2xUwqNcxPcpFzf7SFP7x8gNRuTo5ec0wyoYcXU6mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327118; c=relaxed/simple;
	bh=F9jM9tja/ixm4H725fMZuMP2ARoMzvTSWq/U6XJx5R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjiPzUxT3Uvlu20pibpMbuF9oVME5+4v9srA01tLUMmGOUG9/ox/+IoMaEapKv4dN4GKxZUUlAFM+ZRcftQIIvDTBT532gIxdnda79Im2uLJa9AYpRCjHOsmyJbSer9YGRFZVR8sV5YbjnsYL4+zhRRiXkMuJwvNsIo0IjAcKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fbL7PaM/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OSBg5lXo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fbL7PaM/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OSBg5lXo"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPE2aj8MMacLBet/cFcEFX/RuW9ep+ZbC89Owtm7YeQ=;
	b=fbL7PaM/jGm3qxpDrkSd+OOV7zI9CCrWhK14XQQj/sTBnt5P0YQD0RVra8HFOMFBUfOQ9o
	ZeiwMHWOi5LYUi7Di9bJgMSxMDCUW3fiwPp2judcLdfWVK23tgF678cOtYn+yVpFoN/Gms
	I7BHOMfWvtyv1WlXNjtgE8b3v2b2o9BAuH01E+17hUdm4tCDN7jwTWbpwetE+wKsYlEJdN
	v2tTEdls+9oQiny3wsLcc02lP+uZFcluG4fQMCkxJSTbRWtzCVikVgqv3E6qJmVBwzPuLc
	MgGtp/snz9ICbfa9JSaVWBETsCxx7ltqjFwZ1mEtKO1dTNwu9FmqvY5nz50DLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPE2aj8MMacLBet/cFcEFX/RuW9ep+ZbC89Owtm7YeQ=;
	b=OSBg5lXo+ufWWbp8J7i4SouYnhWhb4+QsBz5t/KMyFqT4Mz+2/cdk9gWc2IFkA4tH5UwY5
	s+fGjtoLVNIUGsAg==
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
	linuxppc-dev@lists.ozlabs.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 01/28] module: Extend the preempt disabled section in dereference_symbol_descriptor().
Date: Wed,  8 Jan 2025 10:04:30 +0100
Message-ID: <20250108090457.512198-2-bigeasy@linutronix.de>
In-Reply-To: <20250108090457.512198-1-bigeasy@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
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
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Helge Deller <deller@gmx.de>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
2.47.1

