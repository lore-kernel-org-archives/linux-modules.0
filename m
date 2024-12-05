Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FC11401C;
	Thu,  5 Dec 2024 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733414767; cv=none; b=BhN8dtbyMtsLTTFRvK4R95UCwRd7ofJf/wD99c0Yslm+YVB5ozdivxN1mf9D30VqbNJYExAOmOy4Y3qMlO6AxR7H4Tl8pNXcQ3kXCkADSbmkpuisan+F1kZ0sYzf82rFDVRs2kv/T4iO32oPAoIHQulT7+q8vl8GDFGNpz0ofFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733414767; c=relaxed/simple;
	bh=/Kdl7bzreorqvX/30Ilif6NOEDW/4fhFjMEfzhYix4w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dpwBvOssp2bY/s30EIOpj3/yQnyDmjlbUzLnry6YLQXVp3xLwguTXhzcwjyQuyNwm3KGLpr4ssPhnYy8HHNYkF2SJTdw2M0V/ZG3AtJEV59jfzp98FmgmQHSoK6or9MlcQKiMqPvyF4YZuOAsRE5Y6lcTs8X2m2LY25bazueu5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RbQ8cIof; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=suAw/MWx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RbQ8cIof";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="suAw/MWx"
Date: Thu, 5 Dec 2024 17:06:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733414764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9p0B4zCa8Sp8P80zJI8PHN0Ymm/O7Rq7034IDOUSF7M=;
	b=RbQ8cIofNTFOulEHQlvzlMSfuz5lfTe7y1N08piENuJAso4CB4KTP2+vdouIiApDNgT7Po
	00LYy4vV0xzZIcrtldnpkzSLTDg1OXnkwGovx79T6PMbtm2uZOJG3fcZqYoZ5N3MA3HJvL
	XEaZutXmH3Md6UByEkScNyNEqHppAtCUkc8TqmtX5GpJVVdOtNnNCGsnEwMvayNTGOkub/
	5BYK1EKXwAvBVOI5gy7QBzE9v4Hzz8SVQVsp8m8UMfJFmIpc14KA5YUSis7hungLsgeF3s
	IFCmFxwI9CBeFwnmYSQj4lHjmSkrGe8YkFOSk58U4b9KkIs7pZe5q4WWMPE8Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733414764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9p0B4zCa8Sp8P80zJI8PHN0Ymm/O7Rq7034IDOUSF7M=;
	b=suAw/MWx1P7eIPNrbyhRrEXsPmNzpaEGmK1Bb0J6+MRB2KL1/IbSzp5w6F7vBL0BamgBG4
	nJKe/dLwTkCVQSDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Ben Segall <bsegall@google.com>, Clark Williams <clrkwllms@kernel.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] preempt: Move PREEMPT_RT before PREEMPT in vermagic.
Message-ID: <20241205160602.3lIAsJRT@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Since the dynamic preemption has been enabled for PREEMPT_RT we have now
CONFIG_PREEMPT and CONFIG_PREEMPT_RT set simultaneously. This affects
the vermagic strings which comes now PREEMPT with PREEMPT_RT enabled.

The PREEMPT_RT module usually can not be loaded on a PREEMPT kernel
because some symbols are missing.
However if the symbols are fine then it continues and it crashes later.
The problem is that the struct module has a different layout and the
num_exentries or init members are at a different position leading to a
crash later on. This is not necessary caught by the size check in
elf_validity_cache_index_mod() because the mem member has an alignment
requirement of __module_memory_align which is big enough keep the total
size unchanged. Therefore we should keep the string accurate instead of
removing it.

Move the PREEMPT_RT check before the PREEMPT so that it takes precedence
if both symbols are enabled.

Fixes: 35772d627b55c ("sched: Enable PREEMPT_DYNAMIC for PREEMPT_RT")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/vermagic.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/vermagic.h b/include/linux/vermagic.h
index a54046bf37e55..939ceabcaf06f 100644
--- a/include/linux/vermagic.h
+++ b/include/linux/vermagic.h
@@ -15,10 +15,10 @@
 #else
 #define MODULE_VERMAGIC_SMP ""
 #endif
-#ifdef CONFIG_PREEMPT_BUILD
-#define MODULE_VERMAGIC_PREEMPT "preempt "
-#elif defined(CONFIG_PREEMPT_RT)
+#ifdef CONFIG_PREEMPT_RT
 #define MODULE_VERMAGIC_PREEMPT "preempt_rt "
+#elif defined(CONFIG_PREEMPT_BUILD)
+#define MODULE_VERMAGIC_PREEMPT "preempt "
 #else
 #define MODULE_VERMAGIC_PREEMPT ""
 #endif
-- 
2.45.2

