Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: [PATCHv2 4/4] testsuite: add tests for external directory support
Date: Tue,  9 May 2017 22:09:24 +0300
Message-Id: <20170509190924.9087-5-yauheni.kaliuta@redhat.com>
In-Reply-To: <20170509190924.9087-1-yauheni.kaliuta@redhat.com>
References: <CAKi4VALJgW=RbpCT4kfix9sACzzz68=LZ-FhUUORXxHMcTA__g@mail.gmail.com>
 <20170509190924.9087-1-yauheni.kaliuta@redhat.com>
List-ID: <linux-modules.vger.kernel.org>

The following tests added:

- depmod_search_order_external_first -- checks if external module
  is taken in use when it has higher priority;
- depmod_search_order_external_last -- checks if external module
  is skipped when it has lower priority;
- test_modinfo_external -- checks if modinfo is able to look up
  correct external module;
- modprobe_external -- checks if modprobe is able to look up
  correct external module and loads it.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 testsuite/populate-modules.sh                      |   8 ++++
 .../etc/depmod.d/external.conf                     |   1 +
 .../etc/depmod.d/search.conf                       |   1 +
 .../lib/modules/4.4.4/correct-modules.dep          |   1 +
 .../etc/depmod.d/external.conf                     |   1 +
 .../etc/depmod.d/search.conf                       |   1 +
 .../lib/modules/4.4.4/correct-modules.dep          |   1 +
 .../test-modinfo/correct-external.txt              |   1 +
 .../external/lib/modules/4.4.4/modules.alias       |   1 +
 .../external/lib/modules/4.4.4/modules.alias.bin   | Bin 0 -> 12 bytes
 .../external/lib/modules/4.4.4/modules.builtin.bin |   0
 .../external/lib/modules/4.4.4/modules.dep         |   1 +
 .../external/lib/modules/4.4.4/modules.dep.bin     | Bin 0 -> 73 bytes
 .../external/lib/modules/4.4.4/modules.devname     |   0
 .../external/lib/modules/4.4.4/modules.softdep     |   1 +
 .../external/lib/modules/4.4.4/modules.symbols     |   1 +
 .../external/lib/modules/4.4.4/modules.symbols.bin | Bin 0 -> 12 bytes
 .../external/lib/modules/4.4.4/modules.alias       |   1 +
 .../external/lib/modules/4.4.4/modules.alias.bin   | Bin 0 -> 12 bytes
 .../external/lib/modules/4.4.4/modules.builtin.bin |   0
 .../external/lib/modules/4.4.4/modules.dep         |   1 +
 .../external/lib/modules/4.4.4/modules.dep.bin     | Bin 0 -> 73 bytes
 .../external/lib/modules/4.4.4/modules.devname     |   0
 .../external/lib/modules/4.4.4/modules.softdep     |   1 +
 .../external/lib/modules/4.4.4/modules.symbols     |   1 +
 .../external/lib/modules/4.4.4/modules.symbols.bin | Bin 0 -> 12 bytes
 .../test-modprobe/external/proc/modules            |   0
 testsuite/test-depmod.c                            |  52 +++++++++++++++++++++
 testsuite/test-modinfo.c                           |  21 +++++++++
 testsuite/test-modprobe.c                          |  22 +++++++++
 30 files changed, 118 insertions(+)
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-external-first/etc/depmod.d/external.conf
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-external-first/etc/depmod.d/search.conf
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-external-first/lib/modules/4.4.4/correct-modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-external-last/etc/depmod.d/external.conf
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-external-last/etc/depmod.d/search.conf
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-external-last/lib/modules/4.4.4/correct-modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/correct-external.txt
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.symbols.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.symbols.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/proc/modules

diff --git a/testsuite/populate-modules.sh b/testsuite/populate-modules.sh
index a7e503603b95..3ac92ee8030d 100755
--- a/testsuite/populate-modules.sh
+++ b/testsuite/populate-modules.sh
@@ -22,6 +22,12 @@ map=(
     ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-i.ko"]="mod-loop-i.ko"
     ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-j.ko"]="mod-loop-j.ko"
     ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-k.ko"]="mod-loop-k.ko"
+    ["test-depmod/search-order-external-first/lib/modules/4.4.4/foo/"]="mod-simple.ko"
+    ["test-depmod/search-order-external-first/lib/modules/4.4.4/foobar/"]="mod-simple.ko"
+    ["test-depmod/search-order-external-first/lib/modules/external/"]="mod-simple.ko"
+    ["test-depmod/search-order-external-last/lib/modules/4.4.4/foo/"]="mod-simple.ko"
+    ["test-depmod/search-order-external-last/lib/modules/4.4.4/foobar/"]="mod-simple.ko"
+    ["test-depmod/search-order-external-last/lib/modules/external/"]="mod-simple.ko"
     ["test-dependencies/lib/modules/4.0.20-kmod/kernel/fs/foo/"]="mod-foo-b.ko"
     ["test-dependencies/lib/modules/4.0.20-kmod/kernel/"]="mod-foo-c.ko"
     ["test-dependencies/lib/modules/4.0.20-kmod/kernel/lib/"]="mod-foo-a.ko"
@@ -40,6 +46,7 @@ map=(
     ["test-modprobe/oldkernel-force/lib/modules/3.3.3/kernel/"]="mod-simple.ko"
     ["test-modprobe/alias-to-none/lib/modules/4.4.4/kernel/"]="mod-simple.ko"
     ["test-modprobe/module-param-kcmdline/lib/modules/4.4.4/kernel/"]="mod-simple.ko"
+    ["test-modprobe/external/lib/modules/external/"]="mod-simple.ko"
     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/block/cciss.ko"]="mod-fake-cciss.ko"
     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/hpsa.ko"]="mod-fake-hpsa.ko"
     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/scsi_mod.ko"]="mod-fake-scsi-mod.ko"
@@ -48,6 +55,7 @@ map=(
     ["test-modinfo/mod-simple-sparc64.ko"]="mod-simple-sparc64.ko"
     ["test-modinfo/mod-simple-sha1.ko"]="mod-simple.ko"
     ["test-modinfo/mod-simple-sha256.ko"]="mod-simple.ko"
+    ["test-modinfo/external/lib/modules/external/mod-simple.ko"]="mod-simple.ko"
     ["test-tools/insert/lib/modules/4.4.4/kernel/"]="mod-simple.ko"
     ["test-tools/remove/lib/modules/4.4.4/kernel/"]="mod-simple.ko"
 )
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-external-first/etc/depmod.d/external.conf b/testsuite/rootfs-pristine/test-depmod/search-order-external-first/etc/depmod.d/external.conf
new file mode 100644
index 000000000000..59f46ae91d2d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-depmod/search-order-external-first/etc/depmod.d/external.conf
@@ -0,0 +1 @@
+external 4\.4\..* /lib/modules/external
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-external-first/etc/depmod.d/search.conf b/testsuite/rootfs-pristine/test-depmod/search-order-external-first/etc/depmod.d/search.conf
new file mode 100644
index 000000000000..642e497f5e63
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-depmod/search-order-external-first/etc/depmod.d/search.conf
@@ -0,0 +1 @@
+search external foobar foo built-in
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-external-first/lib/modules/4.4.4/correct-modules.dep b/testsuite/rootfs-pristine/test-depmod/search-order-external-first/lib/modules/4.4.4/correct-modules.dep
new file mode 100644
index 000000000000..e612900c5de7
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-depmod/search-order-external-first/lib/modules/4.4.4/correct-modules.dep
@@ -0,0 +1 @@
+/lib/modules/external/mod-simple.ko:
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-external-last/etc/depmod.d/external.conf b/testsuite/rootfs-pristine/test-depmod/search-order-external-last/etc/depmod.d/external.conf
new file mode 100644
index 000000000000..59f46ae91d2d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-depmod/search-order-external-last/etc/depmod.d/external.conf
@@ -0,0 +1 @@
+external 4\.4\..* /lib/modules/external
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-external-last/etc/depmod.d/search.conf b/testsuite/rootfs-pristine/test-depmod/search-order-external-last/etc/depmod.d/search.conf
new file mode 100644
index 000000000000..5fdb81236788
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-depmod/search-order-external-last/etc/depmod.d/search.conf
@@ -0,0 +1 @@
+search foobar foo built-in external
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-external-last/lib/modules/4.4.4/correct-modules.dep b/testsuite/rootfs-pristine/test-depmod/search-order-external-last/lib/modules/4.4.4/correct-modules.dep
new file mode 100644
index 000000000000..eab3bb05305d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-depmod/search-order-external-last/lib/modules/4.4.4/correct-modules.dep
@@ -0,0 +1 @@
+foobar/mod-simple.ko:
diff --git a/testsuite/rootfs-pristine/test-modinfo/correct-external.txt b/testsuite/rootfs-pristine/test-modinfo/correct-external.txt
new file mode 100644
index 000000000000..a094abec2650
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modinfo/correct-external.txt
@@ -0,0 +1 @@
+/lib/modules/external/mod-simple.ko
diff --git a/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.alias b/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.alias
new file mode 100644
index 000000000000..ba76e1815af0
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.alias
@@ -0,0 +1 @@
+# Aliases extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.alias.bin b/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.alias.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.builtin.bin b/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.builtin.bin
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.dep b/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.dep
new file mode 100644
index 000000000000..e612900c5de7
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.dep
@@ -0,0 +1 @@
+/lib/modules/external/mod-simple.ko:
diff --git a/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.dep.bin b/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.dep.bin
new file mode 100644
index 0000000000000000000000000000000000000000..556e3c8142d5d85dba5b557474907f9f9dd99dcb
GIT binary patch
literal 73
zcmdnM{w17&iGfjpfx$UHCB8T_w;(5#0SFjDgnmwDl74P}N@-4Nv3_brNorAEVh%_^
S7ot!vJKu^SH}?Po0}lY-ZWUAj

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.devname b/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.devname
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.softdep b/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.softdep
new file mode 100644
index 000000000000..5554ccca7f9e
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.softdep
@@ -0,0 +1 @@
+# Soft dependencies extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.symbols b/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.symbols
new file mode 100644
index 000000000000..618c345f7e93
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.symbols
@@ -0,0 +1 @@
+# Aliases for symbols, used by symbol_request().
diff --git a/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.symbols.bin b/testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.symbols.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.alias b/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.alias
new file mode 100644
index 000000000000..ba76e1815af0
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.alias
@@ -0,0 +1 @@
+# Aliases extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.alias.bin b/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.alias.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.builtin.bin b/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.builtin.bin
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.dep b/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.dep
new file mode 100644
index 000000000000..e612900c5de7
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.dep
@@ -0,0 +1 @@
+/lib/modules/external/mod-simple.ko:
diff --git a/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.dep.bin b/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.dep.bin
new file mode 100644
index 0000000000000000000000000000000000000000..556e3c8142d5d85dba5b557474907f9f9dd99dcb
GIT binary patch
literal 73
zcmdnM{w17&iGfjpfx$UHCB8T_w;(5#0SFjDgnmwDl74P}N@-4Nv3_brNorAEVh%_^
S7ot!vJKu^SH}?Po0}lY-ZWUAj

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.devname b/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.devname
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.softdep b/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.softdep
new file mode 100644
index 000000000000..5554ccca7f9e
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.softdep
@@ -0,0 +1 @@
+# Soft dependencies extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.symbols b/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.symbols
new file mode 100644
index 000000000000..618c345f7e93
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.symbols
@@ -0,0 +1 @@
+# Aliases for symbols, used by symbol_request().
diff --git a/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.symbols.bin b/testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.symbols.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-modprobe/external/proc/modules b/testsuite/rootfs-pristine/test-modprobe/external/proc/modules
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
index 732a9d0ad001..6530442ce002 100644
--- a/testsuite/test-depmod.c
+++ b/testsuite/test-depmod.c
@@ -131,4 +131,56 @@ DEFINE_TEST(depmod_detect_loop,
 		.err = DETECT_LOOP_ROOTFS "/correct.txt",
 	});
 
+#define SEARCH_ORDER_EXTERNAL_FIRST_ROOTFS TESTSUITE_ROOTFS "test-depmod/search-order-external-first"
+static noreturn int depmod_search_order_external_first(const struct test *t)
+{
+	const char *progname = ABS_TOP_BUILDDIR "/tools/depmod";
+	const char *const args[] = {
+		progname,
+		NULL,
+	};
+
+	test_spawn_prog(progname, args);
+	exit(EXIT_FAILURE);
+}
+DEFINE_TEST(depmod_search_order_external_first,
+	.description = "check if depmod honor external keyword with higher priority",
+	.config = {
+		[TC_UNAME_R] = "4.4.4",
+		[TC_ROOTFS] = SEARCH_ORDER_EXTERNAL_FIRST_ROOTFS,
+	},
+	.output = {
+		.files = (const struct keyval[]) {
+			{ SEARCH_ORDER_EXTERNAL_FIRST_ROOTFS "/lib/modules/4.4.4/correct-modules.dep",
+			  SEARCH_ORDER_EXTERNAL_FIRST_ROOTFS "/lib/modules/4.4.4/modules.dep" },
+			{ }
+		},
+	});
+
+#define SEARCH_ORDER_EXTERNAL_LAST_ROOTFS TESTSUITE_ROOTFS "test-depmod/search-order-external-last"
+static noreturn int depmod_search_order_external_last(const struct test *t)
+{
+	const char *progname = ABS_TOP_BUILDDIR "/tools/depmod";
+	const char *const args[] = {
+		progname,
+		NULL,
+	};
+
+	test_spawn_prog(progname, args);
+	exit(EXIT_FAILURE);
+}
+DEFINE_TEST(depmod_search_order_external_last,
+	.description = "check if depmod honor external keyword with lower priority",
+	.config = {
+		[TC_UNAME_R] = "4.4.4",
+		[TC_ROOTFS] = SEARCH_ORDER_EXTERNAL_LAST_ROOTFS,
+	},
+	.output = {
+		.files = (const struct keyval[]) {
+			{ SEARCH_ORDER_EXTERNAL_LAST_ROOTFS "/lib/modules/4.4.4/correct-modules.dep",
+			  SEARCH_ORDER_EXTERNAL_LAST_ROOTFS "/lib/modules/4.4.4/modules.dep" },
+			{ }
+		},
+	});
+
 TESTSUITE_MAIN();
diff --git a/testsuite/test-modinfo.c b/testsuite/test-modinfo.c
index 487750207d05..8fdfe35ef4e6 100644
--- a/testsuite/test-modinfo.c
+++ b/testsuite/test-modinfo.c
@@ -89,4 +89,25 @@ DEFINE_TEST(test_modinfo_signature,
 		.out = TESTSUITE_ROOTFS "test-modinfo/correct.txt",
 	});
 #endif
+
+static noreturn int test_modinfo_external(const struct test *t)
+{
+	const char *const args[] = {
+		progname, "-F", "filename",
+		"mod-simple",
+		NULL,
+	};
+	test_spawn_prog(progname, args);
+	exit(EXIT_FAILURE);
+}
+DEFINE_TEST(test_modinfo_external,
+	.description = "check if modinfo finds external module",
+	.config = {
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modinfo/external",
+		[TC_UNAME_R] = "4.4.4",
+	},
+	.output = {
+		.out = TESTSUITE_ROOTFS "test-modinfo/correct-external.txt",
+	})
+
 TESTSUITE_MAIN();
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index e0dd1992a784..ee9d82d487c7 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -371,4 +371,26 @@ DEFINE_TEST(modprobe_oldkernel_force,
 	.modules_loaded = "mod-simple",
 	);
 
+static noreturn int modprobe_external(const struct test *t)
+{
+	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
+	const char *const args[] = {
+		progname,
+		"mod-simple",
+		NULL,
+	};
+
+	test_spawn_prog(progname, args);
+	exit(EXIT_FAILURE);
+}
+DEFINE_TEST(modprobe_external,
+	.description = "check modprobe able to load external module",
+	.config = {
+		[TC_UNAME_R] = "4.4.4",
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/external",
+		[TC_INIT_MODULE_RETCODES] = "",
+	},
+	.modules_loaded = "mod-simple",
+	);
+
 TESTSUITE_MAIN();
-- 
2.12.2.639.g584f8975d2d9
