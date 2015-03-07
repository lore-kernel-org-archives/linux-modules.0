Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:59323 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109AbbCGNdI (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Sat, 7 Mar 2015 08:33:08 -0500
From: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
To: <linux-modules@vger.kernel.org>
Subject: [PATCH] tools: add basic versions of insert and remove
Date: Sat, 7 Mar 2015 10:32:53 -0300
Message-ID: <1425735173-24181-1-git-send-email-caio.oliveira@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

---

Differences from v1:

* Added updated copyright to insert.c, remove.c. Added license and
  copyright to test-tools.c.

* Rewrote error handling in insert to ensure EXIT_FAILURE will be
  returned if any of the modules fail to load.

* Minor style fixes.

 Makefile.am                                        |   7 +-
 testsuite/.gitignore                               |   3 +
 testsuite/populate-modules.sh                      |   2 +
 .../insert/lib/modules/4.4.4/modules.alias         |   1 +
 .../insert/lib/modules/4.4.4/modules.alias.bin     | Bin 0 -> 12 bytes
 .../insert/lib/modules/4.4.4/modules.builtin       |   0
 .../insert/lib/modules/4.4.4/modules.builtin.bin   | Bin 0 -> 12 bytes
 .../insert/lib/modules/4.4.4/modules.dep           |   1 +
 .../insert/lib/modules/4.4.4/modules.dep.bin       | Bin 0 -> 58 bytes
 .../insert/lib/modules/4.4.4/modules.devname       |   1 +
 .../insert/lib/modules/4.4.4/modules.order         |   0
 .../insert/lib/modules/4.4.4/modules.softdep       |   1 +
 .../insert/lib/modules/4.4.4/modules.symbols       |   1 +
 .../insert/lib/modules/4.4.4/modules.symbols.bin   | Bin 0 -> 12 bytes
 .../remove/lib/modules/4.4.4/modules.alias         |   1 +
 .../remove/lib/modules/4.4.4/modules.alias.bin     | Bin 0 -> 12 bytes
 .../remove/lib/modules/4.4.4/modules.builtin       |   0
 .../remove/lib/modules/4.4.4/modules.builtin.bin   | Bin 0 -> 12 bytes
 .../remove/lib/modules/4.4.4/modules.dep           |   1 +
 .../remove/lib/modules/4.4.4/modules.dep.bin       | Bin 0 -> 58 bytes
 .../remove/lib/modules/4.4.4/modules.devname       |   1 +
 .../remove/lib/modules/4.4.4/modules.order         |   0
 .../remove/lib/modules/4.4.4/modules.softdep       |   1 +
 .../remove/lib/modules/4.4.4/modules.symbols       |   1 +
 .../remove/lib/modules/4.4.4/modules.symbols.bin   | Bin 0 -> 12 bytes
 .../sys/module/mod_simple/holders/.gitignore       |   0
 .../remove/sys/module/mod_simple/initstate         |   1 +
 .../test-tools/remove/sys/module/mod_simple/refcnt |   1 +
 testsuite/test-tools.c                             |  71 ++++++++++
 tools/insert.c                                     | 128 ++++++++++++++++++
 tools/kmod.c                                       |   2 +
 tools/kmod.h                                       |   2 +
 tools/remove.c                                     | 150 +++++++++++++++++++++
 33 files changed, 376 insertions(+), 1 deletion(-)
 create mode 100644 testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.builtin
 create mode 100644 testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.order
 create mode 100644 testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.symbols.bin
 create mode 100644 testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.builtin
 create mode 100644 testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.order
 create mode 100644 testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.symbols.bin
 create mode 100644 testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/holders/.gitignore
 create mode 100644 testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/initstate
 create mode 100644 testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/refcnt
 create mode 100644 testsuite/test-tools.c
 create mode 100644 tools/insert.c
 create mode 100644 tools/remove.c

diff --git a/Makefile.am b/Makefile.am
index d9da17d..caf18b6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -126,6 +126,8 @@ tools_kmod_SOURCES = \
 	tools/rmmod.c tools/insmod.c \
 	tools/modinfo.c tools/modprobe.c \
 	tools/depmod.c tools/log.h tools/log.c \
+	tools/insert.c \
+	tools/remove.c \
 	tools/static-nodes.c
 tools_kmod_LDADD = \
 	shared/libshared.la \
@@ -315,7 +317,8 @@ TESTSUITE = \
 	testsuite/test-modinfo testsuite/test-util testsuite/test-new-module \
 	testsuite/test-modprobe testsuite/test-blacklist \
 	testsuite/test-dependencies testsuite/test-depmod \
-	testsuite/test-list
+	testsuite/test-list \
+	testsuite/test-tools
 
 check_PROGRAMS = $(TESTSUITE)
 TESTS = $(TESTSUITE)
@@ -355,6 +358,8 @@ testsuite_test_depmod_LDADD = $(TESTSUITE_LDADD)
 testsuite_test_depmod_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
 testsuite_test_list_LDADD = $(TESTSUITE_LDADD)
 testsuite_test_list_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
+testsuite_test_tools_LDADD = $(TESTSUITE_LDADD)
+testsuite_test_tools_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
 
 testsuite-distclean:
 	$(RM) -r $(ROOTFS)
diff --git a/testsuite/.gitignore b/testsuite/.gitignore
index 09f231c..2b71a47 100644
--- a/testsuite/.gitignore
+++ b/testsuite/.gitignore
@@ -17,6 +17,7 @@
 /test-modprobe
 /test-hash
 /test-list
+/test-tools
 /rootfs
 /stamp-rootfs
 /test-strbuf.log
@@ -49,3 +50,5 @@
 /test-testsuite.trs
 /test-list.log
 /test-list.trs
+/test-tools.log
+/test-tools.trs
diff --git a/testsuite/populate-modules.sh b/testsuite/populate-modules.sh
index 43fb834..409a6de 100755
--- a/testsuite/populate-modules.sh
+++ b/testsuite/populate-modules.sh
@@ -42,6 +42,8 @@ map=(
     ["test-modinfo/mod-simple-sparc64.ko"]="mod-simple-sparc64.ko"
     ["test-modinfo/mod-simple-sha1.ko"]="mod-simple.ko"
     ["test-modinfo/mod-simple-sha256.ko"]="mod-simple.ko"
+    ["test-tools/insert/lib/modules/4.4.4/kernel/"]="mod-simple.ko"
+    ["test-tools/remove/lib/modules/4.4.4/kernel/"]="mod-simple.ko"
 )
 
 gzip_array=(
diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.alias b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.alias
new file mode 100644
index 0000000..ba76e18
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.alias
@@ -0,0 +1 @@
+# Aliases extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.alias.bin b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.alias.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.builtin b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.builtin
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.builtin.bin b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.builtin.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.dep b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.dep
new file mode 100644
index 0000000..5476653
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.dep
@@ -0,0 +1 @@
+kernel/mod-simple.ko:
diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.dep.bin b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.dep.bin
new file mode 100644
index 0000000000000000000000000000000000000000..b09a85432309c43f99500d6cc3473bcb1ef0a80e
GIT binary patch
literal 58
zcmdnM{w17&iGfjpfx#p{CB8T_w;(5#0SFjDM0RRXUTThhZhnd`L`E+=--;nO_W%O}
F4*<8l52gSB

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.devname b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.devname
new file mode 100644
index 0000000..58f6d6d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.devname
@@ -0,0 +1 @@
+# Device nodes to trigger on-demand module loading.
diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.order b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.order
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.softdep b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.softdep
new file mode 100644
index 0000000..5554ccc
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.softdep
@@ -0,0 +1 @@
+# Soft dependencies extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.symbols b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.symbols
new file mode 100644
index 0000000..618c345
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.symbols
@@ -0,0 +1 @@
+# Aliases for symbols, used by symbol_request().
diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.symbols.bin b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.symbols.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.alias b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.alias
new file mode 100644
index 0000000..ba76e18
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.alias
@@ -0,0 +1 @@
+# Aliases extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.alias.bin b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.alias.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.builtin b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.builtin
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.builtin.bin b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.builtin.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.dep b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.dep
new file mode 100644
index 0000000..5476653
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.dep
@@ -0,0 +1 @@
+kernel/mod-simple.ko:
diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.dep.bin b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.dep.bin
new file mode 100644
index 0000000000000000000000000000000000000000..b09a85432309c43f99500d6cc3473bcb1ef0a80e
GIT binary patch
literal 58
zcmdnM{w17&iGfjpfx#p{CB8T_w;(5#0SFjDM0RRXUTThhZhnd`L`E+=--;nO_W%O}
F4*<8l52gSB

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.devname b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.devname
new file mode 100644
index 0000000..58f6d6d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.devname
@@ -0,0 +1 @@
+# Device nodes to trigger on-demand module loading.
diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.order b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.order
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.softdep b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.softdep
new file mode 100644
index 0000000..5554ccc
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.softdep
@@ -0,0 +1 @@
+# Soft dependencies extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.symbols b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.symbols
new file mode 100644
index 0000000..618c345
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.symbols
@@ -0,0 +1 @@
+# Aliases for symbols, used by symbol_request().
diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.symbols.bin b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.symbols.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/holders/.gitignore b/testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/holders/.gitignore
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/initstate b/testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/initstate
new file mode 100644
index 0000000..e23fe64
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/initstate
@@ -0,0 +1 @@
+live
diff --git a/testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/refcnt b/testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/refcnt
new file mode 100644
index 0000000..573541a
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/refcnt
@@ -0,0 +1 @@
+0
diff --git a/testsuite/test-tools.c b/testsuite/test-tools.c
new file mode 100644
index 0000000..4a9ee9b
--- /dev/null
+++ b/testsuite/test-tools.c
@@ -0,0 +1,71 @@
+/*
+ * Copyright (C) 2015 Intel Corporation. All rights reserved.
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
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "testsuite.h"
+
+static noreturn int kmod_tool_insert(const struct test *t)
+{
+	const char *progname = ABS_TOP_BUILDDIR "/tools/kmod";
+	const char *const args[] = {
+		progname,
+		"insert", "mod-simple",
+		NULL,
+	};
+
+	test_spawn_prog(progname, args);
+	exit(EXIT_FAILURE);
+}
+DEFINE_TEST(kmod_tool_insert,
+	.description = "check kmod insert",
+	.config = {
+		[TC_UNAME_R] = "4.4.4",
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-tools/insert",
+		[TC_INIT_MODULE_RETCODES] = "",
+	},
+	.modules_loaded = "mod-simple",
+	);
+
+static noreturn int kmod_tool_remove(const struct test *t)
+{
+	const char *progname = ABS_TOP_BUILDDIR "/tools/kmod";
+	const char *const args[] = {
+		progname,
+		"remove", "mod-simple",
+		NULL,
+	};
+
+	test_spawn_prog(progname, args);
+	exit(EXIT_FAILURE);
+}
+DEFINE_TEST(kmod_tool_remove,
+	.description = "check kmod remove",
+	.config = {
+		[TC_UNAME_R] = "4.4.4",
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-tools/remove",
+		[TC_DELETE_MODULE_RETCODES] = "",
+	},
+	);
+
+TESTSUITE_MAIN();
diff --git a/tools/insert.c b/tools/insert.c
new file mode 100644
index 0000000..0ebcef9
--- /dev/null
+++ b/tools/insert.c
@@ -0,0 +1,128 @@
+/*
+ * kmod-insert - insert a module into the kernel.
+ *
+ * Copyright (C) 2015 Intel Corporation. All rights reserved.
+ * Copyright (C) 2011-2013  ProFUSION embedded systems
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <errno.h>
+#include <getopt.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <libkmod/libkmod.h>
+
+#include "kmod.h"
+
+static const char cmdopts_s[] = "h";
+static const struct option cmdopts[] = {
+	{"help", no_argument, 0, 'h'},
+	{ }
+};
+
+static void help(void)
+{
+	printf("Usage:\n"
+	       "\t%s insert [options] module\n"
+	       "Options:\n"
+	       "\t-h, --help        show this help\n",
+	       program_invocation_short_name);
+}
+
+static const char *mod_strerror(int err)
+{
+	switch (err) {
+	case KMOD_PROBE_APPLY_BLACKLIST:
+		return "Module is blacklisted";
+	case -EEXIST:
+		return "Module already in kernel";
+	case -ENOENT:
+		return "Unknown symbol in module or unknown parameter (see dmesg)";
+	default:
+		return strerror(-err);
+	}
+}
+
+static int do_insert(int argc, char *argv[])
+{
+	struct kmod_ctx *ctx;
+	struct kmod_list *list = NULL, *l;
+	const char *name;
+	int err, r = EXIT_SUCCESS;
+
+	for (;;) {
+		int c, idx = 0;
+		c = getopt_long(argc, argv, cmdopts_s, cmdopts, &idx);
+		if (c == -1)
+			break;
+		switch (c) {
+		case 'h':
+			help();
+			return EXIT_SUCCESS;
+		default:
+			ERR("Unexpected getopt_long() value '%c'.\n", c);
+			return EXIT_FAILURE;
+		}
+	}
+
+	if (optind >= argc) {
+		ERR("Missing module name\n");
+		return EXIT_FAILURE;
+	}
+
+	ctx = kmod_new(NULL, NULL);
+	if (!ctx) {
+		ERR("kmod_new() failed!\n");
+		return EXIT_FAILURE;
+	}
+
+	name = argv[optind];
+	err = kmod_module_new_from_lookup(ctx, name, &list);
+	if (err < 0) {
+		ERR("Could not lookup module matching '%s': %s\n", name, strerror(-err));
+		r = EXIT_FAILURE;
+		goto end;
+	}
+
+	if (list == NULL) {
+		ERR("No module matches '%s'\n", name);
+		r = EXIT_FAILURE;
+		goto end;
+	}
+
+	kmod_list_foreach(l, list) {
+		struct kmod_module *mod = kmod_module_get_module(l);
+
+		err = kmod_module_probe_insert_module(mod, KMOD_PROBE_APPLY_BLACKLIST, NULL, NULL, NULL, NULL);
+		if (err != 0) {
+			r = EXIT_FAILURE;
+			ERR("Could not insert '%s': %s\n", kmod_module_get_name(mod), mod_strerror(err));
+		}
+
+		kmod_module_unref(mod);
+	}
+
+	kmod_module_unref_list(list);
+end:
+	kmod_unref(ctx);
+	return r;
+}
+
+const struct kmod_cmd kmod_cmd_insert = {
+	.name = "insert",
+	.cmd = do_insert,
+	.help = "insert a module into the kernel",
+};
diff --git a/tools/kmod.c b/tools/kmod.c
index 8ae1d86..5ebe70a 100644
--- a/tools/kmod.c
+++ b/tools/kmod.c
@@ -40,7 +40,9 @@ static const struct kmod_cmd kmod_cmd_help;
 
 static const struct kmod_cmd *kmod_cmds[] = {
 	&kmod_cmd_help,
+	&kmod_cmd_insert,
 	&kmod_cmd_list,
+	&kmod_cmd_remove,
 	&kmod_cmd_static_nodes,
 };
 
diff --git a/tools/kmod.h b/tools/kmod.h
index 50adda4..1770786 100644
--- a/tools/kmod.h
+++ b/tools/kmod.h
@@ -34,7 +34,9 @@ extern const struct kmod_cmd kmod_cmd_compat_modinfo;
 extern const struct kmod_cmd kmod_cmd_compat_modprobe;
 extern const struct kmod_cmd kmod_cmd_compat_depmod;
 
+extern const struct kmod_cmd kmod_cmd_insert;
 extern const struct kmod_cmd kmod_cmd_list;
 extern const struct kmod_cmd kmod_cmd_static_nodes;
+extern const struct kmod_cmd kmod_cmd_remove;
 
 #include "log.h"
diff --git a/tools/remove.c b/tools/remove.c
new file mode 100644
index 0000000..07e2cc0
--- /dev/null
+++ b/tools/remove.c
@@ -0,0 +1,150 @@
+/*
+ * kmod-remove - remove modules from the kernel.
+ *
+ * Copyright (C) 2015 Intel Corporation. All rights reserved.
+ * Copyright (C) 2011-2013  ProFUSION embedded systems
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <errno.h>
+#include <getopt.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <libkmod/libkmod.h>
+
+#include "kmod.h"
+
+static const char cmdopts_s[] = "h";
+static const struct option cmdopts[] = {
+	{"help", no_argument, 0, 'h'},
+	{ }
+};
+
+static void help(void)
+{
+	printf("Usage:\n"
+	       "\t%s remove [options] module\n"
+	       "Options:\n"
+	       "\t-h, --help        show this help\n",
+	       program_invocation_short_name);
+}
+
+static int check_module_inuse(struct kmod_module *mod) {
+	struct kmod_list *holders;
+	int state;
+
+	state = kmod_module_get_initstate(mod);
+
+	if (state == KMOD_MODULE_BUILTIN) {
+		ERR("Module %s is builtin.\n", kmod_module_get_name(mod));
+		return -ENOENT;
+	} else if (state < 0) {
+		ERR("Module %s is not currently loaded\n",
+				kmod_module_get_name(mod));
+		return -ENOENT;
+	}
+
+	holders = kmod_module_get_holders(mod);
+	if (holders != NULL) {
+		struct kmod_list *itr;
+
+		ERR("Module %s is in use by:", kmod_module_get_name(mod));
+
+		kmod_list_foreach(itr, holders) {
+			struct kmod_module *hm = kmod_module_get_module(itr);
+			fprintf(stderr, " %s", kmod_module_get_name(hm));
+			kmod_module_unref(hm);
+		}
+		fputc('\n', stderr);
+
+		kmod_module_unref_list(holders);
+		return -EBUSY;
+	}
+
+	if (kmod_module_get_refcnt(mod) != 0) {
+		ERR("Module %s is in use\n", kmod_module_get_name(mod));
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int do_remove(int argc, char *argv[])
+{
+	struct kmod_ctx *ctx;
+	struct kmod_module *mod;
+	const char *name;
+	int err, r = EXIT_SUCCESS;
+
+	for (;;) {
+		int c, idx =0;
+		c = getopt_long(argc, argv, cmdopts_s, cmdopts, &idx);
+		if (c == -1)
+			break;
+		switch (c) {
+		case 'h':
+			help();
+			return EXIT_SUCCESS;
+
+		default:
+			ERR("Unexpected getopt_long() value '%c'.\n", c);
+			return EXIT_FAILURE;
+		}
+	}
+
+	if (optind >= argc) {
+		ERR("Missing module name\n");
+		return EXIT_FAILURE;
+	}
+
+	ctx = kmod_new(NULL, NULL);
+	if (!ctx) {
+		ERR("kmod_new() failed!\n");
+		return EXIT_FAILURE;
+	}
+
+	name = argv[optind];
+	err = kmod_module_new_from_name(ctx, name, &mod);
+	if (err < 0) {
+		ERR("Could not remove module %s: %s\n", name, strerror(-err));
+		goto end;
+	}
+
+	err = check_module_inuse(mod);
+	if (err < 0)
+		goto unref;
+
+	err = kmod_module_remove_module(mod, 0);
+	if (err < 0)
+		goto unref;
+
+unref:
+	kmod_module_unref(mod);
+
+end:
+	kmod_unref(ctx);
+	if (err < 0) {
+		r = EXIT_FAILURE;
+		ERR("Could not remove module %s: %s\n", name, strerror(-err));
+	}
+	return r;
+}
+
+const struct kmod_cmd kmod_cmd_remove = {
+	.name = "remove",
+	.cmd = do_remove,
+	.help = "remove module from kernel",
+};
-- 
2.3.0

