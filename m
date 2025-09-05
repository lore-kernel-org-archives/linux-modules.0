Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2CC31D746;
	Fri,  5 Sep 2025 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087209; cv=none; b=Nrm5QUZv8ava00OCZ/OfuSh8JknmiMeS/uq/hT3jYETvnRYs12Tu5JFmuypAyk+LRBYiudcbjKST4ClQ6xH/xZPS+/SSbUzqiW7xFASXRNqJSnnzkioYyLE+0DOd4YQWVEBT2NWzKy4+0VqQ3chUx6BxHzOLJ3wRX55LZOVloKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087209; c=relaxed/simple;
	bh=WgrxH3lG2+fvh6S9Kworr7I4wyXCwAYVcDzvGNGNtZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nlAhQiERiM3vjC6e4FQf12sEJhdq6kxyOQpWvkd+ZwXrVUo6ER4C/gNANpB5BuNRErsaLIDbuLTRWGOl3n1xO2waEMtkeqlUB9fTcescz8TxY0xyv0IUK/+Hkw8yD33iVSSceSgssoXuR6AYbcHPhSGjjQ/NAcRdx6JHrg0y0uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Plb916g7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plb916g7"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso15637145e9.2;
        Fri, 05 Sep 2025 08:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757087205; x=1757692005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yM/kpsrWuS7EbRNYLGZUP0tAA7bvvftiQ6cg5jjOdtc=;
        b=Plb916g7CIXX2CCCE09x7vNm67VC5qT36xSoPJfDmvQbKzxH76uj5M4ILWSMwS8r+W
         KDinP34O35hpZDC4kzLdBTKRprPefzsiByAka1OOrv9GmwIz7UBYQeEHOYkujVKDVYpi
         N5cAYINWh4NidDI1dJ408PJvKhNIQQBRo0awVLyKaK6Isd060TrnzGyzyVgqtD2J9cKh
         WYZplwyxjKoxje2uYgzgcs8EKbNdNsO/eT6JM7YRQPjhs6t3WSoLK8aoCHHQXtUrsbmS
         ifjVZXfkMy7/NCfFQkDadkhjDIzfD4GogkJZ+bcnC1pAChN0tvan67CWGoSX97WrLyBU
         1ONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757087205; x=1757692005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yM/kpsrWuS7EbRNYLGZUP0tAA7bvvftiQ6cg5jjOdtc=;
        b=mnHbZrO0gJniQo+lB+WNYiXo5kF7dvtbzIDZRrbo1OAnx5cZP3g4nXTi4ew5gDk3mq
         vTMIH/8/H/AcLvssXtoUwkpdZxjNxpIkWIKfMBEJWRx58nJt1szjnJMliLNMxCASe7Ot
         2vp1yleFkpXhtsNhRKnkDBTzoELcHZxZ+Fco0DpBRSd5EjiG0Z1g4g1HoNE5Ufwhu/IS
         wb21eBnL0x4TBEjohdPkzchRebHbxToxKyvEsJAP0F3J/aarEE9eYAVDWSJOghTw2III
         eaqXUfLGjkk+HNPI981YrcHnw7aB9NXaB+Gxgh2djozA8eZA+687Fat6wfXgqwWylGWR
         3kcw==
X-Forwarded-Encrypted: i=1; AJvYcCWk2MHRhBbvS48LG4aIgUFOP36LgPzXWsaNaeAfOvvGvdfxAYNMQOTmF4LZ0IFuWE834crlwwgpwjzwj9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwitQX4e+AFdvqls2idroHYEt2qAjxpSWT4V0hMxQmQrf7Am6Lj
	l65ve7NwOjpx01Fnpphedrrhc98Y9OxflRKDnCPIPHHL3sgIVI1681F9RdmsjhPF5ktXLQ==
X-Gm-Gg: ASbGnctTtZwRHpwk16qWOyoQijvb5EcUBzKIV3CsbvUVierrfAwxXHbvcpSEHcoYeKD
	vUeujV31UD0Kg8rH9LxDClZwCCUXYUasrQC3EBpg+Giv8IsdGHx7iOMqjxtdNo2/hHhMnTOnGqf
	e9T+cgXRy2NjwjOW7Oh+zetBLHMZyZK1EJfYGbKeJ0TgoGMYgQtWwmxCNIns6LzKbeQ/KXU7Xke
	a4xr7mXoS9pVZqwf9GHFepIR2ytrOoKOU3vXXA5BiDXDJceyHsUaDfb66zqVmnqySLHQ6pJnddp
	jUyyvUXpTy8Bk8miZj+QSKrtVqB8XGrMvawD8h1PAjrsHCKjEMwIdn9MQONMfSBGdtD1dPn3XhL
	th3KvSUceyIrFbBKDnj9m7M9H03w=
X-Google-Smtp-Source: AGHT+IF2rT1+TS5L9oKcWYnx9bd3WcpTH0tQRr6+IS6eToCzikMbl21hDow2X6nBhwzcyUfhn3BhiA==
X-Received: by 2002:a05:600c:5492:b0:45b:9a7b:66ba with SMTP id 5b1f17b1804b1-45b9a7b67ffmr115538645e9.14.1757087204394;
        Fri, 05 Sep 2025 08:46:44 -0700 (PDT)
Received: from Al-Qamar ([2a00:f29:348:d0f:44dd:9238:4455:2174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fc3fasm31472842f8f.5.2025.09.05.08.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:46:43 -0700 (PDT)
From: Fidal Palamparambil <rootuserhere@gmail.com>
To: linux-modules@vger.kernel.org
Cc: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	linux-kernel@vger.kernel.org,
	Fidal palamparambil <rootuserhere@gmail.com>
Subject: [PATCH] module : fix signature checker pointer arithmetic and bounds check
Date: Fri,  5 Sep 2025 19:45:49 +0400
Message-ID: <20250905154550.130-1-rootuserhere@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Fidal palamparambil <rootuserhere@gmail.com>

This patch fixes :
 - invalid module_param type (bool_enable_only → bool)
 - unsafe pointer arithmetic on void *
 - missing bounds check for sig_len, preventing underflow/OOB
 - export set_module_sig_enforced for consistency

Signed-off-by : Fidal Palamparambil <rootuserhere@gmail.com>
Signed-off-by: Fidal palamparambil <rootuserhere@gmail.com>
---
 kernel/module/signing.c    |  48 ++++++++------
 kernel/module/signing.orig | 125 +++++++++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+), 18 deletions(-)
 create mode 100644 kernel/module/signing.orig

diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index a2ff4242e623..8dda6cd2fd73 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* Module signature checker
+/*
+ * Module signature checker
  *
  * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
@@ -20,11 +21,11 @@
 #define MODULE_PARAM_PREFIX "module."
 
 static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
-module_param(sig_enforce, bool_enable_only, 0644);
+module_param(sig_enforce, bool, 0644);
 
 /*
- * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
- * on that instead of directly to CONFIG_MODULE_SIG_FORCE config.
+ * Export sig_enforce kernel cmdline parameter to allow other subsystems to
+ * rely on that instead of directly on CONFIG_MODULE_SIG_FORCE config.
  */
 bool is_module_sig_enforced(void)
 {
@@ -36,6 +37,7 @@ void set_module_sig_enforced(void)
 {
 	sig_enforce = true;
 }
+EXPORT_SYMBOL(set_module_sig_enforced);
 
 /*
  * Verify the signature on a module.
@@ -45,44 +47,55 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 	struct module_signature ms;
 	size_t sig_len, modlen = info->len;
 	int ret;
+	const unsigned char *data = mod;
 
 	pr_devel("==>%s(,%zu)\n", __func__, modlen);
 
 	if (modlen <= sizeof(ms))
 		return -EBADMSG;
 
-	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
+	memcpy(&ms, data + (modlen - sizeof(ms)), sizeof(ms));
 
 	ret = mod_check_sig(&ms, modlen, "module");
 	if (ret)
 		return ret;
 
 	sig_len = be32_to_cpu(ms.sig_len);
+
+	/* Ensure sig_len is valid to prevent underflow/oob */
+	if (sig_len > modlen - sizeof(ms))
+		return -EBADMSG;
+
 	modlen -= sig_len + sizeof(ms);
 	info->len = modlen;
 
-	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
+	return verify_pkcs7_signature(data, modlen, data + modlen, sig_len,
 				      VERIFY_USE_SECONDARY_KEYRING,
 				      VERIFYING_MODULE_SIGNATURE,
 				      NULL, NULL);
 }
 
+/*
+ * Check signature validity of a module during load.
+ */
 int module_sig_check(struct load_info *info, int flags)
 {
 	int err = -ENODATA;
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
 	const char *reason;
-	const void *mod = info->hdr;
+	const unsigned char *mod = info->hdr;
 	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
 				       MODULE_INIT_IGNORE_VERMAGIC);
+
 	/*
-	 * Do not allow mangled modules as a module with version information
-	 * removed is no longer the module that was signed.
+	 * Do not allow mangled modules: a module with version info removed
+	 * is no longer the module that was signed.
 	 */
 	if (!mangled_module &&
 	    info->len > markerlen &&
-	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
-		/* We truncate the module to discard the signature */
+	    memcmp(mod + info->len - markerlen,
+		   MODULE_SIG_STRING, markerlen) == 0) {
+		/* Truncate the module to discard the signature marker */
 		info->len -= markerlen;
 		err = mod_verify_sig(mod, info);
 		if (!err) {
@@ -92,9 +105,8 @@ int module_sig_check(struct load_info *info, int flags)
 	}
 
 	/*
-	 * We don't permit modules to be loaded into the trusted kernels
-	 * without a valid signature on them, but if we're not enforcing,
-	 * certain errors are non-fatal.
+	 * Enforced mode: only allow modules with a valid signature.
+	 * Non-enforced mode: certain errors are downgraded to warnings.
 	 */
 	switch (err) {
 	case -ENODATA:
@@ -106,12 +118,12 @@ int module_sig_check(struct load_info *info, int flags)
 	case -ENOKEY:
 		reason = "module with unavailable key";
 		break;
-
 	default:
 		/*
-		 * All other errors are fatal, including lack of memory,
-		 * unparseable signatures, and signature check failures --
-		 * even if signatures aren't required.
+		 * All other errors are fatal, including:
+		 * - OOM
+		 * - unparseable signatures
+		 * - invalid signature failures
 		 */
 		return err;
 	}
diff --git a/kernel/module/signing.orig b/kernel/module/signing.orig
new file mode 100644
index 000000000000..a2ff4242e623
--- /dev/null
+++ b/kernel/module/signing.orig
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Module signature checker
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/module_signature.h>
+#include <linux/string.h>
+#include <linux/verification.h>
+#include <linux/security.h>
+#include <crypto/public_key.h>
+#include <uapi/linux/module.h>
+#include "internal.h"
+
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "module."
+
+static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
+module_param(sig_enforce, bool_enable_only, 0644);
+
+/*
+ * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
+ * on that instead of directly to CONFIG_MODULE_SIG_FORCE config.
+ */
+bool is_module_sig_enforced(void)
+{
+	return sig_enforce;
+}
+EXPORT_SYMBOL(is_module_sig_enforced);
+
+void set_module_sig_enforced(void)
+{
+	sig_enforce = true;
+}
+
+/*
+ * Verify the signature on a module.
+ */
+int mod_verify_sig(const void *mod, struct load_info *info)
+{
+	struct module_signature ms;
+	size_t sig_len, modlen = info->len;
+	int ret;
+
+	pr_devel("==>%s(,%zu)\n", __func__, modlen);
+
+	if (modlen <= sizeof(ms))
+		return -EBADMSG;
+
+	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
+
+	ret = mod_check_sig(&ms, modlen, "module");
+	if (ret)
+		return ret;
+
+	sig_len = be32_to_cpu(ms.sig_len);
+	modlen -= sig_len + sizeof(ms);
+	info->len = modlen;
+
+	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
+				      VERIFY_USE_SECONDARY_KEYRING,
+				      VERIFYING_MODULE_SIGNATURE,
+				      NULL, NULL);
+}
+
+int module_sig_check(struct load_info *info, int flags)
+{
+	int err = -ENODATA;
+	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	const char *reason;
+	const void *mod = info->hdr;
+	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
+				       MODULE_INIT_IGNORE_VERMAGIC);
+	/*
+	 * Do not allow mangled modules as a module with version information
+	 * removed is no longer the module that was signed.
+	 */
+	if (!mangled_module &&
+	    info->len > markerlen &&
+	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
+		/* We truncate the module to discard the signature */
+		info->len -= markerlen;
+		err = mod_verify_sig(mod, info);
+		if (!err) {
+			info->sig_ok = true;
+			return 0;
+		}
+	}
+
+	/*
+	 * We don't permit modules to be loaded into the trusted kernels
+	 * without a valid signature on them, but if we're not enforcing,
+	 * certain errors are non-fatal.
+	 */
+	switch (err) {
+	case -ENODATA:
+		reason = "unsigned module";
+		break;
+	case -ENOPKG:
+		reason = "module with unsupported crypto";
+		break;
+	case -ENOKEY:
+		reason = "module with unavailable key";
+		break;
+
+	default:
+		/*
+		 * All other errors are fatal, including lack of memory,
+		 * unparseable signatures, and signature check failures --
+		 * even if signatures aren't required.
+		 */
+		return err;
+	}
+
+	if (is_module_sig_enforced()) {
+		pr_notice("Loading of %s is rejected\n", reason);
+		return -EKEYREJECTED;
+	}
+
+	return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
+}
-- 
2.50.1.windows.1

