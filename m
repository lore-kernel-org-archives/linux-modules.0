Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: [RFC] resolve CRC test. Was: Re: [PATCH] libkmod-elf: resolve CRC if module is built with MODULE_REL_CRCS
References: <20170719145649.20334-1-yauheni.kaliuta@redhat.com>
	<CAKi4VA+oMMXajB7_xF2qraye9h7k-JqG5h9Fk7fv9xenW_nvcA@mail.gmail.com>
	<xunyh8y8qmdo.fsf@redhat.com>
Date: Wed, 09 Aug 2017 00:40:11 +0300
In-Reply-To: <xunyh8y8qmdo.fsf@redhat.com> (Yauheni Kaliuta's message of "Wed,
	19 Jul 2017 22:04:19 +0300")
Message-ID: <xunyfud1pwlg.fsf_-_@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

>>>>> On Wed, 19 Jul 2017 22:04:19 +0300, Yauheni Kaliuta  wrote:
>>>>> On Wed, 19 Jul 2017 10:51:44 -0700, Lucas De Marchi  wrote:

[...]

 >> Do you think it's possible to build an out-of-tree module with this
 >> option so we can add one to the testsuite?

 > I'll check what I can do.

Some ideas below. I reused the existing "foo" modules with their
dependencies. Possible problem is that it requires the host kernel to be
built with MODVERSIONS enabled (not the case for Fedora).

---
 testsuite/module-playground/Makefile               | 10 +++++++-
 testsuite/populate-modules.sh                      |  4 +++
 .../test-depmod/relocated-crc/boot/symvers         |  0
 .../lib/modules/4.4.4/correct-modules.dep          |  4 +++
 .../lib/modules/4.4.4/modules.builtin              |  0
 .../relocated-crc/lib/modules/4.4.4/modules.order  |  0
 .../test-depmod/relocated-crc/output.err           | 10 ++++++++
 testsuite/test-depmod.c                            | 30 ++++++++++++++++++++++
 8 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 testsuite/rootfs-pristine/test-depmod/relocated-crc/boot/symvers
 create mode 100644 testsuite/rootfs-pristine/test-depmod/relocated-crc/lib/modules/4.4.4/correct-modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-depmod/relocated-crc/lib/modules/4.4.4/modules.builtin
 create mode 100644 testsuite/rootfs-pristine/test-depmod/relocated-crc/lib/modules/4.4.4/modules.order
 create mode 100644 testsuite/rootfs-pristine/test-depmod/relocated-crc/output.err

diff --git a/testsuite/module-playground/Makefile b/testsuite/module-playground/Makefile
index e6045b0..f12f301 100644
--- a/testsuite/module-playground/Makefile
+++ b/testsuite/module-playground/Makefile
@@ -11,6 +11,10 @@ obj-m += mod-foo-b.o
 obj-m += mod-foo-c.o
 obj-m += mod-foo.o
 
+# predictable relocated/non-relocated symbols crc
+mod-foo-a-rel-y := mod-foo-a.o
+mod-foo-b-nonrel-y := mod-foo-b.o
+
 # mod-loop: create loops in dependencies:
 # 1) mod-loop-a  ->  mod-loop-b -> mod-loop-c -> mod-loop-a
 #     |-> mod-loop-f    |-> mod-loop-f
@@ -63,8 +67,12 @@ mod-simple-%.ko: mod-simple-%.c Makefile.arch
 	$(MAKE) KDIR=$(KDIR_$(arch)) ARCH=$(arch) CROSS_COMPILE=$(CROSS_COMPILE_$(arch)) -f Makefile.arch
 
 ifeq ($(FAKE_BUILD),0)
-modules:
+modules: rel-modules
 	$(MAKE) -C $(KDIR) M=$$PWD
+
+rel-modules:
+	$(MAKE) -C $(KDIR) M=$$PWD CONFIG_MODULE_REL_CRCS=y obj-m=mod-foo-a-rel.o
+	$(MAKE) -C $(KDIR) M=$$PWD CONFIG_MODULE_REL_CRCS=n obj-m=mod-foo-b-nonrel.o
 else
 modules:
 	@echo "  CP       cache/*.ko"
diff --git a/testsuite/populate-modules.sh b/testsuite/populate-modules.sh
index 3ac92ee..f6f71fa 100755
--- a/testsuite/populate-modules.sh
+++ b/testsuite/populate-modules.sh
@@ -28,6 +28,10 @@ map=(
     ["test-depmod/search-order-external-last/lib/modules/4.4.4/foo/"]="mod-simple.ko"
     ["test-depmod/search-order-external-last/lib/modules/4.4.4/foobar/"]="mod-simple.ko"
     ["test-depmod/search-order-external-last/lib/modules/external/"]="mod-simple.ko"
+    ["test-depmod/relocated-crc/lib/modules/4.4.4/kernel/mod-foo-a-rel.ko"]="mod-foo-a-rel.ko"
+    ["test-depmod/relocated-crc/lib/modules/4.4.4/kernel/mod-foo-b-nonrel.ko"]="mod-foo-b-nonrel.ko"
+    ["test-depmod/relocated-crc/lib/modules/4.4.4/kernel/mod-foo-c.ko"]="mod-foo-c.ko"
+    ["test-depmod/relocated-crc/lib/modules/4.4.4/kernel/mod-foo.ko"]="mod-foo.ko"
     ["test-dependencies/lib/modules/4.0.20-kmod/kernel/fs/foo/"]="mod-foo-b.ko"
     ["test-dependencies/lib/modules/4.0.20-kmod/kernel/"]="mod-foo-c.ko"
     ["test-dependencies/lib/modules/4.0.20-kmod/kernel/lib/"]="mod-foo-a.ko"
diff --git a/testsuite/rootfs-pristine/test-depmod/relocated-crc/boot/symvers b/testsuite/rootfs-pristine/test-depmod/relocated-crc/boot/symvers
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-depmod/relocated-crc/lib/modules/4.4.4/correct-modules.dep b/testsuite/rootfs-pristine/test-depmod/relocated-crc/lib/modules/4.4.4/correct-modules.dep
new file mode 100644
index 0000000..303060c
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-depmod/relocated-crc/lib/modules/4.4.4/correct-modules.dep
@@ -0,0 +1,4 @@
+kernel/mod-foo-c.ko:
+kernel/mod-foo-b-nonrel.ko:
+kernel/mod-foo.ko: kernel/mod-foo-b-nonrel.ko kernel/mod-foo-a-rel.ko kernel/mod-foo-c.ko
+kernel/mod-foo-a-rel.ko:
diff --git a/testsuite/rootfs-pristine/test-depmod/relocated-crc/lib/modules/4.4.4/modules.builtin b/testsuite/rootfs-pristine/test-depmod/relocated-crc/lib/modules/4.4.4/modules.builtin
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-depmod/relocated-crc/lib/modules/4.4.4/modules.order b/testsuite/rootfs-pristine/test-depmod/relocated-crc/lib/modules/4.4.4/modules.order
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-depmod/relocated-crc/output.err b/testsuite/rootfs-pristine/test-depmod/relocated-crc/output.err
new file mode 100644
index 0000000..d7e4fb0
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-depmod/relocated-crc/output.err
@@ -0,0 +1,10 @@
+depmod: WARNING: /lib/modules/4.4.4/kernel/mod-foo-c.ko needs unknown symbol __fentry__
+depmod: WARNING: /lib/modules/4.4.4/kernel/mod-foo-c.ko needs unknown symbol printk
+depmod: WARNING: /lib/modules/4.4.4/kernel/mod-foo-c.ko needs unknown symbol module_layout
+depmod: WARNING: /lib/modules/4.4.4/kernel/mod-foo-b-nonrel.ko needs unknown symbol __fentry__
+depmod: WARNING: /lib/modules/4.4.4/kernel/mod-foo-b-nonrel.ko needs unknown symbol printk
+depmod: WARNING: /lib/modules/4.4.4/kernel/mod-foo-b-nonrel.ko needs unknown symbol module_layout
+depmod: WARNING: /lib/modules/4.4.4/kernel/mod-foo.ko needs unknown symbol module_layout
+depmod: WARNING: /lib/modules/4.4.4/kernel/mod-foo-a-rel.ko needs unknown symbol __fentry__
+depmod: WARNING: /lib/modules/4.4.4/kernel/mod-foo-a-rel.ko needs unknown symbol printk
+depmod: WARNING: /lib/modules/4.4.4/kernel/mod-foo-a-rel.ko needs unknown symbol module_layout
diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
index e249c61..a4c8ed7 100644
--- a/testsuite/test-depmod.c
+++ b/testsuite/test-depmod.c
@@ -183,4 +183,34 @@ DEFINE_TEST(depmod_search_order_external_last,
 		},
 	});
 
+#define RELOCATED_CRC_ROOTFS TESTSUITE_ROOTFS "test-depmod/relocated-crc"
+static noreturn int relocated_crc(const struct test *t)
+{
+	const char *progname = ABS_TOP_BUILDDIR "/tools/depmod";
+	const char *const args[] = {
+		progname,
+		"-aeE",
+		"/boot/symvers",
+		NULL,
+	};
+
+	test_spawn_prog(progname, args);
+	exit(EXIT_FAILURE);
+}
+DEFINE_TEST(relocated_crc,
+	.description = "check if depmod understand both relocated and non-relocated crcs",
+	.print_outputs = true,
+	.config = {
+		[TC_UNAME_R] = "4.4.4",
+		[TC_ROOTFS] = RELOCATED_CRC_ROOTFS,
+	},
+	.output = {
+	        .err = RELOCATED_CRC_ROOTFS "/output.err",
+		.files = (const struct keyval[]) {
+			{ RELOCATED_CRC_ROOTFS "/lib/modules/4.4.4/correct-modules.dep",
+			  RELOCATED_CRC_ROOTFS "/lib/modules/4.4.4/modules.dep" },
+			{ }
+		},
+	});
+
 TESTSUITE_MAIN();
-- 
2.13.3





-- 
WBR,
Yauheni Kaliuta
