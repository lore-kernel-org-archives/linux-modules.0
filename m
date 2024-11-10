Received: from 189.cn (ptr.189.cn [183.61.185.101])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9C3154C04;
	Sun, 10 Nov 2024 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.61.185.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731239170; cv=none; b=IJsv7VUOIaYEGyFNHuS8fDWE0IMZh0PIr8LMX4OoF0Dt8rhYpaOdUDTlHy/7vZAi65bTUGGDBsZHXM0EukhUzUUO7fvEuO/BW3L44AmpUiSUv92xq6WH6YUDEh7SwNEwjM17bHugwVveMVtyZdjO5+sDfJFy+IPLxNRzvKowYWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731239170; c=relaxed/simple;
	bh=BN3AeQJgMcYEnrFbsvnwJQ7/uGeQ5MvmLuMfSjylMWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=old/I3ac+ZidnUkbyJgOW7K8yP+qLvlVSwfwTJgWaxaYF0DEJahpPiLQOR+lwmdY4s8mcC/Qj9YVSYiQQo7Ol2qqjI/SdsrEAE73TJuZrng1Q+3z4S6VnqneU0NLlLDJHrWqUZg9LDNSSjovU3bWjhu06btxkUt7At1uHvJw8BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=183.61.185.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.243.18:27538.1421851683
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-60.25.68.92 (unknown [10.158.243.18])
	by 189.cn (HERMES) with SMTP id B03621001AF;
	Sun, 10 Nov 2024 19:42:34 +0800 (CST)
Received: from  ([60.25.68.92])
	by gateway-153622-dep-5c5f88b874-pd459 with ESMTP id e1e8ee41efcd40a5a041e6cffe3022bf for mcgrof@kernel.org;
	Sun, 10 Nov 2024 19:42:34 CST
X-Transaction-ID: e1e8ee41efcd40a5a041e6cffe3022bf
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 60.25.68.92
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
To: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	samitolvanen@google.com,
	da.gomez@samsung.com
Cc: linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Song Chen <chensong_2000@189.cn>
Subject: [PATCH] kmod: verify module name before invoking modprobe
Date: Sun, 10 Nov 2024 19:42:33 +0800
Message-Id: <20241110114233.97169-1-chensong_2000@189.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes when kernel calls request_module to load a module
into kernel space, it doesn't pass the module name appropriately,
and request_module doesn't verify it as well.

As a result, modprobe is invoked anyway and spend a lot of time
searching a nonsense name.

For example reported from a customer, he runs a user space process
to call ioctl(fd, SIOCGIFINDEX, &ifr), the callstack in kernel is
like that:
dev_ioctl(net/core/dev_iovtl.c)
  dev_load
     request_module("netdev-%s", name);
     or request_module("%s", name);

However if name of NIC is empty, neither dev_load nor request_module
checks it at the first place, modprobe will search module "netdev-"
in its default path, env path and path configured in etc for nothing,
increase a lot system overhead.

To address this problem, this patch copies va_list and introduces
a helper is_module_name_valid to verify the parameters validity
one by one, either null or empty. if it fails, no modprobe invoked.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 kernel/module/kmod.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
index 0800d9891692..161ad41b864e 100644
--- a/kernel/module/kmod.c
+++ b/kernel/module/kmod.c
@@ -113,6 +113,27 @@ static int call_modprobe(char *orig_module_name, int wait)
 	return -ENOMEM;
 }
 
+static inline bool is_module_name_valid(const char *fmt, va_list args)
+{
+	va_list args_verify;
+	bool ret = true;
+	const char *p, *arg;
+
+	va_copy(args_verify, args);
+	for (p = fmt; *p; p++) {
+		if (*p == '%' && *(++p) == 's') {
+			arg = va_arg(args_verify, const char *);
+			if (!arg || arg[0] == '\0') {
+				ret = false;
+				break;
+			}
+		}
+	}
+	va_end(args_verify);
+
+	return ret;
+}
+
 /**
  * __request_module - try to load a kernel module
  * @wait: wait (or not) for the operation to complete
@@ -147,7 +168,13 @@ int __request_module(bool wait, const char *fmt, ...)
 		return -ENOENT;
 
 	va_start(args, fmt);
-	ret = vsnprintf(module_name, MODULE_NAME_LEN, fmt, args);
+	if (is_module_name_valid(fmt, args))
+		ret = vsnprintf(module_name, MODULE_NAME_LEN, fmt, args);
+	else {
+		pr_warn_ratelimited("request_module: modprobe cannot be processed due to invalid module name");
+		va_end(args);
+		return -EINVAL;
+	}
 	va_end(args);
 	if (ret >= MODULE_NAME_LEN)
 		return -ENAMETOOLONG;
-- 
2.25.1

