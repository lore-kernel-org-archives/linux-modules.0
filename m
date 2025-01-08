Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F31F8ADA;
	Wed,  8 Jan 2025 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327126; cv=none; b=nCHt0tLNcYkFHAoxnkdwBlzFteV1IHIRLzz7V7t6iOIV9ru2PPOF7Oujhb/CPml7JRkXjL6ax12GvFQ8lV8SudgRcDOkpBjsKWFFwYFMqtdXv+y4OCBUjvhvvko/y/qy0Grj8SNG9B3YQiauz+pxoS92KfR6R50cd6J5E78mPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327126; c=relaxed/simple;
	bh=oLOdODeMcawG2LLLnTFfjNKMo+cYM0/7nhosikokPXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLkQ3rXnieHCIaIfUozA5f9eZ9tYSa98tQSuNTDMBvxkLd+8pS7ymvgZy15zmZZNAN4bSVqNotdsDWVGaB1BnDIgpdhXJvr6KFSWAtPwyHM2k8qF2A1llLwmEwsfH/CGy09aXtwAFq+hBdDCSY0dsx0PZLdtVSrs+n72CA1SEuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T4jBf+7C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qztIvoOg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T4jBf+7C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qztIvoOg"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THX2NyChGogo3Kth4sMAsXNutUP9P3pw+jNEWRR9NrU=;
	b=T4jBf+7CrkH3J1Rd1UOzoEpqLYVQpHHS1gwCmJhR46N2jWCrkBdSbK7by7qWjt0YGhV4MM
	951PWXsNhK6EO8n/pa8ueI7le6PkxGkJ2RrULoy+bbv5xqc0QySLey5R1LMS8uO2dYInBF
	n6ixMKw2Ugku/bh7U6OvGM0wLNjYYqRSW7GaxM9F1qzQeiIGSDYuXrGaL2wkdp798LBQCg
	1uh7RkcxM7Evd7fl5k8szTkBrJ1sfYAprSyzSjYE1a+LmKGakMww09QwrcHKG0TKSAoXdw
	Eg/B2/jggwfOhWCV7S/+QqwCSlxOOD3EIGbN5XwyLj/oh+22sYTpWzVy/7i2Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THX2NyChGogo3Kth4sMAsXNutUP9P3pw+jNEWRR9NrU=;
	b=qztIvoOg4O/H0Tj/WlT2tQcGX0BI8x6o+7eiQXnGVnKGsifQNL2002sAHg44Vtvak+SAe6
	9pN1x0mwDCZt1gDw==
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
	llvm@lists.linux.dev,
	Elliot Berman <elliot.berman@oss.qualcomm.com>
Subject: [PATCH v3 21/28] cfi: Use RCU while invoking __module_address().
Date: Wed,  8 Jan 2025 10:04:50 +0100
Message-ID: <20250108090457.512198-22-bigeasy@linutronix.de>
In-Reply-To: <20250108090457.512198-1-bigeasy@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

__module_address() can be invoked within a RCU section, there is no
requirement to have preemption disabled.

The _notrace() variant was introduced in commit 14c4c8e41511a ("cfi: Use
rcu_read_{un}lock_sched_notrace"). The recursive case where
__cfi_slowpath_diag() could end up calling itself is no longer present,
as all that logic is gone since commit 89245600941e ("cfi: Switch to
-fsanitize=3Dkcfi").
Sami Tolvanen said that KCFI checks don't perform function calls.

Elliot Berman verified it with
| modprobe -a dummy_stm stm_ftrace stm_p_basic
| mkdir -p /sys/kernel/config/stp-policy/dummy_stm.0.my-policy/default
| echo function > /sys/kernel/tracing/current_tracer
| echo 1 > /sys/kernel/tracing/tracing_on
| echo dummy_stm.0 > /sys/class/stm_source/ftrace/stm_source_link

Replace the rcu_read_lock_sched_notrace() section around
__module_address() with RCU.

Cc: Elliot Berman <quic_eberman@quicinc.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: llvm@lists.linux.dev
Tested-by: Elliot Berman <elliot.berman@oss.qualcomm.com>  # sm8650-qrd
Link: https://lore.kernel.org/all/20241230185812429-0800.eberman@hu-eberman=
-lv.qualcomm.com
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/cfi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/cfi.c b/kernel/cfi.c
index 08caad7767176..abcd4d1f98eab 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -71,14 +71,11 @@ static bool is_module_cfi_trap(unsigned long addr)
 	struct module *mod;
 	bool found =3D false;
=20
-	rcu_read_lock_sched_notrace();
-
+	guard(rcu)();
 	mod =3D __module_address(addr);
 	if (mod)
 		found =3D is_trap(addr, mod->kcfi_traps, mod->kcfi_traps_end);
=20
-	rcu_read_unlock_sched_notrace();
-
 	return found;
 }
 #else /* CONFIG_MODULES */
--=20
2.47.1

