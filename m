Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932780AbcKHQqS (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 8 Nov 2016 11:46:18 -0500
From: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
To: linux-modules@vger.kernel.org, lucas.demarchi@intel.com
Cc: bjorn.andersson@linaro.org, afaerber@suse.de,
        Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
Subject: [PATCH v1 1/2] testsuite: depmod: add module dependency outside cyclic chain
Date: Tue,  8 Nov 2016 17:45:49 +0100
Message-Id: <1478623550-18716-1-git-send-email-yousaf.kaukab@suse.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Check that depmod do not report modules outside cyclic chain

Two modules f and g are added which do not have any dependency.
modules a and b are made dependent on f and g.

Signed-off-by: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
---
Here is the output of loop dependency check test after adding this
patch:

ESTSUITE: ERR: wrong:
depmod: ERROR: Found 7 modules in dependency cycles!
depmod: ERROR: Cycle detected: mod_loop_d -> mod_loop_e -> mod_loop_d 
depmod: ERROR: Cycle detected: mod_loop_b -> mod_loop_c -> mod_loop_a -> mod_loop_b 
depmod: ERROR: Cycle detected: mod_loop_b -> mod_loop_c -> mod_loop_a -> mod_loop_g 
depmod: ERROR: Cycle detected: mod_loop_b -> mod_loop_c -> mod_loop_a -> mod_loop_f 

Buffer overflow occurs in the loop when last two lines are printed.
43 bytes buffer is allocated and 53 bytes are used.

 testsuite/module-playground/Makefile     |  6 +++++-
 testsuite/module-playground/mod-loop-a.c |  2 ++
 testsuite/module-playground/mod-loop-b.c |  2 ++
 testsuite/module-playground/mod-loop-f.c | 24 ++++++++++++++++++++++++
 testsuite/module-playground/mod-loop-g.c | 24 ++++++++++++++++++++++++
 testsuite/module-playground/mod-loop.h   |  2 ++
 testsuite/populate-modules.sh            |  2 ++
 7 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 testsuite/module-playground/mod-loop-f.c
 create mode 100644 testsuite/module-playground/mod-loop-g.c

diff --git a/testsuite/module-playground/Makefile b/testsuite/module-playground/Makefile
index a5f142f..bf364a9 100644
--- a/testsuite/module-playground/Makefile
+++ b/testsuite/module-playground/Makefile
@@ -12,13 +12,17 @@ obj-m += mod-foo-c.o
 obj-m += mod-foo.o
 
 # mod-loop: create loops in dependencies:
-# 1) mod-loop-a -> mod-loop-b -> mod-loop-c -> mod-loop-a
+# 1) mod-loop-a  ->  mod-loop-b -> mod-loop-c -> mod-loop-a
+#     |-> mod-loop-f    |-> mod-loop-f
+#     \-> mod-loop-g    \-> mod-loop-g
 # 2) mod-loop-d -> mod-loop-e -> mod-loop-d
 obj-m += mod-loop-a.o
 obj-m += mod-loop-b.o
 obj-m += mod-loop-c.o
 obj-m += mod-loop-d.o
 obj-m += mod-loop-e.o
+obj-m += mod-loop-f.o
+obj-m += mod-loop-g.o
 
 # mod-fake-*: fake the respective modules in kernel with these aliases. Aliases
 # list was taken from 3.5.4
diff --git a/testsuite/module-playground/mod-loop-a.c b/testsuite/module-playground/mod-loop-a.c
index e1fd0ce..e5adb49 100644
--- a/testsuite/module-playground/mod-loop-a.c
+++ b/testsuite/module-playground/mod-loop-a.c
@@ -10,6 +10,8 @@ static int __init test_module_init(void)
 {
 	printA();
 	printB();
+	printF();
+	printG();
 
 	return 0;
 }
diff --git a/testsuite/module-playground/mod-loop-b.c b/testsuite/module-playground/mod-loop-b.c
index f4490b7..26232ea 100644
--- a/testsuite/module-playground/mod-loop-b.c
+++ b/testsuite/module-playground/mod-loop-b.c
@@ -10,6 +10,8 @@ static int __init test_module_init(void)
 {
 	printB();
 	printC();
+	printF();
+	printG();
 
 	return 0;
 }
diff --git a/testsuite/module-playground/mod-loop-f.c b/testsuite/module-playground/mod-loop-f.c
new file mode 100644
index 0000000..0abb161
--- /dev/null
+++ b/testsuite/module-playground/mod-loop-f.c
@@ -0,0 +1,24 @@
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+
+#include "mod-loop.h"
+
+static int __init test_module_init(void)
+{
+	printF();
+
+	return 0;
+}
+module_init(test_module_init);
+
+void printF(void)
+{
+	pr_warn("Hello, world F\n");
+}
+EXPORT_SYMBOL(printF);
+
+MODULE_AUTHOR("Lucas De Marchi <lucas.demarchi@intel.com>");
+MODULE_LICENSE("LGPL");
diff --git a/testsuite/module-playground/mod-loop-g.c b/testsuite/module-playground/mod-loop-g.c
new file mode 100644
index 0000000..0965d76
--- /dev/null
+++ b/testsuite/module-playground/mod-loop-g.c
@@ -0,0 +1,24 @@
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+
+#include "mod-loop.h"
+
+static int __init test_module_init(void)
+{
+	printG();
+
+	return 0;
+}
+module_init(test_module_init);
+
+void printG(void)
+{
+	pr_warn("Hello, world G\n");
+}
+EXPORT_SYMBOL(printG);
+
+MODULE_AUTHOR("Lucas De Marchi <lucas.demarchi@intel.com>");
+MODULE_LICENSE("LGPL");
diff --git a/testsuite/module-playground/mod-loop.h b/testsuite/module-playground/mod-loop.h
index 3244ad9..4da3e67 100644
--- a/testsuite/module-playground/mod-loop.h
+++ b/testsuite/module-playground/mod-loop.h
@@ -5,3 +5,5 @@ void printB(void);
 void printC(void);
 void printD(void);
 void printE(void);
+void printF(void);
+void printG(void);
diff --git a/testsuite/populate-modules.sh b/testsuite/populate-modules.sh
index 409a6de..ba1f842 100755
--- a/testsuite/populate-modules.sh
+++ b/testsuite/populate-modules.sh
@@ -16,6 +16,8 @@ map=(
     ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-c.ko"]="mod-loop-c.ko"
     ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-d.ko"]="mod-loop-d.ko"
     ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-e.ko"]="mod-loop-e.ko"
+    ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-f.ko"]="mod-loop-f.ko"
+    ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-g.ko"]="mod-loop-g.ko"
     ["test-dependencies/lib/modules/4.0.20-kmod/kernel/fs/foo/"]="mod-foo-b.ko"
     ["test-dependencies/lib/modules/4.0.20-kmod/kernel/"]="mod-foo-c.ko"
     ["test-dependencies/lib/modules/4.0.20-kmod/kernel/lib/"]="mod-foo-a.ko"
-- 
1.8.5.6

