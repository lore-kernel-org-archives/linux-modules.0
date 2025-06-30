Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A062283C9F
	for <linux-modules@vger.kernel.org>; Mon, 30 Jun 2025 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293275; cv=none; b=kzXjrvBFrZRfEX138HQdEC7BPktYQQ8fUFN/t++WPZitUOD1tjIhnnWYJxzCuSQ/7K0PfJcQKliCfF6iaeM+8tVN2xN6cEo428t8HqG8PuezkiXw4fnrh9DBAzcjFydiruZd4CQ1TTgMg5LGR2g5tEbL1CEX+dbgqHtnxAz8Ptk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293275; c=relaxed/simple;
	bh=tTwQjFP7H7Ve5sz5rII+oLqb+GY2UIzpGUJSSJir0uA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YYQuPCT7uYcB2GidSHmmZeGw6AK2wGNW/5FEXLTc4PkJHVjQEjiHkSEEIovmyU3fND+Ec3a+kuIYjAkuyydD2uyN4w7O3uEnDktiXF09oiUTUMgKR0/CUU4NOte+fC35tPIgePC+v6LZ7wKpaLDqsjkiYAYpeVVWrwX27ncjFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1UgUZ0ug; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=siyLMqoD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1UgUZ0ug; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=siyLMqoD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1UgUZ0ug";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="siyLMqoD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1UgUZ0ug";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="siyLMqoD"
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out2.suse.de (Postfix) with ESMTP id 235161F393
	for <linux-modules@vger.kernel.org>; Mon, 30 Jun 2025 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751293271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=oqVhvoZgJll8Km1rap2acelvANBj2O2t93CsPJai2mw=;
	b=1UgUZ0ug7K4mzpyxyn/JBrlIoeE7eiVyvySuIQ98K5Nk2R1tkzEdNuUQRTEjVqRcz02Y1J
	kGtLN07sTw5mtsRLS+b876LKiSZS7sqa0jNKQRP3/eHccn6eF39/j2ZKKbHCh/6XkqYerE
	bOPvOk1u9HxOS5aseITQrXL7MjcqE+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751293271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=oqVhvoZgJll8Km1rap2acelvANBj2O2t93CsPJai2mw=;
	b=siyLMqoDXhrXdMsc26k3Z0m8j3eTjarE/NgG7kO9RxgU9D9xsRjAWx9cNkuhhVG5jDQTTN
	z4xqBXEKmh3iEIDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751293271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=oqVhvoZgJll8Km1rap2acelvANBj2O2t93CsPJai2mw=;
	b=1UgUZ0ug7K4mzpyxyn/JBrlIoeE7eiVyvySuIQ98K5Nk2R1tkzEdNuUQRTEjVqRcz02Y1J
	kGtLN07sTw5mtsRLS+b876LKiSZS7sqa0jNKQRP3/eHccn6eF39/j2ZKKbHCh/6XkqYerE
	bOPvOk1u9HxOS5aseITQrXL7MjcqE+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751293271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=oqVhvoZgJll8Km1rap2acelvANBj2O2t93CsPJai2mw=;
	b=siyLMqoDXhrXdMsc26k3Z0m8j3eTjarE/NgG7kO9RxgU9D9xsRjAWx9cNkuhhVG5jDQTTN
	z4xqBXEKmh3iEIDw==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id 135134A05B5; Mon, 30 Jun 2025 16:21:11 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: linux-modules@vger.kernel.org
Subject: [PATCH] testsuite/init_module: Handle __NR_riscv_hwprobe in syscall
 wrapper
Date: Mon, 30 Jun 2025 16:21:11 +0200
Message-ID: <mvmms9p2tuw.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Flag: NO
X-Spam-Score: -4.20
X-Spamd-Result: default: False [-4.20 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Level: 

The libcrypto library constructor calls the riscv_hwprobe syscall through
the syscall wrapper.  Forward it to the __riscv_hwprobe function.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 testsuite/init_module.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/testsuite/init_module.c b/testsuite/init_module.c
index 8ff2699..3516c1d 100644
--- a/testsuite/init_module.c
+++ b/testsuite/init_module.c
@@ -26,6 +26,9 @@
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <sys/utsname.h>
+#ifdef __riscv
+#include <sys/hwprobe.h>
+#endif
 
 #include <shared/util.h>
 
@@ -370,6 +373,24 @@ TS_EXPORT long int syscall(long int __sysno, ...)
 		return nextlib_syscall(__NR_gettid);
 	}
 
+#ifdef __NR_riscv_hwprobe
+	if (__sysno == __NR_riscv_hwprobe) {
+		struct riscv_hwprobe *pairs;
+		size_t pair_count, cpusetsize;
+		unsigned long int *cpus;
+		unsigned int flags;
+
+		va_start (ap, __sysno);
+		pairs = va_arg (ap, struct riscv_hwprobe *);
+		pair_count = va_arg (ap, size_t);
+		cpusetsize = va_arg (ap, size_t);
+		cpus = va_arg (ap, unsigned long int *);
+		flags = va_arg (ap, unsigned int);
+
+		return __riscv_hwprobe (pairs, pair_count, cpusetsize, cpus, flags);
+	}
+#endif
+
 	/*
 	 * FIXME: no way to call the libc function due since this is a
 	 * variadic argument function and we don't have a vsyscall() variant
-- 
2.50.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
