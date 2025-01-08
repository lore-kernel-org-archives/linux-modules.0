Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31491F3D46;
	Wed,  8 Jan 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327121; cv=none; b=qj6Ima8Tzu4X3lmrVZODAbxYOQvEB7thGpM1pzS1A9pdic9ohoCa8oN/DFLNMifnj+kEa+18lmUX5gmuQRrjpcLOq5LcCvptU+UUfRwM1WHViBRrS5bn4nMQ15odvDvsAYlPW05z/RzzrhUlmiEmPAEG/GooRI/6zDmVU/dJ/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327121; c=relaxed/simple;
	bh=oB83UaSp1qFOvtEHzn7IJKhNapwXigzAWoUq9jK7Ea4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmBmUPdUIQGtDHBtvCTiYfXPbQdiHOqDTMs0ZdZoFuqfds0GUxIjnnIhywHjhBAnseKBNUMlvz82hLNMwU7ToR6MpeOKAwS2U0n9RIoHAG/O/e7dOLGqxPbX2ySDU+4pA38dYMicls4jCyvTvGWmKVyh2cTSwHPGqgEFBa4WOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IErKknma; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GAgVeDmt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IErKknma";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GAgVeDmt"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8wtAHd+IQLsYzDyMqjprxSKD9xTpu50XdFLIZhS7qA=;
	b=IErKknmaTjKyf/ql5Yi7VQF+PuYgnEy+x2GQ1Cz8L/ERZ79EH18luUh06m3i0/4+zZmQuG
	W+740ujZcRgji/gtPd2zzau6hd3kQsuL41EYnQqH9ZTp3kbChzwFyu8JxJjy+7DUutgHAR
	pxOi3YROCaK4yPiU/TrPqXdMmEt2tM7i3+QcZPb1NZdoisxXWu9B+BXnBvVf+HpaTuiqEp
	jO8Ya6R2c+MAiejAGx+CbQEa19jrnnJmL4Crzl5pwUmSLlX3NLYCrLHQ0CZDRudU1x2VCe
	a/tfeKYomasIi9PPuzsA2Fx6e2SiKNk8+5X/9ljUFjCE7RGRMcQGBZt/i2XrMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8wtAHd+IQLsYzDyMqjprxSKD9xTpu50XdFLIZhS7qA=;
	b=GAgVeDmtMa9JnOOzyU3MLouTXlmfKpg+HWb0/q93SUIaGTWzuN+sutJfiPnsazTyBbCXdM
	o6j5ieribl667JBQ==
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
Subject: [PATCH v3 11/28] module: Use RCU in __is_module_percpu_address().
Date: Wed,  8 Jan 2025 10:04:40 +0100
Message-ID: <20250108090457.512198-12-bigeasy@linutronix.de>
In-Reply-To: <20250108090457.512198-1-bigeasy@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The modules list can be accessed under RCU assumption.

Use RCU protection instead preempt_disable().

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
2.47.1

