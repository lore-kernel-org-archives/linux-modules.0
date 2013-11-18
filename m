Return-Path: <lucas.de.marchi@gmail.com>
Received: from localhost.localdomain (ip-64-134-188-214.public.wayport.net. [64.134.188.214])
        by mx.google.com with ESMTPSA id u52sm27473992yhg.5.2013.11.18.06.04.59
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2013 06:05:01 -0800 (PST)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Subject: [PATCH 2/9] util: Add cleanup attribute
Date: Mon, 18 Nov 2013 12:04:20 -0200
Message-Id: <1384783467-23476-3-git-send-email-lucas.demarchi@intel.com>
In-Reply-To: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
References: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
List-ID: <linux-modules.vger.kernel.org>

---
 libkmod/libkmod-util.h | 7 +++++++
 libkmod/macro.h        | 1 +
 2 files changed, 8 insertions(+)

diff --git a/libkmod/libkmod-util.h b/libkmod/libkmod-util.h
index 8a70aeb..bc1ed4d 100644
--- a/libkmod/libkmod-util.h
+++ b/libkmod/libkmod-util.h
@@ -3,6 +3,7 @@
 
 #include <limits.h>
 #include <stdbool.h>
+#include <stdlib.h>
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -56,3 +57,9 @@ static _always_inline_ unsigned int ALIGN_POWER2(unsigned int u)
 {
 	return 1 << ((sizeof(u) * 8) - __builtin_clz(u - 1));
 }
+
+static inline void freep(void *p) {
+        free(*(void**) p);
+}
+
+#define _cleanup_free_ _cleanup_(freep)
diff --git a/libkmod/macro.h b/libkmod/macro.h
index 7969072..5396598 100644
--- a/libkmod/macro.h
+++ b/libkmod/macro.h
@@ -57,3 +57,4 @@
 #define _printf_format_(a,b) __attribute__((format (printf, a, b)))
 #define _unused_ __attribute__((unused))
 #define _always_inline_ __inline__ __attribute__((always_inline))
+#define _cleanup_(x) __attribute__((cleanup(x)))
-- 
1.8.4.2
