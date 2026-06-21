Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B91A6836
	for <linux-modules@vger.kernel.org>; Sun, 21 Jun 2026 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782030175; cv=none; b=NnXg4N56TXccfC+Mz0WgaekY/bL4oQBjlYp8+JubXG+dn1YHhGtSlo1/mKCVceXZs9fu7sMfnMWZlginAf4kGvsUeKYZzMsUDV276Zc7CFCe4s/mGD0aVDy24pPRXgXTKu8kjyn2t8szjxAlRhmwDml3hK3GS908V7EepJVBrIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782030175; c=relaxed/simple;
	bh=HwZDFRYhekAFC6O8jGYRm4l0NSTEOoonAEDkXDMKgBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BwkJ/QpuMSbVm1ZrnpRKkBzSMwRfblyPj2xCK5oj8LTbJaovmIRMt3JY+aEJ4WSYzMIKAvAOK2UlDnmyV2FBeSYClbtyFis9KJtlonPse/6IeHqnNIZ1rtzpiCkQVTxnX/2N4AOUQI37W+MnyLS2tyHiVHdB/eqQuIFNkcrvLGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PL5/xXuj; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PL5/xXuj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782030171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hs8TnimAe5SQuVayEUvZngs+IWFN84cQD4SjKS99LKk=;
	b=PL5/xXujgVrkdNrX6ovnuUFVsaoqG9vPZQgzh3ZQYIUgTCG3pJW8HW3bbFjeGbddpnWwPl
	gUCX5YYO9a9q1EPxHB8c5bi76V0nLNOAUMaQoO4MuBQ6dqN5fz39qpcx2+xrMapHXfQupg
	FFIgXJZOHcHzXKzVtzuK1S+LUi118p4=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	atomlin@atomlin.com,
	rdunlap@infradead.org,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH] params: fix path of /sys/module/XYZ/parameters/ in comment
Date: Sun, 21 Jun 2026 16:22:23 +0800
Message-ID: <20260621082223.11439-1-zenghui.yu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The comment wrongly references to /sys/modules/XYZ/parameters/ directory
instead of /sys/module/XYZ/parameters/. Fix it.

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---

kernel/params.c is not covered by any MAINTAINERS entry. I assume it should
be a "MODULE SUPPORT" stuff?

 kernel/params.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/params.c b/kernel/params.c
index a668863a4bb6..3456b104efc9 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -538,7 +538,7 @@ const struct kernel_param_ops param_ops_string = {
 };
 EXPORT_SYMBOL(param_ops_string);
 
-/* sysfs output in /sys/modules/XYZ/parameters/ */
+/* sysfs output in /sys/module/XYZ/parameters/ */
 #define to_module_attr(n) container_of_const(n, struct module_attribute, attr)
 #define to_module_kobject(n) container_of(n, struct module_kobject, kobj)
 
-- 
2.53.0

