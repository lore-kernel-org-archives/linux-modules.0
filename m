Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D795F1392
	for <linux-modules@vger.kernel.org>; Sat,  8 Mar 2025 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741463241; cv=none; b=RkdFJ85uoPE7Cn6GgMJgpuIKFhFFaV62/eAFyhYkDQ0fmqPO2EFA7Tm/Fzfr1Mt9DaYdUllG/gYq2RMviPhQUsNG6mC7VGu/Zqk5yZiwCnwrp3xU/eGUP3+BOjLcUyy4y4t1WLr8MMThWvCkHRxBL+zd1evnFQf7CbsCpyO++nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741463241; c=relaxed/simple;
	bh=NXcByO8e5AUKQNfZRgHIJRWjXfcWfMjuacKTD2xvuVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mbmti2umvsxQ/4s2WlNG23WwH2yR7UbPRFJesill9SjAP+CrN+8OyRUndRWcwVxYxEhN1hRhCieGiMSTngXYfbcuKrpj7mSheX6t/RBX80T1IKsYOPUHtI963jF+QV7THheEHP9lzSL89Y4Q+nVv+m4MBuvAxg/Q91OCGN0kUbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xMDx7hLj; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xMDx7hLj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741463226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3QbJam/t2edM6YxRdQTQO8Mkh9a0H/CFHQLFiR8pKDg=;
	b=xMDx7hLjzCW62XQPNCxwQmRgdreKDf4XgBrfjNR71s7jS7VZHylHXIgOsGDisW8fe64yZV
	Lr/gygVpGQk5Rz3gTrrmwWFi+WRoTAZhlKpY4+tRrQ/9LShfZ1dFwXVUMpU8rOBeTNOecq
	RTZy6qid4AlonTPqkTwDUKPtNYdsxzQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: Remove unnecessary size argument when calling strscpy()
Date: Sat,  8 Mar 2025 20:46:32 +0100
Message-ID: <20250308194631.191670-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The size parameter is optional and strscpy() automatically determines
the length of the destination buffer using sizeof() if the argument is
omitted. This makes the explicit sizeof() unnecessary. Remove it to
shorten and simplify the code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/module/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1fb9ad289a6f..e690f46a7ea7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -795,8 +795,8 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	async_synchronize_full();
 
 	/* Store the name and taints of the last unloaded module for diagnostic purposes */
-	strscpy(last_unloaded_module.name, mod->name, sizeof(last_unloaded_module.name));
-	strscpy(last_unloaded_module.taints, module_flags(mod, buf, false), sizeof(last_unloaded_module.taints));
+	strscpy(last_unloaded_module.name, mod->name);
+	strscpy(last_unloaded_module.taints, module_flags(mod, buf, false));
 
 	free_module(mod);
 	/* someone could wait for the module in add_unformed_module() */
-- 
2.48.1

