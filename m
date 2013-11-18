Return-Path: <lucas.de.marchi@gmail.com>
Received: from localhost.localdomain (ip-64-134-188-214.public.wayport.net. [64.134.188.214])
        by mx.google.com with ESMTPSA id u52sm27473992yhg.5.2013.11.18.06.04.56
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2013 06:04:58 -0800 (PST)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Subject: [PATCH 1/9] testsuite: Move test-alias to test-util
Date: Mon, 18 Nov 2013 12:04:19 -0200
Message-Id: <1384783467-23476-2-git-send-email-lucas.demarchi@intel.com>
In-Reply-To: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
References: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
List-ID: <linux-modules.vger.kernel.org>

Move file so we can use the same file to test other functions from
libkmod-util.c
---
 Makefile.am                                        |  6 +-
 testsuite/.gitignore                               |  6 +-
 testsuite/rootfs-pristine/test-alias/correct.txt   | 25 --------
 .../rootfs-pristine/test-util/alias-correct.txt    | 25 ++++++++
 testsuite/test-alias.c                             | 75 ----------------------
 testsuite/test-util.c                              | 75 ++++++++++++++++++++++
 6 files changed, 106 insertions(+), 106 deletions(-)
 delete mode 100644 testsuite/rootfs-pristine/test-alias/correct.txt
 create mode 100644 testsuite/rootfs-pristine/test-util/alias-correct.txt
 delete mode 100644 testsuite/test-alias.c
 create mode 100644 testsuite/test-util.c

diff --git a/Makefile.am b/Makefile.am
index 1c1e5f7..bdf758e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -176,7 +176,7 @@ testsuite_libtestsuite_la_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
 testsuite_libtestsuite_la_LIBADD = -lrt
 
 TESTSUITE = testsuite/test-init testsuite/test-testsuite testsuite/test-loaded \
-	    testsuite/test-modinfo testsuite/test-alias testsuite/test-new-module \
+	    testsuite/test-modinfo testsuite/test-util testsuite/test-new-module \
 	    testsuite/test-modprobe testsuite/test-blacklist \
 	    testsuite/test-dependencies testsuite/test-depmod
 
@@ -191,8 +191,8 @@ testsuite_test_loaded_LDADD = $(TESTSUITE_LDADD)
 testsuite_test_loaded_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
 testsuite_test_modinfo_LDADD = $(TESTSUITE_LDADD)
 testsuite_test_modinfo_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
-testsuite_test_alias_LDADD = $(TESTSUITE_LDADD)
-testsuite_test_alias_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
+testsuite_test_util_LDADD = $(TESTSUITE_LDADD)
+testsuite_test_util_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
 testsuite_test_new_module_LDADD = $(TESTSUITE_LDADD)
 testsuite_test_new_module_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
 testsuite_test_modprobe_LDADD = $(TESTSUITE_LDADD)
diff --git a/testsuite/.gitignore b/testsuite/.gitignore
index 71f34cc..bd26a40 100644
--- a/testsuite/.gitignore
+++ b/testsuite/.gitignore
@@ -2,7 +2,7 @@
 *.la
 *.so
 /.dirstamp
-/test-alias
+/test-util
 /test-blacklist
 /test-dependencies
 /test-depmod
@@ -14,8 +14,8 @@
 /test-modprobe
 /rootfs
 /stamp-rootfs
-/test-alias.log
-/test-alias.trs
+/test-util.log
+/test-util.trs
 /test-blacklist.log
 /test-blacklist.trs
 /test-dependencies.log
diff --git a/testsuite/rootfs-pristine/test-alias/correct.txt b/testsuite/rootfs-pristine/test-alias/correct.txt
deleted file mode 100644
index 86d0304..0000000
--- a/testsuite/rootfs-pristine/test-alias/correct.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-input   test1234
-return  0
-len     8
-output  test1234
-
-input   test[abcfoobar]2211
-return  0
-len     19
-output  test[abcfoobar]2211
-
-input   bar[aaa][bbbb]sss
-return  0
-len     17
-output  bar[aaa][bbbb]sss
-
-input   kmod[p.b]lib
-return  0
-len     12
-output  kmod[p.b]lib
-
-input   [az]1234[AZ]
-return  0
-len     12
-output  [az]1234[AZ]
-
diff --git a/testsuite/rootfs-pristine/test-util/alias-correct.txt b/testsuite/rootfs-pristine/test-util/alias-correct.txt
new file mode 100644
index 0000000..86d0304
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-util/alias-correct.txt
@@ -0,0 +1,25 @@
+input   test1234
+return  0
+len     8
+output  test1234
+
+input   test[abcfoobar]2211
+return  0
+len     19
+output  test[abcfoobar]2211
+
+input   bar[aaa][bbbb]sss
+return  0
+len     17
+output  bar[aaa][bbbb]sss
+
+input   kmod[p.b]lib
+return  0
+len     12
+output  kmod[p.b]lib
+
+input   [az]1234[AZ]
+return  0
+len     12
+output  [az]1234[AZ]
+
diff --git a/testsuite/test-alias.c b/testsuite/test-alias.c
deleted file mode 100644
index 4d1d8d3..0000000
--- a/testsuite/test-alias.c
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
- * Copyright (C) 2012-2013  ProFUSION embedded systems
- * Copyright (C) 2012  Pedro Pedruzzi
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <libkmod.h>
-
-#include "libkmod-util.h"
-#include "testsuite.h"
-
-static int alias_1(const struct test *t)
-{
-	static const char *input[] = {
-		"test1234",
-		"test[abcfoobar]2211",
-		"bar[aaa][bbbb]sss",
-		"kmod[p.b]lib",
-		"[az]1234[AZ]",
-		NULL,
-	};
-
-	char buf[PATH_MAX];
-	size_t len;
-	const char **alias;
-
-	for (alias = input; *alias != NULL; alias++) {
-		int ret;
-
-		ret = alias_normalize(*alias, buf, &len);
-		printf("input   %s\n", *alias);
-		printf("return  %d\n", ret);
-
-		if (ret == 0) {
-			printf("len     %zu\n", len);
-			printf("output  %s\n", buf);
-		}
-
-		printf("\n");
-	}
-
-	return EXIT_SUCCESS;
-}
-static DEFINE_TEST(alias_1,
-	.description = "check if alias_normalize does the right thing",
-	.config = {
-		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-alias/",
-	},
-	.need_spawn = true,
-	.output = {
-		.out = TESTSUITE_ROOTFS "test-alias/correct.txt",
-	});
-
-static const struct test *tests[] = {
-	&salias_1,
-	NULL,
-};
-
-TESTSUITE_MAIN(tests);
diff --git a/testsuite/test-util.c b/testsuite/test-util.c
new file mode 100644
index 0000000..db9f134
--- /dev/null
+++ b/testsuite/test-util.c
@@ -0,0 +1,75 @@
+/*
+ * Copyright (C) 2012-2013  ProFUSION embedded systems
+ * Copyright (C) 2012  Pedro Pedruzzi
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <libkmod.h>
+
+#include "libkmod-util.h"
+#include "testsuite.h"
+
+static int alias_1(const struct test *t)
+{
+	static const char *input[] = {
+		"test1234",
+		"test[abcfoobar]2211",
+		"bar[aaa][bbbb]sss",
+		"kmod[p.b]lib",
+		"[az]1234[AZ]",
+		NULL,
+	};
+
+	char buf[PATH_MAX];
+	size_t len;
+	const char **alias;
+
+	for (alias = input; *alias != NULL; alias++) {
+		int ret;
+
+		ret = alias_normalize(*alias, buf, &len);
+		printf("input   %s\n", *alias);
+		printf("return  %d\n", ret);
+
+		if (ret == 0) {
+			printf("len     %zu\n", len);
+			printf("output  %s\n", buf);
+		}
+
+		printf("\n");
+	}
+
+	return EXIT_SUCCESS;
+}
+static DEFINE_TEST(alias_1,
+	.description = "check if alias_normalize does the right thing",
+	.config = {
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-util/",
+	},
+	.need_spawn = true,
+	.output = {
+		.out = TESTSUITE_ROOTFS "test-util/alias-correct.txt",
+	});
+
+static const struct test *tests[] = {
+	&salias_1,
+	NULL,
+};
+
+TESTSUITE_MAIN(tests);
-- 
1.8.4.2
