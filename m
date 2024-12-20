Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B532288D0;
	Fri, 20 Dec 2024 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716869; cv=none; b=NM6emAibqNwZTfif3ejaRDkGOfkumCcPtvytELMDNRCAnMFQekwnjSwzQYt/Z8nRWL0hg7JjDI9ZiTnerNLUmKy0YP9iNlNMzx6bphXhd9rvvlVR3yZAM9qM67vNwbgGmg3QLTl4OFn/YV3I+9UMdu6ypAuJ09esiUhaOANka3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716869; c=relaxed/simple;
	bh=2XFKVoH9xoHAvUb+r6+4ArT2m6dzdDe4FeXSZTHHfAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6Xq+pUNonOZ26wIuyY4vGg+diEM/TmsyNbx1zF8bVfAAkHeTSPnR+wTpbGIfrlpc5RDHsBoVbGEaJwBPZxzGinV4z3th/agzMM9aeHaPXVkCeaz9gj/AuH155H8DjEDeqeoF4R35BN7KocJd3hRTL7hrqTXty57h82re7O8yXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iueFOBOB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3zfEw1cC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iueFOBOB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3zfEw1cC"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QN7XAVkRHsrtCJIPCdbMv/hgOMW5RUaasxW+AHUKamA=;
	b=iueFOBOBF1XA+8uZlT6Lv9AyjsTiL6mYfRPQWL+pRk00nCVY30jPfGmczFJeyxPsNr8TrF
	HUInqrtVAr+e0K2p8mFeqS1iau6HPVN252z/leAwzsAqY1yn9KG9JnPibYmAduVHQe1m6A
	aFzDtSdXGMG8DcHHn48kgXT7JUigCt3HFK1CgzzDtbKLNPtRSGsjM6xvJYRoBm+U2L5yQs
	tdKl3howaBaRxlhdBoVt8rfRBoRzGOP7Pz5tlL5ti4rChFwoXbkBMrOd3tbfPUQfWEgH5O
	67nYd0hikDwSlD+s9d5yHNrWZwKCV9ceAFccbJleK1n42s7JT8RHYRH7JWrhnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QN7XAVkRHsrtCJIPCdbMv/hgOMW5RUaasxW+AHUKamA=;
	b=3zfEw1cCyALOINESRPLlGZkpmVhFyKGekw42+llIZu3Tk89yUuP3/+OgBQekIhQ4vu50AE
	81V1KwipbF+I+wCA==
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
	Ard Biesheuvel <ardb@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 22/28] jump_label: Use RCU in all users of __module_address().
Date: Fri, 20 Dec 2024 18:41:36 +0100
Message-ID: <20241220174731.514432-23-bigeasy@linutronix.de>
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

Replace the preempt_disable() section around __module_address() with RCU.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/jump_label.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 93a822d3c468c..7fcf4017cb383 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -746,9 +746,9 @@ static int jump_label_add_module(struct module *mod)
 				kfree(jlm);
 				return -ENOMEM;
 			}
-			preempt_disable();
-			jlm2->mod =3D __module_address((unsigned long)key);
-			preempt_enable();
+			scoped_guard(rcu)
+				jlm2->mod =3D __module_address((unsigned long)key);
+
 			jlm2->entries =3D static_key_entries(key);
 			jlm2->next =3D NULL;
 			static_key_set_mod(key, jlm2);
@@ -906,13 +906,13 @@ static void jump_label_update(struct static_key *key)
 		return;
 	}
=20
-	preempt_disable();
-	mod =3D __module_address((unsigned long)key);
-	if (mod) {
-		stop =3D mod->jump_entries + mod->num_jump_entries;
-		init =3D mod->state =3D=3D MODULE_STATE_COMING;
+	scoped_guard(rcu) {
+		mod =3D __module_address((unsigned long)key);
+		if (mod) {
+			stop =3D mod->jump_entries + mod->num_jump_entries;
+			init =3D mod->state =3D=3D MODULE_STATE_COMING;
+		}
 	}
-	preempt_enable();
 #endif
 	entry =3D static_key_entries(key);
 	/* if there are no users, entry can be NULL */
--=20
2.45.2

