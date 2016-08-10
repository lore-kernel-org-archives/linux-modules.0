Return-Path: <lucas.de.marchi@gmail.com>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 1/3] testsuite: include stdio.h
Date: Wed, 10 Aug 2016 15:37:11 -0300
Message-Id: <1470854233-19810-1-git-send-email-lucas.de.marchi@gmail.com>
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

It's used in the log macros so include it.
---
 testsuite/testsuite.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testsuite/testsuite.h b/testsuite/testsuite.h
index 3bd74f3..bb0eb50 100644
--- a/testsuite/testsuite.h
+++ b/testsuite/testsuite.h
@@ -19,6 +19,7 @@
 
 #include <stdbool.h>
 #include <stdarg.h>
+#include <stdio.h>
 
 #include <shared/macro.h>
 
-- 
2.7.4
