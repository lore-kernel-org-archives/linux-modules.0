Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAFE9444
	for <linux-modules@vger.kernel.org>; Sat, 10 May 2025 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746910900; cv=none; b=umfpE1hdvPscz8NCGXnsH3LDxpiHRc3shfAHswekoeCvEeFs9KZ2S94n1mqbAOiCRJIsum8E2egOw9SJEXN/hpovG733nEprJAN5LNT10CZegW9GPKUogQWkhrwICObLX8XiGY4H4/GB8I4AAxQrHpVM/y4/nyfR/ZcxozF9tcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746910900; c=relaxed/simple;
	bh=CqyaO56/um0r7+07UnuOVscO2huajZ+XOTAMEA9PjAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HCc98RF2DXjlhCYeEVBXMvIXrb0WpWteDb7sBUBhwIYzlypeRQPtFcM0mwTZm3aDsa3QhkzOHMGEq3Z0M832N7VlINtZtCRr+0XUKEkA5uX53efHlfaVpTD8cu6MXkCEvtVXhZLHAdFWP2hhA1VraG7vDB4mYpp5r6rlyt27zMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tba9+g+h; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tba9+g+h"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746910894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SbT4EkS9jDwls1/MWPzR6fUxNMkTZUGDTe7h7TpT/ko=;
	b=Tba9+g+hj5ohfWOFe9qq5iXS40bSZ7Tj2ikBvDOSHh6Fe+fLHL18HEe/hpl+yKriILmQrn
	dtWpOGN+mFOEOG1DAXVSNqjoBpU/B0U1PVmuaU4llaGy+J7UUtpM5Aju1jpCdrxsWGXmmj
	VyKBjKpvlwL+rUHfcVW64oG6C8VyaQQ=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org
Subject: [PATCH] params: Add support for static keys
Date: Sat, 10 May 2025 17:01:26 -0400
Message-ID: <20250510210126.4032840-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Static keys can now be a module parameter, e.g.

module_param_named(foo, foo.key, static_key_t, 0644)

bcachefs is now using this.

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/jump_label.h  |  2 ++
 include/linux/moduleparam.h |  6 ++++++
 kernel/params.c             | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index fdb79dd1ebd8..0fc9b71db56f 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -107,6 +107,8 @@ struct static_key {
 #endif	/* CONFIG_JUMP_LABEL */
 };
 
+typedef struct static_key static_key_t;
+
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_JUMP_LABEL
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index bfb85fd13e1f..2494e7e67453 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -488,6 +488,12 @@ extern int param_set_bint(const char *val, const struct kernel_param *kp);
 #define param_get_bint param_get_int
 #define param_check_bint param_check_int
 
+/* A static key, which can only be set like a bool */
+extern const struct kernel_param_ops param_ops_static_key_t;
+extern int param_set_static_key_t(const char *val, const struct kernel_param *kp);
+extern int param_get_static_key_t(char *buffer, const struct kernel_param *kp);
+#define param_check_static_key_t(name, p) __param_check(name, p, struct static_key)
+
 /**
  * module_param_array - a parameter which is an array of some type
  * @name: the name of the array variable
diff --git a/kernel/params.c b/kernel/params.c
index 2509f216c9f3..991f49e138e7 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -14,6 +14,7 @@
 #include <linux/overflow.h>
 #include <linux/security.h>
 #include <linux/slab.h>
+#include <linux/static_key.h>
 #include <linux/string.h>
 
 #ifdef CONFIG_SYSFS
@@ -412,6 +413,40 @@ const struct kernel_param_ops param_ops_bint = {
 };
 EXPORT_SYMBOL(param_ops_bint);
 
+int param_set_static_key_t(const char *val, const struct kernel_param *kp)
+{
+	/* Match bool exactly, by re-using it. */
+	struct kernel_param boolkp = *kp;
+	bool v;
+	int ret;
+
+	boolkp.arg = &v;
+
+	ret = param_set_bool(val, &boolkp);
+	if (ret)
+		return ret;
+	if (v)
+		static_key_enable(kp->arg);
+	else
+		static_key_disable(kp->arg);
+	return 0;
+}
+EXPORT_SYMBOL(param_set_static_key_t);
+
+int param_get_static_key_t(char *buffer, const struct kernel_param *kp)
+{
+	struct static_key *key = kp->arg;
+	return sprintf(buffer, "%c\n", static_key_enabled(key) ? 'N' : 'Y');
+}
+EXPORT_SYMBOL(param_get_static_key_t);
+
+const struct kernel_param_ops param_ops_static_key_t = {
+	.flags = KERNEL_PARAM_OPS_FL_NOARG,
+	.set = param_set_static_key_t,
+	.get = param_get_static_key_t,
+};
+EXPORT_SYMBOL(param_ops_static_key_t);
+
 /* We break the rule and mangle the string. */
 static int param_array(struct module *mod,
 		       const char *name,
-- 
2.49.0

